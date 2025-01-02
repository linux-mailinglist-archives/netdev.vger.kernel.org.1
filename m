Return-Path: <netdev+bounces-154694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A789FF7D2
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F9D7A0268
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D411917C2;
	Thu,  2 Jan 2025 10:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537438F82
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812631; cv=none; b=QcICvgaiwpDtLxm8mlKWPEUy794PHzB06tl8a090WoPnwd8lL9QJbEiX4NPiaVFxO6T6ydyk1R28PIjssica+Kd7Vrm8z4J9vgVNDqrnygpiPV1WO6EVWQF6kZq9HyYXulRPvQ2ciOMXX7oodraY4fLFJ4/2PX+vAqe/2K9MQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812631; c=relaxed/simple;
	bh=z9NBidfBQGGYxAOnuaHbE2My9/Erg79D2eJmV0MFvgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pumSkDf4OL7n2BLSUhqAZjAs//Ot5rodw8N0PUdTb/bxSz7TCcgdAXGM4clNmCqgq+cjcHd1+lqtXBM3vq4lk6G6IO0LmR4yNEnJ5BeDOsA7FOiUvJ9YpBcXGaPogwkIcGt6r6xvigjiQmgiVumbYDvatKtd25cxo5Z/S4Go/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz2t1735812566tx6fjmj
X-QQ-Originating-IP: vedhk6r7auqiFwf5u2srM5ljrP7YjzDIYKHcnSzwapA=
Received: from wxdbg.localdomain.com ( [115.220.136.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jan 2025 18:09:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15997234190432778791
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/4] Support PTP clock for Wangxun NICs
Date: Thu,  2 Jan 2025 18:30:22 +0800
Message-Id: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NHGFjaVOIMm2ianCFfYkR7jynDiGAezqMfGw1WDMoPLxuQvJUsEuAVth
	A2ozW+JX/LY9P7O2X4CHY0vFrm0S12VfFK6+PX7O26c0OSGqR8VlWeKY6VxoTygocSsaIgt
	kJhR9aNX/CCyCdEMfL7syjhX0GeYgt0MG7qS4N4cSHAfzrgo/DAhcDxSVb/qTSo5T5ySinP
	fsGLmOnRWS87oppjZySG1gYLydjCx6yE9z3Gaued5QbQ93MDSyYnrpj/hVmt6lRSi284a9T
	kuU7hzjqHP6sXaACcwLIILGhQy5LDIUnBLsuOkSGAnlVWNd1TCe+zQn/iSxgXKEpG4plIZK
	SqzF2wQ2vd0u7RNJ1d6/4FqG4NeAT4QuiE1bBE5G+QtsdPvAJq9Nyv36NqSOR1CaCC+bHOa
	AQKy3kOp78lEuv0jT8no7kedDaI2lxsolvwKYhDNLEDBTUOaZa8zMwcmLGdgDXDloW/AXuk
	LuNlNek+WCPYUdeOIdSVS6J2ZmIlRawSSDjQvlPX6SccWhZCPzsa4BWKiXfWBA1oElpRUJA
	pptgyd78XRXXYZT7KSfWIYDR7MG/U7dRbPrh3HFi2MUKTq7THvJpLJfltbuVf1pd3kjC9Lf
	E1Pfop1S3SOtEAm8UFa8u7YsvOIKQk3nFHP9r0yLIeGXKs2xS6/szra5xFb7SxBC9iL+5b0
	deK8QlxjaOynhT1BkDUA9DvWwec+gjuVqCjP8s4Yo7V6rj/HLUmw1o8l7cGyQGNe5gHGE7O
	7MKnYIk65x2hF+MdSWj+DLiaITRv1qegLnPGjKvcuTq81ujfBUa93f72uwvU+Nei1hPRBy0
	1WOl0mRl2BDWomVJm6kWcrcStPH1iOyWxX0XCAbePS8eiE/dD/6zktxMvCEe2LhsF87rNjw
	srsFiyxoK0Vu3y4EuJN4m5z1SKY/F6JsCg4I0xV3kq95wFNqmnmjCrJbkCWB0wg77v8bA4M
	rGM/r5AjXKFC2pF5L94JbcjD0MJxeKEYw2N8UvjRZj7FXiQ591w7TuiDm+HugJ2WpvzM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

Jiawen Wu (4):
  net: wangxun: Add support for PTP clock
  net: wangxun: Implement get_ts_info
  net: wangxun: Add watchdog task for PTP clock
  net: ngbe: Add support for 1PPS and TOD

 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   40 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |    2 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  121 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |    3 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 1013 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  107 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |    1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   27 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |    1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   17 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   10 +
 17 files changed, 1393 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


