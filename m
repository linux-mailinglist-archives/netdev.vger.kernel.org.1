Return-Path: <netdev+bounces-49535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F12437F24A1
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 04:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D907B20C42
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E6156DB;
	Tue, 21 Nov 2023 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYntoANU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C224D9
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:28:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4877302b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700537317; x=1701142117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSsHzRsq5Xx0I++TzI/3MvEwwDTsLOVtRBfIOCKIdNY=;
        b=dYntoANU/29wWk6owo6HjQXi1dAeLiJynF3CXbmXNUs1OIFCO5tb7mfQsZ9mDfg6ik
         zXD/94/zgewUnAGz1nBzZsAaCeNWjwlLPiaS2Hdi6reg2gftP95EX5f7Dzs0m+DWXQqw
         mboTFOlUvulJueHqJlqpAs4R1Wz512sCH398VEak4EcEb33+OjKsZPJKdRtAUKuhjGkn
         2UKfNVbReSybIwkNeEdBaFwiM+VegE+/cjmwnH6LzbW4puot6Q+099GybGI9Dba4c0XR
         DHJyNRZZzrfR0T0WHQtsODBNpkexwcovv4lsanPIcylHSPrkEW5r9vU8CAfduAZEvpHS
         cxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700537317; x=1701142117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSsHzRsq5Xx0I++TzI/3MvEwwDTsLOVtRBfIOCKIdNY=;
        b=eKMpi3n1uftcSGeTQ4PamhaAtK7L49qN57HHvYt64zB+aM5tLLpT915eOHSrXPX3WD
         KTKt1e0YsiYp0lDuhecU/YycxCk5DXWhTNHr31DZM+ERZwBGMS8U34MCVUDOK7KbrAt7
         31u47I2LsmBAXGNsYgDK/jsfchgbveujkfhS0t4XT7pKilGeOvPHk0Do5WZYUwt7KD2H
         saoG5O0AqEZSjD5CNy7x3GC2ccc2p9IKsu1zcEvTwx23t4q/0giupoQXeruY1HA43AEB
         Res4uDc3+qSbfEKrBSgdZL2GsJeJ1aQejfmtLyvbcDIya7KbaRSOukGvP6aUtM8puBq7
         Wbwg==
X-Gm-Message-State: AOJu0YwoAIwuGGCBVy1+PoZZSDN2uOFydyo7S/uri4PJi4iATi6Z0agz
	sR6VAkgmkLnlrkPOwgXwg8M=
X-Google-Smtp-Source: AGHT+IGF4UXbkrRjaKgaPHI9DZ7gwz+3MqDZUnMBhdCwIxBBjETFgh51zrLrDHM9Kl7/AbfPAVPMsg==
X-Received: by 2002:a05:6a00:198e:b0:6b8:a6d6:f51a with SMTP id d14-20020a056a00198e00b006b8a6d6f51amr11094372pfl.31.1700537317335;
        Mon, 20 Nov 2023 19:28:37 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7874d000000b006cb8e394574sm3047851pfo.21.2023.11.20.19.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 19:28:36 -0800 (PST)
Date: Tue, 21 Nov 2023 11:28:30 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: bridge: add document for IFLA_BR enum
Message-ID: <ZVwj3kb/3BdvKblG@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-2-liuhangbin@gmail.com>
 <20231118094525.75a88d09@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118094525.75a88d09@kernel.org>

On Sat, Nov 18, 2023 at 09:45:25AM -0800, Jakub Kicinski wrote:
> On Fri, 17 Nov 2023 17:31:36 +0800 Hangbin Liu wrote:
> > Add document for IFLA_BR enum so we can use it in
> > Documentation/networking/bridge.rst.
> 
> Did you consider writing a YAML spec instead?
> 
> It's unlikely to be usable today with YNL due to all the classic
> netlink vs genetlink differences, but Breno is working on rendering 
> the specs in documentation:
> 
> https://lore.kernel.org/all/20231113202936.242308-1-leitao@debian.org/
> 
> so in terms of just documenting attributes it may be good enough.
> It may possibly be nice to have that documentation folder as "one 
> stop shop" for all of netlink?

Thanks for this info. Will the YAML spec be build by the document team?
I'd prefer all the doc shows in https://www.kernel.org/doc/html/latest/
so users could find the doc easily.

It would be good if there is an example in Documentation/netlink/specs/ (when
the patch applied) so I can take as a reference :)

Thanks
Hangbin
> 
> Absolutely no strong preference on my side, just wanted to make
> sure you're aware of that work.

