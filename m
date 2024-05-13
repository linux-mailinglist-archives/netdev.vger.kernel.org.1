Return-Path: <netdev+bounces-96095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87248C44F9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B65C1F22BAE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F2155346;
	Mon, 13 May 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lHjl84Lj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3814D2BF
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617132; cv=none; b=pPFEaqAA+EPwLL4YpZaZGRC0FUN67FeqtKA8LDXcYsx/vmTHRZR1I6CKDZC/jj1PznIIpRlna5QZh5tzVxjQqw3M0atR9eCfg4aEdXrTjk72g3Y98J1P5HtnOjvxKgKjFdqLRSzryuZcduz1/Al5XYVw59LjzeoCahXXGAqBHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617132; c=relaxed/simple;
	bh=CnS9FqL5LrbgJkm8AmpNZYmQWxP4jGC5n/4SRfhWDsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWLeR4lnc93p5RnSJBQ5nzbOg2w8CLfTDKe8qrVtraGjX/88sAlldREwP9eS8qvGZtMMe3nRJzrAn0FcyAlpx2alxtsbsb/83qATuL2FjgRgvui3pN2/62L9yY3gMG8O8lHJF35IqzNzuwxDBYfdNDiUlygdwH84z6+8bhgw/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lHjl84Lj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0tNIQjsmYkdzhmGuF/RCaMmQSD/ykvXPJhs95LZ7j2Q=; b=lHjl84Ljy3v0GarseFICY9YVBk
	+r4BXZH41Zfr6avjW9qEs28xPiFWiCbToRQQfRvc7duOpQShuHLkKlOhbejx4FKCwuiVUy7UcXalX
	xGkF7UafTmXvVqYHOpBv2V7hzbAp64sPOyyW9HiDwbDkJIHe/A2tiW5Os8fQgVBFN4Zs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6YNx-00FJvS-Fh; Mon, 13 May 2024 18:18:45 +0200
Date: Mon, 13 May 2024 18:18:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: pcs: lynx: no need to read LPA in
 lynx_pcs_get_state_2500basex()
Message-ID: <80b7a791-edfd-4931-a89d-b4002df4faa7@lunn.ch>
References: <20240513115345.2452799-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513115345.2452799-1-vladimir.oltean@nxp.com>

On Mon, May 13, 2024 at 02:53:45PM +0300, Vladimir Oltean wrote:
> Nothing useful is done with the LPA variable in lynx_pcs_get_state_2500basex(),
> we can just remove the read.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

