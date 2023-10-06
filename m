Return-Path: <netdev+bounces-38679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D27BC1F3
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB011C2093D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0851450CE;
	Fri,  6 Oct 2023 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr5hNZS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530D450C9;
	Fri,  6 Oct 2023 22:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C4CC433C7;
	Fri,  6 Oct 2023 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696629774;
	bh=5qNpTHdPbPHNPOq+CPvh8QULUoFCrWL4op5DAxKIpGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mr5hNZS7cPEC9fZ9Pm1otMuyEoQtn5x0MebbmvDKT1ysxZd56Xx+tCIEM8QZkQ0Rx
	 2HUNxrgaPRHz8QjWANUbD1mH6curuCdl6HomjYf2KnrCtmGyAAnY5ufgjcVH8v/6jb
	 QG2jDbcpxxyNYg4G8snQQRAUJZiH1mXGOYt8SQQGeANRY51XoIQTOlWK6yuYXJMFzl
	 JuNX4YzwFq+kxxRqEiTycDfkPmkv5j5xhBajGBUP1pMm0yb+NbugndmWBLihXxE3sN
	 +UAuDIx49s6xJ7b8nNHq77RCfPL2Bx0miv1JSuqRDSCA4eQG0Z9vQ8/jx1890NcVXF
	 fyDg6rJJsfGGg==
Date: Fri, 6 Oct 2023 15:02:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Simon
 Horman <horms@kernel.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 26/30] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
Message-ID: <20231006150252.6d45be95@kernel.org>
In-Reply-To: <20230928070652.330429-27-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
	<20230928070652.330429-27-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 09:06:44 +0200 Herve Codina wrote:
> +	for (i = 0; i < count; i++) {
> +		(audio_devs + i)->name = "framer-codec";
> +		(audio_devs + i)->of_compatible = compatible;
> +		(audio_devs + i)->id = i;

Why not array notation?

> +	}
> +
> +	ret = mfd_add_devices(pef2256->dev, 0, audio_devs, count, NULL, 0, NULL);

Should Lee be CCed for the MFD part?

