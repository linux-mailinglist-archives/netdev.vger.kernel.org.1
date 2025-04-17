Return-Path: <netdev+bounces-183888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6AA92BA5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE82E1B6516D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2791FFC4F;
	Thu, 17 Apr 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ivbcAs0e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112BA926;
	Thu, 17 Apr 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917697; cv=none; b=u8MTc2OFVm/qELqgHSB+N1NNlk8jocjFGl+a71UQy56KNIftFSBRTpMhN4Uhei5JY6wIUAvsYNU+ZoKmo0qSHysgbt0/w0eyxKPhwiMrJGiQmnLaPhTMUCRalp3KYNVIzcWuhlV7v2kCp3zx7AClxMCIO2ACUm30eKa8TWSArz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917697; c=relaxed/simple;
	bh=S8dLOsj0JQS/K9xCZ6WOy1r+UdtN9mec32qE58CjvCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV4HkWU4hCU67ytiO8i7xI+/Rep0KONLjguerr9WM6rx6njmoQ0TXg6J0seU501oJKasY2le++wThtgNdqwR7/6lDxMHGjr66IRgAelxXYOVKHfwxmmTU8Evvrfo4oPdyqLUHuWdg2UKg2aJSiMuY64c1+V+JXtc3G3EdKKX2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ivbcAs0e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fg2BJXRb6S31qKrgfk0IRXZ2sI+nMSB2CJWe2sxF3Ac=; b=ivbcAs0ektzTOXoU4fr3v+s6n0
	Tu9qfSHBhDBO58pm3o8Gzmy1iUmpaQZi6JwIFYEhG6NVJ4sTuYoX5rKfptzFWBdM7mwaiPvBJEx9O
	qGCMNknuOyGb5KD/dBSZwgOFC+o41+ixwIHuh5uMzy+JEf2VCETZhe8K2A4YTcjE+Vws=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5Unc-009p4j-8a; Thu, 17 Apr 2025 21:21:24 +0200
Date: Thu, 17 Apr 2025 21:21:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Davis <afd@ti.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v3 2/4] dt-bindings: net: dp83822: add
 constraints for mac-termination-ohms
Message-ID: <4e69a33c-56ee-4712-8b01-225fdfacee07@lunn.ch>
References: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
 <20250416-dp83822-mac-impedance-v3-2-028ac426cddb@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-dp83822-mac-impedance-v3-2-028ac426cddb@liebherr.com>

On Wed, Apr 16, 2025 at 07:14:48PM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Property mac-termination-ohms is defined in ethernet-phy.yaml. Add allowed
> values for the property.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

