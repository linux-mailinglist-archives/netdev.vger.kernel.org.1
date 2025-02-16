Return-Path: <netdev+bounces-166803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792ECA375A6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107B716553E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A718199EAF;
	Sun, 16 Feb 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L3bYw1IT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC918024;
	Sun, 16 Feb 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722775; cv=none; b=aXQGMRlvH9DWBA8P1D9LHa3xrVgugglvMCdU7K2cVnEsQ+LPoZ1n6UUTfPSkwOWdUqiW69xmOGnNKOhP3LOvy/4L4AiLRyS0Jn0gkk3Uodbfb2ECBrdw59WxWkzUvhgv4cULfGqqikQDgxkh26GlM6TOD9XyTX+Hbi9ZMk1WiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722775; c=relaxed/simple;
	bh=i69Rxv/M0TlJhdvqOqvlHHUGj58LbWRvt4U1OKsIxtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjdDC7HOpdQmZ4f3DsAd+2Pw9WiOuD+FHZceNNnjehGyO/wQ/Nx+Lun8/EBdC4dIy4BO+vYuothN9qWPA+JaNmyU7sAGT5OJX4rbAQ8mYbXVG6FG3Cg2kI0hl6xk+04EWM13VuDsqP0n3bCEKnnGbiooZNnI3u6QGFRAFV4xosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L3bYw1IT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kd7X3GlD7l2NnFs2sFyauaR3N10qrRNEi52KigS/1Wc=; b=L3bYw1IT6EpF2nt+PswxXgve3j
	ZKckm8iHa6R27ERI/sgUqkpALquQmvpERDwP409NpuSrXCgM45qtaFbKefAQKwzBX/pWOkSYMl4s1
	GrLo1N/ST6Dlk9LB6t6KioZPoGGTHBQ8fgvguqcqt5cTmOaJssPl44NhyQ5xkSEOw8zw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhMb-00EhOG-5M; Sun, 16 Feb 2025 17:19:25 +0100
Date: Sun, 16 Feb 2025 17:19:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Message-ID: <62495f94-c3e0-4483-a4cb-d01c261903c6@lunn.ch>
References: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
 <20250214-dp83822-tx-swing-v5-3-02ca72620599@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-dp83822-tx-swing-v5-3-02ca72620599@liebherr.com>

On Fri, Feb 14, 2025 at 03:14:11PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> Modifying it can be necessary to compensate losses on the PCB and
> connector, so the voltages measured on the RJ45 pins are conforming.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

