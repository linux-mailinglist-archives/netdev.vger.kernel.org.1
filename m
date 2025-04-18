Return-Path: <netdev+bounces-184021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71447A92F5F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA702170007
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83521E570A;
	Fri, 18 Apr 2025 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CK2rtsJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FC1DA31D
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940272; cv=none; b=gS/nePm/XCN8ea2S78i7yKRACMcOIN1nTmrT3V30huLLtvipXj96T7mpjTw/JRYihyas4lolShqb8e8pIsyodA6IAR94T9XaSlElqTFbq7cONMgtBmxD77FhLS3IB3ZnDk6xYOuBU8WcLmdkzNkKI4Qb7/0IhdEIK7hHbGIUCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940272; c=relaxed/simple;
	bh=5isKImih2WAb/F2yZrBoG1nc7SxgJF4zQ9WtVoGOqQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu29JzL5U9NbBUjtJmbhf08/BQZcnoJVenXjSlCu/HaPWcAePumCQe0/46cHqG4CpRW+69ijWUjWq8wTSFYoYEYeXtgYMpg5s6clnj0/CNO9N4ISlDX0jUSLYb/U2bp6oxjSV5lDTfKoKjpmRuQ+Ag48iFmrCrKtM7AUKx+sKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CK2rtsJw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-303a66af07eso1130454a91.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744940270; x=1745545070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsW2tptfFjso20mcti4Mqp8BKgow+rWkfzTJM2yOxR4=;
        b=CK2rtsJwSQOW3WZE+jQPK5kxSCjeRb2OZeXEEh0r4xSzkyxRSe8BUdxMq/IGiTxTFO
         nJvWprk2b9Rxh5fayTx0liCUk7zfBLCsXAV5ozgpyb+f7ho68P0iEaewUVvIq9Kbk/Ad
         cjdQKseWY2NWldC0RueXcMrydXgvO8P95ZBew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940270; x=1745545070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsW2tptfFjso20mcti4Mqp8BKgow+rWkfzTJM2yOxR4=;
        b=grC5fGsu+Jd0suxxdX5sR0P/jEBcIvsNyF/BFEjpLZyBGZTVVnYva0xSh7EEsIEDSH
         1i8/axL3gocQKMJ+QPYCcmRZpc9rySY3WRk57kjX/D4U4gZyBXGZMHau+gcegAiMDNdw
         mh1NBbm8AkyWh+JSGkyKQzbG3eZsZeL0IV0K1xxkOy5rb419WTABArxsTBpj2UYKbU/Z
         Wwdpye5EM/dxC3j8ajUgZP4lhMwLj+sl5HTMCPFWx08eJ0GIRvH4GzvV7/Sj/+goODe5
         k4frsek/QSsZAyrWNM7p20CydZGMSBvYM/zXPzkZxIky3wyguEdnJzMC1yaWTYw5P7h+
         Y8sQ==
X-Gm-Message-State: AOJu0Yw2Ps7wkBL7Ree1V//3QO3v31N5e6ZwIry36D6HOZW33rBoAZe1
	SGmQEH7vCrxWnhQ/ScxJyPCChS3VQiUTXYhE1X3OmUNclGp40mukiOxltOP2CFAxXyMPZVSn8xM
	UQZRvR/cZuFS5GyU83nPgo+8yEhqF20n3SJc1y1UsSQuvsMK4119mJhKcS1lF4/sI+OzMsJI8AV
	KsIOk0hHn28NiFOu8MA1B1N60M5y4WTtG2XHI=
X-Gm-Gg: ASbGnct6AMIG70Gk3udRVg1/L9AxGykFDs7Nn4yD5PigUg+zzCTCasf2qUFuaCI18Mo
	0olJYEXaIIi0nYwoPMmA6piCKudAZ03u5HQjbSRlqOOrYAfg+s5KBeKNdoeHVARkf7TB1rkiGLC
	1hlrDSyaDpYTF3Zmlb4LO1x/RzS/qr0RrXnpvmdUd12HTHGZrHcIomD666ToAsPAGo1UQu8c8zB
	RZJJskZxGMJurmvUs5EmghQ3/Q95IFEYZz0wCGJ77+4mEIxmgeZZAza0GZXVGiNzJDTUFm0xird
	39Vp0zJbRr8ECYe2sCAGfmrhfE/6QoJ8eF+WklQISJrUsBxz682kQwZiOB0=
X-Google-Smtp-Source: AGHT+IEBM+dr8qCKWbxlJkdrIj4JsBo+lV0XGAheAzqt3MqfLaRT2FSWdNWTE5tc821wHEYJSxvyZA==
X-Received: by 2002:a17:90b:3b8d:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-3087bbaeb98mr1365692a91.28.1744940270069;
        Thu, 17 Apr 2025 18:37:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df21278sm131772a91.29.2025.04.17.18.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:37:49 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	shaw.leon@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v3 3/3] selftests: drv-net: Test that NAPI ID is non-zero
Date: Fri, 18 Apr 2025 01:37:05 +0000
Message-ID: <20250418013719.12094-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418013719.12094-1-jdamato@fastly.com>
References: <20250418013719.12094-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that the SO_INCOMING_NAPI_ID of a network file descriptor is
non-zero. This ensures that either the core networking stack or, in some
cases like netdevsim, the driver correctly sets the NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 4 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index ec746f374e85..72d2124fd513 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+napi_id_helper
 xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0c95bd944d56..47247c2ef948 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,9 +6,13 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
-TEST_GEN_FILES := xdp_helper
+TEST_GEN_FILES := \
+	napi_id_helper \
+	xdp_helper \
+# end of TEST_GEN_FILES
 
 TEST_PROGS := \
+	napi_id.py \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
new file mode 100755
index 000000000000..54e51633a70a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_id.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, NetDrvEpEnv
+from lib.py import bkg, cmd, rand_port, NetNSEnter
+
+def test_napi_id(cfg) -> None:
+    port = rand_port()
+    bin_remote = cfg.remote.deploy(cfg.test_dir / "napi_id_helper")
+    listen_cmd = f"{bin_remote} {cfg.addr_v['4']} {port}"
+
+    with bkg(listen_cmd, ksft_wait=3) as server:
+        cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)
+
+    ksft_eq(0, server.ret)
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_napi_id], args=(cfg,))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
new file mode 100644
index 000000000000..7e8e7d373b61
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <sys/socket.h>
+
+#include "ksft.h"
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_in address;
+	unsigned int napi_id;
+	unsigned int port;
+	socklen_t optlen;
+	char buf[1024];
+	int opt = 1;
+	int server;
+	int client;
+	int ret;
+
+	server = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (server < 0) {
+		perror("socket creation failed");
+		if (errno == EAFNOSUPPORT)
+			return -1;
+		return 1;
+	}
+
+	port = atoi(argv[2]);
+
+	if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
+		perror("setsockopt");
+		return 1;
+	}
+
+	address.sin_family = AF_INET;
+	inet_pton(AF_INET, argv[1], &address.sin_addr);
+	address.sin_port = htons(port);
+
+	if (bind(server, (struct sockaddr *)&address, sizeof(address)) < 0) {
+		perror("bind failed");
+		return 1;
+	}
+
+	if (listen(server, 1) < 0) {
+		perror("listen");
+		return 1;
+	}
+
+	ksft_ready();
+
+	client = accept(server, NULL, 0);
+	if (client < 0) {
+		perror("accept");
+		return 1;
+	}
+
+	optlen = sizeof(napi_id);
+	ret = getsockopt(client, SOL_SOCKET, SO_INCOMING_NAPI_ID, &napi_id,
+			 &optlen);
+	if (ret != 0) {
+		perror("getsockopt");
+		return 1;
+	}
+
+	read(client, buf, 1024);
+
+	ksft_wait();
+
+	if (napi_id == 0) {
+		fprintf(stderr, "napi ID is 0\n");
+		return 1;
+	}
+
+	close(client);
+	close(server);
+
+	return 0;
+}
-- 
2.43.0


