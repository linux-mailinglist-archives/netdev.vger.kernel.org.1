Return-Path: <netdev+bounces-220683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08244B47C7B
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D333B4974
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9912848A7;
	Sun,  7 Sep 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gPs9V00X"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831851C6A3;
	Sun,  7 Sep 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263973; cv=none; b=bmfR2nbBx3RLRNmd3cR3Yn/XcVehvhX4ILv2cH8Ik/p4PUJn0LjQ7ObDtD51bZiAS0lT4xU95uYsicWOnlyPfPBHbPj1VfypRSdfpZh6KEbp8ROq0FJzXu9YWgkYK4KFLNIm5krJh90SrhB/Eflpnox3CTTaVqsCIADbhG3OWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263973; c=relaxed/simple;
	bh=F/24ciM1j11ua/knGQhVWHQkxntL42B63VZvi0iR/Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VI4GxhOo8Y70zjAS+Y6Cp+1fmca6QUEDLtD1PLA9nahxyy/c877oK/Jjls9E1Tsr5YPDvwAxopVbV8+vvlhfS9aUNZj+ih888+l6GcVNOnwr5k+p1F6GZeacOerPK30OMC3gE9OCUs3DXRo8Mjs9NDpF4a0S0GlPlQmQWuTsACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gPs9V00X; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cKbjs0S9dz9tHp;
	Sun,  7 Sep 2025 18:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757263969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFIcbNvPEoCpucJAgPEBDI5ghiJH/mZZqi/qt+FRAtI=;
	b=gPs9V00X0uyp27qkyqUpw2vp2emOp9nNNpJ2k6uT6pgZAMarP9kSnE4FLdYuOYmqHL7MbG
	fuL16htgJImg3pXpwZMO5rRTCwqapalIt2zEkPkS6cs5f1a7QVgV8w9ajcjtluIrPh+Eqm
	Uxv9oL77Oqu8SXDHaOradOiztXJMkx+Ym93dACPKDO8lvBDuRPc+xNkxLa7gn/GO7eg+6s
	L+aJZzTzvkLsQ4l/i9uL7c48ojTK09HTDtXJ6mmX4z/RAn2dSh6zMrJlIhtOk1J+n7PPvq
	P5yJctAE7l1Y7V13vGhrk9te6woEGdqWG3272x65q2AkuIBCK3ZvSCAn8gAspQ==
Date: Sun, 7 Sep 2025 18:52:44 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v19 4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250907185244.7eab9640@wsk>
In-Reply-To: <20250827111651.022305f9@kernel.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-5-lukasz.majewski@mailbox.org>
	<20250827111651.022305f9@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: y5a5h3eezse9k4uczes6z1epofcg74go
X-MBO-RS-ID: 4f2f62b6c2bc268ccba

Hi Jakub,

> On Mon, 25 Aug 2025 00:07:33 +0200 Lukasz Majewski wrote:
> > +
> > +	/* On some FEC implementations data must be aligned on
> > +	 * 4-byte boundaries. Use bounce buffers to copy data
> > +	 * and get it aligned.spin
> > +	 */ =20
>=20
> Almost forgot, the word "spin" appears here rather out of place.

Thanks for pointing this out.

--=20
Best regards,

=C5=81ukasz Majewski

