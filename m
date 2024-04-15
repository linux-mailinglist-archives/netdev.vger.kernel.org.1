Return-Path: <netdev+bounces-87855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9A8A4CCA
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596412829D3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CF5C614;
	Mon, 15 Apr 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnL3ASRP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B355D732
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177849; cv=none; b=f31x1FZaQXH2AuQyPPl9XGkvo5e/QjoHI4h/Wq3gJIzUZwhfutj5yd2m5HIY9DS48MHJIrLnAWCB9ldsTt8tLPv5ADRuZ8osSQ/KNbwjC+YXO3qMwFxOAcTjIFymVWYL8u1/ormN2RSez6jKRuDqWbVNWF2xp+eZ0BIQP+qE/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177849; c=relaxed/simple;
	bh=buje0Digs+F8wkoIIhoq52lfGLYXrXdxgkwkbJQ0Tt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clI6c8XQPQ0cNt7EDwbHHIXphHHgL1hqtsTi0T2+u49stzWAnQl0bo+lgJYX9vPhs4MyHhQumkt9CiB9ozbXTKFSkA9ty5eRxFAgYbCs8uXc8V1T8VDcd+f9/aCrY1Artr+9bdrpOvS4MrtiK2rxKnZcRWCCFHo1hnuMZzxw4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnL3ASRP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecf1d22d78so818841b3a.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177847; x=1713782647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kSPvWlOyCn9sMA+qCJ+emGi+9aCDeu0mdv4bIhM5Ww=;
        b=dnL3ASRP63Qr5O8vgcKC7gL5CZ2l9QDi30oMjabIQlUcZHxdx735/JEj8qmlDPinys
         T6eTvTQYHvALHNMBS3erGl3t1t7wSluzYxk3kF02SNzJ9pYYqtEc3HowVjqg4l3tn/ap
         kxytWOFG/9L4WaYXgME0qTkPt3OQ1i1UUcQk7SoudPej8EajsmoTID85Eo1r5kszaaWt
         ectavuOJYHDh3ZG8KaPLc5Uk30kgjnYwq9161amnULHVIulH0yB4XqWZCYGPtONTpxlQ
         IWpRijczygfMMTj7ajvcxROSewMdoM2SDy4/MuADkNCWEjSqcl1bBR1ztVQgaA11FerG
         hgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177847; x=1713782647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kSPvWlOyCn9sMA+qCJ+emGi+9aCDeu0mdv4bIhM5Ww=;
        b=LqIbBPOpOtmYSZoNIo8+BqHiefoYC23b3haeDAjMB1sPshzIE2c2Hgzm20TN1OtBQq
         XLHn8O60n5/HJALhUVoEgU+ovT+/G28FGzW0cuVXevYvtFx8RtWOZeEZXvULRVTyaBS6
         ruTyzWuxyJEL+dI0DfB+e/8CrCJFtTkwx8CjFIqtpX46/8cwzcmj+R3zIvOTuMSA6Id5
         UTScZLVX1MjbNNhgii/JKSY61xyV71AX1HRgR/swrfERwYgBhI3saM+h2sTAFxsgQzRB
         X2RIwAdtDMuC1NAi/m4+0WvTWWA8VPGozkIg7VFJj6H2UIr7190p/QhjGNKVGuGKLAOq
         kovQ==
X-Gm-Message-State: AOJu0YzCifAaP4MwrUkkiKmqfRh4G/hsQPA/5QIgkfHVItHZi4T/5MLf
	8HSX/wnO0J4jUqqnLYksuazDeCMCRh5bjaM85eo+35M2NFYDyk9jnLlWOg==
X-Google-Smtp-Source: AGHT+IHT75F7DvqRpB9NlijE9w9gVlnV0aNCgwWmCJ/OkAjf+X1a2XsZGieuwVyKDUBcFvU3ZhORTQ==
X-Received: by 2002:a05:6a21:339a:b0:1a7:94ba:7b03 with SMTP id yy26-20020a056a21339a00b001a794ba7b03mr12514130pzb.6.1713177846851;
        Mon, 15 Apr 2024 03:44:06 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090274c400b001e256cb48f7sm7581991plt.197.2024.04.15.03.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:44:06 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch
Subject: [PATCH net-next v1 0/5] add ethernet driver for Tehuti Networks TN40xx chips
Date: Mon, 15 Apr 2024 19:43:47 +0900
Message-Id: <20240415104352.4685-1-fujita.tomonori@gmail.com>
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
drivers are still distributed with some of the hardware (and also
available on some sites). With some changes, I try to upstream this
driver with a new PHY driver in Rust.

The major change is replacing a PHY abstraction layer with
PHYLIB. TN40xx chips are used with various PHY hardware (AMCC QT2025,
TI TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
MV88E2010). So the original driver has the own PHY abstraction layer
to handle them.

I'll submit a new PHY driver for QT2025 in Rust shortly. For now, I
enable only adapters using QT2025 PHY in the PCI ID table of this
driver. I've tested this driver and the QT2025 PHY driver with Edimax
EN-9320 10G adapter. In mainline, there are PHY drivers for AQR105 and
Marvell PHYs, which could work for some TN40xx adapters with this
driver.

The other changes are replacing the embedded firmware in a header file
with the firmware APIs, handling dma mapping errors, removing many
ifdef, fixing lots of style issues, etc.

To make reviewing easier, this patchset has only basic functions. Once
merged, I'll submit features like ethtool support.


FUJITA Tomonori (5):
  net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
  net: tn40xx: add register defines
  net: tn40xx: add basic Tx handling
  net: tn40xx: add basic Rx handling
  net: tn40xx: add PHYLIB support

 MAINTAINERS                             |    8 +-
 drivers/net/ethernet/tehuti/Kconfig     |   14 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1981 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  291 ++++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  141 ++
 drivers/net/ethernet/tehuti/tn40_regs.h |  279 ++++
 7 files changed, 2716 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: 32affa5578f0e6b9abef3623d3976395afbd265c
-- 
2.34.1


