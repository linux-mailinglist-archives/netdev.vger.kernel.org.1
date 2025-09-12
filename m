Return-Path: <netdev+bounces-222699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73760B55737
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875DA1D61823
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9134F48C;
	Fri, 12 Sep 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpwGrJZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCD34A30D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706852; cv=none; b=Slyr9yxYiJxIiUi8K0ldRu/3XCd7i4FMtgcTH9amAexZObZDn9dg0h4Kd4QAjsfhvkhovgUVqYZw0aaKOePQHd26x3HPmpDRGUu07afZ7r7StQdFW8XE8oGMeSuITTmTgskNwRub9QQq+9Tnu76r2FBKzcbzmxoj+GqYuR1dbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706852; c=relaxed/simple;
	bh=6L6KchES0/naZZVCLZ0vGuIX8JBrK81BunZ0ve9LFn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZfeI36gz7/c18MpOrGO2M+eplEitFXWFxF9/ddYPa1uXtV/COuckykqQWk7vrbIAW/c2JbfdDrttACqNyZq7lC7LAcdCt8rffnx0cMJ58FKV9mDpTLp0rGNARWORNuK99AqF/zqzB+s89W5xex7ibhKAlsnYxeWGkbxMGkOnk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpwGrJZ9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dfe95bbb7so21613685e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706848; x=1758311648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQCdu2qqA5L2SEaa+R2ExFgFn5V27LFp3SRYw/lxCRA=;
        b=DpwGrJZ9lRzNgNehBz1gj1WOlg93536Y346VoX9xDOHyXNwsFnt5x9LLCzVzuJMwQw
         /G2jnPD0BnRfS6kRayVkBPmr8bxxDp1CsgtDZL2twlqsQXaXQ1O2t8qLvFuVFzVns3Ta
         LzbNHek95TtEf5FriYW+WDxWyUWNwrTTEIu4OHr4o0FWHmMd5naIJbuynX5G6yXbm+uj
         6GQsbRKlc2tKigGMi/Wj9kwgrboFTxmbcqsHJZ0Yr7oX4sdTOxv0o0WeMT4MeZbg329M
         aKaHRYz11XRdUSoPWN5+zTcnGVrwEMZzNpt5xRvFDhsncpfYrOw67D4HLaTio49WG5m2
         9WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706848; x=1758311648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQCdu2qqA5L2SEaa+R2ExFgFn5V27LFp3SRYw/lxCRA=;
        b=q90Nhy13iDLT5c2HllVMFMUvBueq290xem0iE2ED6YQK+DOv1n4qTIJTwhigHy74u1
         fFt/yRMWn9Wh8GHFA8zxpCj6zBKX3ttbnMBa/x4ApKJ2y0e1fGCzbGCmS8zH93z1w2/p
         amG5MVzaggqtRkV/EQpQFxjbfceIATrKh48zgnJ38JXaRhSKihjdCVjTBrH+GxWDFMob
         G3TsmFLU/4pK8VguD2fgNknSOsSQls273+L6bD4n/DY4JVrx8XxyZ2R0mL6Z3SKwodUw
         gKfYJojQVJELKg/KS2/xuBJKq84fMSKanwXlvHgawW+tTweswdTT1KjdO8CKnJRJKe+X
         DyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7nu6AIq1r9m7EF2ADTC/wRlZ/4H1tFQXZnOVf+7pCjWiDiwpiZchyo5ZasnSqZwg/tnJXkHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSDXLIbWyTiJarD66jbOOXd51P3HPmW3xnRUJZIFTA7NhuBVD
	Bu5jmN0r7O63Vw25wiKvTbNF+5oeyuOmyhfKWUGh+cgbjVSD10mUVjcB
X-Gm-Gg: ASbGnctMy7uTdvwUzxJhK9xU+lsIXPRnxm39QB2baSnM4CUP3vW8mtknk9ucjrzJOmV
	uXi2SrM20sgc2J3BdOrz2LgXMsy5SPen2xjvqZCqgH27Y8tp6agf/U9NNmr9AuTRNzoMN7O8GpL
	/QymhaJRrxtiSM3CkaHd5HSgpUKlrUY7tFlGujQeOR+03CTlEggG/LPm3+JJACIKIAdsgRY2sNh
	MSzxSAM21hNOYe55D/Gavreq5kPwg8l1xfnlC9HhHCYrsiBaCTDl3qOZTKPH/m6MmX2UzzRC/HP
	3gE7Hn0aWc67J4mgUDk2XgMQ54CgDq9/y7Z1Qh4dWWTwiUtYJ2sNGt6iCjZYhYCuV+vgsNL6AA4
	ppYkE364+49KJIk9d8P4MQG6G8T42RQsw6RORAFKUfHpq6U69HK8F9vzJdomp7A==
X-Google-Smtp-Source: AGHT+IG7/dc62nnEkODKkDFjpjftdI9gNf5NvEVk1eA/5v9zXXjcbJVj1cg1bibwNEL1hSD/5mJ+wA==
X-Received: by 2002:a05:600c:4748:b0:45b:98d4:5eb7 with SMTP id 5b1f17b1804b1-45f211f8799mr46842565e9.18.1757706848078;
        Fri, 12 Sep 2025 12:54:08 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:07 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 11/15] selftests: net: genetlink: add /proc/net/netlink test
Date: Fri, 12 Sep 2025 22:53:34 +0300
Message-Id: <20250912195339.20635-12-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case to verify proper handling of Netlink sockets in procfs:

- Tests /proc/net/netlink file accessibility
- Validates socket count changes on creation/deletion
- Uses kernel's netlink_seq_ops mechanism

Checks that socket entries are correctly added/removed from procfs.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index 5be9ca68accd..f8231a302c36 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -81,6 +81,25 @@
 
 #define LARGE_GENL_FAMILY_NAME "LARGE_GENL"
 
+struct nl_sock *socket_alloc_and_conn(void)
+{
+	struct nl_sock *socket;
+
+	socket = nl_socket_alloc();
+	if (!socket) {
+		fprintf(stderr, "Failed to allocate socket\n");
+		return NULL;
+	}
+
+	if (genl_connect(socket)) {
+		fprintf(stderr,
+			"Failed to connect to generic netlink through socket\n");
+		nl_socket_free(socket);
+		return NULL;
+	}
+	return socket;
+}
+
 /*
  * Test cases
  */
@@ -143,6 +162,61 @@ TEST(capture_start)
 	printf("Starting Netlink tests...\n");
 }
 
+/**
+ * TEST(open_netlink_file) - Verifies correct reading of Netlink socket information
+ *
+ * Tests the /proc/net/netlink interface by:
+ * 1. Creating a test Netlink socket
+ * 2. Reading the proc file before and after socket creation
+ * 3. Verifying the socket count changes as expected
+ *
+ * The test checks that:
+ * - /proc/net/netlink is accessible
+ * - Entries are properly added/removed
+ * - Uses kernel's netlink_seq_ops mechanism
+ */
+
+TEST(open_netlink_file)
+{
+	FILE *file;
+	char line[256];
+	int cnt = 0;
+
+	printf("Running Test: opening and reading /proc/net/netlink file...\n");
+
+	struct nl_sock *sock;
+
+	sock = socket_alloc_and_conn();
+
+	file = fopen("/proc/net/netlink", "r");
+	ASSERT_NE(NULL, file);
+	if (file == NULL) {
+		perror("fopen");
+		return;
+	}
+
+	while (fgets(line, sizeof(line), file) != NULL)
+		cnt++;
+
+	nl_socket_free(sock);
+
+	fclose(file);
+
+	file = fopen("/proc/net/netlink", "r");
+	ASSERT_NE(NULL, file);
+	if (file == NULL) {
+		perror("fopen");
+		return;
+	}
+
+	while (fgets(line, sizeof(line), file) != NULL)
+		cnt--;
+
+	EXPECT_EQ(cnt, 1);
+
+	fclose(file);
+}
+
 /**
  * TEST(capture_end) - Terminates Netlink traffic monitoring session
  *
-- 
2.34.1


