Return-Path: <netdev+bounces-135852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8099F6F7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3C81F2400C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2581F5833;
	Tue, 15 Oct 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pIM66skt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B91F80C7
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019834; cv=none; b=q6NE3CqquScl9u5ENTOR+eUrTgYaV2fm4tV2EkGTCSqvAXkixmjJgEez13v7q11wO2DuOunZCPRzcxLtwHZWUP1ET0RLfvbSBAvXWSfT1G5kpsjzMy2jtJA0EFJ8uJgAqFzAvhgzWV5+hwZhqUviC278cn4aQqL6CN05c9ofEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019834; c=relaxed/simple;
	bh=GtxskHIkNO8eIMlbmj3L18RvHD/mDf4rhq6VhZfNIhg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N+6o/h1BIQXOuKaZd+8WYhj7D3vz6R1sq8q+1y8K53FtdtPIs3C/Rhoy2+5OV1wWRrjIs6qA+mMlebo2PztYC1n0jRFKDV0Xj1M9tx+q6Od1+4ohJoCxVvSaLn2TRBRaBuLRLYEE7HQLdy7CZ8jGA30Azz9ZXd6BysUqt0fWUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pIM66skt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3110b964so48241441fa.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019829; x=1729624629; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QOt9gzhjBA2a3HFdFsXGU33uA19Bo/pjPie57KuItA=;
        b=pIM66sktmjzhUfw3t3umMEUzNH9Dg20UpUDLKKQkiDOH4wMc4/XclAyRcn6ekBVpt8
         X57s3NmJAjnCRQWwZtS9gZ2ecM1hCQWwycln8lQOKr6yx1IcOJ8cL5FUSZOf/anWQjs6
         m47YawE8qlOneWdz7o3wSPQ5Km3oUFf1GWhSwmQnbZMIlNdugugClbR++xkDd4WNL6mu
         P3ltqXli3tr1vp4VozZOPS0M4ug9K9T4rE5JJpUtQBDmzFQGfQ3BZriu6Honfm0vQekn
         XNENwV/QddxluQ9d7vdZ3+fvuX/XojA+PAEGfHItyQGcWAkJgMVWIJP+XET6HgLjBgpH
         sCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019829; x=1729624629;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QOt9gzhjBA2a3HFdFsXGU33uA19Bo/pjPie57KuItA=;
        b=IiC8fHJm4R04Q9df9xONsemkQZhuQgNeIu3uDXr3E2y/WUZQpE33bgX7ME8+pXRTs/
         MYXe75K+JWPYt2TCWPMMvS2uJgf3ng7Avo22Tg2NiGbr7Qs15ZhpD7gt5y3cs9ejCd5U
         6NEmaGBmSelPEc1g2cm5tK6sUCM3hcEvm5QW4PcNp4a8GuOSNXIFYj0AT8CW/b9qtdHB
         Dbo6LomALsoU0NHsWfPiMlRg1Di159Q15rZ+BO7BabsBkZRpoW+thjNd5ldS2IsV2kcH
         m0nLqoB3riXn9q90bBbv6qHwn3+tyKrmjOi5dmL0YrsD0YxXli/dWmp/qrLWw/LJYlRu
         kXxw==
X-Forwarded-Encrypted: i=1; AJvYcCUnsWddsEIA/0ofMyltxXtEcHdDcoe0hHoXNWg7a0nulYVrR2ypuEWk+U/R2OCjmp1t2K9DNng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKUiTHIVg8kq6JDP4GdHJAZeIkawfv9coWxS9QDorpibQa3v2
	YJCUyfeYMFqTZCE7d8/feINjBQs9amz6eUgM7NK2XtGeER+ISHW21HvzZm3h9XI=
X-Google-Smtp-Source: AGHT+IEZfN9DftNPsDmwiL1MDACcRsbm13jb32Ds2T5xIid0qTiIYe5LUNFD+F4+u8zsriFIRIS1Xw==
X-Received: by 2002:a2e:6119:0:b0:2f7:5f6e:d894 with SMTP id 38308e7fff4ca-2fb3f247256mr48275281fa.25.1729019829277;
        Tue, 15 Oct 2024 12:17:09 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d7b7a96sm973002a12.93.2024.10.15.12.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:08 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 0/9] can: m_can: Add am62 wakeup support
Date: Tue, 15 Oct 2024 21:15:54 +0200
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGq/DmcC/4WNQQ6CMBAAv0J6dk23IFBP/sNwKG2VjUJJC1VC+
 LuVePc4c5hZWbCebGDnbGXeRgrkhgTFIWO6U8PdApnETHBRIOcSJjeShl6rAV7qYecRgpu9thB
 LQAG1RlNKmWNrapYio7c3eu+Da5O4ozA5v+y/mH/tL434Lx1z4CCrk9AVFsqguLRqeVLr7VG7n
 jXbtn0A/Jw6388AAAA=
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
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4405; i=msp@baylibre.com;
 h=from:subject:message-id; bh=GtxskHIkNO8eIMlbmj3L18RvHD/mDf4rhq6VhZfNIhg=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59jfZFzMe9pvWeqfu5rqnVyrLZW9q3/3Mety2Kurpd
 sGoWIfZHaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBExP8yMmw7ePPaknmR3osV
 Phs8ONJWIGZ7gT/8Ds89m/MVdx686tFj+O+3Lea4qF762avLgy11vra8qvu1NXqxO7tPMoNR9f7
 NZSwA
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

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62/v6.12?ref_type=heads

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
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com

Changes in v4:
 - Remove leftover testing code that always returned -EIO in a specific
 - Redesign pincontrol setup to be easier understandable and less nested
 - Fix missing parantheses around wol_enable expression
 - Remove | from binding description

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

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  22 ++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |   2 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |   2 +
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   2 +
 drivers/net/can/m_can/m_can.c                      | 117 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   4 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 9 files changed, 152 insertions(+), 9 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


