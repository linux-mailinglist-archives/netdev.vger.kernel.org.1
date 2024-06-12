Return-Path: <netdev+bounces-102936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF129058D5
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250F61C219B3
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2543180A6C;
	Wed, 12 Jun 2024 16:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795D22094;
	Wed, 12 Jun 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209923; cv=none; b=tlIzRE8xOJD9bhyIX9L1ebcN+/NUmXz3WWK/j4vbyX4f8f1BFKFtLZ37qFlkaxHOt+SwqjqGs3PmShXqMSsJ8NKUC11FtpZcOwOKQKU10PsCmCm+NP6Wke4UWmp4bzl0p1geXsAKninzKUA6e3spvof3Ir+ndKBPUQgW0vP7WnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209923; c=relaxed/simple;
	bh=9kcPv5W4B+8600QkPB+YfYX4bbJ0TTcPtkHUsLK5zR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boynw2d5+biICbsbLVNwMqYuB5wDmquoOVf536NtNQf8tew0YmJC2CCc6x2G1J4wlQEFrBojRp7wwbevTDF7KfVAniQlW3dMVPMW+TKTkD/MsROKndJce1oem3atu4A88otNm4OKrLZvyFhMkrE5tGelzyqyVpMVQf/t6vqpJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1C193EF21;
	Wed, 12 Jun 2024 18:31:52 +0200 (CEST)
Date: Wed, 12 Jun 2024 18:31:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <ZmnNfU44NekafjA_@sellars>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
 <Zmm2uTHTge-i3eCM@sellars>
 <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jun 12, 2024 at 09:06:25AM -0700, Paul E. McKenney wrote:
> We are looking into nice ways of solving this, but in the meantime,
> yes, if you are RCU-freeing slab objects into a slab that is destroyed
> at module-unload time, you currently need to stick with call_rcu()
> and rcu_barrier().
> 
> We do have some potential solutions to allow use of kfree_rcu() with
> this sort of slab, but they are still strictly potential.
> 
> Apologies for my having failed to foresee this particular trap!
> 
> 							Thanx, Paul

No worries, thanks for the help and clarification! This at least
restored my sanity, was starting to doubt my understanding of RCU
and the batman-adv code the longer I tried to find the issue in
batman-adv :D.

