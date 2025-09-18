Return-Path: <netdev+bounces-224471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0475CB855DE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84724E1334
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD7030CB49;
	Thu, 18 Sep 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="kIabRhxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397030C0E8
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207190; cv=none; b=fDU7uu12MOiPuk3XwDPOHjberi9bsLyLqQUZmBqy0L7rucixVQlKloaK1s68hRHdiDxODuUeUdjSw1A7HRsk/5A2WbbE20oDhmG2Q+tFVaJrP0+uutqw3YXkVAe/LofqxkPsUaeiOe4DUTs9IQqPzA9UUn9xf6UEbeob5sU6+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207190; c=relaxed/simple;
	bh=Uay4MjYFjjFjRxgKNev3XtX0NxhEpjQT2Ltej8n3uas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/t7098WiCIEFU7rmvMU4hFFr+I2/F8IFsY7vr0K0xgSZRP+O42r2PJ7A1T0xh04JehtzrxW6H5fQ7+w15oOj+/uDjXPsgM47Lj/TFho71zhMXSP7Jnt8dMx+QZO0B/jJIk4Ixepp7JmcnaPoLek9NvnhkIZ9wWEqZASFzZLqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=kIabRhxv; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=ScdLUi7Tz/pPrIV0NjyW4U23VIueAMMWyx8pCW4VZCI=;
	b=kIabRhxvNKZM0EOI0x7ezn3kFDiHT7Qm8gIvQ0BYtJpuVmeKcBUdD0GswFJM4ppsDTAfe2nGvvNzW
	 EXD8tBZpck/HdmqTgASPLT6zjPnhfW3/RUZoI4rvTNKJWHwAwbHtRCS6+DhaCeZlMw5IfwJYZIDLbv
	 yFmJKLYi1x+eMUSaqnjmy9vIa1tanmteksbq2doEgc7rmR2DgCCx8crqZVfC+RlwGFmiNWbIBl4xWb
	 9hNRV0yBO/HZHtotQkzznJ1DRPpbuM1Z29ahTt8cX/J5e94fqC11tRXXsFVnIUte9MEJLYq6n/Hq7j
	 UdYFbNO1fjxZ0AANHx3zEmpP069LWnA==
X-MSG-ID: 05ec3115-949f-11f0-9d65-00505681446f
Date: Thu, 18 Sep 2025 16:51:56 +0200
From: David Jander <david@protonic.nl>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jonas Rebmann <jre@pengutronix.de>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: add Protonic PRT8ML board
Message-ID: <20250918165156.10e55b85@erd003.prtnl>
In-Reply-To: <af554442-aeec-40d2-a35a-c7ee5bfcb99a@lunn.ch>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
	<20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>
	<af554442-aeec-40d2-a35a-c7ee5bfcb99a@lunn.ch>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 16:14:28 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +			port@4 {
> > +				reg = <4>;
> > +				ethernet = <&fec>;
> > +				label = "cpu";
> > +				phy-mode = "rgmii-id";
> > +				rx-internal-delay-ps = <2000>;
> > +				tx-internal-delay-ps = <2000>;
> > +
> > +				fixed-link {
> > +					full-duplex;
> > +					speed = <100>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&fec {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_fec>;
> > +	phy-mode = "rgmii"; /* switch inserts delay */
> > +	rx-internal-delay-ps = <0>;
> > +	tx-internal-delay-ps = <0>;
> > +	status = "okay";
> > +
> > +	fixed-link {
> > +		full-duplex;
> > +		speed = <100>;
> > +	};  
> 
> You have an RGMII interface, but you run it at 100Mbps? That might be
> worth a comment somewhere to explain why.

Yes, unfortunately the SJA1105Q does not support PAUSE frames, and the i.MX8MP
FEC isn't able to sustain 1000Mbps (only about 400ish) due to insufficient
internal bus bandwidth. It will generate PAUSE frames, but the SJA1105Q
ignores these, leading to packet loss, which is obviously worse than
restricting this link to 100Mbps. Ironically both chips are from the same
manufacturer, yet are incompatible in this regard.

Best regards,

-- 
David Jander

