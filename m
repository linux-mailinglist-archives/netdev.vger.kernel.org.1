Return-Path: <netdev+bounces-115273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A1945B38
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AB41C22745
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93611DC486;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0vO8lXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731141DAC51;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591625; cv=none; b=OBaqbnzZvwCHP4kNCl0JZ/8+2x+jgR0MFnctWp7hMbQU3kVVqU72xG/o0PaJmsf8fBARjcwMwNBx4H7qioW0BP9LERGSU4MisiVyCeFDfwwz2VmGVkBMu86oYGQ3uQEsCW3yDUXETQh1uBV6qZv6fc7YP9sCOVJ6tSJC2UIJV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591625; c=relaxed/simple;
	bh=CWclPJ4pjk4LvCG6DZIT3d/BBZcJRSdZLLIzy3xSXx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lKyMXfmiUyCMipi4F8SCxAP9XV5T6maBM2lCJ2vKNxoLX6A6bgvkEw71YiuP8GMKZfrWRvCVAdH4u/TDl/oD/MXrPXdmR5pdClu6ulqKf771oUDsGG/5MdOh1gqbcI6dMgOwNdj2bYW8IUfaCrA2zOaN5uafBYGr8twubkL+uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0vO8lXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E293BC32782;
	Fri,  2 Aug 2024 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722591625;
	bh=CWclPJ4pjk4LvCG6DZIT3d/BBZcJRSdZLLIzy3xSXx8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=f0vO8lXKHCwv8gzlQTZTd+RhyejY7a/1SqsoseF/EWxFZLW7LeGCDuBotpYHWlW+6
	 GcXG73OqhOVDcB9G1bDICfFIs3LxOCRgp2+vMibpPtK2jAds3C3JdPShJSKCPZjGRk
	 XDUZVyznOtHDj70qvZrX1eUPir1FPVOgMuQQIwnodMvP+pQI10wFnEYn6ZfIfORKGR
	 PR9k3CSIiLOxPO5p4sjDlRhdaPLYuWtikHpGkINxRgEybitsQwBaCMaahyOvDtalq4
	 c5UmDoV9S5f8nSAm5h95WZcbxOXxKyZWn1/v/B7sqLHf3LdA9DILXpnjuLfYUaGFZk
	 mlSM6WIOwguLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC92BC3DA4A;
	Fri,  2 Aug 2024 09:40:24 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH v3 0/3] Add support for Amlogic HCI UART
Date: Fri, 02 Aug 2024 17:39:46 +0800
Message-Id: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKprGYC/1WNQQ7CIBBFr9KwFsMMbQBX3sO4KBRaElsMNETT9
 O7Saowu38+8NwtJNnqbyKlaSLTZJx+mAvxQETO0U2+p7woTZFizGiTVczveqFOd0KAE1q0m5fY
 erfOPvXO5Fh58mkN87tkM2/ouCNZ8Chkoo8JBw6VT0lh3LmvovTmaMJKtkfHH+37OWDzgCjVaB
 JD831vX9QXt1AZl1AAAAA==
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
 Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722591623; l=1589;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=CWclPJ4pjk4LvCG6DZIT3d/BBZcJRSdZLLIzy3xSXx8=;
 b=x4vT1adzcphYX0rrutz0CZCP/dHB/HZkjXhHrk8E/y/uNjJi7MiMFh/ChVMNIpDuTz3UhJf2n
 mbxzV5P04axBWe33fisj9pxvwqNDQdjLEhcJyEb9YDhdNyWrcPNRjJ6
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

 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  |  62 ++
 MAINTAINERS                                        |   7 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/hci_aml.c                        | 756 +++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c                      |   8 +-
 drivers/bluetooth/hci_uart.h                       |   8 +-
 7 files changed, 851 insertions(+), 3 deletions(-)
---
base-commit: 2360f368524bb817b71bdd2efed53d0c3c3929ad
change-id: 20240418-btaml-f9d7b19724ab

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



