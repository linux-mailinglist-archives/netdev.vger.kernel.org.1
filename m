Return-Path: <netdev+bounces-38681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444BB7BC207
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750751C20924
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F18450EB;
	Fri,  6 Oct 2023 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqqUlsyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1971450DC;
	Fri,  6 Oct 2023 22:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CD3C433C7;
	Fri,  6 Oct 2023 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696630092;
	bh=S/N63H4X+QPAGfS1YS/mBfx58DuAbwAsy+1fq8W1EuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lqqUlsyH7HQbKjX6+5MZaW5p3Joc5/jp6VffbnbSi4frEd/pPhmgULRdlX5REnhpP
	 BK2xli8u32zh+fkxpuHUOLaTi6MD1PXmD4uaT4ger+hlNVtAIdfLCOrFRtKzFzQdQz
	 2sQXEvvtRBzYF6TTKxDU1a+OboOZzIkfFfzieoDXlciUuulj9kl61ww0wJPKsFKgrl
	 bG0J56gOoLjF3VNIh6eD3ijl/+KNdaIHPaK1qZBx8m+Qm/Nj6jA1it1GsSd/KDmDTO
	 8t97yI7Q9ito8x5R+7R8OzvwKOZlUfEqCdWiEARsL6pB/CF8A3b9DgN6yKbMV0niw2
	 jzXwcskBcwReg==
Date: Fri, 6 Oct 2023 15:08:10 -0700
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
Subject: Re: [PATCH v7 24/30] net: wan: Add framer framework support
Message-ID: <20231006150810.09e2c1a9@kernel.org>
In-Reply-To: <20230928070652.330429-25-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
	<20230928070652.330429-25-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 09:06:42 +0200 Herve Codina wrote:
> +menu "Framer Subsystem"
> +
> +config GENERIC_FRAMER
> +	bool "Framer Core"
> +	help
> +	  Generic Framer support.
> +	  A framer is a component in charge of an E1/T1 line interface.
> +	  Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> +	  frames. It also provides information related to the E1/T1 line.
> +	  Used with HDLC, the network can be reached through the E1/T1 line.
> +
> +	  This framework is designed to provide a generic interface for framer
> +	  devices present in the kernel. This layer will have the generic
> +	  API by which framer drivers can create framer using the framer
> +	  framework and framer users can obtain reference to the framer.
> +	  All the users of this framework should select this config.

maybe make the menu a menuconfig with info about framers but hide 
the GENERIC_FRAMER symbol? The driver 'select' it anyway, what's
the point of prompting the user..

> +	if (WARN_ON(!dev))
> +		return ERR_PTR(-EINVAL);

no defensive programming, let the kernel crash

> +	ret = framer_pm_runtime_get_sync(framer);
> +	if (ret < 0 && ret != -EOPNOTSUPP)
> +		goto err_pm_sync;
> +
> +	ret = 0; /* Override possible ret == -EOPNOTSUPP */

This looks pointless given that ret is either overwritten or not used
later on

> +	mutex_lock(&framer->mutex);
> +	if (framer->power_count == 0 && framer->ops->power_on) {
> +		ret = framer->ops->power_on(framer);
> +		if (ret < 0) {
> +			dev_err(&framer->dev, "framer poweron failed --> %d\n", ret);
> +			goto err_pwr_on;
> +		}
> +	}
> +	++framer->power_count;
> +	mutex_unlock(&framer->mutex);
> +	return 0;

