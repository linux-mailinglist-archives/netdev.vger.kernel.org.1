Return-Path: <netdev+bounces-172724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66FA55CF7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96F7160FD7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0A2AF1E;
	Fri,  7 Mar 2025 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxTWXpT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF82030A;
	Fri,  7 Mar 2025 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310218; cv=none; b=kQFCSYeICgsCpwZzU5yRTgTIjFwf5qviiThlowOYrZbhqHRoNAGmxB55fpFK38MAw75cZEakhudcoTfjApY5TUgVLyfeNqf33r8+aU+TMLqsTxi53OjYGe0QXF8ysvMvojkDIye4oefVsdnOYxxsjp/p7dd6aWDGng03yBynusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310218; c=relaxed/simple;
	bh=hB2SK5wx9v8QGh3wGAwMdptAwb2ft6xPAL+mJB2prM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vElah37+U+4+gVVTZTunb4jIF4vVjr8Raf6EQlbmKWczZgTpMjuPfJ9TlIp53B9VCUlGwqJMyQLK5d+JIS7HyxJM3RwJ6NFASNcHmj/4cZrSFVHgYRk/9mqZqHR0zCYokQeBE5/vWKFRq6h9n8N/HR03RiaC8i1wVOhWMsXX1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxTWXpT7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e900a7ce55so4126776d6.3;
        Thu, 06 Mar 2025 17:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741310215; x=1741915015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdvNoZdxI+TWENbSWz9hBd4EuJ//tH9knwU3HWPo67o=;
        b=bxTWXpT7R4bbtD6CnmtcVAR1TfQwM+O7cd97ErNNAc8FwCj2y2P1hCxoYXq2nEYWsz
         RjRX3BHL5n7f+BeQ2ERwhDtxFcmfLXns7Xt58EGF6VanJ914k4gGH6BesiRioTkn4JzU
         DzAR03M5LavP2PHjEgCEv6EkxGXD+/98ls2j/i3jmaj/6hpQsiLsRAjuujBiAFO9Zb1y
         k5LQYE4ClTCTzj4zSdb3oalCFyK6JWV6bY2XtG3pAdoR84CAyMwbCGPt4ho8I26bMd3U
         1WiaeK4Q42HrH2O5GOcyK7hM+/go5SLNZMIMcn1Usqaa9aAkivTDim87RJufczUTVscL
         hlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310215; x=1741915015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdvNoZdxI+TWENbSWz9hBd4EuJ//tH9knwU3HWPo67o=;
        b=i+eucamvqyoZIJdTvkHGp24tg7ML9tutJq07bS/BtqyLMEc0+OefvYU3Kg7bT1pMqa
         OKGGirWZPmGSqvND7ZO4BuEBLEClZyk4PGkgabMziTkcaIWk/0uoC28dUuADDIOhMYeQ
         jT7JEa5UXZ17RbgWLoBv7N5AAX8l1lXQVVHPnxgZ1srPN7H5Y62BP0OboiyRDWPGiD94
         tb2XZMwlfKqoSFRMBPzZie7EAd4Q9w0JtBZs5yXopQovf2pQlWCwmcXqpRl0sTpWWd+B
         7mAD1d0wlmpnrf29RLepMAjdENj9mWdXwY4H+hHLTPPDTyhx590QsNS4+CF65XNSc5zS
         kXhg==
X-Forwarded-Encrypted: i=1; AJvYcCUpx/Pe9//4whF5rkn576aBHLzT/yOeAxmhsvQcslmibeCRnwHslnciPLFujGZoSOkpObCpC+CfExpT@vger.kernel.org, AJvYcCVgve47ZAtVfn7A0sdbQjoEOaQ0ZwpEo1BfS7JFr+SySBbkWcYjyuEaI//px1+J9R989gV46vcO@vger.kernel.org, AJvYcCW0Z+bFBgN70vc/tzM+yAgy7tZqIKziqdjwIWtfrNYLpwwUIR893o2UKGaDo5h5EeJqrqNo6j8Q/zeNrejz@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOheQ2KL9Re2lesiPsqC1h3n4O9akEQawQRtdToo775GQqfcg
	u2bsWO1rJca4++mjFn5YgtX/LFrf7tDY9dmBgCBH0BvMcsq7CSwO
X-Gm-Gg: ASbGncsefYecOnzBFcUAcZb7gg0uKDgIMEiGgH3vuKHsm4ejeVMom1tm7Saqvos5FIj
	Qku52WpM/AlTcdTucT4vDGdAc6HGd5vJNbBIVDtGxH4sTr4HU1h0NP7DXg0y0jmvxg23Ba4DYtn
	+ZXxba5M5AqBf3wXoTpAoZHpJ9cZglBEsmMYJNnfCfnJjPS4KlcHrjGoNtvw/MGio2rX9gl3jDg
	T+9nbhUaFoaOEAfAzMilwN4Ey4ZXJsi2RXsQF5bsFvdfv+v7e2KtHW2W7mCJBJzzEWx+K1ApCfs
	fk3DH7VMAbD7Bc5QE//M
X-Google-Smtp-Source: AGHT+IFF4yBb+hCS7ZBQCfCT1ORUYw/Gj0CKaqbDjWG3VtyoJXnhpEJioVXA7e3Pa/pLe1dzFKh+kA==
X-Received: by 2002:a05:6214:1c49:b0:6e8:fa72:be47 with SMTP id 6a1803df08f44-6e900604eaamr17244676d6.8.1741310215325;
        Thu, 06 Mar 2025 17:16:55 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f71724d4sm13217566d6.112.2025.03.06.17.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:16:41 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v7 0/4] riscv: sophgo: Add ethernet support for SG2044
Date: Fri,  7 Mar 2025 09:16:13 +0800
Message-ID: <20250307011623.440792-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet controller of SG2044 is Synopsys DesignWare IP with
custom clock. Add glue layer for it.

Changed from v6:
- https://lore.kernel.org/netdev/20250305063920.803601-1-inochiama@gmail.com/
1. rebase against latest net-next/main

Changed from v5:
- https://lore.kernel.org/netdev/20250216123953.1252523-1-inochiama@gmail.com/
1. apply Andrew's tag for patch 2,3
3. patch 1: add dma-noncoherent property.
2. patch 2,3: separate original patch into 2 part
4. patch 4: adopt new stmmac_set_clk_tx_rate helper function

Changed from v4:
- https://lore.kernel.org/netdev/20250209013054.816580-1-inochiama@gmail.com/
1. apply Romain's tag
2. patch 3: use device variable to replace &pdev->dev.
3. patch 3: remove unused include.
4. patch 3: make error message more useful.

Changed from v3:
- https://lore.kernel.org/netdev/20241223005843.483805-1-inochiama@gmail.com/
1. rebase for 6.14.rc1
2. remove the dependency requirement as it was already merged
   into master.

Changed from RFC:
- https://lore.kernel.org/netdev/20241101014327.513732-1-inochiama@gmail.com/
1. patch 1: apply Krzysztof' tag

Changed from v2:
- https://lore.kernel.org/netdev/20241025011000.244350-1-inochiama@gmail.com/
1. patch 1: merge the first and the second bindings patch to show the all
            compatible change.
2. patch 2: use of_device_compatible_match helper function to perform check.
2. patch 3: remove unused include and sort the left.
3. patch 3: fix wrong variable usage in sophgo_dwmac_fix_mac_speed
4. patch 3: drop unused variable in the patch.

Changed from v1:
- https://lore.kernel.org/netdev/20241021103617.653386-1-inochiama@gmail.com/
1. patch 2: remove sophgo,syscon as this mac delay is resolved.
2. patch 2: apply all the properties unconditionally.
3. patch 4: remove sophgo,syscon code as this mac delay is resolved.
4. patch 4: use the helper function to compute rgmii clock.
5. patch 4: use remove instead of remove_new for the platform driver.

Inochi Amaoto (4):
  dt-bindings: net: Add support for Sophgo SG2044 dwmac
  net: stmmac: platform: Group GMAC4 compatible check
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
  net: stmmac: Add glue layer for Sophgo SG2044 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 126 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    |  75 +++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  17 ++-
 6 files changed, 229 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

--
2.48.1


