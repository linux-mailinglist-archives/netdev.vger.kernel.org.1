Return-Path: <netdev+bounces-122645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F496215E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86079B24124
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A715E5C8;
	Wed, 28 Aug 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBXR4b4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427B15E5CC;
	Wed, 28 Aug 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830608; cv=none; b=HSKIZN4btAkapPkfV+QGW+5wL3HPGlj79izSWXeldkoBHn1Yw+3ZIwl2LY2Fx+MPm/7PBVKtGg2Q17lf50sAxjW22kZe/Hz363JlOroXxiv+QTo2XAY98IeBHRyNk8novoAvEs7WHs2dXRtYisggmtv3AKfNXjb0qj0spNH+6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830608; c=relaxed/simple;
	bh=tjx6aDgFIFmvml9PiOXA4U5FFlWfhzPJzpbub2b9Fmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIOqDL091316OpdZSJ0sf74rPMfN44Prw01EwKaCEo6HjMKoTwnkfUl3HvF0rV2B0JI79o0R1hQaOZI70g/jB6jel791MEMPSN/4lMnWAtbe+OhSgb6inQwh4XErDTWoVs0+IcC2wtT7wx5egwThldTUiMtFzBaVfSGcaq5uNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBXR4b4J; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db16129143so849146b6e.0;
        Wed, 28 Aug 2024 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724830606; x=1725435406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFaF8mgDB/FxYdF9gGSTXl/OQne4OAaLSsj+Srtrcq4=;
        b=SBXR4b4Jvd4AUAf0wIb8n6jX7SPeSl+geREO9xHk5h3s3WQj9lWE3Tu1PtcoEXeAjP
         TPTM87zcHXRbUmjPNzl271rHbC1ml+aHSdYdGdDrQwKS8KNBXQE2U2MVyxVUfVaa69tl
         qjGmKMLOo78JcPkbVK6b7MqZTVmd8um+0SJYnvyA1X1f0IsveKWYhZCfXRgcAWWimHHH
         hKkq30MY4bxmb7eHWh5T+s2opR81i1aa9fz87yP8ryhHRg3g61Nv0qJg1/WWnfBpynEw
         j4jOUJmOyni8ptwt/uEFUqXPms7b1cFvhE/Bi+uJ4h422hEYi1dP5VI7mucpY+c5+Ap+
         zbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724830606; x=1725435406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFaF8mgDB/FxYdF9gGSTXl/OQne4OAaLSsj+Srtrcq4=;
        b=bjqTKxM5EpaI8u0X/hGEAkZjimvvVvKYqJ52+Fy8C2Qke0biR3vzqCbs5zfN8duWr3
         G9CmALmrkBIbrpwV+rcQZlLoJm2mhtUnYunx/KKGeaJBFweMb1fu8gaSgtBlUc6PVmoI
         Hbimmy9uuioCv4+0bnaRLB4iEb2M77omwQbUshalM5TgkfWMfoI94RrRAXY7rSQB4fmq
         MW+t8C+/WO139jTPIfqs+CEZ+2HPDUS5J3GWmeQ/jN35K2ESNmIg3sPSh781+3cddSH1
         Fh4C/W591EgLFk8sy1aYk+qhxeWUwe5aMh3Q6bhZcMr8i+ZRXD7EVZs+OIuIrN6CytAy
         Y1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWg4w1srOANSgGO7u9ohkEI174LvFuxNgndK9pXHkNzm4Sa/xFne2bw15YjgaQ9/APS/j0Llc1eRkNzAhGdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uDY3EaQDBTA1Ja0ej7YuiCQINDordxBzPGK65S0LZnULUAsq
	Fs5xpK7zrgaGOVAcctu5+9P70+rCLNbt5ulmEReVHO+8w2iBmNXAqF1q4MGPGEc=
X-Google-Smtp-Source: AGHT+IFgfWgs13tzfnrdCGULEiFwecBcHNlfIMBylQ7wiJyUg03sPCNgIBiji7aTPf9k+G2mYSlmEw==
X-Received: by 2002:a05:6808:22a4:b0:3da:ab86:bfd7 with SMTP id 5614622812f47-3de2a869f8dmr14632341b6e.3.1724830605843;
        Wed, 28 Aug 2024 00:36:45 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98286sm9016225a12.5.2024.08.28.00.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:36:45 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v8 0/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Wed, 28 Aug 2024 07:35:10 +0000
Message-ID: <20240828073516.128290-1-fujita.tomonori@gmail.com>
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

v8
- add Debug trait to reg::{C22 and C45}
- add Andrew's Reviewed-by
v7: https://lore.kernel.org/netdev/20240824020617.113828-1-fujita.tomonori@gmail.com/
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


base-commit: e5899b60f52a7591cfc2a2dec3e83710975117d7
-- 
2.34.1


