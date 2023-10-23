Return-Path: <netdev+bounces-43535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB307D3CC1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946D81C20A0E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B76125A0;
	Mon, 23 Oct 2023 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V/xOy/CX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F8208A1;
	Mon, 23 Oct 2023 16:40:47 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B993;
	Mon, 23 Oct 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Qgu3sV7JqSs1+xqVkj3Q4GC+iKi/Wf5NSoQxrtF3ew=; b=V/xOy/CXT9JTBGtsL7Y3xvmZwV
	rnjrtnpa5D22ISWgGO9NXgw8FxE1TOh+Ky7E5bQuEIBPVohIRtEarYFHeqnEvmA8GPV33pt+97QuE
	qNoxRycGKX+H0q2vf7UImSz8VoL2M2kkyftM18WG2htwIMUd1lNv1JzSTbHPyZMJga6Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1quxyl-0032zT-EI; Mon, 23 Oct 2023 18:40:35 +0200
Date: Mon, 23 Oct 2023 18:40:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 2/5] net: dsa: qca: Make the QCA8K hardware
 library available globally
Message-ID: <3f279720-5386-4ea2-b54c-ffc44277b1cc@lunn.ch>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-3-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023155013.512999-3-romain.gantois@bootlin.com>

> @@ -62,21 +61,37 @@ const struct qca8k_mib_desc ar8327_mib[] = {
>  	MIB_DESC(1, 0xa8, "RXUnicast"),
>  	MIB_DESC(1, 0xac, "TXUnicast"),
>  };
> +EXPORT_SYMBOL(ar8327_mib);

Christian should decide, since he wrote most of this code, but i would
prefer EXPORT_SYMBOL_GPL().

> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/include/linux/dsa/qca8k.h
> @@ -13,6 +13,7 @@
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/dsa/tag_qca.h>
> +#include <net/dsa.h>
>  
>  #define QCA8K_ETHERNET_MDIO_PRIORITY			7
>  #define QCA8K_ETHERNET_PHY_PRIORITY			6
> @@ -265,6 +266,7 @@
>  #define   QCA8K_PORT_LOOKUP_STATE_LEARNING		QCA8K_PORT_LOOKUP_STATE(0x3)
>  #define   QCA8K_PORT_LOOKUP_STATE_FORWARD		QCA8K_PORT_LOOKUP_STATE(0x4)
>  #define   QCA8K_PORT_LOOKUP_LEARN			BIT(20)
> +#define   QCA8K_PORT_LOOKUP_LOOPBACK_EN			BIT(21)

Maybe do the move first, and then add new features in another patch?

      Andrew

