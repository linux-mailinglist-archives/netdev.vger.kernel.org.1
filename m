Return-Path: <netdev+bounces-134738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5853399AF4A
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A5E285161
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240111E5732;
	Fri, 11 Oct 2024 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jkhapWtq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522E1E5727
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688864; cv=none; b=ut+dSducMR5OPBHyls0nZKC+6uZWaqxcQlOSsbvMINY3frOmfdyIUYPMFBJDZniPNTyfG+b2IPjYtNsCy7k68MSDzSPcqmNW7P6iEK87gvXNIacAd6Cdju5ZK94qFE6KWuDIMhjkGKAzy8I7c2Db61mjHU3dDuYGrtDDu0TOANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688864; c=relaxed/simple;
	bh=ETTBvmJvJosLgjOqYtLjlkSy1qEnDhL+4DASSIp7gy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZet3dkyfoiLAs+YcabyiIrQ15JbELiHdYnVLZEcyJhvdQZaLDF3hWJH4EXVpeHDPBSuimA92c5E1FPEL0aa9q29T5czq5N26blpmL09peL+oSdnrdmTxKvyxuqVpDfcHjwaKaGCvpMELPcdXuv3c3cWMQmjr8QA5/x/sHbu1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jkhapWtq; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728688862; x=1760224862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kiDS+SclADOz0xR5hw28yXkZutIrQrTNypM5SU+w010=;
  b=jkhapWtqMwQURu6Jxx+MEPx+/dDm7bYIPD+l0SY/sWesYc1/8JyBmiC1
   6Q6eT+4zAu2BVnZokDuq0OK7mCCCJYmJ2tJoBWY1giEMt+EG9R4isGW0v
   YXdvPD2ezmVMURIwXhSrKSvOdauUDBZ9BWwlD13GPvfYLrbBgcA+SIXOx
   4=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="687003244"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 23:20:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:44552]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id fa7f85d3-a734-478f-b3ee-352c2d887553; Fri, 11 Oct 2024 23:20:58 +0000 (UTC)
X-Farcaster-Flow-ID: fa7f85d3-a734-478f-b3ee-352c2d887553
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 23:20:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 23:20:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <brianvv@google.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
Date: Fri, 11 Oct 2024 16:20:50 -0700
Message-ID: <20241011232050.52157-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241010174817.1543642-2-edumazet@google.com>
References: <20241010174817.1543642-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 17:48:13 +0000
> TCP will soon attach TIME_WAIT sockets to some ACK and RST.
> 
> Make sure sk_to_full_sk() detects this and does not return
> a non full socket.
> 
> v3: also changed sk_const_to_full_sk()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

