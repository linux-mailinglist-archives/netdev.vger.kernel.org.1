Return-Path: <netdev+bounces-41062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B17C97AE
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B68B20C6A
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2527EC;
	Sun, 15 Oct 2023 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyaUD53G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B40111F
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 02:36:56 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6563D9
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 19:36:54 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b68556d6dso1842052eaf.1
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697337414; x=1697942214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VU2x4r2C1Cg+Ar4cIjbSuCvHfJH/2aoAhlJs5r56OOM=;
        b=JyaUD53GYUBMrimAlpH81aFRJHFPeeoC7UCiOPQiiwcj43ZW0DnuLNd4C8NM1jEE7w
         BlLzGvi+6si8Wzf3Ksfce61ykygIcAAg6b230hYUhEma9hqIAmwwxdYE2sYn04n5tC62
         KMSe2LtLMeDKfMA+ZXomL9Ng9JVjLOgBcdWv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697337414; x=1697942214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU2x4r2C1Cg+Ar4cIjbSuCvHfJH/2aoAhlJs5r56OOM=;
        b=AY11OeEa5uAFvgdo8ZmBM+IfUO5H9bQKX4akbsyQqxMfRRqWT1StkxIrvvc8kw1/9B
         8iQQLth18itDJ6dnjlZXdpcE4y8n1eIZ9uCkWqoNWcOk/6l5ma37el5VkZh7QKrxR7cO
         4QMi5TGIvoTNrzKX5QFwE8dZ27nLE4izDnbnyUeDLxDXOJwanMAQh1tdNjbUetFobpvk
         okQ2ibB2XRk02G2iLvqg/RRh2C3d3TAQNnDbGpqgo0hWtQ0ad/1SG7aVNeU51y3PysnQ
         aSNvX85aah+afWoNBThpRWdeGfOk6I6TKSfOusvTsUQZ0pFVwlxwjR6X/7RfBikXo45L
         P81Q==
X-Gm-Message-State: AOJu0YzaG7RvviTyLcLDlgakOk+po0QZhP4iRjvlQ4HqflsIDikDmO0h
	6U5DwpPGWyJoYLkx/6uBWw40dw==
X-Google-Smtp-Source: AGHT+IHClQo+ghAM+7G8NtI+1Ce3WoRKJIKQToAT9aiTv3CxelXG6k00DC30no3I3lgVgPNYZ5q6YQ==
X-Received: by 2002:a05:6358:702:b0:143:9bc0:a975 with SMTP id e2-20020a056358070200b001439bc0a975mr29192932rwj.7.1697337413969;
        Sat, 14 Oct 2023 19:36:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z9-20020aa785c9000000b006926e3dc2besm15684432pfn.108.2023.10.14.19.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:36:53 -0700 (PDT)
Date: Sat, 14 Oct 2023 19:36:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Justin Stitt <justinstitt@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310141935.B326C9E@keescook>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
 <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
 <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
 <202310131630.5E435AD@keescook>
 <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 03:55:41AM +0200, Andrew Lunn wrote:
> > I've been told that this whole ethtool API area is considered
> > deprecated. If that holds, then I don't think it's worth adding new
> > helpers to support it when ethtool_sprintf() is sufficient.
> 
> I think deprecated is too strong. The current API is not great, so
> maybe with time a new API will emerge. But given there are around 160
> users of the API, probably over 100 drivers, it will be 20 years or
> more before all that hardware becomes obsolete and the drivers are
> removed.
> 
> > Once you're done with the strncpy->ethtool_sprintf conversions I think
> > it would be nice to have a single patch that fixes all of these
> > "%s"-less instances to use "%s". (Doing per-driver fixes for that case
> > seems just overly painful.)
> 
> I guess it is the same amount of effort to replace them with
> ethtool_puts()?

Yup, right. If adding ethtool_puts() makes sense, then I totally agree.

-- 
Kees Cook

