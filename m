Return-Path: <netdev+bounces-153980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A159B9FA8CE
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 01:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B07416464E
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A76FC3;
	Mon, 23 Dec 2024 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgX/yH7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1683209;
	Mon, 23 Dec 2024 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734915562; cv=none; b=DRGQeJ9xKI98dyd/Y+3p0ypg1RkVEcFM8BJQFwYXwK5uAXWkmOPCdx3uV6Y9kQAjMPk4y1kZpdux1wEX9p4uZ0upxRG29WbQD/jltqytLFP9U6zuC32OfF82F1N+Z4RNxyKhvdvDa6WzqJaIqx9CCY++HKSpTNproge78/TSKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734915562; c=relaxed/simple;
	bh=hgu//T+7YSAvIXT3VUGoYlGaahKbQUcLyt85jDFn+fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAB/iqjbk7gGRyHPoykRBgnXf7yv27vuadhZwrNpciBykLXe2xSF81UF8e479ilvWPBTIcz7FAwfKPLDATV0Upf9Ghb4eHl7/gz9Bk5wv1Eb/vw35ThsNECl16eIJBnDVVgICe/1WnnLs3QWzgz4BOt8Fr9s5FZRJc3XGPYTSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgX/yH7O; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dcf63155b0so17804556d6.1;
        Sun, 22 Dec 2024 16:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734915559; x=1735520359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZiA8+8cgK1p5p7ZdtgnD9VuQej6yYU4CGShpBV3y6M=;
        b=YgX/yH7O62lI9EkvjmxV3rXkqPlZdFIqH2FcbLCOLsq7KqPEFFUy3BmddmVHqtLl3U
         5AmHESCCflibSQyilzHAnvotqcX0drYu+S8EZGfvYcAApeo8NHg1WXExefNHwU2s9826
         DmuKgvNzKp+fnpk+7s8WVuYOwjj3EpBrJe/UXicQ/tTd3R6/PEl6kxTFZGiFePmId/n3
         l3N2PH6lKUBwUmcwUASBoxl6MF7Uxp7QLl8su4ivK4IJGpABkHOawEGmK7yFkmM+88V3
         cZq4mm7YQpP4A8mzX/peagc8Hu9DoN/lwlbKtf2YX+TO4IeDmdX3zfUVv2CnMFAW13Jm
         8WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734915559; x=1735520359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZiA8+8cgK1p5p7ZdtgnD9VuQej6yYU4CGShpBV3y6M=;
        b=X7zBUFuAgFe+4fsZc5aaU77FYakA1mi2NUFpTFQf4B1jifYSw5g05y/Gl1gVAweE3G
         R2VXruZqg/RA0LeTE7kHhhnb5Z/9FLn9KBgryR6S7NmPNzzUezIfGnNXQvWrC4Th2Gva
         D9FpC59t7sV5I7ABuIkHyK7oBDZZhlhKLajpLiHX9uiFf0j0P00va3x9tjEJSSB9BIit
         G5toSwXT8bSjUCvwVpXZWPc6mr5lpSl4Kk7u+oiOFJnLsUuuIiwaTpafKZI6aUiYNSPw
         ACqKWW9G2Yrc3i6snUy0+OIcEbJqsvenzSsHh7jEATx1UM1bqn6obXM0c5mi3SX8HUpT
         jv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQEAHnFdHQ3wbtbfnsmQ85ZohSoyD9/L7DOPp5HR+uuJ3n41ABEvm2WAVMNEZZwSj+8OQm5AYKXAFw@vger.kernel.org, AJvYcCW+4f8JX7pm7+okpmJJVhruP+qwabL3W/CMEbHFO1P0+TN0ULlfy9UrwXX4e/gC9ZRasAP442jy@vger.kernel.org, AJvYcCWRGv5wfp2WQ3QMerCqOBY6hj8LLWMZSYGMYLFP5a59j1wM1rtDWI+ZDVXNk6mt1yqgR5KtjZPHS8+2u7ih@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1WSKrUPt8hClygadSwcNVk9Qvls0dzVxvigkZzlO4Mqho0XK
	jPoOqdp0NrRBfEbrzMibtMPRQxIeztb2NwIMFR9WBCRnXPpf5+AJ
X-Gm-Gg: ASbGncsOArDmbqCDNy7VGQyVI6Za2MJSqpdeyefhdykDgZI0w4OkEbp6iY+ZaqxZpmX
	hiuV6hi7nJyNrsCQyqalBmQEiN15pJcvPbClsVbLDjpM6NIKIMVWVtIkg+TcA+a1gXDSxnX2E2c
	R1fyTmGzeNcpc+3b+IVIWV7ka5pV9O10lZ7YElSpkqVq/7igkFxSN7MnUyiwSeI8zRN0nvGIaSc
	bu0X4FJZzEaTeY0ylBSy1eUeiohRfxj
X-Google-Smtp-Source: AGHT+IHSkClTiIOMU6UV3EvrSaxtK6rioCiVEHPiLA/vc1hX5NvNNm2L1qNaUclIZVtTYbzu6LhDcw==
X-Received: by 2002:ad4:5ae9:0:b0:6cb:ef8d:b10 with SMTP id 6a1803df08f44-6dd2339fb2cmr222084936d6.39.1734915559348;
        Sun, 22 Dec 2024 16:59:19 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bb4b1sm39250996d6.78.2024.12.22.16.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 16:59:18 -0800 (PST)
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v3 0/3] riscv: sophgo: Add ethernet support for SG2044
Date: Mon, 23 Dec 2024 08:58:36 +0800
Message-ID: <20241223005843.483805-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
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
helper function to compute rgmii clock, As for now, this patch is merged
in net/for-next
https://lore.kernel.org/netdev/173380743727.355055.17303486442146316315.git-patchwork-notify@kernel.org/

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


Inochi Amaoto (3):
  dt-bindings: net: Add support for Sophgo SG2044 dwmac
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
  net: stmmac: Add glue layer for Sophgo SG2044 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 105 +++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  17 ++-
 6 files changed, 257 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

--
2.47.1


