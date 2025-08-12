Return-Path: <netdev+bounces-212834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7EB2236F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AA8188FA91
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484B2E9EDC;
	Tue, 12 Aug 2025 09:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F22E8E0E;
	Tue, 12 Aug 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991667; cv=none; b=Upy2KfduTa4QlQezv238eouCj35G6RPRbYTgQMa9cgiUWzY2F2I8+7AiNgQKiUSxiqD+2KgAPhtpBQnVGEVsB8uoeF8NUapkBRlTSvW8bkOnhJ6Ekgx3F9IUjIISWSUp9oOAq3YEbwyi6hdw0yl+6mZxtEinHyR3sMBBSvGXjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991667; c=relaxed/simple;
	bh=E30CA2OyE6yW18KhFeMGAY+johqRCBEBiBJLS6lL8x8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJp5WjtAmkJhqwFHVpn/f4MFlBI5xOhbZVX+3dldE81eiQJdXOx/ISk+TpAG/rAnIMyoTCDMHq6ykTtc7U9bSsSNI5mKAW/C7MTkfymnZt+9lKZfB/WrIAnFYkgnQP8OycjswFU6uav3Wdyyy+j9QE75/QSDWTMhHhtzJMFMi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1754991596t293a4c67
X-QQ-Originating-IP: PnCszxP7z8c8wtX64M80yLJLhPuH0abNPFPw2j7FmGg=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 17:39:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17493466095422222965
EX-QQ-RecipientCnt: 23
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
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v3 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Tue, 12 Aug 2025 17:39:32 +0800
Message-Id: <20250812093937.882045-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MtnV5/DUURsJNAjWVY+kf5NIALCm6d6jcOTsgGxdyPByH2f7BNbZz8yS
	li+Qlwko5IwWLXbBAtsWHp1T6NHNW/y3/kllahwn749pJbnCs+RVRawLHzcLTyWC34gGkQD
	8aXMaKEszwd7ViAzG70wExNdB6Ofg+cbw47zNkPWdxiMSrdlSZguXtUbVdiXJ04Z0ifAkPy
	HoM00H9xsXei/bSpP9MeQiCF6by4V+lojGc+oLZ0NnpL0vZWBoqkb4WwPL3QIPO7xypY2LE
	Uh1iAYcYHNcx3J5TFfpKOf1o1mXiTX/rfxBlcBSpo3NzGiAyOEXlHC+F3zhKxLaIxHBMnpb
	xooILqyeLkyWWp6ry5iPlPWU/hiJLbHjCygNwr/GYfrRlvaGj5Yy16gQIbFN8pZRQ8k55FG
	vrf6UaD2OmjX+ACWy4KBmuMsuyA1i1xZLSn3Lan5OpTYIMYjhILF+iMYuyniElJu97oBq6k
	dK/dHTJGb2BHw0j3UiKyITX7ljyhqfVbHDOjwEt3YLKDQyuu73md0+6BZ3wH0wpLJTPw+iQ
	zdjn6tUX7yakD6sDFe+TkrxPvmhtCOBVD4ibb5vRMMfWbjI36RTgBGeRyHzSVDH4NZmlC5G
	oHqMkNvN8jCr51IPiZM4wQLdKEVuSrhtT6XdRWV8/h1lZzDbRl6w3Mfx8M68xZaGbRYjpDg
	OvdDQ2b+8SuEUW53ajgtZzt/FBmPXnjQt6TRXX1fNIBpl52j7Z3EymMeoOt3nw2bQ8ccOMl
	K81I6KoXFcXJbfd2iB0DlhEgaoGepfOvh6/c9vAuNy7wLaaOMsbKIc8rYgC4x57Gf/L5qrY
	qHEe3KX4spohXzJk+9ss5/HrjZ9Ur4aJHbBrbEiRxnEllSfZs0j7wAqQ4cf6owhlsm6wGR4
	VVeXgsvpmqW1p3yJBkl8rEfWrtabG34SFOFSYDzFcTYGtHzdrvIXtKPy7uQgwfB795gEauR
	B29HvZ026k72r1RRgGLMCSeJn5Sz9XgrC1WBPDYSV8cqnWih9l2aqwlGUPtAclLY/A7f8bg
	lU2FNSb0iL9UbKLo6NUGLS/rbBW1Wbpk7PdHUVFJpT6sGGj51nNVR7e4bo0GoNFG8vmd/25
	g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v3 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

The driver has been tested on the following platform:
   - Kernel version: 6.16.0
   - Intel Xeon Processor

Changelog:
v2 -> v3:
  [patch 1/5]:
  1. Fix rnpgbe_driver_name as static.
  2. Fix sorted-list for index.rst Kconfig Makefile.
  [patch 2/5]
  1. Using common funcs to initialize common parts across multiple chips.
  [patch 3/5]
  1. Fix no initialised error.
  [patch 4/5]:
  1. Fix invalid bitfield specifier for type restricted __le32
  
  Some common modifications:
  1. Remove extra parentheses for constant.
  2. Check code-spell error and comment.
  3. Remove no used code and define.
  4. Use const for all ops.
  5. Modify the code based on Brett Creeley, andrew, horms's feedbacks.

links:
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 148 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 166 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  15 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 352 ++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 443 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 275 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 201 ++++++++
 16 files changed, 1715 insertions(+)
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


