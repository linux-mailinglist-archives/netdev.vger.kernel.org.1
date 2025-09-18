Return-Path: <netdev+bounces-224612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BBB86EE2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69151C87C5A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F402EFDB1;
	Thu, 18 Sep 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1b2fAVN/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5B22D7A1
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227910; cv=none; b=pvZWiOCZqmt8NriQlDcosjy523aHuDwspD8xy0vi1VhAjOtL3hEEOld7EiYTfpOCCbRQtXtQxhOkmuavBm6KU+/UBeyv9lFV6XlQ46N0zaxXRTE98XmHNWrtd+Vv84pZTK2X5RNbl57v3Wm/AvA8xoO0IkeykGtin9AUD9ZpJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227910; c=relaxed/simple;
	bh=hrsKWnTQ0PNsXbMEb/LIFyMTwebl1ydbZtBV/7P/jbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwLclyjQ/14tS0p5GGIn3CmKPHXEQY29JmOgy1nkxqCVbcDUseUFEGbybzraURLnT1pdOutZctRhGbsEJJ9E0G3tT76MHXXE8PPjFcMM42ye1UqKgRwDj2DeEL/HhHjM/w3tB1v5hvdvYjfwzL7mqNFNib4xj//pVvFjuC0W3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1b2fAVN/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UfJzu2rGQb0UJch70VQkkTuugIH/dfMRyWL6+VWVqYQ=; b=1b2fAVN/SceLIEOd52yVXTzMnP
	fqW2tIlsbQF6tDLTCpHFL58XDvBuY0HA2t1m72kX3qAoWTOWo36OZsO+39Bd86dHy3CP2ZZ8rQNbb
	2KvIuXF4lG0b3/bv468u3cxZ87v/F6EcRnifhqbEIq3S/p+ich3x/mvHY38hyRJX0ISA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzLOZ-008sHr-Iw; Thu, 18 Sep 2025 22:38:23 +0200
Date: Thu, 18 Sep 2025 22:38:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 02/20] net: phy: add hwtstamp_get() method
 for mii timestampers
Message-ID: <3e9e7c36-cadc-4e00-ba62-e224e805b0df@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIb0-00000006mzE-03Vf@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIb0-00000006mzE-03Vf@rmk-PC.armlinux.org.uk>

On Thu, Sep 18, 2025 at 06:39:02PM +0100, Russell King (Oracle) wrote:
> Add the missing hwtstamp_get() method for mii timestampers so PHYs can
> report their configuration back to userspace.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

