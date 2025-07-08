Return-Path: <netdev+bounces-205000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA57AFCD6F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C85F7B634F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89832DEA7D;
	Tue,  8 Jul 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R0KZdfvd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DB2DC35A;
	Tue,  8 Jul 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984359; cv=none; b=aurzUk6HKOVuulHZn9BkFAQ/xvZ195vxJQoC0Xx2YkQk51g3AZE1H+bFXr77D0q9r3IygOm9SmGvlkdTRs00ksURJ8WJyqPMHll9uCIIoERz41QYQ/RGLPz4WfPvEGsqv/Y0Ts4OMUfHKUjc0AgNk0nXnO40849w+FuvQTicdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984359; c=relaxed/simple;
	bh=Jj8Xt+ouMAaUyTZJTQrBeGraUVAo6bKT3UdYU7BhWa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmt9tGRAAhGp6iB9FUHwVRpcO9YQdBJGnLiQujpklyL7PuBkZIH4IXKfBtN48485cLRs7AG2Lh/ESH+tl/TN06wyF4m4VfzskVIC48DP+BSkicKTV3dE/oNksFjV4/Av5FMV+Iive2nAkU94pqcPGegP/SXaJ0L7H1dhzgpAMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R0KZdfvd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vVQp6kue+tfmKXC12NCJ5Th4LJZBp0FktkaqvXHBrEM=; b=R0KZdfvdPT6Lb0KhTh5asTVUwJ
	IeraG3Y0Ur2qOsKwOCXeWbBgCZkGYJbbkTojzQwQeQooDqYkYgasYaMSoRAiClJOtz6dUp2KtUA13
	JiT2orQj+FajaRSzhPW4+XqaQ7gdcbyn/83mHSiLXGv9TWgM1X54Kn2sOedJRqk46JGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9A6-000pO1-CZ; Tue, 08 Jul 2025 16:19:10 +0200
Date: Tue, 8 Jul 2025 16:19:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6 v2] net: dsa: microchip: Write switch MAC
 address differently for KSZ8463
Message-ID: <ab236265-199b-4f18-91d0-d83510655f68@lunn.ch>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
 <20250708031648.6703-6-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708031648.6703-6-Tristram.Ha@microchip.com>

On Mon, Jul 07, 2025 at 08:16:47PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 uses 16-bit register definitions so it writes differently for
> 8-bit switch MAC address.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

