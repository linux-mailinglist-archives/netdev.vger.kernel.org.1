Return-Path: <netdev+bounces-121555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BA95DA7D
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B460C284760
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95CC14290;
	Sat, 24 Aug 2024 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayBGrfUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEF179AA;
	Sat, 24 Aug 2024 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465314; cv=none; b=cYF9ge/2WeG2zecuMyV+lKlxAmvi8RIt1hDZTb5XzFt0178Q06o3nVzWbw9TDCEkk75g0NaK+GPZUhejbEVcbvMMA+7W60k4shbFEdjjBnrQHjWiyIgdw0x+OVrZ6SsE5LMUpy4CsRuj5QfDuw9S2rwmJoVkl4Ug5k8OLkjW4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465314; c=relaxed/simple;
	bh=GbX4khao5Gqa9QXP6hc+sSmMnX3ZI2xvuWGpgSnvv2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAh5nfacI91FE5swLrzPflYKBsxrZ4oSy0xYoAjH3Qe5Qnqa+OPxNvIkw3ovCx6OtYuMGBuswtiH1bldiVOnrQc5/AcNqyRNaw5cdRwMVV+R0DGiCCyMjpa8NKBF9xcrHe/qFrrP8oomxYwgOkRdgdsEonoWbTJe5rcLN+PxscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayBGrfUJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021c08b95cso28730815ad.0;
        Fri, 23 Aug 2024 19:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724465312; x=1725070112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Or1h62UcyIfIvC9Isz/3yZD0qLR1qHYZktC9TocjD/g=;
        b=ayBGrfUJaZgKEVRu3vkpH/CnHC/A9yaMhSsJxoOk1/LQHtZNYPntz/ERL/D06rrj0w
         jNscALrWqCLEhjFbQXUh7G1n5qx50ICEFbekkZoprzeV6c2y+rPJgS2/Jui61NJO6A3m
         FfLDAhYaJlYCIEXCqBrs7hvwAn4IbULRuE67gA81mGloviQ3rVT4eQnzLX+gBTiuMXFf
         CO5dv8qnZI7qgOF5LnaYzISLKRd9Gyzko3g+aw0FH3/WnvhGQmURrDhRxethuTTqSs3Y
         c1+eVPeILKUR1+QulILcAe4V/xWzgMs9dcVTtl9KzqVmndhmzyXGxku1b7rlYx+j79oy
         kwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465312; x=1725070112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Or1h62UcyIfIvC9Isz/3yZD0qLR1qHYZktC9TocjD/g=;
        b=tNNlksPgJkurCzNPHunNDSXpc8A5RzdtQd8YOwkC/17FMrzwUThfQyTRefgYQNZDAu
         tPIp0ZtFD34XmUHUkSK2GpHsW5/SPrNu7rT2GmqNSvPEicGDPNQYQ5ZhFk34qF+b2xI0
         avxscG24ZncmTl8eJ2R3S4Rj0kVpTDcQynYQojhLTVp1rSyeDwRJ8Lox4TRiTyiZw4xx
         pqyJl7uG++vAMqRTYrVDc3SMpt5Txmm75iCWoWkJwyPXt1VnT32wUOq/xHMszAm5bKxG
         yRKNX3Zq46Luv4rl7RtjV5GeSu3oT98TAN1U/CE/07QsQcnaz29fJ+GDA0kdIRKB9A3p
         EefA==
X-Gm-Message-State: AOJu0YxgYWyo1+slubzwvYl1HbITdA66+EjzqIrQJho+NLrEIjj8RPPG
	Pb8+DURbpEpywtEN4a8VTjF0w3ytKlRY3OQeuwxxn9fdGTSeBnt4vgHKgk7j
X-Google-Smtp-Source: AGHT+IHS37zrS3GN5HsCSeBnS5Hz7WbG1HNogM4zb9BRfIiOafaoGbncmgEHfwzC08PEytit9jnAJA==
X-Received: by 2002:a17:903:32c8:b0:1fb:2ebc:d17a with SMTP id d9443c01a7336-2039c50a20amr88249955ad.23.1724465311865;
        Fri, 23 Aug 2024 19:08:31 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855809d4sm34393875ad.95.2024.08.23.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:08:31 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v7 0/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Sat, 24 Aug 2024 02:06:10 +0000
Message-ID: <20240824020617.113828-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a PHY driver for Applied Micro Circuits Corporation
QT2025.

The first patch adds Rust equivalent to include/linux/sizes.h, makes
code more readable. The 2-5th patches update the PHYLIB Rust bindings.
The 4th and 5th patches have been reviewed previously in a different
thread [1].

QT2025 PHY support was implemented as a part of an Ethernet driver for
Tehuti Networks TN40xx chips. Multiple vendors (DLink, Asus, Edimax,
QNAP, etc) developed adapters based on TN40xx chips. Tehuti Networks
went out of business and the driver wasn't merged into mainline. But
it's still distributed with some of the hardware (and also available
on some vendor sites).

The original driver handles multiple PHY hardware (AMCC QT2025, TI
TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
MV88E2010). I divided the original driver into MAC and PHY drivers and
implemented a QT2025 PHY driver in Rust.

The MAC driver for Tehuti Networks TN40xx chips was already merged in
6.11-rc1. The MAC and this PHY drivers have been tested with Edimax
EN-9320SFP+ 10G network adapter.

[1] https://lore.kernel.org/rust-for-linux/20240607052113.69026-1-fujita.tomonori@gmail.com/

v7:
- add Trevor as Reviewer to MAINTAINERS file entry
- add Trevor Reviewed-by
- add/fix comments
- replace uppercase hex with lowercase
- remove unnecessary code
- update the commit message (1st patch)
v6: https://lore.kernel.org/netdev/20240820225719.91410-1-fujita.tomonori@gmail.com/
- improve comments
- make the logic to load firmware more readable
- add Copy trait to reg::{C22 and C45}
- add Trevor Reviewed-by
v5: https://lore.kernel.org/netdev/20240819005345.84255-1-fujita.tomonori@gmail.com/
- fix the comments (3th patch)
- add RUST_FW_LOADER_ABSTRACTIONS dependency
- add Andrew and Benno Reviewed-by
v4: https://lore.kernel.org/netdev/20240817051939.77735-1-fujita.tomonori@gmail.com/
- fix the comments
- add Andrew's Reviewed-by
- fix the order of tags
- remove wrong endianness conversion
v3: https://lore.kernel.org/netdev/20240804233835.223460-1-fujita.tomonori@gmail.com/
- use addr_of_mut!` to avoid intermediate mutable reference
- update probe callback's Safety comment
- add MODULE_FIRMWARE equivalent
- add Alice's Reviewed-by
v2: https://lore.kernel.org/netdev/20240731042136.201327-1-fujita.tomonori@gmail.com/
- add comments in accordance with the hw datasheet
- unify C22 and C45 APIs
- load firmware in probe callback instead of config_init
- use firmware API
- handle firmware endian
- check firmware size
- use SZ_*K constants
- avoid confusing phy_id variable
v1: https://lore.kernel.org/netdev/20240415104701.4772-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (6):
  rust: sizes: add commonly used constants
  rust: net::phy support probe callback
  rust: net::phy implement AsRef<kernel::device::Device> trait
  rust: net::phy unified read/write API for C22 and C45 registers
  rust: net::phy unified genphy_read_status function for C22 and C45
    registers
  net: phy: add Applied Micro QT2025 PHY driver

 MAINTAINERS                      |   9 ++
 drivers/net/phy/Kconfig          |   7 +
 drivers/net/phy/Makefile         |   1 +
 drivers/net/phy/ax88796b_rust.rs |   7 +-
 drivers/net/phy/qt2025.rs        | 103 ++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/net/phy.rs           |  90 +++++++------
 rust/kernel/net/phy/reg.rs       | 224 +++++++++++++++++++++++++++++++
 rust/kernel/sizes.rs             |  26 ++++
 rust/uapi/uapi_helper.h          |   1 +
 10 files changed, 426 insertions(+), 43 deletions(-)
 create mode 100644 drivers/net/phy/qt2025.rs
 create mode 100644 rust/kernel/net/phy/reg.rs
 create mode 100644 rust/kernel/sizes.rs


base-commit: f9db28bb09f46087580f2a8da54bb0aab59a8024
-- 
2.34.1


