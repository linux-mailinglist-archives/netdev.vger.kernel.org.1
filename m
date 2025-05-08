Return-Path: <netdev+bounces-188932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC6AAF6FC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3704A1589
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CE8264FAF;
	Thu,  8 May 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hUi/+wI5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CF263C6A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697448; cv=none; b=TzAOAPATKxX8xk4WY8kGTDqR8yF20uf6WcFf1xz4HByNt2WR+TWlPZPhlpY6MGJKfuqovSgue4Zgvng+zWHJl0nPDwXS7borHP/VlsD4GjxTP4ZF85iwukFWgVE3khgChtvvIu9hqwgYHuejP2KOwBpOXkueTJmykzbhaHAObPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697448; c=relaxed/simple;
	bh=nPT/F3W9N+by11bdaqC4yK2ZudPzdLXlWraniupgjJw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGvtZSZrk1aQT0jwRLY3+LEjCRHukEGRiu9/TO5REanDttBPZalGp52XWq4wXiPDEQrOalvYX19xjsfpk1XwttHJ2LvkqFRL/lui+xoY+WseyEOG65uHolH2k/M3trLAu/fwfwG0XiA+BTZOUqHPmBZnPTcfCUJkeyOtscQRO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hUi/+wI5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1746697446; x=1778233446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nPT/F3W9N+by11bdaqC4yK2ZudPzdLXlWraniupgjJw=;
  b=hUi/+wI52r9++99vjjZX9f6ymsTDvEuy/UQZ/XM8FrGK1p9K9G5uMaEX
   FuYDOLM2ws/TY9JKCd2A/CqWpXsiDTid/opyP77QjYcMiU8ePspAiMDNb
   COhMsR4FoNL4fxDKSAT7U8PpWwUZklQAG04BFh3fvau4cdQy+dNUjS8rN
   /aR+7Os267KKNsIR4JS1FwmzY4h/e1iSxCaIltPfUb4RjRtxc4HVDtwSv
   6jxfgetXkA0LhiYWIufmRz42msz6SuJd1wAL76k7znDdVkd1JR70UwUKs
   mwEVYiOisH0qE32vDJyTa65nmaeIlRwtK3g61KFnhgYvjACAayQAaXypk
   A==;
X-CSE-ConnectionGUID: dgXtX5N7RouoR3jSWbnLcw==
X-CSE-MsgGUID: 6CsaHletTeu58H0FkJHF0g==
X-IronPort-AV: E=Sophos;i="6.15,271,1739862000"; 
   d="scan'208";a="208871395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2025 02:44:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 8 May 2025 02:43:19 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 8 May 2025 02:43:19 -0700
Date: Thu, 8 May 2025 11:41:56 +0200
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
Message-ID: <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com>
 <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
 <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com>

The 05/08/2025 16:40, Jason Xing wrote:
> Hi Horatiu,

Hi Jason,

> 
> On Thu, May 8, 2025 at 3:08 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> >
> > The 05/08/2025 11:33, Jason Xing wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Make sure the call of skb_tx_timestamp as close to the doorbell.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > index 502670718104..e030f23e5145 100644
> > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > @@ -730,7 +730,6 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
> > >                 }
> > >         }
> > >
> > > -       skb_tx_timestamp(skb);
> >
> > Changing this will break the PHY timestamping because the frame gets
> > modified in the next line, meaning that the classify function will
> > always return PTP_CLASS_NONE.
> 
> Sorry that I'm not that familiar with the details. I will remove it
> from this series, but still trying to figure out what cases could be.
> 
> Do you mean it can break when bpf prog is loaded because
> 'skb_push(skb, IFH_LEN_BYTES);' expands the skb->data area?

Well, the bpf program will check if it is a PTP frame that needs to be
timestamp when it runs ptp_classify_raw, and as we push some data in
front of the frame, the bpf will run from that point meaning that it
would failed to detect the PTP frames.

> May I ask
> how the modified data of skb breaks the PHY timestamping feature?

If it fails to detect that it is a PTP frame, then the frame will not be
passed to the PHY using the callback txtstamp. So the PHY will timestamp the
frame but it doesn't have the frame to attach the timestamp.

> 
> Thanks,
> Jason
> 
> >
> > Nacked-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> >
> > >         skb_push(skb, IFH_LEN_BYTES);
> > >         memcpy(skb->data, ifh, IFH_LEN_BYTES);
> > >         skb_put(skb, 4);
> > > @@ -768,6 +767,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
> > >                 next_dcb_buf->ptp = true;
> > >
> > >         /* Start the transmission */
> > > +       skb_tx_timestamp(skb);
> > >         lan966x_fdma_tx_start(tx);
> > >
> > >         return NETDEV_TX_OK;
> > > --
> > > 2.43.5
> > >
> >
> > --
> > /Horatiu

-- 
/Horatiu

