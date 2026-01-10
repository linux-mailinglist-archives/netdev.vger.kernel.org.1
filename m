Return-Path: <netdev+bounces-248720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AB9D0DA45
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E00C3017EC7
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283C29A322;
	Sat, 10 Jan 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="IoWcLW2a"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81B13B58A;
	Sat, 10 Jan 2026 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768068589; cv=none; b=BSYRT1mDSGLeBw+NruHeAOBcr9SpG1UFhGHbDORLnj0j+etdoqNn0xMfNk6+Qnk0Vluv0ZhNKDteIIZwg/v4UJKkiOVGoimV5w4lvJMT5Mx/1QJHsU/J5oChAGhPfBtTqMkgNnlNeNi4GNfHLiNJY1K3d/vrZjZ3oUcpJi1bAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768068589; c=relaxed/simple;
	bh=EFPW0Msly5Teyp9k0y7qo0QpVArg3QHX3RWO1QKXN5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+XhMLWW+wTo9pVKk0oioJEQJig8KXO0jLoYP3rNFMJkwlCwZeIB9BA4ujD+gI9JqitBRDMVuUMj0Kd3zvL3uqh7DmvVVC/GcGFDAELDkMX6tbrCr1PSMIupVAhtF/eiy2wmT2TW4uGsHv4fG051n5g/HKP3hv87717f0oZGyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=IoWcLW2a; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=IoWcLW2a;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60AI8U1I007153
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 10 Jan 2026 18:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1768068510; bh=EFPW0Msly5Teyp9k0y7qo0QpVArg3QHX3RWO1QKXN5s=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=IoWcLW2albxW2UQHMl8qeYHGt3GvqCpnIOECqMXpZr22MDii53p+5+phCdnsF1tUn
	 ddlqu9sVIBVPc+XrVIJXnIwTCfGlWcTJSs6DYDvAQeDmHNoIrFYBzTdH+yx3tOtagO
	 lpUTYcnfagBK2rT7j/aIGlhpLPPkhvsQDRyo5GpA=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60AI8UOx320195
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 10 Jan 2026 19:08:30 +0100
Received: (nullmailer pid 22846 invoked by uid 1000);
	Sat, 10 Jan 2026 18:08:30 -0000
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
Subject: Re: [PATCH v2 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
In-Reply-To: <20260110180433.bfg2hxbdjkfllkiq@skbuf> (Vladimir Oltean's
	message of "Sat, 10 Jan 2026 20:04:33 +0200")
Organization: m
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
	<20260103210403.438687-6-vladimir.oltean@nxp.com>
	<20260103210403.438687-1-vladimir.oltean@nxp.com>
	<20260103210403.438687-6-vladimir.oltean@nxp.com>
	<87jyxtaljn.fsf@miraculix.mork.no> <87jyxtaljn.fsf@miraculix.mork.no>
	<20260110180433.bfg2hxbdjkfllkiq@skbuf>
Date: Sat, 10 Jan 2026 19:08:30 +0100
Message-ID: <87zf6l49y9.fsf@miraculix.mork.no>
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

> I've integrated your test and added one more for RX. Do you have any
> further comments, or shall I send an updated v3?

That was everything I've found.


Bj=C3=B8rn

