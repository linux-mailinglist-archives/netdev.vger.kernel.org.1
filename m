Return-Path: <netdev+bounces-126066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5996FD5F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9552886C5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE215B57D;
	Fri,  6 Sep 2024 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzjQv+x5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F915B104;
	Fri,  6 Sep 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658222; cv=none; b=KInvABlgcgZpFMUFsk6dwBrmoZMGweIdHwBPPy8lQA/qMlHmJwzq/RmnjiUi65bK/srvR0hBQQKYqGbT7PsIIEGeFroYnGnoeleqqJ2d4Gk4fASz9wOjBzCMtQF0PnGEk4RgC4MbK8wCL7Xc76MOVcYTF8xraKeU5vf7LtYZwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658222; c=relaxed/simple;
	bh=DkDtosDpUP9qC10sQxpAe2JKOgxIX1YdAxvK6AOUDM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTGQxbiNE8y15xRH0bQ9DeryrPT+9DDUMQlv/vz5awObK0jOYwwIVtQZntptrT6xbgI2P34ThP1Ly8yfW6hBWCsGklgmyTaLIXXZaZ84lg4Dlobf5wkYgWTx+TyDSTzY8Ok5R1H43tuYts78Lei7jO3T2op9cR/+LyZdtQKn/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzjQv+x5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2053616fa36so26893135ad.0;
        Fri, 06 Sep 2024 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658220; x=1726263020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSMrmdZdyuZUqEvjpif0S/dw7Gi7efe1pBKKqJKf+wQ=;
        b=LzjQv+x5ND8w9p0k0HslsY20mUTAzvK0QvAtdeOErX1WKTFyodCgsel6HvER40kJPF
         KQEY2K6R3dgsD5vKk113BAj6nhZF3S3sO5r4x6527ArjmL6iEDzEXBbgehG3Bto1ftAH
         LB8L9vpEVAeUn+n7qbfrHxMb5INb96+5ug4NLc+nedzSSn+aGdQGh9/OqzL55Eg+NTCk
         g7hkx+FtfjKqi8J3A+VGWhUdMrjiTJBbDI5tK9eacnH1hXaY2deF5Va6Ej1oC0lX4p/1
         ZMIzpWxiCIoBhYBf924wdAqeR0JQynpjjzvzYycCXmFMOEr4q6GzxNItPcCNI98R/FlS
         UdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658220; x=1726263020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSMrmdZdyuZUqEvjpif0S/dw7Gi7efe1pBKKqJKf+wQ=;
        b=oLu9/WyJFl39dmKT5D/c63RdGc6Ii1ZlwwmvmdqC0PfE15sSTMKGp9I+fyiJiO6N+T
         N4K+x4vFvKa7NZW21hXdWLpO5GnAAq6jriiCZO2ZhApCFrpjY1GQBJRE8ZwYg/PD23Oc
         AeGeiOnAZ77LObkRKKMO1ql6shdcwO41thc0pPKsoNZ16/JOkUPdxTBBilijmlQoYvzm
         W6HkP8qoBBdYi/fRQxl8yIMwY03EzcJXrl64FyKE6dKuftWe/UULDFijtv/DCp4mOnAj
         E+9Cp/jrsFfwIvGkjhJqfPTPcX0cKXfWcVf3+rvwPTcO/fnhwji/HaG/aNWeso/q966i
         qh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0zlVhmwvBOLtOZJKO8I2QXegLbqNGuemjqjATyZql4PJvgiKgyy6RIMxoVdTFapt1Cc/EOvXt483g8vAwHX+RK/X5hsd@vger.kernel.org, AJvYcCXrz9QQfzzLmG6akKApW+KkV6bdMg2AnKrtOYW1xv8AoUEiEoPEtpL0ecIOrSG1IfpCY8RimzOS6cy4sDU=@vger.kernel.org, AJvYcCXx0ba5C0SEi1XHUujWSx3RnFSvxHcaX3KsLtMYuZyfvFDFReH904TeWd3v7KZcw/CWdKRiN3Rd@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSx2ma/+Dy7vbmuhQLrVjnvLKtfXWD3lenCBX2qMi6ZLpG5pd
	CFg97o6QD+/Nfb+HLIxbBWs6CMieHa3jO+67nyeohDE+y1C7/p8A
X-Google-Smtp-Source: AGHT+IHNHK2fwO3i887aEkZiDEJIPOt7RTzBl1gPJt8nik/cMuQj120cJOKWXrEnL+sIzBzwLJU8Dw==
X-Received: by 2002:a17:903:2442:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-2070a82ae4emr7633455ad.60.1725658220146;
        Fri, 06 Sep 2024 14:30:20 -0700 (PDT)
Received: from tahera-OptiPlex-5000.tail3bf47f.ts.net ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67bd1sm47081065ad.247.2024.09.06.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:30:19 -0700 (PDT)
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
Subject: [PATCH v4 4/6] selftest/landlock: Test file_send_sigiotask by sending out-of-bound message
Date: Fri,  6 Sep 2024 15:30:06 -0600
Message-Id: <50daeed4d4f60d71e9564d0f24004a373fc5f7d5.1725657728.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725657727.git.fahimitahera@gmail.com>
References: <cover.1725657727.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a test to verify handling the signal scoping mechanism
in file_send_sigiotask by triggering SIGURG through receiving an
out-of-bound message in UNIX sockets.

Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
---
V4:
* Using pipe instead of Poll for synchronization.
---
 .../selftests/landlock/scoped_signal_test.c   | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index c71fb83b7147..630f3a515731 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -269,4 +269,103 @@ TEST(signal_scoping_threads)
 	EXPECT_EQ(0, close(thread_pipe[1]));
 }
 
+#define SOCKET_PATH "/tmp/unix_sock_test"
+
+const short backlog = 10;
+
+static volatile sig_atomic_t signal_received;
+
+static void handle_sigurg(int sig)
+{
+	if (sig == SIGURG)
+		signal_received = 1;
+	else
+		signal_received = -1;
+}
+
+static int setup_signal_handler(int signal)
+{
+	struct sigaction sa;
+
+	sa.sa_handler = handle_sigurg;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_SIGINFO | SA_RESTART;
+	return sigaction(SIGURG, &sa, NULL);
+}
+
+/*
+ * Sending an out of bound message will trigger the SIGURG signal
+ * through file_send_sigiotask.
+ */
+TEST(test_sigurg_socket)
+{
+	int sock_fd, recv_sock;
+	struct sockaddr_un addr, paddr;
+	socklen_t size;
+	char oob_buf, buffer;
+	int status;
+	int pipe_parent[2], pipe_child[2];
+	pid_t child;
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", SOCKET_PATH);
+	unlink(SOCKET_PATH);
+	size = sizeof(addr);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		oob_buf = '.';
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+
+		sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_NE(-1, sock_fd);
+
+		ASSERT_EQ(1, read(pipe_parent[0], &buffer, 1));
+		ASSERT_EQ(0, connect(sock_fd, &addr, sizeof(addr)));
+
+		ASSERT_EQ(1, read(pipe_parent[0], &buffer, 1));
+		ASSERT_NE(-1, send(sock_fd, &oob_buf, 1, MSG_OOB));
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		EXPECT_EQ(0, close(sock_fd));
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+	ASSERT_EQ(0, close(pipe_parent[0]));
+	ASSERT_EQ(0, close(pipe_child[1]));
+
+	sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_NE(-1, sock_fd);
+	ASSERT_EQ(0, bind(sock_fd, &addr, size));
+	ASSERT_EQ(0, listen(sock_fd, backlog));
+
+	ASSERT_NE(-1, setup_signal_handler(SIGURG));
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	recv_sock = accept(sock_fd, &paddr, &size);
+	ASSERT_NE(-1, recv_sock);
+
+	create_scoped_domain(_metadata, LANDLOCK_SCOPED_SIGNAL);
+
+	ASSERT_NE(-1, fcntl(recv_sock, F_SETOWN, getpid()));
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
+	ASSERT_EQ(1, recv(recv_sock, &oob_buf, 1, MSG_OOB));
+
+	ASSERT_EQ(1, signal_received);
+	EXPECT_EQ(0, close(sock_fd));
+	EXPECT_EQ(0, close(recv_sock));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


