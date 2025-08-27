Return-Path: <netdev+bounces-217135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C4B378B3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F687360365
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F611713;
	Wed, 27 Aug 2025 03:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB9DF59;
	Wed, 27 Aug 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266339; cv=none; b=IuTr5m5b+4dXaV68f8Q9zqxsqw0153MWEBm0wlPitVc/Mhk/Y8RhbN+w62yqKFR94EQcLdcnnEMBM8uAQvm/Rng1sxt8svfCup6+uSl6lbMA65RHDWc4Ps0JlrRS5vZ+OnfVpF+zXI2BENbCxMvG5w9ypK/17cM1L3PWeD1jkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266339; c=relaxed/simple;
	bh=MPUCB0Z1uQ24Cnjkt5KOkq+bdA4fSv0sziSIivOPSIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jFyx4ghi+PwGnEyF/sc0Oa12IXLdGATEI7E+3QbDeAPt+z5qW+QQq/kw/nN3EDpH9Wc0L0RSja1B7Q4WCYW6F3yh3zDWZnUqUY9ElDZud/gGlCpsDt2EhaVKwBjL+L3OZzHOgdoVezyvK2z/cdmnA3MWXHwmgMkvJAspo3Uxo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1756266320t257cfaed
X-QQ-Originating-IP: H/22sNSqc05HKbCq6u90qkTPzIcWcNVtfEphTK1YxHs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 11:45:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9214274692704587650
EX-QQ-RecipientCnt: 26
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v8 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Wed, 27 Aug 2025 11:45:04 +0800
Message-Id: <20250827034509.501980-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NrQAxm9Qars7nzsDWeYyAqHWmzJ+0EkMWcNAPUFUwE76GD5mKyS6Vs/4
	3GiO7zvJaJbnG6oai2i1dAVokVSdYFhbLLWVUnKM8E3PFvnskvSiW5DZVndUGf8ZcocUBCa
	8+W/jZqTjaLNFuT7y4voK0ZhPJTMP6BPzmQafxS5UVna6Q8CxrhCJKqBYDTFYmAyFWm5BA5
	A6tJAgAON3lKtvFF5/iHQ9LmkmRwpQPcFIncMbDIpuLM9NpnSiWOn4R75qvKXWtaiziKKc/
	zsCvAm+m1XQk5yU6Gra6UQ15k+SZE9Lp4q69W5QC2dgu15YB1t3PolODkmtFUqJNZRMR+/Z
	g4nDX6yD5PDQGca6uQKQINNzcZZ1H6D+nkaqbWSdPZtzDZarajqsraaZtZf8EBGFo2UB4Nf
	nSQ+qOY1FtfM+QSWJku3bu9O1ZYYHDJ45G9s2jWsvJtb++wWAdIFZrt5YAvg56IfTA0/JrH
	QyltxG7h+I/rl4WnFd7LasVHytAwwfHGQYzmKVfGCQAwFMMhdAVbPNYzAkvN6fnkjafuCn7
	PB52slFHiFQekoySohLbd/EITUS6fcwwWcI6ajDl2YeJAO19M3XzNTjzHFeCUUJKZwPcicu
	A3xiYepj5vd1NCTa7/7A82OdbiqA9deEvkgDSdcxc3ktD5EVOLES8zUHAxO8bIQf2CtuHm0
	M40GlKzPbbhjWW8UaXvycaXaCDD4HLw2E8GHwaIjawwt9u0RHcBRCzfRpsgmQOFaZMmo/yn
	PnGy/dUSvl1WTZduD5RyBmO+TZhOmF5ZPUwggQOgruQus/1HRlG6MKHJ5T1Bj2jeZx1vgC8
	NT9bKhhgujXcyvkryry9xD2R1TwXIUa5dKSvRHvXqe/V7Vm+666aIO99EQtaBFvckR7ARlW
	jjaezTlBraI7mb0Portd6bE4VMMTmxJOyACGQNLPTGTormEAzYG8IMctx63Po/efLxG1Wc3
	GAoDOGpOoceUL8c6KX0TpOpheuSAP1vsdOQJ2sv3SK5TtZWf4yw8b0rUYAFK3L8fEX51H/g
	Xnmy6xyoYqQNrA8bUpP6G0R51kcj2kDaFnIwJOkawDVNWPJ6RDh4V0C0IM3NwjzdKeGyQIy
	kd6dP+t0xcq6hAxOCJyptW/HvWMEx5eelxSiHMETsoSY/rxBQm0/r+w+dGqP+Rp2A==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v8 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v7 -> v8:
  [patch 1/5]:
  1. Add check pci_save_state return in 'rnpgbe_probe'.
  2. Rename jump label 'err_dma' to 'err_disable_dev'.
  3. Rename jump label 'err_regions' to 'err_free_regions'.
  [patch 3/5]:
  1. Update 'mucse_check_for_msg_pf'.
  [patch 4/5]:
  1. Rename status to is_insmod in 'build_ifinsmod' and 'mucse_mbx_ifinsmod'.
  2. Update 'mucse_mbx_fw_post_req'.
  3. Remove code relative with cookie(relative with irq, to be added later).
  4. Update 'mucse_mbx_get_capability'.

links:
v7: https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
v6: https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
v5: https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
v4: https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
v1: https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/

Dong Yibo (5):
  net: rnpgbe: Add build support for rnpgbe
  net: rnpgbe: Add n500/n210 chip support
  net: rnpgbe: Add basic mbx ops support
  net: rnpgbe: Add basic mbx_fw support
  net: rnpgbe: Add register_netdev

 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  98 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 153 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 286 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 395 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 253 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 ++++++
 16 files changed, 1438 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

-- 
2.25.1


