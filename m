Return-Path: <netdev+bounces-140124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E59B54C8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EBE284378
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347C20721D;
	Tue, 29 Oct 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q35c2Tff"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC81991CD;
	Tue, 29 Oct 2024 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236469; cv=none; b=Q2vnWIp4TC7axDWUwAw96ttrfGHouVLjP/BsY28rYZcDKwTPwK01U+fYfZ9To4+g8Y8svItwNGdu1I8AUCGpCLqG5Ge1zYxYtwpZaynvDoLC1ai1FS6lRBKYdJhef1q8+O+lmmDbDV6dC1ci+6cHyPHCzEUtXWjKNjxStMMp0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236469; c=relaxed/simple;
	bh=NKg6PorLv+WO9NJ4+ZZWyzkwrKPt3rtHmRknFRQmC5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zir53SA9yUbUwNWIaa+/YU1ZIJ0L/9FmbGPypccQhJLTxEaTX+8ALvYS3FguqsftM1ZiNVvb1iLVxhbnojuofFE1K5RSXVsvp6NkDxA0XF+e1GVB06ZiUxER8NZdeSKcJFTADaI6JLgtAyr7bS25owoO5Qg0IG+g+ntpS2LKGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q35c2Tff; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6u7F8TreOI0FGCD/HZibohizO/SbnUPvos91dHB797A=; b=q35c2TffZBt6+QRqybI4Tz7zci
	0O2JJYeWDqh3WSuD7PXO24JSsakfs9ak5fQ2Xw7rlba/I6qoUPKJNlup9MS3YKi0F7J2+/7U/g+eo
	Vc8nsg4h/O0QG/GGIhbV6dkPbnQb4EG75urGdNU9pTrD0J4QpErvSgkzkvH6S+UKJvN0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5tXY-00Bd3V-Ff; Tue, 29 Oct 2024 22:14:12 +0100
Date: Tue, 29 Oct 2024 22:14:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ronnie.Kunin@microchip.com, Fabi.Benschuh@fau.de,
	Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] Add LAN78XX OTP_ACCESS flag support
Message-ID: <75302a2c-f13e-4a5c-ac46-2a8da98a7b7c@lunn.ch>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
 <c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
 <PH8PR11MB796575D608575FAA5233DBD4954A2@PH8PR11MB7965.namprd11.prod.outlook.com>
 <a0d6ef0c-5615-40fd-964d-11844389dc29@lunn.ch>
 <20241029104313.6d15fd08@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029104313.6d15fd08@kernel.org>

On Tue, Oct 29, 2024 at 10:43:13AM -0700, Jakub Kicinski wrote:
> On Mon, 28 Oct 2024 20:19:04 +0100 Andrew Lunn wrote:
> > > This is pretty much the same implementation that is already in place
> > > for the Linux driver of the LAN743x PCIe device.  
> > 
> > That is good, it gives some degree of consistency. But i wounder if we
> > should go further. I doubt these are the only two devices which
> > support both EEPROM and OTP. It would be nicer to extend ethtool:
> > 
> >        ethtool -e|--eeprom-dump devname [raw on|off] [offset N] [length N] [otp] [eeprom]
> 
> After a cursory look at the conversation I wonder if it wouldn't 
> be easier to register devlink regions for eeprom and otp?

Hi Jakub

devlink regions don't allow write. ethtool does.

	Andrew

