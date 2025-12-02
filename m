Return-Path: <netdev+bounces-243155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061CDC9A248
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 06:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15323A550D
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322E2FD1A5;
	Tue,  2 Dec 2025 05:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixNjysfa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AF2FD684
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654820; cv=none; b=qyRtSqhB9qOEwvgDnDNBaSxo2uqj6PJltWztDkvf/WPjj0UOzmtA25RM7Ny8pNp75AxQSn7bCjf72di8mM2XYeaxZiJoXT57gcJ8EcAZDZIuZRCl2JRG0Gbyyup/m2H5HfTAKtMmXBjnoo3/XOcbr6qU6hM/F8DToKcaNGLTg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654820; c=relaxed/simple;
	bh=MArT0WZcCNUlkE4LHYHExUAoJVmOQGV3XZUSe5IITs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvd4ZEv2JRIQGHg2JqgKM4PXy0gea1qZd9h5OvLIATKIJaw4ZFiNNigJuVOWoGOqBARE9kTQtMu94BinQ2g6B0FeiNs3gvplBRyaNI8TNV2nWCz8IxYoCquZXJIV9hNwujG3bD3OnN6jVxGVUipxN2BqqMjqXTt3lpgz9K3Qd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixNjysfa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764654817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jmv21TVxnSJ31M3zk6ee/o5jW/F7IMGUM0oXO0AolW8=;
	b=ixNjysfaVSFEpaas0UxqE51ORoumm04zaQnPdGN/HFfu2aYcPNLMEkur/oMaM+x6uEJW/x
	qqRQyAQ/rnLaFDdWJb/Bele4KWYimbnfrrrIFDv7Ca5Tqj15TLJDG1GJnxhy3VutzQnFbE
	nJnZzBjsdpoZtvP/EjPgzaG1qqmlaio=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-hWvHPZnhNj-lV3p9gUAgYQ-1; Tue,
 02 Dec 2025 00:53:34 -0500
X-MC-Unique: hWvHPZnhNj-lV3p9gUAgYQ-1
X-Mimecast-MFC-AGG-ID: hWvHPZnhNj-lV3p9gUAgYQ_1764654812
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EE191956051;
	Tue,  2 Dec 2025 05:53:32 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01AA930001A4;
	Tue,  2 Dec 2025 05:53:28 +0000 (UTC)
From: Xu Xu <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	Xu Du <xudu@redhat.com>
Subject: [RFC net-next 3/8] selftest: tun: Refactor tun_delete to use tuntap_helpers
Date: Tue,  2 Dec 2025 13:53:06 +0800
Message-ID: <5e7fed355f37b299db65dfb0f0d87be591439f02.1764640939.git.xudu@redhat.com>
In-Reply-To: <cover.1764640939.git.xudu@redhat.com>
References: <cover.1764640939.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Xu Du <xudu@redhat.com>

The previous patch introduced common tuntap helpers to simplify
tuntap test code. This patch refactors the tun_delete function
to use these new helpers.

Signed-off-by: Xu Du <xudu@redhat.com>
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


