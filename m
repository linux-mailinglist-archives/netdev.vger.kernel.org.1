Return-Path: <netdev+bounces-111340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC976930A0B
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 15:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4621F2139E
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09DF6BB26;
	Sun, 14 Jul 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLrspywZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F71D559;
	Sun, 14 Jul 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720962933; cv=none; b=H5UVdEgCFmYpXM79GWyyDRWcSlO4p2Hb49j/h4L4Bso2D6XjTrrEvwdQQ704p5qBH5fsPzZ27sUqU9tcR1G38qnw39WMEVYmxNIYpyRiwPSE3bZs3UEl10FNtyhEZvi8+ffsLWpA/jGy+oadP2Atss8C5oUxOGqnjsKNNMy4cac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720962933; c=relaxed/simple;
	bh=dcOo8C1pQ+lOmjwN8FP8eDvQ933tkNrSB9sHuhfLNDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK7X3c2gLdeyeuqgNZNSX7cRnRgaMNm/6UsIqeSVRd8nbMNnU50BKYo4DkhA/PJjYsf52Z9kjj1C9Kc/+h6lW5bynWOEXZHtYQxxN+ZEpcIc7RRJ20EJbs5sYmlQD00QlHlqUhQqH6LdTqpcwNyxaOn9IGeyTOdo8p3q56IvN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLrspywZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso4204865e87.1;
        Sun, 14 Jul 2024 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720962930; x=1721567730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiCM4Oh0wwP2VREwcugnR/BGE8YEV2FgEAMfKAudQZU=;
        b=cLrspywZoNFITXRfUNokVUiW0rpbVIbrYYpg7k+F0FWPZhe6icj+KFhFi+0+kb6iUP
         BDRdO1CFhYT8wp2uttRDRvjUiTr4sMKpz5hwg/s1EBTjKWDBH+l6G5KecprKTUViBbnl
         UNyREx89lksFV2mqhM5nrCwckQFaCd0Uuj4NMnuBZA/zboYb07diYmv0GIPJuvWzMx9S
         RFGVBbtDsN4pRdI3RwC/eQmn5D0UATwIDgIfOXX0ljMvdb2poJC4bYWot+Yf95ic+UZ+
         iNDF0doxthir7pnEJDXvTHwHGk5VsKGNh+fz80+feLKaFIKXwSfLzfTQvf9ARmDrJN6r
         qizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720962930; x=1721567730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiCM4Oh0wwP2VREwcugnR/BGE8YEV2FgEAMfKAudQZU=;
        b=k60NNgYs+Z4P8/kE4isskXqMGQFuD8jJYd8GuOQqFRVBc/ODW34q5uPW/yUDUxf72l
         MlU/wmnuJPzikRQtlf1N/pHBarthGDEkhye8yRJyVYNQYB5oZIXbX8Xonw90FvXhRcWE
         jEaDP+xWr7WQtXQddnn6EBzEcvJbw8WVc4pKeO8Z5yj12DXZSH1ZGU055pPTb8wZmD26
         jGQYYL2Eoaw9ZrKPr68T4AD+PC2/GiME4WVUxNkY9+fXXCt1D/6sKR5rotrxDhmTHQ46
         XhhdWiJb9ZIZFZAN+wzje1w6ZGtAP9t3Pb47ZVO/fQJKyhEeJ86iHK7zNbDL+7lA58fE
         74KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyMl3V0XswoxufQCKB40+GMw8z/JrRkzr+FmZfY51/JQbFwQq6XYhd+PIXqzaiBTmbYkUDf+tj+M9jPOrIXEv9IuY+tayKdZpDaZvHLcjRNJ2ow2fRw+Um0wXXZDgqCKQJqiNCmtUE3pPS0iCjTU/baTU/Qyg+AzVwFRbJCvNsfA==
X-Gm-Message-State: AOJu0YzIMeDU2JXkF3bFInGq6//jC8psQ6j4q6ZgTof3Xlk6Np1b1Ebx
	O49Iuno6VkYvPyHL7fEqTX7bF3GqUJhCwJre5wSawX+ZGhQ2UWH5
X-Google-Smtp-Source: AGHT+IEwsZANI92FHt4sUnfLljzN4WZnd499R+at6I3cz5xxru5RwfBlwsIV4f5R+2ItBy99UrvDKg==
X-Received: by 2002:ac2:42d8:0:b0:52b:b327:9c1c with SMTP id 2adb3069b0e04-52eb99d59e8mr9045576e87.62.1720962927807;
        Sun, 14 Jul 2024 06:15:27 -0700 (PDT)
Received: from mobilestation (pppoe77-82-205-78.kamchatka.ru. [77.82.205.78])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24f38absm467456e87.79.2024.07.14.06.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 06:15:27 -0700 (PDT)
Date: Sun, 14 Jul 2024 16:15:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Drew Fustini <drew@pdp7.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC net-next 0/4] Add the dwmac driver support for T-HEAD
 TH1520 SoC.
Message-ID: <w3ex6eu3fhv4rmb67hm5ktwkehefw25gmemtqsjjfaa76z7v6t@vmfzungbincv>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>

Hi Drew

On Sat, Jul 13, 2024 at 03:35:09PM -0700, Drew Fustini wrote:
> I am marking this as an RFC since it has been almost a year since the
> previous series and Jisheng has handed it off to me. There was
> discussion about the syscon for the APB registers in Jisheng's v2. I've
> gone a different route and switched to adding a second memory region to
> the gmac node:
> 
>   dwmac: DesignWare GMAC IP core registers
>     apb: GMAC APB registers
> 
> This patch depends my clock controller series:
> 
>  [PATCH v3 0/7] clk: thead: Add support for TH1520 AP_SUBSYS clock controller
>  https://lore.kernel.org/linux-riscv/20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com/
> 
> and the pinctrl series from Emil:
> 
>  [PATCH v2 0/8] Add T-Head TH1520 SoC pin control
>  https://lore.kernel.org/linux-riscv/20240103132852.298964-1-emil.renner.berthing@canonical.com
> 
> I have a branch with this series and the dependencies on top of 6.10-rc7:
>  https://github.com/pdp7/linux/tree/b4/thead-dwmac
> 
> Changes since Jisheng v2:
>  - remove thead,gmacapb that references syscon for APB registers
>  - add a second memory region to gmac nodes for the APB registers
>  - Link: https://lore.kernel.org/all/20230827091710.1483-1-jszhang@kernel.org/

I see the vast majority of the v2 comments left ignored:
compatible-string, Tx/Rx common clock handle, clock delays, etc.
Please take a closer look at v2 discussions and make sure the notes
were implemented or send a reasonable response why it wasn't done.

-Serge(y)

> 
> Changes since Jisheng v1:
>  - rebase on the lastest net-next
>  - collect Reviewed-by tag
>  - address Krzysztof's comment of the dt binding
>  - fix "div is not initialised" issue pointed out by Simon
>  - Link: https://lore.kernel.org/all/20230820120213.2054-1-jszhang@kernel.org/
> 
> ---
> Emil Renner Berthing (1):
>       riscv: dts: thead: Add TH1520 ethernet nodes
> 
> Jisheng Zhang (3):
>       dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
>       dt-bindings: net: add T-HEAD dwmac support
>       net: stmmac: add glue layer for T-HEAD TH1520 SoC
> 
>  .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +
>  .../devicetree/bindings/net/thead,dwmac.yaml       |  81 ++++++
>  MAINTAINERS                                        |   2 +
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  89 ++++++
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 131 +++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi              |  55 +++-
>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 300 +++++++++++++++++++++
>  9 files changed, 670 insertions(+), 2 deletions(-)
> ---
> base-commit: 568c4e4b646777f3373f383cc38864a3cd91bbb7
> change-id: 20240712-thead-dwmac-1d44c472bbd5
> 
> Best regards,
> -- 
> Drew Fustini <dfustini@tenstorrent.com>
> 
> 

