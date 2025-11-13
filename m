Return-Path: <netdev+bounces-238518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5ADC5A582
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DACCF4F0759
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534702773F4;
	Thu, 13 Nov 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jEXR4RGv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E077261B
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073315; cv=none; b=qRCt3vuVAtE1NhLFjl6NI+5V0fMcOnQc43JlEjCKdCEMu/SZnJuL/NchJU5K5cC4da9KSP2bAdf01Z2XWIAXNI26tPu1kvVipM0NaeGhtiY96dQEYhnXA+zfyZNyar4c0bqD9UqNAEsRlJDmZ2DpCIYiXvnJn71jzdgfJQPsxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073315; c=relaxed/simple;
	bh=ZAhUkxv/QwpUmT+XMtL947Lv3VQLGrm/GUwyiIv5tI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt3rJou+Rk8br8ag1GXkkWtpeN2+wO91ZNMTXQYFwyttL3ocmJ6CuKChsZ0zyrjSseA2Dd3TdzJIUJiuAf2Ai58BXnnoXQZqnvPAaxNI6uj78Y1Boc6lMfg3s8WkRIWWfDoBTZvPvhm9iIekuZGRNL7O1lJDbeuUGZ/9evX2uV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jEXR4RGv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L0iIh3rNx64MuhyEV240hJ8Ob/rhBqhBaZEzYQ+HSlU=; b=jEXR4RGvY7qPC/fevKUhkeSmRz
	TiMCpTYg/fPWkVm4zDiszoQur827E0Hf7ARdP/ar9bpQ5zj+bawoiD3YpO1TaxeT22Bk0A66kY9t9
	yaQtmTNiwcfNqHPHaAND7BoYdxOYn2euzDhQKRN6UpwZqA5Ukk3GisZxb75txCxvl+5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJfuF-00DvPQ-Kf; Thu, 13 Nov 2025 23:35:07 +0100
Date: Thu, 13 Nov 2025 23:35:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
Message-ID: <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>

> Behavior:
> 
> - Packet loss occurs when the LAN8720 is bound to the smsc PHY driver.
> 
> - No packet loss when using the generic PHY driver.

> Any guidance on how to further debug this or what additional
> information would be useful is appreciated.

Maybe dump all 32 registers when genphy and smsc driver are being used
and compare them?

	Andrew

