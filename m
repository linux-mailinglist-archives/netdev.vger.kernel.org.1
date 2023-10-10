Return-Path: <netdev+bounces-39458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD67BF505
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060F6281B6E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC3B14F6F;
	Tue, 10 Oct 2023 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UAlqB76M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA94435;
	Tue, 10 Oct 2023 07:57:43 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE791;
	Tue, 10 Oct 2023 00:57:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7D45C0017;
	Tue, 10 Oct 2023 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696924659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HGCDW6dA/uAJ0GZAXHKMPSuwZNEP4AsO/ZK/lFHFUk=;
	b=UAlqB76MFympUYcFakSns2mIOgF13pHihMAEYgL1b92u9tsMq8XEVIkpDSc2USgjXn29Dj
	teMJY1lY51yixmRurzbAu6X/It5Prspi6Id1Wa32QHK/EHhiboyV1E/GwksW+XgJBr/BD+
	gMzW3HEboeZULdc0q/po4tOFO145hK5LVo9/hA9YMl3NC5d4IgxP0MpIywwHIVhWpcYl7C
	742U/PmD0Bnm2nlDzGfyngXvb5P5pZawz1yZlpNRIWYKL94NO72XcNjZfdd26znmNKgahB
	ft3/z9/2lF6GWH7GXWiTQEQSVY54kM8V13b7SYnq1pYaTJi9zxGcx8zm4m1HJA==
Date: Tue, 10 Oct 2023 09:57:33 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20231010095733.6899abbb@bootlin.com>
In-Reply-To: <20231006150810.09e2c1a9@kernel.org>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
	<20230928070652.330429-25-herve.codina@bootlin.com>
	<20231006150810.09e2c1a9@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub

On Fri, 6 Oct 2023 15:08:10 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 28 Sep 2023 09:06:42 +0200 Herve Codina wrote:
> > +menu "Framer Subsystem"
> > +
> > +config GENERIC_FRAMER
> > +	bool "Framer Core"
> > +	help
> > +	  Generic Framer support.
> > +	  A framer is a component in charge of an E1/T1 line interface.
> > +	  Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> > +	  frames. It also provides information related to the E1/T1 line.
> > +	  Used with HDLC, the network can be reached through the E1/T1 line.
> > +
> > +	  This framework is designed to provide a generic interface for framer
> > +	  devices present in the kernel. This layer will have the generic
> > +	  API by which framer drivers can create framer using the framer
> > +	  framework and framer users can obtain reference to the framer.
> > +	  All the users of this framework should select this config.  
> 
> maybe make the menu a menuconfig with info about framers but hide 
> the GENERIC_FRAMER symbol? The driver 'select' it anyway, what's
> the point of prompting the user..

Yes, I will change in the next iteration.

> 
> > +	if (WARN_ON(!dev))
> > +		return ERR_PTR(-EINVAL);  
> 
> no defensive programming, let the kernel crash

Will be changed.

> 
> > +	ret = framer_pm_runtime_get_sync(framer);
> > +	if (ret < 0 && ret != -EOPNOTSUPP)
> > +		goto err_pm_sync;
> > +
> > +	ret = 0; /* Override possible ret == -EOPNOTSUPP */  
> 
> This looks pointless given that ret is either overwritten or not used
> later on

Indeed. Will be removed in the next iteration.

> 
> > +	mutex_lock(&framer->mutex);
> > +	if (framer->power_count == 0 && framer->ops->power_on) {
> > +		ret = framer->ops->power_on(framer);
> > +		if (ret < 0) {
> > +			dev_err(&framer->dev, "framer poweron failed --> %d\n", ret);
> > +			goto err_pwr_on;
> > +		}
> > +	}
> > +	++framer->power_count;
> > +	mutex_unlock(&framer->mutex);
> > +	return 0;  

Best regards,
Hervé

