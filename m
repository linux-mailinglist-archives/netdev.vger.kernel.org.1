Return-Path: <netdev+bounces-123992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF2967338
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BBB21F23
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980817C7D8;
	Sat, 31 Aug 2024 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foDF3BYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D713A3E8
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725135244; cv=none; b=hpZIOlVLJtq7L2mNinBOdUeJ8NlPZyLewDKcxtqxdvIwxFtkdEGDjQ0/fNqVFkyTl6uYVQ0pTTIZopHMbvUbxVsiCzet9fyDVU4l3bYFrfe+/PlA3isdL6CMOXth2N9A1L3nk0nHLtcNc1oqNqIgj3G/TAzilPBtCI7vpYzRODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725135244; c=relaxed/simple;
	bh=lA3dDz9Vc0mtZeffGrvc48LYF6zWkPyfHBgYxQCG5ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz6sVNEeE2ec+e+7L3A7N6u0K4qUqryh5muwpFRNRoDUSFuuBRJbq728aj7TqcZ7OL4KkoEHJi3RooCL+gwYbPvmDsffgRL5MUr071WwUI32DaFceSYjA6W3MCRD0Gi9h5OeQm9k96gYn0Rh6n/LdX2L7ha5oV+UPHwZBu0MiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foDF3BYb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so1907514a12.1
        for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725135242; x=1725740042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lA3dDz9Vc0mtZeffGrvc48LYF6zWkPyfHBgYxQCG5ko=;
        b=foDF3BYb7NQxzpJasem2r2xzDlHdJDeVc73kbg+vrMrOgYJMpIzEfPHzNlMj9fRGdo
         EQrUDrLGbUhc1PNAGWCm/aJQeslcY9yedlzb4+wpuF1kDkFnSMbQiQGSNJr+gMy4o4dv
         B2xeQXgKa0VeKD+EDF4Ft1AKfBSSM7PolxYp69katYKydETH4aQwogIO5bAPt3EbgShF
         P4r73oBS0LwjkGqVYLVy/ZrYkD/pDR/2YxJh4Ko8gEBDfJdJvftbmHsscLfy6+9T6HEz
         1KnTT7e5TWBtVs4i66hikcRT/fyZiY20fjzlSAhuoqrw80mqO/iiDg9bLzpQP6O+f0bH
         9CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725135242; x=1725740042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA3dDz9Vc0mtZeffGrvc48LYF6zWkPyfHBgYxQCG5ko=;
        b=saVyemJu0qsWO9gSV+eXPwsFk+0JtnvcK5RnQfASEReTShbx5CK9WsqrhQQlhot++P
         i3jyrFlPRWGSpjJAywGjqjAGFLzsFtgPYvB00pV6qOKHMsh6EwXRtadoJxRCRuIygIsn
         EHEloAKd0pgvntekfkwvyf0dHlKV9NM2E8mt4m2nGoHZzJecV88BefuNUkifMjmx/4lh
         6zTZtOGFdsQMjRcnn4mcEQE7s2V3IDD2ttZs9/YCOEWWtgFJOPnhDq/Xhg1Ome0e3msS
         dG/p7LUdUCEiSFWOvuV01M7fzY9EnSAYm8v6U0Y8KxHpf7890RgulrJM8M5AP5yyPyZu
         inHw==
X-Forwarded-Encrypted: i=1; AJvYcCXWZTZmmyYOs8BsihvVSDPXRclzWTEwbvHis0J2oenoetjwg69TY7HYuebR/WTmDlQJxd+Trck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlNvzwMu1OCdurhbpFOZCxdAQrgNWzvYPM0tgvf2iaxMm8L0O
	Te88Nf0Q4BAOLg2hRjVi850wdh7Rzb6gJf9OUkDWMXHivh5LUsom9u26aIzG
X-Google-Smtp-Source: AGHT+IFoP7q36z/iDvGe6TaerxODellsMF7sjOzFiQ6SD2PcIuM7w0kBZCCW1UHUuv5CDQ5tsv1YSg==
X-Received: by 2002:a05:6a20:e687:b0:1cc:d45e:7303 with SMTP id adf61e73a8af0-1cece4d6db9mr4254505637.4.1725135241799;
        Sat, 31 Aug 2024 13:14:01 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054d4aa84dsm12691575ad.132.2024.08.31.13.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 13:14:01 -0700 (PDT)
Date: Sat, 31 Aug 2024 13:13:56 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sunil Goutham <sgoutham@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software
 timestamp from drivers
Message-ID: <ZtN5hJcqCo4Iw2ny@hoboy.vegasvil.org>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
 <ZtI2xWNRuloF2RDF@hoboy.vegasvil.org>
 <067da3de-3c2f-45e5-a598-cafa62e1f0a8@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <067da3de-3c2f-45e5-a598-cafa62e1f0a8@nvidia.com>

On Sat, Aug 31, 2024 at 08:19:06PM +0300, Gal Pressman wrote:
> I would, but it's not allowed to post series with more than 15 patches.

If that worries you, then you can post in batches.

Thanks,
Richard

