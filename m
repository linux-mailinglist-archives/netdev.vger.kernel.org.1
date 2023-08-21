Return-Path: <netdev+bounces-29296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C880D7828CE
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59630280E78
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844D53B2;
	Mon, 21 Aug 2023 12:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A96185B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC9C433C8;
	Mon, 21 Aug 2023 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692620250;
	bh=veiDrmwqJU+LoUoffNhEFba5PtaFW4YWJImLcQ1gViU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZ/bcmF0SGuuPh/Fr//uzxTs9s0uTNFMC38LvMOvmDtRaZKtCevzLk4gZG5ijLic+
	 S77tyzVzxZIeaq5QQie+0NJ7cip+g8goSjREnFxw2+YWjUk9SIOwzP/8bPkVYIjWIa
	 UJKXoS9zx7vrLi9SzLBicrnM8KGcEufV5aZPkfFFNCKfWYultt4gY+xpGfnPNorlHU
	 sRR8dOWJb0DA8thc0XmU/4ErPDDBpvU11NFruKx4FH9YSE/AfRrkWFpxVyUpNn7Yxo
	 p3fH52kDPvrBoaJ3q3V9Qq4PE1+KTpgj20k1XL5leYW3dtC0BAiJZH3urMeW8CT2rn
	 Y2Hd9JlhNl+9g==
Date: Mon, 21 Aug 2023 13:17:21 +0100
From: Lee Jones <lee@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 23/28] mfd: core: Ensure disabled devices are skiped
 without aborting
Message-ID: <20230821121721.GH1380343@google.com>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
 <528425d6472176bb1d02d79596b51f8c28a551cc.1692376361.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <528425d6472176bb1d02d79596b51f8c28a551cc.1692376361.git.christophe.leroy@csgroup.eu>

On Fri, 18 Aug 2023, Christophe Leroy wrote:

> From: Herve Codina <herve.codina@bootlin.com>
> 
> The loop searching for a matching device based on its compatible
> string is aborted when a matching disabled device is found.
> This abort prevents to add devices as soon as one disabled device
> is found.
> 
> Continue searching for an other device instead of aborting on the
> first disabled one fixes the issue.
> 
> Fixes: 22380b65dc70 ("mfd: mfd-core: Ensure disabled devices are ignored without error")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/mfd/mfd-core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

This is too big of a change to be added this late in the cycle.

Pushing review until after v6.5 is out.
-- 
Lee Jones [李琼斯]

