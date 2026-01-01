Return-Path: <netdev+bounces-246493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D1CED3A3
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 18:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA577300888E
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791AE2F0C5B;
	Thu,  1 Jan 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr10RnHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350D212554
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767288541; cv=none; b=ISCtoMcYjrhENEtAzj+WOcSqZOc/KWx3Q2HM3a9YNpK6MClVmbq1mgzpTIOCEEszcAv+7siiH6FFbJjIzzLniQrx7eQ3ofy4Z4JV/27eX5MYmUThDUerGC/YdGL8veIK9wMXrmIHF237EJ9383KQQx6+D107wGb7hQV2i0WDzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767288541; c=relaxed/simple;
	bh=MV5n72uyCXTGufdfs+Tp7/c9h3fB3MkOv24cXNNb7zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGr6gYhQH0CUiDdwFn2XJ7SRLEcDXn9uvXy9Cg0SBuo4biOyaMa5LXdGimQU7p+mrCBXEoh8wdXck3IweJY+lCXkVuNNtfMvW3dleeyu7KC0uzu7pxn05rISlcXUbih+Mq15pl0xW4T366ru/26qjhjlhoqwSanCQB/XWv6C9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr10RnHs; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso6353084a91.1
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767288538; x=1767893338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrW3GbVAxBV1YYnSWttRqVD3T0zt7/uD6xCGh6+826Q=;
        b=Wr10RnHsSBPVbzqfBwWSHlcnT17bzcG+lhsXgMZGTGJ9tfp7wJbHUQKlGO2Nn6+kKb
         Zv2p3dKZHn/rtuOZiFa7y6GlbyW5ZDwm2RwWa5DBXuTXqQ/Ik85Ho0NnXw5qJwCpEwqZ
         wZvGZAV00yZ45wA+7Po3ANq3aH5luFlpVj7sqTQ47VVs+BvioabY62W1Q//XSkWzrocP
         TRMurknADCypauRmCLiZ1P0ly03jKtuHxREXuHmFXeEa8803QROuWyjG8ufwbBjFSgyY
         MZQ2evJnpMFdGU1bNHSvQO6VIjVmGCeqf2g7bwykqEea/sk4DfdBfnQQwhVc5F6gK3Se
         ds2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767288538; x=1767893338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrW3GbVAxBV1YYnSWttRqVD3T0zt7/uD6xCGh6+826Q=;
        b=BaLxP+jRoWVzzUGnORzTpXaW+eIIgfA1Mt9aeXH/3G5qQRZTX6NYGbQJ7cqVxdjWM9
         mM+6GS1E3SFx5QH8YgrPKWEyk6Ta58YYqXYuxgie+2vhTQR63gIarKWu+qCln98chpG6
         N/yahu2p3brlGDN1kzHQpfamLidF+sjY5f+GA9+yOlVjwy/LZPq4WDtPCrSy/vOon8+Z
         /MumDI8dUWbut7TAY7IkwRNW99ySJL6nqNAPodCpwOHg1iq1/bseP5AqDgppC35xmxwp
         lWPd94QZENg0yfr/gFg3Nj6pC+hnXO5knR4AVyIKT4VjQuRZlphWwUS39xvIwZly59Am
         ZxHA==
X-Forwarded-Encrypted: i=1; AJvYcCUYGFx6VycnJC+v+8FnhZKP9zVhesjN0CLQ8Ag8/ZYQ35oNre92JqhA8MBPs1BaP2nfTqSVR5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXBdCiEGVXj1oPsb20NXcXciqgBo+twpMj+82tAEA5eUX9rrD
	TYH/aYcVptz7FHouU2Ho+hNIQJ3Z5aMbtlNLYXITRUKYv3sG8SBz1opy
X-Gm-Gg: AY/fxX7Y2E0zjmFwGXN6yWRNnqbCUfbBdA2zT//Isxd/Ne3p0X2fVfu+GgIIYHmQbNa
	yeBseQ0JW/USAhu2Z+UqzC9brM7iPw53sZB1kf/duwzmMGN/8OY8wgTfuAR8Oko+HKR7U5F1QxJ
	SsXi5VPMkOHp6+XvCfkG98xmS+gX759AcjAj/xBJ87HhuXQ8Bzl4tnleLjg1bb5w3qgIG/eIPYT
	3l1E4D3XVC+QzL3+kQkIM2ISXzR9oXZ5wutrDm9mbhOm8HztS5UTZZBCYvwsB65Fp24mouaXdUC
	bHfiSlaz3gE0bV+H2sjP5FqsUgJADv10aG0//GKWVLrX3VFT5lHswEUchI+v4srPB8j9DXNx+/7
	Mc73Va+L3FZM/i8Jz/gmGlXoPFVwWh3xunqETzeLcknSjBL47WYYdNm2ziU8FWnJ8F/Yoy5rTxV
	5s4IgTuw6ttUmZz+El6gVxEPNFJZzakz/wXSZ0fkEc
X-Google-Smtp-Source: AGHT+IFq/e0ejvWVIghaAdB4wbXdz4r0A1x/pqGUvUQjwWFjrtqQuvmu8127TTkEaqjZBtPm+dNKzw==
X-Received: by 2002:a05:6a20:3d0b:b0:366:14b0:4b1b with SMTP id adf61e73a8af0-3769ff1bb74mr38532914637.38.1767288537751;
        Thu, 01 Jan 2026 09:28:57 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79e05712sm33360272a12.14.2026.01.01.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 09:28:56 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH net v3] selftests: mptcp: Mark xerror and die_perror __noreturn
Date: Thu,  1 Jan 2026 22:58:40 +0530
Message-ID: <20260101172840.90186-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler reports potential uses of uninitialized variables in
mptcp_connect.c when xerror() is called from failure paths.

mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
      uninitialized whenever 'if' condition is false
      [-Wsometimes-uninitialized]

xerror() terminates execution by calling exit(), but it is not visible
to the compiler & assumes control flow may continue past the call.

Annotate xerror() with __noreturn so the compiler can correctly reason
about control flow and avoid false-positive uninitialized variable
warnings.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
changelog:
v3:
- also annotate 'die_perror()' with __noreturn
- add CFLAGS at top of makefile
- target this patch to net instead of net-next as suggested by Matthieu

v2: https://lore.kernel.org/all/20251129043808.16714-1-ankitkhushwaha.linux@gmail.com/
- annotate 'xerror()' with __noreturn
- remove defining 'raw_addr' to NULL

v1: https://lore.kernel.org/all/20251126163046.58615-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/net/mptcp/Makefile        | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_diag.c    | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++--
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 15d144a25d82..4dd6278cd3dd 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -3,6 +3,7 @@
 top_srcdir = ../../../../..

 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS += -I$(top_srcdir)/tools/include

 TEST_PROGS := \
 	diag.sh \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 404a77bf366a..10f6f99cfd4e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -33,6 +33,7 @@
 #include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
+#include <linux/compiler.h>

 extern int optind;

@@ -140,7 +141,7 @@ static void die_usage(void)
 	exit(1);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index e084796e804d..8e0b1b8d84b6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -5,6 +5,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/inet_diag.h>
 #include <linux/netlink.h>
+#include <linux/compiler.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <linux/tcp.h>
@@ -87,7 +88,7 @@ enum {

 #define rta_getattr(type, value)		(*(type *)RTA_DATA(value))

-static void die_perror(const char *msg)
+static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
 	exit(1);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 8e8f6441ad8b..5716998da192 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -28,6 +28,7 @@

 #include <linux/tcp.h>
 #include <linux/sockios.h>
+#include <linux/compiler.h>

 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -40,7 +41,7 @@ static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;

-static void die_perror(const char *msg)
+static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
 	exit(1);
@@ -52,7 +53,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 286164f7246e..b6e58d936ebe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>

 #include <linux/tcp.h>
+#include <linux/compiler.h>

 static int pf = AF_INET;

@@ -127,7 +128,7 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif

-static void die_perror(const char *msg)
+static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
 	exit(1);
@@ -139,7 +140,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

--
2.52.0


