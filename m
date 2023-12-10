Return-Path: <netdev+bounces-55656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9D80BE5C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 00:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACC61C20364
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8011E523;
	Sun, 10 Dec 2023 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz+FvMm/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4FB3;
	Sun, 10 Dec 2023 15:50:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27fe16e8e02so699523a91.0;
        Sun, 10 Dec 2023 15:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702252220; x=1702857020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwXqrGNjozU56ljLa8Hu6Y/crgsYeVFvhR7eGoGJxqA=;
        b=Sz+FvMm/NPKi18AlYfp15CDT6GGkiidwaDV8tAIdHdPYOMHUj+QtWtSogm87TxIbEm
         I8Q2SmoEotNvz97TpVg4svVRGFZtZLPr2oE7Xa3V0oOhac4TOq++6ohb2ybfKGQYJfhP
         lVUuKhrgennxvQg2sX0ZrfSsAxLr+S2WFHoacOCdqE3MSc/eOaLhbZqvDyp4ExBeGGo8
         VQeUNwt0fhFijgqTbe9S+C95gUlANQ1/43iBB0JhUBkRPRHt4mqx9MPAiB1CnO5xIvrP
         3ZCarqmyVbu/03WynDSn/6Mrv5zxwh/EbiGcRa+TyzXXWTIJM4e2Vvbli7FXjMgo/7i9
         8QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702252220; x=1702857020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwXqrGNjozU56ljLa8Hu6Y/crgsYeVFvhR7eGoGJxqA=;
        b=rHb34TF+Zqc/UI6TurZzj8xDXCrk3+9U7RGpzkrJYXYpW4j3z6nK6/AYhvySdR8QCx
         WisiwmDLUeWq2k2Wab9p/6u/Tpy/gYapk2CwTYb8r0HKjB5vNJDGcqmGlkJhtUcQW2Rd
         jEUDIyKeQQBWgu1IanqdICKcgd8JVIGXQQ6frGU8aFLfOK3YxTiQw+8PptLT/RuyRrP0
         jJPvKA7HXXhiRfmizSDO53z9J6wwcAAKjy5Liz3h7ItnAbd9NwhzK7aGCrQz+DlzLKI2
         Jm6n9cTKhz3lKTqxJVHuxApzLsBKZD6EFMCduIHn/i48Bcr691Jf7dCIh3pWccV4lefZ
         6Kwg==
X-Gm-Message-State: AOJu0YzFF06Feg+2gU+o/XuyweGOo2GNzLtDWsWM+PWD3ienLVjlPYke
	Ere55EKYMBfsHeyoJ40iCC/z0zgjpH+zAA==
X-Google-Smtp-Source: AGHT+IH2mpwt2mbolxQEiR6kw9EPo8dlmc9WLImWMYVh7pwv1rLanrWtNtCliK2YETebT8TIOZSmMA==
X-Received: by 2002:a05:6a00:23cb:b0:6ce:4c49:58e4 with SMTP id g11-20020a056a0023cb00b006ce4c4958e4mr7948405pfc.0.1702252219857;
        Sun, 10 Dec 2023 15:50:19 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006cef6293132sm2812878pfl.101.2023.12.10.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 15:50:19 -0800 (PST)
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
Subject: [PATCH net-next v10 0/4] Rust abstractions for network PHY drivers
Date: Mon, 11 Dec 2023 08:49:20 +0900
Message-Id: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No code change since v9; only commit log updates.

This patchset adds Rust abstractions for phylib. It doesn't fully
cover the C APIs yet but I think that it's already useful. I implement
two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
they work well with real hardware.

The first patch introduces Rust bindings for phylib.

The second patch adds a macro to declare a kernel module for PHYs
drivers.

The third adds the Rust ETHERNET PHY LIBRARY entry to MAINTAINERS
file; adds the binding file and me as a maintainer (as Andrew Lunn
suggested) with Trevor Gross as a reviewer.

The last patch introduces the Rust version of Asix PHY driver,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

v10:
  - adds Trevor's SoB to the third patch
  - adds Benno's Reviewed-by to the second patch
v9: https://lore.kernel.org/netdev/20231205.124531.842372711631366729.fujita.tomonori@gmail.com/T/
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


base-commit: 172db56d90d29e47e7d0d64885d5dbd92c87ec42
-- 
2.34.1


