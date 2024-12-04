Return-Path: <netdev+bounces-149081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959719E4025
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61757167576
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454620C474;
	Wed,  4 Dec 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="OtiORDSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA81E519;
	Wed,  4 Dec 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331246; cv=none; b=QZdJP/3k79o3Yx1EAgGJ53nS1ViWOC7IPF51gG3YPZ0jTAsEaUDKUnmBtG2VOXvX1ujgbb43nU6oPuceUQy1txqsYqjPCKM20yQmWSaJfDP0Ggox5dLLruhmzRJiXFVnzHnh6kI4cc8r0QQjZWfde1EThve3InN3bFowgvlLLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331246; c=relaxed/simple;
	bh=e2bE1gMZRJN1ciwkvkaR9ANnZMaK8Y5vwF1qpUwSV18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx8pXJHUIP31L0oclE6liD5gRwOrZNhz2Uo6ro6le5Vj9UZ9fh1xTpXIqLGEZZAd9OoZ9dIgwa9DM40KJ5l9d4TCnANzTrw0XYbgx78yFFrYn6zE9vUAmr9z525EZH1Psc7y+y3nZfzdcYBfEFfijZGEfnJ22mHDR2QsiF7TiY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=OtiORDSQ; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1733331200; x=1733936000; i=parker@finest.io;
	bh=uEGlJe4Bxvq2OHTVxLPMc+APrj2QmcCgizfZ45v1DZc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OtiORDSQ8S6w37NRH56VRSCd0cTq6VmBcplAa7Gr39JvCDlmJyuM6lY5WoKnq/fe
	 8GtiSf0tZQ1QLobs3u5hXTNxwxd8QWU6WKctZtyHiN2LdOl/MgwBiDo8p1kZlqN9H
	 hWOdZdWqGbTZjI00E3FczvmMT+x5NYCxAgO/hMGV2cWQpsWEWIKUsZIihwz3nb2j/
	 oEs4fe1gZpzaF3oK3ThOClQu3WOVfx/IaB29LORJfZSdhdD9TU9jsEEPZapp4Fthy
	 J/ytHfbs3wKtSgRYsN+ATlC1DFni0o8uKIVMtbwF6NcJT4gjqH1+dV8xiHubjRtY0
	 Zlplrj90wNGtscrBRg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MeQHZ-1t15bD0w63-00MNLo; Wed, 04 Dec 2024 17:53:20 +0100
Date: Wed, 4 Dec 2024 11:53:17 -0500
From: Parker Newman <parker@finest.io>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <20241204115317.008f497c.parker@finest.io>
In-Reply-To: <mpgilwqb5zg5kb4n7r6zwbhy4uutdh6rq5s2yc6ndhcj6gqgri@qkfr4qwjj3ym>
References: <cover.1731685185.git.pnewman@connecttech.com>
	<f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
	<ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
	<20241115135940.5f898781.parker@finest.io>
	<bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
	<20241118084400.35f4697a.parker@finest.io>
	<984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
	<20241119131336.371af397.parker@finest.io>
	<f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
	<20241119144729.72e048a5.parker@finest.io>
	<mpgilwqb5zg5kb4n7r6zwbhy4uutdh6rq5s2yc6ndhcj6gqgri@qkfr4qwjj3ym>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2blSxbCR+yhs7uQqwCDAGl8YVMbUYXlFl2S+vj7UoTf7mx/o3/0
 cVfef/xPPbcAmmGZKCxA5219hwxj7zniR8sS22Xc3Xbp7A13Qx+l8bhI3xk+BuvS6yTVQqx
 3rIB0xJVNf7VE2+YX2oc/bOGwKGpbXNLPBXPSyloSYE5GIaRSjVblAuPZ0wLQN81nTmTamP
 zGtrJCDhCP43c/+iSDIJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VHLldsp8lP4=;qDrO+hlZavqr0m0PZUgQCQN7L7x
 OkLC7CJic9SAE4vZjfIWlNuBl/yLUXuuolv7XTNZEbg126/CEFnIXMLGLVj6/HXMmIjY+o8U8
 m2kvxNkShFHsZzVmIkLxXHUt6fiHRYVdmAHgAH8WtmVW6AsemzztV2bdIb1Za6HRl+XWCfP9q
 xMbKfqSGyWpdQk/se9G2lGoqe8/hHL5gRYoiTMzJyo/jsGzjqW6gs9W2ojeF1uH987ELN0qqJ
 cpwqvehuCb3qYgPRB1PnzD0ChJdCEVAglRmktl7q6qktmSunidefr0YaqbE5U/cJ6BSRaNQiI
 HZ7J/z2qiQmUkp3wFfyY7GLw84+elwNbVwq1hq/3m5EtlbFUeypNKB7xBX9Xym+gUKshPcMWI
 WSkLGyPm2SOG9cxpNkNKc/DTghchEnLj4smaChMuXlDWRAplm/4TGa4JrZI2E8bsBzxzD3npk
 D7HaJ5xyiXZ9hea1xvXVPnqFujpcjiSHsLxHiA65CIfMAwvS4qxlc7VDr3bDkk2kLehIIJzl9
 eaS+/0b97KVFZOG6KaTxHnA8SjVxU1U7ENSdWFIbI4xoLd3s+Dzma0tU6V9IyJQajIyGlBXuV
 VbfMODpOLGkU7g0ZUiK6J4PYqWgG9Q5tbTMn8CVhKUCmXF0DXgRw//6zGrfM8+Q7aeKlUjRNO
 DfLhsI90y3TqhZ93xbyzYc1p8dYZJTAgH1LezOrJc640tZ+BlB6D0qvLBixZQqV+Wlkh3NqLu
 M3NDOoycnH+jrl5KHKtJ1agh/Ij3EkKa7OWwDLjbq+lsd/3qLh+sGFGwPGMBkLNUbGUDjlrFr
 bHtjIlcqa1+ionooviwWUVbrSH/jxelWZZFhqFyJR6nnzlzELGirxmbjUrYV7xjPA2lu3c7jk
 wp6taO+BsZZHWXQQbZCuvG+qpxWpIsBwQepNFGAhWpWSu3ywmwUjyRTbLxam6Ki4famPQ8mS9
 B1qXrh+gMTfwtY3WhYLlCtv4Wn/CkC9epjsE0Qxy+Vhqp3wHrDkAcQLfd5j521jRiV4bHYC/+
 jxrGHLowUbqlDEVOT06LqVVRKlh7PRPG+/siH+2

On Wed, 4 Dec 2024 17:23:53 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Nov 19, 2024 at 02:47:29PM -0500, Parker Newman wrote:
> > On Tue, 19 Nov 2024 20:18:00 +0100
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > I think there is some confusion here. I will try to summarize:
> > > > - Ihe iommu is supported by the Tegra SOC.
> > > > - The way the mgbe driver is written the iommu DT property is REQU=
IRED.
> > >
> > > If it is required, please also include a patch to
> > > nvidia,tegra234-mgbe.yaml and make iommus required.
> > >
> >
> > I will add this when I submit a v2 of the patch.
> >
> > > > - "iommus" is a SOC DT property and is defined in tegra234.dtsi.
> > > > - The mgbe device tree nodes in tegra234.dtsi DO have the iommus p=
roperty.
> > > > - There are no device tree changes required to to make this patch =
work.
> > > > - This patch works fine with existing device trees.
> > > >
> > > > I will add the fallback however in case there is changes made to t=
he iommu
> > > > subsystem in the future.
> > >
> > > I would suggest you make iommus a required property and run the test=
s
> > > over the existing .dts files.
> > >
> > > I looked at the history of tegra234.dtsi. The ethernet nodes were
> > > added in:
> > >
> > > 610cdf3186bc604961bf04851e300deefd318038
> > > Author: Thierry Reding <treding@nvidia.com>
> > > Date:   Thu Jul 7 09:48:15 2022 +0200
> > >
> > >     arm64: tegra: Add MGBE nodes on Tegra234
> > >
> > > and the iommus property is present. So the requires is safe.
> > >
> > > Please expand the commit message. It is clear from all the questions
> > > and backwards and forwards, it does not provide enough details.
> > >
> >
> > I will add more details when I submit V2.
> >
> > > I just have one open issue. The code has been like this for over 2
> > > years. Why has it only now started crashing?
> > >
> >
> > It is rare for Nvidia Jetson users to use the mainline kernel. Nvidia
> > provides a custom kernel package with many out of tree drivers includi=
ng a
> > driver for the mgbe controllers.
> >
> > Also, while the Orin AGX SOC (tegra234) has 4 instances of the mgbe co=
ntroller,
> > the Nvidia Orin AGX devkit only uses mgbe0. Connect Tech has carrier b=
oards
> > that use 2 or more of the mgbe controllers which is why we found the b=
ug.
>
> Correct. Also, this was a really stupid thing that I overlooked. I don't
> recall the exact circumstances, but I vaguely recall there had been
> discussions about adding the tegra_dev_iommu_get_stream_id() helper
> (that this patch uses) around the time that this driver was created. In
> the midst of all of this I likely forgot to update the driver after the
> discussions had settled.
>
> Anyway, I agree with the conclusion that we don't need a compatibility
> fallback for this, both because it would be actively wrong to do it and
> we've had the required IOMMU properties in device tree since the start,
> so there can't be any regressions caused by this.
>
> I don't think it's necessary to make the iommus property required,
> though, because there's technically no requirement for these devices to
> be attached to an IOMMU. They usually are, and it's better if they are,
> but they should be able to work correctly without an IOMMU.
>
Thanks for confirming from the Nvidia side! I wasn't sure if they would
work without the iommu. That said, if you did NOT want to use the iommu
and removed the iommu DT property then the probe will fail after my patch.
Would we not need a guard around the writes to MGBE_WRAP_AXI_ASID0_CTRL as=
 well?

Thanks,
Parker

> Thanks, and apologies for dropping the ball on this,
> Thierry


