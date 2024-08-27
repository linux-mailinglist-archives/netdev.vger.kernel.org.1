Return-Path: <netdev+bounces-122316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E982960B4A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A88328421E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C59F1BC083;
	Tue, 27 Aug 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MtoYB4CE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685E1A0718;
	Tue, 27 Aug 2024 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764037; cv=none; b=nVGcDjc9oPBSM/aKBoD1Eu+5zCU2qwxeILqK8F8zuqelHsl+LKNk58J6DqQMFQkLKSdqeV3WrwztuMxubyKTS7NyWVSsVHjF6Xv1y+IJycl38UWD8AiOO/V5Qrd5e6aW+ep3hxieHwqUYHXuwN7eIdmTbMkHQtoLMTWivyjE8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764037; c=relaxed/simple;
	bh=P29IpYf0a6mkkTpRKgKHvuLkICMiNlUEATtAL79FkVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggwkk2j6i/YLpg70SE+waGo5Z93ss9S/i6UFJy1fhfBzQJX6MmlbpVkisDfJb9Fia2D24FogN5PmCB6TH5B6mMtoOsdGYM9ZMoetBlOaq0vnMQxxaFDd9gtA0kZdh9tA1Lc00e0A5kcwSzWK9s3wq6VNyy/HyWGcZqp6GmlcaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MtoYB4CE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7foC1bo4fBh9WFMtbAOc+JE5/1vrijy9CqGRy/QHvPw=; b=MtoYB4CEeqW+RUpy/IeIPuxTUf
	3YUxTajP3OKsmXyUxnundUik3PDcZ8evNCNX4yLEQL5Dp73w8XRBZ11ky6Oxct54k4byH7YWYW/8B
	6wi8KZ2NiYOuDiYdzyXyiGtmsNpVc3Jc9qfTTeYD7Dasgqwuqe/gJ4a5anSPp5o6K7D0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sivub-005otn-MO; Tue, 27 Aug 2024 15:07:05 +0200
Date: Tue, 27 Aug 2024 15:07:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] net: dsa: microchip: Use standard regmap locking
Message-ID: <8344bcc0-6526-43be-b460-b5356f2251cd@lunn.ch>
References: <20240822-net-dsa-microchip-regmap-locking-v1-1-d557073b883c@kernel.org>
 <36f312eb-150e-4497-84f0-6bfbaab16d9b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36f312eb-150e-4497-84f0-6bfbaab16d9b@redhat.com>

On Tue, Aug 27, 2024 at 02:54:52PM +0200, Paolo Abeni wrote:
> On 8/22/24 21:53, Mark Brown wrote:
> > For unclear reasons the ksz drivers use custom regmap locking which is
> > simply a wrapper around a standard mutex.
> 
> According to the commit introducing such lock,
> 013572a236ef53cbd1e315e0acf2ee632cc816d4
> the ksz driver family one regmap per register width (8/16/32), accessing the
> same set of registers.
> 
> The locking implemented with the code removed here allows serializing
> operations using different register widths.

Just expanding on that, here is the full commit message:

commit 013572a236ef53cbd1e315e0acf2ee632cc816d4
Author: Marek Vasut <marex@denx.de>
Date:   Wed Oct 16 15:33:24 2019 +0200

    net: dsa: microchip: Add shared regmap mutex
    
    The KSZ driver uses one regmap per register width (8/16/32), each with
    it's own lock, but accessing the same set of registers. In theory, it
    is possible to create a race condition between these regmaps, although
    the underlying bus (SPI or I2C) locking should assure nothing bad will
    really happen and the accesses would be correct.
    
    To make the driver do the right thing, add one single shared mutex for
    all the regmaps used by the driver instead. This assures that even if
    some future hardware is on a bus which does not serialize the accesses
    the same way SPI or I2C does, nothing bad will happen.

Also, adding Marek to Cc:

	Andrew

