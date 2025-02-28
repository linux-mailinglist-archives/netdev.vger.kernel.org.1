Return-Path: <netdev+bounces-170798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A97A49F1D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37F417200F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CED27427C;
	Fri, 28 Feb 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EdHJEaRj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406A27603D;
	Fri, 28 Feb 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760824; cv=none; b=hHWHo8GPxDc7v+jwp3A+Qu7YeCmr3YDzix67MCG7HdYXU5kbm1W2He+6wecsS+H8Mrt0T6gpUiH2ttXhj9AER6iheCAIrIvHokB/cXK/YwiwfqicvlUQGe/LEzvGnTbyqM9mf4mO0Oiye1krbN63LyX5DvioswrLddXJy1p6j34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760824; c=relaxed/simple;
	bh=K9aSTy8FSVD1T4fpnYk/tFhdx9lSIaAaRt8Vhp0R81g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOcB37B9YLXfqgzfGzU+cBZUqE2GxJoRgMaTd/cTBswagsmKOJBJa1WRBeNdOGxxBufCzC8ZvN9ssgaKjYenW4Kjdhy4Rm8H3mHr5yvLbQkB8iYwFt9QR+a6xPvMvnQIRXRKGCBE2CEI2FZ2sSZ1msuPjk/BfoBDXC2aKUB2YjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EdHJEaRj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JgWas+pjyab7368tygv7JSgqIDdjvdgqkYNRCAidMPM=; b=EdHJEaRjOfayTy5TqZBAEz5npl
	1db+/ymoVnP7EjBnnWsdsbKVI0J+/peN0f9x+7lLBlJgk18r/xh+A/Ay/vfg6dbeDasJqsVOW+UJq
	0Fr1fh3iyLgfhW4RbIy/FAhR93+pnhmRNe0ao4Dmam/xwF6UQH9Adqt+VBuHWqauAXzg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to3PL-0010Ro-E1; Fri, 28 Feb 2025 17:40:15 +0100
Date: Fri, 28 Feb 2025 17:40:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] net: phy: nxp-c45-tja11xx: add
 match_phy_device to TJA1103/TJA1104
Message-ID: <24095305-7eef-4b70-b9e1-da853094aaf7@lunn.ch>
References: <20250228154320.2979000-1-andrei.botila@oss.nxp.com>
 <20250228154320.2979000-2-andrei.botila@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228154320.2979000-2-andrei.botila@oss.nxp.com>

On Fri, Feb 28, 2025 at 05:43:19PM +0200, Andrei Botila wrote:
> Add .match_phy_device for the existing TJAs to differentiate between
> TJA1103 and TJA1104.
> TJA1103 and TJA1104 share the same PHY_ID but TJA1104 has MACsec
> capabilities while TJA1103 doesn't.
> 
> Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

