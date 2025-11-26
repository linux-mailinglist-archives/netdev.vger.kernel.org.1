Return-Path: <netdev+bounces-241732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91669C87DA5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E1724E0684
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC08330B506;
	Wed, 26 Nov 2025 02:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D95249EB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124772; cv=none; b=GfAh1dzhdCFmkZC9T2N/JwwyXfVrqVLqbTJryHRx8F4R+Y67SZJ7ul2miMgCxuA/fpjlTznMQn66JnvdTfqjVyohHheGM8XUEYKhC9SUIQsF6JY/qQFAo7nPPnlD5rufz04mmlBlRxHRJifEU56SzZW07P7120vxk4dIlnij0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124772; c=relaxed/simple;
	bh=K3dbR8l2NYljhibZ/WAsweWGe40KtUVe8Ba2T/L09s8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sdSIzpQJjityB1X9RUy1agDv7YA2TBcTLdjRS3YFTSZb/kXnbdzOBg4QLi1tH43Bc/SUM2EkHIu7ly/emnonDSJEBfwc6zrGBxB0UE+/IR5ooVX20QlhN+dydxXvrrzSvy23I2rBxXtgdXe5sJ7Z/xaaJ2xqsC8Nk3tmIROcr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz1t1764124752tb32522fe
X-QQ-Originating-IP: BnwC4NGl29A0wFpU8io2lBuzasp3S5JqYKDV8zzCFeU=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:39:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7778118381014999179
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
Subject: [PATCH net-next v2 0/5] A series of minor optimizations of the bonding module
Date: Wed, 26 Nov 2025 10:38:24 +0800
Message-Id: <20251126023829.44946-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OE2SNMSfMbmOVRc8InBqz7NQnefU4wWyQOmLQ1FMXGaHdf9bt7RXAdFL
	DxSBbS+cg0Vze+dyMAEyUP6p0XMGHdM/hEs/3O5BAAoaM4Iw+Korx7O2uRDLmhn12pAu5f8
	RdwwoClxsqb8D99Fm5lkiS45A0I9l6aEhGSsNuB7uzf0nbX8bD9h1zB4Z2L1R4/LNhQZssr
	0HELBo8EJQkYYcvdWj39T+X1mCGVSaGm1G6mMwBrGuC7kFGoCCtlCXL495g95ObbfQ5Dere
	GWWyoD+OygMaaJqjk006VpchEUUH9wc96hcjqunCkwYMG7eH2ZbipaDZU7bzLrvv2H/Hcsn
	plaJxBKoEsK0y+GXv2NkgPrqP05fkjqpHXFfWKp30FISNQtsKn+2/5/wD01sFH2fZuxoome
	FacYQXIjEa/WqP9c/xK27LTk0WUssQg9E2VuuBcq3GLvC64FKd2YqBLFxItVfK+164gAUc1
	mGG0aD0oaPQU8VjmhiVo+/dY/SDN9dwN0SznAHwWbIh0ZvhesZ8ScAg9kIVMhjqsUWkTz6u
	aRiCXYqSDKfKvbOMlVU+kRkOjtzpTBeImFp+NpuQVNBK0nO/Ypjplq9SqILZnT6FhQnw1r0
	UN0v4oPd3thu7jSkfn3zoqgY99V9TOhUtrqr6njK0ZhnSK0RS4nqou62CbwJ+vxbqNqnJSY
	KFyj9wao3TouA0JsDwCsbts8shuq6zhyeorQ07lihlIH+Sg5j/1cHksyhR9mlwIqH/6Zy0U
	YlvSHAJalGHttccOjGbl5QQ9qR4rbTcKnzTfPT4KTQJ8YUnxQX1U0EbXcH3PMb6EyVOGkeC
	QAVl6e1XqQ1RWhqaqk98h0WlJ76i8g2rIlHYbvNFZeAXlYaWo+WTSRA+zBo5ofZPHFEU0lP
	WkpilkJi/fyyGIn+kYkQz+xtdhyLmGXNmspXonphUFX/YOZiFQJXEpyr+OCYongnx7mIPmH
	uj/30Sx9R+AaJozx2xcrqftJ6JvH56zTKXviQN//1XmTqUvrU42p3gOhFk2p1aPmNcPj3+W
	QqMas6NCrifwM876YP
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

Tonghao Zhang (5):
  net: bonding: use workqueue to make sure peer notify updated in lacp
    mode
  net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
  net: bonding: skip the 2nd trylock when first one fail
  net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
  net: bonding: combine rtnl lock block for arp monitor in activebackup
    mode

 drivers/net/bonding/bond_3ad.c  |   7 +-
 drivers/net/bonding/bond_main.c | 111 +++++++++++++++++++-------------
 include/net/bonding.h           |   2 +
 3 files changed, 70 insertions(+), 50 deletions(-)

-- 
2.34.1


