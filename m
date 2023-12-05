Return-Path: <netdev+bounces-53707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6EE8043D4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F3D1C20A86
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E62ED9;
	Tue,  5 Dec 2023 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJPpYXFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE76D5;
	Mon,  4 Dec 2023 17:16:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce4fe4ed18so306644b3a.1;
        Mon, 04 Dec 2023 17:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701738976; x=1702343776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bW8p/7StZNBd4w+aXs/KRA66EMDHFIQHYNt6TXm3wDI=;
        b=YJPpYXFIgtQRoKq6hcT5kG/LVhFe20hSu6FOJyr+iUd5rd57K/rojfnMawyvDSRu/H
         lF/9hLNQaAj68MD43APA/RzMUrjZQIxs4caS4Yvy8cpCRoK7s13bFoz4Pw94j6oEi1OB
         oaiUvt14ViKIYI7z7vCgsO6QPVO4l3133YzYYDuu4D96UpZ8zLwF6vaEb1jB/JQ6d1ye
         9BHoyNzrNkd9osrvJZeVoQ4PX8FEjLkTTXkdfyf4l2zK91/DKbxEUC/tV9frybmJbndM
         fNlwdtsFu0a2sYpLoEMDikMaFpzx1Qma+tXGnGKp6/+mblVh4J5UbnFvMYEZT36mAXqA
         OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701738976; x=1702343776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW8p/7StZNBd4w+aXs/KRA66EMDHFIQHYNt6TXm3wDI=;
        b=oyScthE+DvwiOHd/y9vbV6OJNeMDp4U6AqiIOsVxoIhB3blK6pepRb38yqwWTXrjno
         4KgkTz7aaI3i9xnoq3SgZ9Kq9zff3Wq7j/XmL8E4xsDvySnLonoNes/I71qBxBegQsTv
         hyNNb30MFSH7g7lWkCQ7l2Vk/9AF6OE3FqZ57FqhA/PN2Ds3dwpCQ61urytXAo9cpt3R
         djBl5XsyCg9PnhXD4uvZjBhI8hizRi1sNSkz7Bc16I8/j1Ns82aHOrtL3RgpkooIJQ9n
         gVGOqJuIE2lKxlPApZZwlR5INge7sBgdAq4I0M0qswA3LpRwGS994pcxMafbJxIfXVAg
         ioHQ==
X-Gm-Message-State: AOJu0YxeObg2uZPV/CNcirjVYk5yykz6R1gf90TYXEV1mfTl491q6tTP
	TMbiiSUqoGfWUir25UMd4+bTi++Jf+qudQ==
X-Google-Smtp-Source: AGHT+IGSdPTo3VXtgqI4ABkWxhgD31RlbzxjfDS90P4YmeucppWO6QLt5MsgdcefnXVo4c/9EaiNbA==
X-Received: by 2002:a05:6a00:1ad1:b0:6cd:e3ef:ce54 with SMTP id f17-20020a056a001ad100b006cde3efce54mr17771746pfv.0.1701738976218;
        Mon, 04 Dec 2023 17:16:16 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b006ce64ebd2a0sm89337pfk.99.2023.12.04.17.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 17:16:15 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	aliceryhl@google.com,
	boqun.feng@gmail.com
Subject: [PATCH net-next v9 0/4] Rust abstractions for network PHY drivers
Date: Tue,  5 Dec 2023 10:14:16 +0900
Message-Id: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds Rust abstractions for phylib. It doesn't fully
cover the C APIs yet but I think that it's already useful. I implement
two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
they work well with real hardware.

The first patch introduces Rust bindings for phylib.

It's unlikely that bindgen will support safe access to a bit field in
phy_device struct until the next merge window. So this version uses a
workaround to access to a bit field safely instead of the generated
code by bindgen.

The second patch adds a macro to declare a kernel module for PHYs
drivers.

The third adds the Rust ETHERNET PHY LIBRARY entry to MAINTAINERS
file; adds the binding file and me as a maintainer (as Andrew Lunn
suggested) with Trevor Gross as a reviewer.

The last patch introduces the Rust version of Asix PHY driver,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

v9:
  - adds a workaround to access to a bit field in phy_device
  - fixes a comment typo
v8: https://lore.kernel.org/netdev/20231123050412.1012252-1-fujita.tomonori@gmail.com/
  - updates the safety comments on Device and its related code
  - uses _phy_start_aneg instead of phy_start_aneg
  - drops the patch for enum synchronization
  - moves Sync From Registration to DriverVTable
  - fixes doctest errors
  - minor cleanups
v7: https://lore.kernel.org/netdev/20231026001050.1720612-1-fujita.tomonori@gmail.com/T/
  - renames get_link() to is_link_up()
  - improves the macro format
  - improves the commit log in the third patch
  - improves comments
v6: https://lore.kernel.org/netdev/20231025.090243.1437967503809186729.fujita.tomonori@gmail.com/T/
  - improves comments
  - makes the requirement of phy_drivers_register clear
  - fixes Makefile of the third patch
v5: https://lore.kernel.org/all/20231019.094147.1808345526469629486.fujita.tomonori@gmail.com/T/
  - drops the rustified-enum option, writes match by hand; no *risk* of UB
  - adds Miguel's patch for enum checking
  - moves CONFIG_RUST_PHYLIB_ABSTRACTIONS to drivers/net/phy/Kconfig
  - adds a new entry for this abstractions in MAINTAINERS
  - changes some of Device's methods to take &mut self
  - comment improvment
v4: https://lore.kernel.org/netdev/20231012125349.2702474-1-fujita.tomonori@gmail.com/T/
  - split the core patch
  - making Device::from_raw() private
  - comment improvement with code update
  - commit message improvement
  - avoiding using bindings::phy_driver in public functions
  - using an anonymous constant in module_phy_driver macro
v3: https://lore.kernel.org/netdev/20231011.231607.1747074555988728415.fujita.tomonori@gmail.com/T/
  - changes the base tree to net-next from rust-next
  - makes this feature optional; only enabled with CONFIG_RUST_PHYLIB_BINDINGS=y
  - cosmetic code and comment improvement
  - adds copyright
v2: https://lore.kernel.org/netdev/20231006094911.3305152-2-fujita.tomonori@gmail.com/T/
  - build failure fix
  - function renaming
v1: https://lore.kernel.org/netdev/20231002085302.2274260-3-fujita.tomonori@gmail.com/T/


FUJITA Tomonori (4):
  rust: core abstractions for network PHY drivers
  rust: net::phy add module_phy_driver macro
  MAINTAINERS: add Rust PHY abstractions for ETHERNET PHY LIBRARY
  net: phy: add Rust Asix PHY driver

 MAINTAINERS                      |  16 +
 drivers/net/phy/Kconfig          |  16 +
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 135 +++++
 rust/bindings/bindings_helper.h  |   3 +
 rust/kernel/lib.rs               |   3 +
 rust/kernel/net.rs               |   6 +
 rust/kernel/net/phy.rs           | 900 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 9 files changed, 1086 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: 8470e4368b0f3ba788814f3b3c1142ce51d87e21
-- 
2.34.1


