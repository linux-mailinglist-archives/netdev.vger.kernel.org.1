Return-Path: <netdev+bounces-116095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED494919C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FB6B23AF4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD31D1F76;
	Tue,  6 Aug 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFNrbT3F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA31D1F52;
	Tue,  6 Aug 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950904; cv=none; b=ZJ8eWi3a94RWinU1eG9lkqmF8nqiFmsncNZx7PtFOYBM5Phc4G4qHNiRd52jOgqxgUMe+zXoWLpBaK/+BijwJa9zZvdhXwJZQjB/kaGqH339tVOavCu4m/lBXRAU+xaAFvU3/b7lAu1/pt/4SmT6oakaDD4MhZ87SoI3PAONuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950904; c=relaxed/simple;
	bh=FgWKi1Gnb5JFoFlrMb1EsfWKD+ToCo4W60+JCXA3pqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nm8KAmQToq0bnp+oUQrPfEhi+whZrgj6Zw6y+9SVN+ikI29o8r6/EmSbISiH4XHRW6Rp/Sey07Z3ituYvnv49CPMH0a/Bk0O91pjJuHDfYD3W0pAirxPU96QNM6xE4hWoQqnHFoZaq/UwXiHpPVv2ul4A+eq2tRUZIkkvCqzBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFNrbT3F; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f040733086so7833681fa.1;
        Tue, 06 Aug 2024 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950901; x=1723555701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6pVyMvtl8KE6yUdCoRoqyMAV95L9NT5XCcL2mYypwo=;
        b=TFNrbT3Fet60M1TvdJ+tEOk8S236wP9R4tmw1aFwEPkaE6bJD1yn0IICpp/1e0+8Ox
         9jyAh9N4FIOUXYgeOawwfSGrNGPdvX3UispAYmsyfMPrtc7POWMa0FUQ4EibIIGa42GP
         YvKzl/NpZO3tTe2oIFyJHLg/Rh6dgB1vrZoY20OMqcX1W+ybetFMEdNNHx8/gwGx4Xte
         PZEEcttXNltW8/Q99oqslotQ9imMEs9j1E2fQnpc2KaIrED+ZzXuwAY/Z5QHwvm23yAs
         zg9ih3guSNYWkqOq9XQHg5HN9RfnzrYrC+pUvcITUdMx0usNnXIORacXhECTQ9d/1+K1
         4WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950901; x=1723555701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6pVyMvtl8KE6yUdCoRoqyMAV95L9NT5XCcL2mYypwo=;
        b=ZNVZqQbzCqAyxWf+3+t/sL4BEQ9hIAQ8pQSc8ajOm24SIvgk+1Iz6xDpBTg2D3lNlR
         mqIECl/jWDJo9KERCOuzpWvAlCn6IcEN8nPb5NH+NdK/Y+K3BsBmVHklrskL9EUXjHvI
         Qxqz23nPT4Hz2pE01RQ3TU4IxfD+nd8H0CZmBSkFeAxLX6X3RBQTn9WJCAB9RsKkFwxk
         c2wvRfBaaEt5PpQpZjNI4HNhJo0VZgFllBeBXhEzz2zndDho+L3yNgixiZiQVx1SvGbD
         HazzmjS5O+qNx8j02UkNK2y6j9xhtAz7fC7RIhB8iAljKP7SlBGeXwreRr+39Bau+xkO
         kPDw==
X-Forwarded-Encrypted: i=1; AJvYcCU++KtMYMS/UHWa2GzlDLHQnBE099gf+nkRRVO6jhdGCKR6B5A1ZCkU1Q19yKsUZPODO2rZ6yyZyuTZrZGsTUXLMvMvwGC6VLh0OcBhkfsio/VlyJmnvUnq9nMx2X6PGm6FIhGcgNg5jFt79/iI7NJowMbNCpbiBltfsG5XZNnFdw==
X-Gm-Message-State: AOJu0YzKNe16QNEU2qLOVazSDu2iNjhdC59g4ZJ9qgXWIz0rvvTEef0o
	x6WJWmBd0ZqvnF6g2V1OpeEIxmBH+KUnN9Ki0xe1vB1pOTss0rav
X-Google-Smtp-Source: AGHT+IH7Z6IrVx/WW+2TEoBllCHiUpkOqSv3MvKUVwBEKYJuGe/tKKZDSRVwQUGtr5muMVCgGLm2WQ==
X-Received: by 2002:a2e:87c3:0:b0:2ee:7bcd:a52 with SMTP id 38308e7fff4ca-2f15ab53020mr95966751fa.46.1722950900079;
        Tue, 06 Aug 2024 06:28:20 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::102:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f77sm5910172a12.53.2024.08.06.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:28:19 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v3 0/5] net: dsa: microchip: ksz8795: add Wake on LAN support
Date: Tue,  6 Aug 2024 15:25:52 +0200
Message-ID: <20240806132606.1438953-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add WoL support for KSZ8795 family of switches. This code was tested
with a KSZ8794 chip.

Strongly based on existing KSZ9477 code which has now been moved to
ksz_common instead of duplicating, as proposed during the review of
the v1 version of this patch.

In addition to the device-tree addition and the actual code, there's
an additional patch that fixes some bugs found when further testing
DSA with this KSZ8794 chip.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v3:
 - ensure each patch separately compiles & works
 - additional return value checks where possible
 - drop v2 patch 5/5 (net: dsa: microchip: check erratum workaround through indirect register read)
 - add new patch that fixes KSZ87xx bugs wrt datasheet

v2: https://lore.kernel.org/netdev/20240731103403.407818-1-vtpieter@gmail.com/
 - generalize instead of duplicate, much improved
 - variable declaration reverse Christmas tree
 - ksz8_handle_global_errata: return -EIO in case of indirect write failure
 - ksz8_ind_read8/write8: document functions
 - ksz8_handle_wake_reason: no need for additional write to clear
 - fix wakeup_source origin comments
v1: https://lore.kernel.org/netdev/20240717193725.469192-1-vtpieter@gmail.com/

Pieter Van Trappen (5):
  dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
  net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
  net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
  net: dsa: microchip: add WoL support for KSZ87xx family
  net: dsa: microchip: apply KSZ87xx family fixes wrt datasheet

 .../bindings/net/dsa/microchip,ksz.yaml       |   5 +
 drivers/net/dsa/microchip/ksz8.h              |   3 +
 drivers/net/dsa/microchip/ksz8795.c           |  94 +++++-
 drivers/net/dsa/microchip/ksz9477.c           | 197 +------------
 drivers/net/dsa/microchip/ksz9477.h           |   5 -
 drivers/net/dsa/microchip/ksz9477_reg.h       |  12 -
 drivers/net/dsa/microchip/ksz_common.c        | 267 ++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h        |  31 +-
 8 files changed, 385 insertions(+), 229 deletions(-)


base-commit: eec9de0354105527e31394c0ed4b8c54fb1fe1dd
-- 
2.43.0


