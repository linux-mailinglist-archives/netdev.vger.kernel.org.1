Return-Path: <netdev+bounces-241580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DFC8607F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3ABD4E2820
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6E4326930;
	Tue, 25 Nov 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jg0EhbFA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A978F51
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089435; cv=none; b=tNQCnszJkQfcpcBSJwnvP3yzIrMjmyio3Y/ie7hJcZ67FbFkICfTsFT89e7aN08Cfpl7TAVgkY6dyG0MFu2HJ6dt1DXezG/xTr1OKbXuM7cV3iWWUkcXaR+vKjXs3bXdQR681NRzl10Fa/FCe/v8OPJARxpGhLvx2D71OdC65Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089435; c=relaxed/simple;
	bh=HNNQpvL5Uird9shQ6Aj+bbo8z1SgEJg1RxEn/2M+PwM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=m+fsMtCd80OZ741g4Iw4lV0AJYpKYk9s2QoOMIYjC6o16f8HOWqX7LGnuhGEiqK3SyfiXM9F1DBCPyyMMBQ/rvpAeL9rRFtMJS5GVXpfYClIwh08T4kW9Eof6tGfpVAftrL/RFzHOwNOtxxuY1gcJFuq6tS80ynauP0tZKAKYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jg0EhbFA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 09446C15D59;
	Tue, 25 Nov 2025 16:50:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A3AAC606A1;
	Tue, 25 Nov 2025 16:50:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F14D8102F0894;
	Tue, 25 Nov 2025 17:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764089429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HNNQpvL5Uird9shQ6Aj+bbo8z1SgEJg1RxEn/2M+PwM=;
	b=jg0EhbFASeKtDCILCc5f7AbO/ttc5Wmn1gXF6UyRUmK/HZ5ln+Sj3pPqpwmIehTn+V//KV
	ERU0VRin78cDpQ7koM6RJmh9LS1NM6WDa7/f8BeMrVt2sYcWIfJW4WfBN7MpXMFEXeJSuq
	yajVp5BIFgb2ylRrf9wqJk3TISze0bg3YAxeFSeIg8krdlCPn7vvqiicvJfJF7IitY0D6N
	MHF07tRxwWE7cVdwANHIKmrygY/PFIS/3AwAzOEzO6QaXL0KMSYc0+6/qkN0fT1uVW4u04
	wNFQo/iNUX+Uc1HlYyyNIRZeHqoF6skfj7S1orso2iWztz9dGebXFzn23YI0aw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 17:50:25 +0100
Message-Id: <DEHXIE1SLF7P.3OFKTXSVLN5M9@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next 0/6] net: macb: Add XDP support and page
 pool integration
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
In-Reply-To: <20251119135330.551835-1-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo,

This is a small message to tell you your RFC series hasn't been ignored.
I had been working on the same topic for a while, I'm therefore happy
to see this series! Will provide you soon with feedback, but of course
there is a lot to cover.

Today I managed to:

Tested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> # on EyeQ5 hardware

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


