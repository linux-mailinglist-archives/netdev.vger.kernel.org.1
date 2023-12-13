Return-Path: <netdev+bounces-56678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAB38106E3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B831EB20E36
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936B39F;
	Wed, 13 Dec 2023 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMNChHMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C1899;
	Tue, 12 Dec 2023 16:45:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce3281a307so502583b3a.0;
        Tue, 12 Dec 2023 16:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702428334; x=1703033134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRAM0vwlQO98xCQV4n1w82ieufE2dSQrySJqiSHEGo0=;
        b=CMNChHMrhFVcfzA/NNrCpo/no0wpEZgNBbgBUfM7H7ToL/psLI/VSYbN19Kc+CQ/CS
         TA43R8bLaNpAWZthx9rbRTlOer/+jCSK6Py3m55rlgP+IrZsRwmhu/MgGhq4sHzapSrv
         KbaFDAhPQgmXVBzF/ux9xttGlAAXyiLj9bUhWyWpXaQH0lub8Z2QSx9CA9xYxs2Wzluf
         TEWPOrM+t4mp3rme8wvswIVgADRGBaB3uDVESESJO/qgrKVzB0sjMWjhggRUsCM6f1um
         iijqYYG2KyTJ6c+koLPvOz0fzEjvYFHzOQTxTdfonwpLGx0NPvyxM1GNG/A9Cwj5v67H
         PnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702428334; x=1703033134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRAM0vwlQO98xCQV4n1w82ieufE2dSQrySJqiSHEGo0=;
        b=UdX+XznlKvUNNOpbihPFM0V58tOy7xEVK09UES09y+4k7VtJ0gyA+QRd/WWHT92JIn
         vWsYKLU0IEKpzXBgw6TZrMpy0CrbWT1966bCEXk5eZ+/t4hlFdmAx788FmteonkEP51k
         RsOAwRRqe5zBtOqP4d/I1uwDG70qA+nodAswGgjpf11sC7EMaYSHSIxrJv/pRFkYZVbz
         3hu5NcY8emlMt4ANNNd0yX9zUev/qTlFKPjIr9TgJkG9RfH/djk7qE/jTFbX0bh77KoH
         FiihtCiH1K01uq13NaV1BYQAb+C542DjsYfRz4hTgywnZvhpjrV0SKlF6pLIVVOagSfl
         V2Yw==
X-Gm-Message-State: AOJu0YxtgoRRY1BX/aQHZanVre0U3pVhG3VrTCfOv6WJ/qnJkfeRmbL3
	8Rj04oYAeG0ffIb/Q0UzhIPS95wHX8ZRZ33n
X-Google-Smtp-Source: AGHT+IFWqK2XO+1lnodzNvDfT1I8aLZLOIBOAUM3DN+YMwjOkRm50KYVXdtxqsbcR6IKQsKkAIWKBg==
X-Received: by 2002:a05:6a20:3d29:b0:18b:c9cf:4521 with SMTP id y41-20020a056a203d2900b0018bc9cf4521mr16435580pzi.2.1702428334133;
        Tue, 12 Dec 2023 16:45:34 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id gn21-20020a17090ac79500b0028ac1112124sm2031130pjb.30.2023.12.12.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:45:33 -0800 (PST)
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
Subject: [PATCH net-next v11 0/4] Rust abstractions for network PHY drivers
Date: Wed, 13 Dec 2023 09:42:07 +0900
Message-Id: <20231213004211.1625780-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change since v10; only comment and commit log updates.

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

v11:
  - adds Andrew, Alice, and Trevor's Reviewed-by
  - comment update
v10: https://lore.kernel.org/netdev/20231210234924.1453917-1-fujita.tomonori@gmail.com/T/
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
 rust/kernel/net/phy.rs           | 901 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 9 files changed, 1087 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: 172db56d90d29e47e7d0d64885d5dbd92c87ec42
-- 
2.34.1


