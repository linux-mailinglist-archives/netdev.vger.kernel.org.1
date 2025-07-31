Return-Path: <netdev+bounces-211114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0111DB16A11
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B153A2BA9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81486353;
	Thu, 31 Jul 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4oxyVZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F28A2D;
	Thu, 31 Jul 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924607; cv=none; b=ZyHZBu6mE9V4rJeYdD3hHBPcE0+5dIyGg5+cWf8IB9Aye5I12gIIA5jSI/DQW05g8QFWgyL2FelCttzv/YJOLF8a2zxzJ4cTnOE/HhFtOyemY0HkJWp8lN+CqKAXX7r+gbLxMzZp/DDLO4LeSUqOfzvLnhYqu9v7epj9owPRgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924607; c=relaxed/simple;
	bh=COC+D0tOb2/vFTOc/902HqJ44i+7C7ex0HaywC+rBg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nk+8jAQWWZV67LqYYidYuEM/0/oRAsniwmYuNS1GqvCYlMc9GVsKW9ncAzFK4P3NmFfWfB1fy+wi4oGOmWgjjq+Opnc0SIPh4rPB6OqLBYAsJiFvfJDwQzEchpH48Xmdp3gV7/AHMEHsv/LfBKZXZ/2nE1xx2U+MZaupkQWVYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4oxyVZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1637C4CEEB;
	Thu, 31 Jul 2025 01:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924607;
	bh=COC+D0tOb2/vFTOc/902HqJ44i+7C7ex0HaywC+rBg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4oxyVZ51Z0qHS4csZf9IemuZKgTGinQNQDcaw2b2LdtccrlrM/xDJK6z8QJD502X
	 MU8+CymSMyQ+NOYXu9cxSpJZB50YhFL18OIfEyWMGv14KybY423pvGA43vKQgDKCMT
	 3xlgNeYNBe6ARObTbJEpfGs539qPAJS5zu6+sr/w4sJnMrSMxmLEyUN6YQqUU9fHB0
	 ops3Ox3pqTbF+9V2WACNxllXSKq5WR0IZDBNUv/HvdvFfqWEeXWw+qOhZj3ZrdYzrt
	 fw53q7cnZn0rOVLmpvb9VfivhxWDjLFdl30C73QRMF1H2Ac2sJz3MLASYYGl2nzfER
	 UTpjRXYOaRlVA==
Date: Wed, 30 Jul 2025 18:16:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bence =?UTF-8?B?Q3PDs2vDoXM=?= <csokas.bence@prolan.hu>, Andrew Lunn
 <andrew@lunn.ch>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Sergei Shtylyov
 <sergei.shtylyov@cogentembedded.com>, "David S. Miller"
 <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Csaba Buday <buday.csaba@prolan.hu>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
Message-ID: <20250730181645.6d818d6a@kernel.org>
In-Reply-To: <20250728153455.47190-2-csokas.bence@prolan.hu>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2025 17:34:55 +0200 Bence Cs=C3=B3k=C3=A1s wrote:
> Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
> devm_gpiod_get_optional() in favor of the non-devres managed
> fwnode_get_named_gpiod(). When it was kind-of reverted by commit
> 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
> functionality was not reinstated. Nor was the GPIO unclaimed on device
> remove. This leads to the GPIO being claimed indefinitely, even when the
> device and/or the driver gets removed.
>=20
> Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")
> Fixes: 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()")
> Cc: Csaba Buday <buday.csaba@prolan.hu>
> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>

Looks like this is a v2 / rewrite of=20
https://lore.kernel.org/all/20250709133222.48802-3-buday.csaba@prolan.hu/
? Please try to include more of a change log / history of the changes
(under the --- marker)

Andrew, you acked what I'm guessing was the v1, still looks good?

