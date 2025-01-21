Return-Path: <netdev+bounces-160050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3227A17F55
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F523A706C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166501F192A;
	Tue, 21 Jan 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IodizcoT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057354765;
	Tue, 21 Jan 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468166; cv=none; b=bVqek8SqkwtRkLsDwBuq+LkIVpm57okXZ+omw65H6y2awV/Zgi1kcZTtZZOol3EvCH6esNEuxXuB90m550hrV42MeGN4JyHd5N99b8ydDdDistIzngd5GSSaoe9WyF9vEvtNr+WRJ8G5wMbbqyAS9R0GBU5ZtQFqZZ9SqyaUqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468166; c=relaxed/simple;
	bh=t98D4s6bBXUbrTynpeDozs4iloBf2qil5LWoRx3Nd3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFTUsbDEYaHiNSPxU06sAlpCKUnMfxmXCS7e0FZ/zN6rc18UTxUXy0gAsZ4gCUHdZUZ0c61k2I7Wl1o1baPlW2I5XKsCfzKRebA8cLVp5nguqMH2ZSzC4vb8WEa7G4FU6t5r3x6A0hMtM57pbw73kWC7S/e1Sfk4L7FNST5H5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IodizcoT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+xByHtGpmiYEt5VTgj/OB4PKLKwLNhBfuz1wNDbb7Y4=; b=IodizcoTNecwFi6PuHUId1YthA
	5ybgPJGI78cXluTfbVp19cba2ykVpc+09pkt6/Z1FEUKl5WBdL4BpSn/9mHPzj8TyMGHfs4aR3Dvq
	LZ9jzWj3dbiy9BV8zQARkez0ccRBFgXtevepFZ+GKC/tQxPa9FzArEr/fDteLk16RmDc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1taEpd-006eH5-Bb; Tue, 21 Jan 2025 15:02:17 +0100
Date: Tue, 21 Jan 2025 15:02:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Milos Reljin <milos_reljin@outlook.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrei.botila@oss.nxp.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, milos.reljin@rt-rk.com
Subject: Re: [PATCH] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
Message-ID: <0a81c696-5d4e-4e1a-a036-eee001b393b8@lunn.ch>
References: <AM8P250MB0124A0783965B48A29EFAE6AE11A2@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
 <20250120144756.60f0879f@kernel.org>
 <AM8P250MB01249EC410547230AB267A78E1E62@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8P250MB01249EC410547230AB267A78E1E62@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>

> If you have access to TJA1120's application note (AN13663), page 30
> contains info on startup timing.

You could summarise what the datasheet says in the commit message. It
then becomes clear where you got the values from, making a good
justification.

	Andrew

