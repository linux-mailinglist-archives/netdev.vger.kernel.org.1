Return-Path: <netdev+bounces-203701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BFAF6CA8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15431881DB0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727672BDC08;
	Thu,  3 Jul 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wBDk1hXE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A401D9694;
	Thu,  3 Jul 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530798; cv=none; b=MmEer1h15pYp//Eum5CQnq8ZVPQ824s7OZ4uNQzPFhq8w/d1eGM/ZRbjcO1EqWupeG6ok6rOJcgPDnHXfMBmlkYyandtkdwwG4Zh6bZvsWkmxdvQ62Xlg54/TfbImdRLveeySxbXHLph+NccohUHhP+HrpPbkoQnbMNv8EOXd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530798; c=relaxed/simple;
	bh=4P6DcmQKOMjuHbYAtn5JewzrRX0ciwIvTfmSjx3jKfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR+4L9ET4Lk0kcDVZEHp9uJGJkXhP0Hp4PB2lipbEtJBINp9GmE41piXW1D1UuBH6h62rjhkj0BFCL9Pgn9AYDccSV8pgsRr9so74oqohOrZhLr4bb1XYCDaV0S3+GfZt8YtzwQQ1JoLeQ54Prh3DHdaMTTxh+tkxtUjSmLnEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wBDk1hXE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/4ehdOpzG3rPT6AGrEw+vVrqxugddJkP2hU9YmSDZpw=; b=wBDk1hXEhVm54H6DRSIHM1CyLT
	VKMzBhKuOCJGU83rblwdomASK9nrS1GmD62Buss7WMQw9qQid2X/KV6EpWKO2dU5WeajZbLOGv5RU
	Q5Ry7hgXkmCLGWxs8EPgkdB7QfTz+FHjjr8wo6neDeTOhfgwWs8lvUz9CPLuftJpeVss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXFAT-0004f0-NH; Thu, 03 Jul 2025 10:19:41 +0200
Date: Thu, 3 Jul 2025 10:19:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH RFT net-next 02/10] net: stmmac: Add support for
 Allwinner A523 GMAC200
Message-ID: <c464d56b-dfd2-4e8c-a77a-4a0d05588768@lunn.ch>
References: <20250701165756.258356-1-wens@kernel.org>
 <20250701165756.258356-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701165756.258356-3-wens@kernel.org>

> +	if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {

Please use the standard properties rx-internal-delay-ps and
tx-internal-delay-ps.

Please also ensure that if the property is missing, the default is
0ps.

	Andrew

