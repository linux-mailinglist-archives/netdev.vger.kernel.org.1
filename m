Return-Path: <netdev+bounces-125316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8AA96CBA3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CBF2882FD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6E17597;
	Thu,  5 Sep 2024 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njilfjm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C59FC0A;
	Thu,  5 Sep 2024 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495269; cv=none; b=p7+7YJxnue3RCcU57OhNEsSMdAd8g9gXI6zsDWM2wLtOCKTHKAMEIgXzSuvCkWifrv3fA8vWB3NLYtpGFvA7MhYHU+c+84r7CDfSnHrsN/mo2MGY9pikoq+Y+J9c9dTogkZTexARJRMJ+4gkOePBFd5p+sd5m3Oyl4APp3jTExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495269; c=relaxed/simple;
	bh=6B5/fbYGXDCmpCB56kmnCm2tByrZA7Zjr7RtQx6ILtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDe0QilRo9CVQAPIPpOeJLheW+EYECo7HbScmbFDPW7pysAKQYNOfSSsmljTQT8VjSgdjRopF0NbLI4I6ysGJdIifpFoH+eTMHqz+6lORFH2kK9YAf2sjSYfRvI04oj2FXOPev260SvCzsUeToBJxr54kIwRztZteJt4kOmNPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njilfjm5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3e1081804so158578a12.3;
        Wed, 04 Sep 2024 17:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725495267; x=1726100067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYo96gfr0shigHW7k7ch8rY/tXVue2H6sZrfJvM5RKk=;
        b=njilfjm5hAFTVPD18G4P1hmD9K7YSNdQgu2FjxRPo5IB1t5S5WVGyCCDgjJKKH2kaS
         GftnZ4XPuYU4tnNFWTc3zgoOTE4ao5D89P0K3I8j9UoNsDOo1FKo2T8duDoekMQ98p0C
         XYgyTs/+wDwOk7BLwHqLHBt/HrzRGRsb8z2oOLVA11FrsQctKlVVEUHTfx7EqW4U/Ajp
         po8/kCCAnkjI5Si2se5wsc95Q0Oi97VL1YwS9ll2Wym4r5qlKfZYLaz90K4goh2ZvTc7
         jxF1hc7c6RuV6CitGBTbP8ivnA4UKJKPnhH0IBF6aGMeAytVa9q/GmFjrh+q2L7X7EeF
         De3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725495267; x=1726100067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYo96gfr0shigHW7k7ch8rY/tXVue2H6sZrfJvM5RKk=;
        b=jrasxdyaOjjToSsieP12+s+rHBXpVV9Ie8ZG3jeKg3m5zO9RlhwCXvlyhjYbEvbQEn
         0AY9mVTHL9DZ/VC+lgexgWT0HiUhLBDHp7BWA91vHfRMN9WADr+3IIQBmj0Uto995Y0u
         B4fb+PYAyjcT5VKxB67oenQDnt10hyxg5rV3g1aooQ821HqpCuTG8gzpJfp/w3velUaQ
         Li7BDNAW1eIfCfljhY9rgrplNceWNCQ/LDz8hdszLZgPp9e38oVoSDpKzmRwEjP2vE9/
         9kTXL/rHZZejMZ8X3nTZmWZL5q7b1AeI/2MeDAF4OH/PYxJCe8Vut027xYjT574qk7h7
         qS4g==
X-Forwarded-Encrypted: i=1; AJvYcCVTxm00Ez2kaE7qCV0qeh3YSDqLa+jypvH3vlchdFAp7dLba57F5bdv30DZzKyqxc7FuQ8jKRIWDZnGSKflk7yRC63lRhTk@vger.kernel.org, AJvYcCVaJlWpcBGh9oTiLyqwzKFCA8cWh/t2S81Rp0gHiCRGVuyEphJwiZRRAjz0na9LzRxyJiV1PGD8@vger.kernel.org, AJvYcCXR5ma/GHcp9Gtc+2m6kBQ9HrF6pBycBWtek/6+ptQp7p8i6jgA3ICW0e/EfVVK4511XREJQcyQGzsIzbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXrFMaGSvP3IoFa8bGf491srykQsQnlBOralTkJlOYhzOphNg
	napbu1jA1FR19SjSzGnGnmzqLYIwYnc3z74imLi2082lxHGLZdx3VelWha0H
X-Google-Smtp-Source: AGHT+IGDPU/BNHAZz0bwWU8S2tHlNB+zCpsSMRBxuqOoSw8vPfK18pVrIafwCMVe5MFMa3TZMSUUkg==
X-Received: by 2002:a05:6a20:43a8:b0:1be:c3c1:7be8 with SMTP id adf61e73a8af0-1cce1015c4dmr23641835637.26.1725495266908;
        Wed, 04 Sep 2024 17:14:26 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778534921sm2159781b3a.76.2024.09.04.17.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 17:14:26 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	netdev@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v11 5/8] selftests/landlock: Test connected vs non-connected datagram UNIX socket
Date: Wed,  4 Sep 2024 18:13:59 -0600
Message-Id: <c28c9cd8feef67dd25e115c401a2389a75f9983b.1725494372.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725494372.git.fahimitahera@gmail.com>
References: <cover.1725494372.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch checks the specific case where a scoped datagram socket is
connected and send(2) works, whereas sendto(2) is denied if the datagram
socket is not connected.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
 .../landlock/scoped_abstract_unix_test.c      | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 8fc47e45d17e..39297ebf7b73 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -819,4 +819,109 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+TEST(datagram_sockets)
+{
+	struct service_fixture connected_addr, non_connected_addr;
+	int conn_sock, non_conn_sock;
+	int pipe_parent[2], pipe_child[2];
+	int status;
+	char buf;
+	pid_t child;
+	int num_bytes;
+	char data[64];
+
+	drop_caps(_metadata);
+	memset(&connected_addr, 0, sizeof(connected_addr));
+	set_unix_address(&connected_addr, 0);
+	memset(&non_connected_addr, 0, sizeof(non_connected_addr));
+	set_unix_address(&non_connected_addr, 1);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_data[64];
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+
+		conn_sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+		non_conn_sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+		ASSERT_NE(-1, conn_sock);
+		ASSERT_NE(-1, non_conn_sock);
+
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		ASSERT_EQ(0, connect(conn_sock, &connected_addr.unix_addr,
+				     connected_addr.unix_addr_len));
+
+		/* Both connected and non-connected sockets can send
+		 * data when the domain is not scoped.
+		 */
+		memset(buf_data, 'x', sizeof(buf_data));
+		ASSERT_NE(-1, send(conn_sock, buf_data, sizeof(buf_data), 0));
+		ASSERT_NE(-1, sendto(non_conn_sock, buf_data, sizeof(buf_data),
+				     0, &non_connected_addr.unix_addr,
+				     non_connected_addr.unix_addr_len));
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		/* Scopes the domain. */
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
+
+		/*
+		 * Connected socket sends data to the receiver, but the
+		 * non-connected socket must fail to send data.
+		 */
+		ASSERT_NE(-1, send(conn_sock, buf_data, sizeof(buf_data), 0));
+		ASSERT_EQ(-1, sendto(non_conn_sock, buf_data, sizeof(buf_data),
+				     0, &non_connected_addr.unix_addr,
+				     non_connected_addr.unix_addr_len));
+		ASSERT_EQ(EPERM, errno);
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		EXPECT_EQ(0, close(conn_sock));
+		EXPECT_EQ(0, close(non_conn_sock));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+	ASSERT_EQ(0, close(pipe_child[1]));
+
+	conn_sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+	non_conn_sock = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_NE(-1, conn_sock);
+	ASSERT_NE(-1, non_conn_sock);
+
+	ASSERT_EQ(0, bind(conn_sock, &connected_addr.unix_addr,
+			  connected_addr.unix_addr_len));
+	ASSERT_EQ(0, bind(non_conn_sock, &non_connected_addr.unix_addr,
+			  non_connected_addr.unix_addr_len));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+	num_bytes = recv(conn_sock, data, sizeof(data) - 1, 0);
+	ASSERT_NE(-1, num_bytes);
+	num_bytes = recv(non_conn_sock, data, sizeof(data) - 1, 0);
+	ASSERT_NE(-1, num_bytes);
+
+	/*
+	 * Connected datagram socket will receive data, but
+	 * non-connected datagram socket does not receive data.
+	 */
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+	num_bytes = recv(conn_sock, data, sizeof(data) - 1, 0);
+	ASSERT_NE(-1, num_bytes);
+
+	EXPECT_EQ(0, close(conn_sock));
+	EXPECT_EQ(0, close(non_conn_sock));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


