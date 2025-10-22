Return-Path: <netdev+bounces-231864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B73BFE04A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 533774F43AC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EFE34888F;
	Wed, 22 Oct 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jxH4hqN5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C962BF3F3;
	Wed, 22 Oct 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161006; cv=none; b=PEJo7uBJzVLV9KAiItqMuqQX8ieYQrSxV5elgVghzgpMMKBibeIp8tYy2QRgCFviZQiQ+xylIFSyf8biHGCHC2tA654mpDeMn8CMJcqWQ/wPXDnSZpkZpAlTJmjb176EKdxoS+oioCfuOmuoxxNxISX+/kKm9jjS2af6uCyijHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161006; c=relaxed/simple;
	bh=vMeoOM/0CnodmPJm0nG/wtB4KI/SrV2d0gCGhGF96RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHLrGDJfxGKPtNWOV1CuO+Jnp6V3/UG/jlCJTRLBkLo4VWiEVAFzP606Ry+kn/c1wJl/VC0Aenkjq8mjP90IvNtDCJNwlQnGJ4M60oVSrY+hBus3VoVDPuM2SZspvoNkN1kWMK8zsWHgQf9nYZTYZR1wMm4b8eA4ZPV0fx9GQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jxH4hqN5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=OF687Perng0JCDylsSDgcMvYfapUJmH/8i4CFhsx1ro=; b=jx
	H4hqN5+X5+hMYv8O2bsQ5x4AXt0gwwRtuY1pCqtdrNzr7qy4Ca66EsrRWKB85JAtPtg5sN86GEPiq
	FIuVEi6OumRZmeYvZfmjdx6XysgLNZn2njFuuD4zVGJIfxibdlAxbAbaQUJ/LrwzW5K9N4/eFMXgh
	xn3HgWEaLYriots=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBeQR-00BnzX-Eg; Wed, 22 Oct 2025 21:23:11 +0200
Date: Wed, 22 Oct 2025 21:23:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: net: cdns,macb: add
 Mobileye EyeQ5 ethernet interface
Message-ID: <4d8a90b8-b5fd-4c40-8c40-155ab1ba9211@lunn.ch>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-1-7c140abb0581@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022-macb-eyeq5-v2-1-7c140abb0581@bootlin.com>

On Wed, Oct 22, 2025 at 09:38:10AM +0200, Théo Lebrun wrote:
> Add "cdns,eyeq5-gem" as compatible for the integrated GEM block inside
> Mobileye EyeQ5 SoCs. It is different from other compatibles in two main
> ways: (1) it requires a generic PHY and (2) it is better to keep TCP
> Segmentation Offload (TSO) disabled.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

