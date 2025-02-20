Return-Path: <netdev+bounces-168213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3607A3E1B2
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52A8168FEB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6841204875;
	Thu, 20 Feb 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EObcDFXD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFD1DF754
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070827; cv=none; b=d1Wfm0359rbnlYXaaNzGU67Hu3KsN0zuuyLViquGjhfQ5WQV/hvyd1PB4amcb7mgSNAqmwHoM/Fvp/Mf2H9WNbnxITy/4LSrFHo41K9ap+7Jayy6bo89qOxeJBwQpGD07xiDAaVe0jlmc6SaLuntrC2TEz90HSuxeVRt8OZlf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070827; c=relaxed/simple;
	bh=fOy88t2mrsBpcuMmORkTbMqeRQT1HzWrfhBvjufkiTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmow9NJk1X9MUr7u/9lLs4hutlggsC6pLZZODt1jPWYlRQyyOHZonFZJ58cfoJflulf1LbHPlQ/gok04xVslJUBhv6xHdCr6GefvC/zw3g0z9xd1RD3dDolzE0WOOnEyCZCjgHQCS3HB7e4PIuDz6zjfVNI6sB4AuhlUbxssMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EObcDFXD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221206dbd7eso23545585ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740070825; x=1740675625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk9fC+lYSLtynUzP6jUfSa6nmCyQN3X6KV4IAfSwS58=;
        b=EObcDFXDw4vXENiGJFYUJ+Dm1pQRx+V2LKWVN+mSFmfThcci5E2l+rEdoqYuNAa5jl
         OZOqKPETsa1zvUvNIIJo7qcbYkmXAYUWUTPmVBBQExE3Y03QWUmawmIZnq9PckA1Nn9u
         C3AqbhT1gp5np7lNg9UpHdkCSlxJnXotClj42iuByDFRQ+ucV9T8YH1VBb/Zzg3qIQsK
         +rjOlI9diLCyMOUQi6HxBu4Z0wVEmcTH9Xtc3N8OOVAs7gl01bYG9u1lcXPaGSThtTWI
         Ph5y3ycPS+JwErxWaeFlOU4/n4Mx4jFJFh4jeb4bbhG+BKCh4C1RVPTmLJMe6PoT7Tfw
         b6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070825; x=1740675625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk9fC+lYSLtynUzP6jUfSa6nmCyQN3X6KV4IAfSwS58=;
        b=E1eu4KtGp1b/F14MlLywIFSuwso8pRFK1TsrUIX3OF9uuUJbSPtNIjPfWk7xgxeNj4
         rUdTXWzXo+Y8zFW3FmEpJGvFnMyuW7Ut9VYw68yFB7H/DBa5/96FsfLNjyknQnNQWZa2
         GMmcVR6Czmn39UfO/YRgV2Up0utTRkHBLG0fPODFXvRYbaHH6h/xUCdPuWD4VvY3rTWs
         FgMbzwZWNuPuElGYuIVVzh1abdfBlmMPItfAr+ebyxXcWur6j/YvskfBBj0ucUpsnOnN
         y0ffmmJ+r1XcjpgluzLYIf7yWkJJxbiUAGoT1F4Gdpsbi7ClZWGWwoNkeHsKL0uTLYq6
         LTaw==
X-Forwarded-Encrypted: i=1; AJvYcCXkVtdivK2P191TaUASP+LOxCc9Vwh2Bfs+FPJS/SCFlTdOQ7IfBApEpgGl/EWEfgRhDChPFvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8c3ei1AELPe2HiBHUJ1Dh09y6qVE71LPH8w09jbBZ9PyrRFtR
	FOgop0Wzq2oU4BX81BxBXziNnCWU21g4roz/2R8F2WcOgo8Ss8w=
X-Gm-Gg: ASbGncvz33UBIa+4nlxfeWTYrEI28Dl7RIYRTTwjUFweoOh2TXOmz12S/6QXBZbQ7bv
	inZgIIRQNGOGykOvEBXZBovQMOV2cbamLb9Mg8JLKS7XVYyA4nmpU8qPCrkSquertntYbmYGLNl
	Q4R2GxqYbJcD4tUTse+FyjM51Cc4BdfkW0ngCpD/4bcj/u+zr3mUxBLUiioM4IB0DpLX5uE+1ws
	KFVm0DiRiOq9/IXDs4igZW0+//zAjGORj1OGbylB8r930bUE1eeuLcuFeKjlaAjxzwCOb7MDV+m
	s62qXpht4uSq9FY=
X-Google-Smtp-Source: AGHT+IE7+DEjwyVSCGT+Js5UbOwnM4OjQ1HkA8D+s9jy+UX6S4zUmXO8PDhNNUayOQYVedbKM01RSw==
X-Received: by 2002:a17:902:da92:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-2217098bc35mr145080155ad.25.1740070825473;
        Thu, 20 Feb 2025 09:00:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf9ab068dsm17825772a91.48.2025.02.20.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:00:24 -0800 (PST)
Date: Thu, 20 Feb 2025 09:00:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v5 03/12] net: hold netdev instance lock during
 queue operations
Message-ID: <Z7dfqFr-knB3Bv0G@mini-arch>
References: <20250219202719.957100-1-sdf@fomichev.me>
 <20250219202719.957100-4-sdf@fomichev.me>
 <Z7dGFLSom9mnWFdB@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7dGFLSom9mnWFdB@hog>

On 02/20, Sabrina Dubroca wrote:
> 2025-02-19, 12:27:10 -0800, Stanislav Fomichev wrote:
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> > index 533e659b15b3..cf9bd08d04b2 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -1886,7 +1886,7 @@ static void gve_turndown(struct gve_priv *priv)
> >  			netif_queue_set_napi(priv->dev, idx,
> >  					     NETDEV_QUEUE_TYPE_TX, NULL);
> >  
> > -		napi_disable(&block->napi);
> > +		napi_disable_locked(&block->napi);
> 
> I don't think all the codepaths that can lead to gve_turndown have the
> required netdev_lock():
> 
> gve_resume -> gve_reset_recovery -> gve_turndown
Good catch, looks like suspend is missing the netdev lock as well, will
add.

> gve_user_reset -> gve_reset -> gve_reset_recovery
I believe this should be covered by patch "net: ethtool: try to protect
all callback with netdev instance lock", no?

__dev_ethtool
  netdev_lock_ops
  ethtool_reset
    gve_user_reset

Or is there some other reset path I'm missing?

> (and nit:) There's also a few places in the series (bnxt, ethtool
> calling __netdev_update_features) where the lockdep
> annotation/_locked() variant gets introduced before the patch adding
> the corresponding lock.

This is mostly about ethtool patch and queue ops patch? The latter
converts most of the napi/netif calls to _locked variant leaving
a small window where some of the paths might be not properly locked.
Not sure what to do about it, but probably nothing since everything
is still rtnl_lock-protected and the issue is mostly about (temporary)
wrong lockdep annotations? Any other suggestions?

Thanks for the review!

