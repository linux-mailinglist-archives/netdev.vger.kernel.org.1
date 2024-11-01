Return-Path: <netdev+bounces-140840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A939B8788
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005EA1C20EB7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC5C2C9;
	Fri,  1 Nov 2024 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKNmiPW7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C02AD4B;
	Fri,  1 Nov 2024 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420175; cv=none; b=nHdPGGWOia9ruoInQIgKvTfcgPNndoIJi0ExXPCm4lE9qYmMXYA5CuDwsBjLfa4apnKrVO37vcWRjHJhY1u07kNmFeIGE/o6Ny/fqIkxKV/nn0aijeCO6VYrwpaj51Jp2wWXZ5Vk1u8/CJdYBlkRS+KFyNk/JQVS8DJsgJnnzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420175; c=relaxed/simple;
	bh=r4jj0LH5RQvdecZM1M4ycQJejrglh2pgKdlUTHIpaFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ehv6VCWXFKwQASD38sstwsgoG/zmbk/qhojSQf1/XjtuEsSXBIqSMJfmVhUAULfp7EO5iAl46eCUskJEAYRMsA5PCVWFNGSvxpMP44xcwuD/jGLEi2dLll0PNzzbpT/T43p6INlvA3h7X7fcIl6KQznVI3swXMXHsBXaJ9TKnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKNmiPW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288EEC4CEC3;
	Fri,  1 Nov 2024 00:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730420175;
	bh=r4jj0LH5RQvdecZM1M4ycQJejrglh2pgKdlUTHIpaFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKNmiPW7+Ov3Ib7mGxuDadu1x8DOtgI7AFtQjgFPc8Q2gQjZi8DuQYIDtS9Moe4iw
	 8thCv71U/qrfAU8wOObC7RYDdeIwWX7sBsGWWvcsUj7VVtojCrkZAUjp/00TkDznGU
	 ge37UIa/kJC8I+QqUaDh53HpjUPUd6lpf3bI0lowU8LlfbPH0oIy83kPQv9z1kbR2S
	 ENnBOjg4RIyU8AxJMB14K/YAMeOigVHNddy4WUrUqSoJd+2LmXIcBs5OwgOdV2zUU9
	 JnHSZHPQgFWIm1Yfja/kGT17jz7nxrcz9bMaXDJCZDOjxtRTqLPpeiCWvlebMP1VSg
	 QnvLO3q4A2LQg==
Date: Thu, 31 Oct 2024 17:16:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
 <jensemil.schulzostergaard@microchip.com>,
 <Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
 <ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 10/15] net: lan969x: add PTP handler
 function
Message-ID: <20241031171613.565e6eb7@kernel.org>
In-Reply-To: <20241031093628.faiupqqny7oco7uz@DEN-DL-M70577>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
	<20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com>
	<20241030180742.2143cb59@kernel.org>
	<20241031093628.faiupqqny7oco7uz@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 09:36:28 +0000 Daniel Machon wrote:
> > For a followup for both drivers -- you're mixing irqsave and bare
> > spin_lock() here. The _irqsave/_irqrestore is not necessary, let's
> > drop it.
> >   
> > > +             spin_lock(&sparx5->ptp_ts_id_lock);  
> 
> Hi Jakub,
> 
> I agree it seems wrong to mix these.
> 
> I just talked to Horatiu, and he mentioned posting a similar fix for the
> lan966x driver some time ago [1]. Only this fix added
> _irqsave/_irqrestore to the ptp_ts_id_lock - so basically the opposite
> of what you are suggesting. Why do you think that the
> _irqsave/_irqrestore is not necessary?

Oh, I thought this is a real IRQ handler, not a threaded one.
I haven't read the code to figure out whether ptp_ts_id_lock
needs to be IRQ-safe, but in other places you lock if _irqsave
so yes, let's irqsave here, too.

