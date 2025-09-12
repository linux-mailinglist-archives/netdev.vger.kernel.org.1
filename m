Return-Path: <netdev+bounces-222420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD32B542D5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1482848583D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337C28313A;
	Fri, 12 Sep 2025 06:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFACD1DF270
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658340; cv=none; b=dAeswf/Z8lU0JIQch4Vg2FOjz/se84YiQ/gMyGtgI02Dv5haqV+6/O3xAFdBa9KjgGH5Z9bvW6O52Ubmp8jQ8KQj6aprZiebOYQ0/56c48b2Pzh5BKctWBSLJeExHhmJe7qiSiMMFKSST/uErpAdhDSqT+oZHJUpLHYPlqlYt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658340; c=relaxed/simple;
	bh=papfgHm5FqDaaOL8DCUOhGsuCgyu5hfWuljgHEAEeP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tx1MiZQ4Q9JYFfBjpI6zc/nkBmOvMWdxhxLHVz+JDAt4ZIFuQmQxjGLeLMbSr5Ru9oY7aKULuw+Fbka2BRLcfhTE69kil2VBtU+lCnx1cp/K7lrVdude3aNQITU0nZsK9NYO740QDUnWqqFueXOKHEU80g++7OGi+EJjyIGEOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1757658251te4021178
X-QQ-Originating-IP: 3hwtgTXPDHBNl0hoS6zltLZBRcswE+yPzJdOZKo8MTk=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.63.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Sep 2025 14:24:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4605509738491810659
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 0/2] net: wangxun: support to configure RSS
Date: Fri, 12 Sep 2025 14:23:55 +0800
Message-Id: <20250912062357.30748-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nuk8bQLQf5MZzxGrSn5c7sDiVbS26qRhJ0OpfINLdu7JsTiUdebf9O6/
	Dok+u+ugtNHqIJA1yjghZ4U+C4vrN/5ZLjDCUlSY1W4kE4l+v9tuvTzBvt8rbBd+3yXUOfY
	BjjP66vJOQllIrzq3aTUAxowDLWn3akWbWAs8qiutO/F/v+yRzxwSyy9YsCSUjIr6ebv+1i
	Q9GqMvdmqq5Ovju9T2DQm8RfUJOm3ndeE79WPz2ZGvzZg5Gj9c7Y+XDueT+HGR3KI236tLt
	9GDghMgGXFbD29SjfPRhlz/G31skKnXu9yqiKUEeez3DQ+C4A/mKzqkLTa0M26ctws2tLl4
	0OCk9S7Sop5B0USnLBmDdSo03ienLqS7A06AFhx3dyzEBph2xPyUib1znKIMpEdUgl1HIfw
	o//Z47ibgXAovzLK32IVm3vNj5bTZ5OnACv3ecY1AnsRTGqvzz94lF2D4rqAhtlqj/Kzj9P
	60XoT6HlWzPE6n+PreC0Spv1XbPXKq41r+2tGY7CWef7nhIBzU4WHXRJ8py+m4OfLUw8QGK
	a6UgcjuFAkRmc6adr+w0WnZTtSm8sKI5utNUzHaWVbKjA5wrvQk+UTy57wDedHjnssH9J75
	AqQ9d/lR7EWAt+Bx96H8DLrq12++A8exnTrj4LNcv90mHLQepuX6SXMyr67FooCbZWE/PuL
	bTqasLkww5NNv2DsPRyAYZiXjN1IzqGroZl+ta1uHcqlag9lKGCmFVPo1ziBN0a0Q9MWeMi
	btK/YYQXbJLBljG3TwynLuXpE9EUZzFqlC2pxpPRm+lUFUtqkL929UmgwY7I42xpy1OWQGa
	+4JTxN/D6oClm3oE2gRcfuneKI0YjQxjUVK9Y3B2xOqpHNuf5pz89KA37uRcVCERRaZhXzw
	VMp4547Yk1aF4ldV8AjfhGMudRQRyNMWE11uIGY8RR+3dN3RyntPZc7bv0iGsHi34iHGEIK
	vzd9uXOfKga5CGEuTWhQcwxwBds0L+ERlrSX4r+Bjs9L0GmdM0Q90IpDPEJDZp0kPA+fCeN
	DPhxInhae4+sL/e3vmTBp5/2uPUPI1Gn13nJUwXjsBizRWwEFsVmJvR+9ythc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Implement ethtool ops for RSS configuration, and support multiple RSS
for multiple pools.

---
v4:
- rebase on net-next

v3: https://lore.kernel.org/all/20250902032359.9768-1-jiawenwu@trustnetic.com/
- remove the redundant check of .set_rxfh
- add a dependance of the new fix patch

v2: https://lore.kernel.org/all/20250829091752.24436-1-jiawenwu@trustnetic.com/
- embed iterator declarations inside the loop declarations
- replace int with u32 for the number of queues
- add space before '}'
- replace the offset with FIELD_PREP()

v1: https://lore.kernel.org/all/20250827064634.18436-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (2):
  net: libwx: support multiple RSS for every pool
  net: wangxun: add RSS reta and rxfh fields support

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 136 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 111 ++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 8 files changed, 278 insertions(+), 31 deletions(-)

-- 
2.48.1


