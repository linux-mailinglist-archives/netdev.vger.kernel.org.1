Return-Path: <netdev+bounces-137627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85EA9A730B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20E71C213C6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D61FCC56;
	Mon, 21 Oct 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kxux+rof"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73231FBC9F;
	Mon, 21 Oct 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537975; cv=none; b=MqOG6o2RheQKkkr2cH9mlFb+G7UJoikc//+3nTkkpVb5pw2RwPfQFHZRkN9t6tHqw1J4YiLen9ZFl371VHSliRuOys0uY0+4meHCI8S+g8lgBNp6fb74vIB/a+97criFHNCKBzOAmoVhFv6m/DcBdhfEgouvSzLeK5C2NG79PO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537975; c=relaxed/simple;
	bh=71MvAum+6d78RYFlLQaF+K24ogaifmLcj8CMqlCWKXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmYNuUvFxNA4p+Bo/ozC7sF9+ZR6nkHWL7PX/aIU2Qf0x00GANJ2DSKkTeKX9NZAbWocYOKqe0tCzfu2ET0M6OeaTenCaUW0728HNXoHgDbgfZe1BG7rLm/5ddPUFgXuvxFw8vhltwr08FVo7wKrogrQBQww85Lo7ARbr/0racA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kxux+rof; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729537973; x=1761073973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=71MvAum+6d78RYFlLQaF+K24ogaifmLcj8CMqlCWKXE=;
  b=Kxux+rofVHucCaVfSb6UY899ioSyZYn38DdrLw+u+nq2sE6TTOy9fspv
   OYiIE+WEyoFJngkORFDUyqXkD+6AkSweji671/dRDBRqUNeh90/LPn5N+
   yj7rcKFRektik0durQvh5V0nQLs9hZUOPyEo0e5fUFbyYJX3vvK4/wTaq
   nPSsGZMFYQnJP92jBjnNIHKCP4Yt6/sLuygRdXQkwmLnovFyv5CAAB5EX
   BkDP9UQRWixdbGr8SeuSjeCWyVzVhOf5t4ftx7AjgpCNAjhhjLCx651hL
   mUln5MMZmwHGGKUAS0mqVUR47wWzvbbMW7UHHnbJpPTVoC5BvrWfsvBVv
   A==;
X-CSE-ConnectionGUID: 8pX8BFJzRaej4ADE6ll6eg==
X-CSE-MsgGUID: t+5YL8yTQN+zeQL/C8b/Ew==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="36683250"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 12:12:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 12:12:32 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 21 Oct 2024 12:12:28 -0700
Date: Mon, 21 Oct 2024 19:12:27 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 10/15] net: lan969x: add PTP handler function
Message-ID: <20241021191227.dxfqli6uoeoxbhzj@DEN-DL-M70577>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-10-c8c49ef21e0f@microchip.com>
 <20241021194638.585a9870@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241021194638.585a9870@device-21.home>

Hi Maxime,

> Hi Daniel,
> 
> On Mon, 21 Oct 2024 15:58:47 +0200
> Daniel Machon <daniel.machon@microchip.com> wrote:
> 
> > Add PTP IRQ handler for lan969x. This is required, as the PTP registers
> > are placed in two different targets on Sparx5 and lan969x. The
> > implementation is otherwise the same as on Sparx5.
> >
> > Also, expose sparx5_get_hwtimestamp() for use by lan969x.
> >
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> [...]
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> > index 15f5d38776c4..3f66045c57ef 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> > @@ -114,6 +114,8 @@ enum sparx5_vlan_port_type {
> >  #define SPX5_DSM_CAL_LEN               64
> >  #define SPX5_DSM_CAL_MAX_DEVS_PER_TAXI 13
> >
> > +#define SPARX5_MAX_PTP_ID    512
> > +
> 
> Sorry if I somehow missed it, but if you define SPARX5_MAX_PTP_ID here,
> you probably don't need it to be also defined in sparx5_ptp.c as well ?
> 
> Thanks,
> 
> Maxime

You are right. It should definitely be removed from sparx5_ptp.c

Will fix it in v2. Thanks!

/Daniel

