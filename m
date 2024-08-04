Return-Path: <netdev+bounces-115597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B78469471CC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75E11C2084E
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB813AA27;
	Sun,  4 Aug 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3by+LjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215E1ABED7;
	Sun,  4 Aug 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814904; cv=none; b=ukaewyoKT4OLJwCF7JFFscBCQfa4V7JBuEOl1IjG1wf4Kfu2+AAZh/fFjFNZ/ur5oKgfDjMl3w55KZOoLo/rhtsrXbyqw6zIQgF38rVeRDWn4hwEQbBBtdZj3cZDl41Nc2XgGa5blNwsxTYCpnhoz36HrFRh8I1rvP4EKWM3Q6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814904; c=relaxed/simple;
	bh=A9lkjWevKEy5TGvPrk1v5VG98iKQYmSYyRvFPwITP0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DN1xIRPtMS9dvUNs1hPOdKCaNHIuX3Rg+TQfrjyaPm2wnUiRO0fR0CBb8Y4NRg2Va8IxLoDLK8igp2sVil2fnUiP7oODUvXNSF639gjYKlW1atvkM6JA+NS+lanjKWU+LotB4thuqZXbw4R95VPHayXewuckWBuHVhbtK9e+KZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3by+LjS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1876e748so1242647b3a.1;
        Sun, 04 Aug 2024 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722814902; x=1723419702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6wGj3Srs+8ICOjbRflve4DNc2/q7ft3MhVM25w7NE0=;
        b=N3by+LjSXgVb+FHnZMU3seqBff2wRblCCSHZJLfkgFnoG+IV5Sask+KAitfo6LZHeA
         7E+sA6s0rW2PJppluJZRb0Kmhym0L8oN+FF2aAYcV6RhUwkgqHrf7INrEOW4urvvU+8v
         nx1WD1Q0WpSlwEpkAGSRahY95xhya5/Zt0BY/qsNB1CHyCeqCHD48LwDSW1MoykJpNrU
         H/xyoy0LKoI0wpkaRkPGtJv/Or2rlTYiyQa8SNyKkFjvJoUVZ1hBxw5YX52SRHzGnc09
         37vbmNJ3/K9l/rJ4TORHHxHd6oue972/1x4qVsaOxcHi1+ZIuVH8RKIkDrgXgd1f7+bN
         O2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722814902; x=1723419702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6wGj3Srs+8ICOjbRflve4DNc2/q7ft3MhVM25w7NE0=;
        b=Qv7Cnk2q6NKQAwdAKB31u7v9vRQOQ2VlyaYB6Td/QJnN+6meP0MiW0HZTSZJgynBmQ
         M+RzidocQnyemv/4m4pjEypIp8mbF7istTOSgPjJVL/jnA+Pu0ow2OD9CldfMYV0rNJ6
         /ohs2DYl+SG/FkGH5kOrp3Rs5M1Qa003TgGRuvo0pUvKGi63HAT3OyiBX0HQ7exIYrL2
         0nteq2fK4dR7YRkbX8BpoHe0RWvOJb/ePE2Tjog9SreXWuOt2PL5Vi4J00+Mm7X2aiFy
         qqBN5znjSblvOrIqIAtKgBxA1GZC7bAWEgmmXL7fbK+ZaB3n5eNivYvY1kxf/6fSJeHz
         eiQw==
X-Gm-Message-State: AOJu0Yw/3mochCspsEv+zWSBYkT80u2TbJtg4pY1OptuO/wNe5H4qPAy
	ZWdd1x4h7vnzxJlO0y6Q/TxX4tMbBvLfRFkfW0FQGAaFWfVlDrHdmpybIBDb
X-Google-Smtp-Source: AGHT+IH3Zevz7B3UMfirhuSprXL2eNKUspaMIkWXl5mTJLRLXgm253Uo9zY5KgAQ/8uz5zGoEinoSQ==
X-Received: by 2002:a05:6a00:14c1:b0:710:5d44:3a09 with SMTP id d2e1a72fcca58-7106cf907femr8094624b3a.1.1722814901872;
        Sun, 04 Aug 2024 16:41:41 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece3b99sm4535258b3a.98.2024.08.04.16.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:41:41 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v3 0/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Mon,  5 Aug 2024 08:38:29 +0900
Message-Id: <20240804233835.223460-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
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

v3:
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

 MAINTAINERS                      |   8 ++
 drivers/net/phy/Kconfig          |   6 +
 drivers/net/phy/Makefile         |   1 +
 drivers/net/phy/ax88796b_rust.rs |   7 +-
 drivers/net/phy/qt2025.rs        |  93 +++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/net/phy.rs           |  78 ++++++-----
 rust/kernel/net/phy/reg.rs       | 219 +++++++++++++++++++++++++++++++
 rust/kernel/sizes.rs             |  26 ++++
 rust/uapi/uapi_helper.h          |   1 +
 10 files changed, 402 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/phy/qt2025.rs
 create mode 100644 rust/kernel/net/phy/reg.rs
 create mode 100644 rust/kernel/sizes.rs


base-commit: 3608d6aca5e793958462e6e01a8cdb6c6e8088d0
-- 
2.34.1


