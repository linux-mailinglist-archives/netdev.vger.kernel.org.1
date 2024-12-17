Return-Path: <netdev+bounces-152593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D79F4C22
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8021894BBE
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96441F75AD;
	Tue, 17 Dec 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="alPHzC+k"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFA1F7595;
	Tue, 17 Dec 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440891; cv=none; b=aZY6mPN27QmtU8EtZlvmebsTPV1R+plYf1V303mWwIDDwoN4XxtmZ+sqtd5Gry45pz2+MNYeufLgMkS4BLyJtR2IrBolmWguoMslwseGyptNKaQxMfgmuHPy6QmamdTAyjYISTcnzSlePPafbEIyndHLWjLDXwZYA0N1/zWp99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440891; c=relaxed/simple;
	bh=zVDVBp/0tiFwDjucvUFalT3y7kvUMX45Piw4+9RXvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDMfw2EHZMI8Gb2fKmxLdRUg+nRKmhYj00XcdeDQPRyKxsxy0SL837rJ2jjq4Y+URqk7C+m89WtPrLfLtm3BL3k3a9nFXM1mnGjrIB8iirg1q3XF5L/rV34llU9aoPRfuy9yVWuDadhxbA1P1QCJd5hYfTjUrWEGTAKDsQ5kreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=alPHzC+k; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B8891C0007;
	Tue, 17 Dec 2024 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734440882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGAKh4uQmxyCz+ONct7STH4pqwnEOwd9rXKztJGQ6eM=;
	b=alPHzC+kEBAXeMxkw7OEuP9IdA3kBU3r2Rb5GW4yE1rT/TChwLzGLo4Xdwx/P41KkF/vrK
	PyQE+QpDcJhC+9m3y79M5XXEnNeC153Vs1Gy3gZPYHq1qD5EJQame3J1prALwYpweHisav
	16GwlgEyaqQolptM2PoIlpGetRg+jOvCfDkjAbQjynmxUhCtSTpdyaM8nmFvXXRm1N4LIY
	cEK54Bw91/kWgIoZyMQV7QSwFJAwpz2bzKg3SI4c7cglAv6K/o3SRQNssfJy2o1PBWuqDQ
	rNAX7oBvndjFdgs2aHbAjku/XBsypcln66sRityxEssNHoDv3sdli4CZu8pGoA==
Date: Tue, 17 Dec 2024 14:07:58 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: pcs: xpcs: fill in PCS
 supported_interfaces
Message-ID: <20241217140758.747c329b@fedora.home>
In-Reply-To: <E1tMBRA-006vaY-Sv@rmk-PC.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<E1tMBRA-006vaY-Sv@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Fri, 13 Dec 2024 19:34:56 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Fill in the new PCS supported_interfaces member with the interfaces
> that XPCS supports.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

