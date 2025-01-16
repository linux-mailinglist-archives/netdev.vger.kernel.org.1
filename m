Return-Path: <netdev+bounces-158806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2482AA13546
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D47A3A4C8B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA617198E78;
	Thu, 16 Jan 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h4cuNtj2"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B210194C75
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016077; cv=none; b=NmiLhqTXuortZQw8/eiTga4/ku4HwhdhZbH/TtU+0IXsRhCRvoA+O3QiuIcVq5fmMF8bvrfdXzldM85QFaXu5IZgTf9v+lP8FBlUFUaIqRJQnZEgAnIwWEfvbzmdec/u/uG6qX7AmKa3DyO9ib/dVnnugkRJC1V2uu0XP18zRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016077; c=relaxed/simple;
	bh=JNjXT4EERlyiYexCPZkKAYKKFMMi01JlV2wgfasKET0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAUi+3i9kmuHW11L0izf/TwX+ov1X+aSsD76qw3Qe9saYaW/YQLSLKl387DpEaJessyhsdY9rPSql3hbrtmngsyRGhwKESxYxFoy6PQWMg/DzBiRYlOHxbEKcn8aQ9mc7JWJuV9OzNKkZQkJmBi9t32PS0FgmNVV58JawvLFoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h4cuNtj2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9213FF804;
	Thu, 16 Jan 2025 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737016073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMMO4I+XOjicEs5GOnQABU5X5tsmLYQ+6VrW28JvHQM=;
	b=h4cuNtj2wuZBJ25fhPMZnM2MQBVVazS1TWD82c/CYS/Z8CDdBBb2/LIjQwokQdG5kpiBY1
	sx0hPsvV0uFsTD6zMzIpb0MgMXjLQ5fohkPFWaqbawQWndJ/7UfjfXH43vXpqyZb6CGYh7
	Y/hmmduxAphLn1XA6AAo1oaPRhdAIk2Fd5emW1LK+QV7fM1Wy/O2AwEVrcZds2SHxltBkW
	XIBrremK6YGd1wT5kQBC9sn9zQUDxvU7pMl4p6gaHnEFW3Zf19Qgy6zlCuZ2lCJWStHYRb
	8LjX029NzekFIAcGyiuDZS+L2sDoLBKp1ECYHlideH3+0OUJ6cAOeQXYpoXsXQ==
Date: Thu, 16 Jan 2025 09:27:43 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 6/9] net: mvpp2: add EEE implementation
Message-ID: <20250116092743.34ae7dad@2a02-8440-d117-22fd-0cfc-7753-7eff-f472.rev.sfr.net>
In-Reply-To: <E1tYAE0-0014Pz-R9@rmk-PC.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
	<E1tYAE0-0014Pz-R9@rmk-PC.armlinux.org.uk>
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

On Wed, 15 Jan 2025 20:42:52 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Add EEE support for mvpp2, using phylink's EEE implementation, which
> means we just need to implement the two methods for LPI control, and
> with the initial configuration. Only SGMII mode is supported, so only
> 100M and 1G speeds.
> 
> Disabling LPI requires clearing a single bit. Enabling LPI needs a full
> configuration of several values, as the timer values are dependent on
> the MAC operating speed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you,

Maxime

