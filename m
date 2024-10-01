Return-Path: <netdev+bounces-131026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045C98C680
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998E91F251A4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55921CDFC7;
	Tue,  1 Oct 2024 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKR9nH3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D31CBE98
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813318; cv=none; b=s+tEHAU/5+K3pcThz4xwqmu9Oc7wABSdHh7NG9QG0Z5614QaWrAZezVADIBJpGJHbftWgFMMLD6fCv95b+vzWrr5Vy/CSbj36aOAXc48+3s2ldDhr0I7wiaCKjddrC0NFC+gIo+N7DeU6QS8n3g5ARBgz3KM5YgQwfqTLkmNQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813318; c=relaxed/simple;
	bh=x/BYfN0o3hdOvi6ouH7b1heWPwVtXmW7NgvsyjdBa8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWc7yv6p8vlKl8vkwweC4YA8F8N86JBlwJf1kvA0q5XC7hCWpSMctAAT4Y2rJ7IInQIw7N0dXkYm7O7lOconojFmgs45nB2fBKXDPhotPRFjM0Dt3B6YiaZBp5UWdCmFwUkVLeUMyAjzY7Frx5ooQCvq4hsPxH3F3Ly+hVsPZi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKR9nH3H; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so3971953e87.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813315; x=1728418115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3F7/FFtWApLSUXEepnnbis6VSjR+VGvY092OXy/kqpk=;
        b=nKR9nH3HtHjJFuxL912CmR/D+lTEVp5wGwhTM3Xi69PmXvIHg6VPa3VLzh4dfoIkM8
         N0tSY5Yn5u4jrE3VVxbQaCKgpdL7JFzSycMYasmgcjaRmYc9jHrF4o4r6NaHQJBGOWfi
         wDfkJp/qugoIHzBTuBvN6XSUJoys50KuZh5Bc2MqjFU5AHpB2czwWvBaetayvB62JPv9
         McaXQTCZ9VzZaFaaGWK6a2rDncd25+jTpwLzhL7kTVcn4JpHjOaSdUHYHZOH7QouCvI+
         v6qijZE0tdpmEqs7g4UZkIZ2MVIEWgKAvkRynRLjZg44fGpi8X26QrlHglbiUO1gBSTA
         NeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813315; x=1728418115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3F7/FFtWApLSUXEepnnbis6VSjR+VGvY092OXy/kqpk=;
        b=Gbfd2jvXpEZQFZ6hSGdgg3fuO+EBLFsHTcpe5oKYxoW246Q9Ii3Fh9ubG2TTCai+an
         5i6oeT99yRl7+Q3MB06KV2IfS1h83pEmMsDCTJgfitaXrMu/EeF338isdZAU3pVlgXAJ
         HP4dJR0VQyElOSSNB5zEnEQz3t4796MCnKWbDW1lIq3zMw+TMvE8AQuQYCeW+vd4cHLZ
         UQyRYrEHcPjn1M5ZCyFj2so6dcw+QmtNYwuZNNer2id027xPh+77Jan4zBLdt8BPLsQ5
         UsjtIXd2ZKo53Bk8o0v8FT60oR/3DPoYWacjAN1uFEGGpx9A6bajA+E5b1XdS+NLEeTb
         aTXw==
X-Forwarded-Encrypted: i=1; AJvYcCVU3/qhIQ8yf1kH/liopv0gtk26fKPA+/V5GQDxatDaDuSV7MvD3c35RPH0P1nWnwoKnN1CLyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXZlTjxBcR5uAWjquC3+aeTd5Xzvc3j1RGjoIKdW7Y8u4Vtw7
	xKEa9exLbSFPRSJ0v2az84/0lo2u/5bGXRok2AZOfgLWG5qNFhoL
X-Google-Smtp-Source: AGHT+IFQgGFOsaorJ/fsSrIM5NkGlLHrttg96Z9/+Xv6vqBLdsR83SKhx/SA5x3kSEFm21tU85bkbQ==
X-Received: by 2002:a05:6512:3b1e:b0:52c:8979:9627 with SMTP id 2adb3069b0e04-539a06589bemr435745e87.3.1727813314834;
        Tue, 01 Oct 2024 13:08:34 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5398b124577sm1450666e87.158.2024.10.01.13.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:08:34 -0700 (PDT)
Date: Tue, 1 Oct 2024 23:08:31 +0300
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
Subject: Re: [PATCH v4 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <wltofooowb3nl5gzfygdj3kd22glmd22hji4nlhovwct7ckrvo@j4st55j52awv>
References: <20240924205424.573913-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924205424.573913-1-shenwei.wang@nxp.com>

On Tue, Sep 24, 2024 at 03:54:24PM GMT, Shenwei Wang wrote:
> Increase the timeout for checking the busy bit of the VLAN Tag register
> from 10µs to 500ms. This change is necessary to accommodate scenarios
> where Energy Efficient Ethernet (EEE) is enabled.
> 
> Overnight testing revealed that when EEE is active, the busy bit can
> remain set for up to approximately 300ms. The new 500ms timeout provides
> a safety margin.
> 
> Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

Looking good now. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> Changes in V4:
>  - fixed the comments and R-b.
> 
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
> index a1858f083eef..e65a65666cc1 100644
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
> +				 1000, 500000);
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

