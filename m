Return-Path: <netdev+bounces-134584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626A99A4AE
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE3E2822E3
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B522185BB;
	Fri, 11 Oct 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zJ69IH9R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68801E502
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652682; cv=none; b=N61ZD37gB12H+wXGihzM0nVmGqvMTy2KJaMRV65sBoF5MUOKIV/foCRtOBEkJIAzzEFjDs/6L/nSMw5MELNeK8RQgLMTWTyQFCOT2lRoORIwmL0Bsuke1X8PEdMnP5fah4lM/UCCS9YV9ew+ybEjiDpIwkpCUMWQ4onmBj2Es1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652682; c=relaxed/simple;
	bh=AmDAWkwPTrSHqB94gNRQX6L8AQLPkbqcCXyEv5EfSaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SobkQkcTxS/U+XiEnKQxgSbpadRqrKTyBhL1aBkDIzdit8ucYQpV6lCkxTz4h7/p0Jpq81Lu6oaPh4T8ra9t2q3JXezFEW2YiLft3GpStCzWlUtMbcx+zbjnIWpUjy5b4lfApSPKDslaffHDWqmOnw46t5DRWG/p429tmoUpQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zJ69IH9R; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9950d27234so291192966b.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728652678; x=1729257478; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2TKGyJgT8HCzMKkLqirvkE55tzEqlmM1NvvlVJgJKA=;
        b=zJ69IH9Rzy8nt36J3EwRy4B+SJRfDjWNXWu0S8uz2DU/Ibm2n1VtQz9FluFyq8Cdur
         DM7HVHB1TrLX0+9DqKGXiUfp9nR2Yz/MudsgTWgACXYKkFpXITj6SKiIhwbYud96MzGm
         3yJezBlPv73iLx3Ncfn9Vihfk8EcnZ/JARUBtIqUG5Qh+usbf6BbOsGyl+gDrG66aqye
         YBd76+ux/6Yv9DUwV+6UyodgbzTdkPhsNZFw6c/kdvw1b9Vs0S9sZRckVEcXPv3nMgDd
         iYDTCzGV687e13fbDtjkT18CpnrSe/9/8IeC+YbjY1Yx/ylua9TgImLldwLSwEXLFSKF
         pe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652678; x=1729257478;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2TKGyJgT8HCzMKkLqirvkE55tzEqlmM1NvvlVJgJKA=;
        b=G9qgyqokQKtLqYogHlNxxABmY/LWytYZR/1V7Exg2/IhKt0szgJwNUzrbyzi1h+pLy
         e97/jwVZMEVOs7ZsqoeL4x0QzKss8aakLHylJ1+CppFWwnW2C45tPkT1vzTTs0+xlXJm
         qGdNcx+DW5ysO5AKj9d3D9z8jMhl9/brr8ZjAJk5XX3oEAkSn9xnG4WrJaxjMiScQm+t
         LyiHo659EOc5iJGAAh667XtXgP+tYGwgVHwF8XzZt43fU1xDGiRQfbUUA3hg3EPRAlFV
         q8f2/3AaeyuRjalBsaCb/91ztNUmK/KfcyhMxJtprYXQVVw0Bw5DYzn6xyCMjLrpCxge
         Z7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU2mIAOb0vnW6XJ/waMG+dbwcUyDm/7wqYEEVv0pVf0a6AEjvHrAZI5ziIrIvbqmzai4Xwf0fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQaM2D+2aIlaW6K2Jio1XCA6L7FtVWTGDo10EYlTKyXx9iRzZ
	zm/JgnsuL4kojs5lg9YQYXzUQemPpMX6X3q8lB+T6tEwUUCGTq0lycxHiG/m+Eo=
X-Google-Smtp-Source: AGHT+IGKlXmjraErc8Ifbvkc14cGgVhYhFNKvbvyQPD7iVKNrtUZ8LzVrO5D9KawbCRnHnd0GlMvNA==
X-Received: by 2002:a17:907:d850:b0:a99:8ed2:7e51 with SMTP id a640c23a62f3a-a99b95a5eaamr218199566b.53.1728652677943;
        Fri, 11 Oct 2024 06:17:57 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bf9e8sm210562066b.98.2024.10.11.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:17:57 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 0/9] can: m_can: Add am62 wakeup support
Date: Fri, 11 Oct 2024 15:16:37 +0200
Message-Id: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADUlCWcC/x3NTQrDIBBA4auEWXdATQkxVwldmHHSDqUqmj8Iu
 Xsly2/z3gmFs3CBoTkh8yZFYqhoHw3Qx4U3o/hqMMo8tVIWl5iE8Ecu4O6+vCYscc3EuHWoDfa
 kfWdtqyffQ42kzLMc92B8XdcfBtFf/nAAAAA=
X-Change-ID: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4056; i=msp@baylibre.com;
 h=from:subject:message-id; bh=AmDAWkwPTrSHqB94gNRQX6L8AQLPkbqcCXyEv5EfSaQ=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNI5VQNerDo5vfx2/fdOL5lSxdv/mXOjF62ZxKtb4h/wU
 WN3zM+NHaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBE5sxiZHix3nOX7R8PF1Gu
 AGHGudrz/8ctkNirJjZJ4bL4+umPtPYz/PfcxiQr5XXTVXa9auxL74ZnKbe7D0/8JrD7/UeFHed
 CVzIDAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

Series
------
am62, am62a and am62p support Partial-IO, a poweroff SoC state with a
few pin groups being active for wakeup.

To support mcu_mcan0 and mcu_mcan1 wakeup for the mentioned SoCs, the
series introduces a notion of wake-on-lan for m_can. If the user decides
to enable wake-on-lan for a m_can device, the device is set to wakeup
enabled. A 'wakeup' pinctrl state is selected to enable wakeup flags for
the relevant pins. If wake-on-lan is disabled the default pinctrl is
selected.

It is based on v6.12-rc1.

Partial-IO
----------
This series is part of a bigger topic to support Partial-IO on am62,
am62a and am62p. Partial-IO is a poweroff state in which some pins are
able to wakeup the SoC. In detail MCU m_can and two serial port pins can
trigger the wakeup.
A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

This other series is relevant for the support of Partial-IO:

 - firmware: ti_sci: Partial-IO support
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-partialio/v6.12?ref_type=heads

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-lp-sk-partialio/v6.12?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Previous versions:
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/

Changes in v3:
 - Rebase to v6.12-rc1
 - Change 'wakeup-source' to only 'true'
 - Simplify m_can_set_wol by returning early on error
 - Add vio-suuply binding and handling of this optional property.
   vio-supply is used to reflect the SoC architecture and which power
   line powers the m_can unit. This is important as some units are
   powered in special low power modes.

Changes in v2:
 - Rebase to v6.11-rc1
 - Squash these two patches for the binding into one:
   dt-bindings: can: m_can: Add wakeup-source property
   dt-bindings: can: m_can: Add wakeup pinctrl state
 - Add error handling to multiple patches of the m_can driver
 - Add error handling in m_can_class_allocate_dev(). This also required
   to add a new patch to return error pointers from
   m_can_class_allocate_dev().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Markus Schneider-Pargmann (8):
      dt-bindings: can: m_can: Add wakeup properties
      dt-bindings: can: m_can: Add vio-supply
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state
      can: m_can: Add use of optional regulator
      arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as wakeup-source
      arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as wakeup-source

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as wakeup-source

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  22 +++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |   2 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |   2 +
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   2 +
 drivers/net/can/m_can/m_can.c                      | 109 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   4 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 9 files changed, 144 insertions(+), 9 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


