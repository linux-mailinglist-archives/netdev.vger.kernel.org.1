Return-Path: <netdev+bounces-267987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIdBFVtWt2lsQAEAu9opvQ
	(envelope-from <netdev+bounces-267987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:01:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C07B2932E7
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0EEA3011F0F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763C20A5F3;
	Mon, 16 Mar 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJv1yMpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687133E7
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622864; cv=none; b=i5N45n0W8K9f1kcNhAsUn1ci1NHfV+hp9QhMEoB2Sf0Wz85ag32SksRdQ+gvtHzfJ14eH/g0UXOc8uEhElLKbEg4hXfg9/O2XEmfkyEMwJAkalBYj2Cow1Qh1gVbflUxnLcbfH2t2k3TEmbPCMmCd47Bbt7OFE/47WaPGF6uMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622864; c=relaxed/simple;
	bh=E3TzQu1pHfPmyontnXm+hHLzoEHDGGZg0FGg2U5AhaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LI54D+ltXRLH+RgHCOVEgx99wy+kDNG74BT9FxVQgPNxFsy6VikQu1WGm/VWkHCajzG7wRCNvvzkoaDty3RVNOV2lM6rnHxOE0YUPUooyhZgS4PkjXljtuDbOQOiiH+cCQWs/86svnVcu2/0PnWMNomk9Kh64t1CRr5a43i1oEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJv1yMpm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829928e512aso2047358b3a.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 18:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773622862; x=1774227662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIPI/q2re4TeHZpgDpGUyFzrkzN62EoFr65JPUJDx7o=;
        b=mJv1yMpmv3ZcUQsZirO6MZ2A/Jwf+Cf6jiTJ83m2FFduvhPM1ybL/L+feczXqeau1x
         /r1N04a8nsMVdSqNsP+V2jkrg6opV994Gk1f1WyecoaKDbkdNbaWXfNeQBJUfgKiIThW
         J/nNYlf15vhc06BNUtlyknvRjkjmm6ofA4hMW2Lv3RBzU8MqVakSgG88e4oxD6emqH9C
         U/jUTsNmPNaEjQrEG6rV93FVl+1hp0OaW/9EYtVorTuIpwYS91IJIYqRc++rTxStk8ra
         O/w9/WcTBqkaq3skkQrlwZQvrbN5iTyVsw6hZngQ/ylpFSuEBXsPZsmt+L8UI+Mb0dxG
         fYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773622862; x=1774227662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIPI/q2re4TeHZpgDpGUyFzrkzN62EoFr65JPUJDx7o=;
        b=oY7GZkQcjCDLCHgj1dTwS4UWhrgPOlOT8DFafBFR8biH3Saj0jzfSPP2ewSThbanRS
         z9EFujoxvds0PE8ea8fGYZkIaczuV1Ew8iulQS4o1vcwt3ZX5/SyvcZAcakAMaiC+2FT
         GDnqYZMc/sxi1g8CNAq71ABSgBCFmlTfCbpzFdy8WDBBGGDDLYaQnxqFejfPXrwme7m6
         od5hlrcGHNKAtu0JqHll2xW5JoyG5Us/sSRfkHf4E9+JUGT1xYYGOFw+eus2IcsAjA8E
         1Gf+ULK8H0eXTCFgJ3c8f3Te2v4qbl93H5IKkGo81E19/iRQvhyoW1J8fi0QLZG2rs2c
         iHEA==
X-Gm-Message-State: AOJu0YxA5ZAd/5n8ExFqpx8xfxSQfS1SXZL5dutQn0X1RSsqngHcxY31
	PoFqXVRcidU0sBOnzitsT76xaVF7zSIj53hmpDKKWdWAeADdf0dHj6PH
X-Gm-Gg: ATEYQzywEFQAxm0klajS7CJOwkFFoA88HBWqd5Xw4Zu8Dqy0s72LtscIMgJIQtlqoeB
	p6ViFKgzY6CSYjH5lm+xC9mXbR6gxK9RXFxJqzV0zu5Wo3zVP69ZMlaRjKLrI4u0PPD8IN6Zo2+
	Epwzaz3Ll/NFwTLWNtvQgH9LbBohQNw0TJQXjDU3iG51ma2LJtmgCtK+25i5aGJ5U0nnQlXw4V5
	+qK1t5yx6jzajP7GBNbAEuqiIWrrjRFOyvZn6J6pZeK7/8VP+3XgyA7ymCDck0J1pnUx8Oj8J0N
	6KAVHg7APqfkXcLhb0FExailGo8iY4w7YxYQa6cYsESv+3UNjM14qXOKIQysIwuo3yuqUO69Kzv
	SxhLPsFkV0Rd05sQy5bbHtX56FYmRFbce3fikD8wBeoav2CL7HiRtb7CUVpG9K1OCZ47weuFuO7
	pAfHF3p4+BUgOGluPBuRBDzak=
X-Received: by 2002:a05:6a20:4305:b0:398:c351:aa0e with SMTP id adf61e73a8af0-398ecab0dabmr9889114637.25.1773622860419;
        Sun, 15 Mar 2026 18:01:00 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74028eecd4sm1977320a12.26.2026.03.15.18.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:00:59 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <me@ziyao.cc>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Zhi Li <lizhi2@eswincomputing.com>,
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
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v10 0/4] riscv: spacemit: Add ethernet support for K3
Date: Mon, 16 Mar 2026 09:00:36 +0800
Message-ID: <20260316010041.164360-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267987-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C07B2932E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add initial support for ethernet controller of the Spacemit K3 SoC.
This ethernet controller is almost a standard Synopsys DesignWare
MAC (version 5.40a). This controller require a syscon device to
configure some basic features, like interface type and internal delay.

Change from v9:
- https://lore.kernel.org/netdev/20260312012232.373713-1-inochiama@gmail.com
patch 3:
1. fix misaligned brace.

Change from v8:
- https://lore.kernel.org/netdev/20260309004305.315018-1-inochiama@gmail.com
patch 2:
1. Apply Russell's tag.
patch 3:
1. reverse the order of the local variable to make it "reverse christmas
   tree" for function spacemit_dwmac_update_irq_config() and function
   spacemit_set_phy_intf_sel()
2. Apply Russell's tag
patch 4:
1. Add MAINTAINERS entry

Change from v7:
- https://lore.kernel.org/netdev/20260304080721.1658224-1-inochiama@gmail.com
patch 3:
1. Remove unused parameter in spacemit_dwmac_fix_delay().

Change from v6:
- https://lore.kernel.org/netdev/20260303010630.567674-1-inochiama@gmail.com
patch 1:
1. Drop the extra blank line at the last

Change from v5:
- https://lore.kernel.org/netdev/20260227075718.2243818-1-inochiama@gmail.com
patch 3:
1. fix error from checkpatch

Change from v4:
- https://lore.kernel.org/netdev/20260130022705.1059214-1-inochiama@gmail.com
patch 1:
1 Apply Rob's tag.
2 Adjust clock description according to Russell's suggestion.
patch 3:
1. Add set_phy_intf_sel() and get_interfaces() hook, suggested by Russell.

Change from v3:
- https://lore.kernel.org/netdev/20260128072931.875041-1-inochiama@gmail.com
patch 1:
1. fix the uncorrect compatible string postion
patch 3:
1. add "CTRL_" prefix to all ctrl register definition
2. only use delay config 0 to calculate delay code.
3. fix typo in the comment

Change from v2:
- https://lore.kernel.org/netdev/20260121071315.940130-1-inochiama@gmail.com
patch 1:
1. remove not needed compatible for select
2. drop empty line in "spacemit,apmu" properties
3. add spacemit,apmu properties to required.
patch 3:
1. remove misused phy_fix_phy_mode_for_mac_delays.
2. use local tx clock instead of the clk_tx_i in the dwmac.

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

Inochi Amaoto (4):
  dt-bindings: net: Add support for Spacemit K3 dwmac
  net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
  net: stmmac: Add glue layer for Spacemit K3 SoC
  MAINTAINERS: add entry for SpacemiT DWMAC glue layer

 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 .../bindings/net/spacemit,k3-dwmac.yaml       | 102 ++++++++
 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 227 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   1 +
 7 files changed, 351 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

--
2.53.0




