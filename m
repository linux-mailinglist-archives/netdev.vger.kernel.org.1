Return-Path: <netdev+bounces-217585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E878B391EA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B18E1C204A8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A826CE3C;
	Thu, 28 Aug 2025 02:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526AA26A0AD;
	Thu, 28 Aug 2025 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349778; cv=none; b=pQmd8CO0INlgKnNBGQbHPufel8NW00TgxKXHwjK1b6agzOo1Xikbemzfw+aLWLs9Qawm1o2+xhwZvHIY7QP7KSQ0Qb5GwP9KHdSmlxUJ9e2ESC0K2QKtQBwrn0cBgCEu0GXVAd9pS79jJgWgkI7JYdxX7O/R1dzEcW3wrpj8h5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349778; c=relaxed/simple;
	bh=VeENKAYZM/UVp+O/FDrwaag9F77aNhuhzYJ5z3hgnK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d3UlGuYsWDKoaVC38KrImKOay9s8C32RdSV1uhsUwck51MxiMFYNSKVDjX/zCVYea4HDO89ahC14gme88TnApDZwJ9AH+im6bq3ClbU+eMLoUQg/57vZTcWi8AS/RnoUHLEiWpQzMXPaV1QdcjDu0dBkRaaq5gj9d1rnZjBh0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1756349758tb611abc5
X-QQ-Originating-IP: aL4MtiQuI1SdtEOC8fLpKCATwptjBpuAzJkdPwOu7aE=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 10:55:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12824084307090948245
EX-QQ-RecipientCnt: 28
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
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v9 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Thu, 28 Aug 2025 10:55:42 +0800
Message-Id: <20250828025547.568563-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N879q09ZcJuCn71ZUSvp0SRcwQMWWflhG5H7hq2/tabDdfTAPe4S0o3v
	8EH5VXjx9Af/H9xQO3M7ajfVcT+MqlCpNzd5sgTOozMVMPlJ4obIJikIRkhf+rv9ZxWGr9H
	pjOMKB8OjypHI7PvxY//B5gWLu0ueOZYLGfhXU/qUKMmn4yYHu5fTgGJHTeb3IwCb9QZK4Z
	V7NgjtOzefhLl1ydDEIuipKjjQ8gnMKKis5ODifyHJMFOVwgcUwfHbOAtbKyZ+wC462HaQQ
	ukQ/Yi+PjMXBN5ZWGgykRQcvgokez8V/Pm8lW9AfdRK4zi+y3Kp9l5oKBUzu58/UbThS5+Z
	mU/NBTY14jZKEYdc1lJjda7j/slS7fKETHkw7HGVuNRHLKmIM/TUS8zdBQNQCV9nUr6ptOe
	L+OQwjUqApJKtfTBDyAIva0G/jMdb/JTnBlqOSsrmL9NzlSklcOvSNfHeSqxAvhyAvDzNme
	R19+Ypgr+dnONlDaAXPAlea8HJda4cmPuTb7PP/3fAN/+EnnY9ElWMXndbYcviKIeSIenSP
	jH3+w5HyzKWwDa4+BfnDicfbUnVYjfd630Z6Q7+mgfuBv6S9STmNKEXKvBPGfh3ViTZC/AL
	cUpACKJXXnZGOOeC5zfIe+OJVvXOqQBgpKkK2NIZGc9tPGnOfWsTT10Wu/yzVU7mQ8zA9b4
	uURfRTB5pWvRoO7bg6MET6Z78iHgYKlDDjx1mvKKDwX0Z5dpxHNPm5Fwpt0slolOgs+sLtN
	DuAct9j0N9zSBL/xCi9AIqdKBdypwEc8RSGQmbIMaSR3CRWsfJpCu6dg8q8goDQrPk2tZQn
	5jYyaT3FBGu5Hnhy/7ZmN6bcIWEZvvr3tN3J4pIomEbBjy5GyWHZqWA5aUHyNgT6aOOceG7
	Htwt3t+Bco6yvcEb9YK3MiNQK9lcrjgVJb+EptEhJmiOCB2GRgWBgVaP735xn6UNG1iuYdE
	39WK2mO1AKEt5LTWJlfHIoayG3dJ38zUQFu/r6ZRb3iq/h6bCYCEmee4krN/MWASCeT+PAU
	nR7f8SugGCElIF7VeI+v1xYqfN2cuacfOmt+W2T++MTG29C6IW
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v9 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v8 -> v9:
1. update function description format '@return' to 'Return' 
2. update 'negative on failure' to 'negative errno on failure'

links:
v8: https://lore.kernel.org/netdev/20250827034509.501980-1-dong100@mucse.com/
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
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 393 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 253 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 ++++++
 16 files changed, 1436 insertions(+)
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


