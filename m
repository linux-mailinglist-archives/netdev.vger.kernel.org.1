Return-Path: <netdev+bounces-155371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306E6A0209B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401E918851BB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED311D8A12;
	Mon,  6 Jan 2025 08:24:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4371D619F
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151879; cv=none; b=PyQ63w3zkIyZp1pVg9Lr0gTbuJWbC32spqCAIUE/wZg0sz+5SJzqJSZHt/qzBTf/iV8Os8l64loSliIYzbTxOCu/XFzEraudm4uUrD14n8dIOlmNZfRsm6vWv6tmtrEDk4pWKIMLhCMWBpoiCDlKD9BNEudUfor6UE0/yW019UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151879; c=relaxed/simple;
	bh=ke6Mw0M2Z3COOWytWpye2AsAwMheYxzQqrXz69/0f6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ob70nEmmXPVHbmBPgSOwwL61n4YqUsMaQ/+dRAS5/YObYaY2ydEW5JYZpbSXBynLK2enxHP5Ya+hh2cgUsHJcV5cEDAdnBHIuvP0X0B4lq7MmRGbp/6gksX0AxF5AAN3l1MI9u69ISOEctT7eodAXmL9pLQ2xtSZrRR9XhA5WSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz14t1736151863tyrd8e
X-QQ-Originating-IP: eBDaqxH7OQq9KH7v2MCIPYjzyTLUPEvwzTIMXEicyO0=
Received: from wxdbg.localdomain ( [125.118.30.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jan 2025 16:24:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6895401573510602144
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
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/4] Support PTP clock for Wangxun NICs
Date: Mon,  6 Jan 2025 16:45:02 +0800
Message-Id: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OFwcIyq3IdMxyk/Fk0goro7oKlA4wSU/L658lIjVhqj2fPIkOiMeiUV5
	j385arjdgi9e5w6PsK2XTNHt8D2zr9CoBr+adyqpZU4OA+oMw68Kscvl8bqQ+jgdmSCuDbR
	FYQC0ZSKv4xuEYCCh+S9M6O+vsyTAL7At3zCUJ+zyQx73VDT2/wBLJOIGcYJ5ZzjkpV68am
	pM0CCGMo6ty9S1JEoL8xOtO8Dya9ZGUL9Nu/SJCMIl6gkFJe/MZqzzrvw/UPzBtwKhHogFn
	0KQ2R3AHy+YfsblxJqlCUBLdC49vkr8zMBgq7La8DqFKP0jqAUEhF/+QadF36Qpg8wy1jlH
	nXACBdCdQOe7iFrEt6WZs1HbRtYQ7wSUKP/Xe4pab3P7IVbMofpPseG0cZ7gvuCvJ60J7ks
	2JcVmHamgI7CBeGM2mDZj+dsLF6P3ga445nZ/lhBJsXMm5o8/ewescDnvW7UqyvNiZE0ce9
	asLJIPfcbvOkHtekiFKE+O+PxVHUPkG39V7x8AphVi35rL2klpI/+akK8+XnGzh144br2iC
	AO68hSYpyDHvr/v/X89yPsl6OLUhWIcDwCTAwI/0VVE2TTVIZNYx1ie6LJPB/o2rbVmZGe0
	pm9+creD+H57x8OG/GSY1ydJ2IK3/Wg0X9S9TWATteOcS/zaeDmridatsDcDyWKO08clSji
	lJSARguK+WS/R9CJO+lIaHnHp/6g71AjzufKVq8onnuVWsK/SiDQ3TKx0Ejx0RoeTp5puIx
	OeBIdMv1gWydNzo7u0basNX+DQsoKpjD/ENV4Biu5JIKVlTZJ1qvbKVQO9WOnh3T+pEN9JJ
	8Xu4d8ejSeT0ZUNV4Nzfl4u6DNs7P6sWOPa0vujW2+qw0noGGpvuec0R+FldYh/ENyrSThd
	rq/2MWk29b+jCejcCakBAM8lLJLgbFKlOJrshS0rWxwn1NJub1RwUST8gBsICN81OLFvis+
	PFGxDps0CkpMaxYuqFhas3K9Hv28T53QGSNPueR+GY6Wvca5+neOcNJuafKNTVZtokT8=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

Changes in v2:
- Link to v1: https://lore.kernel.org/all/20250102103026.1982137-1-jiawenwu@trustnetic.com/
- Fix build warning
- Convert to .ndo_hwtstamp_get and .ndo_hwtstamp_set
- Remove needless timestamp flags
- Use .do_aux_work instead of driver service task
- Use the better error code
- Rename function wx_ptp_start_cyclecounter()
- Keep the register names consistent between comments and code

Jiawen Wu (4):
  net: wangxun: Add support for PTP clock
  net: wangxun: Implement get_ts_info
  net: wangxun: Implement do_aux_work of ptp_clock_info
  net: ngbe: Add support for 1PPS and TOD

 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   38 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |    2 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   49 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 1019 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  103 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |    1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |    1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   10 +
 16 files changed, 1305 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


