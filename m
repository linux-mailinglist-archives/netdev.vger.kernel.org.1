Return-Path: <netdev+bounces-214943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C090B2C3AF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76572A03CAF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676CE305079;
	Tue, 19 Aug 2025 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o25mDOzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B58305054
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606451; cv=none; b=omrPuIMdDcbVg2pHuf/qGY2GT7t0eKkQ1H3HbHr1atQFHcheIMIqXGnh9cZUX4Tn4g2MjF+uzsPTBfRj7IKsCKJYHZnn0TeHwkeE0SxgPM3Bt6taoU9M4zFwkRnTKd3ISJfMsQtMmGXbDswKhyh9q+AbiYKeN2Ev8IHLHM87/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606451; c=relaxed/simple;
	bh=xuYBBZzfDca0J3l2miq9yY+5yDozxsqAldex1SkJygY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBE7s/uU9sp64oe4eQJhl/s//RF7PBi0atfbsevt8V08pUOSiQLSf+xBU2G2NdLyH+T+PiJyyS4MJrY0KE4w2zhu0HPZZoywqylLjZCeO1uYOLk2XW9EyWbxzT98LRU7NrmgOjliLiiqQlgSchuBRZ/0h0jCG3PPIy9LlidH4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o25mDOzI; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e931c858dbbso4149920276.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606448; x=1756211248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/SwjOQHeCvMS2KICUc0pDV0Be0a1R8dCwpqQxZT7wU=;
        b=o25mDOzIzo7dJtwVzTaTnpK4dbQKPD5eSOSqVnZK9cU/E+ktWj0cZ9vEPSSSDOspsK
         cXO8aszQ7aSwiIKWn06WkKyz/qR8zYAuhVpb3oUyWylqe35wgPsgqWtPoJc9lZIwMvte
         UANHOGr5Hz49pAB9ktSqmYNVNYg0KXUPomOwS+6giw95M2Q8480QnEbghU0F/U36iQuR
         2AnJYXZIbe6wA5fvjVRs6O0HaGiGS1/jb2cSHE4K7tY2ccpGlftyyIkEWRt5ahbymRCu
         U+lyj0GiUD3Wvu/FKohKCjRc4PAvuWE7sr2Mc+jd+7bKNQTDil3ZrFwNWRNwj0xABb2a
         wgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606448; x=1756211248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/SwjOQHeCvMS2KICUc0pDV0Be0a1R8dCwpqQxZT7wU=;
        b=gbYmhhhQV03ywWUi0gO1xj7N4mK4ZvpqbxdTGFPhjH+CD6rEWX8kqwNvD68KAf381e
         yexST5NXNm7g3Pm8xTBZn0P2mo1LbN2ptZtRw8IOvVHRvm2vWYh4BFS2SBTC9vcrCCNf
         wWSF4mX1KZ0Xe9Er+CgbLjVuUqctwsUxKZwzDWjdCvnxtre45JZEF99hrSWvNVdtFufx
         raRNwDyicEtRNwoXpIjfLncn0vHOgiFH9yUhtoD1xnCIvNA86o9gvcpPavIwAnLwiSHg
         TzqMCWZieAGqunQy91bMLIh0ZF2pY/td7GPnBZjd97i6KXWYzxHvJSbIWr9d2Rovz2hS
         JjAg==
X-Forwarded-Encrypted: i=1; AJvYcCWgDiKY1Wh8FXw31MhWuJoDbcZ/T/ZofgADYtVzRXuSA30+Qo/tawAibG2cWTam9y5VhK3k/3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNWYD2sVm1OosQiOKdXZbZW8cqz9Qk/+mYznaRjD1ObzNlgAt
	RJkT+0wOXItns/oXCmPgNV9LCj07OcNw7AgwoqPmVv7OdyMGwSQ0RlQNJyP/z7x+kmGMIpFLHoz
	YY7IU7PflgODYoYZ9qj1s3fCDoR/N5MF5ktFnkLq2uw==
X-Gm-Gg: ASbGncujoMGRvy4xo/B2tE+9yTBsZHUWqoAP4+DbneF0pUjWpEhC4S8qBpOW7ep2K1k
	CxcHygN2EHUZNB8ByEgyXyIVSU0OgAhsW9ZnOmtSba239EG72XoiI+nJcDyFA9rUAcDdGtEcMgB
	zlO1miUVVovIGLmWVIMy8SxBZScxBay19npMTNOlUzi7lM7gLVNDYpVuO50geT2dai15DVs6ito
	wGTtt4=
X-Google-Smtp-Source: AGHT+IFkoI+r6cV6WNVq6uXPHBA2uVZLDrE8//ETpYalVmXIBJdJpOfeazQCrWmKXo2jK9mqh7ttDODS+RAFkKAtLFY=
X-Received: by 2002:a05:690c:7444:b0:71a:183e:bfe6 with SMTP id
 00721157ae682-71f9d67abbbmr26169127b3.31.1755606448402; Tue, 19 Aug 2025
 05:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806114119.1948624-1-joy.zou@nxp.com>
In-Reply-To: <20250806114119.1948624-1-joy.zou@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 19 Aug 2025 14:26:52 +0200
X-Gm-Features: Ac12FXxegWexeGHmDDmyzbg8yYMj_7Nw43OEeLJf9G4Q8J0jYIS4GpVCHqgHvw0
Message-ID: <CAPDyKFrTu6T7VtogZdh=VnZonh81d9xRGBOHuNv5nECSBkL0SQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] Add i.MX91 platform support
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	frieder.schrempf@kontron.de, primoz.fiser@norik.com, othacehe@gnu.org, 
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
	netdev@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 13:42, Joy Zou <joy.zou@nxp.com> wrote:
>
> The design of i.MX91 platform is very similar to i.MX93.
> Extracts the common parts in order to reuse code.
>
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core.
> - i.MX91 has different pinmux.
>
> ---
> Changes for v8:
> - add Reviewed-by tag for patch #2/3/4/5/6/7/8/9/11.
> - modify commit message for patch #10.
> - move imx91 before imx93 in Makefile for patch #6.
> - modify the commit message to keep wrap at 75 chars for patch #5.
> - Link to v7: https://lore.kernel.org/imx/20250728071438.2332382-1-joy.zou@nxp.com/
>
> Changes for v7:
> - Optimize i.MX91 num_clks hardcode with ARRAY_SIZE()for patch #10.
> - Add new patch in order to optimize i.MX93 num_clks hardcode
>   with ARRAY_SIZE() for patch #9.
> - remove this unused comments for patch #6.
> - align all pinctrl value to the same column for patch #6.
> - add aliases because remove aliases from common dtsi for patch #6.
> - remove fec property eee-broken-1000t from imx91 and imx93 board dts
>   for patch #6 and #7.
> - The aliases are removed from common.dtsi because the imx93.dtsi
>   aliases are removed for patch #4.
> - Add new patch that move aliases from imx93.dtsi to board dts for
>   patch #3.
> - These aliases aren't common, so need to drop in imx93.dtsi for patch #3.
> - Only add aliases using to imx93 board dts for patch #3.
> - patch #3 changes come from review comments:
>   https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
> - add clocks constraints in the if-else branch for patch #2.
> - reorder the imx93 and imx91 if-else branch for patch #2.
> - patch #2 changes come from review comments:
>   https://lore.kernel.org/imx/urgfsmkl25woqy5emucfkqs52qu624po6rd532hpusg3fdnyg3@s5iwmhnfsi26/
> - add Reviewed-by tag for patch #2.
> - Link to v6: https://lore.kernel.org/imx/20250623095732.2139853-1-joy.zou@nxp.com/
>
> Changes for v6:
> - add changelog in per patch.
> - correct commit message spell for patch #1.
> - merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
>   specific part from imx91_93_common.dtsi to imx93.dtsi for patch #3.
> - modify the commit message for patch #3.
> - restore copyright time and add modification time for common dtsi for
>   patch #3.
> - remove unused map0 label in imx91_93_common.dtsi for patch #3.
> - remove tmu related node for patch #4.
> - remove unused regulators and pinctrl settings for patch #5.
> - add new modification for aliases change patch #6.
> - Link to v5: https://lore.kernel.org/imx/20250613100255.2131800-1-joy.zou@nxp.com/
>
> Changes for v5:
> - rename imx93.dtsi to imx91_93_common.dtsi.
> - move imx93 specific part from imx91_93_common.dtsi to imx93.dtsi.
> - modify the imx91.dtsi to use imx91_93_common.dtsi.
> - add new the imx93-blk-ctrl binding and driver patch for imx91 support.
> - add new net patch for imx91 support.
> - change node name codec and lsm6dsm into common name audio-codec and
>   inertial-meter, and add BT compatible string for imx91 board dts.
> - Link to v4: https://lore.kernel.org/imx/20250121074017.2819285-1-joy.zou@nxp.com/
>
> Changes for v4:
> - Add one imx93 patch that add labels in imx93.dtsi
> - modify the references in imx91.dtsi
> - modify the code alignment
> - remove unused newline
> - delete the status property
> - align pad hex values
> - Link to v3: https://lore.kernel.org/imx/20241120094945.3032663-1-pengfei.li_1@nxp.com/
>
> Changes for v3:
> - Add Conor's ack on patch #1
> - format imx91-11x11-evk.dts with the dt-format tool
> - add lpi2c1 node
> - Link to v2: https://lore.kernel.org/imx/20241118051541.2621360-1-pengfei.li_1@nxp.com/
>
> Changes for v2:
> - change ddr node pmu compatible
> - remove mu1 and mu2
> - change iomux node compatible and enable 91 pinctrl
> - refine commit message for patch #2
> - change hex to lowercase in pinfunc.h
> - ordering nodes with the dt-format tool
> - Link to v1: https://lore.kernel.org/imx/20241108022703.1877171-1-pengfei.li_1@nxp.com/
>
> Joy Zou (10):
>   dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
>   arm64: dts: freescale: move aliases from imx93.dtsi to board dts
>   arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and
>     modify them
>   arm64: dts: imx91: add i.MX91 dtsi support
>   arm64: dts: freescale: add i.MX91 11x11 EVK basic support
>   arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
>   arm64: defconfig: enable i.MX91 pinctrl
>   pmdomain: imx93-blk-ctrl: use ARRAY_SIZE() instead of hardcode number
>   pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on
>     i.MX91
>   net: stmmac: imx: add i.MX91 support
>
> Pengfei Li (1):
>   dt-bindings: arm: fsl: add i.MX91 11x11 evk board
>
>  .../devicetree/bindings/arm/fsl.yaml          |    6 +
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |   59 +-
>  arch/arm64/boot/dts/freescale/Makefile        |    1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    |  674 ++++++++
>  arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
>  arch/arm64/boot/dts/freescale/imx91.dtsi      |   71 +
>  .../{imx93.dtsi => imx91_93_common.dtsi}      |  176 +-
>  .../boot/dts/freescale/imx93-11x11-evk.dts    |   20 +-
>  .../boot/dts/freescale/imx93-14x14-evk.dts    |   15 +
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      |   18 +
>  .../dts/freescale/imx93-kontron-bl-osm-s.dts  |   21 +
>  .../dts/freescale/imx93-phyboard-nash.dts     |   21 +
>  .../dts/freescale/imx93-phyboard-segin.dts    |    9 +
>  .../freescale/imx93-tqma9352-mba91xxca.dts    |   11 +
>  .../freescale/imx93-tqma9352-mba93xxca.dts    |   25 +
>  .../freescale/imx93-tqma9352-mba93xxla.dts    |   25 +
>  .../dts/freescale/imx93-var-som-symphony.dts  |   17 +
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 1512 ++---------------
>  arch/arm64/configs/defconfig                  |    1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
>  drivers/pmdomain/imx/imx93-blk-ctrl.c         |   23 +-
>  21 files changed, 1938 insertions(+), 1539 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
>  copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (90%)
>  rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)
>

Patch2, 9 and 10 applied for next on my pmdomain tree, thanks!

Note, patch2 (dt change) is also available on my immutable dt branch,
for SoC maintainers to pull-in.

Kind regards
Uffe

