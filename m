Return-Path: <netdev+bounces-146901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FBA9D6A81
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 18:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BDDB21A2E
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C8182C5;
	Sat, 23 Nov 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xo/Ip2T7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F62225D7
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382326; cv=none; b=mvVVZMA3DM+ByncfJMtbl6VoanNrj9xw9/Z7KrcsoOL8253uTwoiHCDoq5fuXma9O/uND7yA1lLFtMGn+fsosKByGMIFSzGY3Q1GxEVlyZbiXw1ARKxRCOiAxhsoAUWPvPSzuJlTBoQCiTqh+0AuR23dDuNPklDYMIcipVuViEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382326; c=relaxed/simple;
	bh=a7coqXKEp4gZIJ/4RbpjfQ/mEiKwAS2LRkdPo9LqSs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgZroMtFn5pLxr2K62S99No8tEoR073YWPeOad4+bi43TpV5myr0YNtLoDBnyPl/lkMckcPrsg/3uMyEM52MKNMPJUY8z8SDpeapfhXE9IN49vxT/pNZSibyX5bTWeHB+Q1P0l1IaNTTfCRYKFh+Re2YPUDwXWaTrmdfMcYvbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Xo/Ip2T7; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732382324; x=1763918324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FQ52FcY4xppjwiAqCPeBl/5ban1jkWWEcoCySoIHxxs=;
  b=Xo/Ip2T7TU3qhu8OGnktIIudhqUL+Ahe4LGk1fRyw060LL0y0ZgSbg5L
   qll9w2LGUXnY3hOSnxzstl7wzKevzeAaqqp9VvqAvES25D20OjqZSTaka
   fYduhfZoIjziprRFZd/ewszOniQEUv+nkPHnWMAtJUkRO0Fa4S5e/mXAH
   k=;
X-IronPort-AV: E=Sophos;i="6.12,179,1728950400"; 
   d="scan'208";a="249564370"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 17:18:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:46710]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.41:2525] with esmtp (Farcaster)
 id 9192299d-72df-47f8-9c4a-f2f2133393ad; Sat, 23 Nov 2024 17:18:40 +0000 (UTC)
X-Farcaster-Flow-ID: 9192299d-72df-47f8-9c4a-f2f2133393ad
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 23 Nov 2024 17:18:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 23 Nov 2024 17:18:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <liujian56@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Sat, 23 Nov 2024 09:18:34 -0800
Message-ID: <20241123171834.59708-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <1284490f-9525-42ee-b7b8-ccadf6606f6d@huawei.com>
References: <1284490f-9525-42ee-b7b8-ccadf6606f6d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "liujian (CE)" <liujian56@huawei.com>
Date: Sat, 23 Nov 2024 21:24:39 +0800
> > @@ -1178,7 +1188,8 @@ static void reqsk_timer_handler(struct timer_list *t)
> >   	}
> >   
> >   drop:
> > -	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
> > +	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> > +	reqsk_put(req);
> Excuse me, why is "req" used here instead of "oreq"?
> Typo?

Oops, will post a followup.

Thanks!

