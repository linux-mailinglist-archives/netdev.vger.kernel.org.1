Return-Path: <netdev+bounces-251844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CMjKueocGnwYwAAu9opvQ
	(envelope-from <netdev+bounces-251844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:22:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BAF5524A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEA568EA6E0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B69481ABE;
	Wed, 21 Jan 2026 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAQkP8/A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E2481ABC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989933; cv=none; b=SE0x5pDCjJr6JVVvbK5wge/1ZxBe1w/ZsKvaUNnpNlvt2Q5Yl5PQgTdgvtWy8HY4REk/WmHrVEorPszYyQehBVW6Q5rJpGHV4HnVPbZyzCs4dWeTbY72mE8ZSy6Wzacb7DCN/LmZFPA6jX4F5Y66WL026AXySNMichEiRnxyLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989933; c=relaxed/simple;
	bh=n+m2VuVXUv3lxLyuNjmRYwc0S4tL9Oik60u26VWwd3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLfeie41uv3NKmG0GshwO8NjkM9kUID4VgYFy7Svw1+XmxLijajOjESII6tkK7gzIVRxE8Z4HuCOn9IZmdzLrOwYyMayReAsxxsSKI7a5ihkVzSBpyc/aSY5aXXqgbtdh2idCfcv8KQ6l2C9+Qsk8eqps/tdbyYHAASdbuNGlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAQkP8/A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768989931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5aWAKuKoeXw5s3C5RFqgR1rdzlyWibIsmBE/Run9AQ=;
	b=jAQkP8/Alqm0EwwI1V459/W/kpojGnLCuuvje8fjBp67pg5ZcYZ+hTDqOBo0Dq7AnAp3FB
	n4YqP6pQW5yyafDp+IY8p3JMh0V8ONeAarLf1aBA5//QlrVrR1DC+Di2CUBM71YUhcogJT
	iT2EBqSmlIZbPA8vG6iVr44+6PEVk3k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-FuuvoICMMge7RG5MmyPsXQ-1; Wed,
 21 Jan 2026 05:05:28 -0500
X-MC-Unique: FuuvoICMMge7RG5MmyPsXQ-1
X-Mimecast-MFC-AGG-ID: FuuvoICMMge7RG5MmyPsXQ_1768989926
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84A2818002C3;
	Wed, 21 Jan 2026 10:05:26 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53D781800995;
	Wed, 21 Jan 2026 10:05:21 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 3/7] selftest: tun: Refactor tun_delete to use tuntap_helpers
Date: Wed, 21 Jan 2026 18:04:57 +0800
Message-ID: <ecc7c0c2d75d87cb814e97579e731650339703ab.1768979440.git.xudu@redhat.com>
In-Reply-To: <cover.1768979440.git.xudu@redhat.com>
References: <cover.1768979440.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251844-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[req.ifm:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ynl.mk:url]
X-Rspamd-Queue-Id: 16BAF5524A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The previous patch introduced common tuntap helpers to simplify
tun test code. This patch refactors the tun_delete function to
use these new helpers.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v5 -> v6:
 - Fix the Makefile format errors.

v4 -> v5:
 - Delete device using the new ip link YNL API.
 - Linked YNL library to the tun program.

 tools/testing/selftests/net/Makefile | 16 +++++++++---
 tools/testing/selftests/net/tun.c    | 39 ++--------------------------
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..11a5f5ab514f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -180,7 +180,6 @@ TEST_GEN_PROGS := \
 	tap \
 	tcp_port_share \
 	tls \
-	tun \
 # end of TEST_GEN_PROGS
 
 TEST_FILES := \
@@ -192,7 +191,11 @@ TEST_FILES := \
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller
-YNL_GEN_PROGS := netlink-dumps
+YNL_GEN_PROGS := \
+	netlink-dumps \
+	tun \
+# end of YNL_GEN_PROGS
+
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_PROGS += $(YNL_GEN_PROGS)
 
@@ -203,7 +206,14 @@ TEST_INCLUDES := forwarding/lib.sh
 include ../lib.mk
 
 # YNL build
-YNL_GENS := netdev
+YNL_GENS := \
+	netdev \
+	rt-addr \
+	rt-link \
+	rt-neigh \
+	rt-route \
+# end of YNL_GENS
+
 include ynl.mk
 
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 128b0a5327d4..d9030bdd2e06 100644
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
 
 #include "kselftest_harness.h"
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
+	return ip_link_del(dev);
 }
 
 FIXTURE(tun)
-- 
2.52.0


