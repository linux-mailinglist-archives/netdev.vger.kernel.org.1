Return-Path: <netdev+bounces-87861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 317BD8A4CD3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B505FB22B8A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99505C614;
	Mon, 15 Apr 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqiO0ug4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18D5CDEE;
	Mon, 15 Apr 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178039; cv=none; b=Lg8HIISy91sNen9sSiWb6JQtUCYjuYNk+FQ5Y6A6NRz4HifNz+zDqKV1m0btgpqCbtrWILCPydCHU8y+jiAItZguCQ+5eIh1M9/4ocdcoM9LqXKqM8+O0ffQi4LRQDs5xaZKyGjx7AsIqDxFnqxbROLpizAwTo964r7MchIJ8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178039; c=relaxed/simple;
	bh=Sjlzx/Zr4xZqjvrj31+LYvjcGtDG9IzGsg2Rm802Ajk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbhdEP1bO/1H+fLy0YwoHo0vuSACurF4f6gh/zYMUO17IqY/RJWnQqvhWZU6AX8kQBVnSZa0EvH+YtnLNfZdXLmwdodANFn0klOtIsM8cbzUsu7ZQ8IpzAEyVISuIkPXNsYPXaMN50chq8bCvvLwWNn79wpAazf8bP2RJ8sWR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqiO0ug4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso155691a12.0;
        Mon, 15 Apr 2024 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713178037; x=1713782837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSvzyT45i64CJWjrgUQNfbz+rbQkHUniNdPvK1zQ5FM=;
        b=PqiO0ug4iBp982ouT2csgGz4XhZTPXGt+G0MeMqaxsIyiDhNVlpkMGc82XGlGs8qWx
         OWho6bKkHSi5xNVHRIsiyAT42pajzTlicCIvxrK+5n+tRG0bRXKXZ8/PC/5baXo21t/P
         wdPjOy/xmjMU38gnglddz2pdJ22pkPM3iLkIRMk1yTvIRinEWI+anLm+IPrr+nNelpGL
         5hwyCAVMIoGVJnX3cAk/ibADJ4yywMKQ8/L7HZhQ1riv3FCybCQ8xEZRqiGjwz0jpArL
         Nm8xz9FAkfQSabYDzWuN2J8afmyVfpyVkf5ONZgpkbawwCG0pOLd9PT3u/GpHo7DBNkf
         +Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178037; x=1713782837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSvzyT45i64CJWjrgUQNfbz+rbQkHUniNdPvK1zQ5FM=;
        b=sxNSCe88SoVk/vfpjcKuQG66cnNgWpmOfnGDnZAdZVGaS2mkH3LQKOUekT6JOhFl9x
         g7yauOFbwH7/cBm2mceOP1JLwNO0QFttFX/fGmLmYVViKGnaXrqHcSMsPJOpGePPqcol
         lZJgPkt+569PYRkX/EIVbsK7uGMDd5Vtsmcl9Gpmv7ZL2o3XgbKU7RKoWRSjUFMXN5ye
         bZFcgVSf1e/dDHd3eRhZSF7qwNT3l7eNhW3hEBydybB11+WpA2T+3evzlSGcFqNWsvFu
         0OXFo9SppxesA+zNIr2xDOqw3USf0hwr8cQapHsRQq5pxIv2hJUFZGSwyXJRBqAiZlVG
         j1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX0YdtkQxmvBAjsTtrmXYAulYtMA5jyNuOEv/5wHwN/f8dvqEu0RWqM7yafIZwIL5NpsfWziaxwwFG+6CrnmqGMHabkQeLsEqk1kGaZhCA=
X-Gm-Message-State: AOJu0YyB/tdgoIJUS/Nd+hiQcloJhSRD23Yn6/NaJ8F4SEp1ZUA1tdNp
	Yk5vfty7b7QYaKaj5JpZtr9q6CUhShte+xFAOYj3F+o62ll17zt5P/fBPg==
X-Google-Smtp-Source: AGHT+IF4JHue3lrDDRKB7hZ42/JsiBvlIy84gr36A4SmgC21IkXL9plH2Ala03Epjmc6I+8CZRI05A==
X-Received: by 2002:a17:903:2345:b0:1e6:62df:eacd with SMTP id c5-20020a170903234500b001e662dfeacdmr3376786plh.2.1713178037396;
        Mon, 15 Apr 2024 03:47:17 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001e20afa1038sm7807806pln.8.2024.04.15.03.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:47:17 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH net-next v1 0/4] net: phy: add Applied Micro QT2025 PHY driver
Date: Mon, 15 Apr 2024 19:46:57 +0900
Message-Id: <20240415104701.4772-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a PHY driver for Applied Micro Circuits Corporation
QT2025. The 1-3th patches simply add more support functions for the
PHYLIB Rust bindings, which are necessary for the driver (the fourth
patch).

QT2025 PHY support was implemented as a part of an ethernet driver for
Tehuti Networks TN40xx chips. Multiple vendors (DLink, Asus, Edimax,
QNAP, etc) developed adapters based on TN40xx chips. Tehuti Networks
went out of business but the drivers are still distributed with some
of the hardware (and also available on some sites).

The original driver handles various PHY hardware (AMCC QT2025, TI
TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
MV88E2010). This driver is extracted from the original driver and
modified to a PHY driver in Rust.

This driver and a modified ethernet driver using PHYLIB have been
tested with Edimax EN-9320SFP+ 10G network adapter.

Note that the third patch adds Firmware API for PHY drivers. Firmware
API isn't specific to PHY drivers. I think that it would be
appropriate to add the feature to rust/kerel/device.rs. However,
recently drm developers have worked on that area actively so I added
it to phy.rs for now to avoid conflict (I assume that this patchset
would be merged via netdev tree and drm work would via rust or drm
tree). Once things calm down a bit, I'll move this feature (I suspect
that drm also needs rust bindings for Firmware API too).


FUJITA Tomonori (4):
  rust: net::phy support config_init driver callback
  rust: net::phy support C45 helpers
  rust: net::phy support Firmware API
  net: phy: add Applied Micro QT2025 PHY driver

 MAINTAINERS                     |   7 ++
 drivers/net/phy/Kconfig         |   7 ++
 drivers/net/phy/Makefile        |   1 +
 drivers/net/phy/qt2025.rs       |  75 ++++++++++++++++++++
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/net/phy.rs          | 121 ++++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h         |   1 +
 7 files changed, 213 insertions(+)
 create mode 100644 drivers/net/phy/qt2025.rs


base-commit: 32affa5578f0e6b9abef3623d3976395afbd265c
-- 
2.34.1


