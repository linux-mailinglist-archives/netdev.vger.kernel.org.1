Return-Path: <netdev+bounces-217752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF6B39BA5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA2F467873
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5C30DD04;
	Thu, 28 Aug 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jLcgiJry"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E543265298;
	Thu, 28 Aug 2025 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380925; cv=none; b=X3DPVzmGTYInqb3FN9OKlq02Pl5qgUs0MBDx/i5KM6NN0GQ/tWtTnx7anDUg0gcNSuWhPn+flTz6JBxkWP2A/lx9AgD5r4RVeIh/fIA21WvQFsT8kAUBq3SWNcuzipUJgTD0VM7OHeBzzbL8337vdSqCqtJtYXjmMBnoZf/tl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380925; c=relaxed/simple;
	bh=EutqmllJa5MrsJcHizOYbfflLsXSe5J90Zg6yyrLEbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQFFECKL0xZTwSKmorsuqKQq9T6G5MCDF65Zd0Frq7iPGj4BJNLs/qVJkBiWG/o2hKJd+g83lA7tmTkwb5ib5FJ6rsAloJYRA+eM+Z52u98QLp1pfrkM03IkqyctzP0X9LPZp7gk9GohS3aX89KdR+x/v0L9S4EWsuPPCIsmn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jLcgiJry; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 55395C6B397;
	Thu, 28 Aug 2025 11:35:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A39BB60303;
	Thu, 28 Aug 2025 11:35:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59CBF1C22D2C9;
	Thu, 28 Aug 2025 13:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756380918; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EutqmllJa5MrsJcHizOYbfflLsXSe5J90Zg6yyrLEbg=;
	b=jLcgiJrykap+ru207xJFh2urzLO1xQe2+/GPo4Qabl32Z4hKdD+HaMvMTahlp7aeZnDtiz
	xMaE0EBJ5IK5ACn+2oFXKKJCu9DR8tqB9zP1If0FmwuaOfQSH0L+03nl40g4V5hkLTVxVQ
	W8Spy7wsHlDYGo5nwsZQiYHi3S+4b8sHsT/EzTipCSyfjPTYNvQctS6rgETJgBVPwBTRKu
	qeNTvci61b0YoMIfszj0ZYw+beboq6sokM9KW31Hb+1MZ3p7YQS8FKwVkjD7IrE93U1Y/l
	3qD0U3gQAwCc9d7+NFEpXBG5vmgCDSsiZ6HhPYhe/nHEFSgZLW3I2b9ssfx5eQ==
Date: Thu, 28 Aug 2025 13:35:11 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 2/2] net: pse-pd: Add Si3474 PSE controller
 driver
Message-ID: <20250828133511.315176a9@kmaincent-XPS-13-7390>
In-Reply-To: <9b72c8cd-c8d3-4053-9c80-671b9481d166@adtran.com>
References: <6af537dc-8a52-4710-8a18-dcfbb911cf23@adtran.com>
	<9b72c8cd-c8d3-4053-9c80-671b9481d166@adtran.com>
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

Le Tue, 26 Aug 2025 14:41:58 +0000,
Piotr Kubik <piotr.kubik@adtran.com> a =C3=A9crit :

> From: Piotr Kubik <piotr.kubik@adtran.com>
>=20
> Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
> controller.
>=20
> Driver supports basic features of Si3474 IC:
> - get port status,
> - get port power,
> - get port voltage,
> - enable/disable port power.
>=20
> Only 4p configurations are supported at this moment.
>=20
> Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

