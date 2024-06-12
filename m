Return-Path: <netdev+bounces-102900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A31B9055E1
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E10B1F26EDE
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11017F395;
	Wed, 12 Jun 2024 14:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC517F37B;
	Wed, 12 Jun 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204095; cv=none; b=NI9CaB68Sc/Ijm87Yibe5mG7tYTNeUoCHTgPDB+WpMQNLHH1MdsVEiOjjJHzMTruk6FnGGhtd1jCh62f1Y1IIBd7exram6wywlyFbSA2jE5tsbrDhAT+4a+6+RXc6Is5u51Poxl8VhL0eTIXUlrlUDp90fKmr/JcJ2vgd2vEFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204095; c=relaxed/simple;
	bh=abvfzkYnK5q5eDVAAFXS5olkGiZ15PozttMlbU2dBMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfK7rqYLWtu+5fkaFRmB7OqYQ9zgrcw4kSiglKFrCmM6cyi9veS6hQgDKCweYGYmWGozIL/oYLrwIGa6/vDU92hDU9hD+7YseCFWYt04KVXjW97JOa/DucQBsMxdmUiIHKOxkUoXhQd2bTTlOq+PUCjjNlx6/h/Dsdrzly8xXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13C193EDE0;
	Wed, 12 Jun 2024 16:54:44 +0200 (CEST)
Date: Wed, 12 Jun 2024 16:54:49 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <Zmm2uTHTge-i3eCM@sellars>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmmzE6Przj0pCHek@sellars>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jun 12, 2024 at 04:39:15PM +0200, Linus Lüssing wrote:
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
> [...]
> As far as I understand before calling kmem_cache_destroy()
> we need to ensure that all previously allocated objects on this
> kmem-cache were free'd. At least we get this kernel splat
> (from Slub?) otherwise. I'm not quite sure if any other bad things
> other than this noise in dmesg would occur though. Other than a
> [...]

I guess, without knowing the details of RCU and Slub, that at
least nothing super serious, like a segfault, can happen when
the remaining execution is just a kfree(), which won't need
access to batman-adv internal functions anymore.

