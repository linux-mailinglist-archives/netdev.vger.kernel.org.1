Return-Path: <netdev+bounces-150474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B950A9EA61D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DA9282748
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33881208A7;
	Tue, 10 Dec 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VPEoLKH1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE98F6D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799672; cv=none; b=hAYgxph84FO2+H5AG+OLsyV6NjTaSVi+G+vpLH86T+a4m8OAIdDvVOcmMByszm87GiyRXNeXcYhx9+92oK1e6oXmY4SZxM6RD9DYwcmEQ1ICq+Ga+No9UkEreG2QXfF8NNDfWue6d5sPCgdWs5Bfhy/Q0e1IX8kMBqlTINlMnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799672; c=relaxed/simple;
	bh=OUxz+8N8HolIkCVbP4meZ8ox4OH9Zm+H0Gl1KkOtanM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CauU13PRYjmm1/K7b/UeCJDrdURh1/cswUIDpK3eJ1icupFpOwBQkqS65/bWJxKssewU3vLazYh0/pHCICE+xvn4PMlSNMWYdnAlP7CtOdmiJIkly/yLvLHmrMmx0eY4uJJ9+1S8fjwtOgETxBA61PPsbGiQqEFcWNHolxfpdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VPEoLKH1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zYjEtRxgWtrT5qvuV3HGN8YuCHCirlbaVBLPNEzjB1U=; b=VPEoLKH1rsq6no1k9z0rmoxNy/
	MJeaTd+QEHorNj8CW0sMmoIAuDqBuh50kCjym5fcdovaMtvisdsTOLlCxcqS0HyAIkXZCd9XbB2ZY
	zYT5QUqS96orVBpgu7679LDPj/EZNDSq2S8vkkqTDQrCOIXvgY40vimxvLB9J3BQ+X7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqUd-00FkQW-Sq; Tue, 10 Dec 2024 04:00:59 +0100
Date: Tue, 10 Dec 2024 04:00:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 02/10] net: phy: add support for querying PHY
 clock stop capability
Message-ID: <df1bf4ed-61a7-4776-8189-f06b644fb899@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefT-006SMS-6y@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefT-006SMS-6y@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:23PM +0000, Russell King (Oracle) wrote:
> Add support for querying whether the PHY allows the transmit xMII clock
> to be stopped while in LPI mode. This will be used by phylink to pass
> to the MAC driver so it can configure the generation of the xMII clock
> appropriately.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


