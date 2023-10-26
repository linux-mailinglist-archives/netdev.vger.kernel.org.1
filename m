Return-Path: <netdev+bounces-44334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F57D7922
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885DBB21204
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC9370;
	Thu, 26 Oct 2023 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFA1EKFg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F3163;
	Thu, 26 Oct 2023 00:16:55 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2DFDC;
	Wed, 25 Oct 2023 17:16:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd20c30831so65480b3a.1;
        Wed, 25 Oct 2023 17:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698279412; x=1698884212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qjrhGvXyC+Cpvje9494wzCNLGQjRWIo89m7QjkbmOw=;
        b=GFA1EKFgTtWTI2FsnSYj+jbCojpK8HGSeTHVWVunPyInPtvUvT5CIhVJjYmWYQxXmJ
         ltOfZ9zGMwB1oo78SFJ4FfZlTnsA/FMdlxP/b6V3HscP4f1msAJnKvon+HO2uSDFPU01
         MyLNp4KsT/EgAWWqT2wQoWkSHjcAZUlraDBXcqJVx7+b5soF3ZwZAWweaye3MpU8gfUf
         oG/I56ozGzs4TysxhD4LNTUY8gcnzpYo4VsOpLh+AXGrxKp47ac1OV1w7xXILaFjiHxC
         wgzn05jV4Agyja7TGyskevjMvAZVUid9a54gxi70qbLKdJ3dDBjJdiunsN5YFUwidHdg
         xBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698279412; x=1698884212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qjrhGvXyC+Cpvje9494wzCNLGQjRWIo89m7QjkbmOw=;
        b=PkvNuAxYmCgtdqSkHmvYX7wwX11QI5nySwM1H3PQU9GUr+ZOr7x/TLqp0DtK9i4tEb
         8AIgbCeR3+ooWmzFWMDut4wgwkpy7K1jQvtTpNwkYQkXekq3Zs0f+zgodSkNwpjhX3/f
         wB36bIL/Kup8pdtLmMnTXjzF8RijeD1zqrfsAJXiFZMZRxsc7URhoe/qedJichOidK4h
         ZCRJbPsOsRV82L2Ng6NNq4B2Wt3K3DbeHTquUwdMb2bQEK+6ykVsl8GC9ttIjxK8q0km
         I04AsRcCz4bZm762dHcsY5nlAUQauGc9Kfw7V/AYbBjFVjCT87WMt7+KvuYplhjsFLWF
         KXjg==
X-Gm-Message-State: AOJu0Yz33LuB3xihhshzeSRBibvo11YMTdl/X0W6cBC3fA+KLNzS1TTl
	xHyPzrEqx1MjHLXyIKW11dZD3xhVr06jfZAt
X-Google-Smtp-Source: AGHT+IHI91Fj5GCkie1Q7hUI9CKI7WXX3UKG9RSQ3+rLWJPAs3j7H1AqJcTG8Cl5bX8e8+7dPhwZqQ==
X-Received: by 2002:a05:6a20:3d20:b0:17a:d292:25d1 with SMTP id y32-20020a056a203d2000b0017ad29225d1mr19978847pzi.6.1698279412028;
        Wed, 25 Oct 2023 17:16:52 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b006b341144ad0sm10407945pfb.102.2023.10.25.17.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:16:51 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com
Subject: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Date: Thu, 26 Oct 2023 09:10:45 +0900
Message-Id: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
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

The second patch add a macro to declare a kernel module for PHYs
drivers.

The third patch add Miguel's work to make sure that the C's enum is
sync with Rust sides. If not, compiling fails. Note that this is a
temporary solution. It will be replaced with bindgen when it supports
generating the enum conversion code.

The fourth add the Rust ETHERNET PHY LIBRARY entry to MAINTAINERS
file; adds the binding file and me as a maintainer (as Andrew Lunn
suggested) with Trevor Gross as a reviewer.

The last patch introduces the Rust version of Asix PHY drivers,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

v7:
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

Miguel Ojeda (1):
  rust: add second `bindgen` pass for enum exhaustiveness checking

 MAINTAINERS                          |  16 +
 drivers/net/phy/Kconfig              |  16 +
 drivers/net/phy/Makefile             |   6 +-
 drivers/net/phy/ax88796b_rust.rs     | 129 ++++
 rust/.gitignore                      |   1 +
 rust/Makefile                        |  14 +
 rust/bindings/bindings_enum_check.rs |  36 ++
 rust/bindings/bindings_helper.h      |   3 +
 rust/kernel/lib.rs                   |   3 +
 rust/kernel/net.rs                   |   6 +
 rust/kernel/net/phy.rs               | 868 +++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h              |   2 +
 12 files changed, 1099 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/bindings/bindings_enum_check.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: 8846f9a04b10b7f61214425409838d764df7080d
-- 
2.34.1


