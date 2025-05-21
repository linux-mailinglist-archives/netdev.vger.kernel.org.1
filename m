Return-Path: <netdev+bounces-192177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB004ABEC67
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239794E2EEA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59F23E23C;
	Wed, 21 May 2025 06:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585423D29D
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809973; cv=none; b=IYGsoJ0jraxL63rNKyVjoX0jie6ve+jpHYWZ99Mnw7n70ZIHii+gKPpzFGjBlBLK3LKHSmlrOR5LX7x9E2cxBbqNVetXgQtCg7JFRNgI5ilgrAwvt1VqoWTTarVs7Daux3wsrFrqDtgybMYPF1qSWJ/geoHO/VwqmUohgEgprIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809973; c=relaxed/simple;
	bh=YscQreDQBvNBdKQUFvaO0qWGpLWVa+kUNAuW+Aswrxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RO72I8BE9j2lx1OOZ1WDiTWCdMTGz2n+pHa6VW6QqC2i/uCTlk4BOF33KJ0ZNuEjVXrw6f4Vx+ERVEw7FeeUevBJ4ad8hbsYA0U5U9o+NHdDCY0oFb2dD+A2A6TV0deeb7mxtYvbOeT26xwVFcfKp0T9ETdgMhKqJk5eXeMdfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809884t117bc844
X-QQ-Originating-IP: xAHneQnJSyOMz+VxvfvPJCQfB8pQtkaKFBpNuucOxHE=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17426717053815181847
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 9/9] net: txgbe: Implement SRIOV for AML devices
Date: Wed, 21 May 2025 14:44:02 +0800
Message-ID: <BA8B302B7AAB6EA6+20250521064402.22348-10-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MOJijf76Vc+iBY6hMmuQSJRKz5HYHCJRKdIOVYPZgwc8TWlaXzpqUuSm
	p7oFQj2p2lQFC1mmiWTpUHqbRU8D6vZpz96+dKwj+Ii29BJ6Qr0IVd7nCwaQC6ylWp8CB57
	7EwD1KTa+j7uYZe+z7QpAyCaPaRfMgtHM+S3cJtGJZLFT0B3/jI51uCVFfav/l6Gfd7eCWY
	t5CIy50IG934c2hibKwCVPGA9FxyTnfLkGEpq4ZYiVKtOSr8Ei3MHz69gwQ3v4mRIv9EK8T
	dqy4p92ATNW7gEzYiP5FIVwdhnU+Pji7BVfwfLJGVnS8eNnYV+xRfXc38oZi+wpHtal8EOW
	nxfZrSmZWZslCe/WdumQWfmWNiYCMKgODvcqExfqHUxvy/AI4NnNnLOi6x/NU89sS0XNniZ
	9yReyQF1ERhfyqc91de+u/PRK9w/XmP5fwFFgNVoTschLgEPlurNxoRdruFer/KucDMsscq
	3k8IwE0qOLdG2jnVNDggz56BdobnC3HvioR+8+CX/kBwhElNRAPgw+nqcJ99FftrfKMSIpf
	x8i95wEl/VZCk0Q+nqXN462C+qV+FjsugnmCd2is+W4iniOiOiBR6Yl0QkRwKHRHvgYI+2/
	IwSDJSuMDXMpRMkzb1dqLd+FLR745y2Ixp8TXnVXzlubZgUyQMj+YRsKOZOSh8bFa4K50NZ
	NTt2YtXXsMycm2MHRr2421Kyd+IwDYoiKi5QyC/gQ/dU3Q9bvs/fmMQ7F3baDJfhrcquWho
	Oh7G9Iz6ujDZppbNV7yLmPeNqndqWS4PBsM+1+JXwU+FGeiP8Kg8GAcTka6bJWxB82MMBDp
	GJCA5iSwEVRcUcA/MQgRW7WB55CFh5MLPZj3L9RrmBrOOzdMlvYOH7f8oGRfoHR07hpxWbr
	UfxA/7mlDVx4P4ckbh6JTFczAgTLmhpwvO+gNcs2UgHIPDmz7tHW2UfYnfpYeVhMonuAUDz
	7AvCpXRf4SHwhR46wu65wsHHgqR3TK24LUJEIvKA9D6EjouBgpn2IkPfQGxeC7LHX3hMAi4
	hzBPZ7NpgTp18Ub1akwDP2SXbIG2NyFLqbCty5+3qRDI3GTyv8QUrj9Ki0CRzLFjZUv4vLQ
	PogbIIXA2mS
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Since .mac_link_up and .mac_link_down are changed for AML 25G/10G NICs,
the SR-IOV related function should be invoked in these new functions, to
bring VFs link up.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 6bcf67bef576..7dbcf41750c1 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -10,6 +10,7 @@
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_aml.h"
 #include "txgbe_hw.h"
@@ -315,6 +316,8 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
 	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going up */
+	wx_ping_all_vfs_with_link_status(wx, true);
 }
 
 static void txgbe_mac_link_down_aml(struct phylink_config *config,
@@ -329,6 +332,8 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going down */
+	wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 static void txgbe_mac_config_aml(struct phylink_config *config, unsigned int mode,
-- 
2.48.1


