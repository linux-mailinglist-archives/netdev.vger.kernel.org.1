Return-Path: <netdev+bounces-240026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A70C6F7D4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33E803839CE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898B34C141;
	Wed, 19 Nov 2025 14:43:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49232D0ED
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563423; cv=none; b=i33wIOKaRHP1frhj26HwvsDeixyOk4jGvudYZW/cOMkq8Uie182oOB3Sift5SCfQyjjy25Doiy4RwTMSBxzHpYOADOe6JGALyl085Xd3+AgNEJ/UaUMuXK8mEXTC9k+tDXOaQGLnfoATK5YAcc1vGbOflh12O5MNBBdMJSrWpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563423; c=relaxed/simple;
	bh=tN4N7vuK4JJ0rterP05amy6D7j/6Qj9sv/6YKc8hKYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJAMgMWxujmXKW/AyO9QvV0UcjFXbouGehvYFf8iJ1lBlcZtxtT84R7mLmuUHRChCNgJy6v5E9lCul67Nos7bZOBJuk+NA2TP+bNpcTnZlTX2QF9KT1a0NmEhktwoTkhwUX6wd+ghAAXiEw5bwz2QNe9RqMs4NTshyfejYF/Ig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37ba5af5951so61919301fa.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563416; x=1764168216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4rPsaXkkkPPqP8F89aStRjGcZr5tE7ulQ3b9FN2Uak=;
        b=Mz7PPbspKp+ujT0mepw90gTWKME3b7Mcus9iCF5bFpTWKrg5bYcAPX5MiTx7fH7lh0
         kMF6Dn1q5BrrAz4ZYQQANdajddR1SckZ1SgO+M37Z3jOlkN9fFlQShlrq+ckMuf7fsIc
         3JyALRfggoSmGt7iTeeRtVB4XtOrKTwIAvXfeRZEgZy+glHbGgClJCoEXiueShzf/YVc
         3U7rzkdYmOz71yNOOjH88pioW0IrlVQl2An061+nWxex24GpElo26w8RKUPVf7o8S/aB
         Mu7nMtY2U0nCIITG0esueq9TWsvn7lk91MbkGsaXP88owCU0RKewRKRs2zJce9q2oCTu
         Nafw==
X-Forwarded-Encrypted: i=1; AJvYcCVvqX7HCPNux4EBg0zIu12Vj2t3xz8KXGn0wL4smGEUIDZxatMeYi52DY3cO/FZ6OSnxqK2gn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbqPjXk2KHKV18WHGQjmcgxAtH7mDykwrOORU7RfoP1N/8Rzf
	vbkuL27ahcPXkdyIPdKAkI+uG8UmWh+NKQFY7YVPRsQ6NTOxqCO33KFVIzde5SWB
X-Gm-Gg: ASbGncuuz03DV0C01O6q3DEprpXesTYuY+Nkl7j37kbheLu/uF/UDdx+3zZRHgAb66A
	KJnc2n4iTXr86LH2M0ki7yHpgokdODPqsGOmqoMcvKnix7+vVvTDZO44gn7B/tI8KEPETOL271n
	VsMS2p5FJxJTb0Bsv6G1NFFBx/x3EDUccmeTQ8amApxp1IakmVfK9G2ltOsEy38K3BRgd7Q3h7U
	IHoJ+5/RQJNtcfuH0bmWCac61yIEVPng0tJgaMPJ2/BKse7gEPp4dqXMH26nVmhGA2AN3R75iP0
	+/tJ3Tn+enyz3TThwqGdNaPdvIAPX2RnvIRNiClypbr97MpEAD42iG4UXbNUE9HiPnDyTuOlZL6
	sKMvIbjz49JfCP8vk9c6zO8egJ02vm1iRDUy+3uRLW2/+HrOFbO+vr6z7Uyt5xGXPBmZBpU6IM3
	O/Bax69tD/C2C5JMX2EPkYmX5cnGcKAoZzvfCsd0+mbvy5Xv2DZkDlkA==
X-Google-Smtp-Source: AGHT+IHnxVBRnkWu6mRZSyUTXxFbVnhLpzzz1f2NKcF7+hWUUAHLvK/nV4REGK6Q3UChVMYlPqWy8w==
X-Received: by 2002:a05:651c:23c2:20b0:37a:5c06:6eb1 with SMTP id 38308e7fff4ca-37babbacecdmr50467501fa.17.1763563415965;
        Wed, 19 Nov 2025 06:43:35 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9cee0cabsm40924281fa.40.2025.11.19.06.43.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 06:43:34 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37ba5af5951so61916991fa.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:43:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIDM7fVLC0+U6hdCRIeEqX73gSIq3/lxeqN+NncpHW5RrGXR+S6xuGk/qrrm/F8zt6MD2pRr0=@vger.kernel.org
X-Received: by 2002:a2e:9ace:0:b0:372:904d:add4 with SMTP id
 38308e7fff4ca-37babd35f8amr45635351fa.28.1763563413779; Wed, 19 Nov 2025
 06:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aR2V0Kib7j0L4FNN@shell.armlinux.org.uk> <E1vLf2U-0000000FMN2-0SLg@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vLf2U-0000000FMN2-0SLg@rmk-PC.armlinux.org.uk>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 19 Nov 2025 22:43:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v65syu47YAy8-24LDXt1MC2K7r+weOyCWn5fZzRgSFhnDA@mail.gmail.com>
X-Gm-Features: AWmQ_bnEwqpydG-ZRtqWc8I4l30DitJuwNrACYzTdhyRCjLGsAnpeFb-cKD8BLA
Message-ID: <CAGb2v65syu47YAy8-24LDXt1MC2K7r+weOyCWn5fZzRgSFhnDA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: pass struct device to
 init()/exit() methods
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Drew Fustini <fustini@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>, Jan Petrous <jan.petrous@oss.nxp.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, s32@nxp.com, 
	Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 6:04=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> As struct plat_stmmacenet_data is not platform_device specific, pass
> a struct device into the init() and exit() methods to allow them to
> become independent of the underlying device.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-anarion.c   |  4 +--
>  .../ethernet/stmicro/stmmac/dwmac-eic7700.c   |  4 +--
>  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 12 ++++----
>  .../stmicro/stmmac/dwmac-renesas-gbeth.c      |  4 +--
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 14 +++++-----
>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sti.c   |  4 +--


>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 10 +++----
>  .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c |  4 +--

For sun8i / sunxi,

Acked-by: Chen-Yu Tsai <wens@kernel.org>

>  .../net/ethernet/stmicro/stmmac/dwmac-thead.c |  2 +-
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 28 ++++++++++---------
>  include/linux/stmmac.h                        |  4 +--
>  12 files changed, 47 insertions(+), 45 deletions(-)

