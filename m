Return-Path: <netdev+bounces-221354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB3B503F6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7604C1894C46
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BAA31691F;
	Tue,  9 Sep 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ZH8XAOdE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E693168FC
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437245; cv=none; b=tz9FhrFFX3vXN1l1rpfu8vGBAv1YY4ro9s5JZrEFZ9DiM+d//OTCyz/fOxqJexoBLGE9eEnKLn9Z0r0ZxC6hlBxBTU693sxPdoue12GCaYN8Z7VYnL7jNslvDMrdgmMbsx8vQQZB3oNRmTpv+ZNKH5Xxrvj7Ljepgm2Y1oJ3AMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437245; c=relaxed/simple;
	bh=Lbe38wll4IXyCxzVMiY0dfY2WXOxgVlySCsiLx3zr4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGFjYpqZnXT6Hge4pAU155yPR1JFvB8RWQ1PLrb3BiTj+lQUwiZb/BDzS8QAOMFcR1VmhPe65hr+3beVKyOHQlnCIXqY8eoXBj/RgMX6soIl2xSNI7/biTtVQC/IFxAszK/mfy373dAPsExUYCRA8dB3ndOuYqC6TFmWmUNOH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ZH8XAOdE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7728ec910caso394767b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437243; x=1758042043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJILTcwTj5GLlMxe8k8wUCvHBjY6ncPyFv6CxtbM9mo=;
        b=ZH8XAOdEvvVWII4ufxyz7Hi3Yyl1WUqoS2ydExEr5VNkFXVif/CMd26sevrxfnoxv7
         dOXazu1gYsfW780TvW3gvLYXGYO4vk4m2ml9zJX3eBtQ8LNd8uQqLPMaLy5DWZIRoD95
         fIgmtAWIYXbcnsKZy2Bl74uIx1hFVOE/i96G49rpc23+4SDS30HAUlCj5es3AvVPn/mX
         +hvQ1L9wHoKDcs7xIdOTo4yzoP6RUBGs8qgn7iWew/VtL2LzZhKGYyXYaI1BoU+DNBbV
         LgSdsA4CPWml++VdmM4EbahaCGjff3wsiJqFMU/uPG7RA3AdtOMiXMdk1KdFjcwlWV92
         WPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437243; x=1758042043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJILTcwTj5GLlMxe8k8wUCvHBjY6ncPyFv6CxtbM9mo=;
        b=ZNEucihmMbZjqRsNm9LgmHztzMDeT/BNtzfJHO7gItyEAm/hhNje230RxnSYLrcO9F
         x/NnEvwHPwWh30qUhuT7WGl3Kr9mKR3Mm6roi5glQozI4AJCeWluJjOR5STIfhm8Cxoz
         UBh5nnAF2DXIMrrF23QKfyG4tLGz9rJTjejWzF+NPuNjliESYQHeIU9CwRU4inXA+pVs
         FZvcZe7ZWf27VCf/raMnVrOZOi7O2lwrP82dCLrvcm4n3mDDnM0AIOi+mCLPXzukWGhJ
         pEywMTEV4tdZXc9lCiSaMyjWJenINOe/RTQhM/mQGy3pK5ghSDNdkLVSfuAYsP0XZXc+
         7Klg==
X-Forwarded-Encrypted: i=1; AJvYcCXGZ9aQoSVSbDc6MnHfxMapUJva1PsgPnQQbhe5BwPQjY4i3UukJJ9F7VBfpPjBcemOsL557vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu176oR6TE44TDIR638wY8MInWfMQ8JouOsF+Hr9suDuLbNDeE
	0OoGS51MPWGefF7Bm+ATWg1SEVJsQU4FPJkcFiwxGKiqiMxM+MEemVqRlYau5BhqAvk=
X-Gm-Gg: ASbGncuI84C/MX/kHD1+5aDmXkUoKSJPfyE/21QIMW8qfsxXGk0q4mMwrKigHaY/DSb
	fSP4HqgASUFPD5VZfj09aY593ec8HreVNt8zO+RYRHMaO0w7ICa4Hn0fs7BwAUAylO/ahNqIjvk
	0hO0lXRo58r7wKsITkhRbBB2loXxpDY4KJsogdGqkvrK6Q3ZwL+Hf1jp9MvT/s5L5WMn3lO83FQ
	MBpr63hJZOxzDtUpypRXlISAGJ9UGBXRsbi2qVUYZtsR1dePQpnVyP4vcx1pU6cogNZWRPN69vY
	iBXdE7vSENaULl+DpyR3U+BBTTOxBo2ZnhHlwGAf/diogR1Rdtf0OV813ZVk4yLLBeorfFmgEe5
	5zxLIJa/MGygsDaxRd6/npaX/
X-Google-Smtp-Source: AGHT+IGE5JJFfpN2wchcA+CrDTZuQyNgLgrjcdiM3hi/WufD9Wlys/JexGNpiP5WlAQo9pznIPoMKA==
X-Received: by 2002:a05:6a20:6a29:b0:24c:e3da:1a89 with SMTP id adf61e73a8af0-253466eb59dmr9762776637.8.1757437243112;
        Tue, 09 Sep 2025 10:00:43 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:42 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 13/14] selftests/bpf: Extend insert and destroy tests for UDP sockets
Date: Tue,  9 Sep 2025 10:00:07 -0700
Message-ID: <20250909170011.239356-14-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise BPF_SOCK_OPS_UDP_CONNECTED_CB by extending the socket map
insert and destroy tests.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 110 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_update.c |   1 +
 2 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 00afa377cf7d..7506de15611e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -440,10 +440,13 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	__u32 key_prefix = htonl((__u32)port0);
 	int accept_serv[4] = {-1, -1, -1, -1};
 	int tcp_clien[4] = {-1, -1, -1, -1};
+	int udp_clien[4] = {-1, -1, -1, -1};
 	union bpf_iter_link_info linfo = {};
 	int tcp_serv[4] = {-1, -1, -1, -1};
+	int udp_serv[4] = {-1, -1, -1, -1};
 	struct nstoken *nstoken = NULL;
 	int tcp_clien_cookies[4] = {};
+	int udp_clien_cookies[4] = {};
 	struct bpf_link *link = NULL;
 	char buf[64];
 	int len;
@@ -494,6 +497,22 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	if (!ASSERT_OK_FD(tcp_serv[3], "start_server"))
 		goto cleanup;
 
+	udp_serv[0] = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", port0, 0);
+	if (!ASSERT_OK_FD(udp_serv[0], "start_server"))
+		goto cleanup;
+
+	udp_serv[1] = start_server(AF_INET6, SOCK_DGRAM, "::1", port0, 0);
+	if (!ASSERT_OK_FD(udp_serv[1], "start_server"))
+		goto cleanup;
+
+	udp_serv[2] = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", port1, 0);
+	if (!ASSERT_OK_FD(udp_serv[2], "start_server"))
+		goto cleanup;
+
+	udp_serv[3] = start_server(AF_INET6, SOCK_DGRAM, "::1", port1, 0);
+	if (!ASSERT_OK_FD(udp_serv[3], "start_server"))
+		goto cleanup;
+
 	for (i = 0; i < ARRAY_SIZE(tcp_serv); i++) {
 		tcp_clien[i] = connect_to_fd(tcp_serv[i], 0);
 		if (!ASSERT_OK_FD(tcp_clien[i], "connect_to_fd"))
@@ -504,11 +523,21 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 			goto cleanup;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(udp_serv); i++) {
+		udp_clien[i] = connect_to_fd(udp_serv[i], 0);
+		if (!ASSERT_OK_FD(udp_clien[i], "connect_to_fd"))
+			goto cleanup;
+	}
+
 	/* Ensure that sockets are connected. */
 	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++)
 		if (!ASSERT_EQ(send(tcp_clien[i], "a", 1, 0), 1, "send"))
 			goto cleanup;
 
+	for (i = 0; i < ARRAY_SIZE(udp_clien); i++)
+		if (!ASSERT_EQ(send(udp_clien[i], "a", 1, 0), 1, "send"))
+			goto cleanup;
+
 	/* Ensure that client sockets exist in the map and the hash. */
 	if (!ASSERT_EQ(update_skel->bss->count,
 		       ARRAY_SIZE(tcp_clien) + ARRAY_SIZE(udp_clien),
@@ -518,6 +547,9 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++)
 		tcp_clien_cookies[i] = socket_cookie(tcp_clien[i]);
 
+	for (i = 0; i < ARRAY_SIZE(udp_clien); i++)
+		udp_clien_cookies[i] = socket_cookie(udp_clien[i]);
+
 	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++) {
 		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
 					    tcp_clien_cookies[i],
@@ -532,6 +564,20 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 			goto cleanup;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(udp_clien); i++) {
+		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+					    udp_clien_cookies[i],
+					    sizeof(__u32)),
+				 "has_socket"))
+			goto cleanup;
+
+		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+					    udp_clien_cookies[i],
+					    sizeof(struct sock_hash_key)),
+				 "has_socket"))
+			goto cleanup;
+	}
+
 	/* Destroy sockets connected to port0. */
 	linfo.map.map_fd = bpf_map__fd(update_skel->maps.sock_hash);
 	linfo.map.sock_hash.key_prefix = (__u64)(void *)&key_prefix;
@@ -568,9 +614,23 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	if (!ASSERT_EQ(send(tcp_clien[3], "a", 1, 0), 1, "send"))
 		goto cleanup;
 
+	if (!ASSERT_LT(send(udp_clien[0], "a", 1, 0), 0, "send"))
+		goto cleanup;
+
+	if (!ASSERT_LT(send(udp_clien[1], "a", 1, 0), 0, "send"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(send(udp_clien[2], "a", 1, 0), 1, "send"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(send(udp_clien[3], "a", 1, 0), 1, "send"))
+		goto cleanup;
+
 	/* Close and ensure that sockets are removed from maps. */
 	close(tcp_clien[0]);
 	close(tcp_clien[1]);
+	close(udp_clien[0]);
+	close(udp_clien[1]);
 
 	/* Ensure that the sockets connected to port0 were removed from the
 	 * maps.
@@ -622,10 +682,60 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 				    sizeof(struct sock_hash_key)),
 			 "has_socket"))
 		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_map,
+				     udp_clien_cookies[0],
+				     sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_map,
+				     udp_clien_cookies[1],
+				     sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+				    udp_clien_cookies[2],
+				    sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+				    udp_clien_cookies[3],
+				    sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_hash,
+				     udp_clien_cookies[0],
+				     sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_hash,
+				     udp_clien_cookies[1],
+				     sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+				    udp_clien_cookies[2],
+				    sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+				    udp_clien_cookies[3],
+				    sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
 cleanup:
 	close_fds(accept_serv, ARRAY_SIZE(accept_serv));
 	close_fds(tcp_clien, ARRAY_SIZE(tcp_clien));
+	close_fds(udp_clien, ARRAY_SIZE(udp_clien));
 	close_fds(tcp_serv, ARRAY_SIZE(tcp_serv));
+	close_fds(udp_serv, ARRAY_SIZE(udp_serv));
 	if (prog_fd >= 0)
 		bpf_prog_detach(cg_fd, BPF_CGROUP_SOCK_OPS);
 	if (cg_fd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
index eb84753c6a1a..0d826004d56d 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
@@ -77,6 +77,7 @@ int insert_sock(struct bpf_sock_ops *skops)
 
 	switch (skops->op) {
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+	case BPF_SOCK_OPS_UDP_CONNECTED_CB:
 		bpf_sock_hash_update(skops, &sock_hash, &key, BPF_NOEXIST);
 		bpf_sock_map_update(skops, &sock_map, &count, BPF_NOEXIST);
 		count++;
-- 
2.43.0


