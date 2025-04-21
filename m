Return-Path: <netdev+bounces-184315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F1A94A9B
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C03AC0DD
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A82561A6;
	Mon, 21 Apr 2025 02:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046CA1C3BE0
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745201117; cv=none; b=Lq2sLqUVyaMPqrt/FeTs86yPTNyQV6nqQ0g75tt5x+K7Jw59Kt1Lk/qU9BFCFhr06v0hPnG8UVYGUyD3ZbZaD2NadhggxWpWjDxXG9B/0BydSnb8t06WmooZ0Ibt/bLxKhsq1Jbc8gYp+dH5mACX2GtKLjbaGBOTVDFNKWllwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745201117; c=relaxed/simple;
	bh=dnIFkuakm3QjWb9VyczS8L4J8Mucvg58gBtMX9av7kg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dwLgsoYTbNdTXuWDlhbCtBWtO0NxZNuB7+U8tCLDd9uE5TC/a+FwxMYAUvcxYjnjakn/XEAoSPfJ9qhJgLtLGtu56ox0cnQHr4f9/ctQxDNeDm359kV7LLkuJL4jddgEN3G+Er/JWPaRt9U4bJ22STy6DZxDUwhNajzORczmiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1745201074tc81b39ef
X-QQ-Originating-IP: QZZg2jodNhqlwocgQ44f23JuN9zp0lZhBwzOEDHqIQs=
Received: from wxdbg.localdomain.com ( [36.24.64.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Apr 2025 10:04:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17076726303745618232
EX-QQ-RecipientCnt: 16
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dlemoal@kernel.org,
	jdamato@fastly.com,
	saikrishnag@marvell.com,
	vadim.fedorenko@linux.dev,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 0/2] Implement udp tunnel port for txgbe
Date: Mon, 21 Apr 2025 10:29:54 +0800
Message-Id: <20250421022956.508018-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OUC5DGN0mB58YgPHjeVGKnhWeu3UiZDyVlI2Hp1r8hmlOG86sX+JbDdo
	od/jZTIvlMNiBJjlZEesBxDvyUBqOkoYT2ivb1yfpeQk/K40BnNer4aCiuEIUnz5Cp2nQoM
	0nHouPEgkYZsDj8bcIbYT2J3EccVtZYpnOiPONqvBwoy41VjLWbZ0wCaThUlA/TPrcTAQYL
	j4l/G5vzTvvssMAxjx8In9OlVIR++/fLowF9XfNecn/oPBDWpCHl9VYsPzQQZg7FyKn3U56
	zgWiRW68dq1LHuYsFVinurb4LOVVAvtdZpI08LrDmxvE4PevHZNLwMG0ajcgzXtn0n+3Hsc
	EyqGgRRqO8CfX0nNl4Xxj88MlcWauDQeH7kyIN3g2/O4zaij7RYBTsu+s92pDJ/WNDsFL8N
	kFvKMHjpT7rJEH7suyl8Gg86Szn+WKU1Tb9rWfl0jiA1EtAvF4BL2oGBYVKpczJC76BoSY+
	4Ue88kKTURuZAD5mfBiFPRAnmXkJe1SzMpFnHfjK1JICvEy3fMdNdPYqfpKQvA4i58rKMuw
	r1+cNhy+G3AHHgdDKGXvW7N4Lczt2yQDOiKcI7S9dxDiL6gzr9A2z8/3Qy894Ony4/fb738
	gsiQX/RrIPK9Dw029/275ANQT+3UzF/qBDr+dUzidsAiZQdx6xwDOIZtqdA/XfQnVaA3sXr
	ziM2RIb1jQJ+EUnZXfkNh7z1X9myDtr9S6shtCdWyKve64ZTHdZsRyxJw7zqDhU59M3hdCc
	54JaahTGuSSgsFMEE/jV5q3nwgJ1Ud8N2tS7q4WtpJNoORVrAKRESsHDRZ8846ZKKvE5oGn
	PTobV2VpuH11vzC6VSEyI/ICTmagnTtx8GiGfZhqp8kGSA7AVlCj+HjVU2xFG4+G7BiPKuF
	8WzkXxrtYnJNZj6E3DYq5eWBY/YnzoQH2QPSJhGHl0a0UaNcRC7pNNSrRj4X7wjD497Kbbj
	k2jvob25RhLE1Q7CD6j85Xm1caMG0U68KQabeyvZFIBQE2ofNSZEIo/KAFek+zujDxBq82I
	Vp23DiJ7CKSWxd6nbJVGQrKVBw/Vm2sqRUQCDKJw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

v4:
 - Lint to v3: https://lore.kernel.org/all/20250417080328.426554-1-jiawenwu@trustnetic.com/
 - Remove udp_tunnel_nic_reset_ntf()

v3:
 - Link to v2: https://lore.kernel.org/all/20250414091022.383328-1-jiawenwu@trustnetic.com/
 - Use .sync_table to simplify the flow
 - Remove SLEEP flag and add OPEN_ONLY flag

v2:
 - Link to v1: https://lore.kernel.org/all/20250410074456.321847-1-jiawenwu@trustnetic.com/
 - Remove pointless checks
 - Adjust definition order

Jiawen Wu (2):
  net: txgbe: Support to set UDP tunnel port
  net: wangxun: restrict feature flags for tunnel packets

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 27 ++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  3 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 37 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 ++
 5 files changed, 71 insertions(+)

-- 
2.27.0


