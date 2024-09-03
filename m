Return-Path: <netdev+bounces-124464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4926969919
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FB31C247DD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33E1A0BCE;
	Tue,  3 Sep 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="WoL3+8Wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4D1A0BC4
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355983; cv=none; b=K4YMKBFToYeN3IELuJpO+grkFVHBj/qOeE+g8XPheiApYaE+xgkxoMGBCYwitjrUY1CMKptogoAs47KOypPTpcWK5da6HQWxVu8PFc3kLApNZCziKVFP702vtGrJeJ+bOX/wkafk355xfOPVGGr1bjbMoBNQfepK+avHadLB43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355983; c=relaxed/simple;
	bh=RkS5AVf/vdM06VdBh/pNZ142u7DJAZMa3GzPOEWQgE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kEgELW3l+zYasmicsyiInif1VcZvCI0hktCFgfXjbHg2wRDNjea2HQp3kzZXEQ96cKQxtpEcYI1/FyrGc/pYy+0Ls/r2IM6fY1x312KcII4namXXzfLbFHe9pxVqzjSnyG9NAhnxhovukH2eRUWqGoAwTMjrAj2SzGZCKIdGjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=WoL3+8Wk; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-70f794cd240so1119213a34.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1725355981; x=1725960781; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GX275WkLtFvp4P0H3VEJOqlKsL5ASXMh+yrpYY3jjm8=;
        b=WoL3+8WkrkVep/WWWynfC7XLrlThzEvGGLALfzK4YK2XrQfKcIwTM7sJ3ybRsR39t3
         ZADwivT4rFz96C1cPLSv4eAztnvzrslZPlqOu5PiJrzco8Wz4W6xzzYYjpUKMh3c9cjq
         LGtTL2HeKbKfvnGy70dHWq0et/pi6Fj8st0ad47QajqF3fUkn5JIFImpaT1hctF8Wogu
         /nP8i7XZ6W9d5NtdpYSMV0ZMBrxCLt5MdIdPntqACcIqsQpb7TKNkmpAaFTZCFEv8Ldj
         NPXPA2gX3Dwi7GETC80iFO430sB2y1NTPJ4UsLBz/lAUkwmijD/BEnWpfzYdREg0tlws
         isAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355981; x=1725960781;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX275WkLtFvp4P0H3VEJOqlKsL5ASXMh+yrpYY3jjm8=;
        b=fqalbHYbE3BXMowyHt1ElPrSKa/fqYhVDWeLO+vIiF++Tp1yw+W5gIs7GBlCoBhISN
         06tKLD3QAYdodAre+IJCEhpwzUzj0zCpbY5Mb28GT0axUO3/J9kz7kRNDCLRAqV57Uce
         OfHe5WWupCwcZDiV65gvj/v0tlbcIckylrban6Q1ApMt8dyI1Sv0YAvrFUgi55T7cKXe
         JyoxJvyVSYe0l1L9eBeS6QG/GZXRX/1MFX29ae8D1xCiZQxLWGPkgelA69z+d7iayi0S
         TCqWuPkmtitkNXbReutma2MU3YFO3ODLFSv4o2lQL+16UixE3Ln2jAJO11ChYVIKz8G4
         4Gmg==
X-Forwarded-Encrypted: i=1; AJvYcCWSpRK3BkmsxKsPOywzBihEYFiP5VGq7ItWX7SQzt1VSulYPb2q3IUMPSnEObxRhCwb4Ojfu8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynrsa4FfR4rOG2WNj2EtqlNtWefUDJGFXcH3rNjJP/a9sARuBx
	eBoG8oQ2GAIpxw0P2HBKsO7CEdQThEGRFZ9P9v3kOKxooOiTetstHoxp4fYIyg==
X-Google-Smtp-Source: AGHT+IHNAlXlP35WDQ/hjPG0ZhGzmWv5PTEpbHeyt1YwNX8aCYlzjyVLC0Eo1ipif9Q1+hnKTpuh+g==
X-Received: by 2002:a05:6358:7e90:b0:1b5:c544:23a8 with SMTP id e5c5f4694b2df-1b7edb4ae07mr1390862855d.11.1725355980994;
        Tue, 03 Sep 2024 02:33:00 -0700 (PDT)
Received: from [172.22.57.189] ([117.250.76.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d72d1sm8365868b3a.170.2024.09.03.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:33:00 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH v4 0/3] Add Firmware Upload support for beagleplay cc1352
Date: Tue, 03 Sep 2024 15:02:17 +0530
Message-Id: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKHX1mYC/3XOTQ6DIBAF4KsY1qVBoP501Xs0jQEZkMSIgZbWG
 O9e1E2TxuWbzPtmZhTAWwjoms3IQ7TBuiEFfspQ24nBALYqZUQJ5aTML1iCMD2MvZga/W5eo/F
 CAeYMirYFSRRTKHVHD9p+Nvf+SLmz4en8tJ2JdJ3uYkXyAzFSTDCwoqaVLGuq5G3fk054dXbeo
 NWN7MeiR99FlqxKc8pFraDWxb+1LMsXuxdpzwwBAAA=
To: d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2448; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=RkS5AVf/vdM06VdBh/pNZ142u7DJAZMa3GzPOEWQgE8=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm1tfD/vBXyGsCpKZy+AgleCzE/caFt0oMppSdH
 xhZlfoywt6JAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZtbXwwAKCRAFzvXHieVa
 dFpJEACfw8pLANXVXWW4dt1Ioldn8TmvpqvIqaKqWvzfuNi+tKll5YvE1o1H/kSTEqsiZrjM0MT
 3iuxrSqyBGTHWsP/8R5B/YMEJcT/Jhf01wr9fswejixbCA+Lyh+OlA4xdRGmWb3fUZ0UAgvp06o
 5SNgvSyA5dUJpKQKuH3ZYImu2DEZhA4UGxZLUtn9H9MomDcENGl8C+lO5E3LL1RhVR79Y0m8Ibe
 u1h32l56kGTc0axW020mJ5Qc9R+8Daau61UOALhI+ntLf9n/8EfG8/T/3t2HcQTVamHSog3A/1P
 lWmU6L4QQjVRJx+eNxcmqUnR+AcBlrigd+/7NPmqyuOAsfKnroLxeed6ShLAWGG8FMZNXCKBMqr
 0o9IuC+pzLXfk4LrEStfk43oIlqd1Trl9KQbuWPPNcArFDhU+aYoOHrsd35Oc5MYyJE6r/qGZRL
 1o5f3QiRFFoqJSN+v7JaxD4zcK+iVkrqokP5C23F3n6qdXKeGpVdUieg7KzGn8K79QIC17Gwd9j
 R9vlKuUoz1pC2npEXsr0hDr2sKjiTkvP9kXAUEdFAg9GyKR/LuxkkOCrzWAYy3LcW7jiBZ7Or9a
 uybSiQ4Swgj3strtRmsoET3zm3oZyRfewEvgYoyZfTyA1a+AYq61lzNJtv7ZXiyXiSS7S0OAE0z
 snjvKIoWaGJ9DLg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Adds support for beagleplay cc1352 co-processor firmware upgrade using
kernel Firmware Upload API. Uses ROM based bootloader present in
cc13x2x7 and cc26x2x7 platforms for flashing over UART.

Communication with the bootloader can be moved out of gb-beagleplay
driver if required, but I am keeping it here since there are no
immediate plans to use the on-board cc1352p7 for anything other than
greybus (BeagleConnect Technology). Additionally, there do not seem to
any other devices using cc1352p7 or its cousins as a co-processor.

Bootloader backdoor and reset GPIOs are used to enable cc1352p7 bootloader
backdoor for flashing. Flashing is skipped in case we are trying to flash
the same image as the one that is currently present. This is determined by
CRC32 calculation of the supplied firmware and flash data.

We also do a CRC32 check after flashing to ensure that the firmware was
flashed properly.

Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352P7 Technical Specification

Changes in v4:
- Add acks properly
- Fix Kconfig warning by adding select FW_LOADER
- Link to v3: https://lore.kernel.org/r/20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org

Changes in v3:
- Spelling fixes in cover letter
- Add Ack by Rob Herring on Patch 1
- Link to v2: https://lore.kernel.org/r/20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org

Changes in v2:
- Spelling fixes
- Rename boot-gpios to bootloader-backdoor-gpios
- Add doc comments
- Add check to ensure firmware size is 704 KB
- Link to v1: https://lore.kernel.org/all/20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
Ayush Singh (3):
      dt-bindings: net: ti,cc1352p7: Add bootloader-backdoor-gpios
      arm64: dts: ti: k3-am625-beagleplay: Add bootloader-backdoor-gpios to cc1352p7
      greybus: gb-beagleplay: Add firmware upload API

 .../devicetree/bindings/net/ti,cc1352p7.yaml       |   7 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   3 +-
 drivers/greybus/Kconfig                            |   2 +
 drivers/greybus/gb-beagleplay.c                    | 658 ++++++++++++++++++++-
 4 files changed, 656 insertions(+), 14 deletions(-)
---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240715-beagleplay_fw_upgrade-43e6cceb0d3d

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


