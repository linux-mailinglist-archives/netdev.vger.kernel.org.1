Return-Path: <netdev+bounces-99255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C08D43B1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B97A1C211FB
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B571C68F;
	Thu, 30 May 2024 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFOIpTuL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239E17BA4
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035915; cv=none; b=fD9SUGLuYrQxg+TrSUg1RBpkDxqm7tlPaY1/+S+dSMLKEjkxgzZxAsCK+YKnxWcLxkHHbHSK9DfLet63VJ5a5SpmIRL+UXrEI2Xya5nqhYlcoMwauz42g71eGcq3YF9JO7QxTVCfJ3MS99Sr21pf1A4zx90+GQ5Oqf+PfHLMfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035915; c=relaxed/simple;
	bh=UcxU3E0qQ+2AG+rQmng32OwJU8UN9xoTEsh8++nAILg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGgRKTIPvwDDJ9PrzfqpKb96whk1laW/HmS69SB0qxjKZIK/tvnhKlbheEeJOnu8+T/KdZ4rzTsCFvnf0zQGuLGH4DXv5U4ZRjCobeSlfAobfgCR4MbwQ8ejn2Fk9FWn2zzNijXVG9U2C4nqaDIHW+OjBWioHvd0pGAOHt64IfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFOIpTuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB34C116B1
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717035914;
	bh=UcxU3E0qQ+2AG+rQmng32OwJU8UN9xoTEsh8++nAILg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eFOIpTuLEnJloRsRSP0s4IYk6P5TxUwtMGURLr+IMtqEH2BQSYCp8V/5IxAILCg+S
	 dYuwsBS1wEXckexTHZsKvytba5yiTm+huqV9RYiiUSnJguMgl8tGfiS5P8bgCO4ofj
	 LlCMMcYp3eufu1MGNnwplopVmOL0dFmGuhKj1uMwpAX0vcHUuBsptD84CTYinpX5wb
	 o23G5OiDF6r1NXQ8aIs7CYzuTiRG3zJYYB9+z+utB/dvewTO+6xSL6pGZ/U8s3tEva
	 j5KrSo/KHWeBesJmoOj16gZR6wXUB+dziGIYB3of1NO7IS5DJ3oeML7XkevXqbFGA/
	 wDJP5HYXyfb6A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a626919d19dso105323266b.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:25:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoHK2bUc3iDcR4w/rwaraeKYqOVi698kqvk0YTRp5rvKayd3yaErMJga3iWHm2whyeXAiI+kdnT7Sz127clLqXer2ekZA3
X-Gm-Message-State: AOJu0YzcpxjPdxMwYxHX6ld/zLi9Mz/LAEdoWKBEX7fBaHXDNcAlKvY2
	ALUaSee9KlMgB+Uv0QzRe+9hEU+sYSUqlQPlSnvOsQnxwQULEt6NEY9zXdQXW9bIFuFa8vsozgX
	vGrpI/wE2DZr9SUV+ktajkJKGqro=
X-Google-Smtp-Source: AGHT+IFaExT5wshCLDKuDJFe7Sx+KVmOlC7lmJ1yzBoulhBEVmtHrY1Kg64OdEqfJWGmnE/c+sQYQ1wGWRvka+u6L/k=
X-Received: by 2002:a17:906:abd6:b0:a59:bbea:14e8 with SMTP id
 a640c23a62f3a-a65f0a5539bmr42119566b.17.1717035913341; Wed, 29 May 2024
 19:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973237.git.siyanteng@loongson.cn> <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
In-Reply-To: <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 30 May 2024 10:25:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
Message-ID: <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yanteng,

The title should be "Fix ....." rather than "Fixed .....", and it is
better to move this patch earlier since it is a preparation for later
Loongson-related patches.

Huacai

On Wed, May 29, 2024 at 6:20=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> =
wrote:
>
> Loongson GNET devices with dev revision 0x00 do not
> support manually setting the speed to 1000, When the
> bug is triggered, let's return -EOPNOTSUPP, which
> will be flag in later gnet support patches.
>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ++++++
>  include/linux/stmmac.h                               | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 542e2633a6f5..eb4b3eaf9e17 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device =
*dev,
>                 return 0;
>         }
>
> +       if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
> +               if (cmd->base.speed =3D=3D SPEED_1000 &&
> +                   cmd->base.autoneg !=3D AUTONEG_ENABLE)
> +                       return -EOPNOTSUPP;
> +       }
> +
>         return phylink_ethtool_ksettings_set(priv->phylink, cmd);
>  }
>
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 1536455f9052..3e4f7e8d73fb 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -208,6 +208,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI         BIT(10)
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING      BIT(11)
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY   BIT(12)
> +#define STMMAC_FLAG_DISABLE_FORCE_1000         BIT(13)
>
>  struct plat_stmmacenet_data {
>         int bus_id;
> --
> 2.31.4
>

