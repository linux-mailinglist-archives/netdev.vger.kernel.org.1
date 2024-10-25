Return-Path: <netdev+bounces-138909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6E89AF672
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68092B215D0
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD11171D;
	Fri, 25 Oct 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK2MMt60"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3AC10A19;
	Fri, 25 Oct 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818627; cv=none; b=s8iloeC0NeQmgGr7FHvY2lgR9KPnAH0kvsluOWgSCcUj9NrDOVGQCy5/JaiatTX5BOp0B9fbnjOIqutOyyXpEmGeU+YXpYSSmyidFhciEjBsczJXtH4YhMk41zaKpiL16PreIWTcOP2U1qyw9eeYhm7TQQxT+JvPwO3VREyypzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818627; c=relaxed/simple;
	bh=lWwyYbzBQmFD3lKbaX8VpjDA3jlUz6kqDdllqTJhGHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQOK1NbY62tPTEzRgVvsYfJPWQXaZ/yxftgS5jrRbwE1C+/yDGEJ8RNtPVKvLpSFS77PjWcvNYVyJa4D47qd8U8dtWtaRUM2ZVP5TKI4Rcqg0QIQkuF5C3X+8t85nnd5Ob+MxNZQHj9c6QzpmtAH3VCcgPOoZPfDzxBIP6jMMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK2MMt60; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7204dff188eso621944b3a.1;
        Thu, 24 Oct 2024 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729818625; x=1730423425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYpfrlq0V0bV9nsDJv9ukMK1/gCt1wSxEcrYWbmTl9Q=;
        b=aK2MMt60PuIeBAQm/GVI1KYBEbEhpozYfBCJ4lsrDdG4Fc/8xsSYxD9ZFGZEyVJ3wl
         ovVMjOFMp50vQ6ObBRsqsPFm9cZMWPucNstrAxsL0pWqnjcFq0Uf5GZegS6idpM2pajj
         Ddv4Kj0oj3bT+lvrOL3uLQH5JEbGOY8K9KywUcaz8YXV7At/+98AILeNCLmvLIiIo3/A
         o5EyP4X0r1MY/dK96kxfMRn9Sr+a7QKnrtZ5/aeID8JucktCWp6GT8jt3VSAnTremxOs
         XwJZj7ksZI1gaU/T+Bgror4LJLuyjNizud4Us9SJBW6gUmZv8QyHupmypv5QjPqx49KL
         ZNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818625; x=1730423425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYpfrlq0V0bV9nsDJv9ukMK1/gCt1wSxEcrYWbmTl9Q=;
        b=kJT749Fo7V8OAnWTblEJTMyhT29gz53TVn6FxR4WcsxHEFPEtisM4HO7vrV5jpBb7h
         EEEk68/R9cZHtMzR0T3whDHjEK6VNCw2Z/mmzPqZZynMv7YsJnqQVeJUMsx1K/h3DhnY
         axgf7YkwN7VZ3scBcjV+l3qT0KhbbSdJL5Ax9SMDmECC1cz6dD237RXSC6kVp9JF6IKn
         KL/6ZvMISxua56PckfI/tqxUHF2ntBJKjz3/OdyMdWgL5UEbl5BTywhf41hEmvBiHhlO
         60f247rHju1n7WEUiWeJEOOBeJ4au60lEXkDEjel0YQnSEXaWG7hD856H3ldeixeTXp+
         O2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOM8DWcNGTO/gZuPOyHuyMc61zIBHVoaQEu9JjYdXOeOHUHQXQraFwy/8caJKPoChu6axyCrw2xsbyiOcw@vger.kernel.org, AJvYcCVlpAxuTHYA1o0v8N12PGFTl2/4l/p+7x40CPCgJzbus6rCMedheR1evgI25LvoFQOycFOjq5L8kfeG@vger.kernel.org, AJvYcCWc5OgclMLUAF/04ClXcnfXhteJkSN/tkpvFz6McbZa9uzjRWmI4IsqdT8RxVIzaNmxkEKT4hn6@vger.kernel.org
X-Gm-Message-State: AOJu0YxowLjyRPaVWCYPrqJ1DcXQUhoSPLyNgnCgyUymOfIbD8GML9je
	gTXd481kONh6xnbEkllDpc8B6+6cskMiHkBcB2x300pRyR2L85Np
X-Google-Smtp-Source: AGHT+IFpOd28fEHMTcKxVcGsg5KEPz6mrlaxZYvtZFvJjTxq2WDoP6vXaOQgIFHT9LXF1AJwY1a6nA==
X-Received: by 2002:a05:6a00:190e:b0:71e:4c86:6594 with SMTP id d2e1a72fcca58-72030a51d13mr11382153b3a.10.1729818624886;
        Thu, 24 Oct 2024 18:10:24 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b9b1sm53397b3a.133.2024.10.24.18.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:10:24 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/4] riscv: sophgo: Add ethernet support for SG2044
Date: Fri, 25 Oct 2024 09:09:56 +0800
Message-ID: <20241025011000.244350-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet controller of SG2044 is Synopsys DesignWare IP with
custom clock. Add glue layer for it.

Since v2, these patch depends on that following patch that provides
helper function to compute rgmii clock:
https://lore.kernel.org/netdev/20241013-upstream_s32cc_gmac-v3-4-d84b5a67b930@oss.nxp.com/

Changed from v1:
1. patch 2: remove sophgo,syscon as this mac delay is resolved.
2. patch 2: apply all the properties unconditionally.
3. patch 4: remove sophgo,syscon code as this mac delay is resolved.
4. patch 4: use the helper function to compute rgmii clock.
5. patch 4: use remove instead of remove_new for the platform driver.

Inochi Amaoto (4):
  dt-bindings: net: snps,dwmac: Add dwmac-5.30a version
  dt-bindings: net: Add support for Sophgo SG2044 dwmac
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
  net: stmmac: Add glue layer for Sophgo SG2044 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 109 +++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   3 +-
 6 files changed, 251 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

--
2.47.0


