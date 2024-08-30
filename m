Return-Path: <netdev+bounces-123722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E2966467
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5791F2364C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9DD18E378;
	Fri, 30 Aug 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNx3B74S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1C14EC41
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029186; cv=none; b=O6HE3mbUMwhjNmDCOqMQebJeZwqtd02elOou5DRP3nwSytTH0ci+Dh5ep9P5ytJCHEpyoYXyVCs/W7XVtKbsD4w4eAOwp+u2Yixz0x7a14jyapd0HtESgHM2X0Fb4bq46UwuG6SShE6DRi5OKDl/1MWItR44MKnneZouOr1Y/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029186; c=relaxed/simple;
	bh=xvK2Xe7XBmIyDjVnta48phXO4kCNFDvkydc8w74p2EU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ClfcOMJgpegj98Erj2mG81aNXE254v4dhEoQUsBpX28s3IBB/EUsso2G/Yy6FU4AraI2d+ZN21gRZYlQOhv9IOVNrOX2+SZs9CRYRZwzzbD99Qq8eFYMsYRWhWif0BsqOYpaaVZNbJKyQfE1GRsoliiIPSe36jlJclA0NlXkwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNx3B74S; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27018df4ff3so1103995fac.1
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725029184; x=1725633984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiy9a3HSFwh1r+yIXLvfqdBHgYscRWI+30wHsQUPQTo=;
        b=FNx3B74SIlmz7vmynQOKZBNwuncgDorPMq+dC/TAVeJTsJUIZo+JCeNUQmY/QF8bMo
         6GGzHQlMX+3bPlYE1gTwfh1n3iTuDQwp03djfcuLFBDoCqAot6EXfOfvvjLSE3UffiU0
         Vc/PYd6Psiu+mdATNaznvzwYYTu+mjfFotSW+c/QGxc6ZcnrFYiCOqszt5jWdhZok8EZ
         OF3DGPSGVZaZi9grKfdxuwsyYu3z+vHTUZR45BzHE2Md3QaF2O4hzbyYJz+YCTpJd4wF
         TSoR5XbCxewxkigpNKTXhg/ZapKRQQ/NmXISn+Rm0FBzmhqLo98B0DSDa5iBTqrWkbRh
         Nerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725029184; x=1725633984;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wiy9a3HSFwh1r+yIXLvfqdBHgYscRWI+30wHsQUPQTo=;
        b=uHj5tZuTai0Mb5+9PVeJVlKfMiBSj7HKr5+u65hXWUUMdngubKxB6o7paV+1dqoLrc
         xf0YNxHUPmbAm4I6gtATd+v9g0BqpUrmsP+uG76T62IlhXliCPNSM23Pn9HXgKGUc4bE
         FBspbU5xWSn9kDZiN/9UAzKJ58Yt8Eeu0gCvcPWM65g0eoaKDDsQeQ7V5vGPnftmzVgN
         qy69YVUPcia3YlW8jCYRFFbIgsRQSwvgHEfr3ZBH9ZCXcrMl7rCJNTG9BJcXsyJ6NVx1
         LvxBM9LH2U852XSipOgAASQJdrYEJL+PkQvKzI0sQzZX0b4HCXURFYFH4/1H/4Xf9zf5
         GMbA==
X-Gm-Message-State: AOJu0YzmQK6mSg6e43txBn55y1jBcRCPcZLckPrNsPihAvPM9mS0atKz
	Q6ZJMXCRVYddZKo+UDyCy6Q36RbbyJUKuEolgNCHRQNdU5A0SZt1
X-Google-Smtp-Source: AGHT+IHM+JeDGu8O/zbHUSdsZcALt4YmN02wFkOxnD3kUG6+4OR+LroiFtOCapMp05K7mRVfvdYXsw==
X-Received: by 2002:a05:6870:3510:b0:25e:1cdf:c604 with SMTP id 586e51a60fabf-277902e4f79mr6532634fac.31.1725029184026;
        Fri, 30 Aug 2024 07:46:24 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d6f76esm148449885a.108.2024.08.30.07.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:46:23 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:46:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
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
 Wei Fang <wei.fang@nxp.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, 
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
 hariprasad <hkelam@marvell.com>, 
 Ido Schimmel <idosch@nvidia.com>, 
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
 =?UTF-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= <niklas.soderlund@ragnatech.se>, 
 Edward Cree <ecree.xilinx@gmail.com>, 
 Martin Habets <habetsm.xilinx@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 MD Danish Anwar <danishanwar@ti.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Gal Pressman <gal@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
Message-ID: <66d1db3ec801b_3c08a229453@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240829144253.122215-2-gal@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-2-gal@nvidia.com>
Subject: Re: [PATCH net-next 1/2] ethtool: RX software timestamp for all
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gal Pressman wrote:
> All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
> net_timestamp_check() being called in the device independent code.
> 
> Move the responsibility of reporting SOF_TIMESTAMPING_RX_SOFTWARE and
> SOF_TIMESTAMPING_SOFTWARE, and setting PHC index to -1 to the core.
> Device drivers no longer need to use them.
> 
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Link: https://lore.kernel.org/netdev/661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch/
> Co-developed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

