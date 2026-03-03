Return-Path: <netdev+bounces-262969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPiaMj80pmlJMQAAu9opvQ
	(envelope-from <netdev+bounces-262969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:07:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2681E77AB
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D93305B45D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C5D1E1A33;
	Tue,  3 Mar 2026 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYWWhJiM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A643909AE
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500028; cv=none; b=GRYhm3gvfhEwPSVxEr9yL4TKE7OgV6nQKLgVdc+DXFxaFT3BhQFCVhHeIE31+ICBhDFVWaepM8+7lcRUppW0M/ov2oircCv59saMyg5+n5OWMvZ07BVL1QATXFeJA6RedZOXID9pb9/spx9lbgpLxo9UMcQ+xBBS8YwjXTZf0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500028; c=relaxed/simple;
	bh=gES4GJg7caL7FDakaIQFxprqwVBsSTtJ0RmrIWeRxjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9EfxoK6iEoR/2KEtv+VHeIB1x8UF5e4bcpeEQgF9fFLcsNolrp448Eya5yDIiox/1/LrorMjt7FwVZaa8E1+mMCBkkQaaINTZ/A2B02KZbpE5k33QXjVdt+eMmy0JhxHS1M/6wFzN9YDensoGSyR9K6GvN+m0JRuO1AxA4Db9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYWWhJiM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70ece855e2so2144488a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 17:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500027; x=1773104827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyhrdqZlHw4Vr79hIFoPgUvb87j9Owo78niBL4sfkNc=;
        b=RYWWhJiM6D228xY2l1IFJYXs9b2w/L+oNp3rN6LlIQVfY7lQfjR6TUFbqR7JicHeoQ
         kpQ7wnnMFM5NZIq4UBtihp6YaJEjX0Eu71neYaJj9isw/IhK3kO0jtCijFJbp8vSdQRn
         uJBeiwYulw+ICPQUyvOZBJwb6KPXnH3SgIEoAk2o3S14q/Q1VXc1sOKZZt0TZ6iNiWPH
         pRKtxxGu4ZZzA31/oa1vcq7TFo1nU7jfZ/VdJ9vBlJKmKBUmQjycnp7ECtuqT3U/h+X4
         +rxJcV3XgPak2maBvQV9ANy1Sn8ltT5RE6JDsof6NieMfCuSiPtU9dl4P6TAFIiZIwyN
         MxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500027; x=1773104827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyhrdqZlHw4Vr79hIFoPgUvb87j9Owo78niBL4sfkNc=;
        b=k3v3tvug4kHBB7vzsrO2Vd351OpByLUVukknTeaJSTqEk7iSc/CNg2dOWLnS9cCpbw
         QMbr/skBn9RTlELX5ouyR6t2iQEh5MSOAM2fDvK58B43osyUc+ZFYIQYdN44difsPSD5
         BYM4e9p4l3wjX1fBMUVL54JUOPIVC80vC5Hp754henW18AMoUQMYuYBHOul+HQK68EQX
         j5mkypGXf1grMSApt5yRTemy5G2HT3NRNPGWAsrx5g0KKuIfn4aAVMjKMYKENoMkQkdO
         578366qWqN9WK2JeARdI2cg4l7YOhQkshW6ZMXNyMV0HTdNJFcy+/g8CDqjvTSveLzf7
         MmtQ==
X-Gm-Message-State: AOJu0YxWBaaRmOs24fgW01fgQHVsyfjmVYoXXDZv4jcBLIWXlbs+S8Bk
	RS+lvksNLEQTlCbRdv4fMJHr5/VkBqZeCtnJs0F1SZkLfRKed1r6E5os
X-Gm-Gg: ATEYQzyypEpQwEYW30+8CIUf5SvA2WbEgngZ8KD7tYU0niuPFjF5JjIG51UKjuOPvBn
	qGLS7OZL/SJVkwaGqm30NqBb0bu3MccKFyK1iD9fNF4bgEkShUj4qv2tf6uolr1aypw6DNw84V/
	EdutlOsm1YZMKtpgwOUw2AEougQwcHdBHKowrsHMJg1h4rbvg9AOZuKoFsJZp99UoYsC+HiyF3V
	VZk9heFERzkaOWNWp53mftsNU7WceDNSRpr52oTlTBDec4wD0MML+7PQLtNMDytliU96drvy2ic
	PMmDL30EVGGHtnUfqiyfJEnVNe83yEvwmtkT/iLZuR4fRPEHAV9mIQXZ5TC1a+ho3Lplv9YjTHk
	nOZ6X3fMUjzk70iccYBxkbjbpx+OvR/G/lOXXiAUlPpXvHMsTzOhbhIrDCW7b4aJXVgSqquxdGC
	9coJE8fhQHMMZJKCE8ZeYukQ==
X-Received: by 2002:a17:903:2447:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2ae60cc32efmr3595925ad.15.1772500026993;
        Mon, 02 Mar 2026 17:07:06 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45b5201fsm66337935ad.87.2026.03.02.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:07:06 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
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
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v6 0/3] riscv: spacemit: Add ethernet support for K3
Date: Tue,  3 Mar 2026 09:06:26 +0800
Message-ID: <20260303010630.567674-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C2681E77AB
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-262969-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[38];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add initial support for ethernet controller of the Spacemit K3 SoC.
This ethernet controller is almost a standard Synopsys DesignWare
MAC (version 5.40a). This controller require a syscon device to
configure some basic features, like interface type and internal delay.

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

Inochi Amaoto (3):
  dt-bindings: net: Add support for Spacemit K3 dwmac
  net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
  net: stmmac: Add glue layer for Spacemit K3 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 .../bindings/net/spacemit,k3-dwmac.yaml       | 103 ++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 228 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   1 +
 6 files changed, 347 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

--
2.53.0


