Return-Path: <netdev+bounces-239026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D0C62823
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 522BE35E711
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158DF31576D;
	Mon, 17 Nov 2025 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jA4Vbx/+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652FE315760
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360733; cv=none; b=tpnNBGn++w81i05xLuI3P2DrasmIE70xTfyzZb+Wx1B3nhQ1tn4BMFKPLr40HwDU2JD3Rjx/d2nW14KLbczrNMQ7sPgFfmIJAcBfPfWTqMb0l9Wj77y3u18NgugEYMP1/2pYxSr93SkZAVq9kVZNa0UO5CaEzhznOyv2urJrxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360733; c=relaxed/simple;
	bh=FX/b2GtE+iSRZ+ND0lDKGegz8gwWLSxVhruyGDr9UNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5LnajBTknG5l0Pvi9n4GDSuKp78Gp+vb0eagCUr8r2MHaxgwi0bC/kooYtpo/2d1nm4Dxvm3p/I42h5CODW3ayAJoKFDc6s6CBLC3y3Y4xPxZR/YPsnaBc+7jR9oHPi8fiyQGQZUISWFZ4v3+qdpf0uzzShbZcOzkmbc8DTLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jA4Vbx/+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763360730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JFVx21jirZuEDXxoseRs6EgUvkdDlAkphB4c9PwmqI=;
	b=jA4Vbx/+CfmcHAW+8BzKKkS1Nrv04HYSEfI+OV+ENEvESVGpi9lV52jurUSyF7RaTnBo6r
	aJkUvpsn2Ha1NMwphUWBsIHOT/IGdO98Ex7BFjRJAgRHVrAiemUB4kHmLBXkLsvR79VSyk
	o1CjcO9sgy3bOrZXn2vGB9IkoyuuxL0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-Dr8vavj0MwyGUkrHd2SXuQ-1; Mon,
 17 Nov 2025 01:25:27 -0500
X-MC-Unique: Dr8vavj0MwyGUkrHd2SXuQ-1
X-Mimecast-MFC-AGG-ID: Dr8vavj0MwyGUkrHd2SXuQ_1763360726
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DC6B1956094;
	Mon, 17 Nov 2025 06:25:26 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CC62195608E;
	Mon, 17 Nov 2025 06:25:23 +0000 (UTC)
From: xu du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 3/8] selftest: tun: Refactor tun_delete to use tuntap_helpers
Date: Mon, 17 Nov 2025 14:24:59 +0800
Message-ID: <25be4795bc733d28bf3b042ad052f1f0083dd947.1763345426.git.xudu@redhat.com>
In-Reply-To: <cover.1763345426.git.xudu@redhat.com>
References: <cover.1763345426.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The previous patch introduced common tuntap helpers to simplify
tuntap test code. This patch refactors the tun_delete function
to use these new helpers.

Signed-off-by: xu du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 39 ++-----------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 038051346714..2ed439cce423 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -8,14 +8,12 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <linux/if.h>
 #include <linux/if_tun.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
 #include "../kselftest_harness.h"
+#include "tuntap_helpers.h"
 
 static int tun_attach(int fd, char *dev)
 {
@@ -66,40 +64,7 @@ static int tun_alloc(char *dev)
 
 static int tun_delete(char *dev)
 {
-	struct {
-		struct nlmsghdr nh;
-		struct ifinfomsg ifm;
-		unsigned char data[64];
-	} req;
-	struct rtattr *rta;
-	int ret, rtnl;
-
-	rtnl = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
-	if (rtnl < 0) {
-		fprintf(stderr, "can't open rtnl: %s\n", strerror(errno));
-		return 1;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.nh.nlmsg_len = NLMSG_ALIGN(NLMSG_LENGTH(sizeof(req.ifm)));
-	req.nh.nlmsg_flags = NLM_F_REQUEST;
-	req.nh.nlmsg_type = RTM_DELLINK;
-
-	req.ifm.ifi_family = AF_UNSPEC;
-
-	rta = (struct rtattr *)(((char *)&req) + NLMSG_ALIGN(req.nh.nlmsg_len));
-	rta->rta_type = IFLA_IFNAME;
-	rta->rta_len = RTA_LENGTH(IFNAMSIZ);
-	req.nh.nlmsg_len += rta->rta_len;
-	memcpy(RTA_DATA(rta), dev, IFNAMSIZ);
-
-	ret = send(rtnl, &req, req.nh.nlmsg_len, 0);
-	if (ret < 0)
-		fprintf(stderr, "can't send: %s\n", strerror(errno));
-	ret = (unsigned int)ret != req.nh.nlmsg_len;
-
-	close(rtnl);
-	return ret;
+	return dev_delete(dev);
 }
 
 FIXTURE(tun)
-- 
2.49.0


