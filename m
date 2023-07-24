Return-Path: <netdev+bounces-20289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26F75EF4F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA11C209BD
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2826FD0;
	Mon, 24 Jul 2023 09:42:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC3185A
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:42:40 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F41A5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:42:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8b4749013so33203015ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690191759; x=1690796559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Me09JAHDE7SDhvsN7mmKdb7NoKKGDMVG5pQHu9N427Y=;
        b=baffDOg8ahGncXz9Zjz6TH/ve4ciwVqCVOaxVccVq3lOT81+ECLf1ci8uuyv0UtdZ6
         PF/aIAiEL/vAu4FJTy4LHTxdgKuPMc0LgS+jGSCkM2fDwxp0jykDoo/+XTlVwq8ZrAaO
         LsBxbTMJz3FPo+ckfj35nb2dQiJvMpB7V18JeA3/Vbm26Qz0X7zwhJ2Lueyudh8BT9R7
         HdG8vhsxrJrQz/oEVJFKspVW+AM+cxZM13IfqdGJPB/ZWLyvB8OHfT/BKexcNbloBmZ+
         DE2UYzcaoOTI/Ga06u5vST6+sfi0TwUfAhE+vUgfgnLSFujBS4cwhuVNAockkBOpS6eM
         eHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191759; x=1690796559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me09JAHDE7SDhvsN7mmKdb7NoKKGDMVG5pQHu9N427Y=;
        b=cCpfevwKSoeEIRvkibGx+8y6nFpHLsmNrNvkKcBOXEM/V4P0duqAIZqpp0GjLAzwNj
         b6wKiegYnm8A/lBX8U8bGw4xUHx8+9/2Nzo4BNwOEJyob1I3/SuDHoWJN9QLYN1Ahg+k
         QFTUUU4/fJKT3jBzNpa855LUPsNN/JrqUKfJ/G7sOvq7+WM9VhtROQRz9J/5oec6KSaP
         IeKLaOZ4L5ZblGGzy6nQB+j55RoYCJywTzCFyiNx1w1f0RNtyKsZD9FZN0Eb4oR1vVBB
         elKNYAnTjVmsGrlfoguwopqNtSu83GXnUBRAZxS+346zVUhGGWY/2lHyrjQPoNJojVGn
         B6zA==
X-Gm-Message-State: ABy/qLZwTUlfHzVEE/Y/4DEXC9YyiItirsvST4ztSCmmC4evCzafrgAG
	H4IDAW1uiWk76fuMykIZapA=
X-Google-Smtp-Source: APBJJlEKnDDPWiK5PLwQdmv6Spi80wYUuYGu4/jq6uO0jlBvFVTnCKXI7RM08MsHRm0HPIezXY7jcw==
X-Received: by 2002:a17:903:22c4:b0:1b6:6b03:10cd with SMTP id y4-20020a17090322c400b001b66b0310cdmr12260338plg.67.1690191759251;
        Mon, 24 Jul 2023 02:42:39 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bh11-20020a170902a98b00b001a6a6169d45sm8400059plb.168.2023.07.24.02.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:42:38 -0700 (PDT)
Date: Mon, 24 Jul 2023 17:42:34 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv3 net] ipv6: do not match device when remove source route
Message-ID: <ZL5HijWsqLgVMHav@Laptop-X1>
References: <20230720065941.3294051-1-liuhangbin@gmail.com>
 <ZLk0/f82LfebI5OR@shredder>
 <ZLlJi7OUy3kwbBJ3@shredder>
 <ZLpI6YZPjmVD4r39@Laptop-X1>
 <ZLzhMDIayD2z4szG@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLzhMDIayD2z4szG@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023 at 11:13:36AM +0300, Ido Schimmel wrote:
> > BTW, to fix it, how about check if the IPv6 addr still exist. e.g.
> > 
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -4590,10 +4590,11 @@ static int fib6_remove_prefsrc(struct fib6_info *rt, void *arg)
> >         struct net_device *dev = ((struct arg_dev_net_ip *)arg)->dev;
> >         struct net *net = ((struct arg_dev_net_ip *)arg)->net;
> >         struct in6_addr *addr = ((struct arg_dev_net_ip *)arg)->addr;
> > +       u32 tb6_id = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
> > 
> > -       if (!rt->nh &&
> > -           ((void *)rt->fib6_nh->fib_nh_dev == dev || !dev) &&
> > -           rt != net->ipv6.fib6_null_entry &&
> > +       if (rt != net->ipv6.fib6_null_entry &&
> > +           rt->fib6_table->tb6_id == tb6_id &&
> > +           !ipv6_chk_addr_and_flags(net, addr, NULL, true, 0, IFA_F_TENTATIVE) &&
> >             ipv6_addr_equal(addr, &rt->fib6_prefsrc.addr)) {
> 
> ipv6_chk_addr_and_flags() is more expensive than ipv6_addr_equal() so
> better to first check that route indeed uses the address as the
> preferred source address and only then check if it exists.

OK.
> 
> Maybe you can even do it in rt6_remove_prefsrc(). That would be similar
> to what IPv4 is doing.

Do you mean call ipv6_chk_addr_and_flags() in rt6_remove_prefsrc()?

Thanks
Hangbin

