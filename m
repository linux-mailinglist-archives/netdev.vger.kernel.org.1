Return-Path: <netdev+bounces-132677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA73992C3B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FFC2820A8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B771D4164;
	Mon,  7 Oct 2024 12:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EC1D4142;
	Mon,  7 Oct 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304917; cv=none; b=L717ehAFg9gwxd9Ou0Vw1RaXUvDIRUOQKRu0GxqRECIIfVOXuuekDcZdggOR9U7gUCj1lBVIN4cW2onsRIGokBncUg+zaxE3lSsa3kRogVtYxpSNXB0dVRxgjhDe186PhteLSc5FehsjL9VrICmZWHpXonQ0AZio3Wmqt48GH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304917; c=relaxed/simple;
	bh=ZGw/ydXe3lqLhHPyW6x479+JVflWiIK6QLHwbbeX1Bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwU/myu8haQ9qrg3NCOiSmDQM2mBhNfw8PpS8dSgVuP+MsbLXO3zhUhHrglLV8OSMEvJOWuHkfjCyZCD+lQna+SnWoziFi2J/w0s3NtVXRbwAEckXtEacCyHUC5doorb7BdYIadAnEheC/+sXI4loAQ/FWqgr1K6g2UtJtowPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XMdzZ0zbMz6G9gq;
	Mon,  7 Oct 2024 20:40:42 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 647F114011A;
	Mon,  7 Oct 2024 20:41:53 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 7 Oct
 2024 14:41:49 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v01 2/4] selftests: net/psock_fanout: add loopback up/down toggle facility
Date: Mon, 7 Oct 2024 15:40:25 +0300
Message-ID: <31c93d3d050cadf75aaa833aca4b6614666ba8de.1728303615.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728303615.git.gur.stavi@huawei.com>
References: <cover.1728303615.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

Prepare to test setsockopt with PACKET_FANOUT on a link that is down.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 tools/testing/selftests/net/psock_fanout.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 4f31e92ebd96..a8b22494a635 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -48,6 +48,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
+#include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -58,6 +59,43 @@
 #define RING_NUM_FRAMES			20
 
 static uint32_t cfg_max_num_members;
+static int lo_up_down_toggled;
+
+static void loopback_up_down_toggle(void)
+{
+	struct ifreq ifreq = {};
+	int fd, err;
+
+	fd = socket(AF_PACKET, SOCK_RAW, 0);
+	if (fd == -1)
+		return;
+	strcpy(ifreq.ifr_name, "lo");
+	err = ioctl(fd, SIOCGIFFLAGS, &ifreq);
+	if (err) {
+		perror("SIOCGIFFLAGS");
+		exit(1);
+	}
+	ifreq.ifr_flags ^= IFF_UP;
+	err = ioctl(fd, SIOCSIFFLAGS, &ifreq);
+	if (err) {
+		perror("SIOCSIFFLAGS");
+		exit(1);
+	}
+	lo_up_down_toggled ^= 1;
+	close(fd);
+}
+
+static void loopback_up_down_restore(void)
+{
+	if (lo_up_down_toggled)
+		loopback_up_down_toggle();
+}
+
+static int cleanup_and_exit(int status)
+{
+	loopback_up_down_restore();
+	exit(status);
+}
 
 /* Open a socket in a given fanout mode.
  * @return -1 if mode is bad, a valid socket otherwise */
-- 
2.45.2


