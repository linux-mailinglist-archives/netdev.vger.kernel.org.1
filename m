Return-Path: <netdev+bounces-189951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF8AB4950
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E416A463844
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAA1AAA11;
	Tue, 13 May 2025 02:12:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F22191F72
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102337; cv=none; b=hQQXQ+NulOjbnTu4UD2bKfB5V8mu5ym8GAf/DN0J/L52b796xlE+m4BRTXHkgRPQSvfbOKP4K9BKunMCrzsSSCyV4Z3yogqgsH+qCSG5ah/1Yky3GU2qXktL7xrJOkbXxr2ZkGvekPX+NNp2gXkXQmhTF/45xjuCtaeN/X7CAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102337; c=relaxed/simple;
	bh=SQRiXXqvK5crfznlfSKOcLHKX2s7iPKh/Y9c4rEoZdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCfoAasRjwZJWgENMLmVgklv4p5znAeN7UV5tocBweLnxoe5rAWo/VkFeWsDj+xhkWBi7jSXoUEQ5kte3FK8zNwusghpKB/ZvhEDkgHrZ9QkQO+sV6sk4JH7BH0LgMYmcb7hvINjPNqadZeXu90EGz6Ew9JCDDWvVvtAAWv3opo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1747102223t62087d12
X-QQ-Originating-IP: A4OUyRW+b8nhbuLDZ69fsV9BhPJM0KlOnOA3ZjhGRxM=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 10:10:15 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8438290910978052792
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 0/3] Fixes for TXGBE AML devices
Date: Tue, 13 May 2025 10:10:06 +0800
Message-ID: <9B738C8A5BE33471+20250513021009.145708-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NPwdxSKNG61XOkJmV3mSTj5csWfTBRiAQBl/IW/RxKD0BEcV1n9BNJlq
	Boy0Vsu+knn+znTi4hv+Ei8AVYxdGc5PHke7yhRkTfV2of0PXiAawWlMk6ETC/kOdzERfWx
	O7zaVpqQF6MLP4Vum3t1ppnsTMVtMzTdoHmeIwN8wrevWXP5i3ojHeBG9BuY339dBItGqiR
	zshNXQ+lNvfr89rcPmFprDYrME0uzcFzPIYm655cI514vqRyp4Zj3/ZD+wyhOiane09L0G3
	dXhPZfX/kNAnhjliV4o3SjJHtt8UkL+cHPh5gPjvnfStOCPxkPp3JvaJFRVIc6PzSKrWfuH
	YUbpS6GDosa0JiQAxL46wYCZNsruWU981OHCe0zZCNYWyHCAjkMwM2eTSpMcbkd9CVqi+iw
	Jcxeq8Hk1MAROpmUdeGr3IYCMnAkNPeIVrx3v3XP3zjqUh2tmukqzK2XZIQT9Qcy5QC1TE0
	ycdg0M2k99Jx37lNe/xKVF71DjZcF0jo5Yo+9ixcj4Ltxmt45QD/NCT381QiKiANROkEo5w
	XApbRwQ7PrB0lZH9UYuQWkL3Jt58hjdYqCp5WlfsCQZTjizCM0e5nPXWwNEJOwlt3X77eyW
	CfwlLqYFWwbGAfCHKiSeEJlEdsApZyQpznsS+A9/Edy+9h9VBkRFhPlRzm0qhjmmpY+76zv
	4kyZmU5ZFi9XtJ4tE+ARrstmSeL+ZUMKJN/ZxYLDRjcbkizN6wKKZk4QZBoIsD1YxGPKv6S
	22dSip8UPzAq6q6w65tB3XkJUTzuhb7ou4AfBJS8diBvh/WO5l20AmEpmyTmqaz+uSVXFtM
	0fCk5N0/WsPEDeZuf4mXcZz+d4/4+8JpyfjAUtVmbcQjPFpjo7Qn2vAn15lGZRcqR8Tvoah
	9hMw5jg759k+KG84FTxR3+zP9YHFVW1PLz4/AcrbOfAT+tKy1I99llxwHu4JzlUeexrtout
	Br+KXMuFVdVymWP+Lg7mWc+2dp3i2RKnQT1d2UWSX2jzDBIqw/c7I26ShY/rnilIpk05Yy/
	icIuHH10pF5HbXQMUA
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Fix some firmware related issues.

v1 -> v2:
- Split the fixes to separate patches.

Jiawen Wu (3):
  net: txgbe: Fix to calculate EEPROM checksum for AML devices
  net: libwx: Fix FW mailbox reply timeout
  net: libwx: Fix FW mailbox unknown command

 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 10 ++++++++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c   |  8 +++++++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h |  2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.48.1


