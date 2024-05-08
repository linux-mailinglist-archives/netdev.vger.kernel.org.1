Return-Path: <netdev+bounces-94707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B08C0487
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98081C2144F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F853381;
	Wed,  8 May 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DTXdWBnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C721107B6
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193623; cv=none; b=PhIqFieG/EFPJXraWAaQib1eIl2cFnke3HRmhVEhJ4a9UjQgl3JoGidSfMBDfZSyNHRCtlIPJN3JW5QaIzSk8dGbCJYExR/ynDSf60zw9iKS4WMP+Efvy/1M5Vgm5YAfhw8r+ACrKjgsjH7QjTRfaeP6nlPNsSZdLRA5noFtX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193623; c=relaxed/simple;
	bh=cud7NCLbLs0NpQaq1MDx8Z2sap0DQ+bUysuVvQ5I3Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RNAmNn13CYXPUognHWYg93pFVD7E5QMQXi0Mnht0rkdPzP0fFlayQuJn1HT2D1c9prrzGp1zDhXxVS/umTcWVtJkp00c6Pgz9Q7fDH96po6HT/JYIcaISWFSxxs+a5hFiM4FVkD30mU8+ge03AN7Bf7GVC/QjzgAL+HoMNqHUrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DTXdWBnP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f44ed6e82fso108064b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715193620; x=1715798420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeEO1Q8wJpOn7YutMlxicVAzKlqlun27NVu5Gr4Sb/k=;
        b=DTXdWBnPpA4d4O2zMkrHQB4b5F/q+SSE+NEZwi14Vkz+5IBr8ahl6HwUcCB3EsgyKh
         xBORAnVW4R8izeGbDLQPsefL0LhohsQ4D9I+tDgR2l1wzYvHbQQIlkxPGPtBTyoWkSE3
         HFKqQCGAMUYpzTkLSWVzeSvKoC/k5QRn7Olvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715193620; x=1715798420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeEO1Q8wJpOn7YutMlxicVAzKlqlun27NVu5Gr4Sb/k=;
        b=Y7vWnCW4USEI/xWi3WbJ+0Oqa1BVoNnJ3DeGIdvmXxEbSigG1ZqT59a8sBt2Y+QV7q
         6J93KsKr8Mfp7jIciRYdUoz5NGZkJ+k+3sryIQ7WysAu2ARhfjSB8xj9EmuigwoO4u8D
         xUxrSJkvUcHbmwbFb8qgoV5qgkFS+AejsQ9eylhrBKshi7GaYUGzwxqXkqZ/wZ89pTym
         46f4reDwzxdNU5oOtxG6hMUy5+Kgcqx1GdDecL0r2MN7TBKIHpW+o5sxdFx6NG8t3DSr
         +QbZDrHEjKhw6e9PZXp3tx+OvahFozy9Oes6bY2LxpmAYqTnfEXyuCo682IHXqnQoeo9
         Qd8A==
X-Forwarded-Encrypted: i=1; AJvYcCUUq1oMzfa/sC7dQZFGnPzwarOSDZMKh+6ci0Zla7diq4JNHRihOfXpB+r4L/R6g1WRVgw4v34nBnNWX0JefjRcddNtwpAH
X-Gm-Message-State: AOJu0Yw4QBelZNAmVlAfzVE58Dq2iaAQuqWkRq5UZYlLV12w0BwX3LLq
	KarQYCGYR9ePyd7a89lgpAa7A3cFjes5XiUaCQfoMgBxnXkMppXeawpHBRWqIVU=
X-Google-Smtp-Source: AGHT+IEH65mBkaGK3zjRLkbveOpF5uOHYGqMfWJ2weQm+zBhDdq+val0hJykvpF/YI055VANaxKhiA==
X-Received: by 2002:a05:6a20:2d09:b0:1af:9c7a:a16d with SMTP id adf61e73a8af0-1afc8dbdb0fmr3950013637.51.1715193620619;
        Wed, 08 May 2024 11:40:20 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id m185-20020a633fc2000000b006202bc134f3sm8583160pga.77.2024.05.08.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 11:40:20 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH REPOST net-next v3] selftest: epoll_busy_poll: epoll busy poll tests
Date: Wed,  8 May 2024 18:40:04 +0000
Message-Id: <20240508184008.48264-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for the epoll busy poll ioctls, using the kernel
selftest harness.

This test ensures that the ioctls have the expected return codes and
that the kernel properly gets and sets epoll busy poll parameters.

The test can be expanded in the future to do real busy polling (provided
another machine to act as the client is available).

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
v2 -> v3:
  - Added this changelog :)
  - Add libcap to LDLIBS.
  - Most other changes are in test_set_invalid:
    - Check if CAP_NET_ADMIN is set in the effective set before setting
      busy_poll_budget over NAPI_POLL_WEIGHT. The test which follows
      assumes CAP_NET_ADMIN.
    - Drop CAP_NET_ADMIN from effective set in order to ensure the ioctl
      fails when busy_poll_budget exceeds NAPI_POLL_WEIGHT.
    - Put CAP_NET_ADMIN back into the effective set afterwards.
    - Changed self->params.busy_poll_budget from 65535 to UINT16_MAX.
    - Changed the cast for params.busy_poll_usecs from unsigned int to
      uint32_t in the test_set_invalid case.

v1 -> v2:
  - Rewrote completely to use kernel self test harness.

 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   3 +-
 tools/testing/selftests/net/epoll_busy_poll.c | 320 ++++++++++++++++++
 3 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/epoll_busy_poll.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index d996a0ab0765..777cfd027076 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -5,6 +5,7 @@ bind_wildcard
 csum
 cmsg_sender
 diag_uid
+epoll_busy_poll
 fin_ack_lat
 gro
 hwtstamp_config
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5befca249452..c6112d08b233 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -67,7 +67,7 @@ TEST_GEN_FILES += ipsec
 TEST_GEN_FILES += ioam6_parser
 TEST_GEN_FILES += gro
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
-TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap
+TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap epoll_busy_poll
 TEST_GEN_FILES += toeplitz
 TEST_GEN_FILES += cmsg_sender
 TEST_GEN_FILES += stress_reuseport_listen
@@ -102,6 +102,7 @@ TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
 
+$(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
new file mode 100644
index 000000000000..9dd2830fd67c
--- /dev/null
+++ b/tools/testing/selftests/net/epoll_busy_poll.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Basic per-epoll context busy poll test.
+ *
+ * Only tests the ioctls, but should be expanded to test two connected hosts in
+ * the future
+ */
+
+#define _GNU_SOURCE
+
+#include <error.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/capability.h>
+
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+#include "../kselftest_harness.h"
+
+/* if the headers haven't been updated, we need to define some things */
+#if !defined(EPOLL_IOC_TYPE)
+struct epoll_params {
+	uint32_t busy_poll_usecs;
+	uint16_t busy_poll_budget;
+	uint8_t prefer_busy_poll;
+
+	/* pad the struct to a multiple of 64bits */
+	uint8_t __pad;
+};
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+#endif
+
+FIXTURE(invalid_fd)
+{
+	int invalid_fd;
+	struct epoll_params params;
+};
+
+FIXTURE_SETUP(invalid_fd)
+{
+	int ret;
+
+	ret = socket(AF_UNIX, SOCK_DGRAM, 0);
+	EXPECT_NE(-1, ret)
+		TH_LOG("error creating unix socket");
+
+	self->invalid_fd = ret;
+}
+
+FIXTURE_TEARDOWN(invalid_fd)
+{
+	int ret;
+
+	ret = close(self->invalid_fd);
+	EXPECT_EQ(0, ret);
+}
+
+TEST_F(invalid_fd, test_invalid_fd)
+{
+	int ret;
+
+	ret = ioctl(self->invalid_fd, EPIOCGPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCGPARAMS on invalid epoll FD should error");
+
+	EXPECT_EQ(ENOTTY, errno)
+		TH_LOG("EPIOCGPARAMS on invalid epoll FD should set errno to ENOTTY");
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	ret = ioctl(self->invalid_fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS on invalid epoll FD should error");
+
+	EXPECT_EQ(ENOTTY, errno)
+		TH_LOG("EPIOCSPARAMS on invalid epoll FD should set errno to ENOTTY");
+}
+
+FIXTURE(epoll_busy_poll)
+{
+	int fd;
+	struct epoll_params params;
+	struct epoll_params *invalid_params;
+	cap_t caps;
+};
+
+FIXTURE_SETUP(epoll_busy_poll)
+{
+	int ret;
+
+	ret = epoll_create1(0);
+	EXPECT_NE(-1, ret)
+		TH_LOG("epoll_create1 failed?");
+
+	self->fd = ret;
+
+	self->caps = cap_get_proc();
+	EXPECT_NE(NULL, self->caps);
+}
+
+FIXTURE_TEARDOWN(epoll_busy_poll)
+{
+	int ret;
+
+	ret = close(self->fd);
+	EXPECT_EQ(0, ret);
+
+	ret = cap_free(self->caps);
+	EXPECT_NE(-1, ret)
+		TH_LOG("unable to free capabilities");
+}
+
+TEST_F(epoll_busy_poll, test_get_params)
+{
+	/* begin by getting the epoll params from the kernel
+	 *
+	 * the default should be default and all fields should be zero'd by the
+	 * kernel, so set params fields to garbage to test this.
+	 */
+	int ret = 0;
+
+	self->params.busy_poll_usecs = 0xff;
+	self->params.busy_poll_budget = 0xff;
+	self->params.prefer_busy_poll = 1;
+	self->params.__pad = 0xf;
+
+	ret = ioctl(self->fd, EPIOCGPARAMS, &self->params);
+	EXPECT_EQ(0, ret)
+		TH_LOG("ioctl EPIOCGPARAMS should succeed");
+
+	EXPECT_EQ(0, self->params.busy_poll_usecs)
+		TH_LOG("EPIOCGPARAMS busy_poll_usecs should have been 0");
+
+	EXPECT_EQ(0, self->params.busy_poll_budget)
+		TH_LOG("EPIOCGPARAMS busy_poll_budget should have been 0");
+
+	EXPECT_EQ(0, self->params.prefer_busy_poll)
+		TH_LOG("EPIOCGPARAMS prefer_busy_poll should have been 0");
+
+	EXPECT_EQ(0, self->params.__pad)
+		TH_LOG("EPIOCGPARAMS __pad should have been 0");
+
+	self->invalid_params = (struct epoll_params *)0xdeadbeef;
+	ret = ioctl(self->fd, EPIOCGPARAMS, self->invalid_params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCGPARAMS should error with invalid params");
+
+	EXPECT_EQ(EFAULT, errno)
+		TH_LOG("EPIOCGPARAMS with invalid params should set errno to EFAULT");
+}
+
+TEST_F(epoll_busy_poll, test_set_invalid)
+{
+	int ret;
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	self->params.__pad = 1;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS non-zero __pad should error");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("EPIOCSPARAMS non-zero __pad errno should be EINVAL");
+
+	self->params.__pad = 0;
+	self->params.busy_poll_usecs = (uint32_t)INT_MAX + 1;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error busy_poll_usecs > S32_MAX");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("EPIOCSPARAMS busy_poll_usecs > S32_MAX errno should be EINVAL");
+
+	self->params.__pad = 0;
+	self->params.busy_poll_usecs = 32;
+	self->params.prefer_busy_poll = 2;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error prefer_busy_poll > 1");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("EPIOCSPARAMS prefer_busy_poll > 1 errno should be EINVAL");
+
+	self->params.__pad = 0;
+	self->params.busy_poll_usecs = 32;
+	self->params.prefer_busy_poll = 1;
+
+	/* set budget well above kernel's NAPI_POLL_WEIGHT of 64 */
+	self->params.busy_poll_budget = UINT16_MAX;
+
+	/* test harness should run with CAP_NET_ADMIN, but let's make sure */
+	cap_flag_value_t tmp;
+
+	ret = cap_get_flag(self->caps, CAP_NET_ADMIN, CAP_EFFECTIVE, &tmp);
+	EXPECT_EQ(0, ret)
+		TH_LOG("unable to get CAP_NET_ADMIN cap flag");
+
+	EXPECT_EQ(CAP_SET, tmp)
+		TH_LOG("expecting CAP_NET_ADMIN to be set for the test harness");
+
+	/* at this point we know CAP_NET_ADMIN is available, so setting the
+	 * params with a busy_poll_budget > NAPI_POLL_WEIGHT should succeed
+	 */
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(0, ret)
+		TH_LOG("EPIOCSPARAMS should allow busy_poll_budget > NAPI_POLL_WEIGHT");
+
+	/* remove CAP_NET_ADMIN from our effective set */
+	cap_value_t net_admin[] = { CAP_NET_ADMIN };
+
+	ret = cap_set_flag(self->caps, CAP_EFFECTIVE, 1, net_admin, CAP_CLEAR);
+	EXPECT_EQ(0, ret)
+		TH_LOG("couldnt clear CAP_NET_ADMIN");
+
+	ret = cap_set_proc(self->caps);
+	EXPECT_EQ(0, ret)
+		TH_LOG("cap_set_proc should drop CAP_NET_ADMIN");
+
+	/* this is now expected to fail */
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error busy_poll_budget > NAPI_POLL_WEIGHT");
+
+	EXPECT_EQ(EPERM, errno)
+		TH_LOG("EPIOCSPARAMS errno should be EPERM busy_poll_budget > NAPI_POLL_WEIGHT");
+
+	/* restore CAP_NET_ADMIN to our effective set */
+	ret = cap_set_flag(self->caps, CAP_EFFECTIVE, 1, net_admin, CAP_SET);
+	EXPECT_EQ(0, ret)
+		TH_LOG("couldn't restore CAP_NET_ADMIN");
+
+	ret = cap_set_proc(self->caps);
+	EXPECT_EQ(0, ret)
+		TH_LOG("cap_set_proc should set  CAP_NET_ADMIN");
+
+	self->invalid_params = (struct epoll_params *)0xdeadbeef;
+	ret = ioctl(self->fd, EPIOCSPARAMS, self->invalid_params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error when epoll_params is invalid");
+
+	EXPECT_EQ(EFAULT, errno)
+		TH_LOG("EPIOCSPARAMS should set errno to EFAULT when epoll_params is invalid");
+}
+
+TEST_F(epoll_busy_poll, test_set_and_get_valid)
+{
+	int ret;
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	self->params.busy_poll_usecs = 25;
+	self->params.busy_poll_budget = 16;
+	self->params.prefer_busy_poll = 1;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(0, ret)
+		TH_LOG("EPIOCSPARAMS with valid params should not error");
+
+	/* check that the kernel returns the same values back */
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	ret = ioctl(self->fd, EPIOCGPARAMS, &self->params);
+
+	EXPECT_EQ(0, ret)
+		TH_LOG("EPIOCGPARAMS should not error");
+
+	EXPECT_EQ(25, self->params.busy_poll_usecs)
+		TH_LOG("params.busy_poll_usecs incorrect");
+
+	EXPECT_EQ(16, self->params.busy_poll_budget)
+		TH_LOG("params.busy_poll_budget incorrect");
+
+	EXPECT_EQ(1, self->params.prefer_busy_poll)
+		TH_LOG("params.prefer_busy_poll incorrect");
+
+	EXPECT_EQ(0, self->params.__pad)
+		TH_LOG("params.__pad was not 0");
+}
+
+TEST_F(epoll_busy_poll, test_invalid_ioctl)
+{
+	int invalid_ioctl = EPIOCGPARAMS + 10;
+	int ret;
+
+	ret = ioctl(self->fd, invalid_ioctl, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("invalid ioctl should return error");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("invalid ioctl should set errno to EINVAL");
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1


