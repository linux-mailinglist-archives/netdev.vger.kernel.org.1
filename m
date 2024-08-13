Return-Path: <netdev+bounces-117967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050B9501C6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22D51C21D20
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB8184547;
	Tue, 13 Aug 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVrXI/+E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D343165;
	Tue, 13 Aug 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543038; cv=none; b=NxPZEngqavnyMP9OdMgB6WV0a7bLvH/U2Z2eW2zAcj6C/WBM9BD0syn1ZjKEHf36xzDJnsYGeDzqTYH+vukygHSAs+eVLjkiVaKXYwH3bCO3xLK/Hl17sAq86b73HA5zDA2tPr9WvPamFNCuRMQ7joJUbWm3qWRmeAfOcbtf2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543038; c=relaxed/simple;
	bh=ZNnGkI0dGL0wSwGojEl+IOMHCQh5GYTMnNTRrFyWYgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RucKvOmMmVa1l3cJzH9RKeJrjiEQXhu9FaQPA99l4/tFgQU3JCJ0IZRlguF7jL1ZXWJwoWJrKyHAVCy2GzyfXvjjyRSQbPsHoOjnYspTizGj+5mxjoYnU3LxKKylX0CTdUTiXEFK52MbMwqgMmQJu/HpwOJR3AZSGNwuV45FU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVrXI/+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89931C4AF09;
	Tue, 13 Aug 2024 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723543038;
	bh=ZNnGkI0dGL0wSwGojEl+IOMHCQh5GYTMnNTRrFyWYgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVrXI/+E5X7qnh5hjA1pLVnFhqAnq+Td7ISZbwYxD87apof8YTewNMVs3Tbny5gZD
	 hCO38pZYN4HPQruS2mioTLiUMsEkR4TV6dGUiN4Gb7Rq9bAgjb283FF85PHyOEDvPC
	 THCEPndPQtiUAYm9R+OPcGOx7ig7CMOXxePXBOEI=
Date: Tue, 13 Aug 2024 11:57:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 1/8] misc: Add support for LAN966x PCI device
Message-ID: <2024081356-mutable-everyday-6f9d@gregkh>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
 <20240808154658.247873-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808154658.247873-2-herve.codina@bootlin.com>

On Thu, Aug 08, 2024 at 05:46:50PM +0200, Herve Codina wrote:
> Add a PCI driver that handles the LAN966x PCI device using a device-tree
> overlay. This overlay is applied to the PCI device DT node and allows to
> describe components that are present in the device.
> 
> The memory from the device-tree is remapped to the BAR memory thanks to
> "ranges" properties computed at runtime by the PCI core during the PCI
> enumeration.
> 
> The PCI device itself acts as an interrupt controller and is used as the
> parent of the internal LAN966x interrupt controller to route the
> interrupts to the assigned PCI INTx interrupt.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

misc device is fine, even if it's not really one :)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

