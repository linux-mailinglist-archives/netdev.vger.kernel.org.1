Return-Path: <netdev+bounces-231102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CBABF5095
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0696D18C63D0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE4284671;
	Tue, 21 Oct 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuhjVe7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64128284672
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032626; cv=none; b=tOIueWkYuRcUsHAR/aBp5chlgfdMCZdnyewgM0PiXMZz6PKDNGj6Eds0rlToBsk54moaEi6tvNECzCtsyMl2lL0p7xGoCQU75Gq08BOV5criJUfYzvKAn77rWpS0xJ922NUmSs315C4M4Pyd12yv9kY5J1caNmPsztyzrDq9GJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032626; c=relaxed/simple;
	bh=L3OSHu/zykUUrMf0jhQiVo+5X5Tp4yjmsTRArUNbg40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TETHzLPueOQp4s+JhuRllSsP+H16TaTDNTiEbUxR1Lm42I23Stur4/VQN2qsXEenD+Qr4Y5H4iwBySmUo3rUTfdC56gMmkiQFtsFAy+RefEnXicH8NjVQ44fxPP5G6ckU/oj7sWq/jWT7BpZUlal8h3x2EFrLqe3WUwTbKRYQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuhjVe7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C683C2BC86
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761032626;
	bh=L3OSHu/zykUUrMf0jhQiVo+5X5Tp4yjmsTRArUNbg40=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nuhjVe7dewQwiCcKzJosmLlrhCng/YZTQCU888Cw1JRGstMFQKq1pbud2Z8PIRkc9
	 EL4ZiMTVQYItN2lOof0KUvZZ31mV8AJaD79wJAm7T6tlf1UMsiLQwhyZxD2MlFEqre
	 /KQUWp71efacnNSB5bOVbi12pFYCcECOH9GuOJNF8C0PtAG9fZ6VWIuHGxpF2DaPzU
	 poxS+KXXVMrc9lfatxufE8h9v1S3j+YDO2kfnWMICIVyKeCAjglWR2P9p6ow2sler5
	 tOxZrlqn5eUjnCQ2qu06YvN39P83knb1R4AqEVKTZIxh0e7QWamVASXkckmlrRCqZo
	 BFfWu0KvZIh1A==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36639c30bb7so47099071fa.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:43:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9TfaTIhZhozCuvYCznBo/upDF5L3Z/yJ/J6LFSp4xmFqSHnifULPGJT3rcaKOMrIn2e3a81w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKZs/0vTxOpncGh4PfG80AWeq8Tq8XHCBi6irqKrmPT50sbDB
	8MoY9YP8WYrYI8Ab57RDk/wy5096GXIRDm3lhcQIn8l9V/dQLVf+97ynXuKXdwSp79p0fx1m0v1
	Vr+SUWMBXRNJZ3+AoxebABi3NbeU14II=
X-Google-Smtp-Source: AGHT+IGdlueTEgM73EYjdJJ7MYdcpYR/rotWSKlN7mFY5uUlnnqxOjkAfgQUxRhc1E7On08N06u+r1J6has1Jnhp3yI=
X-Received: by 2002:a2e:9fcb:0:b0:375:ebfa:2986 with SMTP id
 38308e7fff4ca-37797a728f1mr44182921fa.34.1761032624223; Tue, 21 Oct 2025
 00:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 21 Oct 2025 15:43:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v67U1KUeEvQ8yhSHP5NY1-9hGuwuTwgKMWGJB2LZn5pwqw@mail.gmail.com>
X-Gm-Features: AS18NWBVywV_yRWAV-n1YGVmZIEA5XvU8OAR8wbCjrwgr8Xivfn8oNIG-rClQ6c
Message-ID: <CAGb2v67U1KUeEvQ8yhSHP5NY1-9hGuwuTwgKMWGJB2LZn5pwqw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: replace has_xxxx with core_type
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Petrous <jan.petrous@oss.nxp.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, s32@nxp.com, 
	Samuel Holland <samuel@sholland.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Vinod Koul <vkoul@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:27=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Replace the has_gmac, has_gmac4 and has_xgmac ints, of which only one
> can be set when matching a core to its driver backend, with an
> enumerated type carrying the DWMAC core type.
>
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> v2:
> - fix conflict with removal with STMMAC_FLAG_HAS_INTEGRATED_PCS removal
> - wrap 88 char line in stmmac_xmit()
> - add Maxime's tested-by
>
> I haven't added Maxime's r-b because the patch has changed subtly, but
> not in a way that invalidates testing. Given the minor changes and it's
> possibilities for further conflicts, can we get this in sooner please?
> Thanks.
>
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  5 ++
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  5 +-
>  .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   |  2 +-
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  2 +-
>  .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   |  2 +-
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  4 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   |  2 +-
>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c |  2 +-

For sunxi,

Acked-by: Chen-Yu Tsai <wens@kernel.org>

