Return-Path: <netdev+bounces-132668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D87992BBC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AE81F20FC0
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894DA1D27AF;
	Mon,  7 Oct 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E4Ve4PfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC51D2794
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304120; cv=none; b=E+61cBgvHk4CtriIgr62Uatd6AlriYdL5/Tl9ZeA63nRukEoIIlbkIiq/pjDisPY4cPFNue61yuaB3/7oSmmF4XfYHlOpSq81lU75NvseHfnQj6mY7qxk4/gU274bv2qVMJiDU0jdKWr/dq87z8THR5bCtQlK6VWKasRMXOI0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304120; c=relaxed/simple;
	bh=HJ9m1TkqNBRzb8HYpzfsA3WB1FXid62/fo1RseEX7XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhudDbZ7HCbVDOi56lJzf5GUtVADSgd3Dhwb2aDy/BOwzV6I6ApUXR7XuoT5qWM0RjDjfILDtrNORwOgZVbESdWKs2afeBYL6wiq2KPvw4CLSOuGX54LO7pGV3mEyF15AK7rmU4hyYBncWU2hQ5L5+Y9ygq0VRI/qDAw7noKtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E4Ve4PfV; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728304119; x=1759840119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kzhgAe7fJlkMqkTuRRVi7dirI26Z6hZB18k4pORLUN8=;
  b=E4Ve4PfVRyGAKBPNuusVBWPuL62rdU6Gjmy+wH8YcVgygLkTNJlJcWwT
   ktNKDrK2ZH4J4JCwroNzVES6VUlDcHzHWENkcaCCta74BkCYHwp9k6qN5
   eund2T+bjka08ywTmTEHbZoyyXhdg9R7kORgWcEp5YElxDGWbFbk5c7Yi
   M=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="237304535"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 12:28:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:53584]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id e4b8c53d-3eb4-48c9-96bb-76a285629504; Mon, 7 Oct 2024 12:28:35 +0000 (UTC)
X-Farcaster-Flow-ID: e4b8c53d-3eb4-48c9-96bb-76a285629504
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 12:28:34 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 12:28:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jk@codeconstruct.com.au>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <matt@codeconstruct.com.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 4/6] mctp: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 05:28:24 -0700
Message-ID: <20241007122824.4398-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <dcaa0489e90f7c294f6b5e4858b98210766383dc.camel@codeconstruct.com.au>
References: <dcaa0489e90f7c294f6b5e4858b98210766383dc.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 07 Oct 2024 18:09:59 +0800
> Hi Kuniyuki,
> 
> > Since introduced, mctp has been ignoring the returned value
> > of rtnl_register_module(), which could fail.
> > 
> > Let's handle the errors by rtnl_register_module_many().
> 
> Sounds good!
> 
> Just a couple of minor things inline, but regardless:
> 
> Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> > diff --git a/net/mctp/device.c b/net/mctp/device.c
> > index acb97b257428..d70e688ac886 100644
> > --- a/net/mctp/device.c
> > +++ b/net/mctp/device.c
> > @@ -524,25 +524,31 @@ static struct notifier_block mctp_dev_nb = {
> >         .priority = ADDRCONF_NOTIFY_PRIORITY,
> >  };
> >  
> > -void __init mctp_device_init(void)
> > +static struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
> > +       {PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
> > +       {PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
> > +       {PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
> > +};
> 
> Can this (and the other handler arrays) be const? And consequently, the
> pointer argument that you pass to rtnl_register_module_many() from 1/6?

Nice, will do.


> 
> >  int __init mctp_routes_init(void)
> >  {
> > +       int err;
> > +
> >         dev_add_pack(&mctp_packet_type);
> >  
> > -       rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETROUTE,
> > -                            NULL, mctp_dump_rtinfo, 0);
> > -       rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_NEWROUTE,
> > -                            mctp_newroute, NULL, 0);
> > -       rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_DELROUTE,
> > -                            mctp_delroute, NULL, 0);
> > +       err = register_pernet_subsys(&mctp_net_ops);
> > +       if (err)
> > +               goto fail_pernet;
> > +
> > +       err = rtnl_register_module_many(mctp_route_rtnl_msg_handlers);
> > +       if (err)
> > +               goto fail_rtnl;
> >  
> > -       return register_pernet_subsys(&mctp_net_ops);
> > +out:
> > +       return err;
> > +
> > +fail_rtnl:
> > +       unregister_pernet_subsys(&mctp_net_ops);
> > +fail_pernet:
> > +       dev_remove_pack(&mctp_packet_type);
> > +       goto out;
> >  }
> 
> Just `return err;` here - no need for the backwards goto to the return.
> 
> And only if you end up re-rolling the patch: can these labels be err_*,
> so that we're consistent with the rest of the file?

Sure, will change the labels.

Thanks!

