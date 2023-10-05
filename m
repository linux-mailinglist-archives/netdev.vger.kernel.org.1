Return-Path: <netdev+bounces-38179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF27B9AD1
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9AE761C2081B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 05:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C315D2;
	Thu,  5 Oct 2023 05:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YLBQ1BxY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D201104
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 05:02:05 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0946AB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:02:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692c02adeefso478899b3a.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696482121; x=1697086921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUBlx/UQfywFlhuFUEtaOwhU14ReSLK4xryxpZiMBMw=;
        b=YLBQ1BxYb6Oo3iEqCEf7FMl2Pql60ePnmQn9Jt6CocarMGEQrJgz6clcP8Kxig5Cko
         cPfbMGubBK3dOYebFXAcj+n856/xdU+x9oqjMqSuoDSDit0pTLmTwe2tg/AFvzAsxRpk
         PJ8W+tw8rIPEhY3U4tWLf+PRvd9ZOn0UQOT6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482121; x=1697086921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUBlx/UQfywFlhuFUEtaOwhU14ReSLK4xryxpZiMBMw=;
        b=a6xn4DULXpw7NaUUV5lo0RjtynJlMZhi4uzAra24ymlHDjANYQxWmHETdLOwWurhA2
         56VL7hTGfN95RKLdFtgXwaUC4DR9XCAG/6SvF3v0LFF89LJOXheC4aUqnMyxNUIK1+Yt
         vsdu7CyW6rRiV6XAl0RCwNvUTNkZK7MzNF9+5X3udkeOX6hcvAryav7Zb0shw0afzkmx
         i5H5VjN3IDZ7NkLqUU+5vT00lurfdgjJDEQ2zWgsztYDH6A4ahZRVfR2y3JBEottRVON
         YtO6us799HIwNI1ihQvfceQT8RZLocQJIcUs+d3Cbf05orj5JcOUKonv6A5lEtAtihW/
         38rg==
X-Gm-Message-State: AOJu0Yx7XoJhZ8rCO7Pl54LERyhCG1V0qnhuoq3lu9TkEnIOILQuR4yK
	nyKcVgnTNgO6Vy0qN2xNojDA8A==
X-Google-Smtp-Source: AGHT+IEk+eklSeAFalrRyIHIONGqBuEv6GuX4yxnxOUjMCyo+vHzQ4Go73W8cmFTtUM0zUjsBQO7jQ==
X-Received: by 2002:a05:6a20:5485:b0:161:25e5:8de9 with SMTP id i5-20020a056a20548500b0016125e58de9mr4742809pzk.48.1696482121626;
        Wed, 04 Oct 2023 22:02:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c16-20020a62e810000000b00690f662a1cbsm427974pfi.0.2023.10.04.22.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 22:02:00 -0700 (PDT)
Date: Wed, 4 Oct 2023 22:02:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: lan9303: replace deprecated strncpy with memcpy
Message-ID: <202310042201.7B14CA59@keescook>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com>
 <202310041959.727EB5ED@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310041959.727EB5ED@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 08:07:55PM -0700, Kees Cook wrote:
> On Thu, Oct 05, 2023 at 12:30:18AM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous
> > interfaces.
> > 
> > Let's opt for memcpy as we are copying strings into slices of length
> > `ETH_GSTRING_LEN` within the `data` buffer. Other similar get_strings()
> > implementations [2] [3] use memcpy().
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c#L167 [2]
> > Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c#L137 [3]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/lan9303-core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> > index ee67adeb2cdb..665d69384b62 100644
> > --- a/drivers/net/dsa/lan9303-core.c
> > +++ b/drivers/net/dsa/lan9303-core.c
> > @@ -1013,8 +1013,8 @@ static void lan9303_get_strings(struct dsa_switch *ds, int port,
> >  		return;
> >  
> >  	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
> > -		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> > -			ETH_GSTRING_LEN);
> > +		memcpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> > +		       ETH_GSTRING_LEN);
> 
> This won't work because lan9303_mib entries aren't ETH_GSTRING_LEN-long
> strings; they're string pointers:
> 
> static const struct lan9303_mib_desc lan9303_mib[] = {
>         { .offset = LAN9303_MAC_RX_BRDCST_CNT_0, .name = "RxBroad", },
> 
> So this really does need a strcpy-family function.
> 
> And, I think the vnic_gstrings_stats and ipoib_gstrings_stats examples
> are actually buggy -- they're copying junk into userspace...
> 
> I am reminded of this patch, which correctly uses strscpy_pad():
> https://lore.kernel.org/lkml/20230718-net-dsa-strncpy-v1-1-e84664747713@google.com/
> 
> I think you want to do the same here, and use strscpy_pad(). And perhaps
> send some fixes for the other memcpy() users?

Meh, I think it's not worth fixing the memcpy() users of this. This
buggy pattern is very common, it seems:

$ git grep 'data.*ETH_GSTRING_LEN' | grep memcpy | wc -l
47

-- 
Kees Cook

