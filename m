Return-Path: <netdev+bounces-129442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F08F983F17
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87380B232DB
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350B80C13;
	Tue, 24 Sep 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv4NTifr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACC80C1C
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163013; cv=none; b=i5xFc/SNAyL7DuQtjPQyzs9yS62lWoqVIL2Ojj1BJwlSOB+bKLvkEbHNJMpAnQh5cNurqTm8lsYFX+SsB6a9j5waPBqnhiJla07KIZcHRac/Iiftd6P9bmhAk098BY4hYToFEmF0Ud6/bIO03pyn+LagtA3GYDGfcTrH+7TdoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163013; c=relaxed/simple;
	bh=+Jnrcxm70XtnYxuo7Zg2dly3Q5LywYfWNjpqdnAaQ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfVGGEm/1pHdlCG+NtJNh+sSJ11pFprDb91cwZwkcP1hRx/a5CSbPr97s2htLr6/Cg5LkbvNkZli42lUyHSGCAdayu+Q6GZ7GOxDYRPR5j7aBqsp66y84iVU1ArCgGCSIdHZLPie/jpuOpHiDEXcAag790luVnHyFAw/f2VTMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv4NTifr; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso46969921fa.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727163009; x=1727767809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nJQRM8OcQBfhzuEe8sQ5z7UNmwmAz6ULuryZyUF/+cE=;
        b=Pv4NTifrJvPQ4GrJiwOtmv0y6usqF7fBCxZ7gW/cF2ugrWc/ABs2Q3IM2AvHC0aLLb
         qzzT6rkqoLgZkXAsHbiV4zoWnpGnCA40S3jAhfQ+GsVgsLzAsEJo16CT6Da14K/+62tq
         orBDlGzZgzwhz9o56woeGpH/3ClgeVF77VqeVs5Th77PSTBCuTJ9605d5v4Mu/G7vmUc
         eDbcyGt8BlPeno/iaO26w5bg/DPq/K0TpeFGcluygnM9dIZ4XrvSYq0eeOtE6rVen5Xv
         RHomZlSJ50y8EYbFNL/fiqskcFnJHv0ruerlbn2/zqvpp3fMkIYH7ZtEYBzBrh+6rcea
         xOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163009; x=1727767809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJQRM8OcQBfhzuEe8sQ5z7UNmwmAz6ULuryZyUF/+cE=;
        b=dasOq8edFsiYaTcQGgWoTAgBHbPC7JXOlCLvcUaobW1Nqz0ARUhziiu5bm/JwG3rtd
         GoB2RIMlXb2MhhLOe04sNjc8lN8Y94X070tn1+Ik3S8jiGt4XNOVcSIL/TB/AkxJmyIe
         odZcp5kSHr67JyQAWqRQ1bqJnevwDiHnzvOh3wmC690Sa3YQd/RjulcbPtLlyxxQCrzd
         JrClyVB9eXYcSkQlU+AothKXhq+vOqeoc6TCQ5r32YDda16sl3pGQ+dBE/ZdHiQn+lfZ
         jjL5rjdHaw7LqZMeNcav/wfGblaYtvAliW3/XUmDbLfkjiPzkDR08lMnDybthaj5cqFZ
         noCg==
X-Forwarded-Encrypted: i=1; AJvYcCVRop0L6Ik/EwA+7fAagyjunf/L13uAssWQ2fURFT7dJR6+ICbWcZ3ZyZT2WnDSfpcWDpfwQ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsrF2y2L06ZCJEfRriWa+8ARLzRo2dkIPPJiFk7xo4oUsqZi+
	Oo9BTzY8QGpg9nmPDtPOVKkL2CGNB5WKz/MFZLbg8C+MOLfHgyP9
X-Google-Smtp-Source: AGHT+IHiSe0OiPhFl7VaoeCUi1YflblepVekNSVUxtXk0ofVtVw4xElfai2k8GkrbEMVv8ANZMNY4g==
X-Received: by 2002:a05:651c:1989:b0:2f7:5239:5d9b with SMTP id 38308e7fff4ca-2f7cb2cfe22mr79571811fa.4.1727163008678;
        Tue, 24 Sep 2024 00:30:08 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d282fc44sm1323081fa.26.2024.09.24.00.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:30:08 -0700 (PDT)
Date: Tue, 24 Sep 2024 10:30:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, horms@kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Ong Boon Leong <boon.leong.ong@intel.com>, Wong Vee Khee <vee.khee.wong@intel.com>, 
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-imx@nxp.com, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <fcu77iilcqssvcondsiwww3e2hlyfwq4ngodb4nomtqglptfwj@mphfr7hpcjsx>
References: <20240923202602.506066-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923202602.506066-1-shenwei.wang@nxp.com>

Hi Shenwei

On Mon, Sep 23, 2024 at 03:26:02PM -0500, Shenwei Wang wrote:
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
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Please note, you can't add the R-b tag without explicitly getting one
from the reviewer/maintainer/etc. Please read the chapter
"When to use Acked-by:, Cc:, and Co-developed-by:" in
Documentation/process/submitting-patches.rst

> ---
> Changes in V3:
>  - re-org the error-check flow per Serge's review.
> 
> Changes in v2:
>  - replace the udelay with readl_poll_timeout per Simon's review.
> 
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c  | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index a1858f083eef..0d27dd71b43e 100644
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
> +	int ret;
>  	u32 val;
> 
>  	if (index >= hw->num_vlan)
> @@ -487,16 +488,15 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
> 
>  	writel(val, ioaddr + GMAC_VLAN_TAG);
> 
> -	for (i = 0; i < timeout; i++) {
> -		val = readl(ioaddr + GMAC_VLAN_TAG);
> -		if (!(val & GMAC_VLAN_TAG_CTRL_OB))
> -			return 0;
> -		udelay(1);

> +	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
> +				 !(val & GMAC_VLAN_TAG_CTRL_OB),
> +				 1000, 500000); //Timeout 500ms

Please drop the comment at the end of the statement. First of all the
C++-style comments are discouraged to be used in the kernel code except
when in the block of the SPDX licence identifier, or when documenting
structs in headers. Secondly the tail-comments are discouraged either
(see Documentation/process/maintainer-tip.rst - yes, it's for
tip-tree, but the rule see informally applicable for the entire
kernel). Thirdly the comment is pointless here since the literal
500000 means exactly that.

-Serge(y)

> +	if (ret) {
> +		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> +		return -EBUSY;
>  	}
> 
> -	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> -
> -	return -EBUSY;
> +	return 0;
>  }
> 
>  static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
> --
> 2.34.1
> 

