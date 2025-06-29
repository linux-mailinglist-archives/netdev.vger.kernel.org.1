Return-Path: <netdev+bounces-202303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0558EAED163
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30E4174B32
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB824634F;
	Sun, 29 Jun 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k0tiTdW6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB492459C0
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233526; cv=none; b=UX4dFiy+0cQJFyc1gzQZ3hCLt+weLl8DY4OiofUbnby7HK8ccqyDxO4cloq/vzBSIhacBqVstRy0UnH/I8yyScpWzYQamG6gZEdtvkVJ6hQ+00hMrN0rDcAdySf3MZhMjOROL1dBddEU2LqV8ITMOIEV/Hj7iwk50aHYR9akD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233526; c=relaxed/simple;
	bh=G/61B5x6m5HWYLNss1aWHcp1JZl7vwCXB6QgizYMTKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Urqs/nVUJrU2UJFe74MWuPSIy2RzthGg1BI2cVbsdADog6556tlVFaqmjtobDZ1P3sVBgUWYp/eNWwTSAWwYXvVShtW9vwZN2mSc/9AkLo9PdlyUIHxEPA72FaTPe6xE/y7/u4S+TXYwdVz7isuNuVKpCaYE6nAaxO58g8fqZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k0tiTdW6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 22C603F950
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233522;
	bh=/1BBk1xnWMXbQKeMLQK9jlxe2oTJlnw7Zx+SrOAU8+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=k0tiTdW6O+P8V+4vzk74Hv0jeS19alooPRtp5mbz6peOHb5sZwrIV6NwDzxIRUQ6k
	 gjBLOni/oj1QIBtXhfED6wGW6YlzQB5lgXewvODN8Zx++TWs5T3vqrlpnKNGzgUWT5
	 LyuYtHyJonobqPzniRq+4unJeXVWNigBsnOGTT/p1a4ALhRT9Itek83tfaU1Foh6Zt
	 C8T0/AJHydX0uzFhF485setl06Npqu7YQbICwd6Md04y9r/rumPtyH5wlisbN9sA38
	 3dQM5rQwrfb6v2CXwmhNGtcz28y6oNef0/kQjajmLC6vfdP+re4olCYWycCtAGLdsk
	 UCj/bCZfpj7cg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-607c91a207dso1488866a12.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233517; x=1751838317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1BBk1xnWMXbQKeMLQK9jlxe2oTJlnw7Zx+SrOAU8+o=;
        b=Fv+PF68cx4YwmslpY1jYeoxM4D/O6vnjMEwZ2Ta2y9AXZGJoZkjU1cm2rE4gh1+has
         mcSHMTTD7EkAJ4Lp6iQgJvTm8nEqdxvvTc9UnSOOfYNfLsQlG5vOQlvy0NTbxC+bjUPd
         wBkVjnoVzscSbUlRmu61ZH2Yih56fwawHCNmwjFcja6KscoWVq6whg1R4xUVAPqQGb2y
         WG6XUvy+vE2q5W/GRitLt/VU4OudMBYKb2aKKP8JJjxi4q8RLPFQLHJ6UIL19zamHAcn
         Bfc86Qtl3z6FAtDEe/SIw14ZqYT7ZGTiL4PMXCoVOgLYQNQzr7BiIjOqVQptRzoZAuUx
         DJqw==
X-Forwarded-Encrypted: i=1; AJvYcCXuT7u/gfbWjX9wl86w8AC2kdruINltHkUZPMwtw93pPOghWUjPi6+SXMJ8AoMpw0b4WngCvUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89W0eBx2Us4/Oi0CFEQItoz5oO2fhoPsfFDQzJIVemsjHSBzu
	aw493qOB/L0sUUAhuttwsfl7RVNE1b1egB/6Ql+RjXlPuUtGREl/GYh+vLQfhi5cLOix6kKefNk
	rKRU7wqjST90FKL1N9zRbb/eiHiF1LFweS4Kpc60hni5FQQPfuHZlf3LmAA+Wr4lLgdcR6W4HQA
	==
X-Gm-Gg: ASbGncvlpoKve5Zuf7NdycUElOmmCWR31BJBZa1Q4qJtDTvgF827uF24VGodZMNVnYZ
	2LGxWBozYUO2MJ8MsNhqthBp89VWsjFVsZWJwBWXR9YxxBZ2oiCmVeKkp1/j8kisuAPcCBj5skF
	Kqn3xEijn1bqojPj5CzLy4yLsRJj0cbwGTEbjygz57gXwbw6sm/k5XyDONZqeTiBcq2+ZMh9EbT
	XYjhaVGx3fc0n21lq5XTcJ+udQK5tjRl+2/8y5m7zxVJP2i1Rbhvmzha+VyTm2Bx9lKPZ6rfvy8
	ZfoW7+1wQWlvgQPehBSIQgaZea/oziSFbciyMr0Fc8Sox+jftg==
X-Received: by 2002:a05:6402:254b:b0:5fd:1c90:e5cd with SMTP id 4fb4d7f45d1cf-60c88dd96b1mr9221544a12.20.1751233517189;
        Sun, 29 Jun 2025 14:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8jizv2tS0inqrEmzuPiGpHZgTWGHT7Ac+lf6PwaXUePpN1H8DVPNfjkvYGk+DrsJzND/r4Q==
X-Received: by 2002:a05:6402:254b:b0:5fd:1c90:e5cd with SMTP id 4fb4d7f45d1cf-60c88dd96b1mr9221537a12.20.1751233516749;
        Sun, 29 Jun 2025 14:45:16 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm4712037a12.19.2025.06.29.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:45:15 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [RESEND PATCH net-next 6/6] selftests: net: extend SCM_PIDFD test to cover stale pidfds
Date: Sun, 29 Jun 2025 23:44:43 +0200
Message-ID: <20250629214449.14462-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend SCM_PIDFD test scenarios to also cover dead task's
pidfd retrieval and reading its exit info.

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
 1 file changed, 173 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index 7e534594167e..37e034874034 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include "../../pidfd/pidfd.h"
 #include "../../kselftest_harness.h"
 
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
@@ -26,6 +27,8 @@
 #define SCM_PIDFD 0x04
 #endif
 
+#define CHILD_EXIT_CODE_OK 123
+
 static void child_die()
 {
 	exit(1);
@@ -126,16 +129,65 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
 	return result;
 }
 
+struct cmsg_data {
+	struct ucred *ucred;
+	int *pidfd;
+};
+
+static int parse_cmsg(struct msghdr *msg, struct cmsg_data *res)
+{
+	struct cmsghdr *cmsg;
+	int data = 0;
+
+	if (msg->msg_flags & (MSG_TRUNC | MSG_CTRUNC)) {
+		log_err("recvmsg: truncated");
+		return 1;
+	}
+
+	for (cmsg = CMSG_FIRSTHDR(msg); cmsg != NULL;
+	     cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_PIDFD) {
+			if (cmsg->cmsg_len < sizeof(*res->pidfd)) {
+				log_err("CMSG parse: SCM_PIDFD wrong len");
+				return 1;
+			}
+
+			res->pidfd = (void *)CMSG_DATA(cmsg);
+		}
+
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_CREDENTIALS) {
+			if (cmsg->cmsg_len < sizeof(*res->ucred)) {
+				log_err("CMSG parse: SCM_CREDENTIALS wrong len");
+				return 1;
+			}
+
+			res->ucred = (void *)CMSG_DATA(cmsg);
+		}
+	}
+
+	if (!res->pidfd) {
+		log_err("CMSG parse: SCM_PIDFD not found");
+		return 1;
+	}
+
+	if (!res->ucred) {
+		log_err("CMSG parse: SCM_CREDENTIALS not found");
+		return 1;
+	}
+
+	return 0;
+}
+
 static int cmsg_check(int fd)
 {
 	struct msghdr msg = { 0 };
-	struct cmsghdr *cmsg;
+	struct cmsg_data res;
 	struct iovec iov;
-	struct ucred *ucred = NULL;
 	int data = 0;
 	char control[CMSG_SPACE(sizeof(struct ucred)) +
 		     CMSG_SPACE(sizeof(int))] = { 0 };
-	int *pidfd = NULL;
 	pid_t parent_pid;
 	int err;
 
@@ -158,53 +210,99 @@ static int cmsg_check(int fd)
 		return 1;
 	}
 
-	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
-	     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
-		if (cmsg->cmsg_level == SOL_SOCKET &&
-		    cmsg->cmsg_type == SCM_PIDFD) {
-			if (cmsg->cmsg_len < sizeof(*pidfd)) {
-				log_err("CMSG parse: SCM_PIDFD wrong len");
-				return 1;
-			}
+	/* send(pfd, "x", sizeof(char), 0) */
+	if (data != 'x') {
+		log_err("recvmsg: data corruption");
+		return 1;
+	}
 
-			pidfd = (void *)CMSG_DATA(cmsg);
-		}
+	if (parse_cmsg(&msg, &res)) {
+		log_err("CMSG parse: parse_cmsg() failed");
+		return 1;
+	}
 
-		if (cmsg->cmsg_level == SOL_SOCKET &&
-		    cmsg->cmsg_type == SCM_CREDENTIALS) {
-			if (cmsg->cmsg_len < sizeof(*ucred)) {
-				log_err("CMSG parse: SCM_CREDENTIALS wrong len");
-				return 1;
-			}
+	/* pidfd from SCM_PIDFD should point to the parent process PID */
+	parent_pid =
+		get_pid_from_fdinfo_file(*res.pidfd, "Pid:", sizeof("Pid:") - 1);
+	if (parent_pid != getppid()) {
+		log_err("wrong SCM_PIDFD %d != %d", parent_pid, getppid());
+		close(*res.pidfd);
+		return 1;
+	}
 
-			ucred = (void *)CMSG_DATA(cmsg);
-		}
+	close(*res.pidfd);
+	return 0;
+}
+
+static int cmsg_check_dead(int fd, int expected_pid)
+{
+	int err;
+	struct msghdr msg = { 0 };
+	struct cmsg_data res;
+	struct iovec iov;
+	int data = 0;
+	char control[CMSG_SPACE(sizeof(struct ucred)) +
+		     CMSG_SPACE(sizeof(int))] = { 0 };
+	pid_t client_pid;
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_EXIT,
+	};
+
+	iov.iov_base = &data;
+	iov.iov_len = sizeof(data);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	err = recvmsg(fd, &msg, 0);
+	if (err < 0) {
+		log_err("recvmsg");
+		return 1;
 	}
 
-	/* send(pfd, "x", sizeof(char), 0) */
-	if (data != 'x') {
+	if (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC)) {
+		log_err("recvmsg: truncated");
+		return 1;
+	}
+
+	/* send(cfd, "y", sizeof(char), 0) */
+	if (data != 'y') {
 		log_err("recvmsg: data corruption");
 		return 1;
 	}
 
-	if (!pidfd) {
-		log_err("CMSG parse: SCM_PIDFD not found");
+	if (parse_cmsg(&msg, &res)) {
+		log_err("CMSG parse: parse_cmsg() failed");
 		return 1;
 	}
 
-	if (!ucred) {
-		log_err("CMSG parse: SCM_CREDENTIALS not found");
+	/*
+	 * pidfd from SCM_PIDFD should point to the client_pid.
+	 * Let's read exit information and check if it's what
+	 * we expect to see.
+	 */
+	if (ioctl(*res.pidfd, PIDFD_GET_INFO, &info)) {
+		log_err("%s: ioctl(PIDFD_GET_INFO) failed", __func__);
+		close(*res.pidfd);
 		return 1;
 	}
 
-	/* pidfd from SCM_PIDFD should point to the parent process PID */
-	parent_pid =
-		get_pid_from_fdinfo_file(*pidfd, "Pid:", sizeof("Pid:") - 1);
-	if (parent_pid != getppid()) {
-		log_err("wrong SCM_PIDFD %d != %d", parent_pid, getppid());
+	if (!(info.mask & PIDFD_INFO_EXIT)) {
+		log_err("%s: No exit information from ioctl(PIDFD_GET_INFO)", __func__);
+		close(*res.pidfd);
 		return 1;
 	}
 
+	err = WIFEXITED(info.exit_code) ? WEXITSTATUS(info.exit_code) : 1;
+	if (err != CHILD_EXIT_CODE_OK) {
+		log_err("%s: wrong exit_code %d != %d", __func__, err, CHILD_EXIT_CODE_OK);
+		close(*res.pidfd);
+		return 1;
+	}
+
+	close(*res.pidfd);
 	return 0;
 }
 
@@ -291,6 +389,24 @@ static void fill_sockaddr(struct sock_addr *addr, bool abstract)
 	memcpy(sun_path_buf, addr->sock_name, strlen(addr->sock_name));
 }
 
+static int sk_enable_cred_pass(int sk)
+{
+	int on = 0;
+
+	on = 1;
+	if (setsockopt(sk, SOL_SOCKET, SO_PASSCRED, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSCRED");
+		return 1;
+	}
+
+	if (setsockopt(sk, SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSPIDFD");
+		return 1;
+	}
+
+	return 0;
+}
+
 static void client(FIXTURE_DATA(scm_pidfd) *self,
 		   const FIXTURE_VARIANT(scm_pidfd) *variant)
 {
@@ -299,7 +415,6 @@ static void client(FIXTURE_DATA(scm_pidfd) *self,
 	struct ucred peer_cred;
 	int peer_pidfd;
 	pid_t peer_pid;
-	int on = 0;
 
 	cfd = socket(AF_UNIX, variant->type, 0);
 	if (cfd < 0) {
@@ -322,14 +437,8 @@ static void client(FIXTURE_DATA(scm_pidfd) *self,
 		child_die();
 	}
 
-	on = 1;
-	if (setsockopt(cfd, SOL_SOCKET, SO_PASSCRED, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSCRED");
-		child_die();
-	}
-
-	if (setsockopt(cfd, SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSPIDFD");
+	if (sk_enable_cred_pass(cfd)) {
+		log_err("sk_enable_cred_pass() failed");
 		child_die();
 	}
 
@@ -340,6 +449,12 @@ static void client(FIXTURE_DATA(scm_pidfd) *self,
 		child_die();
 	}
 
+	/* send something to the parent so it can receive SCM_PIDFD too and validate it */
+	if (send(cfd, "y", sizeof(char), 0) == -1) {
+		log_err("Failed to send(cfd, \"y\", sizeof(char), 0)");
+		child_die();
+	}
+
 	/* skip further for SOCK_DGRAM as it's not applicable */
 	if (variant->type == SOCK_DGRAM)
 		return;
@@ -398,7 +513,13 @@ TEST_F(scm_pidfd, test)
 		close(self->server);
 		close(self->startup_pipe[0]);
 		client(self, variant);
-		exit(0);
+
+		/*
+		 * It's a bit unusual, but in case of success we return non-zero
+		 * exit code (CHILD_EXIT_CODE_OK) and then we expect to read it
+		 * from ioctl(PIDFD_GET_INFO) in cmsg_check_dead().
+		 */
+		exit(CHILD_EXIT_CODE_OK);
 	}
 	close(self->startup_pipe[1]);
 
@@ -421,9 +542,17 @@ TEST_F(scm_pidfd, test)
 		ASSERT_NE(-1, err);
 	}
 
-	close(pfd);
 	waitpid(self->client_pid, &child_status, 0);
-	ASSERT_EQ(0, WIFEXITED(child_status) ? WEXITSTATUS(child_status) : 1);
+	/* see comment before exit(CHILD_EXIT_CODE_OK) */
+	ASSERT_EQ(CHILD_EXIT_CODE_OK, WIFEXITED(child_status) ? WEXITSTATUS(child_status) : 1);
+
+	err = sk_enable_cred_pass(pfd);
+	ASSERT_EQ(0, err);
+
+	err = cmsg_check_dead(pfd, self->client_pid);
+	ASSERT_EQ(0, err);
+
+	close(pfd);
 }
 
 TEST_HARNESS_MAIN
-- 
2.43.0


