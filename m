Return-Path: <netdev+bounces-136297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72319A141B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EBBBB22AC2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30D216A31;
	Wed, 16 Oct 2024 20:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE32170C6
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110871; cv=none; b=qQawbyJIXahvMY1vfSGfsaHoMG6RUp25UpoOgyFJMjx/z6/fSGJL37kZ0e30cugZ428bENpCTp+3bCPYb81uAhj0jowdHcptJe2LO0hli+8tz0oI9ltp7dvmzE1lv6iQ6WeNn7+QW8k+mDW397zH+A0ERcXDecuHJpPuBW/Lz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110871; c=relaxed/simple;
	bh=lwqESQV2fJUST91PyZzyLghOYLJcxfZA0CWzS57RkmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r87zVyWO4w3WtFx1X5NY30QeQkxckQnzHNOEH19drUy/89EeCpQnf2RpJjn+wVHVtEXi+6slksQjeqbmEeOOUwrDQMTR7bU+2U/c+YCY7Sd+hhwylM4QtosL5LQeDfJUsmaDSIqAvX+fILkKqDy2VVL1EDcwuitXSKQ33+Ip30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso176184a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110869; x=1729715669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y1YdCETbV69XbZAAKCBaHF7u4puhzxMZDAXlwiruZ8=;
        b=QJiWDzZTfQEjArZDJAdzGYB3u2y8Vl50h6DNpiNGcgBoClPFTgpbW8Zb32+akX5e2C
         xLBSjqL6/KgMwVFWX6dj6vDwKyzzDdl1jcmBNGmhPnCy3yX+mUi1nuIb3wown53z4/gc
         gnKpAUQd9S6OJkWMxqs0iRW4CCeEPkPG/eNOWR3FVXwkpntLmaylzH2pP91MFd9L5jkb
         FVkbJXg1wLBhHT17X3DtxTw3vS/6bHgSBKtv2hrB/gPrCbFvZroy9IG3MdehSXb3Bmvh
         ywL9CN5P/zTVgFNSJCXfBOmiz39UBuKiOLEesCstr2NIIz71qSJBpo0H7wGM06qkub/G
         VLNw==
X-Gm-Message-State: AOJu0YzNHbqpQCL1a/zi5xTlFFHymyprS+fNDcQ/0vPBowJh4iNREBG2
	+eAkqZ6zPHxAOMahW2Z98dOWsey9lHLaYT7IvBoZF+JZBIR8KPutQeBOXgY=
X-Google-Smtp-Source: AGHT+IFyKxKVOmCr1tFaDjVRT1A5aHduVDPCLxoYLRQMGFciyJRYYiU+TujtdWMbzbQ6P1uX2+cKCQ==
X-Received: by 2002:a05:6a21:e94:b0:1d9:1098:fab4 with SMTP id adf61e73a8af0-1d91c636906mr1557978637.5.1729110869236;
        Wed, 16 Oct 2024 13:34:29 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508b1asm3498062b3a.192.2024.10.16.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:28 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 05/12] selftests: ncdevmem: Remove default arguments
Date: Wed, 16 Oct 2024 13:34:15 -0700
Message-ID: <20241016203422.1071021-6-sdf@fomichev.me>
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

To make it clear what's required and what's not. Also, some of the
values don't seem like a good defaults; for example eth1.

Move the invocation comment to the top, add missing -s to the client
and cleanup the client invocation a bit to make more readable.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 61 ++++++++++++++++----------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 2ee7b4eb9f71..776009bf1dbd 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -1,4 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
+ * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
+ *
+ * Usage:
+ *
+ *     On server:
+ *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201
+ *
+ *     On client:
+ *     echo -n "hello\nworld" | nc -s <server IP> 5201 -p 5201
+ *
+ * Test data validation:
+ *
+ *     On server:
+ *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201 -v 7
+ *
+ *     On client:
+ *     yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
+ *             tr \\n \\0 | \
+ *             head -c 5G | \
+ *             nc <server IP> 5201 -p 5201
+ *
+ *
+ * Note this is compatible with regular netcat. i.e. the sender or receiver can
+ * be replaced with regular netcat to test the RX or TX path in isolation.
+ */
 #define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
@@ -42,32 +69,13 @@
 #define MSG_SOCK_DEVMEM 0x2000000
 #endif
 
-/*
- * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
- * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
- *
- * Usage:
- *
- *	On server:
- *	ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5201 -v 7
- *
- *	On client:
- *	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
- *		tr \\n \\0 | \
- *		head -c 5G | \
- *		nc <server IP> 5201 -p 5201
- *
- * Note this is compatible with regular netcat. i.e. the sender or receiver can
- * be replaced with regular netcat to test the RX or TX path in isolation.
- */
-
-static char *server_ip = "192.168.1.4";
+static char *server_ip;
 static char *client_ip;
-static char *port = "5201";
+static char *port;
 static size_t do_validation;
 static int start_queue = 8;
 static int num_queues = 8;
-static char *ifname = "eth1";
+static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
@@ -596,6 +604,15 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
+
+	if (!ifname)
+		error(1, 0, "Missing -f argument\n");
+
 	ifindex = if_nametoindex(ifname);
 
 	for (; optind < argc; optind++)
-- 
2.47.0


