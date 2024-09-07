Return-Path: <netdev+bounces-126205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F87970041
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 07:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352E82854CC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 05:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C559132103;
	Sat,  7 Sep 2024 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzGRHkBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518E335C0
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725688143; cv=none; b=us+xePU9aSHpevGQT+raa++HLPsKecUfY+teMEw7sC6Gw3q22m9pHabxxpUIE5nj46/4uWtGEP6wvgFl+zLiABcJT5ZBQpUeHnr3egUZebVE9VtJsnLRvZnHNTXomQTZxZklse62PquYutjo1Drr6ZFnpwRQUxLjZu0x2sz3qaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725688143; c=relaxed/simple;
	bh=fpL2KmgVGEswGmq0OUig2ZMQ5V6tpMHzhpYGuQc87sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdbaQEFFibC/9H6gxlAI39b5IVUjB8AcfQwNG47ZCY1oJJiUQlu5Nj4OTTlcOpWCRsj/rcaO/GvG3AH9ClDWVWUhgXozS23mx20xzJvqDhdUgETh1JS1vuOMQXW3vug0SJHPBzuAOs1mfGLMx8CzLbNfsviR2n2XAroptDtHYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzGRHkBP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2068acc8b98so25926675ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725688141; x=1726292941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbP88ANBdDlMycQ4ZMxRW9xzNrQRIR7X8iAradPZIAw=;
        b=lzGRHkBP98JVyISDErkk61wtRSjggNzIUpxulai7p64XpHqaYR97jJXtafzEC//tmh
         c13p1eKli7WQGIUbr4YGivpB6Ik8wfKx7ytVewmm3YGqYjPNmP1WUMwYWNaOT8YIAgBU
         2hx7zcurpdRSvID8y7SFig+5BPKsRpQO7rHNJ/KyQnGBIQcZq8AJJ/VZmqKH0Tv8rXwN
         CKXEtwCIIuP9kqyjCuUozXu3bNC76oqgacwY8qqDt1ZcHIHUI6Cs2ePwb5NZfr5JBC25
         U55OOGluymuqjGzUYJNamcMcqW1luc6ZvFMRemHSqmFEJ37m427qlFwga5UBDD8o77gL
         ajJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725688141; x=1726292941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbP88ANBdDlMycQ4ZMxRW9xzNrQRIR7X8iAradPZIAw=;
        b=VGYwsu7O2zNz+UpE+MFsBpwndNgEVqp9RcKL/4wqkON6BZgSD0sblRRiKgFxkAx4Ki
         fhjhHZYEq8GpZTAKCiXevUy7c/uX+p3iLcT0uf70aKJMLSChigMAzIUsmwITWcjAhUym
         mnyUaf5JzXULXtQYH4uJhxmO9COOM3AGz8S3VYevvpkUd2w3MY6M3/RquAlHR1bIYlpF
         Fa3WnM9mB71Z70GiiQ2oZxGlTA/R+fe/N/S+rGlj+ih1j+qF/wvUCV0/BQ+xuBNjQvGD
         +gM0K5NnOmgp5wRgxb6X7meNmyMu8mj7QSIJrC0xjYmDt+XGanctGpp4MopqHUBMmZVF
         s2pw==
X-Forwarded-Encrypted: i=1; AJvYcCVimG9sbsLDn5U7U0if25r1LLqgaRN53QFpHtuTkaZGZDureOhgKtchagg0w6gJ6LTCu+HjSiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvhP0gJsagXlVu/PCgxCa8Dl53TOKbsILvgUYeQ3oxTjMEGI1p
	h+doUXUHDd++oFVMxbxh1ajqrIl6YNS4LdeFmq06YA1Gmkiy230k
X-Google-Smtp-Source: AGHT+IFKUiujVoLpyWJ5n3Cg0MRpUhwN9x+MZC633rI2rWIVXFJRBTk9x25hv4kG1WSfOYDw6WFJWg==
X-Received: by 2002:a17:903:40c7:b0:207:1611:d18 with SMTP id d9443c01a7336-20716110d56mr3202235ad.46.1725688141025;
        Fri, 06 Sep 2024 22:49:01 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eeb39asm3234695ad.154.2024.09.06.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 22:49:00 -0700 (PDT)
Date: Fri, 6 Sep 2024 22:48:55 -0700
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
Subject: Re: [PATCH net-next 15/16] ixp4xx_eth: Remove setting of RX software
 timestamp
Message-ID: <ZtvpRzjZo5q9VifA@hoboy.vegasvil.org>
References: <20240906144632.404651-1-gal@nvidia.com>
 <20240906144632.404651-16-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906144632.404651-16-gal@nvidia.com>

On Fri, Sep 06, 2024 at 05:46:31PM +0300, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---

Acked-by: Richard Cochran <richardcochran@gmail.com>

