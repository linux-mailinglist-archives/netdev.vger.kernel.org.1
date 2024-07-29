Return-Path: <netdev+bounces-113532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E314593EEB0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 09:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111851C21B86
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893D12C554;
	Mon, 29 Jul 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v7Ax4XJP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372412BF24
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238921; cv=none; b=s+vt0H1XaiVJW2o8i4YQijPM21mgWXVEaiJC6zTiXAzWpgqX2AE68Z6v09/5GH3tPvwCv6D39jErxr24fDKNc93KXk7/AsCrdJSsAwD2Co3JPnqqttAohhmqTlz/0QWOsT13WQmNETOlRiDemehvcZjW8dH/Kbh4zzYFzXglD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238921; c=relaxed/simple;
	bh=+vSedTIJ1OUukY8BR5U3p4j7kIo+5KSENyPdSll/8SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBEaOyCBbLk4X1ce8AiiVGOXmuT12X9YyT+Bith76PJN/WconciGLyem55shjvYUkTJ3eCGQEC2AvpzhiksnM2QQ5Gox8jVtq8Mb9iGKvek/2G18u2c416bTuFpktBByOoB/V8gCnB+3AEwzVmzSwyPvuCCbq4riih1u0JPdR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v7Ax4XJP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42819654737so8470215e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 00:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722238917; x=1722843717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fG++Rp1WwVAjFqGrg10cLveRKjMmHByvEed2FpGCSg=;
        b=v7Ax4XJPhWbf85Pbj+AEPmglfY02V8HnWxBvoyC88Z53yOO1An2xNo+31AczZAviu4
         7tLmWNGi0WDc1h4hc+wp5PCOV+gNkNfQVEgKJPj0AC7GmbuUIUi3YBqMoxt+WGSoFdSc
         jCRv+i65gBP4Fq5OZrfusnOwrQxi5T8WAY+ZU9MjThUuF2pAWxLV9lS/V6BXzxmFKzKz
         /nPS2CW0YLno/KBgp2YQ4VnBceYXNc0Cdv2whc8tXVp2AAkPRucFEckKwSaS1ZlhMDLj
         Eqkl0RKD/l8HM0T13ZPqCZK+9Zga+TuR/mHvDCssVp4EOHSpBez1HuHqy1mJcGzRH+O0
         QBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238917; x=1722843717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fG++Rp1WwVAjFqGrg10cLveRKjMmHByvEed2FpGCSg=;
        b=LCfaHNPy96YW5kdkQqN6/zYM96sR8aejHA17T7pMfQnyhq4TpFqb0gWfnsjMFuozYs
         YorDyDX5o80l+ieejvUlv7Z0qkEvm3wVmOyZsczgmfJteo0oFKZskWWjj4MFXWfILAAY
         pfAzmUpze6QpVrsrRlQCWpvY2QMALRrBqdVJkzKgviFJAuIK8G+prTjnNJ1dVfS9CfXC
         c7kzQUAx+P3aiaDJhNdCEXIUCAeUfZaKdFgWh+7r8DrbdkPCJxcNYY9HSq7lFZ65K6Zp
         BoJhbzYlgrXY573L80WbVWh6i6cnktr37d/vHIY1MMsQr96be+g/qxlB7fuHj2KbzHQh
         QVhg==
X-Forwarded-Encrypted: i=1; AJvYcCVuNTYrtnWtMT2P3dB5fG0mqP4fsF9Y1z3mO8k61aGSIVc8U/yiRpYNjgjuPEI0cIUCzSULaUkSZaUqalfRNj+w7gcQCwVg
X-Gm-Message-State: AOJu0YwI9z52vRXiD9MO0yvGzg4G79eR+JXWF35DZWS0rIE2ffL331hq
	g5fwAelL2PDO2tXPZM2ER6u7Q+jwjOvA92Wle7UG0tKnydx+L/A2hRAvChQLNcU=
X-Google-Smtp-Source: AGHT+IFblJNxmGbt2ldL4Tt9ANm4+7yXmdnl1pp7GhCtq+KapS++Z5zXICBriDeelTZ8BAc59kEoNg==
X-Received: by 2002:a5d:59a6:0:b0:368:71bc:2b08 with SMTP id ffacd0b85a97d-36b5cee3038mr4752651f8f.3.1722238917146;
        Mon, 29 Jul 2024 00:41:57 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm11460879f8f.109.2024.07.29.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:41:56 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/7] can: m_can: Add am62 wakeup support
Date: Mon, 29 Jul 2024 09:41:28 +0200
Message-ID: <20240729074135.3850634-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v2
--
In v2 I mostly fixed error handling in this series and rebased to
v6.11-rc1.

I also dropped the omap serial series for Partial-IO as it can't be
tested with Partial-IO at the moment. The code was tested with other low
power modes but they will be upstreamed later on.

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

It is based on v6.11-rc1 with this series applied:
  https://lore.kernel.org/lkml/20240726195944.2414812-1-msp@baylibre.com/
Also available at
  https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-fixes/v6.11?ref_type=heads

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
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-partialio/v6.11?ref_type=heads

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-lp-sk-partialio/v6.11?ref_type=heads

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

Changes in v2:
 - Rebase to v6.11-rc1
 - Squash these two patches for the binding into one:
   dt-bindings: can: m_can: Add wakeup-source property
   dt-bindings: can: m_can: Add wakeup pinctrl state
 - Add error handling to multiple patches of the m_can driver
 - Add error handling in m_can_class_allocate_dev(). This also required
   to add a new patch to return error pointers from
   m_can_class_allocate_dev().

Markus Schneider-Pargmann (6):
  dt-bindings: can: m_can: Add wakeup properties
  can: m_can: Map WoL to device_set_wakeup_enable
  can: m_can: Return ERR_PTR on error in allocation
  can: m_can: Support pinctrl wakeup state
  arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as wakeup-source
  arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as wakeup-source

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as wakeup-source

 .../bindings/net/can/bosch,m_can.yaml         |  20 ++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |   2 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi      |   2 +
 .../dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   2 +
 drivers/net/can/m_can/m_can.c                 | 100 +++++++++++++++++-
 drivers/net/can/m_can/m_can.h                 |   4 +
 drivers/net/can/m_can/m_can_pci.c             |   4 +-
 drivers/net/can/m_can/m_can_platform.c        |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c         |   4 +-
 9 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.45.2


