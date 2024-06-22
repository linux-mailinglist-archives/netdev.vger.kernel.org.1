Return-Path: <netdev+bounces-105880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A039135A1
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3792F1C210CC
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429C36AF5;
	Sat, 22 Jun 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eQLdbElH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226B1C294;
	Sat, 22 Jun 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081303; cv=none; b=bYrVxww+XHMi2PoGgPn2EWYzQTND7mkNvAlAvI9BIYivwCdLov4Y4t5m+XBupYUU2XRZUXJs7tEtjZ35PZEb4awztUwAaj/v52NRCnKwcMDk3rx6AONJ1UAUKH+RdLdzsbD5KfjqD6+Un0jQJBNjMnWOu2WC+LE/X/NrHkZ1F1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081303; c=relaxed/simple;
	bh=XYxZuKCnL22HPUQAPhPnXi++5P2Q/8abV7mvKUJCUtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGHV4s8i6v+Kgehg7PwXEs1dFgh+4ppPmXOWH8fmGvXRv0GPdQ7z6YeVBUEmgNs81bTIu6O7r5Bkw7Ye1h7gEknmq+VWORVG+OmgvoRNeZxsbi9IZIczLLLCc+3UEQeXEVtoxYEEzIBs1nKQVjsd5ssfEpe0PCpmoJJDHhvGrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eQLdbElH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=WtH1Zp7xwi52ioj3lt3Qy9s5fQZ5eE+x0n+o/lp0u3M=; b=eQ
	LdbElHLPtFX+yp5KF3NrfN9vZKDOrTWM/GKz3CWq3G5Z+eZB0G0ZL2L65ynoDq+kFTqpBqS3q1p19
	mQ3WhY0nhS34VYxO5LHnlqA3IxxJi9PJFlBJmElzGr+5ZdxzVBGb4zxMCn7aKvrJ0NvYf67AYbk6m
	AYCVbXpW8XF4q0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL5Zb-000kHD-So; Sat, 22 Jun 2024 20:34:51 +0200
Date: Sat, 22 Jun 2024 20:34:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <033592b8-f47a-4cae-a946-7b165d65027a@lunn.ch>
References: <20240621112633.2802655-1-kamilh@axis.com>
 <20240621112633.2802655-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621112633.2802655-2-kamilh@axis.com>

On Fri, Jun 21, 2024 at 01:26:30PM +0200, Kamil Horák (2N) wrote:
> Introduce a new link mode necessary for 10 MBit single-pair
> connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
> This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
> terminology. Another link mode to be used is 1BR100 and it is already
> present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
> (IEEE 802.3bw).
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

