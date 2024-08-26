Return-Path: <netdev+bounces-121758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E395E65E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2356B20A8D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F134A33;
	Mon, 26 Aug 2024 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="39JaQrrj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142579DE;
	Mon, 26 Aug 2024 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636367; cv=none; b=I+81WJV4b+K9gUvpN4IamRiqnpdcqqdIAX+8gpPgOGyA7OWNX016whB+M8IFTf2pcft10R7u1nOehcRiWWZbepAD+eQKQJmAF6F+mDBC26W5p6IABtId8izCkaH3/xlzOJGzxywdB9HjOzSMOY13bFGm1myXn9JO68+Sovitny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636367; c=relaxed/simple;
	bh=DDQ2LNUmjSwJeicc7GRFEpLUweO6ZSNXBJdV7ZtL1fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DObcyU+ZDcKLIPjFG2J0qYqFWBp8IRh5zytrvvnpffhYXD+1QeMo/AITOw5HJdx4maYzYynBG4CRfZpidieXFDRUSTwOyGK2LWLUnCIhvFwaT2NJ21ioz/11Xvr/FVFzDgdWTpdZ8eAYPaOO+mggzfhSwbc61/MFgQh8FLjBpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=39JaQrrj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TAqqfpChX+rpsFH7rbwBifApMliSEsLD2ZHYJcTWevI=; b=39JaQrrjz2LgJk7/zCkRIkc5HO
	LG8U4qq2GLjQNX6t2gXcNufqSbQOYkfIYYhx6ph4G79xtyKbXTEAc16dmQRz6jkDSWfQe++uWVCvb
	je6LPJmLUdApRLwTZzo6pv1w0z2ilfQWgpJvsSng+mrl7Q2PEqhOTuc72S5jQ+VH7YHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOhN-005fCl-C0; Mon, 26 Aug 2024 03:39:13 +0200
Date: Mon, 26 Aug 2024 03:39:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: phy: Add phy library support to
 check supported list when autoneg is enabled
Message-ID: <72392868-2811-4726-ae48-cede62f9b45e@lunn.ch>
References: <20240821055906.27717-1-Divya.Koppera@microchip.com>
 <20240821055906.27717-2-Divya.Koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821055906.27717-2-Divya.Koppera@microchip.com>

On Wed, Aug 21, 2024 at 11:29:05AM +0530, Divya Koppera wrote:
> From: Divya Koppera <divya.koppera@microchip.com>
> 
> Adds support in phy library to accept autoneg configuration only when
> feature is enabled in supported list.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

