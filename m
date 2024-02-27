Return-Path: <netdev+bounces-75157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF37868616
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ECD1C223A5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 01:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16753A7;
	Tue, 27 Feb 2024 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t1pytJjH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD036E;
	Tue, 27 Feb 2024 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997910; cv=none; b=T6rVpGWsJ5RKEDSChROuZhonn1Y57bGI6odALOoRYHAZZ/Nx2+zLnxSaimIph1OBxjSzlMftrScePiamotUbRAZmqlK4pwzfsnsTFf4C/6eLC99dHSdE6QlbSHGA/yEJU7b6QkUPsjMGJ7Q69g1waTaAot4oQeZ68ZN+QlVWhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997910; c=relaxed/simple;
	bh=k0H0CJGtSBEjrbnu+t5AAvrqCiCd2uYNjR6AcWRCYDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVOg/e2RUbljY3LQWXX6IW/n/NeqRP1bHnzUcwwaX6dTtsOM4VqxVkY1106zaIJ2eVBofoDrEZhzTdMSiMp3Ubkc+LaIPDiqvMtIogf/AZYgqCBtt3VWN+L3CT/xCsJgJAb2Fh8PxR/6ZRvfiV9D3U/B71fu1huOGN134q4N39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t1pytJjH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6O2EJbJdRBLh8O5A756GdN8KsbWfqwHG0TYcwlqCvAY=; b=t1pytJjHOLRfj/ftDXY5eXf07I
	aX+bujLMpUynEMOV93t/HESb6QRxs5iqFYUynkwsq0oPUp5LoZXyey7ite1PFep/gpxZINXzdYAVB
	ldrjbnOPVmIVrni80ws7SY7/srk4Pc7iOIewjPCHtFl5Bu+x2fNgvgWzIqOnHh2U7SI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remQa-008mrn-OT; Tue, 27 Feb 2024 02:38:40 +0100
Date: Tue, 27 Feb 2024 02:38:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	richardcochran@gmail.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 1/3] net: lan743x: disable WOL upon resume to restore
 full data path operation
Message-ID: <ff0cea8c-5aed-431c-a525-210fd8c10c31@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-2-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226080934.46003-2-Raju.Lakkaraju@microchip.com>

On Mon, Feb 26, 2024 at 01:39:32PM +0530, Raju Lakkaraju wrote:
> In order for datapath to be restored to normal functionality after resume
> we disable all wakeup events. Additionally we clear all W1C status bits by
> writing 1's to them.

Just to make sure i'm understanding this correctly, you are just
clearing that there was been a WoL wakeup. The WoL configuration is
not cleared, so i could suspend the device again and wake it up with
WoL. There is no need for me to use ethtool, the WoL configuration is
preserved.

	Andrew

