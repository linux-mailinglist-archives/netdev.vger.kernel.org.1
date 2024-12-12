Return-Path: <netdev+bounces-151426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4469EEC80
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E82169308
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B58C2153FC;
	Thu, 12 Dec 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lfYxa6uP"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D06F2FE;
	Thu, 12 Dec 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017614; cv=none; b=hLZR4o3qEAtUVlZU7nMai3BCpkbFni+jHJbugRUIeKn2v26qZ1Nhl5Zw9f5poeOb3rFvX15yXC6Y+kPO7eof1CgqKPnnhBC0Ke7cZpE9OmJ1qijrIPZsgEpCvJV3uWanvyLa5+SBkCBV5W4BEeWXnL/Yng37l4qlnBFVt2f0STA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017614; c=relaxed/simple;
	bh=IfmbCcJeozM7VioKT9ps8qUHp2IjCZDdWUy8b58NEOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeWNsiJXGpOs5HHPNUy9Oa74iO1lSOM3gZPCJPAsE1i5KrVR/w/pj8IcPyZ0HyC+eE+K5gXWXlx4ZVzE8DEfUxec/RIfOjVnbmg4pDEA9I9uJ7T4CABl0kte8oIS+wOLwXQK3PTz/TXJXdAz7nRrANdDmnvuvF81j4AY/IHDTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lfYxa6uP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 709481C0002;
	Thu, 12 Dec 2024 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734017609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd7DkGb2x0uc7EE7hQC5+3KDtXVIG2wo02hrD1H/wLE=;
	b=lfYxa6uPjyH58rLdku1n8kZtqHgK7gyHeYmg4VjNcAVun3knJtf+PE6H7LFGA0IB4v5jX0
	Im8HWc/q3r1PYfnHXAg681NDwEjs3qzI3K6mmwU8stMCyD6vE7lzbbihoHhI8mymdeOOOA
	tAZFxTeZC4q5zb3aJiU3CktO/sox8EolTn17bjOlvb62EqpD2v93EVrgRbXSY+HZn3I8Pa
	sJdwR33YYeKbo0Iq4iGER4m3qd/YhulqN8fPjaTyo5jOvS/1ht+XlWRsZc7GCMsBFmkzex
	hqDQQOjauuklMSkkF5NmUXn1rX8FWTpgCNzC1GdnuVVqkkEgEobcMk20c5oQVQ==
Date: Thu, 12 Dec 2024 16:33:17 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Justin Chen <justin.chen@broadcom.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH net 0/2] net: Fix 2 OF device node refcount leakage
 issues
Message-ID: <20241212163317.5e6829ec@kmaincent-XPS-13-7390>
In-Reply-To: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
References: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 12 Dec 2024 23:06:53 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> This patch series is to fix 2 OF device node refcount leakage issues.
>=20
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Zijun Hu (2):
>       net: pse-pd: tps23881: Fix device node refcount leakage in
> tps23881_get_of_channels() net: bcmasp: Fix device node refcount leakage =
in
> bcmasp_probe()

Thanks for the patch. This fix was already sent by Zhang Zekun:
https://lore.kernel.org/netdev/20241024015909.58654-1-zhangzekun11@huawei.c=
om/

net maintainers would prefer to have the API changed as calling of_node_get
before of_find_node_by_name is not intuitive.

Still, don't know if we should fix it until the API is changed? =20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

