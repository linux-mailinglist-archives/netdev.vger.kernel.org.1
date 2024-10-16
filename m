Return-Path: <netdev+bounces-136300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE06A9A141E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF1C1C22661
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818902178FD;
	Wed, 16 Oct 2024 20:34:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC802141B4
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110875; cv=none; b=AE2VkGi7UvU5SWTk3KN+YphbupKpzLbkO7ZpRdCaIi+9FfqNqVXeLQX0HE1ZwpPqM8/57IRztjw1RCSx9Ba1W1SbmFDsrDq9EUKUOKAbayn7jN8byuQ1fnA/bFpF/A/XwAOj6uE3iQDzoZcNl5G3cE0yN4+6sCrIM3fMWUa0tKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110875; c=relaxed/simple;
	bh=hcSkixFqYg77HXfsdEnTEFIm/AfoFOJ9R1hTNzARkKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcPwqbPvDhdFRXBXsUxhTOCuRr7ACiBnObaR4E+gxKxA0Bclg3lq4s2FEIs6oV2uVS1jEfVpzZhBYyTtCM7JNfwyPsJZ3mmRajX1ropLWZoCDhSVoamYj3wfqJGpO/JXupnwksaFr9q7chigjoywU4T0lvjyx2NafG0SO57HC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207115e3056so1792845ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110873; x=1729715673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGR7mUAuBlH1rOyWnnV5cxrmcOdzxRmCwpeuqeEIrHY=;
        b=tE9u4PluINyy/9r/iqcmWF05vV0Z0hBdg/L7Qn2bXG0dmF/BUyBJw6MbG7x+lUVKc7
         o9blyDfb7CW98bKdxLloF+efx1o+OVFMKkzROx/55lWry+yb71WmBJAnzpNDVuBhk/qa
         +xDlpNAXx1PFaTJCpdshzrjW0zPA4k4qMPHudmSnHmJS583oD2pcdQgmlfgFjgQuyKmp
         4dwqeksTFTYZIsZGDZzMHWrkPrXqQc9pvClVJV2UJdW8NaY4+UBUL9kUoQRjrtAR2S9x
         Y06z5ULEL8aoEehKh1lS7IWUVeiMAu0OA7wnMZr5B0G8uBwr9/lfZznBO9uvGt8gHMXf
         eK7w==
X-Gm-Message-State: AOJu0YycAGlWJIsjQhKkry+fSAAaXea6dKLo+Pk/Y3AB8ic9Aoa7gTU/
	VD13mhZ+LhSOUrhcyo2oc7wW2qkc/w8fn9eMuABrEXfLWGecfhZUuE/rGvA=
X-Google-Smtp-Source: AGHT+IEkxJTO8iCzbIZEchqIyE3+n1Dd+QT4XVZbNojDBayWqwn/9htaksCDRHYNeGjwYeuA80nwxw==
X-Received: by 2002:a17:902:fc50:b0:20d:27fa:1911 with SMTP id d9443c01a7336-20d27fa192cmr70358385ad.8.1729110872879;
        Wed, 16 Oct 2024 13:34:32 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f87cf1sm32821635ad.3.2024.10.16.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:32 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 08/12] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Wed, 16 Oct 2024 13:34:18 -0700
Message-ID: <20241016203422.1071021-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/Makefile   |  2 +-
 tools/testing/selftests/net/ncdevmem.c | 57 +++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 26a4883a65c9..759b1d2dc8b4 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -111,7 +111,7 @@ TEST_INCLUDES := forwarding/lib.sh
 include ../lib.mk
 
 # YNL build
-YNL_GENS := netdev
+YNL_GENS := ethtool netdev
 include ynl.mk
 
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index f67ec0dbaa9b..eb026633fdcf 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -55,10 +55,12 @@
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
@@ -231,10 +233,58 @@ static int reset_flow_steering(void)
 	return 0;
 }
 
+static const char *tcp_data_split_str(int val)
+{
+	switch (val) {
+	case 0:
+		return "off";
+	case 1:
+		return "auto";
+	case 2:
+		return "on";
+	default:
+		return "?";
+	}
+}
+
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
-			   on ? "on" : "off");
+	struct ethtool_rings_get_req *get_req;
+	struct ethtool_rings_get_rsp *get_rsp;
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
+	/* 0 - off, 1 - auto, 2 - on */
+	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	ethtool_rings_set_req_free(req);
+
+	if (ret == 0) {
+		get_req = ethtool_rings_get_req_alloc();
+		ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
+		get_rsp = ethtool_rings_get(ys, get_req);
+		ethtool_rings_get_req_free(get_req);
+		if (get_rsp)
+			fprintf(stderr, "TCP header split: %s\n",
+				tcp_data_split_str(get_rsp->tcp_data_split));
+		ethtool_rings_get_rsp_free(get_rsp);
+	}
+
+	ynl_sock_destroy(ys);
+
+	return ret;
 }
 
 static int configure_rss(void)
@@ -370,6 +420,9 @@ int do_server(struct memory_buffer *mem)
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
+	if (configure_headersplit(1))
+		error(1, 0, "Failed to enable TCP header split\n");
+
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "Failed to configure rss\n");
-- 
2.47.0


