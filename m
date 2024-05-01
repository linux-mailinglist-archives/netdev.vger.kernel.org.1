Return-Path: <netdev+bounces-92844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44268B91FF
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7DD1C20DDE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84379168B01;
	Wed,  1 May 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7LE6US6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C8168AEB
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604862; cv=none; b=GL39Ne8y+7WjRSqFDoOYM+eFKqWNwX8p1H2gsLc7UySTmYrFT2y6KvesxI0HHSSsDUw+BlEVZVkOAuPPBXf8mOz6nDhIYDEX1AFIeZJ6GZQAnREtTAHYbnjPqmSQy0PmgyAVSPV9Hs5+DA7f3EBa6T1TfvMlrMywz1v67e1+3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604862; c=relaxed/simple;
	bh=fJaxzwE0epb21fOpDT9HQt0kJ1F9cUvTlT/BZMsYs0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MccaofWBx8jr2FyIi7zhCcQa1/f3MrlIKrWEtgGcUt5U8ckRoOeFiAlEyjIxbSbJC2vFSuCHzjfHjK6Y/6DZnDOMeny37YHibtQ6j37fDBBUzEFyMHabxBOBker3BRllIY7zosKWqWUSWSiAEg2YQyUMHlHr/xdW1rCYeZUpfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7LE6US6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b370e63d96so187277a91.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714604860; x=1715209660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhQmrG0wwJTDs977wRRJwDELsK54k9IWg28r1u7NE+U=;
        b=V7LE6US6Gc/GFipdl0oypwYW+5ENqNwlLBBMcYk9reC0mxvDNPREvHu17QJNYTbq+k
         awz9y9rRCPGU+kNFCFJBrvDJTGebtojQdZOJ6f8mDr8bTxIfY/rXBDoTNUfehVhfolXp
         520pLtOANMD8r0G1GPqnR3QfSga6bDpLyEgI40uitOYx0PDmpRtrwUSx6QlwetiUJ5gg
         5xlBEuVaSI8wZXBmO7mmyfUVtQQxrRmXUlt5bj43/zsov7yZDFH+0HYN5pRIamz2zJbK
         jaG2Yz6/SDDgzjCyudH96sZId3gWtp8JrMWW9KjyLaLMQ6oAh/Z9qg1ShFTb+bDw6h+X
         GiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714604860; x=1715209660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhQmrG0wwJTDs977wRRJwDELsK54k9IWg28r1u7NE+U=;
        b=e6+iKk4e45anCpwim0I+jwebpFQ+54H+zBPVPlLt2jTtuHL05zDqVHEtMH9B1TGlBF
         cnB6tSUR6evLmLPJ069lGqB5q2kZQyxeXMzS6fpEkM7Q4OoUUXAZXz4YW3/DDSxW/EoN
         Vdo0Z3InoHLBpRSivPjzSmLIGRJhrMPYei+QGfILJxWeJhZ7Isc5U++MSHbIQtWaIRDR
         GZTEnIlg/27aiSvugDrxNmzNml0/aFRFeM2+XV9PhMG5pq42FStXVaSBUOP2c0cVujr8
         sXAhEs304+ok3dlxpzq8fuTd+qr4ppdCobQq4BU0Yx1CnKB+vLZmU4g4GzuHy6qBwxV/
         OlVQ==
X-Gm-Message-State: AOJu0YzPdQqCT4wFmLHi3f+E7dIoNOgDx69RPz/RdqDqaq4IPrfh/ecp
	GveoYGxnmws/Sq32iVy6K4AxWPVRjzCpCJdPBUPujGo/XLzLBhAbLNcoLab0
X-Google-Smtp-Source: AGHT+IGKZvFhuso1mQQky8m64RMi/63GLjd7yVF2sSWypKyFXsgDwlt7LoyZV/JXRB8/UECVhUV5Dg==
X-Received: by 2002:a05:6a20:3214:b0:1ad:cdc1:a418 with SMTP id hl20-20020a056a20321400b001adcdc1a418mr4296019pzc.5.1714604860015;
        Wed, 01 May 2024 16:07:40 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id fv4-20020a056a00618400b006e64ddfa71asm23819380pfb.170.2024.05.01.16.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:07:39 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v4 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Thu,  2 May 2024 08:05:46 +0900
Message-Id: <20240501230552.53185-1-fujita.tomonori@gmail.com>
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

v4:
- fix warning on 32bit build
- fix inline warnings
- fix header file inclusion
- fix TN40_NDEV_TXQ_LEN
- remove 'select PHYLIB' in Kconfig
- fix access to phydev
- clean up readx_poll_timeout_atomic usage
v3: https://lore.kernel.org/netdev/20240429043827.44407-2-fujita.tomonori@gmail.com/
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
 drivers/net/ethernet/tehuti/Kconfig     |   14 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1880 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  259 ++++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  134 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   67 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 +++
 8 files changed, 2609 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: d5115a55ffb5253743346ddf628a890417e2935e
-- 
2.34.1


