Return-Path: <netdev+bounces-230836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA77BF0550
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 081544E73CA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50412F5A0B;
	Mon, 20 Oct 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOpCblow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464162ED167
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954157; cv=none; b=heC4ToTCt4YbDX/3cfwll/VlY9JTpiX0K2eh6/hXyUo6oKeIu6dwc3eVUXX1MBYcRzcItHiwzY5ZeHxG3V1Qt4sEDY+wkbGFkoKnEpFEHgVI01WAdh6vYEv+o+s08/arzfbNa2QaJGT5yjwYKewUxesFBCzCLJa2veV8XMywa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954157; c=relaxed/simple;
	bh=rIsPkq1dARb1QczmgvcZPGvLvmgyJgmOrN52SnXRNk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Msi0S3Yj/Foc41oj3/xYyLDRbgkqMOOxL/fGs6aSL1C3ShHm/gb8ch6MS4dRiRSorPqAmcHttOo1RrHKNLuEKVqhy5stsVnIOpjbFhpj5Yh6JfAlrK07OQO1bkHp2IcBObHFUgk0fWLFop3zTXnQ7dNjd8kqwYPFUCQK/VmObNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOpCblow; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7930132f59aso5638007b3a.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954154; x=1761558954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnjCj7JbAdjNvBUGLpD1SpiGs6GWZ/iOIsdOQuRNQDA=;
        b=jOpCblowY/KCSAxOwVAMm0hPe1+P5MBrZ8O/Cx74d5DTs5At3SXOZeGJ5NaaOcO8Gj
         dT+BTbdUJ7AkzHZXBHBw8/tI9IBzTgr7765qOvjPBaER2wJmB0fEHn9lAB9C95GUDWwW
         aVQ7QrZM0sfss0KCitdlkmJdE6U8dktIFZgt9/iDWqqc8+zcZHmzKW7Vopnp39I1wGTI
         RqpaWZw20mjMqFWtHwQQyLFd1SSPaha9Y/mZrRZqCzCOwdysy95YdldZr4vQjBB8Xetb
         Z/ft8gKi8rOy2epOhZ2+E0X1WdzgBSPMCS14ntL6sp8uST7sncEc5CxsKaflgk8FJD5I
         LUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954154; x=1761558954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnjCj7JbAdjNvBUGLpD1SpiGs6GWZ/iOIsdOQuRNQDA=;
        b=p4UoDM9iGCdH4on+v39NXCnQsvIuC6wORJaUWY8llb4yMNX3D7Mvw8QAwj1jE79Db1
         a1eei5XS1suwE5WtZFKuxxuwZmB+TKXVM9PomXgl3kK+SRwpw5q0XVUCuK+zveu2sAy9
         Tm5/ByNn2ZDNyBM9codh1G2f6Q/H9R7GqumzLAm6wrATf7T0r/e3/Dk+rmQU4EeyKUe3
         GrMVLaGyHIszrjZtxHOH2vkbYkUwjud7xE8A0rKA6WPBGtst8eXAMKAARGFjEx+klMHC
         533KO4qwChVi5S4fh8eoQ7vyDrPSk9EJmGTNYo2mlw/bWfxmhJVfZQChxypnxZtFPIPm
         U4rg==
X-Gm-Message-State: AOJu0YyUOlrvoDu/+e0noDJFRVHDaUHLMJPkpW1dJF/bluX+vDt98ws+
	17+uLj0tb2y3Qdp8mfLMGCr1kXOltF39eEkvdpUY98nSp5glG+npdSXb
X-Gm-Gg: ASbGncsjsQvzt3eTQ5S/9/wDULsR46pFG2p13qWYeRWQDbJB2GWgIjbM/Kd1rKE1kwG
	o6WkaTmHnbjM0bN1TJKayT7Aq7UmejRuROvMPOhfZ1y0VhhZNTfDj3Fx9tNRWCy2TchO438FQbk
	hg5BB5EGyQs+fwr5+uMhdsDYngl8mb0CKOq+6ytEDsSEt99s/oVMLGW+3Dpijg7LXLqDKYjoFYO
	cocAZe366x1wYrVg3J+pVrYS0vxaqf1dbkVFREu5hO65aRWdOodVHkP68CICHbVsM2IQQuQ9u/W
	mqB9ZZt4JUhXGaKzuJkuOGKxmwHEnZf0jEBjE4kfOHCH5SsJDzgPe23ylPe9PXnHBdZDnXU8LrU
	lvLdYCBqf8O72p1KODKvfcQgJJDmFQ4rCiF4EvR+lhluDgMvueENeH3jbprXWDboZDuBMUAN/2j
	c=
X-Google-Smtp-Source: AGHT+IGgDyGZ3OQ57iwdb2555NKJghSCCZpCKxoCPXr9rM53NE7X3m8ehUVd2NOzuBByD+q6WjfyCA==
X-Received: by 2002:a05:6300:8088:b0:334:b8bc:1031 with SMTP id adf61e73a8af0-334b8bc1040mr10403992637.58.1760954154496;
        Mon, 20 Oct 2025 02:55:54 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm7256845a12.38.2025.10.20.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:55:54 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Mon, 20 Oct 2025 17:54:56 +0800
Message-ID: <20251020095500.1330057-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be remove
when init the mac, otherwise the phy will be misconfigurated.

Since this delay fix is common for other MACs, add a common helper
for it. And use it to fix SG2042.

Change from v1:
- https://lore.kernel.org/all/20251017011802.523140-1-inochiama@gmail.com
1. Add phy-mode property to dt-bindings of sophgo,sg2044-dwmac
2. Add common helper for fixing RGMII phy mode
3. Use struct to hold the compatiable data.

Inochi Amaoto (3):
  dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
  net: phy: Add helper for fixing RGMII PHY mode based on internal mac
    delay
  net: stmmac: dwmac-sophgo: Add phy interface filter

 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 17 ++++++++
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 17 +++++++-
 drivers/net/phy/phy-core.c                    | 43 +++++++++++++++++++
 include/linux/phy.h                           |  3 ++
 4 files changed, 79 insertions(+), 1 deletion(-)

--
2.51.1.dirty


