Return-Path: <netdev+bounces-136917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385D89A39D7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CBB25119
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D652192B86;
	Fri, 18 Oct 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ1wqO58"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4E19046E;
	Fri, 18 Oct 2024 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243305; cv=none; b=IOpEN9L0eRLIfhJnr7HVTVAnZHIBlyBgJwY1uCWKMyvCIWAdk8p6TdSXzXAX2AK+wi+dJYyZ2r79cBgFAzqfzHE3KkNVGxCNfDJz8DzSdO/i+601nx+ydxDjTyPRXDc4bZQ/4yiR/QgoFFChg/gMTAt9QVws+PcMNkIi4c3H1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243305; c=relaxed/simple;
	bh=oqejlX2WW4YcQ9+FE0HH5JA3mxnvCw/QbzHhcG+3pA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBX2XA4UwImLURuMzI4tNlGgblCCojlc/OHNsE6r+4fY17ebCnVa7Mzbz/I08hKfvM+Yv4mUhdjIVvxWix79hiPyFRLQARj/IZMx+azcF48cwRS6ft1kNuP17R5zkulR1d2HTeNEFY6LAJOY06vuMzzMTCqCyMgdr7j3TCmMZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ1wqO58; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a273e421fso30615766b.0;
        Fri, 18 Oct 2024 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729243302; x=1729848102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlTM9V5DRsPe4eqW9RQavt8mzladFi9MCIQh4OOLQfA=;
        b=EJ1wqO58bVIOGKDq34sujgyLPcXhjX4FNKeAm20LOTim4R/hcLeZ7HlqpeSvpoSxvI
         VuQqK5tLWtVQ0t9gLEWIJsIRz0lgUCkIi+mKFUKUke+bmtKA/fGHV60BLJLG8wIIT18D
         AMl5TlV+cgvxaHqfxVZoabrU4PCUd4aDG/QY/DVFcjmxtfArqN2YurS90BOgPYo9XjeA
         ZW7Q8taHiSrkyrzRFOxtL+nHgni3acHy9X85hPmDFr48f/yss8xY5LZqmolqh86CYr9T
         uPKt+GRnJOXIRR9ahlF5oWiVaOBRL7DekDL0dC8DyUyOUzKFOl+OoMOk3A46kqaG4oSc
         6AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729243302; x=1729848102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlTM9V5DRsPe4eqW9RQavt8mzladFi9MCIQh4OOLQfA=;
        b=r4i4itK+MBPHnHzYWqsEx1+VcQaWO3XlrOeQ+vLMWYpk2xqq3narH/stLiXLCPNrTr
         8e/jR2UrJYBX+FKK/kXClV4iGb1Fa+fhjy2MAtomxqkmbUGnndlpnnT2rWyn24SYEZTK
         71FB2reZzNQyJ9hAymKojk5lk+h069Bnf5LaJdR+jnZ4Cjpd57y8KH9SUu5LFe1zRkJk
         HCIkOk3/7tE3ZBIqvTzG8i78rOyJpAjfRw6q3RRUuTFuD4kQB6hY6eNIyPWi3zj63YS5
         V/kr9NdNBUBx/Q5GF6LkpTuVRd1yncljvhDKmZqmlMAfyuIatX88QnOPQoqa6T0r/Lfw
         GPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvGUleHvZTz8nPJGk49sLjKHF5VP2xJzVHdFXOFqvnNww2gerSdtKdu+VmnIMh3iu9OFR76jgCkXDQsBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPMRX60VaVwz+MkcBRFnzf8XgKkF/5vc0tRxVgkeVO4/OZG+q
	UadHNKfFkkMkCr30RW8SFMOycb3vYElBfR55CR8uhpprGoGiGtqZR5RKJw==
X-Google-Smtp-Source: AGHT+IFDFLCQA1phkwKSMbXUM2S3mB35TEAVZuUbCEytPdAHoYv1Sm/TfjB25QyeBIZIHMBL+yOy2g==
X-Received: by 2002:a17:907:3d8e:b0:a9a:2523:b4fa with SMTP id a640c23a62f3a-a9a69a76177mr64789866b.4.1729243301360;
        Fri, 18 Oct 2024 02:21:41 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf7227sm67420166b.181.2024.10.18.02.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:21:40 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:21:38 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v2 1/8] net: stmmac: Introduce separate files
 for FPE implementation
Message-ID: <20241018092138.xo2zoadx2jng27rp@skbuf>
References: <cover.1729233020.git.0x1207@gmail.com>
 <a5c4bc8682a6ff108d4721e46f08dc0ac799ffcd.1729233020.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c4bc8682a6ff108d4721e46f08dc0ac799ffcd.1729233020.git.0x1207@gmail.com>

On Fri, Oct 18, 2024 at 02:39:07PM +0800, Furong Xu wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> new file mode 100644
> index 000000000000..d4d46a07d6a7
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Furong Xu <0x1207@gmail.com>
> + * stmmac FPE(802.3 Qbu) handling
> + */
> +#include "stmmac.h"
> +
> +#define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
> +#define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
> +
> +#define MAC_FPE_CTRL_STS		0x00000234
> +#define TRSP				BIT(19)
> +#define TVER				BIT(18)
> +#define RRSP				BIT(17)
> +#define RVER				BIT(16)
> +#define SRSP				BIT(2)
> +#define SVER				BIT(1)
> +#define EFPE				BIT(0)
> +
> +#define MTL_FPE_CTRL_STS		0x00000c90
> +/* Preemption Classification */
> +#define DWMAC5_PREEMPTION_CLASS		GENMASK(15, 8)
> +/* Additional Fragment Size of preempted frames */
> +#define DWMAC5_ADD_FRAG_SZ		GENMASK(1, 0)
> +
> +#define XGMAC_FPE_CTRL_STS		0x00000280
> +#define XGMAC_EFPE			BIT(0)
> +
> +/* FPE link-partner hand-shaking mPacket type */
> +enum stmmac_mpacket_type {
> +	MPACKET_VERIFY = 0,
> +	MPACKET_RESPONSE = 1,
> +};
> +
> +void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
> +void stmmac_fpe_event_status(struct stmmac_priv *priv, int status);
> +void stmmac_fpe_init(struct stmmac_priv *priv);
> +void stmmac_fpe_apply(struct stmmac_priv *priv);
> +
> +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			  u32 num_txq, u32 num_rxq,
> +			  bool tx_enable, bool pmac_enable);
> +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> +			     struct stmmac_fpe_cfg *cfg,
> +			     enum stmmac_mpacket_type type);
> +int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
> +int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr);
> +void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
> +int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
> +				    struct netlink_ext_ack *extack, u32 pclass);
> +
> +void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			    u32 num_txq, u32 num_rxq,
> +			    bool tx_enable, bool pmac_enable);

2 comments about this header:

- it would be good if it contained a "#pragma once" equivalent, in case
  other headers include it (#ifndef STMMAC_FPE_H #define STMMAC_FPE_H).

- it is good practice to only keep inside the header those definitions
  which are truly exported by stmmac_fpe.c towards external callers.
  That means that the #defines which are only used within stmmac_fpe.c
  shouldn't be here, but inside that C file.

- You could remove the dependency upon the giant #include "stmmac.h" and
  just provide those definitions necessary for this header to be
  self-consistent. By self-consistent I mean that a dummy C file
  containing just #include "stmmac_fpe.h" should compile without errors.

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 7e46dca90628..3fe0a555aa9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o dummy.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dummy.c b/drivers/net/ethernet/stmicro/stmmac/dummy.c
new file mode 100644
index 000000000000..fc976afd5e40
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dummy.c
@@ -0,0 +1 @@
+#include "stmmac_fpe.h"

The current stmmac_fpe.h as you've posted it does pass the dummy test,
but I think it can be further minimized. Having headers larger than they
need to be will increase build time, little by little.

Well, those were 3 comments :(

