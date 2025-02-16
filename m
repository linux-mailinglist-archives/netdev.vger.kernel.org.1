Return-Path: <netdev+bounces-166773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F22A37429
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 13:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59156165B0E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA9190664;
	Sun, 16 Feb 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpBBOIi9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300FB1547C8;
	Sun, 16 Feb 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709621; cv=none; b=Xp+pvcFYQXOLS6VZfNxbM4OqKHltmZPchC/js5QmbndKUEHBjBxAn8u1UlQivfpUSnR5IO3BewpG1zd5amuY0IiZr17Rm3TwAaQB1XDZYWoiE5zy9gvC8y8wyCo5UITDsgTKpY0NKn/H36d7NMtaSYzcGS0EjaG1M4aao/HZuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709621; c=relaxed/simple;
	bh=eChtph/Tyvc00kHahpYDlz0Y5UiP6dhoC+pdUTtBAPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWszOON2n5sJso253F/KmzSkkJ1LPCWo2u4dzO0GmUspGtlXUNsmvETRF5nXs1rS3if9WhPOxeZzHB3VEcxTADWSEwty+orsg0wFO01LjP0p6k6nqDNsSaDa/ICRxbwHZNO2w6AsTVu3KCQX0qZRshwkX8o45L6qvjc0XVvJMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpBBOIi9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e672a21b9dso9297016d6.1;
        Sun, 16 Feb 2025 04:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739709619; x=1740314419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGDs3HpGQkICOAu67lknk/dBvFr+k4sdCQo4X5U4Pgo=;
        b=IpBBOIi98JwK5bQRo8ajS9R7v9V5b2acnJogiZtVpcE4Vvoxs0ma74pQG/NwIOvunR
         +AI6+yZZ88rkQ1cLMK8l1YPJKnCYdIwm2ZlLabS0t8iaVkM9PHgxurvYe9gEvsd30FjN
         WdMzkfNnMsqFl/3eqJvZRODtXydaGqsd3xnPurjF2A20XwUw2i7dMTlJTkq6b53um/+6
         ioxge3yuzsSoqMaW+HIIdrYZN10D/UByl6vIrDRMO6G6H3aAA8sPqZNfBLou7/kAVY9M
         dhaUSu5I8fd18yRI/EIGoD6b/JvLWgZB1N2vtaMDu7DL30g4blAUWgPFePftln+JHy2S
         20NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739709619; x=1740314419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGDs3HpGQkICOAu67lknk/dBvFr+k4sdCQo4X5U4Pgo=;
        b=TXGLn3a1C33w13c0L/GoZnbiqpvYEadf7m6BmUEl2GKKWVEEpBcOiKpxPXE6u9fU7v
         dZuwRNMheia70AAH7ar6PnoB8CWZrONzTL24PKTbcZE7/IhXV3oAxvn23vTNQEA9B+EM
         4gC+l2HEc8JvYzhqZspLgSR7+Kf0RZ3BTDEizTWnLR20t+Un2fUk5zL3KzrgjYlpYbfi
         /hyxXtoWksWXU+ljQ7zv0KiLqh1rDY+22csmWcMJ7DLV7zG7MP78Sd1H+KW4yGJDwaPF
         d0feAP3t9R1xkcOzRVb7pTQQ1Z/9X6v8kxJ2StYMShilihCfHwtpTSQZJn+K7S/jPNxv
         VEIg==
X-Forwarded-Encrypted: i=1; AJvYcCWLgNp1oxIS8/7t9nIXxUdNRBCe7NvZFFH6OK8//MrRVUkUiwHsHO6p3NF4OTwOaX08QYefS9340J791Myr@vger.kernel.org, AJvYcCXAGeR+vn+oDaTlsgjIhInlswP59ujdpUgIYoa4Ej9HX5Evu81T3Ivf37OEtX7kFb+yRmGJABzmyiMj@vger.kernel.org
X-Gm-Message-State: AOJu0YwHa/TtfkoS7caMCIMARi5aeNX3ScDc6RRM22Xx2Ql9PJF1ugHi
	h+jELkQsCirUgjUGcdZXNC73VcysNr5yMOlnu2xPbEW/OZEW3IHr
X-Gm-Gg: ASbGncv7zj7TLD8IHGj0Md/fpAXIWkg1WUxyg+uw7TrboouJVau6a+6bRaf9INiYi86
	uqYETFwEwANfZd1ANjhUdg8FRoUn4Nl8L3yHiFcx7gklBFz6KSEeTOF0iKjjM1vNUabISA2++SL
	mjwsQdDq/1YBcLyYPtksJHKGmI/R3T/olq5l9p+fTyapfeil96Ae7hpnpn3NvAgwPNFMvAVzGJO
	8ZErYmYvJQjAxCjjaQ6jEvNc8D4Bu26/XFgmicHxBLqxcsGT8YQ39vNF7yCxgNJlX0=
X-Google-Smtp-Source: AGHT+IEpfpOMHZ8O/1KvInhk3KcC7dM/mez8wsS2NuX284w3zcB/+PjufIWyqrWrlCFEXBwTJBBy2Q==
X-Received: by 2002:ad4:5f0a:0:b0:6e0:ad33:36c with SMTP id 6a1803df08f44-6e66cc86d3cmr90601876d6.2.1739709619021;
        Sun, 16 Feb 2025 04:40:19 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d77927csm41319936d6.10.2025.02.16.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:40:18 -0800 (PST)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Furong Xu <0x1207@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v5 0/3] riscv: sophgo: Add ethernet support for SG2044
Date: Sun, 16 Feb 2025 20:39:48 +0800
Message-ID: <20250216123953.1252523-1-inochiama@gmail.com>
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

Inochi Amaoto (3):
  dt-bindings: net: Add support for Sophgo SG2044 dwmac
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
  net: stmmac: Add glue layer for Sophgo SG2044 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 107 +++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  17 ++-
 6 files changed, 259 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

--
2.48.1


