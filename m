Return-Path: <netdev+bounces-126253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CFC9703E1
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2231F1F225CA
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B4C148301;
	Sat,  7 Sep 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNqtBG91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79818030
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725736228; cv=none; b=uQfEfWcwe3ewyf5DhDmZqEDo66m4BV0D03SXsKqr6/ljzH3dY0ciqOrXU8DvxDflvvyD3wvtvtUpmMNADnjQcx9eXtyItxDRwPA1FAVYH2iUbD8Ge/5t9i5+10CrAa5aJyDCZh5KUzkrzBjYIrinG3o+lyHjE35QwdyTtKVidWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725736228; c=relaxed/simple;
	bh=sydYssWUia+zZondaYByPACvLvo+snM8+y859gn1yqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXR5/syRy6XQOIvrLCWntBOJnPeXm9/lFoVjWWx9bP8dv3+bgr9L/MKzv14VsJXCVM5Ov09fQcmp6EKuzEfINAKshl8Skvcp8A4KAvRlyybH82KEljhJUedqKF7VF7zxTqeyKDfOGUGBs9y0Bcd78etIdyCOBOfTrLfK7KhqSTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aNqtBG91; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso42184291fa.2
        for <netdev@vger.kernel.org>; Sat, 07 Sep 2024 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725736224; x=1726341024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sydYssWUia+zZondaYByPACvLvo+snM8+y859gn1yqc=;
        b=aNqtBG91Y1jgK6XuBYY0AEvBAkx9h+KgTMAS6DM16018Ay2oZ9olgGbKNd2Q3sP2Em
         1wEwBM5GqLNblui9qrA1GbhZoRkuQ0Gx4qoad/VbUUlkRb9NwysxvQz314kBLf09sEee
         fkThBbVjW8YZZX48OhQmdhLj25ba/UT2CANIMPmLvfBfAqZ+4LUsbCvN/SYndkO6xtf4
         dxHisNYGo7jAiTYM6bv40XuL936aM+VKaoBkFP1TtNDWAWOYHMJf/kVy6my2QGc8mepQ
         vuTL8k0RMRKCmi6xnrIu8t3/O7S+arpU06OfDosxfMlwrxGunCZ2DLvV2YIddCMQ3c4N
         hiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725736224; x=1726341024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sydYssWUia+zZondaYByPACvLvo+snM8+y859gn1yqc=;
        b=skzXSU/lT+YVFTcmzRJDS0/Wb0Ia3MZcP3rQxGV4I7HbFRAf4gPDmuf2UGcjDXGREr
         A89b/Pe+DmWTIYNIvGmhmq89XoFFHJBNlrehBFYJG2WQ/z5Ti+nF1wCF+UHqXpi4+Tiy
         LO1qhp00y3j562cUNFY8bWfnoUDdc2H+e+6Impo/nU25LXdwuh89nLkbJhLfy0Wrqe1M
         XpLFWqQm/5ejrHs4LvszbCVGhUQpt5RldHuYBpZHGpWK+k8+ct5ZLzgXM1sB84XT9Tsh
         yT/+A7JRd7Gayg7xZDWDGMIiIvQzNuGwkcr5O8+UAtPsDpldS52SHZIHiQXKBJAlSNAa
         Ymuw==
X-Forwarded-Encrypted: i=1; AJvYcCWKdSYY5p8gFgIcfBsKATWTbDanq9/sndSzwZj90H/mF/yY7hD4Cl1aMXA14Zbl8fL9iR6Xjlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgY5vzbTzRy8HuUo20oMT/k4gtXggwaTcJrnDA3lheXbGSfhe
	iU/Yp+10NEClfOHYfyejY1xpNJ3IzTnIiuq9GU4MlS94lipRKVXxHCu8BQVphqAVcdVyXbqYv9W
	iKEgV6CJ8MXBJGILIdBJWf8cz5OMoe9Q1DbN1wA==
X-Google-Smtp-Source: AGHT+IHBS+HIv9yF2p68lLKGdfHAutk1QCeh9S+mS4oyZxefgJiDx1h4l2Ksu3QtKw2/V0i6JkTXszQ2BY3Xf5eqdao=
X-Received: by 2002:a2e:4a01:0:b0:2f6:640c:aeda with SMTP id
 38308e7fff4ca-2f75a991c27mr19131391fa.23.1725736223266; Sat, 07 Sep 2024
 12:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906144632.404651-1-gal@nvidia.com> <20240906144632.404651-16-gal@nvidia.com>
In-Reply-To: <20240906144632.404651-16-gal@nvidia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 7 Sep 2024 21:10:12 +0200
Message-ID: <CACRpkdZru0SfuEmXEdvOp=L+N8inDH3E3o90eXoQmyzO80qsAw@mail.gmail.com>
Subject: Re: [PATCH net-next 15/16] ixp4xx_eth: Remove setting of RX software timestamp
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Sunil Goutham <sgoutham@marvell.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Dimitris Michailidis <dmichail@fungible.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Edward Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>, 
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, 
	Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:50=E2=80=AFPM Gal Pressman <gal@nvidia.com> wrote:

> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

