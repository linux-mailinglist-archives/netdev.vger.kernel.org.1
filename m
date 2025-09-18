Return-Path: <netdev+bounces-224504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F9CB85A77
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0977B6F64
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113273112A9;
	Thu, 18 Sep 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="QQemO7m4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8F3101D1
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209701; cv=none; b=JQEsZlqtBG/nw7ghi6BKD7uTfEMEAJr0mbQvPekl8i3tmBWlnGzfX3DVKfF0LOMLP2azOfsewlOq2G7Rm8PmNl/TsP7xnD4QgLz4GWSlQLk/HjQ1Lb+yzzxQRprom957ewocS+Jv0iqLD8yPL1qiHfr0eEWgW+vOT+1zBfqeF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209701; c=relaxed/simple;
	bh=1L4ztzZI21TGZatF3aNWfrnQCTgXQdveVEOhyL3fA0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbf1oF0LhgiQvFnOWEVu0LKYbU29UN7oZzdu14DQNcw0gJtn6XCRCRxq+XHptM85zgD9cVrc0+iQVGIvv9it07VVvT11w/PAmTHOc0qc+BF1AooPPqxle+TycPdfsNnlxZsumY752pxWftjpougO0g/EckNv2q3xRlg/BooKD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=QQemO7m4; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=SqjdATjfjZTk7QANAggTs1mW/P13EV6a+Izt0r+agQ0=;
	b=QQemO7m4x6zCxk4M9laZ90eCIBZvlHRq/VuixCptBB7zzwo7W14mF7GpiYLDE2KravDs5mWr5Fe32
	 YI5vbPnjY8XchNI9DA2VxwqrhGOoXIMDArJfiLqW1D+YRL2YnyHQ4WHp2jj+Z3dwdLVow44GMCxb0b
	 S6ozX0oObc8Pf1HBbvovaxNrs8/iL/hnZAJYohUXXEqDuxD0E+wq2MS2PgcGQeAqkHwHgbtE3szPdO
	 LY51aW6TvUu1QOAIlIzGxXruryI8IjrqSj/QbUYXHmCSZMbUySBHPD6UI6terkJcLsOTJupcY0AuoB
	 JpIpBWXwmgF0fXl9CqpcwJtEM9ZcoKQ==
X-MSG-ID: df093cf2-94a4-11f0-858c-005056817704
Date: Thu, 18 Sep 2025 17:33:47 +0200
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
Message-ID: <20250918173347.28db5569@erd003.prtnl>
In-Reply-To: <7f1d9289-4102-4db9-a2bb-ff270e8871b7@lunn.ch>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
	<20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>
	<af554442-aeec-40d2-a35a-c7ee5bfcb99a@lunn.ch>
	<20250918165156.10e55b85@erd003.prtnl>
	<7f1d9289-4102-4db9-a2bb-ff270e8871b7@lunn.ch>
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

On Thu, 18 Sep 2025 17:04:55 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Yes, unfortunately the SJA1105Q does not support PAUSE frames, and the i.MX8MP
> > FEC isn't able to sustain 1000Mbps (only about 400ish) due to insufficient
> > internal bus bandwidth. It will generate PAUSE frames, but the SJA1105Q
> > ignores these, leading to packet loss, which is obviously worse than
> > restricting this link to 100Mbps. Ironically both chips are from the same
> > manufacturer, yet are incompatible in this regard.  
> 
> Thanks for the explanation. Maybe add a comment that the bandwidth is
> limited due to the lack of flow control resulting in packet loss in
> the FEC.
>
> Anything which looks odd deserves a comment, otherwise somebody will
> question it....

Yes! This is a golden tip. Ironically what I said above is incorrect. Sorry
for the noise.

Ftr: I wrote this DT about 4 years ago, so my memory failed me, and a comment
in the code would have saved me this embarrassment ;-)

The comment above applies to the i.MX6 SoC's which had this limitation. On the
i.MX8MP we had a different problem that also caused the SJA1105Q not to work
reliably at 1000Mbps either. We haven't been able to find the issue, but so far
this switch hasn't been able to work at 1000Mbps reliable on any platform,
possibly for different reasons in each case.

Best regards,

-- 
David Jander

