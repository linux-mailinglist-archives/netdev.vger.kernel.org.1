Return-Path: <netdev+bounces-96935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30268C84A6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57471C22BCB
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978E2E62B;
	Fri, 17 May 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JcSCPqgd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58879FE;
	Fri, 17 May 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941110; cv=none; b=D0nYTSHZKJt28+kMWROdr/gssfKZ/5Js4xazYOn+estWPfP2NPU5ews7ofTNLRAcXCiDw23H/ir7+Tefafya+8gTg6Oh6ynvV86jXF3QodvF1+oIHpQx6gdy/KEVDsNgEPNzoRiUju+rwLZr1Cg3byuPrS/j22D+waUBZD7//xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941110; c=relaxed/simple;
	bh=SpQPJgD5ifcMb7DMXQffQ8OLyoliyiYJJKgW+mO9s+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMTyqEJVKASko5Zt+JoZfWphiU02llpTQZMIDtWUh3m8R4O6ED+K+CJ8BC0PbRZuWK5zSexdlzVX/OE539FyfU8i6DXI/B9ytTZnTD4HtZT8+7ZTxTVgQll6ZEVnF13stoOTXq2lD9JdayzP4N/2oYskWfgdpZ7q4edW2pKzzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JcSCPqgd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715941108; x=1747477108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SpQPJgD5ifcMb7DMXQffQ8OLyoliyiYJJKgW+mO9s+Y=;
  b=JcSCPqgd0y49KRPXYTC8+DbVqQ0A0W/u9H2Khu0XqSc4OZfoAgQhso+y
   TG1j7alXV8liFxkL11m0tQl+fIt1xkXw/sTdtZ+0/x3egOoYv7NeLsxan
   OkOQiO64+QQLUqsdCAw1KYRUTO1YUbm8ILA85Ortnf2qSgBhA6vzLTRoi
   UB/UPfut8RG+zUn1EkY7Wn5VCwxwK0CtGJ7t8XjAN/qZU4Fc55vx+31Yp
   O5DiuVrRv4LPJibL1h4OKxLkYMFbSQa45WjbS+w0wA5cLy0SJvhrTyi+t
   tV88uOd9k2jwdqovGntUhfvAOMqmqcoWdw4gK+Q5j1hCjKVBDfc34i5Tq
   g==;
X-CSE-ConnectionGUID: Azrk/14wTjiVmxHBQWS5nQ==
X-CSE-MsgGUID: KU0HZz42QG22qF0FR+jm3A==
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="25633951"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 May 2024 03:18:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 17 May 2024 03:18:12 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 17 May 2024 03:18:12 -0700
Date: Fri, 17 May 2024 12:18:11 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net] net: lan966x: Remove ptp traps in case the ptp is
 not enabled.
Message-ID: <20240517101811.vsqcg7moapixlfpj@DEN-DL-M31836.microchip.com>
References: <20240514193500.577403-1-horatiu.vultur@microchip.com>
 <20240514222149.mhwtp3kduebb4zzs@skbuf>
 <20240516064855.ne6uf3xanns4hh2o@DEN-DL-M31836.microchip.com>
 <20240517100425.l5ddxbuyxbgx42ti@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240517100425.l5ddxbuyxbgx42ti@skbuf>

The 05/17/2024 13:04, Vladimir Oltean wrote:
> 
> On Thu, May 16, 2024 at 08:48:55AM +0200, Horatiu Vultur wrote:
> > > Alternatively, the -EOPNOTSUPP check could be moved before programming
> > > the traps in the first place.
> >
> > Thanks for the review.
> > Actually I don't think this alternative will work. In case of PHY
> > timestamping, we would still like to add those rules regardless if
> > ptp is enabled on lan966x.
> >
> > >
> > > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > --
> > /Horatiu
> 
> I don't understand why this would not have worked?
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index b12d3b8a64fd..1439a36e8394 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -474,14 +474,14 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
>             cfg->source != HWTSTAMP_SOURCE_PHYLIB)
>                 return -EOPNOTSUPP;
> 
> +       if (cfg->source == HWTSTAMP_SOURCE_NETDEV && !port->lan966x->ptp)
> +               return -EOPNOTSUPP;
> +

This should also work.
Initially I thought you wanted to have only the check for
port->lan966x->ptp here. And that is why I said it would not work.

>         err = lan966x_ptp_setup_traps(port, cfg);
>         if (err)
>                 return err;
> 
>         if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
> -               if (!port->lan966x->ptp)
> -                       return -EOPNOTSUPP;
> -
>                 err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
>                 if (err) {
>                         lan966x_ptp_del_traps(port);

-- 
/Horatiu

