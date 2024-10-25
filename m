Return-Path: <netdev+bounces-138989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD69AFAD8
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FA31F21F9A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A5199221;
	Fri, 25 Oct 2024 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EhZOQ85w"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD51A4AAA;
	Fri, 25 Oct 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840672; cv=none; b=XR5GCqLQiZaI1vi8vbr8dqS8/wQsuvBCj/CZf0k/PPJNOWN8KS/jsOzPODNnPq9DI9j1A+oW7uuSbIAnoKchtgUboKw2gv8a2twia92cLaE/TDIjYv68MqQpilD/ha8roYpdhj8TXjNPE1wLQN/hhyTolBvZ98hWo/awezGrd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840672; c=relaxed/simple;
	bh=dqqqvJ8g3AVzb03zYJsih0JTQPOidvJI2QvhRqV7u9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsKvhkwKgYbu0AFXjVORYYEbIhss8LIYmLVsLo5+Cn6iUwYP7NxDtbqEAHyQhrhg52MaC4xzALy5zz2+jcbL2vZ2ceDPb4szFW5BgVIHoFdn/PGBkuP4zgzQCw4jCtNNWyRwG+WPchyuq2fJJebeVFvvPQWkdJkqb3+PVOtq/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EhZOQ85w; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729840670; x=1761376670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dqqqvJ8g3AVzb03zYJsih0JTQPOidvJI2QvhRqV7u9g=;
  b=EhZOQ85wbLoZtFFwqDB6sefaJpc9Qt4Pbx938s+5/nFJViQNwZibbQOU
   lumbd2tiJQGhMpunJxLwfFREGobKhGE83vKUpQ2qYR71re2wMnU4gU/XL
   ZVNINGOLopgT4eR0N6qG19/QsaO/yogHsTSuEUKXs+UMhdOvpXhEo4zGF
   aDDtZK+svgtFNltGrj0uyzsHIhxBaBR7U/a3cYGSCKfb5ZJB0uNFXGHT6
   4Egv+DeoESiwgTxxLYQ4xwp3kWbTOe6bBch/S+rTV31l1YvN02B5XM8h/
   U5TaVVXJGEsfr3KbcdIEds1aZW1MKFfJ7b5JH2P80CHdKNcj6atYKPf6r
   Q==;
X-CSE-ConnectionGUID: Hp/0/euNT4aWmfDdVqjxpQ==
X-CSE-MsgGUID: TdR5MXcUTliy1kkXe/9EYA==
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="34008259"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2024 00:17:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 25 Oct 2024 00:17:22 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 25 Oct 2024 00:17:18 -0700
Date: Fri, 25 Oct 2024 07:17:17 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 10/15] net: lan969x: add PTP handler function
Message-ID: <20241025071717.rz3zqppplu52cdpc@DEN-DL-M70577>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
 <20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com>
 <24147551-b639-4f9f-be5e-def2570a863d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24147551-b639-4f9f-be5e-def2570a863d@linux.dev>

Hi Vadim,

Thanks for reviewing.

> On 23/10/2024 23:01, Daniel Machon wrote:
> > Add PTP IRQ handler for lan969x. This is required, as the PTP registers
> > are placed in two different targets on Sparx5 and lan969x. The
> > implementation is otherwise the same as on Sparx5.
> > 
> > Also, expose sparx5_get_hwtimestamp() for use by lan969x.
> > 
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > ---
> >   drivers/net/ethernet/microchip/lan969x/lan969x.c   | 90 ++++++++++++++++++++++
> >   .../net/ethernet/microchip/sparx5/sparx5_main.h    |  5 ++
> >   drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  9 +--
> >   3 files changed, 99 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> > index 2c2b86f9144e..a3b40e09b947 100644
> > --- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
> > +++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> > @@ -201,6 +201,95 @@ static int lan969x_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
> >       return 0;
> >   }
> > 
> > +static irqreturn_t lan969x_ptp_irq_handler(int irq, void *args)
> > +{
> > +     int budget = SPARX5_MAX_PTP_ID;
> > +     struct sparx5 *sparx5 = args;
> > +
> > +     while (budget--) {
> > +             struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
> > +             struct skb_shared_hwtstamps shhwtstamps;
> > +             struct sparx5_port *port;
> > +             struct timespec64 ts;
> > +             unsigned long flags;
> > +             u32 val, id, txport;
> > +             u32 delay;
> > +
> > +             val = spx5_rd(sparx5, PTP_TWOSTEP_CTRL);
> > +
> > +             /* Check if a timestamp can be retrieved */
> > +             if (!(val & PTP_TWOSTEP_CTRL_PTP_VLD))
> > +                     break;
> > +
> > +             WARN_ON(val & PTP_TWOSTEP_CTRL_PTP_OVFL);
> > +
> > +             if (!(val & PTP_TWOSTEP_CTRL_STAMP_TX))
> > +                     continue;
> > +
> > +             /* Retrieve the ts Tx port */
> > +             txport = PTP_TWOSTEP_CTRL_STAMP_PORT_GET(val);
> > +
> > +             /* Retrieve its associated skb */
> > +             port = sparx5->ports[txport];
> > +
> > +             /* Retrieve the delay */
> > +             delay = spx5_rd(sparx5, PTP_TWOSTEP_STAMP_NSEC);
> > +             delay = PTP_TWOSTEP_STAMP_NSEC_NS_GET(delay);
> > +
> > +             /* Get next timestamp from fifo, which needs to be the
> > +              * rx timestamp which represents the id of the frame
> > +              */
> > +             spx5_rmw(PTP_TWOSTEP_CTRL_PTP_NXT_SET(1),
> > +                      PTP_TWOSTEP_CTRL_PTP_NXT,
> > +                      sparx5, PTP_TWOSTEP_CTRL);
> > +
> > +             val = spx5_rd(sparx5, PTP_TWOSTEP_CTRL);
> > +
> > +             /* Check if a timestamp can be retrieved */
> > +             if (!(val & PTP_TWOSTEP_CTRL_PTP_VLD))
> > +                     break;
> > +
> > +             /* Read RX timestamping to get the ID */
> > +             id = spx5_rd(sparx5, PTP_TWOSTEP_STAMP_NSEC);
> > +             id <<= 8;
> > +             id |= spx5_rd(sparx5, PTP_TWOSTEP_STAMP_SUBNS);
> > +
> > +             spin_lock_irqsave(&port->tx_skbs.lock, flags);
> > +             skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
> > +                     if (SPARX5_SKB_CB(skb)->ts_id != id)
> > +                             continue;
> > +
> > +                     __skb_unlink(skb, &port->tx_skbs);
> > +                     skb_match = skb;
> > +                     break;
> > +             }
> > +             spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
> > +
> > +             /* Next ts */
> > +             spx5_rmw(PTP_TWOSTEP_CTRL_PTP_NXT_SET(1),
> > +                      PTP_TWOSTEP_CTRL_PTP_NXT,
> > +                      sparx5, PTP_TWOSTEP_CTRL);
> > +
> > +             if (WARN_ON(!skb_match))
> > +                     continue;
> > +
> > +             spin_lock(&sparx5->ptp_ts_id_lock);
> > +             sparx5->ptp_skbs--;
> > +             spin_unlock(&sparx5->ptp_ts_id_lock);
> > +
> > +             /* Get the h/w timestamp */
> > +             sparx5_get_hwtimestamp(sparx5, &ts, delay);
> > +
> > +             /* Set the timestamp in the skb */
> > +             shhwtstamps.hwtstamp = ktime_set(ts.tv_sec, ts.tv_nsec);
> > +             skb_tstamp_tx(skb_match, &shhwtstamps);
> > +
> > +             dev_kfree_skb_any(skb_match);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> 
> This handler looks like an absolute copy of sparx5_ptp_irq_handler()
> with the difference in registers only. Did you consider keep one
> function but substitute ptp register sets?
>

Yes, I did consider that. But since this is the only case where a group
of registers are moved to a different register target in hw, I chose to
instead copy the function.

The indirection layer introduced in the previous series does not handle
differences in register targets - maybe something to be added later if we
have more cases (hopefully not).

/Daniel

> >   static const struct sparx5_regs lan969x_regs = {
> >       .tsize = lan969x_tsize,
> >       .gaddr = lan969x_gaddr,
> > @@ -242,6 +331,7 @@ static const struct sparx5_ops lan969x_ops = {
> >       .get_hsch_max_group_rate = &lan969x_get_hsch_max_group_rate,
> >       .get_sdlb_group          = &lan969x_get_sdlb_group,
> >       .set_port_mux            = &lan969x_port_mux_set,
> > +     .ptp_irq_handler         = &lan969x_ptp_irq_handler,
> >   };
> > 

