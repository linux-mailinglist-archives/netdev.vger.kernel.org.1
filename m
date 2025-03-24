Return-Path: <netdev+bounces-177170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C1A6E242
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4589E188DD63
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E684264A74;
	Mon, 24 Mar 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xi3wp2Fw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF8263F59
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840795; cv=none; b=ENIbCLbr+/0aDe7MziMmFJKnxD0VGhaWfnURukUX8ZJFr/MMSKiTRPBtNS5ynRYTT1PMKwF9IjSN377MkjSFbJrhLQYgEYfcJpLwf8StaVzLc6SqnDASJx6WZx19paxLu7sMEX2aDpaZjasnmJSDNSBsyQNn5t3GKucz5UHKd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840795; c=relaxed/simple;
	bh=sgxob3PFAPhjAH5p7mwcZ4U4FELSoCR+TXLS7js9IXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJZ+kOFuoFz/gUhZr5NBgc/dhnSxRb+fVHngC3Z/f3fPYhn9OK/bae9fQEnOB039hLBYsGoa7mDcySU/HYtJUjSV+dVB9bGOMDFQDDlImKcNRmbLbaP343rEXYPSzMyt7JnAiawOS7nP84r6PL7g0X0bvjRbQPFTcJiltoo5n9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Xi3wp2Fw; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742840794; x=1774376794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+MlLshkUAnl5AL1tVgvSJvh9OhyxNCptRapEC4hVo4=;
  b=Xi3wp2FwGljpIGXSsUIlX2JtUarGEeqxt5fje4Ms9e7DL1ABgbh0Y7r6
   +g660owHXQvqWUQaUpwu9dDM1o1iGxf4LTNgyDtyMtMJGKaOHGfwx/3UO
   h41gh94aMLPsUoGqq7XAbT6QPTRjGrFkq5zpxixkwrwzcHeaI/hap8xlv
   E=;
X-IronPort-AV: E=Sophos;i="6.14,272,1736812800"; 
   d="scan'208";a="810140830"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 18:26:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:9191]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.40:2525] with esmtp (Farcaster)
 id b4aeecf6-bfbf-4ed5-9a6d-6902fdcbc565; Mon, 24 Mar 2025 18:26:14 +0000 (UTC)
X-Farcaster-Flow-ID: b4aeecf6-bfbf-4ed5-9a6d-6902fdcbc565
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 18:26:13 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 18:26:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 3/3] selftest: net: Check wraparounds for sk->sk_rmem_alloc.
Date: Mon, 24 Mar 2025 11:25:20 -0700
Message-ID: <20250324182602.47871-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67e1810e3b460_2f662329482@willemb.c.googlers.com.notmuch>
References: <67e1810e3b460_2f662329482@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 24 Mar 2025 11:58:06 -0400
> > +TEST_F(so_rcvbuf, rmem_max)
> > +{
> > +	char buf[16] = {};
> > +	int ret, i;
> > +
> > +	create_socketpair(_metadata, self, variant);
> > +
> > +	ret = setsockopt(self->server, SOL_SOCKET, SO_RCVBUFFORCE,
> > +			 &(int){INT_MAX}, sizeof(int));
> > +	ASSERT_EQ(ret, 0);
> > +
> > +	ASSERT_EQ(get_prot_pages(_metadata, variant), 0);
> > +
> > +	for (i = 1; ; i++) {
> > +		ret = send(self->client, buf, sizeof(buf), 0);
> > +		ASSERT_EQ(ret, sizeof(buf));
> > +
> > +		if (i % 10000 == 0) {
> > +			int pages = get_prot_pages(_metadata, variant);
> > +
> > +			/* sk_rmem_alloc wrapped around too much ? */
> > +			ASSERT_LE(pages, *variant->max_pages);
> > +
> > +			if (pages == *variant->max_pages)
> > +				break;
> 
> Does correctness depend here on max_pages being a multiple of 10K?

10K may be too conservative, but at least we need to ensure
that the size of accumulated skbs exceeds 1 PAGE_SIZE to
fail on the ASSERT_LE(), otherwise we can't detect the multiple
wraparounds even without patch 1.

The later sleep for call_rcu() was dominant than this loop on
my machine.

Thanks!

