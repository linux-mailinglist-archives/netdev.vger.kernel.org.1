Return-Path: <netdev+bounces-72746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539EB8597EC
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BB4281460
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C910C6EB5D;
	Sun, 18 Feb 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CMozmuNq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C96F085
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708275854; cv=none; b=Cs6EfIq4W36zIpuWxxR/gnb5joq6tsLV7Cm1fJ/21iXuQaxZTIiMteac96TVbTIehSjCXSzCy1uaeR9A7YdezG436KdOSaaud8/RHMt+XQ4LUhJPWNGzbYdsazsIn+BsVeVgewmLPmuFrXjo766mubl7gY3/pQgNKXDwgS5Sojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708275854; c=relaxed/simple;
	bh=mFCgfPYSUlTXF+kMvfuLJvTSEi8eRbN5TxrMQi8Rv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or5s2CWMY+3CyOkEwPtFJbYN+l9zn/7mwV5OJve7s8sqR7XjcH4hNYupFylsb1GtqNd67AtzwMncWrAGivBvCVC11fu2giqgbGPnCUBo4ZdKy72g4brqtx28MdcL4D+gTtSDxfJSfOD500N92/6yGxZbhPqdPdrN4NU27OQ5KrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CMozmuNq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=30Jv3pZxWyNuFxBMP3ZB8seikc+h5WX0/Mh0ZWr0RI8=; b=CMozmuNqYbPAnBWzihlO9nO0MM
	VcN6ery2VyAwf0w27SrF/HgAh+PriCwwIDlBqgCwESTC29/YxB8xiIzXB6eVTpahQ0PY133pQA/FW
	lp6CtK+xb33GHkodnVFmGdOlKEv2K8SWbWJTSOLO2EQ0JuQl+jxETchHmo8d7oA678mI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkaF-0088G6-Hu; Sun, 18 Feb 2024 18:04:07 +0100
Date: Sun, 18 Feb 2024 18:04:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] tg3: copy only needed fields from
 userspace-provided EEE data
Message-ID: <14978af2-0b94-4677-b303-da7c690abcca@lunn.ch>
References: <59bd00bf-7263-43d9-a438-c2930bfdb91c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59bd00bf-7263-43d9-a438-c2930bfdb91c@gmail.com>

On Sun, Feb 18, 2024 at 03:49:55PM +0100, Heiner Kallweit wrote:
> The current code overwrites fields in tp->eee with unchecked data from
> edata, e.g. the bitmap with supported modes. ethtool properly returns
> the received data from get_eee() call, but we have no guarantee that
> other users of the ioctl set_eee() interface behave properly too.
> Therefore copy only fields which are actually needed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

This one needed some time for me to understand. I missed that when
programming the PHY to advertise, it is hard coded what it actually
advertises. So there is no need to copy the advertise linkmode from
edata.

I suspect this driver is broken in that it does not wait for the
result of the auto-neg to enable/disable EEE in the hardware. But it
could be hiding somewhere in the code and i also missed that.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

