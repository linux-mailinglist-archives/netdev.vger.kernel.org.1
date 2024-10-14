Return-Path: <netdev+bounces-135280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4198199D5A4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93931F24225
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBB219E982;
	Mon, 14 Oct 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZZ9UBjYx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606629A0
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927353; cv=none; b=F3ktBJFgjvptMDrDcCksu59TX49W1HkGIRPxs6pBC665bNMmf9/rE8vb7lYAr73EvNxWhV0st8vduSClzLJ+zHPJbITQIyJPkAmLPxNitzV2cc5/owpm/V7uBQ96nWmoja2S2GEN5g4/Ll3vXeyqS3Rp8Tp6fV+LlyXssRxdj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927353; c=relaxed/simple;
	bh=sLk1issAwdQ//QhdNxu1mHszkFUY5IXHc3oqp9LDe2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzE9PmQUpB4L1YWL6qRvw5i0EVV9zY6TOWTX+SoHPabGeSwmwAYFIfBkRWKV0NGy2BQlcwiyggfEoJle8tq5qE2u5nm6efvbwa3uL4qLiJdXEoqdlPyBeEgkOODf2xnZA6qYxwejD0Y24gBYUyQo0AQO/waUuGSD0mvo7IirjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZZ9UBjYx; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728927352; x=1760463352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CkRBvEQpSVHbs/E5+sfYPxZ9mnuJNYIVX9P/3b1K9Hg=;
  b=ZZ9UBjYx5vK6MnlOg2GDznkVt5ZNw3aMrIBjVc/TOD0bZtaDy4IE2G9M
   chx3F6ch/RIPCL3HDlgt6E2QQFizz5PJtnggK9Waj7lg4A6ifZHlGIWkd
   CUX1WfBQmHFVInKF76CnInwtUvsMXFRNSaA4rSSDDc8ZJbZB0RF9dQ3IM
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="766450130"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 17:35:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:3138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id d1106c9f-76b3-4be3-ba68-ac0314c41a41; Mon, 14 Oct 2024 17:35:44 +0000 (UTC)
X-Farcaster-Flow-ID: d1106c9f-76b3-4be3-ba68-ac0314c41a41
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 17:35:44 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 17:35:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 03/11] neighbour: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 10:35:38 -0700
Message-ID: <20241014173538.66247-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iLhMM9BJLYMg9N0iDfLg-iTjjSof8djopYQfMdbbLeZLA@mail.gmail.com>
References: <CANn89iLhMM9BJLYMg9N0iDfLg-iTjjSof8djopYQfMdbbLeZLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 10:01:54 +0200
> > +static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] = {
> > +       {NULL, PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0},
> > +       {NULL, PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0},
> > +       {NULL, PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
> > +        RTNL_FLAG_DUMP_UNLOCKED},
> > +       {NULL, PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info, 0},
> > +       {NULL, PF_UNSPEC, RTM_SETNEIGHTBL, neightbl_set, NULL, 0},
> > +};
> > +
> 
> Please add __initconst qualifier.

Sure, will add it for other built-in files too.


> 
> Also C99 initializations look better to me.

Exactly, I just double-checked PF_UNSPEC is 0 :)

For some modules that already have the older style,
I'll change them to C99 style when I convert each handlers.

Thanks!

> 
> +static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
> +       {.msgtype = RTM_NEWNEIGH, .doit = neigh_add},
> +       {.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
> +       {.msgtype = RTM_GETNEIGH, .doit = neigh_get,
> +       .dumpit = neigh_dump_info, .flags = RTNL_FLAG_DUMP_UNLOCKED},
> +       {.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
> +       {.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
> +};
> +

