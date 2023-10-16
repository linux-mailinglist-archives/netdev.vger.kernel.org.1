Return-Path: <netdev+bounces-41272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED997CA6FD
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212DCB20DDA
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497D262AA;
	Mon, 16 Oct 2023 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOUh9ZJ2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F782628A;
	Mon, 16 Oct 2023 11:52:15 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32406E5;
	Mon, 16 Oct 2023 04:52:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso2719271a12.0;
        Mon, 16 Oct 2023 04:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697457131; x=1698061931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TWA9LwAA8tsEVaY9yQUvcKb1zGp7WNzBzeWulwFOsY=;
        b=UOUh9ZJ2ZtxWQYAAaFaM44H6oF/uyu+/HUTgxTMSQF/mPnCysT8auabmA6C6BN1Hr4
         qSjnZgkRZsl69UiGzMhsf2Vl0Uvkjv6Yc8zacUAAxuKJrv35+ixcsRkh8gfeHJ+TgzM1
         L1TJUgkmO1kKkwY+1t81qO1hFOEf8KpF2w1rIMQs3ypTbuCm0tXWoM9X9UiWVrTq4YQ+
         URFAe0xpW13MQOB+7Pk2/kyBrOnOWL+JwjD1UISeFyg5lOLJQhRxtv/UnQaP3puYc5y/
         wjB6QgvSAjeqNlfPzsqs52EF70wf0lZAvs6uhGO4s89KmDkQJxdVs1oU7wTbfTqrtmC4
         q/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457131; x=1698061931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TWA9LwAA8tsEVaY9yQUvcKb1zGp7WNzBzeWulwFOsY=;
        b=Qmi0Inp5qB9q0FlO9t44yErP4G87l0QRM3bsr5/nSz+mbNpf7+RsHwxk/Ww3FHEKrg
         2WAJvnI2U+9ZJAw608omJ9DmRIfb0wcTKPyTMJ58oCX6HMOqoSmbHOnvhF/gpSzRwFMw
         ouLvkI/73C9tulnEUY1Tx5ICBxIzmWoflazSfyjMDuCuLW8vv2B3Fa7xU7E93YHCPJow
         X3liNHahzDbBAbnhjCFZs64wJSh2djzTZPULEdQJqCt3KPrSzg7MYVVbo1dL+oEV3lDf
         9a0n+vkdtTeLETaQxQwh3YOTtXS99dw+cIEhre33ZAC5NwY/uIv2WaWvmqcB7a2MmY/b
         F6jA==
X-Gm-Message-State: AOJu0YxETHCTxITJ1XS8+5SSXdIIvw2WL4FOpt+3FzgpT7mbGPht76q5
	04wKjlpOTWYcassK78q7yjghzq+xnYQxcg==
X-Google-Smtp-Source: AGHT+IFPCJmiJnv0H5Ibu+0EgGaiO1e4yhydt0CO23AM5hIh8EAM544OLHRLRDgCjmk1myJR8lwv/Q==
X-Received: by 2002:a05:6402:3212:b0:53d:b5bc:6415 with SMTP id g18-20020a056402321200b0053db5bc6415mr13068236eda.15.1697457131517;
        Mon, 16 Oct 2023 04:52:11 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a26-20020a50e71a000000b00537963f692esm15555389edn.0.2023.10.16.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:52:11 -0700 (PDT)
Date: Mon, 16 Oct 2023 14:52:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/6] dt-bindings: marvell: Add Marvell
 MV88E6060 DSA schema
Message-ID: <20231016115208.434cpmke4q3g3lwu@skbuf>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-2-38cd449dfb15@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-2-38cd449dfb15@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:12:55AM +0200, Linus Walleij wrote:
> +description:
> +  The Marvell MV88E6060 switch has been produced and sold by Marvell
> +  since at least 2010. The switch has one pin ADDR4 that controls the
> +  MDIO address of the switch to be 0x10 or 0x00, and on the MDIO bus
> +  connected to the switch, the PHY:s inside the switch appear as

PHYs without :, I guess

> +  independent devices on address 0x00-0x04 or 0x10-0x14, so in difference
> +  from many other DSA switches this switch does not have an internal
> +  MDIO bus for the PHY devices.

