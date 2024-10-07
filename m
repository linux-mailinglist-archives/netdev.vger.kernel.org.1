Return-Path: <netdev+bounces-132772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A739931BF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894C2B240A9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBF51D9679;
	Mon,  7 Oct 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMHBplOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6B1D95B3;
	Mon,  7 Oct 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315910; cv=none; b=QWJOMOnWu7Rqs5WsIrgv4eQ2zODbnrdtuF0vhhmlx7lHCDl5Y/2ebBVu0IdKFDiEMpzyvhZo+00HCibXtSd2DLao6PZSF+CpXj1VgskKWimbPiQtj/SUvZEvCE4sjvaF2HYtnSOZ7CGBHqB+a6FKXER5E4M5Ywm38DH9zm9m+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315910; c=relaxed/simple;
	bh=pdY49v+4fS4cdD0PwxaqWdkKTtbiEkF5VlMpD72D/o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dytEJyS+jQyA5CU1g+cpjkOOv2BeRLT8wJutNs5qrJB1wnbsCjtelVzhYvECwzbctSwIh9PruDfEfA8QAe5szjoU4LikXikKnPD2HOoh9saVznoYzUpcoHoXoeX5weCgRQI9omwrJg1C+0zt/6o1N+h6xrEA4if6EqVFje9HWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMHBplOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7DCC4CEC6;
	Mon,  7 Oct 2024 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315909;
	bh=pdY49v+4fS4cdD0PwxaqWdkKTtbiEkF5VlMpD72D/o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMHBplOOQSyDsy88RYdl6IgDj9tJMiCzOV1iM77Kf8V6UQ0S6PDXRN8kr2Tz4s66k
	 4sygnQwabHDnVePga89lmOi23kh2gK2m/cBVtVDn/dQJhSPnDw7UQHeYxR+52eM8uY
	 cd4BdwyKxWhCfV7s0CQaIIZq2V994PjNbQRxDHO+Y3waJJFGMQFnDFjHx6c/9MwcU0
	 Et2x8h2ye8axf0sYxF8RNTXkTEAH42el4Nz7XVkZvUh9cIUbLF7fLpsuAN3S3Krrsi
	 QIR6GuVsoUmtMKe3OV0i/CFhLEHyBpTV7oMjEpxIgk6IMyJu0yNASXM3pZZJufjhb8
	 oGD8DUxx3VEhA==
Date: Mon, 7 Oct 2024 16:45:05 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lennart Franzen <lennart@lfdomain.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error
 handling path in adin1110_read_fifo()
Message-ID: <20241007154505.GG32733@kernel.org>
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
 <20241004113735.GF1310185@kernel.org>
 <2669052d-752f-416a-9d5e-a03848f30904@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2669052d-752f-416a-9d5e-a03848f30904@wanadoo.fr>

On Fri, Oct 04, 2024 at 03:15:39PM +0200, Christophe JAILLET wrote:
> Le 04/10/2024 à 13:37, Simon Horman a écrit :
> > On Thu, Oct 03, 2024 at 08:53:15PM +0200, Christophe JAILLET wrote:
> > > If 'frame_size' is too small or if 'round_len' is an error code, it is
> > > likely that an error code should be returned to the caller.
> > > 
> > > Actually, 'ret' is likely to be 0, so if one of these sanity checks fails,
> > > 'success' is returned.
> > 
> > Hi Christophe,
> > 
> > I think we can say "'ret' will be 0".
> 
> Agreed.
> 
> 	ret = adin1110_read_reg()
> 	--> spi_sync_transfer()
> 	--> spi_sync()
> 
> which explicitly documents "zero on success, else a negative error code."
> 
> > At least that is what my brief investigation tells me.
> > 
> > > 
> > > Return -EINVAL instead.
> > 
> 
> If the patch is considered as correct, can you confirm that -EINVAL is the
> correct error code to use? If not, which one would be preferred?

-EINVAL seems reasonable to me.

> > Please include some information on how this was found and tested.
> > e.g.
> > 
> > Found by inspection / Found using widget-ng.
> 
> I would say: found by luck! :)
> 
> The explanation below will be of no help in the commit message and won't be
> added. I just give you all the gory details because you asked for it ;-)
> 
> (and after reading bellow, you can call me crazy!)

:)

