Return-Path: <netdev+bounces-251814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF0xO1SacGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:20:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965154417
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9505D72AD2F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B830F546;
	Wed, 21 Jan 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2kxRLlX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344D3161B5
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986740; cv=none; b=e/0GfiVtf7guK9O0UHBM6z+ogSWND+Te617+sE3OxXPc8y4T9oK+e62YvsqOEX2KaNwX0XVSgX7E9F8a6+0ZSTeVgV4vII2QJ8XX2UUj5lakZh9HMbtXOFtZfHc9otyiuavj6Q6JS7tUsugeppXX0ZVohxaFLp1qKY9MYyuazEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986740; c=relaxed/simple;
	bh=ivdSRO/Sa+8y6SbfRo9OGAFBLBdiIOgB64qyEx+BEkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6IDAf6awq+T8QQB21EsKeJdRBN5BZFQr14L2RNGyO30nz7HpLv2OaJTMxw74pBxj/cHbOfpnwSFY+ClwgF1mfQ2hpo1F9m2IB1IpwXcZ/QoItYcIvS+I0Q2MkASfNajqqAWx16CVGx0YDH7vzZEx7AGe/SRpyeAvRY1CByYNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2kxRLlX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5386f1c9fso918901785a.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768986737; x=1769591537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fbq78sea0hmX5//P4GjhYjkpSX+LqZ+KYNl1xezZDJM=;
        b=F2kxRLlX1ZSwnQ/Iq4Qz9o4mAvQWrT0myKFGKy8F/u4EVYUg4JOcJ/2CNGJ2KJCdWS
         ON8wcG3TNVN6DrmyzPBHJzFD/Xp9IxhBYiruPhlo6norTsbbwANFKpNNubLBfaR1OuYQ
         kS4rNc+/gYTaY0dxmjc40boEWyjB/8AXEWGEoEHUax5IRyAKf/LlG0bf6154YldozkNw
         oHWCMHawrBG5HIay6e7wwQssKJDthFS56Y+PrXaGvgXrXXag1SlTvwN28Ee3NSwQo9Hj
         Y2o38ouGL9HOu7+LtGcCk6wX3W4tl9c3p6CNFDs3UW+6G6b5opcCq1qxuGSlhMzq6z8w
         fIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768986737; x=1769591537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbq78sea0hmX5//P4GjhYjkpSX+LqZ+KYNl1xezZDJM=;
        b=Tmk/wGYJC9ew6O8jW0lppTpiB87iZNaLGSXo69Hkggk4TkRfW9AVyIDWqzZ8Ne/IQP
         UzLoJgKMEGrPks/egxC/aq/BPdsZD2gKwonmE9fzjA0WmUg2fZkuLOT1y/k9waLSzHgY
         v22hCRchII3Z/Ne7VU0HWEZXG30VrjyJ+vWAMtm3+J1LLU4cw2HCiqh/MYw5uRQzUzPL
         txbuoDX8VrSIvtoOrv2JCTLS08yxJ6c9+e3GeaprhSqL3xZgnyV6GXQuntf+4mh95T/U
         98CP2CnRaWaxlKAJmDR/FnumnHZiI9l66jR37hkP9E3CKH+/09UfFlUk7csU77OoGCSi
         bacw==
X-Gm-Message-State: AOJu0Yz0RSIY6Y1L5uhRA9HRfK3BqbPFKPUetU/gOSOvBu26jKcqZF85
	GdXMEL/zQvvKvCT5E0F9bRmLM3XhQ2DftF4egK3ldzj2Nf4ukSmKdWLg
X-Gm-Gg: AZuq6aKFFKxRgNAsT1KZQWe9bCgAgje2JEaDseIIxhOcyCIkTFjllLakXvW0ReWubqp
	hGs1+9i7IkCLEObbPO67OAMV1GnEdpk1dGqSaoFFuO5IeQ5EiVzo03VUwijjJv2/opqotqo7bZE
	WYLSdJNIO7HSZ3I6hcU8WUMH5YI6mpvhgqZPLuwy2UQGjGdL4QfE36R6+l9xXolErYAAHlm6qRK
	H9EjW8LcQtuxymwhuazrrg8luKW+XvMjm5LYNk5PZUALWCnorVrDdwZleSWzOHutbbOjJays+NO
	YpB4K1uuQIHhcCZf3Q0Rszd0N0l0ZxCnYcBRK6uw7OcnBSNQ3BosSpxTzLTz8n7whH7xthov1nI
	bvyDBBw7FeUX4vLML72ep1NRnAZgQCxp1u7DFNLGAwRLjw48Pv8Z5VnQHQGv3MxtKZ2XM4mIRmr
	lwAlv5Wu7aBA==
X-Received: by 2002:a05:7022:6b86:b0:11b:923d:773f with SMTP id a92af1059eb24-1244b3081a4mr12334928c88.5.1768979609488;
        Tue, 20 Jan 2026 23:13:29 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm24056346c88.7.2026.01.20.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:13:29 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <ziyao@disroot.org>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v2 0/3] riscv: spacemit: Add ethernet support for K3
Date: Wed, 21 Jan 2026 15:13:08 +0800
Message-ID: <20260121071315.940130-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251814-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,disroot.org,cqsoftware.com.cn,nxp.com,bp.renesas.com,linux.intel.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7965154417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add initial support for ethernet controller of the Spacemit K3 SoC.
This ethernet controller is almost a standard Synopsys DesignWare
MAC (version 5.40a). This controller require a syscon device to
configure some basic features, like interface type and internal delay.

Change from v1:
- https://lore.kernel.org/netdev/20260120043609.910302-1-inochiama@gmail.com
patch 1:
1. remove phy clock
patch 3:
1. improve comment and include something special about Spacmit K3 dwmac
2. reorder the included file
3. fix wrong delay macro used in spacemit_dwmac_set_delay.
4. add check for maximum supported delay.
5. use DIV_ROUND_CLOSEST to calculate best delay configuration.
6. use assign for the ctrl register initial value.
7. fix input when calling of_property_read_u32().

Inochi Amaoto (3):
  dt-bindings: net: Add support for Spacemit K3 dwmac
  net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
  net: stmmac: Add glue layer for Spacemit K3 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
 .../bindings/net/spacemit,k3-dwmac.yaml       | 103 ++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 221 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   1 +
 6 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

--
2.52.0


