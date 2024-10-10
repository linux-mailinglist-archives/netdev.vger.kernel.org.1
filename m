Return-Path: <netdev+bounces-134334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F45998DDB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40ED6B234A0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6FD1CDA23;
	Thu, 10 Oct 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s49fncDV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316257DA62
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577216; cv=none; b=PCHskMflpdCLqDElk/1eUvDsgfB+Yf9ggPBiNqCkI/b2HVpCkXKxoljMRKQnrjG9x1lqJpkrPiEgF3opOD3Ukyu+D8fEXU8S0GB1SEmywfuO5Kx+yM4GSMVzAfhjb9jfp8MzE+4l7Q0378YLbNKlTN8XIybZDCZTBiAaN1PnggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577216; c=relaxed/simple;
	bh=7L6FMSJ/RYFmrxA46zQ897HYLyi7D0YRYMb0P0XFpjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmtHBUT7VQasSisu8wByygeJ9vt+8Zupx8jslq6iyZ72b1nAl8dIRR+fHkPxeoV1eyICUZuYFXI57kM4rzhRhKq8dlthLy0xzI6qOvevj/3+Qz162c6u2uGBv2ZqzMIxB74dniqH/FAVgDIUtFT1Dbw/sDf+qQxo+Pd7xuSm9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s49fncDV; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728577215; x=1760113215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OLxrv8N9otMsreYXtj/0lBP406Ue0wGSc/SI+c/ae+k=;
  b=s49fncDVJnsi+tpEKITzf4avjMMi6LqQLeVgY8e2/HdAbYT/74k29EOr
   LZujxbkccqXiLKzPNkmY8S7EbOoCQuB2UYn1E4oKEWMBCFOI/Uv6q74gj
   iuddKbXwTtmgDGbTy7ReEgP50axVU44d6BSAU5ARILPMwkiMuD8A0ZY+3
   w=;
X-IronPort-AV: E=Sophos;i="6.11,193,1725321600"; 
   d="scan'208";a="136941826"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 16:20:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:64996]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id 807dbd3a-1fa5-416a-bc21-3f7f70016080; Thu, 10 Oct 2024 16:20:12 +0000 (UTC)
X-Farcaster-Flow-ID: 807dbd3a-1fa5-416a-bc21-3f7f70016080
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 16:20:11 +0000
Received: from 6c7e67c6786f.amazon.com (10.88.181.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 10 Oct 2024 16:20:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 07/13] rtnetlink: Protect struct rtnl_link_ops with SRCU.
Date: Thu, 10 Oct 2024 09:20:06 -0700
Message-ID: <20241010162006.60635-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iJU=JcaKqfdARq9aNC+QMoG8B-RjfgqfufYvA_74v6TsA@mail.gmail.com>
References: <CANn89iJU=JcaKqfdARq9aNC+QMoG8B-RjfgqfufYvA_74v6TsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:02:39 +0200
> > @@ -490,7 +511,9 @@ int __rtnl_link_register(struct rtnl_link_ops *ops)
> >         if ((ops->alloc || ops->setup) && !ops->dellink)
> >                 ops->dellink = unregister_netdevice_queue;
> >
> > -       list_add_tail(&ops->list, &link_ops);
> > +       init_srcu_struct(&ops->srcu);
> 
> init_srcu_struct() could fail.

Oh, I somehow assumed init wouldn't fail.
Will fix in v2.

Thanks!

