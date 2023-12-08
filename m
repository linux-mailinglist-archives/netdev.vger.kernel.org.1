Return-Path: <netdev+bounces-55316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160380A577
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2ED71F212BF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7C1DFE0;
	Fri,  8 Dec 2023 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFzW2p3M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4799E173B;
	Fri,  8 Dec 2023 06:28:25 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so23902751fa.2;
        Fri, 08 Dec 2023 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702045703; x=1702650503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Do5YXZvpx1oH456IeLehOp7UBGB2jGfxbiAhA8fLLOw=;
        b=cFzW2p3MyYfpTjkfLMr/KOZ4XnMsSo0j1jZTzhfTCd2X/auxaJxXCUjXd+BCiK4CgF
         IDKtmecombAWYTfAAs8X/sLkfFeG89AnwNwnRKjgIB66qqjrLEs18bCGS639wP+qvIYT
         rZAZG/ndxJEVjdDGu3F5i+Dbx5em6rwc3s1xs/CrA6Q+qX9YHHn+SDgBFxHK4UgphhuH
         D7hbfQX8ZUa/pYJg6cHQuqD7H9nCtPH77O+3GCvELMOZgcps7/pPxcsPFyvYmMVvkHZE
         vvpkzMBVXCN0hrThycYaYltEeiYigPqtOMfjTxIHw6FOskl4TbI2KrMoAhIiZixctZfd
         ZEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045703; x=1702650503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do5YXZvpx1oH456IeLehOp7UBGB2jGfxbiAhA8fLLOw=;
        b=gOQyJJaZ9pzYCAvRpr4DR9Ay7977x1f0tH2Wr1l8ozC5YWcg1iHbWv6hswlMxp9FmE
         bacWV81wCR6AEZFTBqv2dl1bKJucmp13RHW+tls6LWPNapUstpy8sBr9O8erVuheLATG
         FOUHFlTcvsUSXv26Lzc1o25vG0HsVHBfCyiDmZH0aVc1QcgfzQK0oPxK5rHhLxzvXPD0
         wSWM7oV5Mxvd48fGH81hqi8GsD4iwV6N0CrUzNNNRz1U/xhBApwRAO6MRo33AiNyyK8c
         aCKPdw64Cmz++wn0ZC6vz2bMh8ifoUDNXckckYL8x5U3Z7uPuIWLqhwrqSvmGzMOeSQ4
         vElg==
X-Gm-Message-State: AOJu0YyhytYxeHR3aUoWFIP6rl9+ZO8nWAuG0BCOJnlWeqNwWTBvtjvQ
	NwdmoAQrYXHMmGxCbCmyxQ4=
X-Google-Smtp-Source: AGHT+IE50woDjg19iA4GldfyfOAv1dTTmjwQ/EliunHTPN8NwGhroGYmf7AQov1vmNIbRe4tOPrYww==
X-Received: by 2002:a2e:97d3:0:b0:2ca:30a:838c with SMTP id m19-20020a2e97d3000000b002ca030a838cmr2470312ljj.99.1702045703253;
        Fri, 08 Dec 2023 06:28:23 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j16-20020a2e3c10000000b002c9ff0457f8sm241983lja.11.2023.12.08.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:28:22 -0800 (PST)
Date: Fri, 8 Dec 2023 17:28:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>
Cc: Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Johannes Zink <j.zink@pengutronix.de>, 
	"Russell King (Oracle" <rmk+kernel@armlinux.org.uk>, Jochen Henneberg <jh@henneberg-systemdesign.com>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated  list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	James Li <James.Li1@synopsys.com>, Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree
 parsing
Message-ID: <uzss3af2cklc5bx5apszoegafeaaiv7o7iwgrgrml4grkyev6p@6tme4hdb4mkn>
References: <SA0PR12MB44138E48A245378CF54D2F9ED98AA@SA0PR12MB4413.namprd12.prod.outlook.com>
 <20231208091408.071680db@device.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208091408.071680db@device.home>

Hi Maxime, Jiangfeng

On Fri, Dec 08, 2023 at 09:14:08AM +0100, Maxime Chevallier wrote:
> Hello,
> 
> On Fri, 8 Dec 2023 07:02:19 +0000
> Jiangfeng Ma <Jiangfeng.Ma@synopsys.com> wrote:
> 
> > In order to setup xpcs, has_xpcs must be set to a non-zero value.
> > Add new optional devicetree properties representing this.
> > 
> > If has_xpcs is set to true, then xpcs_an_inband should preferably be
> > consistent with it, Otherwise, some errors may occur when starting
> > the network, For example, the phy interface that xpcs already supports,
> > but link up fails.
> 
> Can you elaborate on why you need this, and on which platform
> especially ? Usually drivers for the various stmmac variants know if
> they have XPCS or not, or can guess it based on some info such as the
> configured PHY mode (dwmac-intel).
> 
> Besides that, there are a few issues with your submission. If DT is the
> way to go (and I don't say it is), you would also need to update the
> bindings to document that property.
> 
> > The types of has_xpcs and xpcs_an_inband are unsigned int,
> > and generally used as flags. So it may be more reasonable to set them to
> > bool type. This can also be confirmed from the type of @ovr_an_inband.
> 
> And this part would go into a separate patch.

In addition to what Maxime already said having DT-bindings adjusted to
fit to the pattern implemented in the software part is a wrong way to
go. The best choice in this case is to add the DW XPCS DT-node to the
DW MAC MDIO/MI bus and then use the "pcs-handle" to inform the MAC
(mainly it's driver) of what PCS-device is actually attached to it.
The series I submitted on this week is exactly about that:
https://lore.kernel.org/netdev/20231205103559.9605-1-fancer.lancer@gmail.com/
I guess I'll need about a month or so to settle all the comments, but
the solution implemented there will be better than this one really.

-Serge(y)

> 
> Thanks,
> 
> Maxime
> 

