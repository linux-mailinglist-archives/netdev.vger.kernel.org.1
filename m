Return-Path: <netdev+bounces-126313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6681D9709CB
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 22:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0F3B21583
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 20:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40162178CE4;
	Sun,  8 Sep 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JS1trTKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D54D8B1
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725828571; cv=none; b=Nj+gd8UX6mY2mLwxA2mi0aU/v54oig0U9JtUiMLTmcJQQY408EP4JwU8yMMlNVarpPZjmd0+H/Oa/XQXqEurbS4KtIg1Inwexe/VcnnfYVPfe0j0E37usszJ+T+9n+fBiLT1qgUMFgpUAosEwEwzXs+sEFZQbS87QU7LfW68QCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725828571; c=relaxed/simple;
	bh=EoBKEDH3k4qBQyLBQhS51btl8ruh9qqZSDp7H6obE4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqOIntYWLdm5f0s8UEAruIQ+f014v7o/wUPFmyPE+4BOTZHM5w3tXcFa+xFyEGMFhRRrZE4rT6HMPG+zYMbF4XEDlgYtPvwqY9jR67J32uhpvPwSXsNld4SXwgHgbdrY9MQeWWP/tzRG6ZKy4Ydgubl6S9RG6tiCHhM1Z6ZW1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JS1trTKk; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c26852aff1so4045974a12.3
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725828568; x=1726433368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEC4wQ1JIXOpeG5hhCNp2MQwBTDr5gpJ3bo6M3CBVtc=;
        b=JS1trTKkvXAgqiYbC01zItEsJP92zihXrGJ7stWcGZ3jUEGyyZtoOHopzqAUj5KvCS
         DdJnC/DOe8bPXtsWOLoR4q019OX0MhLdKMkKzBkowOI8zY9Z1kjoc6IR0DZNvJ2U5h/u
         KFM4JXkK97/ceQNBDlKkUTifqg6kwt/y/ZuaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725828568; x=1726433368;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEC4wQ1JIXOpeG5hhCNp2MQwBTDr5gpJ3bo6M3CBVtc=;
        b=hQhD+FAt6zyuTTSkTrsehPmVda86YgEvTgqHZ7dyw5lJ+JQ/EFnw+GOqks56VFW2g1
         2+9d3neOROwobSNXazCd50xdEh4b2R6DzXV//v2HPpioGO0hmueqVR3jy2K6Lu1WZLwl
         ZG2N3BQnuhJVwTOfO2VGmWji7k2Spav8B5KUSxez9iRcniWljB1LV7HdFYEP8ti10JGL
         D2aRa0y0Mbg/oV0w+AuLt7t3SEvgthwiYPFQFVTCGQStQdREmYAxYJkbL/fY1VqhutfQ
         17TR8x/Atdx4jobw9FgCVVag7leiMfiFz/RWI9lJPldGrAd9p3NHZK3sesQQmg/6ikrn
         lSag==
X-Gm-Message-State: AOJu0YxBWIDrjtTxMyX2ximJl83bCUs+ntxalNAmQOgYtO6tLtcQFJpm
	MnrGOSyusqHpK/c5lFhv48c52+UbUS5HBrXKMjJl0ks/9Eee58vj8/MiM/ySAt3DCDbRlncVDcV
	NoKOqMtkqL2Utjqo2tYKI0cojEHQG+i4vJ3kKSlwVCuSrOnY7H9STduQWLo46WZDtB5U5aAPR3Y
	ldUO15wTpHtR1SrC3okcLs3GnEQw02ygcC83UCNG6tp5DRvg==
X-Google-Smtp-Source: AGHT+IEpMGHYf5BD/zUKQTqTgiisAQ1anJ5u/AzUGtH+fTD6Vnd38+tGUnUUgp5rDSrfzmoVdpGKVA==
X-Received: by 2002:a17:907:97d2:b0:a8d:5472:b56c with SMTP id a640c23a62f3a-a8d5472bbf6mr81751866b.22.1725828567442;
        Sun, 08 Sep 2024 13:49:27 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2844fsm247389666b.88.2024.09.08.13.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 13:49:27 -0700 (PDT)
Date: Sun, 8 Sep 2024 22:49:25 +0200
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <Zt4N1RoplScF2Dbw@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240908160702.56618-1-jdamato@fastly.com>
 <20240908160702.56618-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908160702.56618-2-jdamato@fastly.com>

On Sun, Sep 08, 2024 at 04:06:35PM +0000, Joe Damato wrote:
> Add a persistent NAPI storage area for NAPI configuration to the core.
> Drivers opt-in to setting the storage for a NAPI by passing an index
> when calling netif_napi_add_storage.
> 
> napi_storage is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted), and set to 0 when napi_enable is called.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  include/linux/netdevice.h                     | 34 +++++++++++++++++++
>  net/core/dev.c                                | 18 +++++++++-
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 

[...]

> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6719,6 +6719,9 @@ void napi_enable(struct napi_struct *n)
>  		if (n->dev->threaded && n->thread)
>  			new |= NAPIF_STATE_THREADED;
>  	} while (!try_cmpxchg(&n->state, &val, new));
> +
> +	if (n->napi_storage)
> +		memset(n->napi_storage, 0, sizeof(*n->napi_storage));

This part is very obviously wrong ;)

I think when I was reading the other thread about resetting on
channel change [1] I got a bit confused.

Maybe what was intended was on napi_enable, do nothing / remove the
above code (which I suppose would give the persistence desired?).

But modify net/ethtool/channels.c to reset NAPIs to the global
(sysfs) settings? Not sure how to balance both persistence with
queue count changes in a way that makes sense for users of the API.

And, I didn't quite follow the bits about:
  1. The proposed ring to NAPI mapping
  2. The two step "takeover" which seemed to imply that we might
     pull napi_id into napi_storage? Or maybe I just read that part
     wrong?

I'll go back re-re-(re?)-read those emails to see if I can figure
out what the desired implementation is.

I'd welcome any/all feedback/clarifications on this part in
particular.

[1]: https://lore.kernel.org/netdev/20240903124008.4793c087@kernel.org/

