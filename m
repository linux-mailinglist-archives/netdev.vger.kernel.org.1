Return-Path: <netdev+bounces-111990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10939346BD
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA771C212CE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC842C69B;
	Thu, 18 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zn3PFBPs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD93611E;
	Thu, 18 Jul 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273433; cv=none; b=bI9hbtHwNASN1OHJtMUaHnRk6dlQlxw+4CBIu+FC2aQ70zz1tTXdAaikT5p2dh62FofAo0CFMe4SgbCFMfr7RKLwO7/AOnhanZXosoRoMPndLCp5TjzRDTF97jWg6BU90/LNHePS2uvaFP2jhA1ygO1mB++fMA7/vGfAknHB+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273433; c=relaxed/simple;
	bh=7+zu5L9uvyhFaZGTSGbANYzDfAfi7Y31CYoNzB3YQ40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyNvUiFfp5ScxQ/o1LFbJkrCir8h6VXqKfhcT609fCK5iAqHW0vJRcG+PgXE4Y2No/l8tPEGm1T82QQmxBm9uEcQKkBXpkz9zY7Gjjr/XB6Bx4XTrGJNxmRbb6VG3pzm17g8oa7eFrKULT2AMLl/1r5NVMwy8cmSvo38stHEnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zn3PFBPs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2exnLrrRrPmk9Z8Xfze5jArJw5qXx4jp1s+I7j+j12c=; b=Zn3PFBPsZfbbLoRqMRfmZjAl57
	SXWLMPY9DcqXElROqJP5JY+Ev/eqQqTEfuO1xr4r1zCJpUgpFkRo2UAqSVayfazn/Tp4NVN71aVhy
	VcOUuCUf4DwlolmCAJytxOyKVfiPL79tqLn0G9IA6GNWL+SwXdDazgEQcdeluUkRijJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUHqZ-002kn6-Ck; Thu, 18 Jul 2024 05:30:23 +0200
Date: Thu, 18 Jul 2024 05:30:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	horms@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, linux@armlinux.org.uk,
	bryan.whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 1/4] net: lan743x: Create separate PCS power
 reset function
Message-ID: <933de7d6-87ee-4b7c-997f-69c1560a4e83@lunn.ch>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <20240716113349.25527-2-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716113349.25527-2-Raju.Lakkaraju@microchip.com>

On Tue, Jul 16, 2024 at 05:03:46PM +0530, Raju Lakkaraju wrote:
> Create separate PCS power reset function from lan743x_sgmii_config () to use
> as subroutine.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

