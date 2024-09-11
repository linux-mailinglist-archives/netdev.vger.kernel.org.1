Return-Path: <netdev+bounces-127521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06E975A7F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422A51C22687
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E541A304A;
	Wed, 11 Sep 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEIkYrOR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E417DA66
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080431; cv=none; b=Hbc43myldQaPkmei66lh0VaJrO1ceZk4TMTCIUkh8KWVlg84auYCy5feWYhwpaE2rcvO0wffOavDBDNVosR7eyUsiMlJrrAFMvn2tXUgOIuLs+HSS9m4786+RPwbViMvTTaxqWJBw5ROQLadvWLAUw7aqNKrDcG7QHPW5EHMNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080431; c=relaxed/simple;
	bh=nol/iDZePG78i/WNZ+Uk7Xf/7+JB2vG35T2BwP2yKX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+0LDa6vBabAE2gMwOKAWIf74rXlkAoHUP8MGahmuOGy7n32LwZT/niECkdq6ShqbBoCcpQI+kSpSy9B3lEazYjydieEVaezuMwMsZDpWu4YMf/eu41eHM0CEzcOWQ4psC7g0ozkiZyuILpKC/2whdKF2vhjhLDlvs1BJYTeuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEIkYrOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAFCC4CEC0;
	Wed, 11 Sep 2024 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726080430;
	bh=nol/iDZePG78i/WNZ+Uk7Xf/7+JB2vG35T2BwP2yKX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEIkYrORyP53K4HS5Y3HwwyCRsNMEP1EvimcquHH9qi2UcC90l0JU/+Woi+usV3t7
	 qFq2JwVK6DMR7OniqvyA+rvEfVudLp4w16qeS+jsp0PJaVPRCC62OyDDemy9LexXGS
	 ZoS2f9Vx1UHL2ra4zfZHMCDpkMe6CPR2BYHi6//0BPHswbMzjaFQHPvV9mJxQSStUP
	 4A1aqYwtR9sLlwGjI4WwBm7ZeCcg/dNLO2tj74W1CpLdwPDKZ2RDo0AavfAZVk3ghK
	 rDzE8gwqWht/eTxZaOqG/pBoce5mp3bqLUdYbsoYUbxG0eU8uK/AEekIvSIJpaIM3S
	 u7VGaGaaWsg0w==
Date: Wed, 11 Sep 2024 11:47:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, David Ahern <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Alexander
 Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add initial PHC support
Message-ID: <20240911114708.6863aed6@kernel.org>
In-Reply-To: <006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
References: <20240911124513.2691688-1-vadfed@meta.com>
	<20240911124513.2691688-3-vadfed@meta.com>
	<006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 18:25:11 +0200 Andrew Lunn wrote:
> > +#define FBNIC_PTP_CDC_FIFO_STATUS	0x0480c		/* 0x12030 */
> > +#define FBNIC_PTP_SPARE			0x0480d		/* 0x12034 */
> > +#define FBNIC_CSR_END_PTP		0x0480d /* CSR section delimiter */  
> 
> We know the PCS is a licensed block. Is this also licensed? Should it
> be placed in driver/ptp so others who licence the same block can
> re-uses it?

Nope, the timestamping itself happens in the MAC, obviously,
but the clock / ticker module is fairly straightforward.
IDK if there's even shared IPs for that.

> > +/* FBNIC timing & PTP implementation
> > + * Datapath uses truncated 40b timestamps for scheduling and event reporting.
> > + * We need to promote those to full 64b, hence we periodically cache the top
> > + * 32bit of the HW time counter. Since this makes our time reporting non-atomic
> > + * we leave the HW clock free running and adjust time offsets in SW as needed.
> > + * Time offset is 64bit - we need a seq counter for 32bit machines.
> > + * Time offset and the cache of top bits are independent so we don't need
> > + * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
> > + * are enough.
> > + *
> > + * TBD: alias u64_stats_sync & co. with some more appropriate names upstream.  
> 
> This is upstream, so maybe now is a good time to decide?

Ha!

