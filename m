Return-Path: <netdev+bounces-108026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534BC91D95F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B131C204AB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E480035;
	Mon,  1 Jul 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lartWDZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973154765
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820148; cv=none; b=CnHOJSVCSgexJksEwjcV9vafvMX2aEdVCvWltIyiEb7W+KWEAlG2D1IgEkSh5ziP0IfGBeiA6JirIRRNVDzdmF2AbdDBnyRtO5RAi1m38ygAN96JIQ3To7q4P3wR02Yok0J9/bnW0P5kxOY/GNmbkk2YIVA+89q03j3MbQBIUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820148; c=relaxed/simple;
	bh=pJBkp03od0t5cPwYoB01Uwt+nGAhI3y9ejXauMhaoh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwdfF5BBUcMhS8EYkO/Z6Dw9oB9JaIaKq3pJMIq5bpOOU6QQNTUpvjPsHn3lFAYdVU76i/v6HIv+oImH7snzgHrA+z/GCnSWkXbXnfhBlj72hma6twpSFXtbCQhvf9pIR5CeNoHpd64Yx28h9C7faH2eRrjDhGhKaLQbCQ6s670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lartWDZO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so29610381fa.2
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 00:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719820144; x=1720424944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNKIJU8OGmFNb74tPuLhxgiIWEwrxic6628/n7QE6U4=;
        b=lartWDZOOdNXRCYuFkBcm77MsDfOuDkVjk36XVepYTnhSM03otlhvN6WnF53XUTjF9
         vEwimAsi4THfYlK2WeFLHaCaEWvYvJRqq8I8pBddy5I3Vh5vGRH0ebjxytmvTSQT64Ty
         bTzgKMgEJ4nzztQYo0dezc/jZLaQGqyA2J84BytiRujopY9b5q7n9zKAOu/70gCMJ3Qv
         qfGINxsg2zzX0DLsl+LNIxG9hKrtjfS6ji1YAV5rZpQzabjxkeXqFlHQahKvktjslcJK
         jyV5FRzWkPe1VW/EW7Bw5Rgp6w3YgeAGD0GXwV7uI0tC56qFGm4A3U5UdJ0yz16SQSxP
         Tapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719820144; x=1720424944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNKIJU8OGmFNb74tPuLhxgiIWEwrxic6628/n7QE6U4=;
        b=RlEy17gM90EHwb9kytPkoCdo4bx+DmWf++QH1cgcrlnry0LxwJ5enX0f4iJLgUt+y8
         t6pzIh+1YzRHZ+Czf8pNdUXPnJ0F5RDX1gnU4Q/1vhyMf71fTMuKwDUJ9juQ/jVrmq83
         ZoyL24TWCzryj5YX4bVQTVSWUsBf5HS4aXnOssDaoVgXKrE2x7TVka4uUHNN5Sad2VXV
         HWfTgAMF+PxeKuqn0pSqMb94+4TgCGNr2zNpgOeffcQ3QvmMirEdvXBjOdxp3Ve9D/dG
         upnnmyThlgZqwTAGmH5FRDtajDCC+4+ZmFqjnRZbqCmB7ZOZuSwWpqH9H+vzffpFHiqd
         2r9g==
X-Forwarded-Encrypted: i=1; AJvYcCUG1kjwVfBjfLEvHxOpKtVOy/6Z4rSfQ996JcHINc0M8llh+OKhiHoWCZi6ijUjArNKkoZXZ0UwLh59PmpBv5FttOH6VLWb
X-Gm-Message-State: AOJu0YwdeRwTByE2VY0X9AVaAuT4smlr7jjlWqhebaI7YDNdBgDoOBD0
	4ZBllBysXf0xhv2SaV1+4g3tRvr/xPITD4sY1DMZt+U7p7FAKdbxh5vf9ileGIITGMH3Fvt7ieh
	kQiY4IlZXaC3PVu5MmBJR2YOqCcErynDvplg3PQ==
X-Google-Smtp-Source: AGHT+IFK1vPadWMCRRGMINnXSF7M/bNV+Fi2LkdhgFy33X86BsH0xVeVtU0MOvER0+70M2Fn7FrxIaFHaLQVd/PZlHU=
X-Received: by 2002:a05:651c:88a:b0:2ee:6cda:637b with SMTP id
 38308e7fff4ca-2ee6cda6515mr8715861fa.35.1719820144133; Mon, 01 Jul 2024
 00:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701014720.2547856-1-quic_yijiyang@quicinc.com>
In-Reply-To: <20240701014720.2547856-1-quic_yijiyang@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 1 Jul 2024 09:48:53 +0200
Message-ID: <CAMRc=MdU6wPR722q=Ev0NCz=icHvbb4JAuiF+PjDFNLDoWTbKw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-qcom-ethqos: fix error array size
To: YijieYang <quic_yijiyang@quicinc.com>
Cc: vkoul@kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bartosz.golaszewski@linaro.org, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com, quic_tengfan@quicinc.com, quic_aiquny@quicinc.com, 
	quic_jiegan@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:48=E2=80=AFAM YijieYang <quic_yijiyang@quicinc.com=
> wrote:
>
> From: Yijie Yang <quic_yijiyang@quicinc.com>
>
> Correct member @num_por with size of right array @emac_v4_0_0_por for
> struct ethqos_emac_driver_data @emac_v4_0_0_data.
>
> Cc: stable@vger.kernel.org
> Fixes: 8c4d92e82d50 ("net: stmmac: dwmac-qcom-ethqos: add support for ema=
c4 on sa8775p platforms")
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 80eb72bc6311..e8a1701cdb7c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -272,7 +272,7 @@ static const struct ethqos_emac_por emac_v4_0_0_por[]=
 =3D {
>
>  static const struct ethqos_emac_driver_data emac_v4_0_0_data =3D {
>         .por =3D emac_v4_0_0_por,
> -       .num_por =3D ARRAY_SIZE(emac_v3_0_0_por),
> +       .num_por =3D ARRAY_SIZE(emac_v4_0_0_por),
>         .rgmii_config_loopback_en =3D false,
>         .has_emac_ge_3 =3D true,
>         .link_clk_name =3D "phyaux",
>
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> --
> 2.34.1
>
>

Oops, that's on me. Thanks for catching it.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

