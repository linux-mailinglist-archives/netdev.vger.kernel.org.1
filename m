Return-Path: <netdev+bounces-129213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F497E3E9
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 00:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6901C20A51
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837B770E4;
	Sun, 22 Sep 2024 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoyYEIpv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27B1A28D
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043476; cv=none; b=QoKhnrKj6Q+Msv0PzHy4AVO4KX07rimLj1zL8ZEXQf75/RNlSnFwP/7bJyzjPSIduMW2A/kt2OTajKvDERH4Wk0xs2SeSi98BpPEOiXyy9avtq/EOY13VAffEQgDEULs9JITRmabwn4uE3mX+z9tNdYQowFIYeRwAfgozQCwWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043476; c=relaxed/simple;
	bh=+VWjUNRxUp+RfG26z07hsVE/vm58zscjICTwSUp5dFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOT4Pv/rlmxFglcth6NRVZONDrY1C9nto2XezKcH45MPK3i3z3iujeNlBnZZL6AA9ecsoIeponF9CJC2Otzt+rj5FcMB0UBtyZxneSR+xH30+4RYPn59k5pC4kK/uW5W5SzZbMC9QYpUZUDuUdRuimw4OJJMYsd8uTyC70mnLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoyYEIpv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-536562739baso3467130e87.1
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043473; x=1727648273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+z+sTMVisDVFfvjkFFbu8DDWbPGrFSf17/aPoR5w2s=;
        b=VoyYEIpvAoz97Z/EpCV4D0bHfjktTqqKR5N+FfoODtreI7q0xi4X8w44WWVT0amDvv
         iqW3uT2dsw/g4rsO+MdOYsqzOuZDp1da7u+ZVuhw3HgCWeyOsH97QAXEbE2X2w8R0ay2
         Zdjav31E1C8Tt8u6hSoilwSNBTx39ADOj3xNlFnyRkgHQcs40oxZzsuVebaz9AiSkHt7
         taUv8pnw9+2rXslvQ/jhA85N6HLPxpndKfo+asa3K3jaDhhAJVLHjgNuGmzXtFhRgplo
         y3I+Ejnmq24Tv0h/RXiIrCH/uZmvm6tA7I3id7RI57/Gx7LXZi7XerWlKwZnYw0liiHK
         N1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043473; x=1727648273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+z+sTMVisDVFfvjkFFbu8DDWbPGrFSf17/aPoR5w2s=;
        b=KuIULBNpM5n8QymTCq+hfWYI6Ln0//OEJFPjwvqcuKWWx6OBW8xTIIzQXZBBidWw+Z
         iGJkh5Ztvj2YmmLPqConNMODgQvcBPFDrtFrR+o4ljaTE4tQquRztjyLpDVeOL5RN5H8
         QEli9jTcoBUztjP7olFkmbQ/9FfuXeAw6o8J9tXu4xO754HQ0BlGws6nuuusLcdItGEp
         +siSs3RJWtQ6iPQFPVi4GKbt0OhEg+UwhfgETWfppbbM0Pwy1r17zKQBSG6JhSx6gNql
         hdvSRNpRrTcoYLuAmNBd+kntyLHxRX2HClQnBxUpoLM8spohNAHhbw1LZzieJuZsYIq4
         1C9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyA39ZIu3N90PnagPAqXJ8Wb/Xmtq2/4vC22t5QQL0Oxt1xf8T8TQgl5CH4DIqpDDS4nT/n7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VBVx1sBOB/V2sXh1ySwhq73XHwX7sk8+0NeRi7v97riMhedS
	qQaRvn1f4etIP2ABVsY8aQBANkmQG+/Q3OjyG0pazM99tuNqo8UN
X-Google-Smtp-Source: AGHT+IHxU+MGElA+QsRzR7T/maHHhNlCIFzzXDBhrpK7Lmg8bAMOit3g7+vHOKt093dToxEIMGOyfQ==
X-Received: by 2002:a05:6512:158c:b0:534:36bf:b622 with SMTP id 2adb3069b0e04-536ac34649dmr4068777e87.61.1727043472449;
        Sun, 22 Sep 2024 15:17:52 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870966f6sm3081871e87.151.2024.09.22.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:17:51 -0700 (PDT)
Date: Mon, 23 Sep 2024 01:17:49 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, horms@kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Ong Boon Leong <boon.leong.ong@intel.com>, Wong Vee Khee <vee.khee.wong@intel.com>, 
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-imx@nxp.com
Subject: Re: [PATCH v2 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <yzyezokrtcj5pnby4ak5lzrrnqu3y3k45kaibtklwrjn4ivzel@hwf6bgssykna>
References: <20240918193452.417115-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918193452.417115-1-shenwei.wang@nxp.com>

On Wed, Sep 18, 2024 at 02:34:52PM -0500, Shenwei Wang wrote:
> Increase the timeout for checking the busy bit of the VLAN Tag register
> from 10µs to 500ms. This change is necessary to accommodate scenarios
> where Energy Efficient Ethernet (EEE) is enabled.
> 
> Overnight testing revealed that when EEE is active, the busy bit can
> remain set for up to approximately 300ms. The new 500ms timeout provides
> a safety margin.
> 
> Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
> Changes in v2:
>  - replace the udelay with readl_poll_timeout per Simon's review.
> 
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index a1858f083eef..a0cfa2eaebb4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/ethtool.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include "stmmac.h"
>  #include "stmmac_pcs.h"
>  #include "dwmac4.h"
> @@ -471,7 +472,7 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
>  				    u8 index, u32 data)
>  {
>  	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
> -	int i, timeout = 10;
> +	int ret, timeout = 500000; //500ms
>  	u32 val;
> 
>  	if (index >= hw->num_vlan)
> @@ -487,12 +488,11 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
> 
>  	writel(val, ioaddr + GMAC_VLAN_TAG);
> 
> -	for (i = 0; i < timeout; i++) {
> -		val = readl(ioaddr + GMAC_VLAN_TAG);
> -		if (!(val & GMAC_VLAN_TAG_CTRL_OB))
> -			return 0;
> -		udelay(1);
> -	}

> +	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
> +				 !(val & GMAC_VLAN_TAG_CTRL_OB),
> +				 1000, timeout);
> +	if (!ret)
> +		return 0;
> 
>  	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");

1. Just drop the timeout local variable and use the 500000 literal
directly. There is no point in such parametrization especially you
have already added the delay as is.

2. A more traditional, readable and maintainable pattern is the
error-check statement after the call. So seeing you are changing this
part of the method anyway, let's convert it to:

+	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
+				 !(val & GMAC_VLAN_TAG_CTRL_OB),
+				 1000, timeout);
+	if (ret) {
+		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
+		return ret;
+	}
+
+	return 0;

-Serge(y)

> 
> --
> 2.34.1
> 
> 

