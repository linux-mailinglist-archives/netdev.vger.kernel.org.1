Return-Path: <netdev+bounces-235634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905CC335FA
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B295A34BC51
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6662E2825;
	Tue,  4 Nov 2025 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOW64mFp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F742E1F0E
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298638; cv=none; b=qB//segyx+soA8f0uSdWA3T9y2x/WOCoo+M5RAF3GaYbi3a39yjY+WkIl+K1o1e28xb5b507LFIToQYk2C7BgzZlnSnGkc3dyPVv5w/ccDUta8iEH5mD7bqUBmRcEaYEdHOb6GJen6H/nAOR0u87Rxrf2sRWyguRMR07d8b2kdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298638; c=relaxed/simple;
	bh=ac27qDfiL3DzAS1Gq7wogtyqvj7uuvxj8Qzxa+5Lxjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQp/OE38xO4xewftW+NsgNu9qq+VGjknLXwAjqXiG52zhqwY4+9vxgcBtgrNOsAhvPtnbaQe0Im8S7NmcwrxAF+lenXtLYjyOMZOdcqjFSpYyFR37hOpvRPeB6jgrZ58Bj94PCz3P9wAs7HiU/R1wW4Jc1173GCM5/B0nKZCX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOW64mFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9C3C4CEF7;
	Tue,  4 Nov 2025 23:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762298638;
	bh=ac27qDfiL3DzAS1Gq7wogtyqvj7uuvxj8Qzxa+5Lxjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOW64mFpiXtvYcBDvFAR0lGMbAMiRqgWYkuoVEcaQsPuWkgjuRzz7DgqO0hAHm3F4
	 +EzkFLtY120v8A9xNhsXid5DeEk46l3fmOrmBoTvUgR4wOaMCRVxE8GZVLWyQr7wvx
	 Nfq/bqO1TVM8362unMQn1Vl6J9caZMCgT9iqqrtsTyXFLc06BMLYqPgVeNO6ZhuJY2
	 YbvC6O+HDwsYMpgKC5oFanCmkGh7zPweOu91HP5i7KBu/pf2kR/2pV8nNQGDu6z8yq
	 /lA8ZltbineFtrVZP/rKI6gcbqEQHkekC2Za/qW3rfamOomM8Xxy6WEUtCytjF+Mf5
	 YlzMpdYdRUIqA==
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
Subject: [PATCH net-next 5/5] tools: ynltool: add traffic distribution balance
Date: Tue,  4 Nov 2025 15:23:48 -0800
Message-ID: <20251104232348.1954349-6-kuba@kernel.org>
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

The main if not only use case for per-queue stats today is checking
for traffic imbalance. Add simple traffic balance analysis to qstats.

 $ ynltool qstat balance
 eth0 rx 44 queues:
  rx-packets  : cv=6.9% ns=24.2% stddev=512006493
                min=6278921110 max=8011570575 mean=7437054644
  rx-bytes    : cv=6.9% ns=24.1% stddev=759670503060
                min=9326315769440 max=11884393670786 mean=11035439201354
  ...

  $ ynltool -j qstat balance | jq
  [
   {
    "ifname": "eth0",
    "ifindex": 2,
    "queue-type": "rx",
    "rx-packets": {
      "queue-count": 44,
      "min": 6278301665,
      "max": 8010780185,
      "mean": 7.43635E+9,
      "stddev": 5.12012E+8,
      "coefficient-of-variation": 6.88525,
      "normalized-spread": 24.249
    },
   ...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynltool/Makefile |   2 +-
 tools/net/ynl/ynltool/qstats.c | 293 ++++++++++++++++++++++++++++++++-
 2 files changed, 293 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
index 1e860c63df66..2fe520f54ebb 100644
--- a/tools/net/ynl/ynltool/Makefile
+++ b/tools/net/ynl/ynltool/Makefile
@@ -24,7 +24,7 @@ all: $(YNLTOOL)
 
 $(YNLTOOL): $(OBJS) $(LIBS)
 	@echo -e "\tLINK $@"
-	@$(CC) $(CFLAGS) -o $@ $(OBJS) $(LIBS) -lmnl
+	@$(CC) $(CFLAGS) -o $@ $(OBJS) $(LIBS) -lmnl -lm
 
 %.o: %.c main.h json_writer.h
 	@echo -e "\tCC $@"
diff --git a/tools/net/ynl/ynltool/qstats.c b/tools/net/ynl/ynltool/qstats.c
index fcdbb6d9a852..31fb45709ffa 100644
--- a/tools/net/ynl/ynltool/qstats.c
+++ b/tools/net/ynl/ynltool/qstats.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <errno.h>
 #include <net/if.h>
+#include <math.h>
 
 #include <ynl.h>
 #include "netdev-user.h"
@@ -13,6 +14,16 @@
 
 static enum netdev_qstats_scope scope; /* default - device */
 
+struct queue_balance {
+	unsigned int ifindex;
+	enum netdev_queue_type type;
+	unsigned int queue_count;
+	__u64 *rx_packets;
+	__u64 *rx_bytes;
+	__u64 *tx_packets;
+	__u64 *tx_bytes;
+};
+
 static void print_json_qstats(struct netdev_qstats_get_list *qstats)
 {
 	jsonw_start_array(json_wtr);
@@ -293,6 +304,283 @@ static int do_show(int argc, char **argv)
 	return ret;
 }
 
+static void compute_stats(__u64 *values, unsigned int count,
+			  double *mean, double *stddev, __u64 *min, __u64 *max)
+{
+	double sum = 0.0, variance = 0.0;
+	unsigned int i;
+
+	*min = ~0ULL;
+	*max = 0;
+
+	if (count == 0) {
+		*mean = 0;
+		*stddev = 0;
+		*min = 0;
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		sum += values[i];
+		if (values[i] < *min)
+			*min = values[i];
+		if (values[i] > *max)
+			*max = values[i];
+	}
+
+	*mean = sum / count;
+
+	if (count > 1) {
+		for (i = 0; i < count; i++) {
+			double diff = values[i] - *mean;
+
+			variance += diff * diff;
+		}
+		*stddev = sqrt(variance / (count - 1));
+	} else {
+		*stddev = 0;
+	}
+}
+
+static void print_balance_stats(const char *name, enum netdev_queue_type type,
+				__u64 *values, unsigned int count)
+{
+	double mean, stddev, cv, ns;
+	__u64 min, max;
+
+	if ((name[0] == 'r' && type != NETDEV_QUEUE_TYPE_RX) ||
+	    (name[0] == 't' && type != NETDEV_QUEUE_TYPE_TX))
+		return;
+
+	compute_stats(values, count, &mean, &stddev, &min, &max);
+
+	cv = mean > 0 ? (stddev / mean) * 100.0 : 0.0;
+	ns = min + max > 0 ? (double)2 * (max - min) / (max + min) * 100 : 0.0;
+
+	printf("  %-12s: cv=%.1f%% ns=%.1f%% stddev=%.0f\n",
+	       name, cv, ns, stddev);
+	printf("  %-12s  min=%llu max=%llu mean=%.0f\n",
+	       "", min, max, mean);
+}
+
+static void
+print_balance_stats_json(const char *name, enum netdev_queue_type type,
+			 __u64 *values, unsigned int count)
+{
+	double mean, stddev, cv, ns;
+	__u64 min, max;
+
+	if ((name[0] == 'r' && type != NETDEV_QUEUE_TYPE_RX) ||
+	    (name[0] == 't' && type != NETDEV_QUEUE_TYPE_TX))
+		return;
+
+	compute_stats(values, count, &mean, &stddev, &min, &max);
+
+	cv = mean > 0 ? (stddev / mean) * 100.0 : 0.0;
+	ns = min + max > 0 ? (double)2 * (max - min) / (max + min) * 100 : 0.0;
+
+	jsonw_name(json_wtr, name);
+	jsonw_start_object(json_wtr);
+	jsonw_uint_field(json_wtr, "queue-count", count);
+	jsonw_uint_field(json_wtr, "min", min);
+	jsonw_uint_field(json_wtr, "max", max);
+	jsonw_float_field(json_wtr, "mean", mean);
+	jsonw_float_field(json_wtr, "stddev", stddev);
+	jsonw_float_field(json_wtr, "coefficient-of-variation", cv);
+	jsonw_float_field(json_wtr, "normalized-spread", ns);
+	jsonw_end_object(json_wtr);
+}
+
+static int cmp_ifindex_type(const void *a, const void *b)
+{
+	const struct netdev_qstats_get_rsp *qa = a;
+	const struct netdev_qstats_get_rsp *qb = b;
+
+	if (qa->ifindex != qb->ifindex)
+		return qa->ifindex - qb->ifindex;
+	if (qa->queue_type != qb->queue_type)
+		return qa->queue_type - qb->queue_type;
+	return qa->queue_id - qb->queue_id;
+}
+
+static int do_balance(int argc, char **argv __attribute__((unused)))
+{
+	struct netdev_qstats_get_list *qstats;
+	struct netdev_qstats_get_req *req;
+	struct netdev_qstats_get_rsp **sorted;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	unsigned int count = 0;
+	unsigned int i, j;
+	int ret = 0;
+
+	if (argc > 0) {
+		p_err("balance command takes no arguments");
+		return -1;
+	}
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!ys) {
+		p_err("YNL: %s", yerr.msg);
+		return -1;
+	}
+
+	req = netdev_qstats_get_req_alloc();
+	if (!req) {
+		p_err("failed to allocate qstats request");
+		ret = -1;
+		goto exit_close;
+	}
+
+	/* Always use queue scope for balance analysis */
+	netdev_qstats_get_req_set_scope(req, NETDEV_QSTATS_SCOPE_QUEUE);
+
+	qstats = netdev_qstats_get_dump(ys, req);
+	netdev_qstats_get_req_free(req);
+	if (!qstats) {
+		p_err("failed to get queue stats: %s", ys->err.msg);
+		ret = -1;
+		goto exit_close;
+	}
+
+	/* Count and sort queues */
+	ynl_dump_foreach(qstats, qs)
+		count++;
+
+	if (count == 0) {
+		if (json_output)
+			jsonw_start_array(json_wtr);
+		else
+			printf("No queue statistics available\n");
+		goto exit_free_qstats;
+	}
+
+	sorted = calloc(count, sizeof(*sorted));
+	if (!sorted) {
+		p_err("failed to allocate sorted array");
+		ret = -1;
+		goto exit_free_qstats;
+	}
+
+	i = 0;
+	ynl_dump_foreach(qstats, qs)
+		sorted[i++] = qs;
+
+	qsort(sorted, count, sizeof(*sorted), cmp_ifindex_type);
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+
+	/* Process each device/queue-type combination */
+	i = 0;
+	while (i < count) {
+		__u64 *rx_packets, *rx_bytes, *tx_packets, *tx_bytes;
+		enum netdev_queue_type type = sorted[i]->queue_type;
+		unsigned int ifindex = sorted[i]->ifindex;
+		unsigned int queue_count = 0;
+		char ifname[IF_NAMESIZE];
+		const char *name;
+
+		/* Count queues for this device/type */
+		for (j = i; j < count && sorted[j]->ifindex == ifindex &&
+		     sorted[j]->queue_type == type; j++)
+			queue_count++;
+
+		/* Skip if no packets/bytes (inactive queues) */
+		if (!sorted[i]->_present.rx_packets &&
+		    !sorted[i]->_present.rx_bytes &&
+		    !sorted[i]->_present.tx_packets &&
+		    !sorted[i]->_present.tx_bytes)
+			goto next_ifc;
+
+		/* Allocate arrays for statistics */
+		rx_packets = calloc(queue_count, sizeof(*rx_packets));
+		rx_bytes   = calloc(queue_count, sizeof(*rx_bytes));
+		tx_packets = calloc(queue_count, sizeof(*tx_packets));
+		tx_bytes   = calloc(queue_count, sizeof(*tx_bytes));
+
+		if (!rx_packets || !rx_bytes || !tx_packets || !tx_bytes) {
+			p_err("failed to allocate statistics arrays");
+			free(rx_packets);
+			free(rx_bytes);
+			free(tx_packets);
+			free(tx_bytes);
+			ret = -1;
+			goto exit_free_sorted;
+		}
+
+		/* Collect statistics */
+		for (j = 0; j < queue_count; j++) {
+			rx_packets[j] = sorted[i + j]->_present.rx_packets ?
+					sorted[i + j]->rx_packets : 0;
+			rx_bytes[j] = sorted[i + j]->_present.rx_bytes ?
+				      sorted[i + j]->rx_bytes : 0;
+			tx_packets[j] = sorted[i + j]->_present.tx_packets ?
+					sorted[i + j]->tx_packets : 0;
+			tx_bytes[j] = sorted[i + j]->_present.tx_bytes ?
+				      sorted[i + j]->tx_bytes : 0;
+		}
+
+		name = if_indextoname(ifindex, ifname);
+
+		if (json_output) {
+			jsonw_start_object(json_wtr);
+			if (name)
+				jsonw_string_field(json_wtr, "ifname", name);
+			jsonw_uint_field(json_wtr, "ifindex", ifindex);
+			jsonw_string_field(json_wtr, "queue-type",
+					   netdev_queue_type_str(type));
+
+			print_balance_stats_json("rx-packets", type,
+						 rx_packets, queue_count);
+			print_balance_stats_json("rx-bytes", type,
+						 rx_bytes, queue_count);
+			print_balance_stats_json("tx-packets", type,
+						 tx_packets, queue_count);
+			print_balance_stats_json("tx-bytes", type,
+						 tx_bytes, queue_count);
+
+			jsonw_end_object(json_wtr);
+		} else {
+			if (name)
+				printf("%s", name);
+			else
+				printf("ifindex:%u", ifindex);
+			printf(" %s %d queues:\n",
+			       netdev_queue_type_str(type), queue_count);
+
+			print_balance_stats("rx-packets", type,
+					    rx_packets, queue_count);
+			print_balance_stats("rx-bytes", type,
+					    rx_bytes, queue_count);
+			print_balance_stats("tx-packets", type,
+					    tx_packets, queue_count);
+			print_balance_stats("tx-bytes", type,
+					    tx_bytes, queue_count);
+			printf("\n");
+		}
+
+		free(rx_packets);
+		free(rx_bytes);
+		free(tx_packets);
+		free(tx_bytes);
+
+next_ifc:
+		i += queue_count;
+	}
+
+	if (json_output)
+		jsonw_end_array(json_wtr);
+
+exit_free_sorted:
+	free(sorted);
+exit_free_qstats:
+	netdev_qstats_get_list_free(qstats);
+exit_close:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
 static int do_help(int argc __attribute__((unused)),
 		   char **argv __attribute__((unused)))
 {
@@ -304,6 +592,7 @@ static int do_help(int argc __attribute__((unused)),
 	fprintf(stderr,
 		"Usage: %s qstats { COMMAND | help }\n"
 		"       %s qstats [ show ] [ OPTIONS ]\n"
+		"       %s qstats balance\n"
 		"\n"
 		"       OPTIONS := { scope queue | group-by { device | queue } }\n"
 		"\n"
@@ -312,14 +601,16 @@ static int do_help(int argc __attribute__((unused)),
 		"       show scope queue      - Display per-queue statistics\n"
 		"       show group-by device  - Display device-aggregated statistics (default)\n"
 		"       show group-by queue   - Display per-queue statistics\n"
+		"       balance               - Analyze traffic distribution balance.\n"
 		"",
-		bin_name, bin_name);
+		bin_name, bin_name, bin_name);
 
 	return 0;
 }
 
 static const struct cmd qstats_cmds[] = {
 	{ "show",	do_show },
+	{ "balance",	do_balance },
 	{ "help",	do_help },
 	{ 0 }
 };
-- 
2.51.1


