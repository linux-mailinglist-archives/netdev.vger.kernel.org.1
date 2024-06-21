Return-Path: <netdev+bounces-105503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A9911871
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16C91F22A19
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63383CDA;
	Fri, 21 Jun 2024 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdudnFke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40B82886;
	Fri, 21 Jun 2024 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936802; cv=none; b=eHg185sksOhYBxc0iaCuAJZNjrXUYq/H0bOUeNgsQuW7yd2AvSaNfoKh9qgH4y04Q2Kn54X0wUvrQQoOLZ3c3+8dZk9e+LcVSjQfZ9j1cuk98q96XKHKJD8knCdblKQSfYVKU+qPvbAo75Gdqto0xCTh3nCFeeSCWQZBS+78HFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936802; c=relaxed/simple;
	bh=YQqMCr6z3KLnf1NGBPbvx1fvzk7WCcOQ9AyqvgyuQnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmvIAhKaJ6MmMb4Kq1jveklqogQUVRa51s4+WozYEIi6LmXzmGaeVyTTkX1BMUanDf0WmwQcFtAiLgymdVw9DIO1/24e0R9SP9rtToPT/R/lMntAb6S8TIbiMdPfQSHro21euHH+0tZy+BdPb1aDgycCaPljcZ7WdBm80LXCpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdudnFke; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706354409e1so1411263b3a.2;
        Thu, 20 Jun 2024 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718936800; x=1719541600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EOjQvHBNQ4HSObNyapAYwFrypjXAGViXwaERjXA6IA=;
        b=cdudnFkem1KIIkSI+B7Tw8xw1tjpJxSj6a3zPxQom8SMw0Gcv6ut95B51jzds00aid
         v5KvYHuZgtJ8s/MhzyQ3Alz0+nVvd6vTE8X8VNQaRi62HBKQo75fCSAOq4hAyL7oct21
         92ss/kzEcoccOdYWaedrj0FMIGnQ02pk2DtQx9+tKEGOk+5v8VPmFbElRrbmGwWzjNov
         uFsB4VpDFCY07nRW+EksAmJIGQR3BwedECeXInW2x5sWtUwnQpRLsyDDNJ5LVae5v5zS
         cKGvtbr+FtaNj2GTB+Kimrvn86YH1lSq1u7Iy16vQi/JuznpJqyOxjfOY+25vl4C0W9J
         Xi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718936800; x=1719541600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EOjQvHBNQ4HSObNyapAYwFrypjXAGViXwaERjXA6IA=;
        b=bMdKadpXY49UPeRh+B6Qo5LPcmwW4/AYwjwUFfW3/Dg475hf6/TY2lMGi7lv3KxojC
         beq6NhTIxyeh0kzRC8otrC43EP7Fq/amsxSLr7kDbUtaUlkKLwKZDNVztOojdtLdDKg3
         5tdcRm3mi4NRV6aJMIxANd27toGWIphAkkYR8fO1FJXwGa+KPgSsCMseK3/1EAfgSyHP
         0winVyaOB5A/eQdPW0pTmCoql2Ux2BbOgUsx6ZXOljzPPxIkLa1cD0ACh482lxloUzKP
         SwIXFuFYIv66d6lG6psk6HIN2QkDlj5RmsH4eEqqnfX9a1i7+OqBR1hzjBtnm5wnbxb7
         FwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULCIDuT869SyxBsF/evFxFwaNrD6LmzhSA2n+qzVparPEPhWGZZxrHKzuL4jc5UDmSwJgNPracs5rpvqtPL3s11Ntrw9UW5D3ve4uA9TawpUT+929E7+ly5olughXzqsnASudj
X-Gm-Message-State: AOJu0Yzp3Ah+OcLzhFxsaMILkYpTkmbn586zqtvg3uXzx3N1Y8BtpcTn
	9E22DWv4vHKcIi53efvdjyG+R99Cyhiahhmo1Eb4Qp4ZiPizqu5GwvfWow==
X-Google-Smtp-Source: AGHT+IEaTUQSQHEf8JO1QEEzvL12qgq6Mth9Alo5Y74gEn+JuuGA4loLO41+inOPhXbfBBplIF26gQ==
X-Received: by 2002:aa7:9d0b:0:b0:704:3251:1b67 with SMTP id d2e1a72fcca58-70629c1d46amr7588666b3a.2.1718936799570;
        Thu, 20 Jun 2024 19:26:39 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065130c204sm321525b3a.211.2024.06.20.19.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 19:26:39 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:26:27 +0800
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: xgmac: increase length limit
 of descriptor ring
Message-ID: <20240621102627.000060d6@gmail.com>
In-Reply-To: <e3yzigcfbbkowias54nijvejc36hbcvfgjgbodycka3kfoqqek@46gktho2hwwt>
References: <20240620085200.583709-1-0x1207@gmail.com>
	<e3yzigcfbbkowias54nijvejc36hbcvfgjgbodycka3kfoqqek@46gktho2hwwt>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 15:06:57 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> Hi Furong
> 
> On Thu, Jun 20, 2024 at 04:52:00PM +0800, Furong Xu wrote:
> > DWXGMAC CORE supports a ring length of 65536 descriptors, bump max length
> > from 1024 to 65536  
> 
> What XGMAC IP-core version are you talking about? The DW XGMAC
> IP-core databooks I have define the upper limit much lesser than that.
> 
Hi Serge

Thanks for this information.
I double checked 3.10a and 3.20a, 3.10a do have a limit to 16K,
and 3.20a bump the limit to 64K.
So we need to lower the limit to fit all XGMAC versions. And what about
your advice to set this limit?

> Do you understand that specifying 65K descriptors will cause a huge
> amount of memory consumed, right? Each descriptor is equipped with at
> least 1-page buffer. If QoS/XGMAC SPH is enabled then each descriptor
> is equipped with a second buffer. So 65K-descriptor will cause
> allocation of at least 65536 * (4 * 4) bytes + 65536 * PAGE_SIZE
> bytes. So it's ~256MB for the smallest possible 4K-pages. Not to
> mention that there can be more than one queue, two buffers assigned to
> each descriptor and more than a single page allocated for each buffer
> in case of jumbos. All of that will multiply the basic ~256MB memory
> consumption.
> 
Fully agree with you. This patch is trying to make it possible for ethtool
to set a longer descriptor length against XGMAC. All MAC cores still have
512 descriptors allocated by default for both TX and RX, which is defined
by DMA_DEFAULT_TX_SIZE and DMA_DEFAULT_RX_SIZE in
drivers/net/ethernet/stmicro/stmmac/common.h

This patch does not change the default descriptor length for XGMAC core,
but give ethtool a chance to set a bigger value than DMA_MAX_TX_SIZE and
DMA_MAX_RX_SIZE defined in drivers/net/ethernet/stmicro/stmmac/common.h

> Taking all of the above into account, what is the practical reason of
> having so many descriptors allocated? Are you afraid your CPU won't
> keep up with some heavy incoming traffic?
> 
Heavy incoming traffic on some heavy load system, the max 1024 limit defined
by DMA_MAX_RX_SIZE in drivers/net/ethernet/stmicro/stmmac/common.h is too
few to achieve high throughput for XGMAC.
With this patch, ethtool can set a new length than 1024

> Just a note about GMACs. The only GMAC having the ring-length limited
> is DW QoS Eth (v4.x/v5.x). It may have up to 1K descriptors in the
> ring. DW GMAC v3.73a doesn't have the descriptors array length constraint.
> The last descriptor is marked by a special flag TDESC0.21 and
> RDESC1.15, after meeting which the DMA-engine gets back to the first
> descriptor in the ring.
> 
> -Serge(y)
> 
> > 
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
> >  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 24 +++++++++++++++----
> >  2 files changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 6a2c7d22df1e..264f4f876c74 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -11,6 +11,8 @@
> >  
> >  /* Misc */
> >  #define XGMAC_JUMBO_LEN			16368
> > +#define XGMAC_DMA_MAX_TX_SIZE		65536
> > +#define XGMAC_DMA_MAX_RX_SIZE		65536
> >  
> >  /* MAC Registers */
> >  #define XGMAC_TX_CONFIG			0x00000000
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > index 18468c0228f0..3ae465c5a712 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > @@ -491,9 +491,16 @@ static void stmmac_get_ringparam(struct net_device *netdev,
> >  				 struct netlink_ext_ack *extack)
> >  {
> >  	struct stmmac_priv *priv = netdev_priv(netdev);  
> 
> > +	u32 dma_max_rx_size = DMA_MAX_RX_SIZE;
> > +	u32 dma_max_tx_size = DMA_MAX_TX_SIZE;
> >  
> > -	ring->rx_max_pending = DMA_MAX_RX_SIZE;
> > -	ring->tx_max_pending = DMA_MAX_TX_SIZE;
> > +	if (priv->plat->has_xgmac) {
> > +		dma_max_rx_size = XGMAC_DMA_MAX_RX_SIZE;
> > +		dma_max_tx_size = XGMAC_DMA_MAX_TX_SIZE;
> > +	}
> > +
> > +	ring->rx_max_pending = dma_max_rx_size;
> > +	ring->tx_max_pending = dma_max_tx_size;  
> 
> Do you understand the consequence of this change, right?
> De
> 
> >  	ring->rx_pending = priv->dma_conf.dma_rx_size;
> >  	ring->tx_pending = priv->dma_conf.dma_tx_size;
> >  }
> > @@ -503,12 +510,21 @@ static int stmmac_set_ringparam(struct net_device *netdev,
> >  				struct kernel_ethtool_ringparam *kernel_ring,
> >  				struct netlink_ext_ack *extack)
> >  {
> > +	struct stmmac_priv *priv = netdev_priv(netdev);
> > +	u32 dma_max_rx_size = DMA_MAX_RX_SIZE;
> > +	u32 dma_max_tx_size = DMA_MAX_TX_SIZE;
> > +
> > +	if (priv->plat->has_xgmac) {
> > +		dma_max_rx_size = XGMAC_DMA_MAX_RX_SIZE;
> > +		dma_max_tx_size = XGMAC_DMA_MAX_TX_SIZE;
> > +	}
> > +
> >  	if (ring->rx_mini_pending || ring->rx_jumbo_pending ||
> >  	    ring->rx_pending < DMA_MIN_RX_SIZE ||
> > -	    ring->rx_pending > DMA_MAX_RX_SIZE ||
> > +	    ring->rx_pending > dma_max_rx_size ||
> >  	    !is_power_of_2(ring->rx_pending) ||
> >  	    ring->tx_pending < DMA_MIN_TX_SIZE ||
> > -	    ring->tx_pending > DMA_MAX_TX_SIZE ||
> > +	    ring->tx_pending > dma_max_tx_size ||
> >  	    !is_power_of_2(ring->tx_pending))
> >  		return -EINVAL;
> >  
> > -- 
> > 2.34.1
> > 
> >   


