Return-Path: <netdev+bounces-130496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EB98AAF7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367E3B20BA6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832C194096;
	Mon, 30 Sep 2024 17:18:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C61993B6
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716694; cv=none; b=k+0qvOll8DdLX49KBkOFHXQnxk+TFgsCrHiNtaw9FDMJBV5ILZNv0f7DMQ0W59SkiyHWXWyFFZG+6NddANG1+63Oamc7A+w6Izb7/rMnzA94A9opupJecaje5HkaTP5SeIDJ6v8C8/JRXRnnrDxqJuQnog7jtw3UrGtjo/W+oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716694; c=relaxed/simple;
	bh=vMNcy5rp/19kLtTFFRT5e69El7Ugk1upqapaGfCCX64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHZZaPyxdy4T0eXrNJtvMeTfHaykdn8jQ9u3Fs5yJexbN4F31ARb3U3LHgOmAezAj1U8mligE75C3tRBCe7DBkyagh1ef1H8vx6ow4RyYXHCW/WLYBHJxNK9QefRkHzneJybvgaHfffpRSbYuO6X3w86vS+Hnl63xn/pKILff9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e0a060f6e8so3044037a91.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716692; x=1728321492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSSLtD8diYjIU3ryK9k/GhGnK6d7d0bOVmQH4VUjHSQ=;
        b=JNAr8bZe6n7dohr+drx6AjSmzndBkmt4nrMVUZ1IGGhHTBftED2XAQSLiF0i9dXC8x
         yQCD7fRfiPJt6tbA03MHRoYSjv3b9V0lyts5BLmtWy/XarLfpdgdjk/7iVzsTkUjjYPk
         J0Lf4PNzzOowBvVp+WdRWvDzTqdcEpjbRIBlimg4ENwUi3XyDU5SC9ox/r+Bn1EoeVkR
         5bxH6V0C6FrOCPHmsF0G+Wdu5kwQZbLsJBUj6NdakqODjn0XjmS4GkcGshNUczs6zKTQ
         0PWqImrQp6HS80/I2QQUJRKRYLXeWjk60kYsHuhGMweoq+K//RRsF5Gj3DoudjQ4qtU0
         2Gfg==
X-Gm-Message-State: AOJu0YxdfZJFqgoGL8EYuaceEYCvsC0v6p/uqFP7JUtsiQmaZ3vfWQty
	Dyy2dWiIhbc4hCHK2Ca2RZZGRCA5uW91+/hY1dZrWtF86B3m8DX8IxLA
X-Google-Smtp-Source: AGHT+IF6oCENfzoOcXeU15zolTEBlhvagDBqBm1R6ZeDDry2v7S+oqs0hXArDgDmZB8WtnbbB262lw==
X-Received: by 2002:a17:90a:bd85:b0:2da:8c28:6561 with SMTP id 98e67ed59e1d1-2e0b8c4c097mr14004423a91.22.1727716692037;
        Mon, 30 Sep 2024 10:18:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0d4af744bsm7168382a91.23.2024.09.30.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:11 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
Date: Mon, 30 Sep 2024 10:17:52 -0700
Message-ID: <20240930171753.2572922-12-sdf@fomichev.me>
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

This is where all the tests that depend on the HW functionality live in
and this is where the automated test is gonna be added in the next
patch.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/.gitignore        | 1 +
 tools/testing/selftests/drivers/net/hw/Makefile          | 9 +++++++++
 .../testing/selftests/{net => drivers/net/hw}/ncdevmem.c | 0
 tools/testing/selftests/net/.gitignore                   | 1 -
 tools/testing/selftests/net/Makefile                     | 9 ---------
 5 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 rename tools/testing/selftests/{net => drivers/net/hw}/ncdevmem.c (100%)

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
new file mode 100644
index 000000000000..e9fe6ede681a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -0,0 +1 @@
+ncdevmem
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c9f2f48fc30f..7bce46817953 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,4 +26,13 @@ TEST_INCLUDES := \
 	../../../net/forwarding/tc_common.sh \
 	#
 
+# YNL files, must be before "include ..lib.mk"
+EXTRA_CLEAN += $(OUTPUT)/libynl.a $(OUTPUT)/ncdevmem
+YNL_GEN_FILES := ncdevmem
+TEST_GEN_FILES += $(YNL_GEN_FILES)
+
 include ../../../lib.mk
+
+# YNL build
+YNL_GENS := ethtool netdev
+include ../../../net/ynl.mk
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
similarity index 100%
rename from tools/testing/selftests/net/ncdevmem.c
rename to tools/testing/selftests/drivers/net/hw/ncdevmem.c
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1c04c780db66..923bf098e2eb 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,7 +17,6 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
-ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9c970e96ed33..22a5d6a7c3f3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -97,11 +97,6 @@ TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
 
-# YNL files, must be before "include ..lib.mk"
-EXTRA_CLEAN += $(OUTPUT)/libynl.a
-YNL_GEN_FILES := ncdevmem
-TEST_GEN_FILES += $(YNL_GEN_FILES)
-
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
@@ -111,10 +106,6 @@ TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
 
-# YNL build
-YNL_GENS := ethtool netdev
-include ynl.mk
-
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
-- 
2.46.0


