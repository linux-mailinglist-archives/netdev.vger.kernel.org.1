Return-Path: <netdev+bounces-143240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF5A9C18A0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBBDB247F0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E851E0DCE;
	Fri,  8 Nov 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UNnxvySE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7141E0B82;
	Fri,  8 Nov 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056418; cv=none; b=NcznuYTNo4X7hC68SEpYCWECHvZkSpqhpJflq5CpMLbmjDoGfT5XunSN75q4x7UVRei2G7jtxEVlZJndTRLiRm5gboVyjqIl5gtTK05xEXLsXmkfnoVf50dyKQkt8x4sRW8cfkt/tXQ715ofoeqFn6NGMgx4gfJPqZVZk5ayrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056418; c=relaxed/simple;
	bh=0RV4BRrDPu9fzqimtYkCGhm8dxWaki2Xe2w2Vb0cDQM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkvxAxdtMWV05xBcJaegTbk6XrUZ+txkMCjoe5hd+GpwskqHrhlJVoEIByidTizlGRu5TZRwgFtX/1SKIc2k1qPnNfq4NcUpRfJukeWD9Fd0yv90vgO/hky81acQl5pik9ldJiBLm66cDPcWcRrzv2flrLkio1Aipi5nNqL9cj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UNnxvySE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731056416; x=1762592416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0RV4BRrDPu9fzqimtYkCGhm8dxWaki2Xe2w2Vb0cDQM=;
  b=UNnxvySE+dSEzp8niNbW5zasK//WIdY/LnxTERRzVakH/T8hX8mn/C1h
   8WEOcthRml8ykI2tfdjiUlfbGKxGkXS3gAk+RPK145MOhW8MxezyGUa66
   OHIOhGuJZ4GR7hOM+x2LNyiU6mVYN3Ol07YeoRj11VNng5yZZ8gJxpawd
   1UY5zZU8piRXUJORAFBHNNtMUHRVu0pRbibEGmg2hcjdBZBozou4C/shG
   nFTaJgNxhv67ZkkMMuaamyB5YwlfwmaomuD2dgD1Myw4CyShVxyh33Tfz
   gS+X3apw53IT/59ew12rsVSoHV10c7tXVdBdCrfEABd5bDqvNWBxakNXt
   A==;
X-CSE-ConnectionGUID: HVTPMN6wSQqpa45vmMRqjw==
X-CSE-MsgGUID: +GH327iKRSSLSExU7iDt1w==
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="34564944"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 02:00:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 01:59:59 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 01:59:56 -0700
Date: Fri, 8 Nov 2024 08:59:56 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 3/7] net: sparx5: use is_port_rgmii() throughout
Message-ID: <20241108085956.pr23rcnkhleoesnl@DEN-DL-M70577>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
 <20241106-sparx5-lan969x-switch-driver-4-v1-3-f7f7316436bd@microchip.com>
 <4748d3a9-55e8-48f9-b281-60ec619bf304@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4748d3a9-55e8-48f9-b281-60ec619bf304@lunn.ch>

Hi Andrew,

> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
> > @@ -1087,6 +1087,9 @@ int sparx5_port_init(struct sparx5 *sparx5,
> >                ANA_CL_FILTER_CTRL_FILTER_SMAC_MC_DIS,
> >                sparx5, ANA_CL_FILTER_CTRL(port->portno));
> >
> > +     if (ops->is_port_rgmii(port->portno))
> > +             return 0;
> > +
> >       /* Configure MAC vlan awareness */
> >       err = sparx5_port_max_tags_set(sparx5, port);
> >       if (err)
> 
> That looks odd. What has RGMII to do with MAC VLAN awareness?
> Maybe it just needs a comment?

The sparx5_port_init() function initializes the RGMII port device (and
the other types of devices too). After the common configuration is done,
we bail out, as we do not want to configure any 2g5, 5g, 10g or 25g
stuff.

I can add a comment, sure.

> 
>         Andrew

/Daniel

