Return-Path: <netdev+bounces-238799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1311C5F885
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 23:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E9434E125D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE527281E;
	Fri, 14 Nov 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CF7OYzWF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31081CD1E4
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160504; cv=none; b=LvEIsUQ6uPkj9KNbsW4M6xUVVfLJyItWhivU8kMSFokdq8OKBNAKOcdmpYe45BQQj3F6KK/BOKU0g3Lk5tC1hLbHmR5vF2o3ytBIiVeuRcq0e8kHI0DgXkOPNGK8DlxXmAhcnwO5td9eRh5c6vhDUMGCYGkyCzvaag8LriOk42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160504; c=relaxed/simple;
	bh=ZiShzYxb8/vPvEHy4sT1AkKWD7IKEpw4q2VADTL9XOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMCqFzFF1ovFfiTpKWp25gnl9GTka6geFzRHuhVv8+v7BA1tVv2ZChfaXc1EqrpHqRZ4LxbgsFgE+d3SsVkExVbJqSEbAjVbFZd7ql7dNvDig3G6iE6mfyIQhyl74A1gWgI2AR1Y9Kuk1NCQr1LV8Ongg8kHee3MpJujnfmMpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CF7OYzWF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F78IEs8+xjZrv/l1B2Ep/2gtJ5uv4uZLk6Yv9ylMb/Y=; b=CF7OYzWF9Kn082khOXeE/z0TIO
	OcfUfU4Cj1aGHXTvLLUwsZd1uLrE5OswabSJ1raPu81t1pAToA1ZAiHKqeFVW/F+FOHEwtqees8f0
	z6n1Oqy9MlazaY/Q8RdpMfIiEiuJPCZ0TKKzMY/as7i02aZo+DLF+0vJrgkDowJ9vrFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vK2aW-00E2nU-Uc; Fri, 14 Nov 2025 23:48:16 +0100
Date: Fri, 14 Nov 2025 23:48:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
Message-ID: <78cf90ba-7afd-4ddd-893a-8a3ca8d69147@lunn.ch>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
 <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
 <11991339-711b-442d-a1e4-8c3393b12b0a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11991339-711b-442d-a1e4-8c3393b12b0a@gmail.com>

> The CRC errors should be a clear sign that you have a serious electrical
> issue here as the MAC is not capable of de-framing what is coming out of the
> PHY properly.
> 
> Given that you use RMII this would indicate that your PHY's TX CLK, which is
> a RX CLK on the MAC side may not be stable, do you have a scope you could
> use to check that it looks correct? Anything on the PCB itself that could
> hinder the clock signal quality?
> 
> Given that you don't see it at 10Mbits/sec, this would suggest you have an
> issue with data sampling and rise/fall times of the clock being misaligned
> with when the data is present on the data lines.

And Heiner pointed out:

.flags          = PHY_RST_AFTER_CLK_EN

So i would see if that has anything to do with it.

	Andrew

