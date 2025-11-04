Return-Path: <netdev+bounces-235632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA3C335F7
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7711834C36C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05982E090C;
	Tue,  4 Nov 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UypzBVLo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3932E03E6
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298637; cv=none; b=SK+otmTVWHYPSlmUcGHjgXicA0BnrYlz3GbT3U/h8aUKGcpEscktvngvfTb+/A+tjpAEZXHOyPFwnaacqz5k3bimSSf6PIx2Yv68cUtbufX+Nqyxxvv8Z3IdoA3+LmLmRFxbInS+XgZq8yMQFgvycYrXibmMf7Enbw4+hZ0/E2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298637; c=relaxed/simple;
	bh=HDZe7E1p1J6cDYjk3DZjPSBiNJRUdBLqAtoxpUaz6h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3Z1gVE+Rm9mOhiMMfjpd7iWXsLou5ajIekRNmAH0Urzit0YsqitU7rcRqoGxTbMGrbRTfFHBwWyecaM/rSpNY9mUYmaI2n0NYNw4u5Ceo1YvWUi7ZkEaurCfHsCMiuUw+RBrTdYPiAYunbcYQHZ00uRIRchzjeUbnRgN+YKAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UypzBVLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6013C116B1;
	Tue,  4 Nov 2025 23:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762298637;
	bh=HDZe7E1p1J6cDYjk3DZjPSBiNJRUdBLqAtoxpUaz6h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UypzBVLoyoA+0nhJ12qb5wn0/5nPCzcoa7507n4Ai8EZh4J25F9vQuk8/Y8xKzfC1
	 /kSuiiAvQ3ktElis2fgLHS5so4LSJxvOrEhGtyINTpLzaEbd/u++JY7kIqsQMN0r4Y
	 i6HK6+49qDYSoPcCjrzzu9BQ+WcAYL9f1e1PxEmtSG5lTmEZCqAAEoaMGH78WRYC/Q
	 E8cOOEYxShcwa3r7GGHU5WqihId/uMSACJU6r7kWwSEvj0SMdl0gzGx+j13IxhTnM6
	 fuddvngCVNlxFCIgweXeOtFttGsQFxzNXdO8m3FQnyYFjMVXuPq7ER+Lbzv8KV+jmu
	 nmzbOqU8MZUTg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	joe@dama.to,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] tools: ynltool: add page-pool stats
Date: Tue,  4 Nov 2025 15:23:46 -0800
Message-ID: <20251104232348.1954349-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104232348.1954349-1-kuba@kernel.org>
References: <20251104232348.1954349-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the page-pool sample with page pool support in ynltool.

 # ynltool page-pool stats
    eth0[2]	page pools: 18 (zombies: 0)
		refs: 171456 bytes: 702283776 (refs: 0 bytes: 0)
		recycling: 97.3% (alloc: 2679:6134966 recycle: 1250981:4719386)
 # ynltool -j page-pool stats | jq
 [
  {
    "ifname": "eth0",
    "ifindex": 2,
    "page_pools": 18,
    "zombies": 0,
    "live": {
      "refs": 171456,
      "bytes": 702283776
    },
    "zombie": {
      "refs": 0,
      "bytes": 0
    },
    "recycling_pct": 97.2746,
    "alloc": {
      "slow": 2679,
      "fast": 6135029
    },
    "recycle": {
      "ring": 1250997,
      "cache": 4719432
    }
  }
 ]

 # ynltool page-pool stats group-by pp
 pool id: 108  dev: eth0[2]  napi: 530
   inflight: 9472 pages 38797312 bytes
   recycling: 95.5% (alloc: 148:208379 recycle: 45386:153842)
 pool id: 107  dev: eth0[2]  napi: 529
   inflight: 9408 pages 38535168 bytes
   recycling: 94.9% (alloc: 147:180178 recycle: 42251:128808)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynltool/Makefile    |  11 +-
 tools/net/ynl/ynltool/main.h      |   3 +
 tools/net/ynl/samples/page-pool.c | 149 ----------
 tools/net/ynl/ynltool/main.c      |   3 +-
 tools/net/ynl/ynltool/page-pool.c | 461 ++++++++++++++++++++++++++++++
 5 files changed, 474 insertions(+), 153 deletions(-)
 delete mode 100644 tools/net/ynl/samples/page-pool.c
 create mode 100644 tools/net/ynl/ynltool/page-pool.c

diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
index ce27dc691ffe..1e860c63df66 100644
--- a/tools/net/ynl/ynltool/Makefile
+++ b/tools/net/ynl/ynltool/Makefile
@@ -10,25 +10,30 @@ CFLAGS := -Wall -Wextra -Werror -O2
 ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
-CFLAGS += -I../lib
+CFLAGS += -I../lib -I../generated -I../../../include/uapi/
 
 SRCS := $(wildcard *.c)
 OBJS := $(patsubst %.c,$(OUTPUT)%.o,$(SRCS))
 
 YNLTOOL := $(OUTPUT)ynltool
+LIBS := ../lib/ynl.a ../generated/netdev-user.o
 
 include $(wildcard *.d)
 
 all: $(YNLTOOL)
 
-$(YNLTOOL): $(OBJS)
+$(YNLTOOL): $(OBJS) $(LIBS)
 	@echo -e "\tLINK $@"
-	@$(CC) $(CFLAGS) -o $@ $(OBJS)
+	@$(CC) $(CFLAGS) -o $@ $(OBJS) $(LIBS) -lmnl
 
 %.o: %.c main.h json_writer.h
 	@echo -e "\tCC $@"
 	@$(COMPILE.c) -MMD -c -o $@ $<
 
+../generated/netdev-user.o: ../generated/netdev-user.c
+	@echo -e "\tCC $@"
+	@$(CC) $(filter-out -Werror -fsanitize=address -fsanitize=leak -static-libasan,$(CFLAGS)) -MMD -c -o $@ $<
+
 clean:
 	rm -f *.o *.d *~
 
diff --git a/tools/net/ynl/ynltool/main.h b/tools/net/ynl/ynltool/main.h
index f4a70acf2085..fd05d21451a2 100644
--- a/tools/net/ynl/ynltool/main.h
+++ b/tools/net/ynl/ynltool/main.h
@@ -59,4 +59,7 @@ struct cmd {
 int cmd_select(const struct cmd *cmds, int argc, char **argv,
 	       int (*help)(int argc, char **argv));
 
+/* subcommands */
+int do_page_pool(int argc, char **argv);
+
 #endif /* __YNLTOOL_H */
diff --git a/tools/net/ynl/samples/page-pool.c b/tools/net/ynl/samples/page-pool.c
deleted file mode 100644
index e5d521320fbf..000000000000
--- a/tools/net/ynl/samples/page-pool.c
+++ /dev/null
@@ -1,149 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <string.h>
-
-#include <ynl.h>
-
-#include <net/if.h>
-
-#include "netdev-user.h"
-
-struct stat {
-	unsigned int ifc;
-
-	struct {
-		unsigned int cnt;
-		size_t refs, bytes;
-	} live[2];
-
-	size_t alloc_slow, alloc_fast, recycle_ring, recycle_cache;
-};
-
-struct stats_array {
-	unsigned int i, max;
-	struct stat *s;
-};
-
-static struct stat *find_ifc(struct stats_array *a, unsigned int ifindex)
-{
-	unsigned int i;
-
-	for (i = 0; i < a->i; i++) {
-		if (a->s[i].ifc == ifindex)
-			return &a->s[i];
-	}
-
-	a->i++;
-	if (a->i == a->max) {
-		a->max *= 2;
-		a->s = reallocarray(a->s, a->max, sizeof(*a->s));
-	}
-	a->s[i].ifc = ifindex;
-	return &a->s[i];
-}
-
-static void count(struct stat *s, unsigned int l,
-		  struct netdev_page_pool_get_rsp *pp)
-{
-	s->live[l].cnt++;
-	if (pp->_present.inflight)
-		s->live[l].refs += pp->inflight;
-	if (pp->_present.inflight_mem)
-		s->live[l].bytes += pp->inflight_mem;
-}
-
-int main(int argc, char **argv)
-{
-	struct netdev_page_pool_stats_get_list *pp_stats;
-	struct netdev_page_pool_get_list *pools;
-	struct stats_array a = {};
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
-
-	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
-	if (!ys) {
-		fprintf(stderr, "YNL: %s\n", yerr.msg);
-		return 1;
-	}
-
-	a.max = 128;
-	a.s = calloc(a.max, sizeof(*a.s));
-	if (!a.s)
-		goto err_close;
-
-	pools = netdev_page_pool_get_dump(ys);
-	if (!pools)
-		goto err_free;
-
-	ynl_dump_foreach(pools, pp) {
-		struct stat *s = find_ifc(&a, pp->ifindex);
-
-		count(s, 1, pp);
-		if (pp->_present.detach_time)
-			count(s, 0, pp);
-	}
-	netdev_page_pool_get_list_free(pools);
-
-	pp_stats = netdev_page_pool_stats_get_dump(ys);
-	if (!pp_stats)
-		goto err_free;
-
-	ynl_dump_foreach(pp_stats, pp) {
-		struct stat *s = find_ifc(&a, pp->info.ifindex);
-
-		if (pp->_present.alloc_fast)
-			s->alloc_fast += pp->alloc_fast;
-		if (pp->_present.alloc_refill)
-			s->alloc_fast += pp->alloc_refill;
-		if (pp->_present.alloc_slow)
-			s->alloc_slow += pp->alloc_slow;
-		if (pp->_present.recycle_ring)
-			s->recycle_ring += pp->recycle_ring;
-		if (pp->_present.recycle_cached)
-			s->recycle_cache += pp->recycle_cached;
-	}
-	netdev_page_pool_stats_get_list_free(pp_stats);
-
-	for (unsigned int i = 0; i < a.i; i++) {
-		char ifname[IF_NAMESIZE];
-		struct stat *s = &a.s[i];
-		const char *name;
-		double recycle;
-
-		if (!s->ifc) {
-			name = "<orphan>\t";
-		} else {
-			name = if_indextoname(s->ifc, ifname);
-			if (name)
-				printf("%8s", name);
-			printf("[%u]\t", s->ifc);
-		}
-
-		printf("page pools: %u (zombies: %u)\n",
-		       s->live[1].cnt, s->live[0].cnt);
-		printf("\t\trefs: %zu bytes: %zu (refs: %zu bytes: %zu)\n",
-		       s->live[1].refs, s->live[1].bytes,
-		       s->live[0].refs, s->live[0].bytes);
-
-		/* We don't know how many pages are sitting in cache and ring
-		 * so we will under-count the recycling rate a bit.
-		 */
-		recycle = (double)(s->recycle_ring + s->recycle_cache) /
-			(s->alloc_fast + s->alloc_slow) * 100;
-		printf("\t\trecycling: %.1lf%% (alloc: %zu:%zu recycle: %zu:%zu)\n",
-		       recycle, s->alloc_slow, s->alloc_fast,
-		       s->recycle_ring, s->recycle_cache);
-	}
-
-	ynl_sock_destroy(ys);
-	return 0;
-
-err_free:
-	free(a.s);
-err_close:
-	fprintf(stderr, "YNL: %s\n", ys->err.msg);
-	ynl_sock_destroy(ys);
-	return 2;
-}
diff --git a/tools/net/ynl/ynltool/main.c b/tools/net/ynl/ynltool/main.c
index c5047fad50cf..ba7420e2a7d5 100644
--- a/tools/net/ynl/ynltool/main.c
+++ b/tools/net/ynl/ynltool/main.c
@@ -47,7 +47,7 @@ static int do_help(int argc __attribute__((unused)),
 		"Usage: %s [OPTIONS] OBJECT { COMMAND | help }\n"
 		"       %s version\n"
 		"\n"
-		"       OBJECT := { }\n"
+		"       OBJECT := { page-pool }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, bin_name);
@@ -71,6 +71,7 @@ static int do_version(int argc __attribute__((unused)),
 
 static const struct cmd commands[] = {
 	{ "help",	do_help },
+	{ "page-pool",	do_page_pool },
 	{ "version",	do_version },
 	{ 0 }
 };
diff --git a/tools/net/ynl/ynltool/page-pool.c b/tools/net/ynl/ynltool/page-pool.c
new file mode 100644
index 000000000000..4b24492abab7
--- /dev/null
+++ b/tools/net/ynl/ynltool/page-pool.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <net/if.h>
+
+#include <ynl.h>
+#include "netdev-user.h"
+
+#include "main.h"
+
+struct pp_stat {
+	unsigned int ifc;
+
+	struct {
+		unsigned int cnt;
+		size_t refs, bytes;
+	} live[2];
+
+	size_t alloc_slow, alloc_fast, recycle_ring, recycle_cache;
+};
+
+struct pp_stats_array {
+	unsigned int i, max;
+	struct pp_stat *s;
+};
+
+static struct pp_stat *find_ifc(struct pp_stats_array *a, unsigned int ifindex)
+{
+	unsigned int i;
+
+	for (i = 0; i < a->i; i++) {
+		if (a->s[i].ifc == ifindex)
+			return &a->s[i];
+	}
+
+	a->i++;
+	if (a->i == a->max) {
+		a->max *= 2;
+		a->s = reallocarray(a->s, a->max, sizeof(*a->s));
+	}
+	a->s[i].ifc = ifindex;
+	return &a->s[i];
+}
+
+static void count_pool(struct pp_stat *s, unsigned int l,
+		       struct netdev_page_pool_get_rsp *pp)
+{
+	s->live[l].cnt++;
+	if (pp->_present.inflight)
+		s->live[l].refs += pp->inflight;
+	if (pp->_present.inflight_mem)
+		s->live[l].bytes += pp->inflight_mem;
+}
+
+/* We don't know how many pages are sitting in cache and ring
+ * so we will under-count the recycling rate a bit.
+ */
+static void print_json_recycling_stats(struct pp_stat *s)
+{
+	double recycle;
+
+	if (s->alloc_fast + s->alloc_slow) {
+		recycle = (double)(s->recycle_ring + s->recycle_cache) /
+			(s->alloc_fast + s->alloc_slow) * 100;
+		jsonw_float_field(json_wtr, "recycling_pct", recycle);
+	}
+
+	jsonw_name(json_wtr, "alloc");
+	jsonw_start_object(json_wtr);
+	jsonw_uint_field(json_wtr, "slow", s->alloc_slow);
+	jsonw_uint_field(json_wtr, "fast", s->alloc_fast);
+	jsonw_end_object(json_wtr);
+
+	jsonw_name(json_wtr, "recycle");
+	jsonw_start_object(json_wtr);
+	jsonw_uint_field(json_wtr, "ring", s->recycle_ring);
+	jsonw_uint_field(json_wtr, "cache", s->recycle_cache);
+	jsonw_end_object(json_wtr);
+}
+
+static void print_plain_recycling_stats(struct pp_stat *s)
+{
+	double recycle;
+
+	if (s->alloc_fast + s->alloc_slow) {
+		recycle = (double)(s->recycle_ring + s->recycle_cache) /
+			(s->alloc_fast + s->alloc_slow) * 100;
+		printf("recycling: %.1lf%% (alloc: %zu:%zu recycle: %zu:%zu)",
+		       recycle, s->alloc_slow, s->alloc_fast,
+		       s->recycle_ring, s->recycle_cache);
+	}
+}
+
+static void print_json_stats(struct pp_stats_array *a)
+{
+	jsonw_start_array(json_wtr);
+
+	for (unsigned int i = 0; i < a->i; i++) {
+		char ifname[IF_NAMESIZE];
+		struct pp_stat *s = &a->s[i];
+		const char *name;
+
+		jsonw_start_object(json_wtr);
+
+		if (!s->ifc) {
+			jsonw_string_field(json_wtr, "ifname", "<orphan>");
+			jsonw_uint_field(json_wtr, "ifindex", 0);
+		} else {
+			name = if_indextoname(s->ifc, ifname);
+			if (name)
+				jsonw_string_field(json_wtr, "ifname", name);
+			jsonw_uint_field(json_wtr, "ifindex", s->ifc);
+		}
+
+		jsonw_uint_field(json_wtr, "page_pools", s->live[1].cnt);
+		jsonw_uint_field(json_wtr, "zombies", s->live[0].cnt);
+
+		jsonw_name(json_wtr, "live");
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "refs", s->live[1].refs);
+		jsonw_uint_field(json_wtr, "bytes", s->live[1].bytes);
+		jsonw_end_object(json_wtr);
+
+		jsonw_name(json_wtr, "zombie");
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "refs", s->live[0].refs);
+		jsonw_uint_field(json_wtr, "bytes", s->live[0].bytes);
+		jsonw_end_object(json_wtr);
+
+		if (s->alloc_fast || s->alloc_slow)
+			print_json_recycling_stats(s);
+
+		jsonw_end_object(json_wtr);
+	}
+
+	jsonw_end_array(json_wtr);
+}
+
+static void print_plain_stats(struct pp_stats_array *a)
+{
+	for (unsigned int i = 0; i < a->i; i++) {
+		char ifname[IF_NAMESIZE];
+		struct pp_stat *s = &a->s[i];
+		const char *name;
+
+		if (!s->ifc) {
+			printf("<orphan>\t");
+		} else {
+			name = if_indextoname(s->ifc, ifname);
+			if (name)
+				printf("%8s", name);
+			printf("[%u]\t", s->ifc);
+		}
+
+		printf("page pools: %u (zombies: %u)\n",
+		       s->live[1].cnt, s->live[0].cnt);
+		printf("\t\trefs: %zu bytes: %zu (refs: %zu bytes: %zu)\n",
+		       s->live[1].refs, s->live[1].bytes,
+		       s->live[0].refs, s->live[0].bytes);
+
+		if (s->alloc_fast || s->alloc_slow) {
+			printf("\t\t");
+			print_plain_recycling_stats(s);
+			printf("\n");
+		}
+	}
+}
+
+static bool
+find_pool_stat_in_list(struct netdev_page_pool_stats_get_list *pp_stats,
+		       __u64 pool_id, struct pp_stat *pstat)
+{
+	ynl_dump_foreach(pp_stats, pp) {
+		if (!pp->_present.info || !pp->info._present.id)
+			continue;
+		if (pp->info.id != pool_id)
+			continue;
+
+		memset(pstat, 0, sizeof(*pstat));
+		if (pp->_present.alloc_fast)
+			pstat->alloc_fast = pp->alloc_fast;
+		if (pp->_present.alloc_refill)
+			pstat->alloc_fast += pp->alloc_refill;
+		if (pp->_present.alloc_slow)
+			pstat->alloc_slow = pp->alloc_slow;
+		if (pp->_present.recycle_ring)
+			pstat->recycle_ring = pp->recycle_ring;
+		if (pp->_present.recycle_cached)
+			pstat->recycle_cache = pp->recycle_cached;
+		return true;
+	}
+	return false;
+}
+
+static void
+print_json_pool_list(struct netdev_page_pool_get_list *pools,
+		     struct netdev_page_pool_stats_get_list *pp_stats,
+		     bool zombies_only)
+{
+	jsonw_start_array(json_wtr);
+
+	ynl_dump_foreach(pools, pp) {
+		char ifname[IF_NAMESIZE];
+		struct pp_stat pstat;
+		const char *name;
+
+		if (zombies_only && !pp->_present.detach_time)
+			continue;
+
+		jsonw_start_object(json_wtr);
+
+		jsonw_uint_field(json_wtr, "id", pp->id);
+
+		if (pp->_present.ifindex) {
+			name = if_indextoname(pp->ifindex, ifname);
+			if (name)
+				jsonw_string_field(json_wtr, "ifname", name);
+			jsonw_uint_field(json_wtr, "ifindex", pp->ifindex);
+		}
+
+		if (pp->_present.napi_id)
+			jsonw_uint_field(json_wtr, "napi_id", pp->napi_id);
+
+		if (pp->_present.inflight)
+			jsonw_uint_field(json_wtr, "refs", pp->inflight);
+
+		if (pp->_present.inflight_mem)
+			jsonw_uint_field(json_wtr, "bytes", pp->inflight_mem);
+
+		if (pp->_present.detach_time)
+			jsonw_uint_field(json_wtr, "detach_time", pp->detach_time);
+
+		if (pp->_present.dmabuf)
+			jsonw_uint_field(json_wtr, "dmabuf", pp->dmabuf);
+
+		if (find_pool_stat_in_list(pp_stats, pp->id, &pstat) &&
+		    (pstat.alloc_fast || pstat.alloc_slow))
+			print_json_recycling_stats(&pstat);
+
+		jsonw_end_object(json_wtr);
+	}
+
+	jsonw_end_array(json_wtr);
+}
+
+static void
+print_plain_pool_list(struct netdev_page_pool_get_list *pools,
+		      struct netdev_page_pool_stats_get_list *pp_stats,
+		      bool zombies_only)
+{
+	ynl_dump_foreach(pools, pp) {
+		char ifname[IF_NAMESIZE];
+		struct pp_stat pstat;
+		const char *name;
+
+		if (zombies_only && !pp->_present.detach_time)
+			continue;
+
+		printf("pool id: %llu", pp->id);
+
+		if (pp->_present.ifindex) {
+			name = if_indextoname(pp->ifindex, ifname);
+			if (name)
+				printf("  dev: %s", name);
+			printf("[%u]", pp->ifindex);
+		}
+
+		if (pp->_present.napi_id)
+			printf("  napi: %llu", pp->napi_id);
+
+		printf("\n");
+
+		if (pp->_present.inflight || pp->_present.inflight_mem) {
+			printf("  inflight:");
+			if (pp->_present.inflight)
+				printf(" %llu pages", pp->inflight);
+			if (pp->_present.inflight_mem)
+				printf(" %llu bytes", pp->inflight_mem);
+			printf("\n");
+		}
+
+		if (pp->_present.detach_time)
+			printf("  detached: %llu\n", pp->detach_time);
+
+		if (pp->_present.dmabuf)
+			printf("  dmabuf: %u\n", pp->dmabuf);
+
+		if (find_pool_stat_in_list(pp_stats, pp->id, &pstat) &&
+		    (pstat.alloc_fast || pstat.alloc_slow)) {
+			printf("  ");
+			print_plain_recycling_stats(&pstat);
+			printf("\n");
+		}
+	}
+}
+
+static void aggregate_device_stats(struct pp_stats_array *a,
+				   struct netdev_page_pool_get_list *pools,
+				   struct netdev_page_pool_stats_get_list *pp_stats)
+{
+	ynl_dump_foreach(pools, pp) {
+		struct pp_stat *s = find_ifc(a, pp->ifindex);
+
+		count_pool(s, 1, pp);
+		if (pp->_present.detach_time)
+			count_pool(s, 0, pp);
+	}
+
+	ynl_dump_foreach(pp_stats, pp) {
+		struct pp_stat *s = find_ifc(a, pp->info.ifindex);
+
+		if (pp->_present.alloc_fast)
+			s->alloc_fast += pp->alloc_fast;
+		if (pp->_present.alloc_refill)
+			s->alloc_fast += pp->alloc_refill;
+		if (pp->_present.alloc_slow)
+			s->alloc_slow += pp->alloc_slow;
+		if (pp->_present.recycle_ring)
+			s->recycle_ring += pp->recycle_ring;
+		if (pp->_present.recycle_cached)
+			s->recycle_cache += pp->recycle_cached;
+	}
+}
+
+static int do_stats(int argc, char **argv)
+{
+	struct netdev_page_pool_stats_get_list *pp_stats;
+	struct netdev_page_pool_get_list *pools;
+	enum {
+		GROUP_BY_DEVICE,
+		GROUP_BY_POOL,
+	} group_by = GROUP_BY_DEVICE;
+	bool zombies_only = false;
+	struct pp_stats_array a = {};
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret = 0;
+
+	/* Parse options */
+	while (argc > 0) {
+		if (is_prefix(*argv, "group-by")) {
+			NEXT_ARG();
+
+			if (!REQ_ARGS(1))
+				return -1;
+
+			if (is_prefix(*argv, "device")) {
+				group_by = GROUP_BY_DEVICE;
+			} else if (is_prefix(*argv, "pp") ||
+				   is_prefix(*argv, "page-pool") ||
+				   is_prefix(*argv, "none")) {
+				group_by = GROUP_BY_POOL;
+			} else {
+				p_err("invalid group-by value '%s'", *argv);
+				return -1;
+			}
+			NEXT_ARG();
+		} else if (is_prefix(*argv, "zombies")) {
+			zombies_only = true;
+			group_by = GROUP_BY_POOL;
+			NEXT_ARG();
+		} else {
+			p_err("unknown option '%s'", *argv);
+			return -1;
+		}
+	}
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!ys) {
+		p_err("YNL: %s", yerr.msg);
+		return -1;
+	}
+
+	pools = netdev_page_pool_get_dump(ys);
+	if (!pools) {
+		p_err("failed to get page pools: %s", ys->err.msg);
+		ret = -1;
+		goto exit_close;
+	}
+
+	pp_stats = netdev_page_pool_stats_get_dump(ys);
+	if (!pp_stats) {
+		p_err("failed to get page pool stats: %s", ys->err.msg);
+		ret = -1;
+		goto exit_free_pp_list;
+	}
+
+	/* If grouping by pool, print individual pools */
+	if (group_by == GROUP_BY_POOL) {
+		if (json_output)
+			print_json_pool_list(pools, pp_stats, zombies_only);
+		else
+			print_plain_pool_list(pools, pp_stats, zombies_only);
+	} else {
+		/* Aggregated stats mode (group-by device) */
+		a.max = 64;
+		a.s = calloc(a.max, sizeof(*a.s));
+		if (!a.s) {
+			p_err("failed to allocate stats array");
+			ret = -1;
+			goto exit_free_stats_list;
+		}
+
+		aggregate_device_stats(&a, pools, pp_stats);
+
+		if (json_output)
+			print_json_stats(&a);
+		else
+			print_plain_stats(&a);
+
+		free(a.s);
+	}
+
+exit_free_stats_list:
+	netdev_page_pool_stats_get_list_free(pp_stats);
+exit_free_pp_list:
+	netdev_page_pool_get_list_free(pools);
+exit_close:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
+static int do_help(int argc __attribute__((unused)),
+		   char **argv __attribute__((unused)))
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %s page-pool { COMMAND | help }\n"
+		"       %s page-pool stats [ OPTIONS ]\n"
+		"\n"
+		"       OPTIONS := { group-by { device | page-pool | none } | zombies }\n"
+		"\n"
+		"       stats                   - Display page pool statistics\n"
+		"       stats group-by device   - Group statistics by network device (default)\n"
+		"       stats group-by page-pool | pp | none\n"
+		"                               - Show individual page pool details (no grouping)\n"
+		"       stats zombies           - Show only zombie page pools (detached but with\n"
+		"                                 pages in flight). Implies group-by page-pool.\n"
+		"",
+		bin_name, bin_name);
+
+	return 0;
+}
+
+static const struct cmd page_pool_cmds[] = {
+	{ "help",	do_help },
+	{ "stats",	do_stats },
+	{ 0 }
+};
+
+int do_page_pool(int argc, char **argv)
+{
+	return cmd_select(page_pool_cmds, argc, argv, do_help);
+}
-- 
2.51.1


