Return-Path: <netdev+bounces-114387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B63942556
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F589B210B4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2A1946B;
	Wed, 31 Jul 2024 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N76543o4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9F1862F;
	Wed, 31 Jul 2024 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399735; cv=none; b=qCMIiLuMq3Z5zFgadlGFCuaqpmJEikdtOFSQOeMLtrJFMB3c453EOEw77FK55D9fABteSFPhLNp1uHXnpcG0dH2SF0KKQdTNSU1KzDepWi2OdmDKHHNecsnGzZcWx9W/q17zQuJI7B6GFX/DOj7FvDRtYGiLU3PnfF+NY5ACyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399735; c=relaxed/simple;
	bh=qeDU079LYh8OWFGqojUUzmfS0be1shKPfjdrLNWpM9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KRbOM4jFAHceLwlWeCO3ZyB57smF42/3BI3oKrCQJw3dqmGB4mxVhAA743Ut+GE3t+NCmy7sM3xRIMZrnLhecqKDh12TPDDauRNZ2cA1eEt+ZzzaIWV3Jkt+pLSXvjhtOdzfZJklk6c0NrlmaxCMU76H5a0SuQRWvbhQOwV2Q8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N76543o4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb6b247db0so913465a91.2;
        Tue, 30 Jul 2024 21:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399733; x=1723004533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d2mS2/e3ojtrftx3dXd9g6HWv6C9RGRQRO2kjhQS9mA=;
        b=N76543o4Aq4VkQ1W5wL6B+M+ED/Q0W+mN9AcjEB3rD+xAbzJAq5H36bb6M2HyA5j1h
         qPXOFP7SObwZtOfricAtkdRuFAhBXHVpuOzVSAHL78AMegnrqZCnNE4tR0qeLJCjcglP
         UXIJBz5iHTPNSj46UEnieMtGVhznW3/bg6kQqupH2fyVs7qZ99beseRtC8+7fHPitgsc
         hYyh8rzT7nhea5CUt9o/fTfKSh6mWVA0UI+wuqnh/ra8rUN7Y4/PoBjCp/hl+UIllQWh
         Z0bQwhuINoqYk/Dt+aEQuMzIZY/XWsBz7d4bauQgm7B83TXvTvV90yQtQEZad6AgtrRT
         JARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399733; x=1723004533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2mS2/e3ojtrftx3dXd9g6HWv6C9RGRQRO2kjhQS9mA=;
        b=Bfjj61ItZbQLONpl0GaY7ChBKrPy47prjruObab2PawihkJWxl+m5X8kdzHDEyFE4g
         9Qoe24PdlCi3bPzQ+lO1+zr24T+V1vuRe6kP62ZMvBqOGGW4Gsg3Yfz3zAA8sR+lt7yM
         WFFEIS+d5M6MJvfCrG3859Q/aR6XimJp/eWKsfi1X4/d6ycSWvBzqMyqKBRrbpnuJpcj
         NMnvtD0p7SFG9iBkMQqnXYqF0OLtThzRGSyMgDJ3uyspI3jRMKX8/ixGgSGgdEa5N52z
         6nFyh6/13LrsjwDMbY9ohAC95X18DaDWuy4xpWQpSPlo4pqNw7GM5RG6f4H/vufuf+uY
         IsRw==
X-Gm-Message-State: AOJu0YwuqY9dJspf8TD8Zi1AKJwlhc+qs7o+fY/ynblVms6uzXB+d9bd
	FpD/TlZvUJxlnDmm7cvJMAcqeUAErhdRKoeZupaX7SVOZQ8wXRL376IlIW2Y
X-Google-Smtp-Source: AGHT+IENMZoJPj8Q5u6X+/yXP2my5AYfOEEFLbYFjvtVGtFGP3Xre3Amak5+tWJDemHhze9IIYNB9w==
X-Received: by 2002:a17:902:e546:b0:1f2:f9b9:8796 with SMTP id d9443c01a7336-1fed6bdd93dmr122476355ad.2.1722399733186;
        Tue, 30 Jul 2024 21:22:13 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm110815145ad.18.2024.07.30.21.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:22:12 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH net-next v2 0/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Wed, 31 Jul 2024 13:21:30 +0900
Message-Id: <20240731042136.201327-1-fujita.tomonori@gmail.com>
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
code more readable.

The 2-5th patches update the PHYLIB Rust bindings. Note that 4th and
5th patches are already reviewed by Trevor and Benno.

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

v2:
- add comments in accordance with the hw datasheet
- unify C22 and C45 APIs
- load firmware in probe callback instead of config_init
- use firmware API
- handle firmware endian
- check firmware size
- use SZ_*K constants
- avoid confusing phy_id variable
v1: https://lore.kernel.org/all/20240415104701.4772-1-fujita.tomonori@gmail.com/

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
 drivers/net/phy/qt2025.rs        |  92 +++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/net/phy.rs           |  77 ++++++-----
 rust/kernel/net/phy/reg.rs       | 219 +++++++++++++++++++++++++++++++
 rust/kernel/sizes.rs             |  26 ++++
 rust/uapi/uapi_helper.h          |   1 +
 10 files changed, 400 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/phy/qt2025.rs
 create mode 100644 rust/kernel/net/phy/reg.rs
 create mode 100644 rust/kernel/sizes.rs


base-commit: 0a658d088cc63745528cf0ec8a2c2df0f37742d9
-- 
2.34.1


