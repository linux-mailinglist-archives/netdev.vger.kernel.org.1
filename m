Return-Path: <netdev+bounces-119372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3152955585
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 07:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73FB1C21844
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 05:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F583CDA;
	Sat, 17 Aug 2024 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2OyNctA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D180BFC;
	Sat, 17 Aug 2024 05:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872338; cv=none; b=FkEufa/Pwlj9rHBOfAUG+LwNoSwsGdILbC9dR3YhXNpbmtwLwti10a2N1UJ6QE0gQBfFKrQq8dWZlU/jt+drDmGQIWE00ilRz6cxJ2PS6NpAUCBRcDkLy3UWuc40MEnrvIuyYzmr43k14xh4pMzNAuu06whPDyeFmz5fR1UV21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872338; c=relaxed/simple;
	bh=vmx+P1CuFEpMFLtehjO8rEQ6KRWpdZ78F9yfzsnhWGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiGFB3Rta5G1jKm09nbI4FT8jVJHaz3nfv+muMBGZRiCivlauAuv4FOGvtPKsoFJuLDWkoT45R6ukQVWGruLvNqk+Ynt2YzK+mo8c8wFNhmLOLjZg9cKmsv0m+WJ/KTwOnJITmggCkgb3mdmAPyIZM+O+xgWQ9GnbG5ubKFAxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2OyNctA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75abb359fa5so358513a12.0;
        Fri, 16 Aug 2024 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723872335; x=1724477135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p42ho0GceISUkXinglAkKZPfvE6LNt/mzihc8FFx11c=;
        b=H2OyNctAUk/cBmeoXKcJDBpirtAj7oPltmRGqZuSmph3ngljITnAg/jDk32X83Vkj7
         6lY+wb4BeIWtCz8lbbbhz+QDI4Jsy73HL6iJ8LK7JHTVJasvPUGIkz++SjokCsidv3MB
         n99oI08eJGPJbgC8MD264E6AGrXuf/5SK+LGDmkc7GhJjIUwBP260MOvU+KMpCFDbTdE
         g/tHZjftvPLnEBmrOU7Pqwoxn4YKWXw5m5hdIxtxNdAzh5lmDVt0ZWBZXiDI4Ps9eloA
         nHY094PRo1ZPO846j8iThF4CiVIeAFJVNQ1seZcAFBVouxyM/3PwObpXvFIyNgqj0np6
         +NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723872335; x=1724477135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p42ho0GceISUkXinglAkKZPfvE6LNt/mzihc8FFx11c=;
        b=Tg5pvETKn1f1u7Rhlyq0StlUWp8CI43RpVxdpM0QjcyzR+djLnyaF9Cgv6jqR8Oo0X
         9RuglRVMzxfKI/y0TuMbrlBOKlm6t2GmowI0x3Iy2ub9deUKBnA6Z48H7BPS2OxBO3Dk
         vHaLktxho+YvkqqHZhIIwEMmEUltWl95U4cA3iOOKjfY18IrMy53r8TNkkkRA3pbYMaL
         12MtDSgh8vnTISqYtfKcj7Aq/oFGpPgCGvAKC1LRDkDzq6TYEAroMG+gLH05SilxbOqS
         SD7Vn1b1kp1IXN4xYGqQ2beg8Y8u6MCl7372B9bWi/1SJPjqN/b6RuRG+oFS6YN31AF/
         nohQ==
X-Gm-Message-State: AOJu0YwUm1CS5JHgtOcoc+KKjxQrBkTeOqqMgi5d+5Q6hzpupnuO+d4a
	ZEoOay7sUhmsU0EfSh1yu3wemnbhulU4uni/Y42JYgrKRKGOYxH/R/1Ceq5U
X-Google-Smtp-Source: AGHT+IGQhRld7X/X0M+1Z44rg/Add/4qe0B69pfNjrAYUav7vg4qbhjy/VoGx+th7WnhAa2Y0Zp7TQ==
X-Received: by 2002:a17:90a:d517:b0:2d3:c488:fa6b with SMTP id 98e67ed59e1d1-2d3e151f6d8mr3336291a91.5.1723872335246;
        Fri, 16 Aug 2024 22:25:35 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74e33sm2881655a91.39.2024.08.16.22.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 22:25:34 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v4 0/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Sat, 17 Aug 2024 05:19:33 +0000
Message-ID: <20240817051939.77735-1-fujita.tomonori@gmail.com>
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

v4:
- fix the comments
- add Andrew's Reviewed-by
- fix the order of tags
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

 MAINTAINERS                      |   8 ++
 drivers/net/phy/Kconfig          |   6 +
 drivers/net/phy/Makefile         |   1 +
 drivers/net/phy/ax88796b_rust.rs |   7 +-
 drivers/net/phy/qt2025.rs        |  90 +++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/net/phy.rs           |  78 ++++++-----
 rust/kernel/net/phy/reg.rs       | 222 +++++++++++++++++++++++++++++++
 rust/kernel/sizes.rs             |  26 ++++
 rust/uapi/uapi_helper.h          |   1 +
 10 files changed, 402 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/phy/qt2025.rs
 create mode 100644 rust/kernel/net/phy/reg.rs
 create mode 100644 rust/kernel/sizes.rs


base-commit: 399117317001d0f5bf4194feccaafa62b12e744f
-- 
2.34.1


