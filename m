Return-Path: <netdev+bounces-166883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6FA37BFA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B748B16B2D3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9619ABAC;
	Mon, 17 Feb 2025 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CHthldAF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4013194AD1
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776739; cv=none; b=W1eCJtnrubVs9VeVjpKR/Jsg6DYw+Cg9tzl+ggFm/EJLkhOmglpZo5JoFgnUiMTd5dhB9PiBEweMGySdCgQNIrBm0Cy3yFUWUTdsdYstWGS4LY/lcVg4Z+4XCGa2mTBuJUAkLG1yDIN2KGqvWBX0RW0h9aESTGTdhg2otDppzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776739; c=relaxed/simple;
	bh=I4jElsKLO3xjHp4+FGR34gEFeHf8DAoYrFYY9fzZwhI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hS+cIn1r1YT75QCASA9SRMvJkVo+gDyLSUGK+1gYWeRbuHOA9ILVtsW1ExBwPWhqk4xxUjO0neTGWTI/Q+jSFDvjxivJInUsXvTrfTEWeHxBZ5hrQFvGKxHPdT0z+nG3Q7WOO9q1MMuqBU538KITvRdum6LKlrUw726Ao9onbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CHthldAF; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3d1a428471fso21845325ab.2
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739776737; x=1740381537; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbNYgolpmdlkL880GB4JAqCw8CX2Bv040wvl7gMCZ38=;
        b=CHthldAFUFjxeHujru+Jvv7nzw4s/Jqs35h1XS1Eyx2mD9bVQh/6MhD3uu11WShvba
         2onfH7B053q01+iGNcqtE2nmLhb20UFALmYTW4vPlTdl7k1+VbARKNMOdALR4zbLmvwQ
         XJYk/sv4CdlBsPVcUpKqlees1A/tyRiprQAWi//VwkHWh9EOI9Rt2s+/agK/vzjolrtb
         FYEZZwL9kJgjWumIEeqzh8CcbFLfJgyOqXzEMouFFHPQPEzMpDbRMPGATJnM2HSlmdOF
         WFd1rnrShQalAg0WCiH27UWrsxyTazJpxiRV5yMpcbpgNaDxY/x3ujnr2H06nuBD6joY
         Rp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776737; x=1740381537;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbNYgolpmdlkL880GB4JAqCw8CX2Bv040wvl7gMCZ38=;
        b=qjSzIKQRRV8ETQqGcQI53YtZ6ptrHFfBFSWYuwMwXmAQps0sYWH39wQqRykjngybeu
         9emt7jkeyL82LbF8SdTZEg9npGIGkDUnlmC1j3l6YxeF5sf0l9aqXSG7nYfwKQQy4vkP
         Pxgl7KnqFClG8nfE0pqvIitBx5M2Ykhk5BhxzXrS3t/VdjARVGBs/8u1bKLD3/MZlnyF
         4AvuQwmQWAZ+kjPaRu3YTB8wHHu5xuBGMvjgCA0Jm/AznI6hk4wCU0os0NxsVzbB5ZBX
         c2uX7B3S/uAbNFbUKDWA+4tzbpY4It5a3O4GXd3CffebSS1WeQUG1yVrEqRTn1U9il5G
         0XvQ==
X-Gm-Message-State: AOJu0YwGlhdXX/DLx6cz7g94HkriX3HHzKA8BfpP+r7XttGOr6Jo8Ptw
	xRbURdscqPKQ0iiLwabLQwIoz314qK7NOXu2y58wLV1677aZ89W2S9V1RWbLI+Z7xvi0WZaPCLW
	a71ksCROfQ5lKIobRHMUlsm7uNtQTwbi5
X-Gm-Gg: ASbGncslOOJ3XHLpnR5eYxb9qS7kQAdaj0Q8rqeB7NaP1Tgvit/nUcXuc4fVRPZAttU
	fL85KOSFEbUZjJPXhfnnvBb+4OQvnHgxXHo9kLtKsGpSo3hct04dD1877jqbY2V/NOy6iVva8fc
	Y96OCpJPDOVN5E90cE3eW6zNofWJh4+JckbTZjoq4rVR6t6JBRa/q6v29J3khSOvkVC6st7hBg6
	Q9/Aez/pb1JUUUu1yGLllxYiyGiVo7yncA/6N614rCZ/WhKKrgCehEx2g+jM9fU4NoaWQjevI4f
	bqT/HKB+yVSXP/09ZBWqUDvcaW8Z0az8fI08GVw=
X-Google-Smtp-Source: AGHT+IGx14t/coTa0nDHuRYAjHq9TCbFyk7Yy6Dj0apGzi6Dm2S+35KcW2ni8rQ+sOqnrwLIP6VX4564qiy7
X-Received: by 2002:a05:6e02:1a8b:b0:3cf:c8bf:3b87 with SMTP id e9e14a558f8ab-3d28076c338mr59775375ab.1.1739776736932;
        Sun, 16 Feb 2025 23:18:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4ed28171124sm524265173.16.2025.02.16.23.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:18:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 861D73402B1;
	Mon, 17 Feb 2025 00:18:55 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 78229E56B89; Mon, 17 Feb 2025 00:18:55 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH net-next v4 0/3] netconsole: allow selection of egress
 interface via MAC address
Date: Mon, 17 Feb 2025 00:18:43 -0700
Message-Id: <20250217-netconsole-v4-0-0c681cef71f1@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANTismcC/23NTQ6CMBAF4KuQWVvTHwrqynsYF1in0ERb0mKDI
 dzdsSuNLl/evG8WSBgdJjhUC0TMLrngKdSbCszQ+R6Zu1IGyaXmktfM42SCT+GGrDaN4CjtrhU
 GaDBGtG4u2Anojm7nCc7UDC5NIT7LlyxL/w/MknGm0Wq8aNtw3RzHR8T3tOtxa8K9YFl9AvoLU
 AQIJTslrGjFfv8LrOv6AnJvS+31AAAA
X-Change-ID: 20250204-netconsole-4c610e2f871c
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, kuniyu@amazon.com, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v4:
- Incorporate Breno Leitao's patch to add (non-RCU) dev_getbyhwaddr and
  use it (Jakub Kicinski)
- Use MAC_ADDR_STR_LEN in ieee80211_sta_debugfs_add as well (Michal
  Swiatkowski)
- Link to v3: https://lore.kernel.org/r/20250205-netconsole-v3-0-132a31f17199@purestorage.com

Changes in v3:
- Rename MAC_ADDR_LEN to MAC_ADDR_STR_LEN (Johannes Berg)
- Link to v2: https://lore.kernel.org/r/20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com

---
Breno Leitao (1):
      net: Add non-RCU dev_getbyhwaddr() helper

Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_STR_LEN
      netconsole: allow selection of egress interface via MAC address

 Documentation/networking/netconsole.rst |  6 +++-
 drivers/net/netconsole.c                |  2 +-
 drivers/nvmem/brcm_nvram.c              |  2 +-
 drivers/nvmem/layouts/u-boot-env.c      |  2 +-
 include/linux/if_ether.h                |  3 ++
 include/linux/netdevice.h               |  2 ++
 include/linux/netpoll.h                 |  6 ++++
 lib/net_utils.c                         |  4 +--
 net/core/dev.c                          | 37 ++++++++++++++++++++++--
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 net/mac80211/debugfs_sta.c              |  7 +++--
 11 files changed, 97 insertions(+), 25 deletions(-)
---
base-commit: 0784d83df3bfc977c13252a0599be924f0afa68d
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


