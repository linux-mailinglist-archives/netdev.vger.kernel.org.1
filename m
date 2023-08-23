Return-Path: <netdev+bounces-30076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBA785E9C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CB22811E3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391821F18D;
	Wed, 23 Aug 2023 17:31:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA881F927
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:31:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E8E77
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692811858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqTyXiYk85eSAkuFlWw7TwM0UuCOfOOwIwWYHvwxf1Q=;
	b=PjSivwf1Ka9WdYWh+0SsuUhPQWF0KsvI3HTEsSkPd8rEyndFZqs47YN1PMZQJ45qE4CCXu
	1ffl0BP2hkpZJ1oCWbnvGYyoibepiD2hQoeFn42gqnx51enP8FntVvP90RPB6XbdR00Ku2
	3I94/4weHiVNPr3mVeHy+p3BVh8ggNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539--nPCCUbzOyaiAstHkb_IhQ-1; Wed, 23 Aug 2023 13:30:55 -0400
X-MC-Unique: -nPCCUbzOyaiAstHkb_IhQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBC76853065;
	Wed, 23 Aug 2023 17:30:54 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37238492C13;
	Wed, 23 Aug 2023 17:30:53 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next 4/4] ip vrf: make ipvrf_exec SELinux-aware
Date: Wed, 23 Aug 2023 19:30:02 +0200
Message-ID: <0595f76490e04b9337df0f97001bbc0232c3bd01.1692804730.git.aclaudi@redhat.com>
In-Reply-To: <cover.1692804730.git.aclaudi@redhat.com>
References: <cover.1692804730.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When using ip vrf and SELinux is enabled, make sure to set the exec file
context before calling cmd_exec.

This ensures that the command is executed with the right context,
falling back to the ifconfig_t context when needed.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 include/selinux.h | 1 +
 ip/ipvrf.c        | 6 ++++++
 lib/selinux.c     | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/include/selinux.h b/include/selinux.h
index 499aa966..592c7680 100644
--- a/include/selinux.h
+++ b/include/selinux.h
@@ -6,4 +6,5 @@ void freecon(char *context);
 int getpidcon(pid_t pid, char **context);
 int getfilecon(const char *path, char **context);
 int security_get_initial_context(const char *name,  char **context);
+int setexecfilecon(const char *filename, const char *fallback_type);
 #endif
diff --git a/ip/ipvrf.c b/ip/ipvrf.c
index d6b59adb..12beaec3 100644
--- a/ip/ipvrf.c
+++ b/ip/ipvrf.c
@@ -24,6 +24,7 @@
 #include "utils.h"
 #include "ip_common.h"
 #include "bpf_util.h"
+#include "selinux.h"
 
 #define CGRP_PROC_FILE  "/cgroup.procs"
 
@@ -455,6 +456,11 @@ static int ipvrf_exec(int argc, char **argv)
 		return -1;
 	}
 
+	if (is_selinux_enabled() && setexecfilecon(argv[1], "ifconfig_t")) {
+		fprintf(stderr, "setexecfilecon for \"%s\" failed\n", argv[1]);
+		return -1;
+	}
+
 	return -cmd_exec(argv[1], argv + 1, !!batch_mode, do_switch, argv[0]);
 }
 
diff --git a/lib/selinux.c b/lib/selinux.c
index 4e6805fc..7e5dd16d 100644
--- a/lib/selinux.c
+++ b/lib/selinux.c
@@ -30,3 +30,8 @@ int security_get_initial_context(const char *name,  char **context)
 	*context = NULL;
 	return -1;
 }
+
+int setexecfilecon(const char *filename, const char *fallback_type)
+{
+	return -1;
+}
-- 
2.41.0


