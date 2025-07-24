Return-Path: <netdev+bounces-209656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E227DB102E2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48FA3AF971
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63C272E60;
	Thu, 24 Jul 2025 08:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622FE27146E
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344467; cv=none; b=Hd/F8xjGRT+af4LBa67BZN9OJ6kPtveMPvgi5OuY0LN77gGCXgmo30WAdMezTu3HyPOM1qBxiIBh4GrFY3Yhq7OdXALzqgH6Q6BRZvs0Tued9TMcH5P+fws8THJ8LvLDtRqJY1c7u12wBZ62tIWxu7EfNoueMCoIb1FB/I1YRuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344467; c=relaxed/simple;
	bh=YYYc9foDjVhRKzIGAxjT5zSiOXGiTC0Cp3AU7QIOjgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HiyrCzn/0Wy56awhWuR5WXcn2R1dxYbVbUNlNXRlL4WQu+qSprTycOsqMgHy+bNK9O3QBsrGY5d9e5/1+/7DcaC8At4gZfBRWMuZDwSLDDYc4KgJ8CtXkaX5DHSnB22BfoA57A5TPVTUKjUncFSfpdjzjwI4IkFq9a9X7owxxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1753344380t4a6c2665
X-QQ-Originating-IP: pvYPyoJbZ8X0ksMCGh9juh9AoS2HU45isUtHAvhQpjA=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.23.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Jul 2025 16:06:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12727271929034278221
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 0/3] net: wangxun: complete ethtool coalesce options
Date: Thu, 24 Jul 2025 16:05:45 +0800
Message-Id: <20250724080548.23912-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: M0N6ZCan9mUhYcq9UE4oeuh7KXkhZO0YnEidAtwgMjVOOIEZZ9R/GI/D
	TPqAYb7ITc0EZS5/f9wfHFPKYLeP5b5O/n+F2s6KTQUx/sDDWsx2cFyo4c3tjUSsAfbZHRB
	KLNIHEVnv6LlAJ/dNlfWOSLNqvhhxhHhC/VUk2PnPquPYHvhZeN+mdzq3EyW7AfcvDPsa+R
	DY4MjRBM5c50X25IArea1ySxjI9QR0SujW8//hAIrbK4KYmDArj+8bKqj7sokBH2k3iKy7l
	kEU/oPVXwnJz6sZm6wIEY7f8jFQf8rrsfS3qxl5qzbk9trwJil66uOS6mLzwabPR3Xl8Q1c
	n5W7sy+SGC7goip2VJVnhbeFgm8IaQg4jKfzgIF9PFuiuQPrXso9vPQ7t4r0968pB0zVYR7
	Um9U9n0hNUhp7f46Hz+g76UaS0GPgVeTneFGLoI0syYk1wmCIyoAhwGsvXJvoM9DdoGtogS
	nhmNpGVC3HBL0wPY6Q4vmZTgZAKaIOEWffHojbzqB7ZLExUJUATVsJzAJXFJPsif6lImSNE
	LI8wVM+FzdaprcJh/YYYKrgpzsmWQkjXmBVJNWmeeK9kzNFyapIv1SmcJR49MMC5+wwiKIo
	cVJfhG6/+mLVnttTDT2pCRNDjaEal8NPLGcXO4o5trTkXVdJxmpETsAkIooSQNojGKNvumf
	OoVMu5wHB+vTyzrldyshlHlcyCBCILJ1vPYI/LpkV5NUZHOiZD1n37Xwck+fm0fAJhrEgQn
	GupmKZKKLOxxen52+1wAsdahaX+Oo2bjSoC5bgXWxPkEBXRPpTC02qDY+B9HCQLSksmxgFO
	3OphJNiF9FBZMyhgMSlteR4A/aYIv8qxzR/HKX+LK/Q5HRSDd5SOK6QPTb/v+VXgsfCZNXz
	NXWfhS0Q2xQMZrXJW+TnNwsgmDxjXUsq4XbLGl5va/8hqh2ZQoFT4MjAk6faAf3EGdaY0lN
	boDaJU2tMZjM22E0ksc2m6xOSWZZZi8Wj5qxfNQdfyjbR376lj3NvvpJDl6T314bFwoGSZT
	MRgfvZYQsrnQahPzt+mMdxF6I/0L4CvsTKOrxlIRgFoSeLLOwJi2OJS8jPH1t0tTf9x2xnX
	w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Support to use adaptive RX coalescing. Change the default RX coalesce
usecs and limit the range of parameters for various types of devices,
according to their hardware design.

---
v3:
- detail the commits messages
- support DIM algorithm

v2: https://lore.kernel.org/all/20250721080103.30964-1-jiawenwu@trustnetic.com/
- split into 3 patches
- add missing functions
- adjust the weird codes and comments

v1: https://lore.kernel.org/all/3D9FB44035A7556E+20250714092811.51244-1-jiawenwu@trustnetic.com/ 
---

Jiawen Wu (3):
  net: wangxun: change the default ITR setting
  net: wangxun: limit tx_max_coalesced_frames_irq
  net: wangxun: support to use adaptive RX coalescing

 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  41 +++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 100 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   5 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |   2 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   5 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +-
 9 files changed, 135 insertions(+), 26 deletions(-)

-- 
2.48.1


