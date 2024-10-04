Return-Path: <netdev+bounces-131935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A93B498FFCB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE6EB23B0A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B8145323;
	Fri,  4 Oct 2024 09:31:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D881494A7
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034311; cv=none; b=aUbbDwWBHx1/h4Gw/HvO+X64v3A+/1v+iKb0dqSwWC99/SDwkNevtq0O1NvgKTS/ZQ49OWCwljVJKG2q5oxNW1r2DWck3Dyii2yyMsvZeqtgpeh533KU/b42Fo5VkPRYzsb0mrryn+RyBJ18sPZ3J3ZYcOTXbP8qKpVJzC0yJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034311; c=relaxed/simple;
	bh=S6P0XpKje2bsphev9nwaLR2W+PwMJn2qKq2oNw/8dww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIe0mhIgTpew07wHtQMRWyhVz8xGfFc5ikjX4jNjuoh5FxI5gUMwz4ucKcWyLo3Xnw0VROUwHjUcO2WqBVcp9ajFA6tiKqk0DISEbANUuhAKV7c97Mvmv+w5a0IS7n0IUvfXh0qH9/mGw1qmrL2BuL8sirTuRgK3VzSeF2abBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [178.197.161.117] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1sweev-00000000dLn-0zCr;
	Fri, 04 Oct 2024 11:31:44 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98)
	(envelope-from <equinox@diac24.net>)
	id 1sweeK-00000000GlU-42Ss;
	Fri, 04 Oct 2024 11:31:00 +0200
From: David Lamparter <equinox@diac24.net>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org,
	David Lamparter <equinox@diac24.net>
Subject: [PATCH iproute2-next] lib: utils: move over `print_num` from ip/
Date: Fri,  4 Oct 2024 11:30:14 +0200
Message-ID: <20241004093050.64306-1-equinox@diac24.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`print_num()` was born in `ip/ipaddress.c` but considering it has
nothing to do with IP addresses it should really live in `lib/utils.c`.

(I've had reason to call it from bridge/* on some random hackery.)

Signed-off-by: David Lamparter <equinox@diac24.net>
---
 include/utils.h |  2 ++
 ip/ip.c         |  2 --
 ip/ip_common.h  |  3 ---
 ip/ipaddress.c  | 40 ----------------------------------------
 lib/utils.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tc/tc.c         |  1 -
 tc/tc_common.h  |  1 -
 7 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index a2a98b9bf17d..13aac0d033e2 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -37,6 +37,7 @@ extern int batch_mode;
 extern int numeric;
 extern bool do_all;
 extern int echo_request;
+extern int use_iec;
 
 #ifndef CONF_USR_DIR
 #define CONF_USR_DIR "/usr/lib/iproute2"
@@ -336,6 +337,7 @@ int get_time(unsigned int *time, const char *str);
 int get_time64(__s64 *time, const char *str);
 char *sprint_time(__u32 time, char *buf);
 char *sprint_time64(__s64 time, char *buf);
+void print_num(FILE *fp, unsigned int width, uint64_t count);
 
 int do_batch(const char *name, bool force,
 	     int (*cmd)(int argc, char *argv[], void *user), void *user);
diff --git a/ip/ip.c b/ip/ip.c
index eb492139a04d..c7151fbdc798 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -27,8 +27,6 @@
 #endif
 
 int preferred_family = AF_UNSPEC;
-int human_readable;
-int use_iec;
 int show_stats;
 int show_details;
 int oneline;
diff --git a/ip/ip_common.h b/ip/ip_common.h
index 625311c25bce..350806d9d0cc 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -7,8 +7,6 @@
 
 #include "json_print.h"
 
-extern int use_iec;
-
 struct link_filter {
 	int ifindex;
 	int family;
@@ -223,7 +221,6 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
 #define     LABEL_MAX_MASK          0xFFFFFU
 #endif
 
-void print_num(FILE *fp, unsigned int width, uint64_t count);
 void print_rt_flags(FILE *fp, unsigned int flags);
 void print_rta_ifidx(FILE *fp, __u32 ifidx, const char *prefix);
 void __print_rta_gateway(FILE *fp, unsigned char family, const char *gateway);
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 4e1f934fdbb4..f7bd14847477 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -568,46 +568,6 @@ void size_columns(unsigned int cols[], unsigned int n, ...)
 	va_end(args);
 }
 
-void print_num(FILE *fp, unsigned int width, uint64_t count)
-{
-	const char *prefix = "kMGTPE";
-	const unsigned int base = use_iec ? 1024 : 1000;
-	uint64_t powi = 1;
-	uint16_t powj = 1;
-	uint8_t precision = 2;
-	char buf[64];
-
-	if (!human_readable || count < base) {
-		fprintf(fp, "%*"PRIu64" ", width, count);
-		return;
-	}
-
-	/* increase value by a factor of 1000/1024 and print
-	 * if result is something a human can read
-	 */
-	for (;;) {
-		powi *= base;
-		if (count / base < powi)
-			break;
-
-		if (!prefix[1])
-			break;
-		++prefix;
-	}
-
-	/* try to guess a good number of digits for precision */
-	for (; precision > 0; precision--) {
-		powj *= 10;
-		if (count / powi < powj)
-			break;
-	}
-
-	snprintf(buf, sizeof(buf), "%.*f%c%s", precision,
-		 (double) count / powi, *prefix, use_iec ? "i" : "");
-
-	fprintf(fp, "%*s ", width, buf);
-}
-
 static void print_vf_stats64(FILE *fp, struct rtattr *vfstats)
 {
 	struct rtattr *vf[IFLA_VF_STATS_MAX + 1];
diff --git a/lib/utils.c b/lib/utils.c
index deb7654a0b01..6cf990067e0e 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -7,6 +7,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <inttypes.h>
 #include <math.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -38,6 +39,8 @@
 int resolve_hosts;
 int timestamp_short;
 int pretty;
+int use_iec;
+int human_readable;
 const char *_SL_ = "\n";
 
 static int af_byte_len(int af);
@@ -2017,3 +2020,43 @@ FILE *generic_proc_open(const char *env, const char *name)
 
 	return fopen(p, "r");
 }
+
+void print_num(FILE *fp, unsigned int width, uint64_t count)
+{
+	const char *prefix = "kMGTPE";
+	const unsigned int base = use_iec ? 1024 : 1000;
+	uint64_t powi = 1;
+	uint16_t powj = 1;
+	uint8_t precision = 2;
+	char buf[64];
+
+	if (!human_readable || count < base) {
+		fprintf(fp, "%*"PRIu64" ", width, count);
+		return;
+	}
+
+	/* increase value by a factor of 1000/1024 and print
+	 * if result is something a human can read
+	 */
+	for (;;) {
+		powi *= base;
+		if (count / base < powi)
+			break;
+
+		if (!prefix[1])
+			break;
+		++prefix;
+	}
+
+	/* try to guess a good number of digits for precision */
+	for (; precision > 0; precision--) {
+		powj *= 10;
+		if (count / powi < powj)
+			break;
+	}
+
+	snprintf(buf, sizeof(buf), "%.*f%c%s", precision,
+		 (double) count / powi, *prefix, use_iec ? "i" : "");
+
+	fprintf(fp, "%*s ", width, buf);
+}
diff --git a/tc/tc.c b/tc/tc.c
index 26e6f69ca81d..beb88111dc79 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -31,7 +31,6 @@ int show_graph;
 int timestamp;
 
 int batch_mode;
-int use_iec;
 int force;
 bool use_names;
 int json;
diff --git a/tc/tc_common.h b/tc/tc_common.h
index f1561d80a43b..bca6a7c9899f 100644
--- a/tc/tc_common.h
+++ b/tc/tc_common.h
@@ -27,4 +27,3 @@ int check_size_table_opts(struct tc_sizespec *s);
 
 extern int show_graph;
 extern bool use_names;
-extern int use_iec;
-- 
2.45.2


