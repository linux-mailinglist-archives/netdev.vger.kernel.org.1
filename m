Return-Path: <netdev+bounces-130493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2898AAF4
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707941F22130
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B581957FC;
	Mon, 30 Sep 2024 17:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A319922D
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716689; cv=none; b=KwkCRZcPC9PahoOAanMC2WDeTAhQadtYXhq4HhltKtIqne3fmRdrV+H0nObHbxei/UET4FguVxpRD7L+0y1/Khj5DSNl+E91Ggy5lO3tw/lF55l6fJ6VmqV5CtdlU7bNmdpfzB+34FTRvd4Vt7uWRUfpjSwYa6seGqVh90j00G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716689; c=relaxed/simple;
	bh=DchTwohJsAm9ztDbrxiO7lBrit40qg4YFTMOJURrdl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEd+S3jg7njSbR9bPqwike0ExGrON4ZLBvVeAxbJYehSwUtf6c+4qbXYAi4Bs9Uy/Bgic44h7ofbpGdUBq/E52ISdV+jTrrUU9clilIADDivcjUkCnFdxms76kDivpbpqBpoAJi/othzh/uAYpaUWVouBeYXTKrqnwdw6NApGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b0b2528d8so51020435ad.2
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716687; x=1728321487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm/BiP5G4zd1/28qh8JWsTl9oMWQWTePUlVBIOmJBLY=;
        b=lRoYPa9R4LMx9SObYEFdiWoLXJj5RdjRlqnS2x/FOm6IDtrCbj3y0/m4n3gs4QbctE
         wAho9hZ+8Uz2BT/XUdrs1CG+MXkebW40ikkIB8ZTox4t4mMQLfQ7ceSKs+IaTZeAMYos
         XieusnYuFVj7Go1bbm/bcrxnDD12zk5XMWK1Sf5RK1vLP2avYM8rN3FUzqsTaOK/NfK4
         KiLeT3DFjRKwOZ25kAkZpK9YPq6FTBsD0QIwZeR7p7hIf2Wx4+0eAukPJDQqBiSQSGQG
         eCfCM5gFSr+Dtk+AgMJxC8UsYyHam3ld1wFN0xFtjxJuNgJQxKzsQKGHOJF/vX/zN65g
         WzTQ==
X-Gm-Message-State: AOJu0YypHRJPEXIN++k0DiQxzJ50A4ohRE6AytuB/sjgAwAc3DV1o7uZ
	/nCfDJjLAsb7tcQNzI2oj0Uur8+09DeAWLwq+nb28eWIPwOfXSqynHN5
X-Google-Smtp-Source: AGHT+IHVPlJe9DUgw0z1GDKkliuMRleHui99SwTPn0rpxRJ97jU+y4XirIWkq2mocdAkfl46KnZtSQ==
X-Received: by 2002:a17:902:dac2:b0:20b:85da:a6e5 with SMTP id d9443c01a7336-20b85daa92bmr74371315ad.8.1727716687260;
        Mon, 30 Sep 2024 10:18:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5169csm56842855ad.238.2024.09.30.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:06 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 08/12] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Mon, 30 Sep 2024 10:17:49 -0700
Message-ID: <20240930171753.2572922-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next patch the hard-coded queue numbers are gonna be removed.
So introduce some initial support for ethtool YNL and use
it to enable header split.

Also, tcp-data-split requires latest ethtool which is unlikely
to be present in the distros right now.

(ideally, we should not shell out to ethtool at all).

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/Makefile   |  2 +-
 tools/testing/selftests/net/ncdevmem.c | 43 ++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 649f1fe0dc46..9c970e96ed33 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -112,7 +112,7 @@ TEST_INCLUDES := forwarding/lib.sh
 include ../lib.mk
 
 # YNL build
-YNL_GENS := netdev
+YNL_GENS := ethtool netdev
 include ynl.mk
 
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 48cbf057fde7..a1fa818c8229 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -28,10 +28,12 @@
 #include <linux/netlink.h>
 #include <linux/genetlink.h>
 #include <linux/netdev.h>
+#include <linux/ethtool_netlink.h>
 #include <time.h>
 #include <net/if.h>
 
 #include "netdev-user.h"
+#include "ethtool-user.h"
 #include <ynl.h>
 
 #define PAGE_SHIFT 12
@@ -217,8 +219,42 @@ static int reset_flow_steering(void)
 
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
-			   on ? "on" : "off");
+	struct ethtool_rings_set_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_rings_set_req_alloc();
+	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
+	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	ethtool_rings_set_req_free(req);
+
+	{
+		struct ethtool_rings_get_req *req;
+		struct ethtool_rings_get_rsp *rsp;
+
+		req = ethtool_rings_get_req_alloc();
+		ethtool_rings_get_req_set_header_dev_index(req, ifindex);
+		rsp = ethtool_rings_get(ys, req);
+		ethtool_rings_get_req_free(req);
+		if (rsp)
+			fprintf(stderr, "TCP header split: %d\n",
+				rsp->tcp_data_split);
+		ethtool_rings_get_rsp_free(rsp);
+	}
+
+	ynl_sock_destroy(ys);
+
+	return ret;
 }
 
 static int configure_rss(void)
@@ -354,6 +390,9 @@ int do_server(struct memory_buffer *mem)
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
+	if (configure_headersplit(1))
+		error(1, 0, "Failed to enable TCP header split\n");
+
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "Failed to configure rss\n");
-- 
2.46.0


