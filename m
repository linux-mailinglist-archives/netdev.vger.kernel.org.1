Return-Path: <netdev+bounces-171927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6FA4F741
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D11A16DC9F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1CC1E5B74;
	Wed,  5 Mar 2025 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZtRGv3t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF01DF98D;
	Wed,  5 Mar 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156792; cv=none; b=SnT2PDwQy2Kyi0sxeczfjeWSiaqe1w5+lZ7V772ZbOwJ3mcgTf4iDt/ebR86MdmYhFABWH4Wg+WQk6cGtidqfa/d0e2IqZ1SBSOC7px9Dv6Nu6I0axtF7mSIkgANf4lwdnncf7yJiq8Ivv4BwBOKrKIshkrfbW4tEZqGD0x9RBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156792; c=relaxed/simple;
	bh=0odiSTYUNkwLcMWmJWPXdbE2gWNEYYCynJ47FWDc7Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6uwjkYcMFp/CLE4KGJvWlCNMC3vwd+USvh+ooKlCUSgp25qy9WamEMHLjws2S6TuZBHu07G2IRwVWuMrd9PuY43oPzGWj1OnPPU2GNf4HWYv+zizCJO4PsnpJc7oPu86povdvZ1hhD+EMbG/gSbf/AZuXqs/V2QHsnrBJQl1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZtRGv3t; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3b44dabe0so327516685a.1;
        Tue, 04 Mar 2025 22:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741156790; x=1741761590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZA5b2x/fScL7d+i7eRMvLOrisXrqpzgaeKI+s5E2mY=;
        b=KZtRGv3tIgTJ4ioSu7Xbmj19Kua8lfJqCqCE+BGefhpSQoL6cwJffd7XVrWkH6syOC
         w+IkchCnnAHsgqQD5OIajSdcShhooWMozvrKkMz4D66e8c1ZoS+NuLqC4f3n3Ul9/th7
         8DUfwHy8kkEtLw+Zg1EciWALU/Op0Zl/LuU25QtI4lFKFwotQQa2Ha+1QeV17B7D0VoM
         phqT9BeMBaRZ1/Ua3+vmA5Wr9ZGi9l17beJ4SkZvkycd+UAXN8NzZrqmt5dehefhmChM
         eLmfPlMhx+7oN1UjDzWV4MIeT6beCBwjSFbQG0mz8W9LXVOJP1Kc0F6DYcGXdKQRFh0l
         E12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156790; x=1741761590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZA5b2x/fScL7d+i7eRMvLOrisXrqpzgaeKI+s5E2mY=;
        b=LgEdL2WR6Xc4poNXSFbo1NEY2IE42RnEK6o1oIU6OqLmFvyGEyI89pFfpecZO8BVZT
         22ZNPkTs2xpvjdMV5jWfvjXUhSVI1Eq5IMqx7WHwfJB8dAAr/I6l10xLWGbr2j3VEdgi
         JpcAmsNv7LExnsLRmBZxKQBh2Q7hE0dnt04HNEHZbqhni0ZdPMhwZIboPGfVH+IShhBy
         F0K/9+0T0Rja6dy3pWC9K+5S0i954XCF7X9s7rK5u9eP75Pbq04+NITnuahse9p4bt6x
         n/xEtI4awyDI/bcOk47SDGK2YbR5wH90BvuOTgxNi4WrdCs2hzcx1Fevyf8oO5N9/FUY
         9pmA==
X-Forwarded-Encrypted: i=1; AJvYcCUGrXtO+olEW2mZn54KgmTvs7NacBNhDpYJg3aNtl49APBcQJOjvln8DS8C8EiEg7GPu95+VHwQcfNtYCEs@vger.kernel.org, AJvYcCVi8ilzv0m+67M+RQbYFg3DY6CIaBEJp5+otcaUKLdpltuYnzv0BFLO+rhfdREeImDtReNGykoQxiXK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1I4rdI3sid/5T78E2dYsc0IqmzzMMap+KTvwvJfdd2g3bd1Cq
	Wt6UJiqhd7UMf3TwKX0V8D63CZNb614h0+mCLSGNX6iLfMMzK3VJ
X-Gm-Gg: ASbGnctdYZS5fOb6OTYU0DhXZ/EjEPmVw5apU4O3FFGK4CnveY0IZiJb4Zdvyob17oJ
	rPVxu7Z7AoqbCHk3cqfRFMvJImKm9RhzZqnA05C7NUWyUSqHqJwgustHj9VtFW+gpP1zA/Bk4eD
	GYWDEyfgvOsgKOjjODnFu3dklN7YvScd3yfPoJEisgPFB8Exv2sdqHe8Tps0pIcdrGtIaOGISQS
	D7AuAGNHKe5ZqSEN4+s0Uscgvm+k1AbwLQhsEgEazojmStDjV6jQNx1jBiiqTdQu2xyT2M+YM6q
	rHaGkGxKr+FxiROCq/PB
X-Google-Smtp-Source: AGHT+IHQn5rcf/yZwl7qfbDraLVtkQEZKtE6MR9UkwRor+hKRVkXlhUT2tJZmUlvvrfGucfe6+0vEA==
X-Received: by 2002:a05:620a:4899:b0:7c3:c01e:ad0a with SMTP id af79cd13be357-7c3d8ef2cd2mr402188285a.49.1741156790046;
        Tue, 04 Mar 2025 22:39:50 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3cc0c20ffsm231314385a.91.2025.03.04.22.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 22:39:49 -0800 (PST)
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
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
Subject: [PATCH net-next v6 0/4] riscv: sophgo: Add ethernet support for SG2044
Date: Wed,  5 Mar 2025 14:39:12 +0800
Message-ID: <20250305063920.803601-1-inochiama@gmail.com>
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


