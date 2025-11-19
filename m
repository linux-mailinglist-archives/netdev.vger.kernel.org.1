Return-Path: <netdev+bounces-240013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A36C6F31F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E33C95002B7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9CF364EB3;
	Wed, 19 Nov 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J5FZ0Oz3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615823538A1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561406; cv=none; b=JZFe1ybFNBLtleNpLkJ/I5EKUP/GUV7OaBJq3JPP3InRX8cPFfzQMqQxJaJ/5OFdkMAzDgA1rEiIt++NIK5GAqQLznc5CIoBcnRapSlPBcz1fth1mGsOl7SLAfP2G1B7rc5AeAYBImKwqVwjEuJgw6ZdrTnlol1f3z94hgzjAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561406; c=relaxed/simple;
	bh=+wg7P+9JQZcHTzO9iSDPSNZTaRZE0A3xtiJBTQ0TiA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DP2iHA+eXvDu8qpnnz/eP421Pw5OCTHt3B+9EtsXDLX7m+7HWOm66JkxQA4LO+2JBM8ZZlGjKiSDiK2XPRD3YQquk427uGd/V3j0RH2yC+YdIDpgfFqqzv4CV+jo9hUQIm0ZQMe8gAGkl9tiaVzAHl+Q1X9sPxaQPgkJ3/BB9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J5FZ0Oz3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3AF964E417A1;
	Wed, 19 Nov 2025 14:09:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0755A60699;
	Wed, 19 Nov 2025 14:09:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4D5E10371A63;
	Wed, 19 Nov 2025 15:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763561393; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+wg7P+9JQZcHTzO9iSDPSNZTaRZE0A3xtiJBTQ0TiA0=;
	b=J5FZ0Oz3c5uM2WeJU+S/S6aW0vzCzTtcjORp0FgibIhqOdWex6tmngIhma1gFq4i/bIzYB
	X9tC6Kf2J7rnT6vneyDTeZDqt9EIABvIxnR3rq9ZIaV34hsTPn2y5wEsRsEBOi2RJQLMqw
	yvjCQGgLoWav/C/hJjciYAIVcpEX0mh+nEVxGW0Dku751l3b3cznAKiQ69T19pxl1Ow0jN
	ToxPF8PQa0e/rIn1vlHatopL38BNFz6S2MusVHh6853rXmGBdXi1Wa3LZizChJDb958E7m
	pUb6+WOin/9h9mqziscevc5eLei2sRITzEag8Tt32H5PV8RtkhCN5/bfC9Kycg==
Date: Wed, 19 Nov 2025 15:09:48 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/9] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <20251119150948.0ba5f479@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-3-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-3-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 19 Nov 2025 12:47:18 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> PHY devices had lack of hwtstamp_get callback even though most of them
> are tracking configuration info. Introduce new call back to
> mii_timestamper.

It would be nice to update this kdoc note:
https://elixir.bootlin.com/linux/v6.18-rc6/source/net/core/dev_ioctl.c#L252

Else:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

