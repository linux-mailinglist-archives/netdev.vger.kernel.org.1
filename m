Return-Path: <netdev+bounces-181113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEFA83B1D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB303B4BEE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D220CCDC;
	Thu, 10 Apr 2025 07:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307A205AA5
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269604; cv=none; b=LW9lm0ClCjfV55I5mX5/ksbuxIJGbdzrCvLb/wl2qNc72flaERvXowvnl+tCudX64xbLQVBIidwQ9pJyDABa2wPVczxbSbNDrLaSS50TrJtzbUbMGUWELTn5EutZyJUNSryYyh5aZ12IL1tHb1tZVMR9CF60edkg8CvidaKlXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269604; c=relaxed/simple;
	bh=FyPVmCCJ2zMShyEJWdQUh/nX1BUS/D8dWaEQDYe3db4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WvNjDjpCOZzFkmMVbHlA/VqYYB6yvIpmwf53s79XVduy9gPCwoukHfnekZc4IRsj0a0mwx6UffZPNdfsG0VckfB4qneKVlknFqOP1VDOrK/GSIS5ySctKBg7jm/Jfq4zqqg7gSuVm0vfqIonj1M5c5MyA7+qbr4HPf9Ygkk2Vbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp25t1744269558t2d65ba0
X-QQ-Originating-IP: FIibLGqFLx6cBSnPwK1DxleL6Y9ghllemPI2decv8KY=
Received: from wxdbg.localdomain.com ( [220.184.249.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 15:19:08 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2750494174517785146
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
Subject: [PATCH net-next 0/2] Implement udp tunnel port for txgbe
Date: Thu, 10 Apr 2025 15:44:54 +0800
Message-Id: <20250410074456.321847-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MwqrwaLzgdebL3VjnAP60fyWpZe8ah2KUFrtW5vLrPaXkgpydxZ5MdQY
	Ya45t+4vuu2D5x2J+TtxvoW8ivoz5vE3KuKhDV/8Mb2+9fZ2sNVyfXrdDsfMYdxS58eBUaJ
	9vKWjup2xg5fBycdFFlirQbuZe4lRct1jQ0JT3UX1U3ZPlSD/zYSCqS0U5SjzF/Iyy8f9qo
	E9GUoCdexb7CgkI5YYI1xzAUl/iq5BStb4+Ic/bL6TXULUpk4FcreptKfdhOtpeseIeXxJN
	1sYdtvfCkgczeZ3EodlY2Xt6QOQJKEiqRhM8/7ltuQwELKEpOJl2G9DvzmqjIswmP42WbcU
	NnKtWZiT7U1veMkGwkHi7pHxgWfidPHYhS84jas3SGfcpU9mtvqmeTMGkobtLKnoVBXwN5Z
	M4RNzaFBlXkqjuvTL2BFAH6OE1rpazMZ9tyLD2e1mttTUkb5QR/qVjTlZSDK2v4sj9DZV+H
	viItyAyEBvxKgJCSImZjZCnPW0HHrQ7N1tp0vvX/m7CXP+ncg6B+hYz5hjHAQs4iSOQz6fz
	0d1rk2lweyTB71qrUGGIlfSbVcNLTAVEf7HmRF+hzMb9g4PIDQiR7AgqhEguO4/PZAyMW2b
	gvyE4D7HBK/DupBYCzA9ZhwuiX3VteQBGMxC13LJT55Cr4RLvQDJvsqNEflchDiJEzRjiya
	MnFjfqdPtrgUv3UoTrO2zxsi3uGVg0qiqDRS5WQ7uAWuiH65MiYC2G9Swtz3GgIyviz+oTP
	rjup8+GlLMQnGclyUqo6LCmjjF6QF7jQ1hoJOp7q6gR5v6n1A0MF7HExx60SzXpoGNZk6J1
	G7zeGQdCbVvTSmwruSlXLxMl+jA0KPur75kQ8yCzOcTW79U3+BNS/EFmNMoSDdqYlqonQn1
	9OCbG80/g+bwucqLDqkVn2RPg17t/w77yHeZqaUExmvPK0S1TkME0Q8a7OiMpDZkNQlh9up
	d/p9oqJWKUrXcYZnglF2paZUGE1PgFp5GFAFm7epznVdVwrEnEFL6+c0AmXfVqB79RySddK
	4Zk2KGryXYFV9Da6KrLPw0loI48g8djdHHEIL4pJ6T5cpEcvGJjqjDyzqvdN0=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Setting UDP tunnel port is supported on TXGBE devices, to implement
hardware offload for various tunnel packets.

Jiawen Wu (2):
  net: txgbe: Support to set UDP tunnel port
  net: wangxun: restrict feature flags for tunnel packets

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  27 +++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   3 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 114 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   8 ++
 5 files changed, 153 insertions(+)

-- 
2.27.0


