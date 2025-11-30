Return-Path: <netdev+bounces-242767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B35C94C22
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B641A3A541A
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE222A4EE;
	Sun, 30 Nov 2025 07:49:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C2D27E
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764488960; cv=none; b=VljFilwNwfiFP+f+sCO0q//kMbuQc3F9cCQlS2d+NSTPWXTeHAUfpAcP0np8ZHv0ztM/PS0qiqRr+j3HDuIkxbCG/Beq0gVgmxVc3uuoTgnVaiTsvuip6UDOnNTKA110S4rZTZOGXJ3zkIVIHUXENMm9eUFHzrvGsXQBLuiRiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764488960; c=relaxed/simple;
	bh=eLj53H6rvZQhgh0sCP/qgWLCVx8K7ZTAEMcf9STTt9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PC/tduCJy1A4j3A7UnyY30I4t7wnk41An/26MHKGvz3T42jh8Im+9qtv3mQZtLtUcwe0wteFFqPBw4idYZiPKb2dW21JxhyXw+pJEFOq3C3WP3mVX4AE1ZT0WMSNqz/tBDnjdljOU8Uq4QaMIu3hcE6L++wuPMvE0g36Caoz9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1764488931t7625372d
X-QQ-Originating-IP: yZeuYH+K2NWl/cN8c5Q1lGZ8X8HTk115c+2xUZvDnPU=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.219])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 30 Nov 2025 15:48:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16355821704819130157
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
Subject: [PATCH net-next v3 0/4] A series of minor optimizations of the bonding module
Date: Sun, 30 Nov 2025 15:48:42 +0800
Message-Id: <20251130074846.36787-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MwQdfXoP8nuz7nExv8e5Jqh8y8rPw7ex05UVQko4XsxhCgHmOz7E1mzP
	ZMk8eWK7PWPSLLhxzHXxgowprDJVLM3xlodtDZ+CXnNduK+TBRm/1YDKnp5eJwmwsk2CWhr
	HpXVIS6Ne35/oqyIsic+Gd0LLuEbxhIAS6oFayG+ruCrcMkP8dRfawotiRLczAMoPRIpWTD
	aZaVicYRHkpQiiMsFNAd4attVqdqEi7PXjqLkE/YzeCd2l5wwhbfC2pWJdmMI+ncswCjvyv
	ZOTCKnz/OxMbxkvlOBlcQjYeLUuM9wGY8mHp5CUPPSwsM5JIK3UiWPGE7ANNoA2wx/sFPm5
	HRWvRaCC90cVQn+qDr4m9Lad2dLDDIwUaLXdk3kQlXATh/CZuvOsB0maEiiE7xRGJmCCNnh
	9hr15822y/WmLgupkyLR+BLa9qsFfBrWbpgs4DxnkT9WuahbahXPkUb8odUlpMmecJf1i8k
	8AzlMy9GpvCdwgwy4fXqfQZBBxFzQC9XmZ57R1QMaX+EFuqrskzZeoZrQKyyq2HrL8zaZ8v
	KOx57wG5yrmwpAPrXIqhl2bSMP+8/ZnNevKjR+6xPjYYVkUWyVVOJwBvWSpwNMcscSJs7h0
	3o0GwvQ4N0L/Lkuhh2azpusoSkA3kCgNZisVEAnAmDOtPpLcRVonalO69KtEsDXaxfUhcPc
	Fn/KxIQbz8WK6/bPMoQMWjbbxFFhVGPSUJcGIufbwjs9ALpsFWAWj9Ip3icwxCdpqqauWcp
	UftbFPgVQiwm+FUBADxgNfAUqn3R23X9QlKcP9Y/iQCffT+HLBCcLXprojebVr/1SAJE5d8
	3XTUUiIz1xkTVwv/pMwMcVKmL0RdpLK5h6qx6v1rJ3KCrmrPkAMFEgtFr29v+OoRa2WYoF4
	eFPqSRKDwjppXRmydN8OQMIPF2C4B+qzd8MV5UZROHfwHPN8/PrGawGfROkRVSSSDwHmEje
	RnL7gFqBfb/Pc/tV1GBtnX+wi03TG+hZCBBR0knMAyyBa/Hk9c9mi36WADhxhKyKH+G8=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

v3: drop the 5/5 patch, net: bonding: combine rtnl lock block for arp monitor in activebackup mode 

Tonghao Zhang (4):
  net: bonding: use workqueue to make sure peer notify updated in lacp
    mode
  net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
  net: bonding: skip the 2nd trylock when first one fail
  net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing

 drivers/net/bonding/bond_3ad.c  |  7 +--
 drivers/net/bonding/bond_main.c | 99 +++++++++++++++++++++------------
 include/net/bonding.h           |  2 +
 3 files changed, 68 insertions(+), 40 deletions(-)

-- 
2.34.1


