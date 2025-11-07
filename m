Return-Path: <netdev+bounces-236777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5DC40124
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D46B034D511
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86DA2877F4;
	Fri,  7 Nov 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="En7wV3RV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5127AC31;
	Fri,  7 Nov 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521635; cv=none; b=hVWK3/HdzjzoccN8ffgU/+vVRsOMPmypH84IvCdcSkZGjly1Ojm8YniABOr7lsoG/ZGiNGYg074wDQA0aaPutHL9kJj3QSH1e5P4npBl6kthMHB0Eg2QAVwYoe24mQjmTYdB+0DL8efsS13Jj3DDKmTt+bUF+DeqLqCmWzKdXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521635; c=relaxed/simple;
	bh=nASBEMmiuToF4yzqfTxiNUgeuRWihPGcnc9J2tj5mvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsC2rHWh0K2EEyxA8QoLXinN9f3zsjWv/XWQCnRGyFw6/l4Bm6Ev/Jhu5IPkxlogyjMv0+ie9YU6iCK+uzYUrURCA+HKhKAG2V43uFNuXoGFHRWjRWcrjIjEOS4HVsxegY8rIlJXNdS0sG2EoB+KhrQUR9oSQXefN5AbsbOCCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=En7wV3RV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AxJqVnHc0O114rvP6wlG8i6ohapQHLOHOSZ4GUd7m8U=; b=En7wV3RVHDDIsHSEN+zlKj89Mr
	Qd3iHinQZaP0F9RxR6zNPZc0hI9Ln+z8E+8wqDcjp+tCbrRZd4BgfOlkbb43IGFL5DHX4IqFoyojr
	zVyCjeAlgGP+udcbN21lFW3A457eORMOjSLUM1uSqnEGlju0a29EMiPfEMNle3341Hys=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHMO8-00DECY-Qh; Fri, 07 Nov 2025 14:20:24 +0100
Date: Fri, 7 Nov 2025 14:20:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode
 interpretation
Message-ID: <ce95eb8c-0d40-464d-b729-80e1ea71051c@lunn.ch>
References: <20251107083006.44604-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107083006.44604-1-jonas.gorski@gmail.com>

> +	/* Older driver versions incorrectly applied delays in
> +	 * PHY_INTERFACE_MODE_RGMII mode. In order to not break old users, keep
> +	 * interpreting RGMII as RGMII-ID.
> +	 */
> +	if (interface == PHY_INTERFACE_MODE_RGMII)
> +		interface = PHY_INTERFACE_MODE_RGMII_ID;

Did you look through the in kernel .dts files? How many systems does
this effect?

I would maybe add a dev_warn() here, saying the DT blob is out of date
and needs fixing. And fix all the in kernel .dts files.

	Andrew

