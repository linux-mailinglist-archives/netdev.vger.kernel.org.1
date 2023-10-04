Return-Path: <netdev+bounces-38095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC37B96B9
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 31539281813
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433924206;
	Wed,  4 Oct 2023 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQXXKp3m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B30219F2;
	Wed,  4 Oct 2023 21:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACD8C433C8;
	Wed,  4 Oct 2023 21:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696456792;
	bh=h1wuJu7EQsw0ISUx0TDepOY/LS54P4l5en5rkpEd2fY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IQXXKp3mHSs7C3RpBvqk6NjjA3omclpdvfBr+th98AGd/jJHwr+SNYt3DrQA/tTC6
	 CGVXbkPAeLNP+ogRrvru18i0GSibBl+w7HXMap5DQDuOrYmLdw+Tx1W6/MbCpIrsYq
	 uQ3amhujSUY0KGp2MM38dxsXREQ33YXtIE15pnkYiOSaXPIiIUmxtBEpzyfZ9vgDDo
	 bI7OyMePLY5CWCjr27kEoifclTlu1G2sjnuJ22oAvnoWRy9zz4MvD4Uf4V77e1j84o
	 PZj8x033qUbHukwEnp7u6/RJOHhxm8BSYTwVY5olkQb+SrKjjXJGu8bwuLwx25JHMi
	 kQ8hdjMEwCLSQ==
Date: Wed, 4 Oct 2023 14:59:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev, Mario
 Castaneda <mario.ignacio.castaneda.lopez@nxp.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-imx: request high frequency mode
Message-ID: <20231004145951.570a8ce4@kernel.org>
In-Reply-To: <20231004195442.414766-1-shenwei.wang@nxp.com>
References: <20231004195442.414766-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Oct 2023 14:54:42 -0500 Shenwei Wang wrote:
> Some i.MX SoCs like the i.mx8mq support adjusting the frequency of the
> DDR, AHB, and AXI buses based on system loading. If the dwmac interface
> in the driver does not request a HIGH frequency, it can significantly
> degrade performance when the system switches to a lower frequency to
> conserve power.
> 
> For example, on an i.MX8MQ EVK board, the throughput dropped to around
> 100Mbit/s on a 1Gbit connection:
> 
>     [ ID] Interval           Transfer     Bitrate
>     [  5]   0.00-10.00  sec   117 MBytes  97.9 Mbits/sec
> 
> However, throughput can return to expected levels after its driver requests
> the high frequency mode. Requesting high frequency in the dwmac driver is
> essential to maintain full throughput when the i.MX SoC adjusts bus speeds
> for power savings.

Oh, another one in one day :S Although this one feels much more like
a bug that escaped testing because testing didn't use power saving?
In any case, do you happen to have a user report you can mention here?
Quoting stable rules:

| Serious issues as reported by a user of a distribution kernel may also
| be considered if they fix a notable performance or interactivity
| issue. As these fixes are not as obvious and have a higher risk of a
| subtle regression they should only be submitted by a distribution
| kernel maintainer and include an addendum linking to a bugzilla entry
| if it exists and additional information on the user-visible impact.

And a Fixes tag would be good, please add.
-- 
pw-bot: cr

