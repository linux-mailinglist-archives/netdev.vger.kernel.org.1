Return-Path: <netdev+bounces-162226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19ADA2642E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C2A7A2CD5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6971C150980;
	Mon,  3 Feb 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pUDkNLaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D3522A
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612877; cv=none; b=ka2Mfw2+fnyyDrbbjbXQtLutEYkld/Ibq5pUEABOl9U5zBmpGzqxBvRzd0pMjbNR3t1e8Evwj0p14T7lBegKFQujVTFyiNTpqSURpXPBYaXyiOimPH7U2RI0Pu9Y8kQDgmau6d/ZuNJYWYAtZXYbguD1x1jsghPt1LxDVYoQdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612877; c=relaxed/simple;
	bh=vFqoder34BNSoYS9d3W9VoijwcDBKUPC6iSfUkqXhjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdeBy6gBQwxsYe5pNtONZMONxafWNuCbqLRF0cJUlxmLF+JcBrfSntD00euvFudqyXyvXs63DHxXSzVCO8gjvsLTL356nIqQYsA+sWaVze5nSrLkLeUrignH29cpeg6SseH6hD7ib5ebIoWyJipDifsvhf7KVAJXdwsEROvr8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pUDkNLaZ; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738612876; x=1770148876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/OS/rO6nDxwkqL/VY/Y5C6ulrraKeRpwB3HfCtML74=;
  b=pUDkNLaZdiERENaEMKn7W92tw934Q4hfIf7BAfJ4AIzw33TysE7ZgjXd
   zVhRDKrbO9b5V/S2VKoc6pECIU6mPhIyOkTK443lP7VCJf7p13h4VQD0+
   7wEOscRKONMwz6RFMt0n4dxx9bMh8zx/QsJsDgfecCCxWFBbzihWHSE5f
   I=;
X-IronPort-AV: E=Sophos;i="6.13,256,1732579200"; 
   d="scan'208";a="715706127"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:01:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:25508]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.236:2525] with esmtp (Farcaster)
 id bf5abf61-2d7c-47f3-b656-5a20eb0cc5ce; Mon, 3 Feb 2025 20:01:10 +0000 (UTC)
X-Farcaster-Flow-ID: bf5abf61-2d7c-47f3-b656-5a20eb0cc5ce
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 3 Feb 2025 20:01:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.5.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 3 Feb 2025 20:01:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH net 0/3] MAINTAINERS: recognize Kuniyuki Iwashima as a maintainer
Date: Tue, 4 Feb 2025 05:00:49 +0900
Message-ID: <20250203200049.49670-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250202014728.1005003-1-kuba@kernel.org>
References: <20250202014728.1005003-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Sat,  1 Feb 2025 17:47:25 -0800
> Kuniyuki Iwashima has been a prolific contributor and trusted reviewer
> for some core portions of the networking stack for a couple of years now.
> Formalize some obvious areas of his expertise and list him as a maintainer.
> 
> Jakub Kicinski (3):
>   MAINTAINERS: add Kuniyuki Iwashima to TCP reviewers
>   MAINTAINERS: add a general entry for BSD sockets
>   MAINTAINERS: add entry for UNIX sockets

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thank you so much !!!

