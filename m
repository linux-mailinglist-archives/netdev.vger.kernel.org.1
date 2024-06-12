Return-Path: <netdev+bounces-102893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E457C905558
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96501C2091D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5424617E91A;
	Wed, 12 Jun 2024 14:39:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B817E47A;
	Wed, 12 Jun 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203162; cv=none; b=jDGmSGeuu4T6iFoW1xASZ+shD1NZ7gFV9BaWpI2YfHjWvOUpcfOyGvGSbWazqV9v79foFkEiWU3nILyz+2G6d0mj+9VqmNsVOhGvYfQ4ucnZiiwTFRpSwRowBng4b5EnaD/swYCaxU72VXR7+QB98EZacHwEcBgvS+Ym1hnomtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203162; c=relaxed/simple;
	bh=pPUr/Dzg/34UQ1vJ3rlTbyO0Slke2kCite75RGIvVxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkGYUn8EolVvw4J9BZCu2BgJPaqlcrIQn4LeGLlyCZ6EDWlsm2VoGu7U49cdoVSW4Mt8CF9Zo6QKuguW++HlBqPMZShEclSHkNFiCljDcdwEjZsjNPsw78of6bhDofOZYfaPGWaFAaOZZ8L3GBgq81aryeld+h6etorSWCwEDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 357533EDE0;
	Wed, 12 Jun 2024 16:39:11 +0200 (CEST)
Date: Wed, 12 Jun 2024 16:39:15 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <ZmmzE6Przj0pCHek@sellars>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jun 12, 2024 at 07:06:04AM -0700, Paul E. McKenney wrote:
> Let me make sure that I understand...
> 
> You need rcu_barrier() to wait for any memory passed to kfree_rcu()
> to actually be freed?  If so, please explain why you need this, as
> in what bad thing happens if the actual kfree() happens later.
> 
> (I could imagine something involving OOM avoidance, but I need to
> hear your code's needs rather than my imaginations.)
> 
> 							Thanx, Paul

We have allocated a kmem-cache for some objects, which are like
batman-adv's version of a bridge's FDB entry.

The very last thing we do before unloading the module is
free'ing/destroying this kmem-cache with a call to
kmem_cache_destroy().

As far as I understand before calling kmem_cache_destroy()
we need to ensure that all previously allocated objects on this
kmem-cache were free'd. At least we get this kernel splat
(from Slub?) otherwise. I'm not quite sure if any other bad things
other than this noise in dmesg would occur though. Other than a
stale, zero objects entry remaining in /proc/slabinfo maybe. Which
gets duplicated everytime we repeat loading+unloading the module.
At least these entries would be a memory leak I suppose?

```
# after insmod/rmmod'ing batman-adv 6 times:
$ cat /proc/slabinfo  | grep batadv_tl_cache
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
```

That's why we added this rcu_barrier() call on module
shutdown in the batman-adv module __exit function right before the
kmem_cache_destroy() calls. Hoping that this would wait for all
call_rcu() / kfree_rcu() callbacks and their final kfree() to finish.
This worked when we were using call_rcu() with our own callback
with a kfree(). However for kfree_rcu() this somehow does not seem
to be the case anymore (- or more likely I'm missing something else,
some other bug within the batman-adv code?).

Regards, Linus

