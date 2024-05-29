Return-Path: <netdev+bounces-99155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC868D3DAB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD87B21ECA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069D181D0A;
	Wed, 29 May 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElnJLkFs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC71181CFD
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004928; cv=none; b=Xc/t466/f6D/NZqiu/UCFcoFGV+rVvAlnVKoUDyyEAiy+86rwbiTazOrnnf3MVa5CQ10tf+OpHd/OAyk7MQDeBu0CTmx3wjzeYtC+IUiPc8X9aRPMEranQshbSnpZCs0DFVXWRI/l/wpk0CknDpFFeoKiK5LK0jEpaKDq+u232s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004928; c=relaxed/simple;
	bh=TltO1sEr7haFVLSXhyJRQB4TncUI/LH+o3HXtlZ/V/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=steaWMDx+3b65JpvdjWi1PgHYEGsefVz4EWkbaLJH08WceJyJ9JNZLBkNGP/K1NFwSw41RztzClxDE6p2U7MheRx3dAb9UjpJ+Q6YvxSeVQlZ9bYaFHE6jr1llOjA9PvVwrOM0VrkY4gztaHGRuZBh7cF65YB4CtzFUSaDwUGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElnJLkFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34516C2BD10;
	Wed, 29 May 2024 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717004927;
	bh=TltO1sEr7haFVLSXhyJRQB4TncUI/LH+o3HXtlZ/V/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ElnJLkFs0txVwgj3VG3Xfs1jySgRDdOT/zTjAKQFFpmsKuSU/w1Vo41l7odeB7ujR
	 iHI6HF7v04r6fA6cjUgumNBbBdiBHL+1MFEdDgQS2H2WQMMLtz3oSTzuHjGeqeefKh
	 /hCkqhY+xmXx0rX24vTdadoWBMSqt5uVHXy/zCADCn7u1yYyOzpnPt91YgDBgJ/k+O
	 ifjI/tguj/j+Pl1seAzkgWBZ3p5IUFB7FipZ8ITUADD53aYntAUOhH2qwS8VpkGLoo
	 FZ5FF+4Qt099dk/JANOtJ/pcBSnIiZ17gnVNWNCHV5kg3grWj4v76vK2p2XvuWkHca
	 usjGpwR0Z0gRg==
Date: Wed, 29 May 2024 10:48:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 07/15] net: psp: update the TCP MSS to reflect
 PSP packet overhead
Message-ID: <20240529104846.3d0b4651@kernel.org>
In-Reply-To: <6641712443505_1d6c67294c7@willemb.c.googlers.com.notmuch>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-8-kuba@kernel.org>
	<6641712443505_1d6c67294c7@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 May 2024 21:47:16 -0400 Willem de Bruijn wrote:
> > -	inet_csk(newsk)->icsk_ext_hdr_len = 0;
> > +	inet_csk(newsk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
> >  	if (opt)
> > -		inet_csk(newsk)->icsk_ext_hdr_len = opt->opt_nflen +
> > -						    opt->opt_flen;
> > +		inet_csk(newsk)->icsk_ext_hdr_len += opt->opt_nflen +
> > +						     opt->opt_flen;
> >  
> >  	tcp_ca_openreq_child(newsk, dst);  
> 
> The below code adjusts ext_hdr_len and recalculates mss when
> setting the tx association.
> 
> Why already include it at connect and syn_recv, above?
> 
> My assumption was that the upgrade to PSP only happens during
> TCP_ESTABLISHED. But perhaps I'm wrong.
> 
> Is it allowed to set rx and tx association even from as early as the
> initial socket(), when still in TCP_CLOSE, client-side?
> 
> Server-side, there is no connection fd to pass to netlink commands
> before TCP_ESTABLISHED.

Mostly for symmetry, really. IDK what's worse, the dead code or that
someone may be surprised it's not there.. Should I delete it?

