Return-Path: <netdev+bounces-112014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80864934914
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25EE1C218D4
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CFB77F08;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyYL68MF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE93763EE;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288577; cv=none; b=iTd7GS7irmvWwNK27N3iQ1sNA3zHpUhoFDAPtRNKiku/EtS3QbDihJajfliO3KUclqQFyHHbssBQsYSHxkcpA0qb7gODKEtkz0ZlN0UVaNXDx7zIP2VcDjSHWzK/pNYpA5FbLc4QtpC9NgWrEIZfo8sOj3GklsGH/uLJRajY3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288577; c=relaxed/simple;
	bh=McKO7a2Y9X5UuWrJvOXo6XzO6tf+ZBq08Na/c5RO+zI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bPmS/kS19zb8sJA/+7GnePasxW8PRlW+ZrH0RnjhGScrDLrG8AJ9TC8AkUNKOVGCTBzPAq39SHIwhM9HDDOqKNh6UTHp/rSD7ICk9KcoOOVh4hoOXLJlncKO5OlMvd6DuwUQDe3UV9q32bACVUjsb54eK822ny+lWOAzUkBTrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyYL68MF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DCE6C116B1;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721288577;
	bh=McKO7a2Y9X5UuWrJvOXo6XzO6tf+ZBq08Na/c5RO+zI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iyYL68MF1S0LvsDrkCN9wdDVBzCz2X7MmT06y2MuWP9GsgLALmO7ebL4j6YKA0n/y
	 XGZ89Xf7C0C73EL9NzJoJ5gHF0Q9GJAczDX/AwSGQQHYrxGzK4wUEHNVrtkrIgy8av
	 Nrh2wegio2YIk/WURHdmmZHjamf7JyvYaOBtC/q7eM4b3UPXhCbSsERMrMWdX6l+Fm
	 JQEybTVxLrBJMCfjrWwB+tPd2/LpCUqKBrPG+yFuraEW2ettzpWRuB8s3M13YCcZjW
	 LCmZRkFgxDXs9uABRyv9jgpVoN+MhnJl37LnHEhAF1V4Mx3XIYPfC9Bvg8Jtn5NplI
	 GhhTSuH1+no1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E186C3DA49;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] Add support for Amlogic HCI UART
Date: Thu, 18 Jul 2024 15:42:18 +0800
Message-Id: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFrHmGYC/y3MQQ7CIBRF0a00fywGkAZw5D5MB0Ch/YktBhqia
 di7WB3el5ezQ/YJfYZrt0PyBTPGtQU/deBms06e4NgaOOWCCqaI3czyIEGP0jItuTAW2veZfMD
 X4dyH1jPmLab3wRb2XX+CpP1fKIxQIgPrLypo5Xy4tTVO6M4uLjDUWj+mDLEinAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721288574; l=1309;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=McKO7a2Y9X5UuWrJvOXo6XzO6tf+ZBq08Na/c5RO+zI=;
 b=yaEHvInkvweHp4KULgQoWMx2FfK9VIzp24xUAWtkczpAXykd9ulVlbDUQyyItoTFFdlqpTF+R
 3LBUXfXOZtFBO1nMiiSc+rH13F9K6ssqRZO7fZnUFROqioIQsgUg1xr
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

 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  |  66 ++
 MAINTAINERS                                        |   7 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/hci_aml.c                        | 772 +++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c                      |   8 +-
 drivers/bluetooth/hci_uart.h                       |   8 +-
 7 files changed, 871 insertions(+), 3 deletions(-)
---
base-commit: 54dd4796336de8ce5cbf344db837f9b8448ebcf8
change-id: 20240418-btaml-f9d7b19724ab

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



