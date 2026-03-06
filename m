Return-Path: <netdev+bounces-264631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOmFJXtBqmlQOAEAu9opvQ
	(envelope-from <netdev+bounces-264631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:52:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2D21AC46
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A75AF3025A41
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BAF36682E;
	Fri,  6 Mar 2026 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJUaAkiL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1F343D80;
	Fri,  6 Mar 2026 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765560; cv=none; b=bfPSLE+Hs4n4PWCN5rxkJ+NzLB+yBZzE800b6PCsl9CPFfFrI7p0hmRGvQ2J+q1XbxAwpJ47GHFonVRw7WDbaxAmhTgTCyF6TPkMTmgh/eW82dqEXUz4dVdp/cyNZ3Yf3TNlpNcasT0yQZxOhmpSE/hKcMupgGXyoUWJJZFzcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765560; c=relaxed/simple;
	bh=59Brc3xI7MFaiXfr+R/dXuomEGyJC2J+vM/pJ/BSte8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBrn9ipYGCJplF9Z4OhjE34eRcpQA40dttQbu05DJ7fu9wA9uyzUoVVDDHgP8Fv24XTv0AfFGt9aeWkDECc+hvN8za2WLhC0m9pcDR1VdiKtnYw3/49MwUCTEa60VhvbpJRjVd4yLwOK6X+RuDSjRT5jphtE/JAxoyQ7ycRLMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJUaAkiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99677C116C6;
	Fri,  6 Mar 2026 02:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772765560;
	bh=59Brc3xI7MFaiXfr+R/dXuomEGyJC2J+vM/pJ/BSte8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJUaAkiLxDd++c9sKrZnqEjNkKjdzz59SAy9wTUS1ke/qS9IR+iEnm9Z/8NB6RYYS
	 G4cBNUSwM/FjCfDVijoXBZeTdM6XI5OEt/qpfFy85VNsIy9YabGSW8YMCuVvrmQBvP
	 vh50wIestjE8G3UWXVt3B13MTpR5ZR+lk8NDl6u/HeetyPp1HbmueZyG101OrPjk6x
	 riwbXU+4Q+LcUWQq9YgabkBvYTwNF3AiDSPS6qR1+Nuclfz1G7gGt1TlnUNeEi4bWf
	 COpVWmyM6Wa0LRo2zZbmdhFIWpw7mUNtvPmGI+oGg83DDdnQ/O+37pYUXtM2RpFyqG
	 lf7jy2ZxDTxEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: inochiama@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	dlan@kernel.org,
	palmer@dabbelt.com,
	me@ziyao.cc,
	boon.khai.ng@altera.com,
	linux-riscv@lists.infradead.org,
	edumazet@google.com,
	joabreu@synopsys.com,
	pjw@kernel.org,
	weishangjuan@eswincomputing.com,
	andrew+netdev@lunn.ch,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	siyanteng@cqsoftware.com.cn,
	richardcochran@gmail.com,
	looong.bin@gmail.com,
	quentin.schulz@cherry.de,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	dlan@gentoo.org,
	alexandre.torgue@foss.st.com,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	aou@eecs.berkeley.edu,
	rmk+kernel@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	vladimir.oltean@nxp.com,
	mcoquelin.stm32@gmail.com,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	peppe.cavallaro@st.com,
	devicetree@vger.kernel.org,
	pabeni@redhat.com,
	linux-stm32@st-md-mailman.stormreply.com,
	wens@kernel.org,
	maxime.chevallier@bootlin.com
Subject: Re: [net-next,v7,3/3] net: stmmac: Add glue layer for Spacemit K3 SoC
Date: Thu,  5 Mar 2026 18:52:37 -0800
Message-ID: <20260306025237.580075-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304080721.1658224-4-inochiama@gmail.com>
References: <20260304080721.1658224-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12F2D21AC46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264631-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,dabbelt.com,ziyao.cc,altera.com,lists.infradead.org,google.com,synopsys.com,eswincomputing.com,lunn.ch,bp.renesas.com,cqsoftware.com.cn,gmail.com,cherry.de,ghiti.fr,gentoo.org,foss.st.com,vger.kernel.org,eecs.berkeley.edu,armlinux.org.uk,nxp.com,lists.linux.dev,st.com,redhat.com,st-md-mailman.stormreply.com,bootlin.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: Add glue layer for Spacemit K3 SoC

The ethernet controller on Spacemit K3 SoC is Synopsys DesignWare
MAC (version 5.40a), with the following special points:
1. The rate of the tx clock line is auto changed when the mac speed
   rate is changed, and no need for changing the input tx clock.
2. This controller require a extra syscon device to configure the
   interface type, enable wake up interrupt and delay configuration
   if needed.

Add Spacemit dwmac driver support on the Spacemit K3 SoC.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> new file mode 100644
> index 000000000000..22aa25a7417b
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Spacemit DWMAC platform driver
> + *
> + * Copyright (C) 2026 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#include "stmmac_platform.h"

[ ... ]

> +struct spacmit_dwmac {
> +	struct regmap *apmu;
> +	unsigned int ctrl_offset;
> +	unsigned int dline_offset;
> +};

This isn't a bug, but the struct name is 'spacmit_dwmac' (missing 'e'),
while the driver filename is 'dwmac-spacemit.c' and all function names use
'spacemit_*' (e.g., spacemit_dwmac_probe, spacemit_dwmac_set_delay). Should
the struct be named 'spacemit_dwmac' for consistency?

[ ... ]

> +static int spacemit_dwmac_fix_delay(struct spacmit_dwmac *dwmac,
> +				    struct plat_stmmacenet_data *plat_dat,
> +				    unsigned int tx_delay,
> +				    unsigned int rx_delay)
> +{
> +	int rx_code;
> +	int tx_code;
> +
> +	rx_code = spacemit_dwmac_detected_delay_value(rx_delay);
> +	if (rx_code < 0)
> +		return rx_code;
> +
> +	tx_code = spacemit_dwmac_detected_delay_value(tx_delay);
> +	if (tx_code < 0)
> +		return tx_code;
> +
> +	return spacemit_dwmac_set_delay(dwmac, tx_code, rx_code);
> +}

The 'plat_dat' parameter appears to be unused in spacemit_dwmac_fix_delay().
The function only uses 'dwmac', 'tx_delay', and 'rx_delay'. Is this
parameter needed?

[ ... ]

