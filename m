Return-Path: <netdev+bounces-75144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505078685BA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8724BB221BA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 01:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24C4C6F;
	Tue, 27 Feb 2024 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHDODS1B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B082F56;
	Tue, 27 Feb 2024 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997181; cv=none; b=mdoolG+m+4dcepG7nsvqYjyPYuZukWNpRts55EkA4z3BNsgXrh5LuxYqDqE8v9ZHNuQOng4wgDtDSct6baG7YslayF+p/Ow6fcGF4VWn1afMzrXkXnslhRrWy6JtPxx4HqTYvy2+bgERXF3kMj72arTZ3pe43EVDDmKkHifEOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997181; c=relaxed/simple;
	bh=bJnkg4o/lnbk66QKJ1pLyaWugnPbKZ6rSmeYjGhatOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=le7qZFoV1DcKQEjbFja8jGwtwEyx/GyE+fNxIEgaG8Pwz/MLzUTsUzYtTcRxLCuXp/r3OIwUPKmOe7s7XSzdLI38iNJLOgH4E6SMQjz7VTyI8Dabr4+5s+XPCFFV0yHFgTSolwiO7DM+Q3yOvA/kOg7uZn8kkfoQP3RFaBU4uYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHDODS1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2C5C433F1;
	Tue, 27 Feb 2024 01:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708997180;
	bh=bJnkg4o/lnbk66QKJ1pLyaWugnPbKZ6rSmeYjGhatOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHDODS1BJa2mTw7KMtTpB3UW4CtJzQGXAJ9ehwu+0h4N8/JZVr+q4YSYFo9mNaK9n
	 CPMq8XKUyJY+HT3I2ZC1LbWN8eWFaTfsHsOdmHplifEbW2qc/dnEp3G2Hqle3PP1EX
	 0OLkVthSPHZyDjgOaJkzQOp3W/Wqnh4CZPaXrcReyYV/L14rnOVV8dl2JMqXi1ZsP2
	 dB90HncWK8LdkT2zl8gTkviz74qf92PQ7Voc4Yzls2tlcJsd6d4TGsUaLfBeqbhBO0
	 1Ih51Q33qBO+yRUyF1OEyLsdVpa4FPyd/93XphOCBgQL6FGx0HHKhoTubtNDecKcFt
	 luTp24btvjlfQ==
Date: Mon, 26 Feb 2024 17:26:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Russell King
 <linux@armlinux.org.uk>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>, <arinc.unal@arinc9.com>, Daniel
 Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 0/8] MT7530 DSA Subdriver Improvements Act
 III
Message-ID: <20240226172619.59defc7b@kernel.org>
In-Reply-To: <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
References: <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 14:05:28 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 Relay w=
rote:
> This is the third patch series with the goal of simplifying the MT7530 DSA
> subdriver and improving support for MT7530, MT7531, and the switch on the
> MT7988 SoC.
>=20
> I have done a simple ping test to confirm basic communication on all swit=
ch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.

Russell, Vladimir, there are patches here carrying your Suggested-by
tags. Would either of you be able to take a look thru these?

