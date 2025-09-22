Return-Path: <netdev+bounces-225337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58535B9257C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A552A3B9B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19F312832;
	Mon, 22 Sep 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyLdi0ay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C72D739F;
	Mon, 22 Sep 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560736; cv=none; b=MQK9bGYJLM5/HfsWI8keRpajzqMuSa5VXZ6WxsD76QMHeSau0OUyJ0MC5zzBZnpLihjxPnouTdXrRH7OWtALp/RejtYmzc2RZBwansT2IShXugDEbZkkLne6A6fJ5mZbLnvwln174rvXWR9DM4y5UeD/papb2FSJ2W8VOFuwuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560736; c=relaxed/simple;
	bh=aB41Del3g0nOA+kFSYQYpkWIe9LOgh+neGwq9E8TZ/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCHmHNMU+33APaD7XFdyO1zrBVwuKOVxPHgORzZKDzJ0RI9r3P30jcHU4VngCRET+V6XvWiyWAAQjDIfAc2eb95EJju+JV6sD0lzDUObVDNAKdWSEkw3ioUXaeHNKvlRMMd/ax7Im3yWOi2pfILg4UCmHU/zr1hJVuzdfd3n+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyLdi0ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5240C4CEF5;
	Mon, 22 Sep 2025 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758560736;
	bh=aB41Del3g0nOA+kFSYQYpkWIe9LOgh+neGwq9E8TZ/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyLdi0ayT0aqVNMp+NAnnqmKMZU8LE/Z8pI+DgUCXRagaJXUQE8nzBE0zVj7a6/Ek
	 iz0b4gKpWMOKM/DmDDzJF1X9fIe6fGbg44ZJ7sereMMo8kRRqSJK7b3Klbe9bwVi1C
	 BvyQ7oZqfv4R/tv4F6BZHQHvKzTDjvthu9lAs6gSajdWyw0QRSwB5+jFF7VCbfpJT7
	 Y+FACemuaEeWt8jogzH1Be44PxCngu+YUCJI9SFzobW25FgBcY9qhU2rMOpuhw15yg
	 blZPN2eSj7PH5CptcE7u9r74WWbvb+isvaWIi+rpHXNLtebtSmzG/qpG2N5IQwwZE7
	 Jjz28vUQjzF6Q==
Date: Mon, 22 Sep 2025 12:05:34 -0500
From: Rob Herring <robh@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <20250922170534.GA468503-robh@kernel.org>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-1-105f5eb89b7f@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-wol-smsc-phy-v2-1-105f5eb89b7f@foss.st.com>

On Wed, Sep 17, 2025 at 05:36:36PM +0200, Gatien Chevallier wrote:
> Add the  "st,phy-wol" to indicate the MAC to use the wakeup capability
> of the PHY instead of the MAC.

Why is this ST specific? PHYs being wakeup capable or not is independent 
of ST. If you want to or can use wakeup from the PHY, shouldn't that be 
a property in the PHY?

Seems to me you would want to define what all components are wakeup 
capable and then let the kernel decide which component to use. I'd think 
the kernel would prefer the PHY as that's closest to the wire and 
probably lowest power.

That's my 2 cents spending all of 5 minutes thinking about it. I'll 
defer to Russell and Andrew...

Rob

