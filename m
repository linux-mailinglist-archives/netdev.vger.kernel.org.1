Return-Path: <netdev+bounces-139558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB99B307B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F041F2259B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222761DA0ED;
	Mon, 28 Oct 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AUuZ2c0V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842218FDBE;
	Mon, 28 Oct 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119113; cv=none; b=E5HA9joRTxEcuONqsS2mfdOtqYmjeR0K6aTIFHeUBrQqa4IxUnEQh9i41D6jbuHGoBN2sJVi6NX4JeF6yjuKkN7WqQHROcNa75wsafSMWqT9dIsnk0AYPCUG1yKqMcX+LKXTzV+prJdB9up57eUm2LWnTjUw9Ye5AsLj3AlVZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119113; c=relaxed/simple;
	bh=l57zkt31ysNXbU5Beb1POJfXYxsAs1C0+JtNN0Z5Qww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0yrCbXR2v1Jx7ArimlUI6U3vfF6FBIy2WebyqRL7BUMFTb4a6qX9I5Bt5NMRHFFFNICVvVPiHqxfyTDO8lGpwEaaqen0qzfT+JyKoOj4WeOSZc/BUpKECO/4e7ET2+ip04iZlLOBvSa+rq9oQrAHrec5qlZJ5GCPXELKWjwl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AUuZ2c0V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U3TgRywqxilRRFAt5rH162dOH+tv6SvlcFTqOEAK1N8=; b=AUuZ2c0VAqFrfvrVHH5PIbRfWM
	+PxNwbgBA5ln9p3yYdYRDdgVSzIboTrkHvQmR8r2FKJ48n7bmTionKoeQ1UyuLx9YFBEpD5KL76Ii
	xiYxGgSkT7Py0zG2S3PAuyo1f7nPrVIEhECLoDYYlUK+YkbS3k156eSLr0OSJ4p8l0mQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5P0j-00BRe7-Rg; Mon, 28 Oct 2024 13:38:17 +0100
Date: Mon, 28 Oct 2024 13:38:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabian Benschuh <Fabi.Benschuh@fau.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] Add LAN78XX OTP_ACCESS flag support
Message-ID: <c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025230550.25536-1-Fabi.Benschuh@fau.de>

On Sat, Oct 26, 2024 at 01:05:46AM +0200, Fabian Benschuh wrote:
> With this flag we can now use ethtool to access the OTP:
> ethtool --set-priv-flags eth0 OTP_ACCESS on
> ethtool -e eth0  # this will read OTP if OTP_ACCESS is on, else EEPROM
> 
> When writing to OTP we need to set OTP_ACCESS on and write with the correct magic 0x7873 for OTP


Please can you tell us more about OTP vs EEPROM? Is the OTP internal
while the EEPROM is external? What is contained in each? How does the
device decide which to use when it finds it has both?

I'm just wondering if we even need a private flag, if the hardware
will use one or the other exclusively?

	Andrew

