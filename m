Return-Path: <netdev+bounces-246865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE4CF1C0D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 04:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05C7B303EBB5
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 03:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8C320A09;
	Mon,  5 Jan 2026 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQg5Ov5v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CF23D7DC
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584713; cv=none; b=Q1wcU1HLizRSDh6mLIkGkwP1Eh001O4GGfEGxu97lLSklOkG3aAn0HPFSlV1rOMTjZKubqusi1y38N7dUwN5mkkVZdAzEAeK5NA0iXUF9BSWTQfMdruPguacjDVnKRkJCPDuDtiwN7rN8ctqofldBLBR5N+9NqhadsTLLpun2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584713; c=relaxed/simple;
	bh=uRFxgVVwz4SIzsd58nKVZfi6jcW33M/juIg8syiwhW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXSigqh6SOvvfdNpid1MWI0IMYD2E8cLmsn2jBQXsXVxfcZfgC5kktLWemfB7kcGYFAGXTjx41gAPCyFTDd4B4r/hmOwVKVhMekctNEHRt+wuMx13VnllfIgZc5p8IqFXIkFt+cy1VKIk5FcAzyxZg2WlnoUtHMtv0HCzbnE3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQg5Ov5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767584710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+m7vsuXPa0IEo+bxmHFD7Tx24Sxf6E+9tEfv8GQStw=;
	b=aQg5Ov5v700EOnmtPcP1khFP6sNIFhkSbE4ymMm+fDkkCvnjpgrGPut1MtvyhTJLDIJtP4
	ZEX6pGGgMjKvIh4S+0Oyw29yIn+sdFvqrBHyC7TJzSO94T6RKRovNA53z61Dw1EbZyuBXx
	g0i8mQA5AWYIsegqPeJtKY3VwAt8z30=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-ecJvDtlcMhuejjHxkWFmIg-1; Sun,
 04 Jan 2026 22:45:07 -0500
X-MC-Unique: ecJvDtlcMhuejjHxkWFmIg-1
X-Mimecast-MFC-AGG-ID: ecJvDtlcMhuejjHxkWFmIg_1767584706
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED7711956050;
	Mon,  5 Jan 2026 03:45:05 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F2CE1800367;
	Mon,  5 Jan 2026 03:45:01 +0000 (UTC)
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
Subject: [PATCH net-next v3 3/8] selftest: tun: Refactor tun_delete to use tuntap_helpers
Date: Mon,  5 Jan 2026 11:44:38 +0800
Message-ID: <832ffbf4ec570342e29c75a02457e3f4e2beb14a.1767580224.git.xudu@redhat.com>
In-Reply-To: <cover.1767580224.git.xudu@redhat.com>
References: <cover.1767580224.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The previous patch introduced common tuntap helpers to simplify
tuntap test code. This patch refactors the tun_delete function
to use these new helpers.

Signed-off-by: Xu Du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 39 ++-----------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 128b0a5327d4..08e760fa5d15 100644
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
+	return dev_delete(dev);
 }
 
 FIXTURE(tun)
-- 
2.49.0


