Return-Path: <netdev+bounces-246223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 638AFCE6528
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7829F3000B71
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DD23BD1A;
	Mon, 29 Dec 2025 09:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF01ADFE4
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001981; cv=none; b=nQMf2qdYwPw0OeYCF76B2Tph3/m0rQrjwx+RAk6tAf3u/hw3yMVl1BXXKkVIEsw0KpdDMwzgSBmsHhlglkEZbZ5I1cdekxnA+suZgKZ0kbRSp0I/di4or78NpzCqamoTz+UcocWrRCbXkLQFsmeWNjOZVrZm2cvaqek5T8tbRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001981; c=relaxed/simple;
	bh=m2aZss0+ZM8b/lxCn7No8GorU3awbdpWBPrKC2tzIHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAiGVTy8QuQMerqXVD7Cq6DNAJMOXDzgpzDYX9rsfea65wg+WTVbpklXyoQpw4XyBrR1051BxZ/h5sR+Xf83zxqq6TAs8/PkG7OD8LrB48Q9zAcQvzs+YCD7V8dZOwWhHZxoYc6GBfQMMUUx/IGSWi7xQBIsslYQiARwSGPtgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz1t1767001960tf8c7f011
X-QQ-Originating-IP: CQ88bxfsKLaLKiLv0+9fB4QYu1BSGSwJr7I9EYcTsmU=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Dec 2025 17:52:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4196833978099224823
EX-QQ-RecipientCnt: 13
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v4 0/4] A series of minor optimizations of the bonding module
Date: Mon, 29 Dec 2025 17:50:14 +0800
Message-Id: <cover.1767000122.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MdzdX6p4PZzkbLQbZEM0BMR+HFB0/IbrJ0SZAqaZaR++02IRgd4rb6nf
	DWtVoBZk6UbPNhbKFT4NHKpaG5UQ8vfxZ10BXsMhGgx/j+0D0tO9OLPaeDaKSEvQSq+qgJh
	vLLiq9w9I+hDKpDQ4ppbb0I/9qbfjMfv+BzyNXR6m1gsjo9NrXRQAfoZLDgckkRladOD7H5
	8lJTVZxnUFIr2bVfapA3gWb40yO2j8wme/EUBjHFfi63GbGYu81hUOUkUHhLjs3+R0uVZ/c
	ULZIvL1KPW8EFj45qlqhqAqdYGlDw7P0RISeurOt5ENKoFucYwWtuCUd5P4l07y5j6fBzbn
	SG+++Ip++V6QHhO+4CvFYpGOavY7NdzRKF3EEbs+OV81KJePwePjitNdX0VDle49eDFDApY
	Xaxy1a4RX8DI9hzMSMQl3wF8QCwfPRI2mXrAYw3feUDs+Xz2V/rgiUOsh2aOn2m/GT1awZ3
	hIAT60oWGcVYmImyuGwS9KJyVB75QosHxxurKEAlbuStb1QpUnqSuUonnWcKd6ZCFkak15y
	7m8W9229jgdLetG9Uezz2p6uXDJCjCkFlBZoK848PbfkNfcmg9rK29Me3ajSjOA6v1vKOKV
	/9rtHvZXQnd3l0OZtBPuAGOqOZxjcin0oQkizoE2DHCIuW9fQul3ocZ2jcq+dtZ97P6Tplh
	NpK4Rkb/JRNivIJ5RLKccTBcm5Uxs9LReLa3WP2rhKTs6vV2YkghclUy81Zm7g6FJ9eX0Sl
	GNnsjVkPA5hGsr8acGQorTCHLzZ3KxXcPozn1ugPGfh2F4dAGisS7on0NPG8xO8EgVQba8j
	iPiCUbbTKw9soBPvhNfrkhJXUYGV0BgyWphQFnYIqJHoW/US7XJduQwiX5ZQet/klu/bcnl
	0YVnNyNQzQLRqMU2y4leS6zP7KvFLcvjDF8xSYBoYQj6PmDyuoz9JGjGc2yIkzLGgsPDhlp
	wEZFtBO7IELU/l0g/hF2hJ+7agUXTXDpkMDAStixnGR6dphzvhyJ1S/8lkZzauLG4JGE=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

These patches mainly target the peer notify mechanism of the bonding module.
Including updates of peer notify, lock races, etc. For more information, please
refer to the patch.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>

v4: patch1 keeps the netdevice notifier order
v3: drop the 5/5 patch, net: bonding: combine rtnl lock block for arp monitor in activebackup mode 

Tonghao Zhang (4):
  net: bonding: use workqueue to make sure peer notify updated in lacp
    mode
  net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
  net: bonding: skip the 2nd trylock when first one fail
  net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing

 drivers/net/bonding/bond_3ad.c  |   7 +--
 drivers/net/bonding/bond_main.c | 101 ++++++++++++++++++++------------
 include/net/bonding.h           |   2 +
 3 files changed, 69 insertions(+), 41 deletions(-)

-- 
2.34.1


