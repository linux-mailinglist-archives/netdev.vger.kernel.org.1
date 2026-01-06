Return-Path: <netdev+bounces-247443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26690CFA86C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D97B63001FF0
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB593587BD;
	Tue,  6 Jan 2026 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="OaArPkna"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2A3587B6;
	Tue,  6 Jan 2026 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726915; cv=none; b=BKUngNVi+Xih4x3wruR+naDNgkVV20OHketHEjuOKLyoT4hXih7RmgsIFWHL+pXI0A2xcd54+GsjmhWE+Ya4SM+p33WW+6Q6rf1V9JJMpLiR7V1DH7NtpUzMfacZn4+69YV333QEev68zojIvypn/iVZy8kUiA8LxJ+A5q06OfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726915; c=relaxed/simple;
	bh=mhw90XZVlZP+k0RPbsgOaOSrXrjWbeCxnVbLPsrLSrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocz2pR3pdmVCWdmTBzgCY9cx0pSGPIECW/++WZ56GFwJELtkQXswwrvsonL2FhDH/zPk6bOk+3S2KC06LvA9ebzgh1GirP1xiZySWoIj2tC0JmYUBQWZjy2QgjPaQs/CiE+8C+7Nvp0Cd+N6sjTTIKsFrfKUKJMKhPUuoaLXLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=OaArPkna; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=OaArPkna;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 606J3pAR245901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 6 Jan 2026 19:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1767726231; bh=2A66euThQPenJG2KEd8CaRBqOlB3WqSPAAMrbx7aFzg=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=OaArPknaMBsAYMuaq+tE2ybZt2qjucvuf7QIlgekae4B0sR6nr28biT5g1R1+uXxB
	 MlORgrtRyQcLsXMDqpCXl4OufIxKdvhxL2ge3sW0IIol4hr8PpqY+YlUBf29+iVjig
	 RCiJf7ehJ219xozbMNnCVYrZ7DI5HT1W5imubuF0=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 606J3oDj1248715
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 6 Jan 2026 20:03:50 +0100
Received: (nullmailer pid 602062 invoked by uid 1000);
	Tue, 06 Jan 2026 19:03:50 -0000
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
Subject: Re: [PATCH v2 net-next 07/10] net: phy: air_en8811h: deprecate
 "airoha,pnswap-rx" and "airoha,pnswap-tx"
In-Reply-To: <20260103210403.438687-8-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Sat, 3 Jan 2026 23:04:00 +0200")
Organization: m
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
	<20260103210403.438687-8-vladimir.oltean@nxp.com>
Date: Tue, 06 Jan 2026 20:03:50 +0100
Message-ID: <87qzs2a7hl.fsf@miraculix.mork.no>
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

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index a7ade7b95a2e..7b73332a13d9 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -98,6 +98,7 @@ config AS21XXX_PHY
>=20=20
>  config AIR_EN8811H_PHY
>  	tristate "Airoha EN8811H 2.5 Gigabit PHY"
> +	select PHY_COMMON_PROPS

GENERIC_PHY_COMMON_PROPS maybe?


Bj=C3=B8rn

