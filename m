Return-Path: <netdev+bounces-117094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19394C9B7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4AB284A8C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2E416C86B;
	Fri,  9 Aug 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTdL38PK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBC16C6A8;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182155; cv=none; b=TVihvl1mX1y6ZH05kTsJR0TMXRxVW5nfQxOaxDWA9t+ER52fjPCNlM+sgpRW1Tu0QHkg279JsxnnaNLW04BOCDq2/Onaipzz2b/tiuUIx+Hg+o/ExBcl51kYRwzmMjzl0NDou0NlFbbjjqYYPtGVafT11nvoGvSGhdwXuvreEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182155; c=relaxed/simple;
	bh=1doFq/GnmGNBeEeQE2d1SwDuwG+592umTPSGO46ePAc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bVNoxc435RupQTdWB8YbPGxjg1c1F3CKh5wloX4hujPn89f5Aye9Ma/puSldYAPlWTTyzjE9FD3SzOBxcDrFddgp0IaWuvErWf3pCWsBekTGcCaqej7VFp2qj1X7i/qFoV7byyGSeCk94aupejtoyP4I+xgP7hKcSVxDSajXXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTdL38PK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ADE3C32782;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723182154;
	bh=1doFq/GnmGNBeEeQE2d1SwDuwG+592umTPSGO46ePAc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OTdL38PKhYm4sOyLxc7jlPF8pl0ijZ0epkE5SAsa7Tf2QBG2pTYjYD7H6hsDZ0tev
	 TA9c+Z9C7I9GhPjnSnviSdDygbYei8gzMDPrWOGKohXk8MVgcS8jkimvzd5bybE8DE
	 t3rl+QUYRxCtxtgaS6IlEg5lT/W3+w7auvBQU2KFP2F58abdeWK5Vk4/QiKuLQOdDa
	 CYCDPvdTibcfjrWoJ/LZzOxRI3c3YsPFhZanO/0ddiPMAtmZ6HDvyrExLk9+QQ9aMX
	 8gL0vyNLM7pAU3A+DQ45QJnoL4DI62Oy8eoqAU/3dUEXn4NlqvTp/pozw5rmrfUHYm
	 28cqbnkGokaFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F094C52D71;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH v4 0/3] Add support for Amlogic HCI UART
Date: Fri, 09 Aug 2024 13:42:23 +0800
Message-Id: <20240809-btaml-v4-0-376b284405a7@amlogic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+stWYC/2WNyw6CMBREf4V0bU3vbbGtK//DuKClhSYCBkijI
 fy7BZ/R5UzmnJnI4PrgBrLPJtK7GIbQtSmITUZsXbSVo6FMmSBDwQQoasaiOVOvS2lASxSFIWl
 76Z0P19VzPKVch2Hs+tuqjbC0D4Nk+dMQgTIqPeRcea2s84fUdlWwW9s1ZHFE/OLezxETB1yjQ
 YcAiv9z/MMphi+OJ65UAMx4rXf852+e5ztXixtvDAEAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yang Li <yang.li@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723182152; l=1806;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=1doFq/GnmGNBeEeQE2d1SwDuwG+592umTPSGO46ePAc=;
 b=0q9QHXQQT+97DRCpC8JpU+3Hk1di8rDs6Me7TZ2w+4gHo9wNNFlY8IT+DNFYpcl08yRf1ruKq
 7PIGy+afjfhBVOZqjzbSyfXYQgkgWcuM8kgr2UsdqpfXmeZHP1NL/dn
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

Add support for Amlogic HCI UART, including dt-binding,
and Amlogic Bluetooth driver.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v4:
- Modified the compatible list in the DT binding.
- Reduced the boot delay from 350ms to 60ms.
- Minor fixes.
- Link to v3: https://lore.kernel.org/r/20240802-btaml-v3-0-d8110bf9963f@amlogic.com

Changes in v3:
- Updated the properties within the device tree binding file.
- Remove the "antenna-number" property.
- Performed code optimization for improved efficiency and readability.
- Link to v2: https://lore.kernel.org/r/20240718-btaml-v2-0-1392b2e21183@amlogic.com

Changes in v2:
- Introduce a regulator for powering up the Bluetooth chip instead of power sequencing.
- Use the GPIO Consumer API to manipulate the GPIO pins instead of the legacy API.
- Minor fixes.
- Link to v1: https://lore.kernel.org/r/20240705-btaml-v1-0-7f1538f98cef@amlogic.com

---
Yang Li (3):
      dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
      Bluetooth: hci_uart: Add support for Amlogic HCI UART
      MAINTAINERS: Add an entry for Amlogic HCI UART (M: Yang Li)

 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  |  63 ++
 MAINTAINERS                                        |   7 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/hci_aml.c                        | 755 +++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c                      |   8 +-
 drivers/bluetooth/hci_uart.h                       |   8 +-
 7 files changed, 851 insertions(+), 3 deletions(-)
---
base-commit: bd0b4dae74b0f0ee9ea37818e1c132b56a26d6dd
change-id: 20240418-btaml-f9d7b19724ab

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



