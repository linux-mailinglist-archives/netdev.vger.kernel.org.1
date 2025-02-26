Return-Path: <netdev+bounces-170018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B7A46D5E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8A73A2404
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916E321ABB4;
	Wed, 26 Feb 2025 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tzIefyib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0C21884A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605123; cv=none; b=f71YpiXDEZzD+/3annvmHYpVN12jZog7aGkU4FvAfwAkVF4epzM9rQxrWyX0vFxfsjJLHIXectWehK2M7tAdstmlfRzfXOwIn8aAJJkomKf6rFlxdSBt/4S2OPB+ixteL533INZcgXnX25vBE7lmd17A+46JgbMyvk9VNubaBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605123; c=relaxed/simple;
	bh=ZqozZ7yikwsLwwqPCXrxoI3e5hGiagZta4POPpletsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msOwL0L6sQPOuKS1mCvlIXTBYZvjkdafz267eQV+ipazCpGB1c41Bi5DG2VnY0IT8GuDZRsDrNeylIJgs13XuNFhr8TzfdiukapDRwfWbMYq6RQCz/HJULM2zSqUnof/tdAxYRjLrAEHqsmag/XfP6GmvuBxU+pDvIvbw1O9Yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tzIefyib; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740605121; x=1772141121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bGEGcn2FYkJDt/EFXSFkNrjLbc4UXXia+HqmAk544g=;
  b=tzIefyibNokZctdmp9WF9xChzVMaUw+bTDnHhtdZlvAqZ358y20688y3
   AJ0F8Thn9XRxMNDhD8bMkkb0W1stmj1Y3BKWupgxETDezAoX7PwhgxkZS
   eUFiPRNNar8sbKGqQoOjbbJGJZhW5fkTRmIXneESew22ybZ/D8KFEV8LI
   4=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="475606647"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:25:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:48581]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.186:2525] with esmtp (Farcaster)
 id 07044637-c0f4-4ed3-bf55-d3ac73571f32; Wed, 26 Feb 2025 21:25:16 +0000 (UTC)
X-Farcaster-Flow-ID: 07044637-c0f4-4ed3-bf55-d3ac73571f32
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 21:25:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 21:25:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.dichtel@6wind.com>
CC: <aleksander.lobakin@intel.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <idosch@idosch.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 1/3] net: rename netns_local to netns_immutable
Date: Wed, 26 Feb 2025 13:25:04 -0800
Message-ID: <20250226212504.37165-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226093232.644814-2-nicolas.dichtel@6wind.com>
References: <20250226093232.644814-2-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Wed, 26 Feb 2025 10:31:56 +0100
> The name 'netns_local' is confusing. A following commit will export it via
> netlink, so let's use a more explicit name.
> 
> Reported-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Confirmed allmodconfig passed.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

