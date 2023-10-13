Return-Path: <netdev+bounces-40900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485CD7C916D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795041C2098A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D12C876;
	Fri, 13 Oct 2023 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcbMzY+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CEB2C85A;
	Fri, 13 Oct 2023 23:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF660C433C8;
	Fri, 13 Oct 2023 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697240624;
	bh=XMsp3WQfHWzYrvwTL5bSfSAdHyGXuKsHrx4YecNlQnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pcbMzY+nvNyIhtSC8ysJbc2lzO4vgdQ56KyCMQKjQkGDFWlLd84I9WSAIk4Jm+sNj
	 smTiXtjEjWCCCx0X3mCBp4QP6yqvUGQ4GFZsJj4MG4B82xN2as+zaYRQVor7myn4Kb
	 H9Nz2T4tDJ8XjCkWfNUfB0Ldim1MFXkOQk6dXZ/eSr+j4A6Y93eih3yk90GTYQVdjv
	 iuDHUZovFOIy6Ef1fwuXyIErv8rcBPcmtTp1c/QGYhJ/Du4//NaPVQpOb5kszMYDTa
	 9EB6SKKVquFXP23KYaWXkjgaTPpFNqK+KvNWtD2Wam7EAGXOdFs4Xpz1X4riRZs6IE
	 RVOLIFYTvlimg==
Date: Fri, 13 Oct 2023 16:43:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 24/30] net: wan: Add framer framework support
Message-ID: <20231013164341.69c6fd6c@kernel.org>
In-Reply-To: <20231011061437.64213-25-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
	<20231011061437.64213-25-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 08:14:28 +0200 Herve Codina wrote:
> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.
> 
> The framer framework provides a set of APIs for the framer drivers
> (framer provider) to create/destroy a framer and APIs for the framer
> users (framer consumer) to obtain a reference to the framer, and
> use the framer.
> 
> This basic implementation provides a framer abstraction for:
>  - power on/off the framer
>  - get the framer status (line state)
>  - be notified on framer status changes
>  - get/set the framer configuration

Acked-by: Jakub Kicinski <kuba@kernel.org>

