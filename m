Return-Path: <netdev+bounces-207277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F0B06881
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9767A4AEE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 21:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6F273802;
	Tue, 15 Jul 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjOteLk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146972634
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614658; cv=none; b=W/XArxp1dRKUmsXe5Z/KB4jPrzL4eARBmCQTi8A0O9GToSpx1gV94j8iK3vrxzEqY0h8egu6Sp8xlArygn5bADpra7tN/Y0GvH1kQt/OII+s2SxQgZJovl0+IfxHzO1e86M3lUE78ZTPCL8dyTA+gMW/UCxWjtZW0nkyiWk/KwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614658; c=relaxed/simple;
	bh=7D1ahHGaAl/v7MnAd6dMClc0h+Fp8VG1amzlESU5O0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arz1GZjzRet9cmxBU4CThGBBELxtNgygMK3nd6JBJL98MBzJX/NYxcWyyFZzKzOxROImvv53c6ZXewXWPlNrIe+awsWTaVJSNuriaJGMCm6H3fDF0e8yTF6X/aG0RCW+Ej9Lkyz8zjVR/ATotZH7eHdbAWBMMBVARBQ6vuoFlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjOteLk8; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-41b6561d3b7so795912b6e.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752614656; x=1753219456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/tQoEIqJKl/dL9+V9+OzIl4u+yt/F14Qbh9khLLPFo=;
        b=IjOteLk8/qmEiJPouf90dbVj+yio3AngiJ5HF2KfUoQYjNYUjDcLiKLqdxqwF+Sbvo
         SmV2omvoo4UQ7EcI7CgYQYPcE5zS43Tp0QQt4LqhOisJu8YLUqBk3htjQ3ZrNyuRbOnF
         cRx6M7tfw5renf78Rmft2NxjbwMA9JMenkR01w7TGXrv1sAEUhFtmDYJFfzqPC5m4cRF
         jwjZXdS/BkkHTN6w2RBgGfpMZvH5zh/iz/z1QGnrC+1PFXCHycwLAStvZ6WAhVV7o6tO
         uzJR1KLSyvMiVpMdQiFte+f4mTOxcNVNpiQyQj5Bo6pIu+G6kXFzdCyskVqiwmqipcid
         Cp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614656; x=1753219456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/tQoEIqJKl/dL9+V9+OzIl4u+yt/F14Qbh9khLLPFo=;
        b=vTpxJphN3EXDfccJH1gFZ3JebEFWQmgzzCQsPNbVCvhqHQ8lWzgaEfR178ODpMd66W
         N+lnO5jBhHJfjNETlNKBnIUjbj/7yew24WJ/Ff0uYfH/3iaGRL/g5i/VxmEvfWiqkxGJ
         Sq3eNhtlZbde2UP7zok0grJ7k49C6waqFHvZ5hNnfTGLvDHw7RprA7CiJu29b/Phhy28
         Sm359QECOGOuXam1Wz3a1bt/7R35QjJxkw9rCEHsGYcyBEXBgn98Fgoj16tzo5yHIpnV
         gKGehGofhADx1lPpeR9uLdVrp6I+khaYl0kR1LeMEhX1cbZW5zsL80/pZzSm+IQlRXR5
         6MrA==
X-Gm-Message-State: AOJu0YxW7xWkUoaAD7pbgtAs+Bi8O/mQmxpEzpwxggcMiVNejFrzcoBa
	B9hT9zCKwZpFjXz3ABKDfgn5ebN/CfqD6M9GGRq4UCe+qnEfJWmI8GJloDiyXjuR
X-Gm-Gg: ASbGncv/tNJj/0ygpR5x04NPuwJe39zXaXvMT/uDMXSFMV/Kp8iGlupHRIMPOWxTvaS
	hdiSthsdkM4YwaYfmkZcBRd6/aPDKVp/WobbQoi/KBQQCAwmRurqIFnpoqa/peMbz6tWeRroyGT
	QYc08g1EB7IBivzxUZa1qcsT+y/hgmApMgw5p+mmSH8FY4zgikxdI3GKxx/7eMQfXonLy+U7vmF
	7r7fDnyZ66vsHyZzuaVW8BBOWfdyauCok0/CkQNBdkXmn3/SMdNDWZwrOUkSjewjHXea90/xguo
	tjmsQ/2pSkDDb5yKoaaxuHBRZrFkVrhEpUnCLNLd0G5xFPtu+glX0a7uwsGfODgdq+UWRp+7fHn
	zfCz7PrpsRxb5J0n1oQeOHcM=
X-Google-Smtp-Source: AGHT+IH7Lud7U1UhJTVoV1HxLqVKLXo1WL9RmVQRqah7djxBe2n/AbbORnqZ7XSgFF7Wwvi0Fj9hGQ==
X-Received: by 2002:a05:6808:508b:b0:40b:1588:e005 with SMTP id 5614622812f47-41d037e362bmr250172b6e.10.1752614655618;
        Tue, 15 Jul 2025 14:24:15 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141c1ac4f9sm2331700b6e.37.2025.07.15.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:24:15 -0700 (PDT)
From: Tianyi Cui <1997cui@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tianyi Cui <1997cui@gmail.com>
Subject: [PATCH net-next] selftests/drivers/net: Support ipv6 for napi_id test
Date: Tue, 15 Jul 2025 14:23:05 -0700
Message-ID: <20250715212349.2308385-1-1997cui@gmail.com>
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
 .../testing/selftests/drivers/net/napi_id.py  |  5 +--
 .../selftests/drivers/net/napi_id_helper.c    | 35 ++++++++++++++-----
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
index 356bac46ba04..4382a99c3756 100755
--- a/tools/testing/selftests/drivers/net/napi_id.py
+++ b/tools/testing/selftests/drivers/net/napi_id.py
@@ -7,10 +7,11 @@ from lib.py import bkg, cmd, rand_port, NetNSEnter
 
 def test_napi_id(cfg) -> None:
     port = rand_port()
-    listen_cmd = f"{cfg.test_dir}/napi_id_helper {cfg.addr_v['4']} {port}"
+    listen_addr = cfg.addr_v['6'] if cfg.addr_v["6"] else cfg.addr_v["4"]
+    listen_cmd = f"{cfg.test_dir}/napi_id_helper {listen_addr} {port}"
 
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


