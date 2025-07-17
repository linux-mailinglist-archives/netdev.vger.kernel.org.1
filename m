Return-Path: <netdev+bounces-207833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1585B08BEA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA3A1AA56A9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0D29B23C;
	Thu, 17 Jul 2025 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTiH8TwV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962932CCC5;
	Thu, 17 Jul 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752845; cv=none; b=CLArFIyKM0J8WxSYvgppFdDjDzwFD+MrreZe9qNa6Jq7vh/YoQ0CEqDdmJuxIQ6+9X18WQMd1mXpMk6iFmrWtbHdMm8fa1BjgOmfnDJqWxxGxu1H2JXlK02wDRohL746AzjQgFyS/zn4KfJ+BQko/mJISC0Kr6sKQkYId8Y8vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752845; c=relaxed/simple;
	bh=Q1O9ujEI/+5mMPGKVIHuQmTYkvZY6/Ie/ovaWQ6LnNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU6unDtRsY+TZ56aeQwinpi8ARiD+WoQuqC+cMnF17hwjO+RGh/YbH1Eq43BJHaKG6n0svE2pIw1GE4vmq71m9LejmIelpJUZfAxTe7gq+qNWBEv/udkRX/KrDWrUopMZMg3iYY5wQLSxn49kSWYeaAAawCJsUfva3bTPmOjsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTiH8TwV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-556fd896c99so797349e87.3;
        Thu, 17 Jul 2025 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752752842; x=1753357642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hUzQnHUphnbfFgIY49ERlZzZ414PTUWI3wMK+KFf1L8=;
        b=NTiH8TwVujpGhzNK5mZn7AYCTZsHA4NPGGRNwzhoSfLo6sHNO0t88Ot2g7dHFLXrCW
         P3AyD+9qAVjBjyGGP6gUfe3+hS9zl5DaKKcuRbCB9XptFC65BJhIfa2cEbWJ/0cT4VX/
         G0a/U9+K2dL9QBrXD9EZRIfTkDW0Z+IQpXkeibxdwpjRLl8PVvG1tkINH/n8SZNNbVqF
         U/la1IgQqbJ0MrIr1X/7pqvDaNiI6yXN6C1nHHwjUcV6lAustprLtuS0q2qEJ1bWFnw2
         0g/zuitiwC9sEde4zuBR5FVBcgw5tkM1TbyIrib1Pwy/P3UIeFYqWDqFUnPXJzOGX5tG
         2YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752752842; x=1753357642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUzQnHUphnbfFgIY49ERlZzZ414PTUWI3wMK+KFf1L8=;
        b=Jc/xBNMSBDfWQt0PXVQsPwbfBB4wOJl/tIyaDHKH01UoPUo4KtY4lNXksH3rj4iCXf
         sQc/vE9u5MnojZxPp3Fcrq1UPYvmTaPbI3QonjlQuFP9gFhSCW1y+sSilEGvv+ZMlZpN
         yOHHpCT3XAOkpjuD05+H2sii38C5qvHqKJpa6AUxzKpDP/zznhqYo4DeP3XZ8PWimi0Y
         efWMebRm5hkrqZhOrNZcyn7fyWImycNeuMyAtMgUVnnbzYiSqTONU2gxB2xAdINX3fii
         fV/mPA/3oRt+laR/+YRnEeniUdZGxIHsExqdhJhz3bcX+hfmxamKh9YFB2Y+3JaZOboh
         U2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUfNOIGKPdLZARrT/Yp3/7/A17hRvYowNvyXIyI9ePDI5EfWXUkFeJmsUu/yrb6gmuMJU4692eg@vger.kernel.org, AJvYcCWB8kbizR9AqMJtdLsCXPNXbBmxSauavhKlwUowWt6dOQgiNMCVhl5DntSEXHnvaKZk8RtQz3qkhD+PTko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiI+KNtvWq8o7dkj24QogvDVb714lzkvJye0BQO4QPFTy81pu0
	b3dtjIvhVEtQrQmfUGRzr1us9ctBV4ZM/WldQh/4wo15NEVXHDavUA1o
X-Gm-Gg: ASbGncvKAoyZPANEpxAoIriWazcuNIqE6qVoWew/d2cJRjy5VqA9MajUv7F4v+AzQiG
	TVk/Q5gztzlxIeZ5NDffw7f6OFIszZKi9tpB2eLlgRJaJ/cAHvHqnjsAvk6hSk31b9Hruc1/OOw
	aiufBgEqTAo1Ap9TxzuEpFwcB5epYs94DWyHc0N/Bl+8sleIrx03Fu9vAMpc6+aik9jYWu+ay0C
	vJ59cm1QnqA8kZ2JKU/JbQctoAKZi8koiglJJhuBTtjgF3T7SVtYjhE/KsHbqGn8kMk/hMno6F+
	an+WqQd9K99dMQ5tQpS6LnRu3GJBSDE+asw82BCWDwrNcjNwpAl8H27FXeKBbwO+s/nVy0EnD5U
	wdRSMu/r3pxvh/NS72Bf9qB+sjFy/KQ==
X-Google-Smtp-Source: AGHT+IEeUss8ZBlPkHLakvGxJF2K58yDRc8vQWOCbMdXUi501yCOkwF9vYWrYBaVVUbMnozeWCQi6Q==
X-Received: by 2002:a05:6512:33c1:b0:553:d910:9340 with SMTP id 2adb3069b0e04-55a23f72cf3mr1951594e87.46.1752752841436;
        Thu, 17 Jul 2025 04:47:21 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bca2asm3021540e87.29.2025.07.17.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:47:20 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:47:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
Message-ID: <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>

On Tue, Jul 15, 2025 at 07:03:58PM +0530, G Thomas, Rohan wrote:
> Hi Andrew,
> 
> Thanks for reviewing the patch.
> 
> On 7/14/2025 7:12 PM, Andrew Lunn wrote:
> > On Mon, Jul 14, 2025 at 03:59:18PM +0800, Rohan G Thomas via B4 Relay wrote:
> > > From: Rohan G Thomas <rohan.g.thomas@altera.com>
> > > 
> > > Correct supported speed modes as per the XGMAC databook.
> > > Commit 9cb54af214a7 ("net: stmmac: Fix IP-cores specific
> > > MAC capabilities") removes support for 10M, 100M and
> > > 1000HD. 1000HD is not supported by XGMAC IP, but it does
> > > support 10M and 100M FD mode, and it also supports 10M and
> > > 100M HD mode if the HDSEL bit is set in the MAC_HW_FEATURE0
> > > reg. This commit adds support for 10M and 100M speed modes
> > > for XGMAC IP.
> > 
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > > @@ -405,6 +405,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
> > >   	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
> > >   	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
> > >   	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
> > > +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
> > 
> > The commit message does not mention this change.
> 
> Agreed. Will do in the next version.
> 
> > 
> > What does XGMAC_HWFEAT_GMIISEL mean? That a SERDES style interface is
> > not being used? Could that be why Serge removed these speeds? He was
> > looking at systems with a SERDES, and they don't support slower
> > speeds?
> > 
> > 	Andrew
> As per the XGMAC databook ver 3.10a, GMIISEL bit of MAC_HW_Feature_0
> register indicates whether the XGMAC IP on the SOC is synthesized with
> DWCXG_GMII_SUPPORT. Specifically, it states:
> "1000/100/10 Mbps Support. This bit is set to 1 when the GMII Interface
> option is selected."
> 
> So yes, it’s likely that Serge was working with a SERDES interface which
> doesn't support 10/100Mbps speeds. Do you think it would be appropriate
> to add a check for this bit before enabling 10/100Mbps speeds?

DW XGMAC IP-core of v2.x and older don't support 10/100Mbps modes
neither in the XGMII nor in the GMII interfaces. That's why I dropped
the 10/100Mbps link capabilities retaining 1G, 2.5G and 10G speeds
only (the only speeds supported for DW XGMAC 1.20a/2.11a Tx in the
MAC_Tx_Configuration.SS register field). Although I should have
dropped the MAC_5000FD too since it has been supported since v3.0
IP-core version. My bad.(

Starting from DW XGMAC v3.00a IP-core the list of the supported speeds
has been extended to: 10/100Mbps (MII), 1G/2.5G (GMII), 2.5G/5G/10G
(XGMII). Thus the more appropriate fix here should take into account
the IP-core version. Like this:
	if (dma_cap->mbps_1000 && MAC_Version.SNPSVER >= 0x30)
		dma_cap->mbps_10_100 = 1;

Then you can use the mbps_1000 and mbps_10_100 flags to set the proper
MAC-capabilities to hw->link.caps in the dwxgmac2_setup() method. I
would have added the XGMII 2.5G/5G MAC-capabilities setting up to the
dwxgmac2_setup() method too for the v3.x IP-cores and newer.

-Serge(y)

> 
> Best Regards,
> Rohan
> 

