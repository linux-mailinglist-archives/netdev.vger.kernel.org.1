Return-Path: <netdev+bounces-50368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB77F57AB
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675D0B2110B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 05:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA63BE4A;
	Thu, 23 Nov 2023 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYaOj9Xm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999771A4;
	Wed, 22 Nov 2023 21:09:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca85ff26afso1157465ad.1;
        Wed, 22 Nov 2023 21:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700716193; x=1701320993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQnb3OI9ite9LCaTS2sIPyyiu8ymtk9unqf+0DnLIgM=;
        b=aYaOj9XmgOUI6n8zUO2lhpIYuuuxqDPe5tGn55UbeQMFKirv1uID4odXEDzataRXW8
         tyQNSKjqddezl04JrDJNGP78VHnXxkMdh7uTHRonpKPUIxV6BJMwDAw64MXKSnytZVL7
         5Hsva4Nk41kWFHhfSJNLMH5l1M+kfzaQ5ua5LIPBY5mnGV7EQx3K+zIA91r0C4u9S4U1
         iazrdx6kKPhBrXAIQ+RMjLy/7yDvA73XysS3UZcsjbdrPfT/rDOtFONWtu/ePgzuwJI6
         hBGVbBXZWFhAk3MeQ0VHSLYPK7gFeUC27PoI+0ZGMpFnvrexq9zRJjzSvDmdTuMKgRCv
         1/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700716193; x=1701320993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQnb3OI9ite9LCaTS2sIPyyiu8ymtk9unqf+0DnLIgM=;
        b=DF6PCEQSvpkqeAcr2ddFmRU6cwJeiMQ6SkqSwb62bLpPNoYNIwxel/ZXTrII2XbY48
         cej4O/8MxNmCdBjPxWAv3bEjgWtIJ3dsu6+bMEEeZ8Seeu1ONqZF+W9KgRVng8/+vcta
         YWZ8Rx4gxw7ei0IKuIyn8VT6G9T3+1cRBrLfpm3/ePeh84Qi+4v71wgrx2CxUFpfavbA
         ys/KmGuyYRlabUSw84ofCdA8Lc2w10eW2MRGZgl/0j0x0mvkR7qeGHlUOZZxXrrSUq7T
         2Yh50XAGGDu1ZyTB7uU9iZdrF3vI1oQJpeCWbT97HhhOeReCMCTO+sptF024NShqtSmK
         RN7Q==
X-Gm-Message-State: AOJu0YzbAMd9qqeTDgHh0y74rYMZ5o9O7K/9wcANy4dEhng0rcPQCoYr
	uCa1ADETGrLsLw8oRcPeQTJ0etx/SdvVzg==
X-Google-Smtp-Source: AGHT+IFuYegjL3R3qLm4qqfbGzCI8z4sl7db4dzYX+N4jfeO7UFKUfKgJa/CBed7gkymfYCbO1c83w==
X-Received: by 2002:a05:6a20:2d0a:b0:18b:8158:dfa4 with SMTP id g10-20020a056a202d0a00b0018b8158dfa4mr2459371pzl.5.1700716192576;
        Wed, 22 Nov 2023 21:09:52 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b006900cb919b8sm347734pfi.53.2023.11.22.21.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:09:52 -0800 (PST)
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
Subject: [PATCH net-next v8 0/4] Rust abstractions for network PHY drivers
Date: Thu, 23 Nov 2023 14:04:08 +0900
Message-Id: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
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

The second patch adds a macro to declare a kernel module for PHYs
drivers.

The third adds the Rust ETHERNET PHY LIBRARY entry to MAINTAINERS
file; adds the binding file and me as a maintainer (as Andrew Lunn
suggested) with Trevor Gross as a reviewer.

The last patch introduces the Rust version of Asix PHY driver,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

Note that the way to access to a bitfield needs to be fixed;
is_link_up(), is_autoneg_enabled(), and is_autoneg_completed()

v8:
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
 rust/kernel/net/phy.rs           | 893 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 9 files changed, 1079 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: 750011e239a50873251c16207b0fe78eabf8577e
-- 
2.34.1


