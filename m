Return-Path: <netdev+bounces-184911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82669A97B0E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F691899DD8
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B01F151E;
	Tue, 22 Apr 2025 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="axz5MdxN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36D184F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365011; cv=none; b=Y+aA5XA2XriYv31NKwBqeKWE7Y9hVELXfuY8YNDb2da/M/sOQT79mIsXMbVWLIIOKYcD90NSF9N0YswwQNYDxFBVucFciyjgwQKycmaU07M3pLXGFGvwzi6t0jnAjsqSj2+wVMhMFmrtVM/4GI8o64QO8z2YUbwMMeo3tv1FR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365011; c=relaxed/simple;
	bh=xAlx+MJX8nNewVjgdt5ATui8gHpywINRhhg8eaTl4U0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jm+NLovJ1GjJT4nUxNWgL0n3g7voHWKtbXPO47OeWOju4eDNiAqG2OJLlqgBX4hgBL5IsYlKfASH+VX0ngyb5pCn699TDr3LYSCpS3KsInaV2L49l4PvP4YZ8osM7V1UNPupHNoZxJcqt2MiAFBodkfy8EoBK3T7vUuLNpRBlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=axz5MdxN; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3feb0db95e6so3328494b6e.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365009; x=1745969809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcRHQvphPQn4CUi/TPisXUxRxZEAhcBM8wzHtZBA4KA=;
        b=axz5MdxNBXoX1Xd3ESyYEGobuL8MK8l/0PR3KuCPWvWH7i2IqkNqRSXc6ZHu9NeMTo
         26Ob2yvmMFu5MV27EEBC7NZrm2/JADnhFvkjdCNSBkNVialVELPCuJfPgnzl28gprNst
         mMPogyZ1QK2zIkIo6/Lpkuj5eBBML61KCi5ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365009; x=1745969809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcRHQvphPQn4CUi/TPisXUxRxZEAhcBM8wzHtZBA4KA=;
        b=WLXGII23AcwG50aWNZSHfxl1hqV4P5XlReyRKWHIqpfEyp0e5V3/Yo2i0tYM4UcOVe
         7YPd+TbxObU7bwElhQaemjvBj/cgz7a3tL+vQnIme862cyViy7vL8QKyDsUkSpMmoHA3
         Gk3iUV9bdddjEawn8haSo6r+Dvh4OXNpqrRicgykHDfiwcZ9/n8zmTRMtiQ3tU81q5BF
         FRTQLb2NQ+KbXfhmaOfUw2070QCrPBGvthwC71r5w/UV1b+aaC032RfwJ87D6aM48IcE
         gRbFX8Q03sbwOycSfkRLjiRrGSXh5ACp5SJx6juseVfb8L0mjXk7FDFYJv83AG0yKUu7
         0PQg==
X-Forwarded-Encrypted: i=1; AJvYcCUqk9EIcpYSZSsOJIPMpIyFvuWNBdh4zBkYTlUWSrfWPosalu2G7x/5FjpGQ9AVZHeQgi9oYaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1XW5wGtBy3vZMzX8jXlcGze47lMl/ePVKF9q2exnk+64BRgw
	+tEwcAO46BsT7y9lIFhCEbjpN9mOxKSW/d91n2qCvIW0cnSs7tScf/HWopP9kw==
X-Gm-Gg: ASbGncuQjNJQNDkhb8heFsJsXzPyxX3/BHvMdH9qsi81kjsr1nfljE0I+88dyoCMVc2
	svpoSssosuaoV7D9dLzf1FukrW5Swjrf6PiSAACg9wz8a5WwJPky/8bRxJeWpPzS88FAKsILWwb
	1hUB4+zYrcUWB7PmsTd5+b1FHxcjmMePiiKt+dAdMgLPkNHu5M3KS9tsMbgozPwWS5SXSqL6KLa
	VUU/V42qLnprBjeB0mGi2eOOfJ+J7cYgJ/GAzBQc7BTlbyXsp3ka6efjuBzYa2q3sKeEEoe1OH8
	XAdq/C/UlyxJArIuSj6JA0RUpMUksz4Ew07lT2UG4kOpYlYkIVrVBo5JK+piZg9Hb0g87orGO4A
	EkZ6dznrN+xTOOEGR4p6bvTxWOfP8
X-Google-Smtp-Source: AGHT+IFhDRCfBt60rvSifXoPbqKYD8GCY+Z4oAiyxrebKJVf2J/b3b6ULPnb6DYxozFbO+7qvNEESg==
X-Received: by 2002:a05:6808:4e1b:b0:3f9:c0f6:215e with SMTP id 5614622812f47-401c0a7af27mr9218983b6e.12.1745365009355;
        Tue, 22 Apr 2025 16:36:49 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:36:49 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 0/8] net: bcmasp: Add v3.0 and remove v2.0
Date: Tue, 22 Apr 2025 16:36:37 -0700
Message-Id: <20250422233645.1931036-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asp-v2.0 had one supported SoC that never saw the light of day.
Given that it was the first iteration of the HW, it ended up with
some one off HW design decisions that were changed in futher iterations
of the HW. We remove support to simplify the code and make it easier to
add future revisions.

Add support for asp-v3.0. asp-v3.0 reduces the feature set for cost
savings. We reduce the number of channel/network filters. And also
remove some features and statistics.

Justin Chen (8):
  dt-bindings: net: brcm,asp-v2.0: Remove asp-v2.0
  dt-bindings: net: brcm,unimac-mdio: Remove asp-v2.0
  net: bcmasp: Remove support for asp-v2.0
  net: phy: mdio-bcm-unimac: Remove asp-v2.0
  dt-bindings: net: brcm,asp-v2.0: Add asp-v3.0
  dt-bindings: net: brcm,unimac-mdio: Add asp-v3.0
  net: bcmasp: Add support for asp-v3.0
  net: phy: mdio-bcm-unimac: Add asp-v3.0

 .../bindings/net/brcm,asp-v2.0.yaml           |  23 ++-
 .../bindings/net/brcm,unimac-mdio.yaml        |   2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 176 +++++++-----------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |  78 ++++----
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   |  36 +---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  13 +-
 .../ethernet/broadcom/asp2/bcmasp_intf_defs.h |   3 +-
 drivers/net/mdio/mdio-bcm-unimac.c            |   2 +-
 8 files changed, 126 insertions(+), 207 deletions(-)

-- 
2.34.1


