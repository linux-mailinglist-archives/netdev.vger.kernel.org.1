Return-Path: <netdev+bounces-134743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E299AF78
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599B31F2311D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC221E3786;
	Fri, 11 Oct 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bfuMHHKT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E651D2F55
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690079; cv=none; b=L/cZY45DqwqiZ/sMSo7Crhb4MRiJX0ck0sZOVP0SJumhXsBnNDz5ZclqDJvDrjJJ8c8wvUHHBj7obYU24V4v6wJ7IdfpW1eAR3K7UkhdqW6pnDwm9ZkSAElWR54rcESM7eL4j+WYFUnvw+SoqTDqoqy1fVZYY8YeGwCXn92ib2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690079; c=relaxed/simple;
	bh=e5wcewnaxtf90knQgqofVi3NP1IGrdMt9bYsefLK9L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQkvbK8lEFekoIiIg6z/fM342hsBsp7ACRdBh87jHUd5S4aB6HgJvVIvsYJ8Y7Wb9b4/RPOPmlWDPVidY01yMp2+W3A+o3ftqOHPIr1F1LBNPuM3ZZPCY7uhH97twMWh/EnyxYxivrZZecxFV1Zn6AFax2+MYg4TGMrtSe2FHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bfuMHHKT; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728690078; x=1760226078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YXWUBK5GWc8qovSq7tSBtTtdp9w7ZG6c8EeBrmC5WWg=;
  b=bfuMHHKTB00ibm3jQB8hnHOl3QtxZbfdH4YFX3nz3K9qpiok6HLoAkJj
   ArIQR/B6jyIUaXYgPfXwxEA3CW4H7rDOevDWh88nFbtJLYBkUSNExt0Dk
   RAs8LQeHHG2eEuqZEOIlfh+iUjbBTpiG802UUNwnfBo22/XRy3tGoCSFv
   w=;
X-IronPort-AV: E=Sophos;i="6.11,197,1725321600"; 
   d="scan'208";a="238716297"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 23:41:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:2959]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 974a1419-c61e-4089-94f1-6dd13acc1179; Fri, 11 Oct 2024 23:41:14 +0000 (UTC)
X-Farcaster-Flow-ID: 974a1419-c61e-4089-94f1-6dd13acc1179
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 23:41:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 23:41:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <brianvv@google.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 5/5] ipv4: tcp: give socket pointer to control skbs
Date: Fri, 11 Oct 2024 16:41:05 -0700
Message-ID: <20241011234105.54116-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241010174817.1543642-6-edumazet@google.com>
References: <20241010174817.1543642-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 17:48:17 +0000
> ip_send_unicast_reply() send orphaned 'control packets'.
> 
> These are RST packets and also ACK packets sent from TIME_WAIT.
> 
> Some eBPF programs would prefer to have a meaningful skb->sk
> pointer as much as possible.
> 
> This means that TCP can now attach TIME_WAIT sockets to outgoing
> skbs.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

