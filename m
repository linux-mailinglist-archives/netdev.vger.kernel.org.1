Return-Path: <netdev+bounces-232521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAB2C0635B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AEC1C038A8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE4E30B52C;
	Fri, 24 Oct 2025 12:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2F2FC877
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308400; cv=none; b=J5Uv1li+KQCkh0ZRUaopbSaGxryXrq4jztgJr4z2xgMMyAnLiCm7xfXHS2lMPgaRXBvZJt5uYNQQY7vllzUO+mN6XnHXrSIYVu0NUdZpKmTHjEgH93g0W0qk6Ne0vl3wJ6zfdLSOpoJKVE6fATu0fXX+fTAoRhM+JRmTDaHNK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308400; c=relaxed/simple;
	bh=N7bYvZ7G6mr5HXK56jX+rEn75FO4qMTwALC4zGvUuN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diopE/QyTyrNo4OOocBEXzEFLae0Qbxml3TjaKIhT8WPUKuyPH25QYs3KRfhmbU3HkOpGqNqfPXwkFFH6hqK0pjLdAvHcRUnoSiL17v+g/Qco1MlnbhOzB8f3LFkOIWvgNu9Flq5Mm1L+LNMVVMf2E+XP8gxSAnJ/zEuMrXbZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz6t1761308347t19260049
X-QQ-Originating-IP: SXgeuczB0FTUkq+3R/HvNID98S4zrTFQMWH6iPe5GcI=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Oct 2025 20:19:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10794608114889597100
EX-QQ-RecipientCnt: 7
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Eran Ben Elisha <eranbe@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Ido Schimmel <idosch@idosch.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2] net: add net cookie for trace_net_dev_xmit_timeout
Date: Fri, 24 Oct 2025 20:18:53 +0800
Message-Id: <20251024121853.94199-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NRkWGnbnkwTm1BQQgc9F6KeuibmtB5ePwGjGmYLygSsQ8zu0lvdYbqwy
	JblvCUNNUHgSfOUAPRVZTsrBqqGKCT1+gkRTLUB/5s/FxKR8g6phv913kTD0skfowkls+fo
	Xq2d7Wr16lZLkWFnSdM4lVNL2FH2+zj1V7x9sHY0ziuwBNYAPlg6yYgfwTK84TF6T1zUlu0
	viGWI59mz4SzKUSRhUAla1nLErUMA3VGhtuuwGDPvto60Jpl/TR7SwCON0gehxI8U2eXOJz
	9OYxAn5uOFI0tjp7pqt3yep5z9MeGEnQgZLwqjW5SvhjEWwFqTpQdFWzjqSqY72u9yhx+n+
	sQwZXTppRD+wOPQXIpBTBntKjHYHV+1NDqpL1WcFofb+J6fKEhn9DLuliO86BFcNB3noMA1
	zegQEDF8Ii2oMSF0a7aJOcluMiTxjkhpHhV7gR/tBVV3+R360oQiJPF3xjyKLK/LcJcR36Z
	7UqtNuoPx1UEgSnXLcHNUPPAAFA1Q+9qRS8MhZSxsOmCXX8XgtOnmMEhd1QB7DS07i72/JK
	rdm9MODtV/yFPLS57kKGnp3ek22a0a9IIkhsjU7I9E6A8XJ+y/x0Ex4pSnDocVebPjWSETV
	gVWoWS+XiPBDmYHLxVFursqe30k3os3IMyhcSNY8TyqBZ1IhhpY6QwzX/6Ds8WtwRZ7jd8G
	fQh2jJq3JANZHr6E14H00EgilkQ+KWLmuwEZhQ1YF0QLL2iSY+MiaLrkBsaFoljxm2qcgo5
	bfXGCrOKxxaE89ZpUIVxwtZmjJTDh5flrA7eS0TEZ7mNFFeCWZ13l5WOrI5FlyoDchD7/Kt
	pXZIFA76uwWgDczOoikI0wlHt6/bEjMQzz+OJnGKdG7A9as+GBDDYsdoWktGCdKHwcw2BRM
	ngTr+arrKNT+eLYFGRoTil5xZGwJSWqK5MQFAAXuRY20In56kbolDKtjYV7R3hbrtvY5x1t
	Tlw5FqBqifi5/MQ/bjANIaC5ClYSWj3FYIgqSAW+S5gS8okETlmzjWoTZ
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

In a multi-network card or container environment, provide more information.

[002] ..s1.  1838.311662: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
[007] ..s1.  1839.335650: net_dev_xmit_timeout: dev=eth4 driver=virtio_net queue=10 net_cookie=4100
[007] ..s1.  1844.455659: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
[007] ..s1.  1845.479663: net_dev_xmit_timeout: dev=eth4 driver=virtio_net queue=10 net_cookie=4100
[002] ..s1.  1850.087647: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3

Cc: Eran Ben Elisha <eranbe@mellanox.com>
Cc: Jiri Pirko <jiri@mellanox.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
v2: use net cookie instead of ifindex.
---
 include/trace/events/net.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index d55162c12f90..8d064bf1ae7f 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -107,16 +107,20 @@ TRACE_EVENT(net_dev_xmit_timeout,
 		__string(	name,		dev->name	)
 		__string(	driver,		netdev_drivername(dev))
 		__field(	int,		queue_index	)
+		__field(	u64,		net_cookie	)
 	),
 
 	TP_fast_assign(
 		__assign_str(name);
 		__assign_str(driver);
 		__entry->queue_index = queue_index;
+		__entry->net_cookie = dev_net(dev)->net_cookie;
 	),
 
-	TP_printk("dev=%s driver=%s queue=%d",
-		__get_str(name), __get_str(driver), __entry->queue_index)
+	TP_printk("dev=%s driver=%s queue=%d net_cookie=%llu",
+		__get_str(name), __get_str(driver),
+		__entry->queue_index,
+		__entry->net_cookie)
 );
 
 DECLARE_EVENT_CLASS(net_dev_template,
-- 
2.34.1


