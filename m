Return-Path: <netdev+bounces-224165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE471B8166D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC191C26C44
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBD3009CA;
	Wed, 17 Sep 2025 18:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A518D656;
	Wed, 17 Sep 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135509; cv=none; b=XM4J2JizVMGOb8/y3y2UCWxbnnDwYrYlwftO4Tq6gSzGy1TCigfjtIk3XJKdwJqv6KX6FUVBqMxTQ3OjaH5N68/YVarIwCt3HmlRTuQgJ39laejPm0vRVINIrZhBt8iKv0V3C/se/C3QQqD8yk4WRD3oklYOTSToRldga5PqMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135509; c=relaxed/simple;
	bh=UJV1axYFUWahAo/wlw4bcjdRchM59PcQ4RAHtgD9ZE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNNBctYGQ13fkxzEFK9AL44uhkC3t/xHpWviJMhi72NdY1YdG2MF7uBQv44+m8GbKvHQqY7Q3Kl4O/LKSpZwxINLkfe/L5JFBuzRrQO+paYPRdFLyog3DiPrvpcjtTLNRTuoHCvhSJzvzAgnfmniQxysbB52OBv+7R583c5QFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id ADCA32C0163F;
	Wed, 17 Sep 2025 20:58:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7CE07149290; Wed, 17 Sep 2025 20:58:17 +0200 (CEST)
Date: Wed, 17 Sep 2025 20:58:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hubert Wi??niewski <hubert.wisniewski.25632@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <aMsEyXPMVWewOmQS@wunner.de>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917095457.2103318-1-o.rempel@pengutronix.de>

On Wed, Sep 17, 2025 at 11:54:57AM +0200, Oleksij Rempel wrote:
> Forbid USB runtime PM (autosuspend) for AX88772* in bind.
[...]
> With autosuspend active, resume paths may require calling phylink/phylib
> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> resume can deadlock (RTNL may already be held), and MDIO can attempt a
> runtime-wake while the USB PM lock is held.

FWIW, for smsc95xx.c, the MDIO deadlock issue was resolved by commit
7b960c967f2a ("usbnet: smsc95xx: Fix deadlock on runtime resume").
I would assume that something similar would be possible for
asix_devices.c as well.

Thanks,

Lukas

