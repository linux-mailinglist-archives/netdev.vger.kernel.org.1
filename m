Return-Path: <netdev+bounces-96677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5558C71B5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BF81C20DA6
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CF21104;
	Thu, 16 May 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DrENtvhB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E08171AF;
	Thu, 16 May 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715842154; cv=none; b=HMmUY7k4FYk9bnbKDh26q70xkEArPrk8bQcB8xUPTAASlzEzipawR3Jbh0g95XqubP6ZUELea1vVr+wVkI8jPNUm7o8NaIE4rSLJLHc2AUETmiBSAKhjmB6Ar0yRdfrzjbWxIihnf0ezcRzikpoeQAycaBPndYeeMrIWui8g4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715842154; c=relaxed/simple;
	bh=SyMmY+b4YU3SONunGKIa26m5Xb6BwsXQTNlCEx0uWe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLkKO5JaKzBViTIhf1skCSWOxAWRWIMwIjuaf6QHQpHSEIKDQDJFSrmXrnqH7bOiVmyBAX7WYgwzJbfcTWbR8GHDCZM7VgTn8MkdJa7csv8haqUZ8phjW3EGIO5zEVARGyLyEyTEeh77gPjPSRfip+mQ1sbeabHXQQf8WjRKCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DrENtvhB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715842152; x=1747378152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SyMmY+b4YU3SONunGKIa26m5Xb6BwsXQTNlCEx0uWe0=;
  b=DrENtvhBcPIWMTT6+UZIiY2zC/yC4VfA8k24iZxDdZ5KY9tvgOKpExEo
   m9XDaVhPnSYkGFs96IyMUJ6lPQICmF187VTtI4KfPYXmbNQ+aJgjRQv03
   4mZHJw3u0bmskHyMOkcnBvdRow+CFGsvivdG9/OQOSFsynm7ZTOjaLXjt
   jm3OljGKR6v1ZwqluJV9LIiyDYJefYytauCRgzX4/NimgHD6qYq4kQLrc
   Rjc3uaChVH5ZmN/Dq81k4IfNbXZnLC8TWjDl75AZK+oB+vpsO27pou63m
   wnb9fKsbEfFrcfEYsi2LBk/W0Pmni6FCUA+DlbVINQvJmaErriZ7406wx
   Q==;
X-CSE-ConnectionGUID: 0HJ+oesVSAS5tXgfLO6EMw==
X-CSE-MsgGUID: zTkDEhL6ToquXWLHL3TPVw==
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="24943960"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 23:49:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 23:48:56 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 23:48:56 -0700
Date: Thu, 16 May 2024 08:48:55 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net] net: lan966x: Remove ptp traps in case the ptp is
 not enabled.
Message-ID: <20240516064855.ne6uf3xanns4hh2o@DEN-DL-M31836.microchip.com>
References: <20240514193500.577403-1-horatiu.vultur@microchip.com>
 <20240514222149.mhwtp3kduebb4zzs@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240514222149.mhwtp3kduebb4zzs@skbuf>

The 05/15/2024 01:21, Vladimir Oltean wrote:

Hi Vladimir,

> 
> On Tue, May 14, 2024 at 09:35:00PM +0200, Horatiu Vultur wrote:
> > Lan966x is adding ptp traps to redirect the ptp frames to the CPU such
> > that the HW will not forward these frames anywhere. The issue is that in
> > case ptp is not enabled and the timestamping source is et to
> > HWTSTAMP_SOURCE_NETDEV then these traps would not be removed on the
> > error path.
> > Fix this by removing the traps in this case as they are not needed.
> >
> > Fixes: 54e1ed69c40a ("net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index 2635ef8958c80..318676e42bb62 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -479,8 +479,10 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
> >               return err;
> >
> >       if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
> > -             if (!port->lan966x->ptp)
> > +             if (!port->lan966x->ptp) {
> > +                     lan966x_ptp_del_traps(port);
> >                       return -EOPNOTSUPP;
> > +             }
> >
> >               err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
> >               if (err) {
> > --
> > 2.34.1
> >
> 
> Alternatively, the -EOPNOTSUPP check could be moved before programming
> the traps in the first place.

Thanks for the review.
Actually I don't think this alternative will work. In case of PHY
timestamping, we would still like to add those rules regardless if
ptp is enabled on lan966x.

> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

-- 
/Horatiu

