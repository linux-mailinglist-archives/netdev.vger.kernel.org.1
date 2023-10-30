Return-Path: <netdev+bounces-45327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739DA7DC1EC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33F11C20B21
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF41C2B4;
	Mon, 30 Oct 2023 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70476D285;
	Mon, 30 Oct 2023 21:31:50 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9EE1;
	Mon, 30 Oct 2023 14:31:49 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b40d5ea323so3087114b6e.0;
        Mon, 30 Oct 2023 14:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698701508; x=1699306308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuBaURUuWJkEQpbZhWeSxspKPPb+Lr69ekE2ADTt8Wc=;
        b=ctMEZumrolkdnjByFGUWOWQUVnxi61WDindnpVDBDNpzKALR2zuRQXMFQv3Jd5iooU
         x51LimDOvJH9znKkaZBhlkoRhXWRNxjsMq/XXpLbkWnxQLvwxODQNvNc0TaibUEYD6lA
         R6CvOWkxJV00ZYY8USh6XMIS+KnNY1HFJI0E+3j1TQ1J6h8Bmo/YDvAf1mzP8Pmr4HkX
         hmBE/1R/U3ZVuG6TFwInTBUqd0YBqkwIXfN8r3aee0MO8VZK6u6BpfiwS+3tMrsw0MPl
         qoPctdqhQQJKi9h4NHptdoJZv7POl3t7K9Q4APAXB42kYVEoNgDSjMEKA0jHBrXFnrGg
         JfeA==
X-Gm-Message-State: AOJu0YyAIfB3gcDoPI56bcesX54lm/i11vsNoxr0EJnYzGiVMr9pB7Oo
	XqqBGB66HsM4a05SG4tpDg==
X-Google-Smtp-Source: AGHT+IGKuby//PdBhTBpw28HsYfEui30ghahooRRo1gU9DZgJ7OM+SQsCkxRsIdIYwyzeeSbhBnk8w==
X-Received: by 2002:a05:6808:1789:b0:3ae:554b:9c97 with SMTP id bg9-20020a056808178900b003ae554b9c97mr14084990oib.37.1698701508322;
        Mon, 30 Oct 2023 14:31:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a05680809b600b003afc33bf048sm1518710oig.2.2023.10.30.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:31:47 -0700 (PDT)
Received: (nullmailer pid 2495794 invoked by uid 1000);
	Mon, 30 Oct 2023 21:31:46 -0000
Date: Mon, 30 Oct 2023 16:31:46 -0500
From: Rob Herring <robh@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>, Herve Codina <herve.codina@bootlin.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Qiang Zhao <qiang.zhao@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 00/30] Add support for QMC HDLC, framer infrastructure
 and PEF2256 framer
Message-ID: <20231030213146.GA2490536-robh@kernel.org>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
 <20231013164647.7855f09a@kernel.org>
 <20231025170051.27dc83ea@bootlin.com>
 <20231025123215.5caca7d4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025123215.5caca7d4@kernel.org>

On Wed, Oct 25, 2023 at 12:32:15PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 17:00:51 +0200 Herve Codina wrote:
> > > Which way will those patches go? Via some FSL SoC tree?  
> > 
> > This series seems mature now.
> > What is the plan next in order to have it applied ?
> > 
> > Don't hesitate to tell me if you prefer split series.
> 
> FWIW we are happy to take the drivers/net/ parts if there is no hard
> dependency. But there's no point taking that unless the SoC bits
> also go in for 6.7.
> 
> Li Yang, what are your expectations WRT merging this series?

I think it is too late for SoC stuff for 6.7. 

I picked up binding patches 6, 7, and 8 because 6 and 7 are the same as 
an additionalProperties fix I have in my tree. As 8 depends on them, I 
just picked it up too.

Rob

