Return-Path: <netdev+bounces-234484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28CC215DE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5740189C358
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0FC2DBF75;
	Thu, 30 Oct 2025 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MjStNRD8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888318859B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843919; cv=none; b=Xp9CDz+BfkDexSiZAovaPCRpMaN9r+xwPQo+iBu99aOuYoI1Jnb413Pm2dRQJwsEHmWSE/zwPIPdtI1PC23kkttLvuYUtcAzQl/jAnMoDYjR24E/IsxKugbyqtiLhHCXJ/s8k8LoFzPqFPyhxO0/O4tylaqgWBLsmy9s7DW6P2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843919; c=relaxed/simple;
	bh=8lWtldHLyzk7eRvcHyn73JYzwTGqrFwL998v54w/xGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wk49dtlAJ0D9TgPuIVj03thWKnvEDRoZWCKDMngL6z3/qQx/yjo3nDDkUvXLHppIBFPsr6acy5trdy+Z4VyIvi3yA/PY1dr6OLHY42hL9/Rzo/oFwmliuCOHapPBeeWeWQcrcOKN21hTHkNrzZxeNI3RLmn5Kkf4W0H/3Dd2mX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MjStNRD8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3E8A5C0DABA;
	Thu, 30 Oct 2025 17:04:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE08B60331;
	Thu, 30 Oct 2025 17:05:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8A8511808CCF;
	Thu, 30 Oct 2025 18:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761843914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8lWtldHLyzk7eRvcHyn73JYzwTGqrFwL998v54w/xGI=;
	b=MjStNRD8PYvrsR+XWDlnZdrt/RgQTMEfpmVxVjml6TZS19NgRGKuq9nHohwN5vojzfeN4w
	0oAM6cZdwIbAQZBIlbUBmwzJDqnOc916dZ0E1nlMzpnQNRNvxUHm9K9O6d3DyuvXdw+214
	d2H28iYL4nue5dU1TGc0Q18cRy5v00BOjMhAsp3gE++gEM5ErQplyH6Mb0CFxLfZBy1gOW
	UPn0smFQ83j4q82yVqK2OtfktCCya+x24zn1b4VuqFbAPUQu5fBoSNMi54QtqM+lb93YN7
	s6bT/U20m+TLZpqta5EwJC+FGYkO5uQy0m0W/4rUd0lcbxHjlIDBw2PMpEgfpQ==
Date: Thu, 30 Oct 2025 18:05:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
 socketcan@esd.eu, Manivannan Sadhasivam <mani@kernel.org>, Thomas Kopp
 <thomas.kopp@microchip.com>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jimmy Assarsson <extja@kvaser.com>, Axel Forsman <axfo@kvaser.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 3/3] can: peak_usb: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251030180511.13d6d4e8@kmaincent-XPS-13-7390>
In-Reply-To: <20251029231620.1135640-4-vadim.fedorenko@linux.dev>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
	<20251029231620.1135640-4-vadim.fedorenko@linux.dev>
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

On Wed, 29 Oct 2025 23:16:20 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> Convert driver to use ndo_hwtstamp_set()/ndo_hwtstamp_get() callbacks.
> ndo_eth_ioctl handler does nothing after conversion - remove it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

