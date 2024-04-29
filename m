Return-Path: <netdev+bounces-92026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA948B5045
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 06:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BFF1F225B4
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 04:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2CEC2;
	Mon, 29 Apr 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XChONofA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30982907
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365579; cv=none; b=eXV2mxRxD6ho2OretKoPBXnsCkKLY3LwpL0myTNjftwBnT7JUDmgpUSxGg8tERxt14qRkfmEWPo8lfmOGTyAWCQ7eFhACh5LVjgEjP3vqZPHQelY0hx4GHg8tv4kvz6WNWLFQCRMvmvSRluNXoP0LXbTdWJnTvfsjWd+g4IbxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365579; c=relaxed/simple;
	bh=r/XIfR5EcdkykaDN/M+V+Nzc4VnCw4vbx5xcRlnZS6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrpqcAh0rWmjJpgEFVrEu+Lj14ho5ntPKgx3lapI7MzWqCZohvzxSO7UPyBd30SygyL9Z/e14VLvERlBZsAsxT7hzsiQR+lXhmw64J+NA46kTxT3YNnCnef1Q7WrxnnYNmOY9pl5Z6TUI93J20f9HF7+lsiqPdevtBCEHsKffgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XChONofA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2abae23d682so1052528a91.3
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 21:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714365577; x=1714970377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpD2KKLFMe+IPvRLqxOVN18mobSRa8XCwFl+iN12MEs=;
        b=XChONofAGHZGoKKbxidNtuagiAea5AjgdEzxu3jIWR/qoP8GW5eHNosuEtm5HhyhwL
         rCNfs/3HIcZFAW2cSY+mzUFlQRKDcGLpcJJCObSVb27cswIyCOwYHW6uXMrLpWSNQmbd
         udSTTDSSs3RLro6yB+r/5jdxSkNB8ftheEtBY6RGZ9RWQvsjmEX0z4urq3JqEGnRnsVr
         jR3uFZZ+1JrmVO5rMVA3WiW21KSI9llCaZbYVgFqxDLIP/8jOhJvyoavYlMh1I0Lsa4Z
         kCkU7IkcG2uBGSZJIFf+e/HJslRqozVPLPq3QsUZnojXjqbTWBX0tUHO16cwF5C7JHdN
         sJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714365577; x=1714970377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpD2KKLFMe+IPvRLqxOVN18mobSRa8XCwFl+iN12MEs=;
        b=RCCfg9wUFzcGS1wg9XbElywnZphiDf8hrVJd4akfGqCwY88uYofqw46i6VXNQ96Tgl
         olAq584GXW2CjFUCQR0VKMUEYvzwe8dPn0MSdpP9Eda/sa8tIWUU6Gx5N2aDv6eZtFFp
         7dYaE9M5a53OLkWUfb5WFMMLcBdlUzgZ55Geca+lD4x2BkneB7Yqbcd7x7UjzCeODMDf
         B7ClCvCeMsxJsJhyeTVYbsfrHMzsMepyjQc/03Yp2RttKI8yw5VGHokvkUDAOKlBwrNz
         711CumYMBem1b1o8zjk3KVuasCJpSO+dEdojUldphF9GaAEfehbPBYyL1NTwbnpdJiiv
         oA4g==
X-Gm-Message-State: AOJu0YzyFhg3EiAASv17oeFcEajH4R5+YA8Jiv/FADAhfxrS2Sx2bABB
	feXxmbIkJbwSi3Zt+j6HKG3vPmk4ePjYgQzQEPYTzuzoNww6InJtN996Xw==
X-Google-Smtp-Source: AGHT+IEzZ6EV1zjJYK6CaC+LPGmCeKLJR07CxmkNm0R+2/Ceg97qbSdID3mbygkzkavvivJjvEPRsg==
X-Received: by 2002:a05:6a20:3945:b0:1af:3ad8:40e with SMTP id r5-20020a056a20394500b001af3ad8040emr6540059pzg.3.1714365576583;
        Sun, 28 Apr 2024 21:39:36 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001ebd799bd1csm796129pls.13.2024.04.28.21.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 21:39:36 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v3 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Mon, 29 Apr 2024 13:38:21 +0900
Message-Id: <20240429043827.44407-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a new 10G ethernet driver for Tehuti Networks
TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
(drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
chips.

Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
based on TN40xx chips. Tehuti Networks went out of business but the
drivers are still distributed under GPL2 with some of the hardware
(and also available on some sites). With some changes, I try to
upstream this driver with a new PHY driver in Rust.

The major change is replacing a PHY abstraction layer with
PHYLIB. TN40xx chips are used with various PHY hardware (AMCC QT2025,
TI TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
MV88E2010). So the original driver has the own PHY abstraction layer
to handle them.

I've also been working on a new PHY driver for QT2025 in Rust [1]. For
now, I enable only adapters using QT2025 PHY in the PCI ID table of
this driver. I've tested this driver and the QT2025 PHY driver with
Edimax EN-9320 10G adapter. In mainline, there are PHY drivers for
AQR105 and Marvell PHYs, which could work for some TN40xx adapters
with this driver.

To make reviewing easier, this patchset has only basic functions. Once
merged, I'll submit features like ethtool support.

v3:
- remove driver version
- use prefixes tn40_/TN40_ for all function, struct and define names
v2: https://lore.kernel.org/netdev/20240425010354.32605-1-fujita.tomonori@gmail.com/
- split mdio patch into mdio and phy support
- add phylink support
- clean up mdio read/write
- use the standard bit operation macros
- use upper_32/lower_32_bits macro
- use tn40_ prefix instead of bdx_
- fix Sparse errors
- fix compiler warnings
- fix style issues
v1: https://lore.kernel.org/netdev/20240415104352.4685-1-fujita.tomonori@gmail.com/

[1] https://lore.kernel.org/netdev/20240415104701.4772-1-fujita.tomonori@gmail.com/


FUJITA Tomonori (6):
  net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
  net: tn40xx: add register defines
  net: tn40xx: add basic Tx handling
  net: tn40xx: add basic Rx handling
  net: tn40xx: add mdio bus support
  net: tn40xx: add PHYLIB support

 MAINTAINERS                             |    8 +-
 drivers/net/ethernet/tehuti/Kconfig     |   15 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1875 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  275 ++++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  132 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   61 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 +++
 8 files changed, 2613 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: d5115a55ffb5253743346ddf628a890417e2935e
-- 
2.34.1


