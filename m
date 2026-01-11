Return-Path: <netdev+bounces-248798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EBD0EC06
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B75E9300C5F0
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8793382C9;
	Sun, 11 Jan 2026 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="fXbUnhQa"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0719B640;
	Sun, 11 Jan 2026 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768132454; cv=none; b=FGzfPT0vvufyvvFawJ7oidHViyR6ZBroNS893lpeaT3sdYGmvEeZbG/M2765G/2m06zyUAe/xCOZlf1QGwTMYVrhMccJVw/dV8pmpoOkbBk78y5i2P6gKJ72SNDijphCE2KIt7ZwHeSwGrfHY7/Gb5LGCwZxURFc7RaGH7I8W+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768132454; c=relaxed/simple;
	bh=GhOetxFDMeDhYbefSfq2TFJ9faSnhBK5OhkfJG4g/0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sscwHrbcaYeEa3GbayfredYZzGupifJHYuftYT6kTWscUD9AkzjkgLIs5GO5JHc75OovKrIDml6WnVCXzL8T86/qb6zbZlJNBHSR3fnf0H06mGiImTDscQeF68cVuOUAnOLV6fB9vNzNpQMB0exx14arwYwKt5Lqu25nnDu1huY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=fXbUnhQa; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=fXbUnhQa;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60BBrFAW050203
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 11 Jan 2026 11:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1768132395; bh=GhOetxFDMeDhYbefSfq2TFJ9faSnhBK5OhkfJG4g/0A=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=fXbUnhQafZvq1kWpyrH38IcXXKX2qNZtY0JZ5UpNgLOjoKgxTWUUf0xn87J92YIXp
	 YpIJIJqIq9gfHjWQCluPnXUlkuPsFNo0dAmSBe3Kx6AtoOW+Wy32sKT+IEIk/YBGAt
	 gwQ+EGIGqnYKOfbKPWowZ3n44xiM7CygfyEqcQ0M=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60BBrFuL932582
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 11 Jan 2026 12:53:15 +0100
Received: (nullmailer pid 71986 invoked by uid 1000);
	Sun, 11 Jan 2026 11:53:15 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Eric Woudstra <ericwouds@gmail.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
In-Reply-To: <20260111093940.975359-6-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Sun, 11 Jan 2026 11:39:34 +0200")
Organization: m
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
	<20260111093940.975359-6-vladimir.oltean@nxp.com>
Date: Sun, 11 Jan 2026 12:53:15 +0100
Message-ID: <87o6n04b84.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> Add helpers in the generic PHY folder which can be used using 'select
> GENERIC_PHY_COMMON_PROPS' from Kconfig

The code looks good to me now.

But renaming stuff is hard. Leftover old config symbol in the commit
description here. Could be fixed up on merge, maybe?


Bj=C3=B8rn

