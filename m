Return-Path: <netdev+bounces-144138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DE9C5DF3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49318B87F81
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E61F20010B;
	Tue, 12 Nov 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gN8R0y5r"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BF1FF053;
	Tue, 12 Nov 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424344; cv=none; b=pCYWuglR8RAsS75avrHmcjChcC87nMiHFiR2eQgiXTDQ/Ww6g85nCifuxX4BHy6JvGt3+cKzWlVrscVDnbnCvi3ps380hIrR+cxI8XnxRLnU4DuDydAP+vmq9XfdmFHEtpcHe73gO2RFhLACNkPO81ZW3312uyVhEXS+t55kMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424344; c=relaxed/simple;
	bh=FvYDxemAYWoX77GN8sFeA7OVWjIqbPCJa5r4+zu85Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U591I1JSHk12rAWW9ctAYHwxo6F0aP3/glU0tVudP243BZCXAF5tGw/cJfzv/VYhu9WBT8VKWtT0aWP02h4AEE9kDMgnsN1awVjXNvXUWu+xSNuXJ3pFKhkyMDm8VEt3fdR2pFWBydDbr7TC8HqOkvFKFDHMh4fU6I+pyduJ1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gN8R0y5r; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AAF7240006;
	Tue, 12 Nov 2024 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731424339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/ZZ+GzA9JnknmCSiZ4KAoFAxIWZALm0qPy9dvBIJSk=;
	b=gN8R0y5rBADWu+wo+lGHeMRwjS1282FydlI9vD3kgvpHQWTYsItwv0ODr3pyxeUUL9/IZL
	szxsyvU9qROe3EZH29OPtqpzNY1CGgw47LbshgwpkgUVX6VO2bWsajgC4TmMcGHH7r9LlY
	G33EvbRmjGx8br4vfR0EeyZkdPYjWhhRewSY/WUDxk+ZEvI08pmAojF8qfmADEABnJxIG+
	qoyc+4hqVEjd2XnEyLTv/JnKdPv8cfU++ryF0rzS0cTh8FTuDEnlZfczRSAd+U2jb3EZf+
	mfFl/EYf15RQtHk91p5j5TX+qAfHgPZIWoTiawRO5TblLOHnhgPxrTSLqjvRdg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: cathycai0714@gmail.com, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Avi Fishman <avifishman70@gmail.com>
Cc: cathy.cai@unisoc.com, cixi.geng1@unisoc.com,
 David Miller <davem@davemloft.net>, edumazet@google.com, kuba@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 Network Development <netdev@vger.kernel.org>, pabeni@redhat.com,
 wade.shu@unisoc.com, xuewen.yan94@gmail.com, zhiguo.niu@unisoc.com,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Murali <murali.somarouthu@dell.com>, Tomer Maimon <tmaimon77@gmail.com>,
 "Silva, L Antonio" <Luis.A.Silva@dell.com>,
 Arias Pablo <Pablo_Arias@dell.com>,
 Somarouthu Murali <Murali_Somarouthu@dell.com>, uri.trichter@nuvoton.com
Subject: Re: [RFC PATCH] net: stmmac: Fix the problem about interrupt storm
Date: Tue, 12 Nov 2024 16:12:17 +0100
Message-ID: <7732873.EvYhyI6sBW@fw-rgant>
In-Reply-To:
 <CAKKbWA6zRee9Rzee-ebLnEAvwLqnmsPswGaUo_ineyzw-b=EgQ@mail.gmail.com>
References:
 <CAKKbWA7e0TmU4z4O8tHfwE=dvqPFaZbSPjxR-==fQSsNq6ELCQ@mail.gmail.com>
 <CAKKbWA6zRee9Rzee-ebLnEAvwLqnmsPswGaUo_ineyzw-b=EgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

Hello,

On dimanche 3 novembre 2024 20:00:54 heure normale d=E2=80=99Europe central=
e Avi=20
=46ishman wrote:
> Hi all,
>=20
=2E..
> >  Yes. It could also happen between the dev_open() and
> >=20
> > clear_bit(STMMAC_DOWN) calls.
> > Although we did not reproduce this scenario, it should have happened
> > if we had increased
> > the number of test samples. In addition, I found that other people had
> > similar problems before.
> > The link is:
> > https://lore.kernel.org/all/20210208140820.10410-11-Sergey.Semin@baikal=
ele
> > ctronics.ru/>=20
> > > Moreover, it seems strange to me that stmmac_interrupt()
> > > unconditionnally
> > > ignores interrupts when the driver is in STMMAC_DOWN state. This seems
> > > like
> > > dangerous behaviour, since it could cause IRQ storm issues whenever
> > > something in the driver sets this state. I'm not too familiar with the
> > > interrupt handling in this driver, but maybe stmmac_interrupt() could
> > > clear interrupts unconditionnally in the STMMAC_DOWN state?
> >=20
> > Clear interrupts unconditionally in the STMMAC_DOWN state directly
> > certainly won't cause this problem.
> > This may be too rough, maybe this design has other considerations.
>=20
> But then after the dev_open() you might miss interrupt, no?

Indeed, but in any case, unconditionally returning from an IRQ handler with=
out=20
clearing any interrupt flags seems like very strange behavior to me.

Disabling and reenabling interrupts as you suggested does seem like a
good solution for this particular scenario, but it doesn't solve the more
general issue of the dangerous way stmmac_interrupt handles this.

Maybe the setting and clearing of this STMMAC_DOWN bit should
be wrapped in some kind of handler which also disables all interrupts?

Best Regards

=2D-=20
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



