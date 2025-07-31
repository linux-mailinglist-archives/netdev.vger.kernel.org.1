Return-Path: <netdev+bounces-211119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E20B16A1D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7253AA3F8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8137F477;
	Thu, 31 Jul 2025 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZP0j/Obd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD03C3C;
	Thu, 31 Jul 2025 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924847; cv=none; b=Uqk58ZcUcE4LIfo/mwQYYIIv/F0XddMP11iJ1+smNEgv9JG+MT7U+VM92YM+ofPtHUEcryEDec0vWf4waNK332FDq58HxFOUlGVXD6BoBwHNDgz+gVEFhNgbxwcfFiAMj1/oyJL3Yc+jYCANWusaIRWGtiDX1mDWYPPeaTUGyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924847; c=relaxed/simple;
	bh=exdqehG6S26AsJO18p2l4bnLA/RP9WKhT44s/JptwDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXSxCwfwZSb/NjMnJgmfRUZjQwQD/2RKMAbaqJGmOTLTzHalDYTmTJScuGnQBWYyhODzH6RXwo1vM0rQALdWYU7yRqw1r65++v2Wr85qNlvAIVawu5GsmES4zVDFkj7LMWF2+cHDhM+5kzjRdNHTB4EP2eRl/OMOz9xob+S7MrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZP0j/Obd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=exdqehG6S26AsJO18p2l4bnLA/RP9WKhT44s/JptwDc=; b=ZP0j/ObdwcNC4neV0D4hiSlDD7
	Pmb/mcjUL2zfAMaBD5N5eP76L63kvR4ragns7dfFq/VfQA39iaVsWVIwk3pgjAYHjcjgxrGaxQi/7
	n/mduFhxjg+r/PLwaL5Imc+hJhBm4SdlV3YCZ6htEKedddsQAGPdeTDPxRjlAVHpWvWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uhHyE-003KO8-PY; Thu, 31 Jul 2025 03:20:34 +0200
Date: Thu, 31 Jul 2025 03:20:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Csaba Buday <buday.csaba@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
Message-ID: <78797ee3-ccee-4133-acef-a847e5b244af@lunn.ch>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
 <20250730181645.6d818d6a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730181645.6d818d6a@kernel.org>

> Andrew, you acked what I'm guessing was the v1, still looks good?

Yes.

