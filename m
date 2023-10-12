Return-Path: <netdev+bounces-40360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D37C6E92
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459D71C20CA5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA426E2D;
	Thu, 12 Oct 2023 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9V9dEIt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47E266DC;
	Thu, 12 Oct 2023 12:54:25 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D7FB;
	Thu, 12 Oct 2023 05:54:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690f8e63777so237418b3a.0;
        Thu, 12 Oct 2023 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115263; x=1697720063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KARJWYDG1LXfd55izpQA/w+fD+DEi2wLeLv0QKgn6kA=;
        b=M9V9dEIt5y2w4gAGykKLF1R0M7XxIJ9eBosoI2q8+6wszvYD/Yibg4BL3S2sgEdNUC
         EDHtBu9iZ4RnWoaPGc/izR9rkJSg1ThdQXFLhYyzSmtFudznJQrGs0XQMSh/Vqv8wnIK
         Oq2oNQct+9aBlzCF62PlaRL23/84sRXTxhnUaOD2DuO7kwlDdcUDE3QyiGRCWv5q1tf5
         NIGIXBdGEe9aeXrWuCBfXp/7qtQGjDUX3yKloqDDtDUU8cKhYAXpMYmt3TsNHoIdh6tx
         bd9SbiKT1GpdckshA+MceT55coCdV4LAQPED8XThp4E4i4Oy7xocf+ifmX6XQtiyhDHg
         3l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115263; x=1697720063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KARJWYDG1LXfd55izpQA/w+fD+DEi2wLeLv0QKgn6kA=;
        b=bMOg7i9RgGdPG0K7JkCBTcSNgw2CDS1fmJR0k/NumVI+eg4tgOpO7ctBMd1TU5HRUT
         lk/ox3zNQ0HPwgPvxcoNGkcfxPE8I5MXOxQlLCnaogAaJ1qr1TPdYDyhLQrwz8WquES4
         uSXFmwo+e+2zdVUIk3OPAwbdTV3vYddZIdqtoW0DpMuNO0yTk889vMpkFAQ2Ef67BEqh
         +m64Q3ArUZuWPoF06t1kQWNVz80zV9oeWrwOpqtPRVJfgdDlQQB+nW5Juh5PwIZbefhp
         3oM7c1MCFvTNkEXNP8T4/Vuve3Jb9eTbwm+kO5OICQsdEhGykxjwFSDTPncSYLIlVl9g
         j/lQ==
X-Gm-Message-State: AOJu0YxTNFr+DwPypiQeFJS60srrUre6ihgX3Aqh6QJUbAH+psV/0Z5Z
	ezuS/3bxKoPsVJrWVCO9ipN+MOzQfJT40jxe
X-Google-Smtp-Source: AGHT+IHtApxvMUI38ubpSyMmGD1NGTH8jr9a2XFGjDP/XceXVELShmS8BvXPBOWZEYpfvqPsvB4lTg==
X-Received: by 2002:a17:902:d352:b0:1c9:e121:ccc1 with SMTP id l18-20020a170902d35200b001c9e121ccc1mr1409700plk.5.1697115263356;
        Thu, 12 Oct 2023 05:54:23 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r23-20020a170902be1700b001ba066c589dsm1886857pls.137.2023.10.12.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:54:23 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	wedsonaf@gmail.com,
	benno.lossin@proton.me,
	greg@kroah.com
Subject: [PATCH net-next v4 0/4] Rust abstractions for network PHY drivers
Date: Thu, 12 Oct 2023 21:53:45 +0900
Message-Id: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds Rust abstractions for phylib. It doesn't fully
cover the C APIs yet but I think that it's already useful. I implement
two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
they work well with real hardware.

The first patch introduces Rust bindings for phylib.

The second patch add a macro to declare a kernel module for PHYs
drivers.

The third patch updates the ETHERNET PHY LIBRARY entry in MAINTAINERS
file; adds the binding file and me as a maintainer of the Rust
bindings (as Andrew Lunn suggested).

The last patch introduces the Rust version of Asix PHY drivers,
drivers/net/phy/ax88796b.c. The features are equivalent to the C
version. You can choose C (by default) or Rust version on kernel
configuration.

v4:
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
  MAINTAINERS: add Rust PHY abstractions to the ETHERNET PHY LIBRARY
  net: phy: add Rust Asix PHY driver

 MAINTAINERS                      |   2 +
 drivers/net/phy/Kconfig          |   8 +
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 129 +++++
 init/Kconfig                     |   8 +
 rust/Makefile                    |   1 +
 rust/bindings/bindings_helper.h  |   3 +
 rust/kernel/lib.rs               |   3 +
 rust/kernel/net.rs               |   6 +
 rust/kernel/net/phy.rs           | 813 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 11 files changed, 980 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs


base-commit: 21b2e2624d2ec69b831cd2edd202ca30ac6beae1
-- 
2.34.1


