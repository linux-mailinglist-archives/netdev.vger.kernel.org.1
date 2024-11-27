Return-Path: <netdev+bounces-147607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5939DA9B4
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D41280D4A
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 14:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE101FCD0E;
	Wed, 27 Nov 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V0m3y3rQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E36A8D2
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716540; cv=none; b=GrcZvjb/2F4SiZuY6gx18C0tPvBtZwuyBiD57ITHTyrw+usdVwcTpatUmft2ZpKNY8lGotxQ8WRahVqX5FXae9x6nkDayGdqo37NBJiGSnz5ltK4PRTbS/wCr8Q1kd8wmSBPWD7NEDJUd5CyQbldIeOIYP0nP8Ca5xa3ufempqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716540; c=relaxed/simple;
	bh=fVpfE1DT7WKEEdAdua79wEXCVTG1srLmglyWX6/q1fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eK9Hfxlvleq5k0O8dpIqNYHqzK06lWAcBxjWi+78srwG/hgN26HvQffRi6KQ4giepPH1jVH2miai8R7tGoA5ABtMFNjpM9/wtJlqJY5Mh9HE+zIs9o4Zz7etR093aS5ROAZOklpGg+T6cYW6EH/afBkbPozkIyZfwX9m8x1wvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V0m3y3rQ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60A50E0003;
	Wed, 27 Nov 2024 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732716536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVpfE1DT7WKEEdAdua79wEXCVTG1srLmglyWX6/q1fo=;
	b=V0m3y3rQ21r/yw6cqjlYOWFOnXMUo+QMtVx/LlHTBpRZ4b1Fa887ZIv4FbiwotcfJ//V+c
	aQ0XkMe88euHh+n0M9jT+cODKa8BOoMLjHAj7nDJibFT/0oLWudJfCWxBWrqwKHBjD3MrF
	rXUiqVIHpv4t364D2z5IyU5aIvguihd6Q7t+BzBG81QdeEmlDJStKytDS/B5++6vW5NhWj
	UhjsJcDF/YtJGMAKSMKAU2fYpPxJWAiP18eMegipFSTp0PgAJbWZTnzhDXdv7FkEy6RRZJ
	ngwZog+2QaGkYy9IMoEMQDlR2GpJkLceX8AwbzdgUhTzdb/XkPQDc8IACN2bTw==
Date: Wed, 27 Nov 2024 15:08:53 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Couzens <lynxis@fe80.eu>, Andrew Lunn <andrew+netdev@lunn.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Daniel Golle
 <daniel@makrotopia.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 12/16] net: pcs: pcs-lynx: implement
 pcs_inband_caps() method
Message-ID: <20241127150853.1f38e829@fedora.home>
In-Reply-To: <E1tFroq-005xQk-SU@rmk-PC.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
	<E1tFroq-005xQk-SU@rmk-PC.armlinux.org.uk>
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

Hello Russell,

On Tue, 26 Nov 2024 09:25:16 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Report the PCS in-band capabilities to phylink for the Lynx PCS.

I'm a bit familiar with Lynx for Altera TSE, so my experience with it
is limited to 1000BaseX/SGMII. I unfortunately no longer have the
hardware to test it.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

