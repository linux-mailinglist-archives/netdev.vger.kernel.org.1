Return-Path: <netdev+bounces-153498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160499F853E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FA163375
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB21E3DF7;
	Thu, 19 Dec 2024 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dWZR6uV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD61BD9D3
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638348; cv=none; b=UJPI9zI2fEo06Ehjw5KBpnayrJH0O0MfoPhgAGKizKj+M/ysOQ269KbbXwaptNQQ5ndj2xUYjkoQ8dozUWXg9vPJ6by1IxvKvmPiH8y+1we7bMyhUpVie/tCd+UEzA+gzv+WoRLd4KxKj/R52Z97rtLt1bNDrksAjiGBaW9nFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638348; c=relaxed/simple;
	bh=FveGKuE50tvj//BccFVz6uTSoxWvQQAOqunJVHcMagI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ot16rrY2lgUhsBQoj4VA+jr5knYYmzpHipgILYZrdbRTYS9BLptBMFeduvPzWh2wMreVePt98kkJEr7ecv8SHxJU3ftY+5U/i8W9JYLWOueoWJ48HIxqyo2/1S7tHtBUwAXaFlt+j7CE2zyaZjrHYbhFhbPhPBMqSOLJNrNsQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dWZR6uV6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so1846278a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638342; x=1735243142; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9p15xFpI3OtdTaI4RI0VDmNj/jcCe5gDftH03DAkDo=;
        b=dWZR6uV648wXwrBYovXtQ6kaz1aFBsaeAaLhWbBGv4v8MpKI+9XrI94LHcZoDzi9DH
         VgP9qROFqFiu2Wmyulh5VoLDD6vIRobjTKmYPKPSInL0mv5CEGeEsJTmq1tueC8X7iWs
         ok9RS0CTEi7JpOG1/T+LY89YAVWz743woUfspsLb5ck5mol2F3+2aT/HL7v2mX+pf76R
         8hvyRRqTvHh1IOuHaRHTKFvUmLIZD1J2hXDnbTPeqzf6+dMcM80YPFJv3EteflM2/auX
         D2vzqZ8di7oiDfwlTg7mOYlrRSk29LG1xCkA6Uu72ihjNOSQLmIAIRpvLU7i9kvFQb8v
         glSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638342; x=1735243142;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9p15xFpI3OtdTaI4RI0VDmNj/jcCe5gDftH03DAkDo=;
        b=aU6Qqd+ZyeNoZxuvgPmR9Qs0FXVFvLXYzKhfS3nnJqSMyWhA1hDmLNNfK+56Ds7267
         ysiRjp48UANmzAr794PWDe8cX+1frR6EbrErbHGkmON5wLdNYXq9CdxP7/Z/DLtSTNRk
         9q8iD+rN6P1/NNjm2+Ma/2KLfyo0Lh1u1HhOM/6jMgVN4tsn+NYtwCUvLLwqAMvrcz7P
         l06eEChxT5LOqrzbekRlrw9TvuHzFr8wQRVOnbz3lPSUFPyqeB24SpMh1dKLWzFQSzAk
         zh6cXU+qFgRS6Bto2wo3akMxuGecOtsiiSu9QEWiwn6v5svd8VpDDq+o18xgHkKWSLyV
         BHng==
X-Forwarded-Encrypted: i=1; AJvYcCV0YYUTO3CC2FVBzrrPmZQHON3njwbXg4KwX5dN1MOzIsxy+0ubkgkdvaRCKKEkZNOLrJD4H6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvWk1FhAmSnxQBr3ZZS9PqPPynlyggtlJrn/an5gtFNyPOEPt
	dfCb5/a58430xu/SF54GS+pHq5iW1nSzsK2Qms5EfPLLdnE17n5VkIwMeFsvgF4=
X-Gm-Gg: ASbGncs9ZPxLrkeXr/NdlFbrNyN5EqKoxrFoF+rwxxL4EsPoJlas0yKMF7CE2hNkMXV
	9JNpn9L9TruS/g6W8CTfyM+ivviCoJMRgPVg6tVHy57RBJYeSTRv31fgjpik5owSolOPwfVlYJ6
	fQiY01055blQvxrpGpykjvTeH8+ZqGjHv7xYlnwx2H4sX/uvzf1BMck4XpsENu/V0aA4MCk9pqb
	3OAsqCGi3LZg8fBUiXkWPzsFllnA8HKQad0K0Ev75lOdoeysw==
X-Google-Smtp-Source: AGHT+IGqEgM3Ah4T+Wz8+r13B/J1am5wz00UoQzvYl0b+jCD8bk+TH5XawNEo4BvvQIWkA5//ALkXA==
X-Received: by 2002:a05:6402:4405:b0:5d8:16ea:cfb4 with SMTP id 4fb4d7f45d1cf-5d81dd7d02cmr168237a12.8.1734638342170;
        Thu, 19 Dec 2024 11:59:02 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f900sm948330a12.53.2024.12.19.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:01 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 0/7] can: m_can: Add am62 wakeup support
Date: Thu, 19 Dec 2024 20:57:51 +0100
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL96ZGcC/4XOQW7CMBCF4asgrzvIYydOzIp7IBYTeyhWSxzZY
 IpQ7l6DWKCqUpb/LL43d5E5Bc5is7qLxCXkEMca5mMl3JHGT4bgawslVYNSWjjHKTg4ORrhSl9
 8mSDHS3IMxQAq6B16Y63GwfeiIlPiQ/h5Duz2tY8hn2O6PfeKflxfNOISXTRIsF2rXIcNeVTbg
 W7fYUi8dvEkHnpp3sV2UWyqePBUf0buiMw/Yvsmqn5RbKuoNXsnaSCj7B9xnudfhM+X8XMBAAA
 =
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
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5191; i=msp@baylibre.com;
 h=from:subject:message-id; bh=FveGKuE50tvj//BccFVz6uTSoxWvQQAOqunJVHcMagI=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTqu6nMKw3LdWZeP4yk9//ndmdPGWVHU77pv8xn3+MO
 +Sk3e26jlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAigfsZ/udl+jY/5sh5OLXp
 SFTS0/6Wz8fmnf4ctnSx/ZQlnh8CVjAyMvw48n1ixt9dv642cT/vZ+UV1/k/yzr14T55ZYE9YeV
 ytkwA
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

After feedback from Nishanth and Krzysztof, I moved to a wakeup-source
property that can be a list of powerstates in which the device is wakeup
capable. This describes special cases like Partial-IO where the device
is powered off but pins can be sensible to changes and trigger a wakeup.

It is based on v6.13-rc1.

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
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-partialio/v6.13?ref_type=heads

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.13?ref_type=heads

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
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com

Changes in v6:
 - Rebased to v6.13-rc1
 - After feedback of the other Partial-IO series, I updated this series
   and removed all use of regulator-related patches.
 - wakeup-source is now not only a boolean property but can also be a
   list of power states in which the device is wakeup capable.

Changes in v5:
 - Make the check of wol options nicer to read

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
Markus Schneider-Pargmann (6):
      dt-bindings: can: m_can: Add wakeup properties
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state
      arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as wakeup-source
      arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as wakeup-source

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as wakeup-source

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  27 +++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |   2 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |   2 +
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   2 +
 drivers/net/can/m_can/m_can.c                      | 111 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   4 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 9 files changed, 151 insertions(+), 9 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


