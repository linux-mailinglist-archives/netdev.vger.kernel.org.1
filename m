Return-Path: <netdev+bounces-224081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346DB808AB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3249E6215BB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1113728B8;
	Wed, 17 Sep 2025 15:25:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234336298D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122730; cv=none; b=EyytH0+scwhxCt226dT3hZEUnQO4UOwxnk55Sn0owZQJot7LnRBe8tf4f1kZLKfAfinOaqEq5O8r774UUb5lQT+GUpzhf3OrAqSYZu7tZbiRsKptsPkIN9PCMNl9rrnEK9N1PSGZOpAwkA5iZHm47EqnwOjM0i2bc2KK+bm0wR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122730; c=relaxed/simple;
	bh=q27fzm1U+HTtOJk/CZd2YtayE6m/1WFC4/HuVd7xPus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWQesAXylYrNi6JClTL5sRfs3kz3L13iTZPExeX8p1UC2TvATYPHUyA68o6m3tVq6HQz6UImMltWXqFb4n88sNZVTNm5B7adfYX/BDNTqm85Xrxdnfybs1GiimEWkaKWuk3qfqCsKsDsQz3bADdLzDqK3yPQax3jC5ZpdDcFhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3601013024aso8099091fa.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122724; x=1758727524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q27fzm1U+HTtOJk/CZd2YtayE6m/1WFC4/HuVd7xPus=;
        b=sanWM7sxKWvvOYOFjXUGh4lxyvQj87a91BzYkzJprLkR3Y+L4DmSNynhJ0eRiCVllg
         g0NmN/ykK3xLD3AAO9s5y+6KTuJwr4FnknviTZUqVg06YAo2SAY6CKBZ+tagPzqpdU9L
         eo2TwGOfJXKQVkTKLTWCyWNnJMktuwEZuXNIPoJ9kLdwtV2J+7/W2/AX7OeD1V1NlXQj
         puRcgjBHGg9Nbz7VQvN9oeF+NzZpsrX78YNvWUt1dbHxKLtFaPaye4WW5AByHCghRr23
         MvTulJOGUFUOh1+kydrg3Z9m8Ufh1m+ymqZPFsfmA6c/2vQWWNZcEVyvYE3yhex/oaZZ
         L3kw==
X-Forwarded-Encrypted: i=1; AJvYcCW80utodOdTLxW3V+8dnEYQdvHYnlMXk3Bsy6hpUyic9wk4qdoEqqp2IYYxL2CG1ipM81LzQws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKuEUOMaxtd/W3bEd4C4UkowKXd0LtM8bSrv7HTTgyyLKCWJO
	e8tf2pC0CpCRwT2ccpc2HkVHtEz8PjCLI1/yAJXexbAMbEHSxDdcAGh0lhq577Xz
X-Gm-Gg: ASbGnctCM8UJiL1voH3ppdASbhGXYHWP5jcnFYfUSCrJZ6lV/b2opZRuob+a3nJolvj
	inTiRDrhELEjXuhIBgtLwIeLJZhR4PHH+qjg4yMwaUX+ubUBAlx08pQAx+wVU31J4uCdlz60++l
	gTVAG/YlaiznXD2rf0rjz+F+rM2JkYcitunTFsWujlx4DlC4z7XnCfLGRxeH32hXVAWHGSL2xSs
	y3Br2kWftwTSKmEo8XZO1WyNzUk7RP8uBgWHttFCqPzhhv5qFtHKi2p7LF+wgw7cHf0mQG9SxfA
	p4F25ZnyOHBBVshqq5ZEFd7Gi709ZZgX2XFJq2TwWr1dgM+do5kRI5pGRjKB9QPtY/7CpRN3IQ5
	9rGGU9G+A6vidIgVwwfihSn8oCCKGWHwIFXqEuO1Lahzg26stJig=
X-Google-Smtp-Source: AGHT+IGcb4T7bN0pYWyhkwLXEsylod7pIB6IIMz8UOx7nwja1m5zgBDoqUAEogFJ+fVh1xtSa2w0pw==
X-Received: by 2002:a05:651c:4358:20b0:35f:1b40:1534 with SMTP id 38308e7fff4ca-35f6084555fmr8327251fa.5.1758122723861;
        Wed, 17 Sep 2025 08:25:23 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a58450sm42842811fa.6.2025.09.17.08.25.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 08:25:22 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-577232b26a6so1497857e87.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:25:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJ588ziPvRNIlOYlNL0JhF7pKuSNeqfAMpM5J4DDNOzKAxvo6mwQRS/mmbFh949Nqa3xba6f8=@vger.kernel.org
X-Received: by 2002:a05:651c:2129:b0:336:ba05:b07f with SMTP id
 38308e7fff4ca-35f63f7b5famr7302181fa.21.1758122722394; Wed, 17 Sep 2025
 08:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk> <E1uytpl-00000006H2k-08pH@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uytpl-00000006H2k-08pH@rmk-PC.armlinux.org.uk>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 17 Sep 2025 23:25:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ThmdFN7jHTs6Kf6pG0rhHzQn=X8XXt21qna2HLx3f0g@mail.gmail.com>
X-Gm-Features: AS18NWAKSCnNyj6DLBKT_D2jbUlV9UmfcpG5sUkS8PNH_1L_6YQPZfrfuWMUlOI
Message-ID: <CAGb2v64ThmdFN7jHTs6Kf6pG0rhHzQn=X8XXt21qna2HLx3f0g@mail.gmail.com>
Subject: Re: [PATCH net-next 08/10] net: stmmac: sun8i: convert to use phy_interface
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Drew Fustini <fustini@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, 
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Minda Chen <minda.chen@starfivetech.com>, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Samuel Holland <samuel@sholland.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:13=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> dwmac-sun8i supports MII, RMII and RGMII interface modes only. It
> is unclear whether the dwmac core interface is different from the
> one presented to the outside world.
>
> However, as none of the DTS files set "mac-mode", mac_interface will
> be identical to phy_interface.
>
> Convert dwmac-sun8i to use phy_interface when determining the
> interface mode rather than mac_interface.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Chen-Yu Tsai <wens@csie.org>

