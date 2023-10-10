Return-Path: <netdev+bounces-39740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF1A7C4416
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714AE281DD1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CB3550A;
	Tue, 10 Oct 2023 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tmcb004r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53C31594
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:30:18 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D56098
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:30:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27cfb36c0d4so505604a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696977010; x=1697581810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jk/roA1OX5FDgRmG8rXSW1i76Cf+PVeWpMPLt8rVrkA=;
        b=Tmcb004r2BAcfqR4j+lcfiVLjXKhEvQrI1NQavhS8xO0Nunm8kF6Kq2GmI5hAj7asK
         jk2e3qk83ec+AjMmyarMsumpnHJCbKi83deuUZmkI/SscA5ZSU4HhACGgIfczJusMa+0
         uBC3plmTYoFj45QECcfTsLEdo5NMkwDLwYn0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977010; x=1697581810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk/roA1OX5FDgRmG8rXSW1i76Cf+PVeWpMPLt8rVrkA=;
        b=B8m7gB8ShTMq/ZtX4R3qFw0Zp8sI01x6GBzt/WE4NcVJI2GYSyHSHNjqskH8203VOi
         InyyYFugpCc8Rxsj1RY3pl5UG60TusTxjzal9U5uGbIJP7FTT61s5mdHzGtTxq9+gW/n
         RfDWDQSKQ7t8Hk3h5YZ+hNnllue8vNUdhja0ppvEGOH5x/2R+YUMw4Vock5FRjsbthib
         f9kiFl4p+F97zbRTGjGok1s7am/kTFuFeFmzsDYOptPR6JglWPOaVki5bamtQwsakDJ9
         /Y9zJjvZaAqNNLjJpVQ87s/CLwADrBv4UixnyYVrVeqaZa9jziKfinBBZWRO6NMne9dg
         csQQ==
X-Gm-Message-State: AOJu0YxwF1A201yDcKZc9VlZluGj13SLXiR+59S0YLpXYbVmIS+jp5pp
	ED+PywNg9mpV/Zm3Bm1jTSKX6Q==
X-Google-Smtp-Source: AGHT+IFJJFy6I0NJ7fJc92KgL1DUF2I4+xXv/DYwva8smLJkbVqRlyh1cWrhEPh+t9R4XFb2bAm6cg==
X-Received: by 2002:a17:90a:788e:b0:276:ae0f:57c0 with SMTP id x14-20020a17090a788e00b00276ae0f57c0mr16533759pjk.19.1696977010647;
        Tue, 10 Oct 2023 15:30:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090b079300b002791491f811sm10504761pjz.8.2023.10.10.15.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:30:10 -0700 (PDT)
Date: Tue, 10 Oct 2023 15:30:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
Message-ID: <202310101528.9496539BE@keescook>
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
 <20231010110717.cw5sqxm5mlzyi2rq@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010110717.cw5sqxm5mlzyi2rq@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 02:07:17PM +0300, Vladimir Oltean wrote:
> Hello Justin,
> 
> On Mon, Oct 09, 2023 at 10:43:59PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > ethtool_sprintf() is designed specifically for get_strings() usage.
> > Let's replace strncpy in favor of this more robust and easier to
> > understand interface.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> > index 41ea3b5a42b1..d171c18dd354 100644
> > --- a/drivers/net/dsa/realtek/rtl8365mb.c
> > +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> > @@ -1303,8 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_switch *ds, int port, u32 stringset
> >  
> >  	for (i = 0; i < RTL8365MB_MIB_END; i++) {
> >  		struct rtl8365mb_mib_counter *mib = &rtl8365mb_mib_counters[i];
> > -
> > -		strncpy(data + i * ETH_GSTRING_LEN, mib->name, ETH_GSTRING_LEN);
> > +		ethtool_sprintf(&data, "%s", mib->name);
> 
> Is there any particular reason why you opted for the "%s" printf format
> specifier when you could have simply given mib->name as the single
> argument? This comment applies to all the ethtool_sprintf() patches
> you've submitted.

The primary reason is that without the "%s", any format specifiers in
mib->name will be processed by sprintf(), which could lead to very
unexpected results. One never wants to just pass a string directly to
the sprintf-family of functions for this reason. "%s" is needed to keep
things safe.

-Kees

-- 
Kees Cook

