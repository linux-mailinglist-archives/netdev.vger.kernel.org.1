Return-Path: <netdev+bounces-188901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A6AAAF448
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313DA1619C0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892121CC40;
	Thu,  8 May 2025 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xvtFJMQT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BC33FD
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688136; cv=none; b=jjCRztZL/xgOAvcRlRrb8otzd8SZzuXpugORrX6lcHqbhMAK8dNfoe8XNCczBvT8xB6y2jufag8GHXwwR0KIjrN3ZeXPo+Mf80DjH9S01tYGX9XRWoIHCSq+21rPrX7pyNZMbTkJTHI7Ftw+/TIkH4thT6F4uAh49wUIOtygxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688136; c=relaxed/simple;
	bh=ro+fNqHlMjS5LfEr2nfJj/uKzW54Yi1ADwyqobeaERo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6JZGiZ8vQVuLxHd7+nKlT51tTXELok3MfFEPneRQYskYGKJVtPVpUnMlriGsaCXxd87mZddZ2FsJGgG4fKC7uxviT3yYzwVL7hpUTXvPuaASBr5ZYZtszoa6VRQrGC+7Z583hjnPVIBZ/ToPHchMYvlnePW0TDsBaVqwLNkaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xvtFJMQT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1746688135; x=1778224135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ro+fNqHlMjS5LfEr2nfJj/uKzW54Yi1ADwyqobeaERo=;
  b=xvtFJMQTOK5cI2lEFo5AOq2Ccf+REsMUbM41KOYz28I20ZBOECqLjM5a
   0Ivo9kKF7qQeoW6vl8Ql3NnuFP6mGpGWyJ3OL04YW1Xu+Z0Hapm375Low
   CvNjEbvdOl4H/RvAjwDbVyFeV7eQvCFBCOx0eEUzOJEqr0C3ewKsCmGxs
   Uzo8NA/DopaCkMQ950hS0RIvvUH0K4x4WE4qCUVpWSXrneHGtC8sb46Rs
   5RAC4sSadJz2sHOAbEhW/NtuVPhfYoxrLpBT+uTM5QkoM9OkJUEP1Ax8m
   IJliX7leUdQegObw5I9CUqeIkIyxxME8UqLYxG3/blO127c7iFonTs202
   g==;
X-CSE-ConnectionGUID: Lkz06igDQsq9icAK8YbzRw==
X-CSE-MsgGUID: r697ijZUQQ20/Ff89o04IQ==
X-IronPort-AV: E=Sophos;i="6.15,271,1739862000"; 
   d="scan'208";a="272726326"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2025 00:08:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 8 May 2025 00:08:23 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 8 May 2025 00:08:22 -0700
Date: Thu, 8 May 2025 09:07:00 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <irusskikh@marvell.com>, <andrew+netdev@lunn.ch>, <bharat@chelsio.com>,
	<ayush.sawal@chelsio.com>, <UNGLinuxDriver@microchip.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <sgoutham@marvell.com>,
	<willemb@google.com>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next v1 4/4] net: lan966x: generate software
 timestamp just before the doorbell
Message-ID: <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250508033328.12507-5-kerneljasonxing@gmail.com>

The 05/08/2025 11:33, Jason Xing wrote:
> 
> From: Jason Xing <kernelxing@tencent.com>
> 
> Make sure the call of skb_tx_timestamp as close to the doorbell.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 502670718104..e030f23e5145 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -730,7 +730,6 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
>                 }
>         }
> 
> -       skb_tx_timestamp(skb);

Changing this will break the PHY timestamping because the frame gets
modified in the next line, meaning that the classify function will
always return PTP_CLASS_NONE.

Nacked-by: Horatiu Vultur <horatiu.vultur@microchip.com>

>         skb_push(skb, IFH_LEN_BYTES);
>         memcpy(skb->data, ifh, IFH_LEN_BYTES);
>         skb_put(skb, 4);
> @@ -768,6 +767,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
>                 next_dcb_buf->ptp = true;
> 
>         /* Start the transmission */
> +       skb_tx_timestamp(skb);
>         lan966x_fdma_tx_start(tx);
> 
>         return NETDEV_TX_OK;
> --
> 2.43.5
> 

-- 
/Horatiu

