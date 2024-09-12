Return-Path: <netdev+bounces-127962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1724A9773B9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9374284A97
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF4190058;
	Thu, 12 Sep 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fver4PLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F02C80;
	Thu, 12 Sep 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177403; cv=none; b=D6gDdO7eEyLVgyGxkLlw/XDWkSCPdOYpoaOdgUk/whnYX61u+BzjS/d1h+7E9xHfuQ3HkwSHrE4Yb+4ntWHpuL7Wcd+/wd+m2g5KkjXG7jqRg23+okigBplcOrDF6lRpqcKubOlgL3n9x949AvEAy4BRMkKciPWpWgvCfUf3kyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177403; c=relaxed/simple;
	bh=wn1Uao9imIMKmuiA3axl08TkNFIJDDki1TBiy/Cw4AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=elpLjFHahNkmqU2a1QMvYRCWZxqWP42bi5q8OUc2yS4Z9QWkCiwOHJDRxtzoZ19mSYI1s4JiZMQ22HoiaLP2Z1sVia7YoKPlYT6OE12+W7bLNAaxZv6b4aQCVWw8MlVnVQW+/4r6BOdPoGFjyZecBiXjAGcFa8uLIqk2diazaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fver4PLl; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-502adfff6fdso464893e0c.1;
        Thu, 12 Sep 2024 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726177401; x=1726782201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZtWidyoc7iwFa3Dk5rtB8c+BGvNkAphuCMWXvuYMko=;
        b=Fver4PLlpAxsLjxDRfJ2LYLQ76WLi6j8yQ2cCjUL3U4/Bldic8DgcDa2TBsEmIBepA
         DdE+rciQBqihisJaHN6GTlUX3xHO8/lpRQ6RITC6WW8FTGfrteIvlLH8WvnDmLFBfIZI
         Oxbs/WBwb+C15sr05EMV6O1T35F5XeId1z19BWnB0ilYTfPwsZnLTYzI6l6iNLvN/B9r
         W1XUJpWbQlonj34aXTmAdIq59Irh3rwRgrAa9t1msGcSmznXWgclqRJDoNRt7xf1BBYc
         wxoHY86UoXDjZlFSP3Raf8Aa7/bVH/StDR6DmK/pHEr7vLq++QlWquyQBPnOG981SsEZ
         SYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177401; x=1726782201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZtWidyoc7iwFa3Dk5rtB8c+BGvNkAphuCMWXvuYMko=;
        b=FFBLt06GmbIuxF5/kSpiA8sNOXxRpyr/OdFxW7/7PzCLxWrNmw0T2zdINOgxP1qEEb
         RTEg8jIsy4Fk018LsvhqPoQO3sEuv5t9oxEN0J5GosZwB4RBV+0ad3HUBUPEx1karH0L
         dXfn52XiyZQWYFamTZJmPAUe8DN4IwzRYp0v7pZ7F62s4sun2JDvoFq+2oDqaiO3KiQp
         A5tN7aPj3GhHnRM/7jGHQR4+bGQ2F0g10DzBUR7dKscke4XF0vXbiXBPSEDFrCIxk2C+
         KnZwpjaIC187DY4PfL4ROtH9vJWzQkY2lOIeuJlqf0UWNCo3VrKv3iZpWhrH/JWNfPTs
         V+iw==
X-Forwarded-Encrypted: i=1; AJvYcCXpSx0Z+gnevGPvZJQ7iE9Zgp+zHrDEESEHQXEi6JC1pbq4gzZlmY7E/AlS0pvzGAr+2vAW+zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGLpnDIDE8iaRISexotX9jKw8F1/6m0zfCpmwdgsaGelUj0/s
	0OQ5CS0R6ee7jraNknyddi5u85OoS+8jf6s0Xuw95mNsOGFmlMntm9etXA==
X-Google-Smtp-Source: AGHT+IF1xx4rS8uQuvPC2zg0SWj7iYX9HW8vf9roER21DJ3EtZsSPGdhksWnAGwbSTq3yHiGcMjRqQ==
X-Received: by 2002:a05:6122:3c87:b0:4fc:eb15:b0f6 with SMTP id 71dfb90a1353d-5032d4a5264mr4304659e0c.8.1726177400594;
        Thu, 12 Sep 2024 14:43:20 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-502f9b1bab8sm830578e0c.36.2024.09.12.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:43:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2024-09-12
Date: Thu, 12 Sep 2024 17:43:15 -0400
Message-ID: <20240912214317.3054060-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 525034e2e2ee60d31519af0919e374b0032a70de:

  net: mdiobus: Debug print fwnode handle instead of raw pointer (2024-09-10 12:24:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-09-12

for you to fetch changes up to 7ffaa200251871980af12e57649ad57c70bf0f43:

  Bluetooth: btintel_pcie: Allocate memory for driver private data (2024-09-12 17:32:42 -0400)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604
 - btusb: Add Realtek RTL8852C support ID 0x0489:0xe122
 - btrtl: Add the support for RTL8922A
 - btusb: Add 2 USB HW IDs for MT7925 (0xe118/e)
 - btnxpuart: Add support for ISO packets
 - btusb: Add Mediatek MT7925 support ID 0x13d3:0x3608
 - btsdio: Do not bind to non-removable CYW4373
 - hci_uart: Add support for Amlogic HCI UART

----------------------------------------------------------------
Alexander Hall (1):
      Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604

Bartosz Golaszewski (1):
      dt-bindings: bluetooth: bring the HW description closer to reality for wcn6855

Frédéric Danis (1):
      Bluetooth: hci_ldisc: Use speed set by btattach as oper_speed

Hans de Goede (1):
      Bluetooth: Use led_set_brightness() in LED trigger activate() callback

Hilda Wu (2):
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0489:0xe122
      Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B

Justin Stitt (1):
      Bluetooth: replace deprecated strncpy with strscpy_pad

Kiran (1):
      Bluetooth: btintel_pcie: Add support for ISO data

Kiran K (2):
      Bluetooth: Add a helper function to extract iso header
      Bluetooth: btintel_pcie: Allocate memory for driver private data

Kuan-Wei Chiu (1):
      Bluetooth: hci_conn: Remove redundant memset after kzalloc

Li Zetao (1):
      Bluetooth: btrtl: Use kvmemdup to simplify the code

Luiz Augusto von Dentz (5):
      Bluetooth: btusb: Invert LE State flag to set invalid rather then valid
      Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
      Bluetooth: CMTP: Mark BT_CMTP as DEPRECATED
      Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
      Bluetooth: btusb: Fix not handling ZPL/short-transfer

Max Chou (1):
      Bluetooth: btrtl: Add the support for RTL8922A

Michael Burch (1):
      Bluetooth: btusb: Add 2 USB HW IDs for MT7925 (0xe118/e)

Neeraj Sanjay Kale (2):
      Bluetooth: hci_h4: Add support for ISO packets in h4_recv.h
      Bluetooth: btnxpuart: Add support for ISO packets

Pavel Nikulin (1):
      Bluetooth: btusb: Add Mediatek MT7925 support ID 0x13d3:0x3608

Scott Ehlert (1):
      Bluetooth: btsdio: Do not bind to non-removable CYW4373

Yang Li (3):
      dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
      Bluetooth: hci_uart: Add support for Amlogic HCI UART
      MAINTAINERS: Add an entry for Amlogic HCI UART (M: Yang Li)

Yue Haibing (1):
      Bluetooth: L2CAP: Remove unused declarations

 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  |  63 ++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  10 +-
 MAINTAINERS                                        |   7 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btintel_pcie.c                   |  18 +-
 drivers/bluetooth/btnxpuart.c                      |   1 +
 drivers/bluetooth/btrtl.c                          |  23 +-
 drivers/bluetooth/btsdio.c                         |   1 +
 drivers/bluetooth/btusb.c                          | 249 +++----
 drivers/bluetooth/h4_recv.h                        |   7 +
 drivers/bluetooth/hci_aml.c                        | 755 +++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c                      |  11 +-
 drivers/bluetooth/hci_uart.h                       |   8 +-
 include/net/bluetooth/hci.h                        |   5 +
 include/net/bluetooth/hci_core.h                   |   4 +-
 include/net/bluetooth/l2cap.h                      |   4 -
 net/bluetooth/cmtp/Kconfig                         |   4 +-
 net/bluetooth/cmtp/capi.c                          |  32 +-
 net/bluetooth/hci_conn.c                           |   7 +-
 net/bluetooth/hci_sync.c                           |   5 +-
 net/bluetooth/leds.c                               |   2 +-
 net/bluetooth/mgmt.c                               |  13 +-
 23 files changed, 1037 insertions(+), 205 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
 create mode 100644 drivers/bluetooth/hci_aml.c

