Return-Path: <netdev+bounces-23127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A476B062
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC26281838
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3989420F80;
	Tue,  1 Aug 2023 10:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F31F94D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:07:39 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AA0CF;
	Tue,  1 Aug 2023 03:07:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67785C0007;
	Tue,  1 Aug 2023 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690884455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWt1iHAsmrfK3BwrkrMdjb6oetsmwYgFvyU2cU/2Gk8=;
	b=j0ab26/LBkhJu/rDBUgxTxpfUHsrUu+mfwFrtSgmX9T5+Pk0LuHAPLV/9JflTk/bXN78Iw
	GxNpsOf5oXmOU1WefL+SDb12OMzJALhot9d8BpXmrOJkwqiKU9u+qM4F6K1E5nj0lBfb7+
	gLCrL+TlVu1b+Du7sMnHz75yki1Sho1tzxFptk2CFoK+gEUyxpzLNZKbZLUIg8VILRvTNC
	jA293aUHVMzqAS7Ih35p4vP9mjBeznj8kVMegn7AU6mm6wBKKsHMvIdoaGgWGc0lnAr6VS
	XUP/Egyc8NGdUCrdAPow0ErAFNIpObFqtVsobYB9grq6Ebj8meCevmKJMnRnDw==
Date: Tue, 1 Aug 2023 12:07:30 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
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
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 06/28] net: wan: Add support for QMC HDLC
Message-ID: <20230801120730.64e5b58e@bootlin.com>
In-Reply-To: <80341a96-c40f-4a45-9bad-359a890edfc4@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
	<20230726150225.483464-7-herve.codina@bootlin.com>
	<80341a96-c40f-4a45-9bad-359a890edfc4@lunn.ch>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 1 Aug 2023 11:31:32 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static inline struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
> > +{
> > +	return (struct qmc_hdlc *)dev_to_hdlc(netdev)->priv;  
> 
> priv is a void *, so you don't need the cast.
> 

Right, I will change in the next iteration.

Regards,
Hervé

