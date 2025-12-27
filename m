Return-Path: <netdev+bounces-246140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97965CDFF0B
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896C1300EA27
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406073164D9;
	Sat, 27 Dec 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="k57w20PL"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210027B3E1;
	Sat, 27 Dec 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766852033; cv=none; b=tma1DbhoTIBKPyLnaroRuJGrf1D0ucq7amTP9vtHi4tD6RqC7RiZx8+1Jpi7pInEkeJK6HMO1v3n8CO+6HZbG3doW2z2gxS52rLU3qyfe38nkz7MwknnD3/4wqrPvI+Kx8VGWOuLoZoHF5d8tssBLWTxpylSWYTdco06FwL5/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766852033; c=relaxed/simple;
	bh=6xQepFKbLSgWwslvs/nMpOgMMovKMH4umS/FdNhEKCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ab/QUW/IBGP4rujZXpu/8lE4WK3ALwUD1qjSHEDbclndRa8TMl5NEz0Mirx82glOAdT0ml1Swk+Vm2o45em6d2/4ppx7U5ppcPKbjTkzAGMCEGh8c+Cf5TdNeXIdS/cLPwMtJJQiVDdnVVwoeuK8WYuGAUfmezDMluurXyLSBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=k57w20PL; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=k57w20PL;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BRGCXea1092612
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 27 Dec 2025 16:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1766851953; bh=6xQepFKbLSgWwslvs/nMpOgMMovKMH4umS/FdNhEKCI=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=k57w20PLkK0NnQT97ZSgjxTiFyMawI1HfymwWSj/dmV9dfAS0qmWGBcJ1DeXhHDTB
	 Ikjv2Rf43hQPgRm2SkAZK5mFlF3fTrfTBplyddiW09dNafUsFVtDwDIDFTy2FmJol/
	 uX9FVRLcPgMDx6rz8X0io7qVVg3U2DMkmysnOspg=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BRGCXAq1173802
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 27 Dec 2025 17:12:33 +0100
Received: (nullmailer pid 1325881 invoked by uid 1000);
	Sat, 27 Dec 2025 16:12:33 -0000
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Eric Woudstra <ericwouds@gmail.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 0/9] XPCS polarity inversion via generic device
 tree properties
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Sat, 22 Nov 2025 21:33:32 +0200")
Organization: m
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Date: Sat, 27 Dec 2025 17:12:33 +0100
Message-ID: <87qzsfewem.fsf@miraculix.mork.no>
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

> This set contains an implementation of a generic feature that should
> cater to all known needs that were identified during my documentation
> phase. I've added a new user - the XPCS - and I've converted an existing
> user - the EN8811H Ethernet PHY.

Hello Vladimir!

Will there be a new version of this patch set?

The firmware for AN8811HB has now been submitted [1], so I plan to move
forward with the driver. And without this series then I don't see any
other reasonable alternative than continuing with "airoha,pnswap-rx/tx",
like the existing EN8811H driver.


Bj=C3=B8rn

[1] https://lore.kernel.org/linux-firmware/20251225163003.4797-1-lucienzx15=
9@gmail.com/T/#u

