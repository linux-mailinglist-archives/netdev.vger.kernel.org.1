Return-Path: <netdev+bounces-94527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC8C8BFC7B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A23287244
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35BF8288A;
	Wed,  8 May 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyYRIxsD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7745018
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168607; cv=none; b=juE80Wfs5HL4QcAPZZKjOc8FavioY+XEtewuPyYYCoIFCjrajcXk0jQQF69BOHVzsrqrOHoB8XMdN/marPa4k3cvoE5YmStz5CxlOyMDinuNXqK64Le3xOSr0cDxLQpzuURs1DOS0KnWYVOphHSG3rAW87t+5oBTEWK/RerL8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168607; c=relaxed/simple;
	bh=hgNnT+EeWdfewuh/5VDsiLeoMhrftiCmpV98lU83dVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tsWpJwDFVn8t6fAE1U+AzqMJ4qg7qIRZLI3H3wB/NVg2iGE/qMm3qBpS7jt5Iq8hu3VFc5Lt0O82IMtPV2Lu2lFchMugs1Yaiqow2TyhCwRVwtQ2y4aqXb8GeNbv8+C/lvcFZR1ndSjnMrnASauI8kOdsiUXYQpQz/h0mUUzQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyYRIxsD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b516b36acfso940449a91.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168605; x=1715773405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4dXDsXBzisMQyrGVy6J8+nY+9PizJBiVKwieNRVOtQ=;
        b=MyYRIxsDhG1gfOX0400lkjvQhiPsEx1/zlyTlulzt3+nYUWeFJury2weypIKLwvgsl
         4p+tP7ZcXhSIjnYiApFm8gNit0w0xQ6dZVnTLsz+DIfuRXxa/V6XYulcr3cG1xyrNOhF
         KP2nqo3pQCnp+sJ9rhU1xNofg+8bWdjiYFhrSgfOYrUpc+VvtNM0eRtqNCBJaqm1MupL
         CKDEiCNXrO469JNP3UFAuSxUeOsrMxG0Vp6Q2vRLNfL7arAXFj+Emi8OvZNjzYBEvLWH
         OiEuyuvQ1ELjVfYquvzFKvqS1s85cJp2S+LfkBEvqezhQ1jUFP5+xrJzH/aKV7BP/Yh9
         6b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168605; x=1715773405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4dXDsXBzisMQyrGVy6J8+nY+9PizJBiVKwieNRVOtQ=;
        b=NgSoMjlfgY16/WE/Opquh2xH1ixBTpCcJXaSLVsSUagtjZzPgfzzcFpfE6AF0jYcDy
         +u0HWe8+WLP22pKh6yqzS5FgfT1f/sJ+thJuqLFWwbJ1KWtXaLgk0l8TUAl9ebMrMXtq
         SQp/NQ9vVH8uEMtG2oxLLxai5xcQewJhzEiequGSdIscPcB7tv2GUhsEsDB9FXwTvOsD
         T7I9FWzl943sDF+fJYvUrRwHkLkMaHDOhoVGn7PsK2St+5alGUixESNhcc5rfqiS7MUH
         eu3UHEIK3DNNZQpYaDZTIoHcnYwvBWWvLBE5tG6RL485Ao3Iy9l2GM+0xMFTi7BFLgYh
         PP/g==
X-Gm-Message-State: AOJu0YxX8aTw7x+wnPaC5MnBd67Ux+j8Y83TcJ1TIgkXFOOdw/Thaeqr
	L5YD20Q+vGHPMVI16eKpz4c7+lP0QhAQfJVZBFstjcjwmDvIJtYESDslkp4u
X-Google-Smtp-Source: AGHT+IFOYMDvzR8mU8AfktXXLZ9eAGSqn3k2QFRqG2OTrZyJlmAeyt6QxWTX9pwFoCUYwl60Rs22Hw==
X-Received: by 2002:a05:6a20:9712:b0:1af:93b0:efff with SMTP id adf61e73a8af0-1afc8d29ec2mr2173928637.2.1715168605482;
        Wed, 08 May 2024 04:43:25 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e83a70d774sm11620938plg.187.2024.05.08.04.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:43:25 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com
Subject: [PATCH net-next v5 0/6] add ethernet driver for Tehuti Networks TN40xx chips
Date: Wed,  8 May 2024 20:39:41 +0900
Message-Id: <20240508113947.68530-1-fujita.tomonori@gmail.com>
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

v5:
- remove dma_set_mask_and_coherent fallback
- count tx_dropped
- use ndo_get_stats64 instead of ndo_get_stats
- remove unnecessary __packed attribute
- fix NAPI API usage
- rename tn40_recycle_skb to tn40_recycle_rx_buffer
- avoid high order page allocation (the maximum is order-1 now)
v4: https://lore.kernel.org/netdev/20240501230552.53185-1-fujita.tomonori@gmail.com/
- fix warning on 32bit build
- fix inline warnings
- fix header file inclusion
- fix TN40_NDEV_TXQ_LEN
- remove 'select PHYLIB' in Kconfig
- fix access to phydev
- clean up readx_poll_timeout_atomic usage
v3: https://lore.kernel.org/netdev/20240429043827.44407-1-fujita.tomonori@gmail.com/
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
 drivers/net/ethernet/tehuti/tn40.c      | 1884 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  252 +++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  134 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   67 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 +++
 8 files changed, 2606 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: 7824463aaea913f6d43c6e1f169ba2fc5de1d35c
-- 
2.34.1


