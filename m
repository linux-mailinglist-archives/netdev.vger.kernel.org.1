Return-Path: <netdev+bounces-212719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C657B21A68
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47043A4311
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454292D97BD;
	Tue, 12 Aug 2025 01:51:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D652D6E5D
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963518; cv=none; b=QyfPduhW00AZ+oDIzJULjxEXKHPUEPa79k8F5ny+q70USSRRdbNfS6j0IofMh0NSJYnxXVqXOI/p+78Vfd2bv7kYuY97835FlooC18AXAAURfe8LQXE8f2LMm2AI9XnEhCXAQpkFL/nbROTAPY81XEu5KYj2NglYffD61bt+sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963518; c=relaxed/simple;
	bh=L6C/Hc2C1BDV26pT8Sewq/+Am4O4fiGScZLw7oqDbHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXGovmf9We3MFBbLaQ/SaF3nwtblFmZKPQVOJrtxmv1EQmvUM0cnTJKSzqnoXFNwbK25ePF+soEOsLmwZ4uWHM4Op0YFGFX3LpZJJYzKXVdC/NZuPvA4hXJaROToMCDKhuL4XDP2Atdxo86NEmKvUErZuskWQBsf/hRfoUPnshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1754963438td8593ed3
X-QQ-Originating-IP: VBg3+tJ/6xBqaiigvzY2gJx3Bs9roQsxVGGOBckkLSY=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.182.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 09:50:35 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7462837097837684663
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 0/4] net: wangxun: complete ethtool coalesce options
Date: Tue, 12 Aug 2025 09:50:19 +0800
Message-Id: <20250812015023.12876-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NIdseMQqGGu7c3dQwlg/JhelSAOkO5BveGW7L+kcESYnAxNNDVHNaq3v
	TWIVClLEMXgwmOCWC1U+9cCryOMlsP4JavohaKWG7rzQZMY2G0eTaAEONYgL0rRoEbs9Fv8
	zwLs6sQKRmS4f/7iUOotl+JT1MsnlI+f7ZIzJWKaZdfx1Yq6yWYuIiJvvbv1rrpazlsOs+3
	2C3GVEogD5bkRZr9XINFGmwTjUzoVZa1z3AMVNUDSEfsoQJF87O+CX32rbsNi5e9hX+8V9X
	lcTl+5jfFxXOYswisgw+WO+aZmVME7oyqkHz8XWHiszMz/pOVhhv406vzaj567Sdl8bDHGW
	eJV6cTCpeJetyVbayR7ioGXk5H3XN6rQkRnSTUGu+ili6u/L5W4QDceF6Tkz9gQTlMwHasm
	O0ScB6YsJ8BTMEuH4HZRXZfb5MnXacDvlaeo0LD6Z3OnmeUCIrrJvKAyX/HNVpE3eWb4PDM
	BkMRQ6iqUswt1QbyzKECRcwcO0zAuQTiinlFvkzuQR7WO6Ts4bsRJ9WUfGDA4RMUdXl7yXO
	DMjM35iSN+8acDG1u06epWcWVpxhGeM6jdetRV5q9QiwjDiyYk4ALp5tgz9cfdxalAEHtPf
	6RUoDPP6vgbI8ECWI+IBrcP17ENYpRrOVzeXQ+GByOALVikm9t97gyGjXtlaCB9int78VhA
	0yNHEH6E93QD9DCnzueJ66aYbG2pL8i89I2mCBXuK8ZS+Xcm0xOD0EjlpUoOm2PiSKGXSuT
	Ws54RZTR9qHMUoWho13rYpzDqagyHG/icJywsp7QB7rwe3v3GnECkUkM6XqTdOPkzJfeW5w
	5ggRb0RMxbqIpAXNi9RAuZq69sCf0gCvlPx7C39e94bAuxRkRnZ72WpQK90fNC7oDJBANkG
	4AYmjD/JQzdviz3HpFjrwlxWUWl8nPG5rBC9XAhPy68xwUBAshS1wR4E72c6Pk0kmEPd5DN
	z5Ph5W7QqkP2HQvdIp4e8eaCWE/ueMmwUJEMLpAeIVJ7fAb5p8nDZ3Hfz65s/rjMBlsjk+C
	YRUDbZI9v5YHFGLTHeAbiCWLLH9GncHpsJ0A0s056Zy28pQe02iWQIhoyfXDOc8fMcK4C3H
	txAMs0q2UtG
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Support to use adaptive RX coalescing. Change the default RX coalesce
usecs and limit the range of parameters for various types of devices,
according to their hardware design.

---
v4:
- split into 4 patches
- add performance test result for NGBE changes
- use U16_MAX instead of self-defined macro
- add adaptive-tx coalesce for DIM tx work
- avoid setting itr in DIM work when adaptive coalesce is off

v3: https://lore.kernel.org/all/20250724080548.23912-1-jiawenwu@trustnetic.com/
- detail the commits messages
- support DIM algorithm

v2: https://lore.kernel.org/all/20250721080103.30964-1-jiawenwu@trustnetic.com/
- split into 3 patches
- add missing functions
- adjust the weird codes and comments

v1: https://lore.kernel.org/all/3D9FB44035A7556E+20250714092811.51244-1-jiawenwu@trustnetic.com/ 
---

Jiawen Wu (4):
  net: ngbe: change the default ITR setting
  net: wangxun: limit tx_max_coalesced_frames_irq
  net: wangxun: cleanup the code in wx_set_coalesce()
  net: wangxun: support to use adaptive RX/TX coalescing

 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  55 ++++++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 103 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   5 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |   2 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   6 +-
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |   1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   1 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |   1 +
 12 files changed, 155 insertions(+), 27 deletions(-)

-- 
2.48.1


