Return-Path: <netdev+bounces-214155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0FB28604
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDBF566C96
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3E29E0E6;
	Fri, 15 Aug 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RzNwjMIA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AAA317714;
	Fri, 15 Aug 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283840; cv=none; b=SXokWGGWEBJo9AIt52Ab4tv6l5AGP89WjYY+7bqUSF7dsn+LpSTdWfl/3AHbCpy5b4//yUQYcayERUkeRv0orB3B+svi+UsgncYo0nnp5EC/xwBpeFFfZ5lF4bf89ukb3hhl/brBK/jrrJHkW9TMXfZfK3/JVt2nD2h3xc4e4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283840; c=relaxed/simple;
	bh=ahUOqBCDV0i3ymai3IRlg0wotZn1HH8vMD5mQmNJqog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtdq1ilotAtj8PjFaxbEGYQra5X8UsB12EK99LBd+Ubx9U1juzkbU7SZyaeX9AqlcBISjXZcwr/uL5kpi6O0bRyeVSgfPfK0xdrjXd9NxoCQ93ouNqhsYOuVGiXLBzkg4Yy/7Up9Ddn7oH7Gtm5esk/aWrjaYjJnajGNX85V6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RzNwjMIA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iu0DdN7wt+trCScaSSR6XDHfcmzH60E7l/MJwJR22tI=; b=RzNwjMIAA1zClN258rfnGOGzGx
	FGydthcWvyA4OOVryav2EozsamLMJq7kZgJFFTMOS+5MZ9Go+DWElIr4rg84bdVONnCYTTdhejHS+
	JnIQOIPJWfshBdQI28V6vaq0aujyMzSAkDsKir+2bry3ZoVpEA3W915ed4QLXxAuVlU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umzVc-004r0R-N2; Fri, 15 Aug 2025 20:50:36 +0200
Date: Fri, 15 Aug 2025 20:50:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 3/5] net: cadence: macb: Add support for Raspberry Pi RP1
 ethernet controller
Message-ID: <7264beaa-2983-450f-9f32-cfb22fcf8bcb@lunn.ch>
References: <20250815135911.1383385-1-svarbanov@suse.de>
 <20250815135911.1383385-4-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815135911.1383385-4-svarbanov@suse.de>

On Fri, Aug 15, 2025 at 04:59:09PM +0300, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The RP1 chip has the Cadence GEM block, but wants the tx_clock
> to always run at 125MHz, in the same way as sama7g5.
> Add the relevant configuration.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

