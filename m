Return-Path: <netdev+bounces-153451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD259F80A7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E47A030A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB2143736;
	Thu, 19 Dec 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RYxYQkz1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F071482F2;
	Thu, 19 Dec 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627029; cv=none; b=SvZklVi0dQHg6q3Ara8eIwR6yG6eTQJRYCzmqo2cJBu/rpq5I2mxGW5oX/0eBMZ2t4WlWL4B/U0tZydvLeYmbwdodFrQkWBVQdw1BEOZcT0pE13LXhgL5emAXh5CYGa70Ob9UBYab6JSyzoF0JZ72/LMYPwsk4PtiXWMCj1d9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627029; c=relaxed/simple;
	bh=oqaaaB57GyBPgAkcLlUGBO6o/hvfrsIR7FxtmGWtT34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/F7JSTysKERvxvQbH5v0/cRqefoUMganw/CpyYNxhGJgWNaHTnQ1mGCEZczNenevaOGXfYE3/JYutPphIC5ZNKEM7leTYUJqyYep9zfLrE6dLeIqvZsA0fmI0M5S94BUfY5fDYjkuAEvrwI0ZPMe+nxztTTMz5LsyzJE/1DvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RYxYQkz1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5RTw4bXm3CKmAJo0gFxaP64qRCe46+jXL1PRQdRz9io=; b=RYxYQkz1uJ/NZJBBzQvsjhMA9c
	s6+6WXXRz41eEFRKeVFzYsRYa4y+nkpUJLPLY2kziczOqdjdpB176BuFcRCk9MiqKSm/QCmKv1iO3
	clEzflX3rT+OBVzRRktT4bHaHAxZGh7YIoUdcSlqGFIKjJ+JbAaGbIimxKJ0kTinljVY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJjB-001gc5-C6; Thu, 19 Dec 2024 17:50:21 +0100
Date: Thu, 19 Dec 2024 17:50:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: microchip: Fix KSZ9477 set_ageing_time
 function
Message-ID: <cfc29efc-8bc1-46c1-97b9-8d2a53a3240c@lunn.ch>
References: <20241218020224.70590-1-Tristram.Ha@microchip.com>
 <20241218020224.70590-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218020224.70590-2-Tristram.Ha@microchip.com>

On Tue, Dec 17, 2024 at 06:02:23PM -0800, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The aging count is not a simple 11-bit value but comprises a 3-bit
> multiplier and an 8-bit second count.  The code tries to use the
> original multiplier which is 4 as the second count is still 300 seconds
> by default.
> 
> Fixes: 2c119d9982b1 ("net: dsa: microchip: add the support for set_ageing_time")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

