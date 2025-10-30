Return-Path: <netdev+bounces-234322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D7C1F58F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FB03A244D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FAF342160;
	Thu, 30 Oct 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vSrDUMlb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE799342170;
	Thu, 30 Oct 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817256; cv=none; b=S9+F7/HZAmtLEqDCdv6qsXt6EDwe966JUJ+vPc0aNRESFZOtsEV4q68iuw7WbQ++XN7alt4TusgGFRgzJaODv6/vdN74WS/eTPogseL2XI6wtWETcxa4ttFG+FI0DcuPev3j8PypY5McdvoqyAyTsTvVCg43SKJm87ao98ytXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817256; c=relaxed/simple;
	bh=AXhIip8aIJ6Y54u/3AC4lYdPqgouWN/WzBDGCLOYg0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmFChGRJRrcba5tNhd0pcl9bl20CsknolwONSon6enepGG4cDF9blPO06jj4WLn8L1ZM60lDMxpvRw39e1hl5btAgmLFYzSL5v4uvoG5MXSfimJ88QJYoCim5UOp+sn3qyt4sDE8LcJa9g9XkzqBMnmtCRO2hkvQbZ3j2UzPAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vSrDUMlb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 703A1C0DAA7;
	Thu, 30 Oct 2025 09:40:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B150C6068C;
	Thu, 30 Oct 2025 09:40:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB2AA118085E6;
	Thu, 30 Oct 2025 10:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761817250; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AXhIip8aIJ6Y54u/3AC4lYdPqgouWN/WzBDGCLOYg0c=;
	b=vSrDUMlbZ8avJZWyHiNapiup5y0BhHT/84h+ToSACliw/NSLq0u2GnKDCUxrDfZRDTZbO2
	HK17XCryYRmoexUDrq84kUG5ffGjPlrPua9QR25+Jcp4jMkv6+/Z+5qw5upIO3tMT4F4Rh
	eb1B2bEfwLYWgFvJ3pEnEmxMn2skbfby+RrMCHDxKu0LQf1M1/BBb5PbopdI/3CD4FMNLT
	cayZYKMH4B8fLt4MQjVHjahr8jFcH2Cc7H7/B9dQJrPCu+HpVyWwtm28fJsV1o+zzwScpg
	vf8/T6SHmPipvEXMhyuuE/XcD17AvonD5pXJXDD/erV93pIGw0uWYT7oFbkwbQ==
Date: Thu, 30 Oct 2025 10:40:46 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: pse-pd: tps23881: Add support for
 TPS23881B
Message-ID: <20251030104046.107457ac@kmaincent-XPS-13-7390>
In-Reply-To: <20251029212312.108749-2-thomas@wismer.xyz>
References: <20251029212312.108749-1-thomas@wismer.xyz>
	<20251029212312.108749-2-thomas@wismer.xyz>
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

On Wed, 29 Oct 2025 22:23:09 +0100
Thomas Wismer <thomas@wismer.xyz> wrote:

> From: Thomas Wismer <thomas.wismer@scs.ch>
>=20
> The TPS23881B uses different firmware than the TPS23881. Trying to load t=
he
> TPS23881 firmware on a TPS23881B device fails and must be omitted.
>=20
> The TPS23881B ships with a more recent ROM firmware. Moreover, no updated
> firmware has been released yet and so the firmware loading step must be
> skipped. As of today, the TPS23881B is intended to use its ROM firmware.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

