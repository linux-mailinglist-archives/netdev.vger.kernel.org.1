Return-Path: <netdev+bounces-193516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE940AC4496
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA8E7A470B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B3214814;
	Mon, 26 May 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbV8TnNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC98460;
	Mon, 26 May 2025 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293213; cv=none; b=HcxIWgmOiyvvb6SBRFJGFNHSh2LCsAGMhvjTkYqvFKo74Q1AfzdvphAa6opwMDQcpa9TMVnWfwXGYBqQDIayhw1cRNfPdiI8B7urJ4Loqx50Z8/EgbDeFtpWRjEgFLg19ZegzZHmoxUWQ+VEPZEb3ts/Z7BBlX1nANDsaLu5H9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293213; c=relaxed/simple;
	bh=QnOzZJosDZwQmHUjH11bMfDX1vpKijtZ/w27pwfOkAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssEKX2iVXeSVqT126ceeEyGmOgwPCmoFvVGcnSdCR2TS3dt3Ght9nRL2rR8hH5apLE8KX/G+JEDZvDTpL7PJqMlP8sRMBcFMCckSNkrF/LKM0O4bb+QW9x0guFQEpaECaiUkBLhEkFlyqkZptjX0+Aj+pf6j0GVdhmnwM1w2cZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbV8TnNy; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87e075fe92fso260274241.3;
        Mon, 26 May 2025 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748293211; x=1748898011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/VsZ6IE0jdOkCcZ5aD8yrns3Cyc4PjTDiK26k40UxU=;
        b=dbV8TnNyh+ifewX1fPtmAEE9Lr4Xf4Gm2PUoi4irBf+m14JsAf1N8sl0dVvMkoEx5a
         Obyo2+ExY6Zrx7QfMynq+c2F5h22xnvYbSDcxlP3in3mSlhRf6w0ZDwYSOE3rXqhC0D0
         t/oLXSqbIr3q6wjPYhaJUeZzzOoO6GXlz28zlK169ID5O+BJ15/8gvfGba+AEJjY93kU
         yjLvhEjEm4UVL8ho3I3NSStNRGQGZeuSXH+f+N5ysRXNSOUoGoztMdvUfyp6Kr6F11fK
         xUEmdJNU25U7Rxu5eT7ZSZ7CEp/tKFdxdTjQcGKwknh748zGEH2y/aNQ0r2p/cGdn/S8
         RhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748293211; x=1748898011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/VsZ6IE0jdOkCcZ5aD8yrns3Cyc4PjTDiK26k40UxU=;
        b=hj6TiNnOZ0O4eS/LvJtAH28gHp35Rq45ZfM2riG3/FYOWbjUEtidx4WQn/2QJcmQfn
         aItR066/scZDx9ZGjERPq9RaE2W/GZBbR7ly99im6ceWjLZ/c1wecpp2k3Ais2LSTtwg
         nyRktGuorR+5LMSkXnh6BMo+rT35xVoW+G4eblSJxdZ5uyfvDVMnucHv/TosXlExY9nC
         YUG1Rn2U6LEISG1HKERJgKXapg2QM87vI1CvKKZlJehnvgkCL0Gbd8SpwAI4Gh1I90mL
         0ToXRJDBLNd8QaI0TDdUa9/CupuHpBfEWYpkWTFZA+bgI9JKwHip6sbovhAptdFnDclu
         vYWg==
X-Forwarded-Encrypted: i=1; AJvYcCVqvoGKvFVigF5tblRBMDY0oF5l4fd+PyXUM/TcOq3V+cihcP7cmUQFjKybagq3IXAYcdiCjTOLXAdD06A=@vger.kernel.org, AJvYcCXVsdSC8nbNjWoufJfbHTso098UbxivHz7d0NLDBMbVC7PkoUi70QNJCkx9ErEPmyFC5VkpH1Y2@vger.kernel.org
X-Gm-Message-State: AOJu0YyRY2pDRWB/F3U8QAijUDtGMNRC1VicjTXvEygRj3vw8ImWSX9b
	7t3Eii4wgmAQQWsRyckcyY80h2/1FWCNvMhFwUXVCe8TMWR2UaXzeXsbRP6zVnU55z6f/meFaU+
	iT2uvdubtKyLnrdqtN2dvnEk7KwTKc3w=
X-Gm-Gg: ASbGncuBUAoPRU17banJksKoG57YriZnN+r8n5Oh9H+Kd3EIdAdK8JUjdpXU0YDkzry
	Tf03Upstcc3CzTIXAYddg1zmJkSqtbA/bzbpds4nu4R2/rF0YUapOmu1RUw7WVzDBOxqLhdwNeL
	bDBGMi7QYHnH1fxAxKWHMUXDqueDrHn+vaWQ==
X-Google-Smtp-Source: AGHT+IH1F819UdbqKdjXVnrU+7ibb4kb7PWACyBEmwPcni1wlQBFRsB0+/IWFIf8hbs072AoO3ylAlqbgpDxsk8Lh1Y=
X-Received: by 2002:a05:6122:82a5:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-52f2c5bf4admr7622487e0c.10.1748293211020; Mon, 26 May 2025
 14:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526002924.2567843-1-james.hilliard1@gmail.com>
 <20250526002924.2567843-2-james.hilliard1@gmail.com> <aDQgmJMIkkQ922Bd@shell.armlinux.org.uk>
 <4a2c60a2-03a7-43b8-9f40-ea2b0a3c4154@lunn.ch> <CADvTj4qvu+FCP1AzMx6xFsFXVuo=6s0UBCLSt7_ok3War09BNA@mail.gmail.com>
 <a2538232-be98-42ed-ae82-45e2fcff3368@lunn.ch>
In-Reply-To: <a2538232-be98-42ed-ae82-45e2fcff3368@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 May 2025 14:59:59 -0600
X-Gm-Features: AX0GCFtdyKxOISq6OJd3jmhemPTpifVHzFplXIgoyjcfXkmvrrAzTnbwIsfNJc4
Message-ID: <CADvTj4pCo=d8ehkz6JoPNYEGtUWsgmGCqT7vFEyHTtD7yF5ZAA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Feiyang Chen <chenfeiyang@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'm currently doing most of the PHY initialization in u-boot to simplif=
y testing
> > of the efuse based PHY selection logic in the kernel. I'm sending this
> > separately as a number of subsequent drivers for kernel side PHY
> > initialization will be dependent upon specific PHY's being discovered a=
t
> > runtime via the ac300 efuse bit.
>
> Do the different PHYs have different ID values in register 2 and 3?

Well...for the primary phy address in the device tree, no:
AC300(does not appear to support address 1 unlike AC200):
PHY at address 0:
0 - 0x3100
1 - 0x79ed
2 - 0x44
3 - 0x1400

AC300 address used for PHY initialization sequence on address 16(0x10),
appears to be used as replacement for i2c init sequence on AC200:
PHY at address 10:
0 - 0x1f80
1 - 0x1084
2 - 0xc000
3 - 0x0

AC200:
PHY at address 0:
0 - 0x3000
1 - 0x79ed
2 - 0x44
3 - 0x1400

AC200:
PHY at address 1:
0 - 0x3000
1 - 0x79ed
2 - 0x44
3 - 0x1400

AC200 appears to support either address 0 or address 1.

>
>         Andrew
>

