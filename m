Return-Path: <netdev+bounces-107393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D391AC79
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656101C22071
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C3199393;
	Thu, 27 Jun 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="25BpBuEH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54561990C5;
	Thu, 27 Jun 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505289; cv=none; b=P26gbXm5cgo9E9neqFiXz4iPTbL2gEWspptzqQqLP11yw0erXJxPMkUTErfv6vot/OYoPi0KVoMsDVSh9nmkB5Oz1gqu5pialJxlea/5LmdYf2gx2pKW+HB72pnr8XfU9jlPMzWKchg0xS38eSDL3TF5z9dhBO+waUt1KH28O/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505289; c=relaxed/simple;
	bh=bYNfD/sWppWfPDl6mDI1Wo+8bcvFnM+UlOUpvz0sOYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXj06VT1twlpnaCN+yxcPj83xPnlZLYI7uBArft4AZJf9M3RF52NefjPJcCYE6YaNzLAiuFFhrMMpqH6ZFC3uj0Ni3Vv4Eq4WODKMwfYVP3m1zQYPplFH/teccVSu1rhwWPyRvAkPcgnpd4AspGebBXoKhS4WBfz85Qc8vgNCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=25BpBuEH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MMg+2qG7mpCoM3f9trdLFdHvZyhj2YqLAwH1f1zGavo=; b=25BpBuEH8fEPF5hX24TIa8WVTQ
	hH49Wm5pArEIoDhIN5wpFS+zOx/5QnIeGZ5Mx6diK/QBg2dbYDMUf1JLagzAL4PDF80mzCEZdrwXe
	2vwLfO3x/UCSLGg8DqeOJVv6NnE1M/MbCRMoEVBlfYtHb2H7MHSNtK5/D+Mr1u1GMqVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMrs7-001Baa-GO; Thu, 27 Jun 2024 18:21:19 +0200
Date: Thu, 27 Jun 2024 18:21:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 2/3] net: phy: aquantia: wait for FW reset
 before checking the vendor ID
Message-ID: <71d26a69-aee8-42b9-ab7c-1ba11d3fa760@lunn.ch>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627113018.25083-3-brgl@bgdev.pl>

On Thu, Jun 27, 2024 at 01:30:16PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Checking the firmware register before it complete the boot process makes
> no sense, it will report 0 even if FW is available from internal memory.
> Always wait for FW to boot before continuing or we'll unnecessarily try
> to load it from nvmem/filesystem and fail.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

