Return-Path: <netdev+bounces-165187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AEAA30E03
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E321887E5F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768524CEEE;
	Tue, 11 Feb 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jI9/2iGS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697824CEE5
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283415; cv=none; b=Xk+xWzCzcfC5Eka9k3mc9EKbw4S9qZOxw9anYdPOaGVBgqC0nBOMy/Ot+n4v19Mmb5MFhVnD7DHI2RJppmmXLyHaS3NTxr4U8dAQtvF1eph6W/f02FBd1IcNTF8ImPiDqeFztXzwt+b9Pjvnc5xYnsRyySVe5dWpgikkM5/dWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283415; c=relaxed/simple;
	bh=RoLrFS9DskrVuK6skz+TWguAjtx8dYeqtIvn6Hhzydk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTN1XBfhR2gtYqFCzN+yFWsH8UbBLYzpVN6oaA36iLCPqwLJAaXjyTL6Cze6xa/K0ZWOUZfi/uLlkytEQD+qRmH7hauM7M6aelQaxtWI1RVMCea6PfOgTC8vsXM8U6JV6H3ZUBrKpLTyP78D65Q3RCxCrGx9rlOGmA3/vvGrGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jI9/2iGS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MHoZjbvXKpF/JWLLQoRJo6AmGuTjc7g47NiAq5yc2Gg=; b=jI9/2iGSopbwXMPv5YRoojOaQP
	0uXqUZBP6tSnNqdwbjbameYwGw/61ZPxu2jKPwPfIoabYATOVYv0XYgv9/w3JPTpCHRZZIf9I2i7x
	uDoQ8iPvgYI2bjMpOBVi92IIBck8XbawtMOkrLuxvbUXU3nU9/8mBYgtSFp8H//nAd50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thr4A-00D58x-IZ; Tue, 11 Feb 2025 15:16:46 +0100
Date: Tue, 11 Feb 2025 15:16:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Simon Horman <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: add support for
 thermal sensor event reception
Message-ID: <f8c9cc3f-4cba-488b-9c93-c31b404f4d63@lunn.ch>
References: <20250210104017.62838-1-jedrzej.jagielski@intel.com>
 <87644679-1f6c-45f4-b9fd-eff1a5117b7b@molgen.mpg.de>
 <DS0PR11MB77854D8F8DEEE0A44BB0E17EF0F22@DS0PR11MB7785.namprd11.prod.outlook.com>
 <442420d6-3911-4956-95f1-c9b278d45cd6@molgen.mpg.de>
 <7085302f-af69-484a-8558-2aa823379fbe@lunn.ch>
 <DS0PR11MB77856580F83D80DE883C82F0F0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB77856580F83D80DE883C82F0F0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>

> Actually there is only one adapter across all portfolio of ixgbe adapters
> which supports this feature. That is 82599, none other supports it.
> Even next generations (x540, x550) didn't provide support for reading thermal
> data sensor.
> As E610 is some type of extending x550 it also follows this path at this point.

It is something you should consider. The machine disappears off the
net for no obvious reason, and needs a cold boot to get it back? vs
HWMON entries you can monitor, a warning when the critical value is
reached, which probably reaches the network console and so gets logged
somewhere, and then the emergency value which shuts down the NIC
without any notification getting out of the box.

Also, if there is temperature information, Linux can take an active
part in managing it. If the critical value is reached, it could
downshift to a lower link mode. Better to have a slower link than no
link and a cold boot.

	Andrew

