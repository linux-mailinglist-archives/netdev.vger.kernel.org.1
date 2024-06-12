Return-Path: <netdev+bounces-102935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ED09058AF
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB88281B1C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1517DE35;
	Wed, 12 Jun 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT8YxOaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB916C878;
	Wed, 12 Jun 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209514; cv=none; b=Rb9CGroR00Tkx/Vz88mQEs9zy+J//7hp7V86wx9AZPva9tihLccIsQzaLKkKqyVzf6Uow9Gl7OU+hAO4ZBscI8CxE6gClMmliCO3eir+MI6vBQC7akIzEXglSI++W5zRsPRcs+EPadFyAt+xgZ1pE61Zg/JCzI02zDqyS1LnWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209514; c=relaxed/simple;
	bh=N74sdXU+mbZDgYlAYkPQg813zdoGTX8PfSjmu0Wmurw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWuEofDOxSUn7uRWGpu6T9VwUWQNTS8W3W6AO15cVBC09d7cIrdTw9II/uQcXTd+a+iPLcNTRBZKXz2WADPRAgAbkrk09S0YyU/qdvPo3DIp6ze724yvyCvhoVgFsK7raQ2wadD+Lo3jGexdpza4E4ewO9GuD/eEfsqtitPOdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT8YxOaa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso96912e87.0;
        Wed, 12 Jun 2024 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718209510; x=1718814310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjViDW1ofcPI9Q3XzCSNNVOySVpdiDhgF1rEIa0r7VA=;
        b=JT8YxOaacyD+maxqD1ybXvJ2ozpKi0q2/ASLCbXjui4wzog5djBEKSfG3Mb2e5IO4A
         LYM0kwFw59Lf5yv0cCuQFmKCtsf08gXnv6IzF700a3IO2o2P5Yk3e8DvyOS1qq90CZvq
         /FvwVPmv5hP7EtdA3NTwERcQCpiUH+IbCm92UFfDAjnV/AeYAZsMx6y6f7ynSGC9cEe/
         7/RgcD3NHqxYIAXUgqmrpcDyzndq7QgnC6+i7BnOz4j9VkWcHg08YbbQzTct9xfPwYwq
         tIbhUBrIDkXeEQl5CKTXZvPKad6L8V14Dkgpciu2bJiRk+D1rHpJQUT9RBctYWm/OxFo
         oj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209510; x=1718814310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjViDW1ofcPI9Q3XzCSNNVOySVpdiDhgF1rEIa0r7VA=;
        b=QjBtu/n0wKv3OhKtnKBYejZr8ymDdE53BO7vHE2CVl5zb/FkUhV3tN4X+vBtwBXy4n
         9FexCaAzgq6O+9SnY4LeTFScvr787f26uwMbbQhrCoymdGD1oVmwB2BRJmxYt19safnd
         Cb9EnFsWi1YX49urKuCIOCJLvoIGRUZj2VDq48JliqsauB52J2yTcCvWOx19a2/gp1rN
         srbOoF2DEC14ukVP22MPW50io9msNK/1DXoUt2wW3BwT3ra1sLG8qdqy/sMMl0aLgJYA
         KQNjOdONDxJS0Y608KdfroFXYqVY208tvJefDTMZv+0WN3rw/z2pMCos/PYYyQB1K53s
         YiQw==
X-Forwarded-Encrypted: i=1; AJvYcCUcypNfjlLB+1/YPpeQbeKlW9ts5LwtvbwERiBI7YL1AOw64tpDXDfArNuATxZY5TNp71xoLwTledLCx7FQjhN1U3P2YQ5I+9aTICPW56nRwTxclMUQZLh9VSUj
X-Gm-Message-State: AOJu0YyRZoa0AuRLy919NZFnAGp6yyeSozZyZmJxIjKasTAov+5/rHLV
	q0HhyxvxpYGjpYNmQhKnkfa5bztCqttYBzHpIgkZabo8dCUgunTy
X-Google-Smtp-Source: AGHT+IHBg4ENXu6zKpZ4W+gE4pdn4C5m09sRJi6Bz+mwDKzOLfMiJn8NxGSpgfnMNC0+xPotL9oCnA==
X-Received: by 2002:a05:6512:20c7:b0:52c:83c2:9670 with SMTP id 2adb3069b0e04-52c9a405bbcmr1175666e87.69.1718209510177;
        Wed, 12 Jun 2024 09:25:10 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com. [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8a3be915sm1465837e87.289.2024.06.12.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:25:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 12 Jun 2024 18:25:06 +0200
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Dmitry Antipov <dmantipov@yandex.ru>, netdev@vger.kernel.org,
	rcu@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <ZmnL4jkhJLIW924W@pc636>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmmzE6Przj0pCHek@sellars>

+ Vlastimil Babka
+ Matthew Wilcox

> On Wed, Jun 12, 2024 at 07:06:04AM -0700, Paul E. McKenney wrote:
> > Let me make sure that I understand...
> > 
> > You need rcu_barrier() to wait for any memory passed to kfree_rcu()
> > to actually be freed?  If so, please explain why you need this, as
> > in what bad thing happens if the actual kfree() happens later.
> > 
> > (I could imagine something involving OOM avoidance, but I need to
> > hear your code's needs rather than my imaginations.)
> > 
> > 							Thanx, Paul
> 
> We have allocated a kmem-cache for some objects, which are like
> batman-adv's version of a bridge's FDB entry.
> 
> The very last thing we do before unloading the module is
> free'ing/destroying this kmem-cache with a call to
> kmem_cache_destroy().
> 
> As far as I understand before calling kmem_cache_destroy()
> we need to ensure that all previously allocated objects on this
> kmem-cache were free'd. At least we get this kernel splat
> (from Slub?) otherwise. I'm not quite sure if any other bad things
> other than this noise in dmesg would occur though. Other than a
> stale, zero objects entry remaining in /proc/slabinfo maybe. Which
> gets duplicated everytime we repeat loading+unloading the module.
> At least these entries would be a memory leak I suppose?
> 
> ```
> # after insmod/rmmod'ing batman-adv 6 times:
> $ cat /proc/slabinfo  | grep batadv_tl_cache
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> ```
> 
> That's why we added this rcu_barrier() call on module
> shutdown in the batman-adv module __exit function right before the
> kmem_cache_destroy() calls. Hoping that this would wait for all
> call_rcu() / kfree_rcu() callbacks and their final kfree() to finish.
> This worked when we were using call_rcu() with our own callback
> with a kfree(). However for kfree_rcu() this somehow does not seem
> to be the case anymore (- or more likely I'm missing something else,
> some other bug within the batman-adv code?).
> 
Some background:

Before kfree_rcu() could deal only with "internal system slab caches" which
are static and live forever. After removing SLAB allocator it become possible
to free a memory over RCU using kfree_rcu() without specifying a kmem-cache
an object belongs to because two remaining allocators are capable of convert
an object to its cache internally.

So, now, kfree_rcu() does not need to be aware of any cache and this is
something new.

In your scenario the cache is destroyed and after that kfree_rcu()
started to free objects into non-existing cache which is a problem.

I have a question to Vlastimil. Is kmem_cached_destroy() removes the
cache right away even though there are allocated objects which have
not yet been freed? If so, is that possible to destroy the cache only
when usage counter becomes zero? i.e. when all objects were returned
back to the cache.

Thank you!

--
Uladzislau Rezki

