Return-Path: <netdev+bounces-120363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE939590C5
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E961F229D3
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888101C822E;
	Tue, 20 Aug 2024 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcO22625"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5D1514FB;
	Tue, 20 Aug 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194748; cv=none; b=pxuBnnQfIM3HR04ip5tyijlfdMFbpok5b4xEUXNyOWjlqrj6hGchv5WJ06XQpd588dEd4PsimH+Q66afWpaheI9ogFpybCcO8qOyWQQuWty6Nf7c7z37AMzUs/si6NzrV1weNlQQNVTFyxWh1STFCrxxj9ZzpEBp1ZC/G7w1x2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194748; c=relaxed/simple;
	bh=HHCPIDvyK05qfa4SNsfZaOc8FCBXhRJR62AYAZNyhns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1wQezQTKEDbkvPNtBUPIZ0JwK9EKbUucXXALEo6oE/WuV2Rw6drLGQsppsWGlT8t9wvlGEg+RlDwEVjvTEDobp/yXKJQB7PE2dH5dmRg640n8JbC0Wpmp7Rq4WoV/LwUIEs3MnHT/C9zQDZiXBcvwiRQeCCDaTjDmGBFWRbYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcO22625; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70949118d26so4960120a34.0;
        Tue, 20 Aug 2024 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724194746; x=1724799546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjLAXEC9qZatTjv0VKwa8ha+bQsXiBEJ+z4SyznFSZU=;
        b=ZcO22625OxyptzZBZl0wwriHslIoRdiXLrZzsMoZEMacZ/41xqBscsdVRYR9EuFWJO
         fgtHfjLh9lneYsa2DDtkdlaostSrV4N9L8go3LVXuEaiy0XMSwBXGulgx6omXhBVzZfx
         pjr+LgvRXWqYATLI7y+yT6O9cFMUzsknURzBsI9fWB7ozWJZChkmtcZgTrHsYimZzDfP
         xoariXM6xq6UurrcasLclfOhls89SMIBvAwGCOkq93r0tlWolRepV5cj3Z0Z++ZOEWSX
         ZBHqjyk4ggk/OdGF0jATyLL2Qv9u4XN21JcCT3ezTYvpiuJPkqtXyPGMQM4aXq5jZiWb
         wfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194746; x=1724799546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjLAXEC9qZatTjv0VKwa8ha+bQsXiBEJ+z4SyznFSZU=;
        b=DYDMQLM/k3343IzHvoWDdgud8M9b9JqBclaL6M4n3NQ+junIwvdsuNnrt1eicKoiJl
         ruy19cu1gd1ijSwcicu7/K368OhX1xaWzrjzrJxYaUpVptne3g1dnKl4Tx980twFf1KR
         Z60FAGdBMlzuvAhjKvFoj30HjTa6k590wATHEQNaGVkjP9fkfKWvhTLWzoU+lO7p+7xv
         W4VbxO4kMqalyJ/euknmYZHd8hyPGRqJWqCT+xn94CKOedVKysBu0SVAYmK36olFxlJf
         cbFyPKLQD6UWC/zhr1TPSMIPrRKbeEQVvb5MxVpd682IFLs9EFKhI8W7WRlA3uCMqoZO
         ZHCw==
X-Gm-Message-State: AOJu0YwtwmYl0W1WJxcwoik3P8+3L+ilmUTTkptkhErw6JbwYuO36g2c
	BojM3QZKU5doy0TT93jwq3SHLX4hBRTfQXLa+xZoRNnxmMrAupcsWOfFNOpm
X-Google-Smtp-Source: AGHT+IGHpO5Q3mnCh4JIJA4nu887E2L5xIIjDKHAwI2uM77WDdMTXNBPfBTKxqseuUPtzzvGCNvtUg==
X-Received: by 2002:a05:6830:440e:b0:70c:934c:b1e2 with SMTP id 46e09a7af769-70df85f0f2dmr530769a34.7.1724194745665;
        Tue, 20 Aug 2024 15:59:05 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61d5045sm9922076a12.38.2024.08.20.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:59:05 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v6 0/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Tue, 20 Aug 2024 22:57:13 +0000
Message-ID: <20240820225719.91410-1-fujita.tomonori@gmail.com>
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

v6:
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

 MAINTAINERS                      |   8 ++
 drivers/net/phy/Kconfig          |   7 +
 drivers/net/phy/Makefile         |   1 +
 drivers/net/phy/ax88796b_rust.rs |   7 +-
 drivers/net/phy/qt2025.rs        |  98 ++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/net/phy.rs           |  90 +++++++------
 rust/kernel/net/phy/reg.rs       | 224 +++++++++++++++++++++++++++++++
 rust/kernel/sizes.rs             |  26 ++++
 rust/uapi/uapi_helper.h          |   1 +
 10 files changed, 420 insertions(+), 43 deletions(-)
 create mode 100644 drivers/net/phy/qt2025.rs
 create mode 100644 rust/kernel/net/phy/reg.rs
 create mode 100644 rust/kernel/sizes.rs


base-commit: af3dc0ad3167985894a292968c67502f42854e6d
-- 
2.34.1


