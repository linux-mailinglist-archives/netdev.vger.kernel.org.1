Return-Path: <netdev+bounces-51778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0E67FC042
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A0B21470
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79AF5C8FE;
	Tue, 28 Nov 2023 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AKK5qcPc"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC96E6;
	Tue, 28 Nov 2023 09:26:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5DAB60005;
	Tue, 28 Nov 2023 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701192404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bng8R5x/Jmq2SVxmDJwMSiwsK4vhqKDM3h6nqdBSV2s=;
	b=AKK5qcPcfM1hiW5bzr3BhkVuOFr724YPqPa74JpMexXiVIIJB8NpxTTx5iws+jqvFTmzKe
	spY8WrOUXoem/qgXMTVJ2910ttXabpuTGG70MuZp5z5dxN99O4e0PcyVI/8CNzzDK7J3J+
	f1Zgd3K6cWN3DTLrkCj/pNHcg7nRF4dfaeQNz016qiFh4vNszeVlCdrSOvDdlNoqgYpm+P
	PD2N/3MCCql4071pAIpf1BRkJqTYm5tzprPYWkJlAj48bvJt3/Ccm5L5qbSZHuUsIAO+QB
	6lOA9DMmFQYoQQaanpr3Z9ceucEwY881QiV9dW3Fe1r0jcmn2fr9WOQ1UX6MmA==
Date: Tue, 28 Nov 2023 18:26:41 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH net] net: stmmac: dwmac-socfpga: Don't access SGMII
 adapter when not available
Message-ID: <20231128182641.7e2363c0@device.home>
In-Reply-To: <50d318fd-a82c-4756-a349-682b867c0b8b@lunn.ch>
References: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
	<50d318fd-a82c-4756-a349-682b867c0b8b@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew,

On Tue, 28 Nov 2023 17:37:30 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Nov 28, 2023 at 10:45:37AM +0100, Maxime Chevallier wrote:
> > The SGMII adapter isn't present on all dwmac-socfpga implementations.
> > Make sure we don't try to configure it if we don't have this adapter.  
> 
> If it does not exist, why even try to call socfpga_sgmii_config()?
> 
> It seems like this test needs moving up the call stack. socfpga_gen5_set_phy_mode():
> 
> 	if (phymode == PHY_INTERFACE_MODE_SGMII)
> 		if (dwmac->sgmii_adapter_base)
> 			socfpga_sgmii_config(dwmac, true);
> 		else
> 			return -EINVAL;

I don't have access to a platform with the SGMII adapter available, but
my understanding is that we shouldn't error-out when we don't have the
adapter, as some other component (like the lynx PCS) might be there to
handle that mode.

However you have a valid point in that we might want to check if we
have either an SGMII adapter or a PCS, and if we have none of these we
error-out. Thanks for the suggestion, I'll address that :)

Maxime

