Return-Path: <netdev+bounces-128237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF0978AC7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697211F214DC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540141714AA;
	Fri, 13 Sep 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5QNCBry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065A7F460;
	Fri, 13 Sep 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263852; cv=none; b=WD9FWz+WsQNXZuF2vjUVvr1g/e7JwZozFYnRNPIsjZtxsKHECRU2Sf52FIXa7hYEA7y/CZo+MjsPxWjLMsQLkiVZqqPsSfFjRUe0mXng43ZG6uTAWauR/yQfDOTrU3qO9wM3tLdvoe6JZO0vIhZ6+8YBMekc+DxLszmaNr8py7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263852; c=relaxed/simple;
	bh=hNyvoxa3anpKEWE9B+/hF81CDNXxoDAwvMwv79zNG+A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fjnB+KMv/DdgYxF3rOswC8TFTud4FG+1yz4CWlF01z3WsrBHTK+LVR8hDGmPq7fmj99vue9pteu1nyweB/IR7lmzhqhDrislLEXSqN419ZtE8iKgq8In0sZc/Ms2ZWLZimZ0COV+QzOCwVdegSIoDYAw1L3/tytD01zT2Iy0qoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5QNCBry; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9ad15d11bso210790685a.0;
        Fri, 13 Sep 2024 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726263848; x=1726868648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMLeKw66M9m1AhtQ5lqJRpIeGoTSiq6qH4fFplYAkTQ=;
        b=Z5QNCBrym40GVQ2/sD0LiKpPRtoPZMl+xXc5OIN25oeCHVv2fcCbpa2m1h+ofWCFNU
         tT9hOe4nWg/1Fe4pMfWSVgLiwHJumkP6C2STEkZO3lDDAOgA8yOEmNnZyVrlQ0H7n8XH
         AIXYm2WgfOObtPaWJ3c1nSXwwpXB7dGfxjzgychdNjRf1H9+aqa3xoGJv5FIbMQHlmXP
         17vgQ+BhEVKbL8MseanRyld2E4Cc9diojMdgePf0knoj5f1iBNeSLW/XwUQH9LjpkIfD
         9hAJVDwfsM46DhkH/vZO6BThSoB9eyVo7KqIEIGxebs4aghcAFNvhenBOxRvPKfJZ0/m
         K+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263848; x=1726868648;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LMLeKw66M9m1AhtQ5lqJRpIeGoTSiq6qH4fFplYAkTQ=;
        b=O+fWO3ikQXkPiM83wyr1MEQawMzJpbwdU2cJ2tvNHiFAncQ9L51t3mudFtvMFbJYta
         har+zIKJSg3VHI3RFvJKGry07iNT72Eeoi4StMBDaadOhMKXAsXGxVyiErWUIues54Vz
         5w4Jn4nqZaJtpd3CvvNjQHtz/oCo9UAHTy1UkXOVaXTxQivGlcQXFEVhOzNEYpINP99B
         AspjlE2IQxdXhq4RzKQcPEn2j6l4CtFKZhxrdxEXyFE0BikISelTDNnNIgwStRVHhTcU
         2MX6RFcp1SRJzTax7ignGPMLNJpjkHlBJv05x6LGo9gkEo8aJIwAqssV+sT9Xfs19XMI
         ZU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj0njyLbSOjnDcsGodrRc5/5y8SYQlG4G8M19y1sATifSAHOhltpVMLDIEEictlsNofQRbc13AE1ryHVBO@vger.kernel.org, AJvYcCW/pYLZoGemHIUPorcVub4lQeArEB9BZadgIi4loMPIZn5St89J7V0v1G9cq917VMo6FX5AazyvjTM=@vger.kernel.org, AJvYcCWDX/jdZykVCbZFssezHIAYnZ/9+iuClWjtETLfiYHuQFxltkHqXhaUvqe9MaVUbX7EIuTJNo8E@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHRtduBhDwvhzInT+2IUGsyz1OF8HE7qW+yyL5bUy/pJkGCYT
	5q9x2R9aAFPXnyHtAxh/Tv1etBJ1zWwsxYmYH4kPd2Ii6r2USU+H
X-Google-Smtp-Source: AGHT+IFebz0zvDKDAhsGeRE4WEblmqKZL3XP0bUChu0h1cXPwGrBz4bmSFyW7vRxCT7fsZElpXQG0Q==
X-Received: by 2002:a05:620a:1a27:b0:7a9:afef:33bd with SMTP id af79cd13be357-7a9e5fba0e4mr1449546185a.58.1726263848065;
        Fri, 13 Sep 2024 14:44:08 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3eb5792fsm5238385a.75.2024.09.13.14.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:44:07 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:44:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, 
 kuba@kernel.org, 
 skhawaja@google.com, 
 sdf@fomichev.me, 
 bjorn@rivosinc.com, 
 amritha.nambiar@intel.com, 
 sridhar.samudrala@intel.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 Johannes Berg <johannes.berg@intel.com>, 
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
Message-ID: <66e4b22743592_19ec3c294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZuMC2fYPPtWggB2w@LQ3V64L9R2.homenet.telecomitalia.it>
References: <20240912100738.16567-1-jdamato@fastly.com>
 <20240912100738.16567-6-jdamato@fastly.com>
 <ZuMC2fYPPtWggB2w@LQ3V64L9R2.homenet.telecomitalia.it>
Subject: Re: [RFC net-next v3 5/9] net: napi: Add napi_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Several comments on different things below for this patch that I just noticed.
> 
> On Thu, Sep 12, 2024 at 10:07:13AM +0000, Joe Damato wrote:
> > Add a persistent NAPI config area for NAPI configuration to the core.
> > Drivers opt-in to setting the storage for a NAPI by passing an index
> > when calling netif_napi_add_storage.
> > 
> > napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> > (after the NAPIs are deleted), and set to 0 when napi_enable is called.
> 
> Forgot to re-read all the commit messages. I will do that for rfcv4
> and make sure they are all correct; this message is not correct.
>  
> > Drivers which implement call netif_napi_add_storage will have persistent
> > NAPI IDs.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>

> > @@ -11062,6 +11110,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >  		return NULL;
> >  	}
> >  
> > +	WARN_ON_ONCE(txqs != rxqs);
> 
> This warning triggers for me on boot every time with mlx5 NICs.
> 
> The code in mlx5 seems to get the rxq and txq maximums in:
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>     mlx5e_create_netdev
> 
>   which does:
> 
>     txqs = mlx5e_get_max_num_txqs(mdev, profile);
>     rxqs = mlx5e_get_max_num_rxqs(mdev, profile);
> 
>     netdev = alloc_etherdev_mqs(sizeof(struct mlx5e_priv), txqs, rxqs);
> 
> In my case for my device, txqs: 760, rxqs: 63.
> 
> I would guess that this warning will trigger everytime for mlx5 NICs
> and would be quite annoying.
> 
> We may just want to replace the allocation logic to allocate
> txqs+rxqs, remove the WARN_ON_ONCE, and be OK with some wasted
> space?

I was about to say that txqs == rxqs is not necessary.

The number of napi config structs you want depends on whether the
driver configures separate IRQs for Tx and Rx or not.

Allocating the max of the two is perhaps sufficient for now.

