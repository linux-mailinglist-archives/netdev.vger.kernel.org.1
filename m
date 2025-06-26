Return-Path: <netdev+bounces-201439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27DAAE976A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88D01C2825F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86AD25B677;
	Thu, 26 Jun 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oFv1FQMD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618623314B;
	Thu, 26 Jun 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924951; cv=none; b=HyN87RT/UwF3MxFktd4STAKk2dWxb3fclkIvtddsqG2bOzOCF7XGhKVfaUPLCGtnUgSp5hUa+PE9AVbiAvMlcWwqJb7/sT3DdXN3k3RD+ie9kdyFVqboIFCc7yGy3bWVp6+P/cGRvFVM9DqXhs7uRDy90BrW7fuTDnM1N201qiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924951; c=relaxed/simple;
	bh=cEaC6+G/sN4jozSX9BP1ZCCBNnJkl7knaZmfoplO16E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4aY97ELNW6CDkDzWet3kTDSDYyKdC/+9AZZ1kjTqDdBXhZNrRBGGL6Pubzh9jmZpK3ZcvnGutIn/SVgLhPsJukTZltuKQBvYLNU8Ex3sOB4zXz3gkZbdJ1M1jaVZoGON30KCbPkZV0f7dBV7ds99r+CFOzvLbSgRJ7qCWjuwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oFv1FQMD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3dQ8YaRlPH8leheSk/R4RK1kv8p6nuXuYIhHCLiJSfw=; b=oFv1FQMDH/Tz+OBC5qChk1l6P8
	395y1OId5p42efMwHjjuhLS+fTIwrfsZr0q3lel7P1LDJmcOCanUL/7OwfMOVOpCxnc7PUy/SV1WZ
	GVa9D42034UJKVeUwuZ95YySR+iURF5IkFwxbumR7mplKUSOGgV5mhDIHk3LsGoCiNg0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUhYg-00H10f-Vs; Thu, 26 Jun 2025 10:02:10 +0200
Date: Thu, 26 Jun 2025 10:02:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next v2 3/3] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
Message-ID: <c954eabf-aa75-4373-8144-19ef88e1e696@lunn.ch>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <bc112b8aa510cf9df9ab33178d122f234d0aebf7.1750756583.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc112b8aa510cf9df9ab33178d122f234d0aebf7.1750756583.git.matthias.schiffer@ew.tq-group.com>

On Tue, Jun 24, 2025 at 12:53:34PM +0200, Matthias Schiffer wrote:
> Historically, the RGMII PHY modes specified in Device Trees have been
> used inconsistently, often referring to the usage of delays on the PHY
> side rather than describing the board; many drivers still implement this
> incorrectly.
> 
> Require a comment in Devices Trees using these modes (usually mentioning
> that the delay is realized on the PCB), so we can avoid adding more
> incorrect uses (or will at least notice which drivers still need to be
> fixed).
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

One question, how should this be merged? The two DT patches might want
to go via the TI DT Maintainer. And this patch via the checkpatch
Maintainer? Or do you plan to merge it some other way?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

