Return-Path: <netdev+bounces-207667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3372DB08239
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 03:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182583A47AA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642E51B4F2C;
	Thu, 17 Jul 2025 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xft+Si1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5502AE96
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 01:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715186; cv=none; b=hGGRn9tuh+X78OIDVP5tjHigpAKwHJiMiZce9cJ19a10CZO76im3GJij8H6qNkVKlKN/mie+3IE0JRreaxBOSlI9bZmMvmcC6Ro478hmIrUj667WuWP+PgA84zqpNJKny7Em7sv1mPI7wSGq0ONGt8pQLWM/n7MGIYQdYxw5GYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715186; c=relaxed/simple;
	bh=k1V2vTZXPTGfpLajyCFbbZLmJzx98KVoJOBwgDWNtjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvjIuURwcUv+lkcY++eyKybafBa2IV/GMqDiU0uL4ZJi+JEptR80IS5PaOzy5AvK/Ix3c6Vm8Yc47+gc4hW+SlSfeJ+VFxlvWt9XCxc8ACWA9h5HUB3O57Kxcm0W+SdRM1ME5jisX9fvOIxyu6mBJ3K5sN8xK8tndWVV9zAuoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xft+Si1O; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2efbbf5a754so343649fac.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 18:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752715183; x=1753319983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bgM6aXCZLWtmJsugUeWeDy9+2oMLPqXSBhEbcsi1F5c=;
        b=Xft+Si1OOX5hO//41ATimTP02tEdrl9LL4Og/IYUtwr6gJQPL+7noOvT9r+pa0w8LK
         b0isnhrfno0zwALJQX/2wHrtwoWiCYDqQvvcsjmIymwhRcbKbLp8qiguqL5lvkTZ6Xfw
         xk8mwYkLVEHTyOOQfNEtC2lH7gzDj3C3Cz/6ZWLYuqLg7JPzZzfbJVoetnQcaWeoJ8XS
         qG2QLzT2EZIGCMpaUc2ojgpq2tZ33X9U0+mBgL8AdhKnGZJmGJ1hoZ1ZFSeiEnToSxOG
         7Qhd+3jCg/m+v04sDXPdx6N3kyjp7sQkK5HVRKL31LLJvUnEJHu9gyjwzXSmLjrUKGHg
         Df5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752715183; x=1753319983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgM6aXCZLWtmJsugUeWeDy9+2oMLPqXSBhEbcsi1F5c=;
        b=hEkmotpLX0/Rt7RuCixSVOCNsdmfjJDHXWPhrn2usPRbLyl2HXYBG6MVhqBqf3bTrh
         ySUtg+y1BqIQuE2FYScEnR3aqxiCM+YQFHdP5K41SO240kaaTvnQhFKiq5l3JrnPONV0
         no/lF/EHcdABQKx8P99zXCfyRCez6c3qUkBMBWWymRfbGa4UCkr+Syk6Jx6nljwYzODG
         rv5okhsYRsDbi9m6+6AVXF1q5uu5aEBPoDZ8yTR2efEczr+lVY3Ea/yGZQd760pVvxVj
         azTXCdw3kI7/jclFChv/wN6dNtoDyG07a/3KUMfNQ5x+Ua3EDUE1nX14eSiw4N4kfjgD
         QLaQ==
X-Gm-Message-State: AOJu0YyWkkwKi3H/naMSWUWTl7yUpuwdMyQ2+KEpYpUAx2ksZnBRVQyC
	rOBSdweB2v+0bR1tHXdb3t39yw2VL6Tv3lM5LMufhUhBcL8vilRA/M18ytil0YLK0zM=
X-Gm-Gg: ASbGnctrP9JUDhoywF1pHBAq/4p8AjkfA0uT9lKHeAee45ZXruEHdkxuKPgdodoo0Eo
	K5tT0rydUNravOcpJJ3yJV/PwJZRbAVwppTgJ6U+O5a4GhD6Ob0bvbM3isjYA5wPrLghOq6dAbu
	FbriO5C08OYlsSs5bkxdV4Zl5mluMs2kcv4R5q1BW8mEcAsS3/ie/A4EscVovymm6fQp+VEr8RU
	Cv3ckaBP0tXRoglAmI9gt6lo8mFvV2b2CViGj1188ivxDbqtPm9GBjQPbVJkr2j4KiljCdobb9B
	O+d1RqZpD8BiUa3zQe9Iqipqh78uYPMnMvjG+AntHk9Ge7ubOM4dCdkakit2sMx4vJ7fU7k4nCZ
	mp3JW4XWzXjK2EhS55FXFHORM
X-Google-Smtp-Source: AGHT+IHWncB86dWL7ZsDNuRBKshqNwmDBRZXRwMd1GLyitZETG2zpCwg7RyCB74rdKQa3Ibba2p0sg==
X-Received: by 2002:a05:687c:2c02:b0:2ff:cb8f:2935 with SMTP id 586e51a60fabf-2ffcb8f2f6dmr1311183fac.19.1752715183259;
        Wed, 16 Jul 2025 18:19:43 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30009d55900sm129561fac.28.2025.07.16.18.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:19:42 -0700 (PDT)
From: Tianyi Cui <1997cui@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tianyi Cui <1997cui@gmail.com>
Subject: [PATCH net-next v2] selftests/drivers/net: Support ipv6 for napi_id test
Date: Wed, 16 Jul 2025 18:19:13 -0700
Message-ID: <20250717011913.1248816-1-1997cui@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for IPv6 environment for napi_id test.

Test Plan:

    ./run_kselftest.sh -t drivers/net:napi_id.py
    TAP version 13
    1..1
    # timeout set to 45
    # selftests: drivers/net: napi_id.py
    # TAP version 13
    # 1..1
    # ok 1 napi_id.test_napi_id
    # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
    ok 1 selftests: drivers/net: napi_id.py

Signed-off-by: Tianyi Cui <1997cui@gmail.com>
---
Changelog:
 v2:
   - Use cfg.addr instead of if statement in napi_id.py
 v1: https://lore.kernel.org/all/20250715212349.2308385-1-1997cui@gmail.com/

 .../testing/selftests/drivers/net/napi_id.py  |  4 +--
 .../selftests/drivers/net/napi_id_helper.c    | 35 ++++++++++++++-----
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
index 356bac46ba04..d05eddcad539 100755
--- a/tools/testing/selftests/drivers/net/napi_id.py
+++ b/tools/testing/selftests/drivers/net/napi_id.py
@@ -7,10 +7,10 @@ from lib.py import bkg, cmd, rand_port, NetNSEnter

 def test_napi_id(cfg) -> None:
     port = rand_port()
-    listen_cmd = f"{cfg.test_dir}/napi_id_helper {cfg.addr_v['4']} {port}"
+    listen_cmd = f"{cfg.test_dir}/napi_id_helper {cfg.addr} {port}"

     with bkg(listen_cmd, ksft_wait=3) as server:
-        cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)
+        cmd(f"echo a | socat - TCP:{cfg.baddr}:{port}", host=cfg.remote, shell=True)

     ksft_eq(0, server.ret)

diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
index eecd610c2109..7f49ca6c8637 100644
--- a/tools/testing/selftests/drivers/net/napi_id_helper.c
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -7,41 +7,58 @@
 #include <unistd.h>
 #include <arpa/inet.h>
 #include <sys/socket.h>
+#include <netdb.h>

 #include "../../net/lib/ksft.h"

 int main(int argc, char *argv[])
 {
-	struct sockaddr_in address;
+	struct sockaddr_storage address;
+	struct addrinfo *result;
+	struct addrinfo hints;
 	unsigned int napi_id;
-	unsigned int port;
+	socklen_t addr_len;
 	socklen_t optlen;
 	char buf[1024];
 	int opt = 1;
+	int family;
 	int server;
 	int client;
 	int ret;

-	server = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family = AF_UNSPEC;
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_flags = AI_PASSIVE;
+
+	ret = getaddrinfo(argv[1], argv[2], &hints, &result);
+	if (ret != 0) {
+		fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(ret));
+		return 1;
+	}
+
+	family = result->ai_family;
+	addr_len = result->ai_addrlen;
+
+	server = socket(family, SOCK_STREAM, IPPROTO_TCP);
 	if (server < 0) {
 		perror("socket creation failed");
+		freeaddrinfo(result);
 		if (errno == EAFNOSUPPORT)
 			return -1;
 		return 1;
 	}

-	port = atoi(argv[2]);
-
 	if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
 		perror("setsockopt");
+		freeaddrinfo(result);
 		return 1;
 	}

-	address.sin_family = AF_INET;
-	inet_pton(AF_INET, argv[1], &address.sin_addr);
-	address.sin_port = htons(port);
+	memcpy(&address, result->ai_addr, result->ai_addrlen);
+	freeaddrinfo(result);

-	if (bind(server, (struct sockaddr *)&address, sizeof(address)) < 0) {
+	if (bind(server, (struct sockaddr *)&address, addr_len) < 0) {
 		perror("bind failed");
 		return 1;
 	}
--
2.47.1

