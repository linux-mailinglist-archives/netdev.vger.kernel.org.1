Return-Path: <netdev+bounces-119515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E719560A9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2081F20F18
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4517BCE;
	Mon, 19 Aug 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA/Rw6AS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB5C125;
	Mon, 19 Aug 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029234; cv=none; b=MtlTIhj6EvKsUf/W7FoqnshaJred8GOWPSaJkaq8rq156h5LRdxAMIRuAdRbXRgor5k9JkRBoRUKp+epaY+gIQJ8WGh3N7myDzvABI5RUyOKjta2eCHFOavclfYre18HRE+5kKM1oRsFIFpP+F+j3LYvoTV0T5tgQyXuASf0kCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029234; c=relaxed/simple;
	bh=i8dzXzoIGeUTIahgTpQr1S2802s5SPb2+Wh6eH4Hrx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIBF0BtQb5+iqdbw8Puh3zeo+KrCK0N0Qw0pvU5GGsJVIExVKw7kcSZD7xMgBO0g8tBlpyCFoHWE9HoKXD0amh76bTKawYUDkm51vprQGbS4ZEY2ZvPqsvqT36IrtVUc9t9Ixvr2Y54KHJBE0leDIr3wystjw7nAfwDwx7aTfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA/Rw6AS; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2702920904bso252002fac.0;
        Sun, 18 Aug 2024 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029230; x=1724634030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wqgfroSmatXP/ouuo8bFCtUF9kvNxtAke/43gLoC83M=;
        b=IA/Rw6ASmxcIj5x96+f8xn6pRwxGivsLYHIcFQMHVP1VMgDwQUVf/6ELmHY++QAg3I
         +lshdaTdaKZSrzI3akl4O5S/kD4vVSS0J6DW0HYIxSfi5gSK9kDzBhwhRuaEZSagTa/5
         QRZf0KHATymAKuy1EMeD8ft9/Mk2Zc/a+TzEcodJolDIOOKAd1G96LBc8R2U40KFjEj9
         BYgK6AXlCcXTpGJoGeYq5L2/ub32BqZE57u9SzkIfRO5OBh7Vm1oDKs2ZvzQiUwiqyk9
         0uKT0Rd+SyBGrDHYKPcbJArAgIS2E7/XGGBAkI4li+fq0NRKt2ffdL7+H1zfKJhl1AXV
         udig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029230; x=1724634030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqgfroSmatXP/ouuo8bFCtUF9kvNxtAke/43gLoC83M=;
        b=r1WaYXwAzrvqpfWb7iRlg5oxYI1P3JDyV3gCy+f/h14V0fOGbGnfXQsBE9lPYH9ulF
         CV9tt+PbMo/EZbnrxRZHCycOKBnoV/W6XaJavMzNI6unpYSIz788dRQC0WTSO8QA5Q96
         1TZuKWwL5T2om4/lbXd7G1jijlzm3BfHSqq86/FwieJZWrbkbJeTJh4m2Qdb41JuxA58
         dSUt4h5vwGaIelKajSdpOri4FyvZwdEQnu/PI00IADjcrTCXUNNMGsnTTGf0n2jN9f6V
         eiFpGVksrSJlvs7noe0yWG260Wz2lv/2qCjAaWBe3lW/fcBQsmav7gDgw2WGanEmEgD6
         g7iw==
X-Gm-Message-State: AOJu0Yx9CaBNT78dxV47Pgb+1cPdYFlylIaoWD7G+8GX6CywH2QGYiUd
	UChWhjt7NHpxHhhBkpWU8OkiFTHIvCxZxNVSpVjHhigtpKPDtfeBulMJ5i4U
X-Google-Smtp-Source: AGHT+IEMoae07P9rDRT0dXyQ9dSVVgwVhGzWb61AYqDoY9TA+57G2L12ogu8/txDRg+8n6icJP2NRQ==
X-Received: by 2002:a05:6870:524f:b0:260:ccfd:b26f with SMTP id 586e51a60fabf-2701c52f1f6mr5559274fac.6.1724029230154;
        Sun, 18 Aug 2024 18:00:30 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c4a7sm5718732b3a.193.2024.08.18.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 18:00:29 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v5 0/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Mon, 19 Aug 2024 00:53:39 +0000
Message-ID: <20240819005345.84255-1-fujita.tomonori@gmail.com>
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

v5:
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
 drivers/net/phy/qt2025.rs        |  90 +++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/net/phy.rs           |  90 +++++++------
 rust/kernel/net/phy/reg.rs       | 222 +++++++++++++++++++++++++++++++
 rust/kernel/sizes.rs             |  26 ++++
 rust/uapi/uapi_helper.h          |   1 +
 10 files changed, 410 insertions(+), 43 deletions(-)
 create mode 100644 drivers/net/phy/qt2025.rs
 create mode 100644 rust/kernel/net/phy/reg.rs
 create mode 100644 rust/kernel/sizes.rs


base-commit: a99ef548bba01435f19137cf1670861be1c1ee4b
-- 
2.34.1


