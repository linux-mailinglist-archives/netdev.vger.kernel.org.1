Return-Path: <netdev+bounces-251352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F8D3BE78
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B15FF357A08
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF625352C3B;
	Tue, 20 Jan 2026 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv+En+us"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C13352C51
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883784; cv=none; b=Z65iAPduSgAB/gumvNnFEOJrFVgZSFG2ty1YlMD7qtrSbbz6T+MTZD0pbWsl8LKBTsCYLTpq7jA5XhpU6UTLR0r/aj8Ok/nFUJrl6y/CxN8yEjhVP4rl2yrTQkyC9I0tr/guYSks4rUXVRafybzs6r4RmM36NEo/srSB6Of1dgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883784; c=relaxed/simple;
	bh=Wlngs8GSpv8APxHaAYUjYkmr2dMA0BCajAs9V2BT8ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBjNui5FVSlHTjVHiljJtK9bxcPykozTm5//WzQVSpGK5NijZWExSevP18l/A92wDAR9xME/WrQdcQzSFJfagg692hiMtz2wKo1FeCsHvGtVXGARGThPBpBRwvSLJA2ZVXAfRvS2BHpgcKKNXPqG13U0O9VIZ2C1dgVqQ43xabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv+En+us; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b1981ca515so5361438eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768883782; x=1769488582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29OkNoazPkO3Cz/ca1GMRTcjG5fAIFuxe8NjRt6vIh0=;
        b=Sv+En+usckN0PdXCgss6w0dIE9S1izYcvxOPEajAvlYAkmF2+Elcdwc3o20WMi/Xe4
         fARMGt2UFAXdEgfIRNgM50oAdmzfmU1AgwKofiCvn+dTuLDVEkOhj0Mzv97ZifyjXYhT
         H1kF/rlcon5vD0TiDi+ngaBURg60CztGK2VGDzBYTiInv95BShtCdQ2x+N/gC2O4fLXm
         xkLMiQv3KizbAwvhHBQhUScsWDVSagTKUpKpqnP0SHQtZsyhcYPlPOm7agjE9v7fQ+NJ
         Jd18az63o77GPaGHhlDAIcwfjriXBvtIcQQi9+8uDaPbLaEFDRKvHgCcHqXg4MndHGyj
         A/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768883782; x=1769488582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29OkNoazPkO3Cz/ca1GMRTcjG5fAIFuxe8NjRt6vIh0=;
        b=GDFNYywBQKrlGyP2Bfc/YY1yV4tO3zNin9Oji3itDgjaCPOzE4qPnHJ3WF/ciF9W7O
         2FTo//oNHB0LIAupd5EDE/bwK6nzz4daJhoVrirdmZoOf3KyJ1E5l+plX8rv+ZFOySiy
         o6soR6AxiqKBm/POkaDOzCFmNXp62XCkeKX58pmmJvI6Mnv83ZNAZV4oBKBiCYBsWmhk
         1yJFyCvzh5uw8YZlQJwoLVdlpF0MjnAmKlb/8jEJSkAwVH8bqLzZNHFY3cqqbR18XZmH
         wpGjaS5Sufp+VzO1y+x1vLMi3zoUCBM0H/ic0CxzJcphJVN4+WbjihXMFW6TA+smcy2P
         l6OA==
X-Gm-Message-State: AOJu0Yx64FpRCWghSnkjG50ub9Tu2JAewVdfMaRpXVOKPtS9QaepzRcU
	n17tdRFTIf5QJA8fzTgSiX4+blpntk4+vaQKTcijFmFFCGcVUzcU4tQt
X-Gm-Gg: AZuq6aKi9bPkf+/inJ0AtY8ZHzy/Scdoyi/FkcaowLWs4r2EewhHVCXBnDYOiUx7GPG
	Iqk/wrkddwuS/RHjPRUYGx2up1YcA64ag97lpjlBHgB7LFw9shvLMzBuM+0U+BtyUNE5bifgvmy
	aHXklEL7w61JitaAtF9vZKzNYl+ljHOUtR9dpjzkIo61qtNHG8ILvlwIyF6pp6XKjGl7gHc5nbZ
	3Xw81R4hQQY2B7rZUcY5ZnMMZ/xbWoqJwayouDKTECkFUT5FrekPV0FJoF7K9D6I/QX3nY2m+bU
	UQiSgoPn8peJH1YqDhB8Vf4P+0Rjg2SBaPaTHqzHxjL8d7JNRX5pya+iT5g1b21DdxdwsyJG73d
	NfAbw8mTktglYvW+7jVy3+gRpLu7zjbOvcczXciGQRddK37IMoxdUjNctN1iowAwuNuDME1KPyJ
	vvY0EnSYkWmQ==
X-Received: by 2002:a05:7300:a188:b0:2b6:af85:dd29 with SMTP id 5a478bee46e88-2b6fd3a7b8fmr363879eec.0.1768883781926;
        Mon, 19 Jan 2026 20:36:21 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6fba43c3dsm1271369eec.0.2026.01.19.20.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 20:36:21 -0800 (PST)
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
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
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
Subject: [PATCH net-next 0/3] riscv: spacemit: Add ethernet support for K3
Date: Tue, 20 Jan 2026 12:36:05 +0800
Message-ID: <20260120043609.910302-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for ethernet controller of the Spacemit K3 SoC.
This ethernet controller is almost a standard Synopsys DesignWare
MAC (version 5.40a). This controller require a syscon device to
configure some basic features, like interface type and internal delay.

Inochi Amaoto (3):
  dt-bindings: net: Add support for Spacemit K3 dwmac
  net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
  net: stmmac: Add glue layer for Spacemit K3 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
 .../bindings/net/spacemit,k3-dwmac.yaml       | 107 +++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 224 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   1 +
 6 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

--
2.52.0


