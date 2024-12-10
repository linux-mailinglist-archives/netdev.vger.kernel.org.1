Return-Path: <netdev+bounces-150655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22E9EB201
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD18C2894C7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B51A0BD7;
	Tue, 10 Dec 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C8YmAVMK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456723DEB6;
	Tue, 10 Dec 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837733; cv=none; b=epk9nxKeYzZ9kJMJRu3zkugYu2OUKxW189BM411cMw/TOWUvq7tk6yEvHVg6XSlLr2BHI7agONcfsbkOP7B7QoPVsqUym3iEJysoThsg8R3BezTQTxf5yVY78p8ec3iiYGts+eCmqQKqXPgVxOZJcss/nU+Z1CZqV1cROKSiNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837733; c=relaxed/simple;
	bh=KSb1CsrkqC3wYPbKN8cfL6z4QkC5xeYcGVFKvtDP/Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPWLOIW2XgxbzJgQschEULOfKgbPJnlhExhw3/F5xmC633LVigBKnigT7lSHh8HkGcCJ8wqWmmbaz0qGk739L6apHha4GL2I9UkhgE4norjSGqKkQo1Bh5hNUga1JbFCdSXhYh6fD0fSgrEejQCty9E6zbFSjGG5MscCfLueCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C8YmAVMK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SkIzBj7XqUW6X0EbObqOqOtk5PpRyAk+LhCPP1Kn5N0=; b=C8YmAVMK/nQMB1dHTKVmHjpPnP
	fPB2dkyBmS5TvAma9EHMgf+tMJEMYpWdpV5g9Ezw2I9BcaKGZIZlLyhrrL+HMeynLDuj/5BDeO2Iq
	gw7RGgQqrXRGM+wGi6ZS3zzEh+oojV+7oSl4DFYLyON20/4LeUhiKPtBr6cWj2YrC0VM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL0Oc-00FnvD-7L; Tue, 10 Dec 2024 14:35:26 +0100
Date: Tue, 10 Dec 2024 14:35:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
	Marek Vasut <marex@denx.de>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Improve
 example to a working one
Message-ID: <dfb09395-78ce-477f-bbbc-747b0a234d4f@lunn.ch>
References: <20241210120443.1813-1-jesse.vangavere@scioteq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210120443.1813-1-jesse.vangavere@scioteq.com>

On Tue, Dec 10, 2024 at 01:04:43PM +0100, Jesse Van Gavere wrote:
> Currently the example will not work when implemented as-is as there are
> some properties and nodes missing.
> - Define two eth ports, one for each switch for clarity.
> - Add mandatory dsa,member properties as it's a dual switch setup example.
> - Add the mdio node for each switch and define the PHYs under it.
> - Add a phy-mode and phy-handle to each port otherwise they won't come up.
> - Add a mac-address property, without this the port does not come up, in
> the example all 0 is used so the port replicates MAC from the CPU port

To some extent, the example is for the properties defined in the
binding. For properties defined in other bindings, you should look at
the examples in other bindings, and then glue it all together in a
real .dts file.

I don't know if Rob will accept this patch.

	Andrew

