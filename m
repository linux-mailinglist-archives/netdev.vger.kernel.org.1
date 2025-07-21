Return-Path: <netdev+bounces-208508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D92B0BE5B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8970516DED9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20016218593;
	Mon, 21 Jul 2025 08:02:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D871D07BA
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084977; cv=none; b=KsjVgXjXj+Sd8M5KoSIcKnd580yvBOGvhgC1dCmFClWKktaVwemr+YH8oc+1+p10AOK9G8p3xFYHD2ZAiw6AyFRrajAzFJV82Od7aG/iD1UsLMsneES3oecVMNs8X94nnC9qtT7l6WEha3WTzWvCdBvTn+vdieBn209oIimtHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084977; c=relaxed/simple;
	bh=JttuV5F56XFdNv7uHVhIrQAdWmBMevhrdW1wgCTDBmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nw3taQG5YR0FSt/SzoD/XayUM3YK2Ufc9y/ffQgzjd3ruCjhvjmtnKwGjeDGAcUbbbnYthYZhZhGyeI4xGmBKUVcAB+i72MOO1AtXhB7SWi1d91mNSOrq/cEZHJ0gm9hSLpf9l9/hsT4K6c+XcqBjN69SY4aBAxNZj0/vYFHBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1753084892t2e4c5b34
X-QQ-Originating-IP: zNvMmzu35uFFQizrR3G8Fw3y3OhBSkm+I67TtguwCcs=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 16:01:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9570242010480470205
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/3] net: wangxun: complete ethtool coalesce options
Date: Mon, 21 Jul 2025 16:01:00 +0800
Message-Id: <20250721080103.30964-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MaW89v4ocMish5IJ90ixpxsaUO+0b3Ll5F+puumC89Af34TBXT4yAjby
	zca66U2pLu6tQPL5LvdPoR9w0PZ8rCtpfQKtllHT8ywQaRCTKKx/KnMrbJFYX2s4uBF1Kzq
	1Cku/MJESoQ1BwiXbSiD3in1C2fwNY8ZxB1HsRlMdKRjPI1Dhcz6I6pjHnzdmVPfHmfZ05D
	R6aPY9dAksbl84LVB8SE3Sym8SdnirZlrvvYqu8Y8sqH5ciNhmRUBNp/WtVUXMGgV1osMSY
	3/CnGe6jg27qv2BmKMRkG10jkMFtQrhLES43HmkDArOFI563t4zqjbUjXkHOr0TYBDrkkT+
	2BIKOTQZdTmGPg2OSKFq52mG7XXcZP4myv6lw/DDy4u52ta9yf5CQwNitj2c9pOckbPkdpD
	oJnWIK42HyqSy+fwBO2dK4HkIk5S12WULMkew7feIBYiKCsihTrU5M5N5KR4rfokiC4zHYS
	lcOs1vJzlE2gtFfSP0PnMZjqEhTUys7NeUORr8xMaKGH1aKx9oKNCLkbTKOaNY+u7DRotjn
	6rr6R/yLUKVYTyJtTQ7xoyiZYTlKDccWuyWkW6p2J9uHTiwRd2cRzO2xal5/yODTQOovL3b
	kE9dPikiA9v9CIH3tYsVWDoQEk9m0qkbX/izlLLfS0qQrEx/l9CWqIvfufOtDhBRmemAcy1
	UBCfmrf2ggHZASrDJqRX4JaFHMcbiU6/GrXpP0HKJ3/8+vL99fIKREzesZdtcb86QKyFcOn
	cEc4YStYlgB00boB6F4AdlPSIUto9iLzxameziJMOt86egK9fLnNu4Z/Bce3zdV3NohF95O
	OStuNUtMdnEJP3y9AV1Jc1V+LC9rkugfQ+vO/sLfWgya0cQnY+2RtCLbsH2ZxecAUfH4nre
	xXGL1YDJRNWqJJoyx7dlihKYq7i2xTNAZMTC3mzq5gpBLzrBoty7GFyjFsDzE8cguw+5ia4
	GOHCwDc0wfb3Ckczdu0bOwGeK/YM/pAvwtfHF3a2MnBjeIJos7vmf1Oi8eejuf3w5tYOuKK
	usENDbGq+D7HCFGpWOiFfih4aPw4DR3xBhmrj5Na2/YeNcRbx/
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Support to use adaptive RX coalescing. Change the default RX coalesce
usecs and limit the range of parameters for various types of devices,
according to their hardware design.

---
v2:
- split into 3 patches
- add missing functions
- adjust the weird codes and comments

v1: https://lore.kernel.org/all/3D9FB44035A7556E+20250714092811.51244-1-jiawenwu@trustnetic.com/ 
---

Jiawen Wu (3):
  net: wangxun: change the default ITR setting
  net: wangxun: limit tx_max_coalesced_frames_irq
  net: wangxun: support to use adaptive RX coalescing

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  41 ++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 208 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  10 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |   2 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   5 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +-
 8 files changed, 248 insertions(+), 25 deletions(-)

-- 
2.48.1


