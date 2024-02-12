Return-Path: <netdev+bounces-70999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451B851856
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2AC7B2145E
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D73C6A6;
	Mon, 12 Feb 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="tandMsPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLVwQ2MY"
X-Original-To: netdev@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0B3CF62
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752630; cv=none; b=JoqajEMttXJue4thfN6xybfuybeuhaR9lG3QgECNdSYPoP7ClPBGBJcU18h1dGdokVxW+icShOr4sIdHnHE1tqXvAq0xSdX6loI0OHppeLfRH1+EubT0WzPz54m/49BCj20Jo4VpPDmtMwRBkPSJ6zXa3WVlC0BpBcz5NMYECqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752630; c=relaxed/simple;
	bh=omO/y7Min3t3drXGTjkU8ivRM1Gj7ToXSJLuvHe7OQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7soIR7sbrMbryDokoSlZXAi2HgQlmaUjBmBACI+JZ+inF4xcJwTKt/Iw3FI+vKHa4ajlyxXUeLe6sqE2JICjiJYFL5DP4rC1qHUs5KtF/tOIJ0qiV/EIPGK1UYkLjt/f9ILZENc6rMUj0ouNYrBgSkOvNVwQFxH+le2JbFRWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=tandMsPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLVwQ2MY; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.west.internal (Postfix) with ESMTP id A5C322CC0468;
	Mon, 12 Feb 2024 10:43:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 12 Feb 2024 10:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707752626; x=
	1707756226; bh=tFNsDEhQ57EVClFgdSKVMQSx6jeGAta1H7vo9rDP8Y8=; b=t
	andMsPB/6pru/uCAP/4mJuADeK7r4MTwzWdvWIc/NZ8y15MBLdyffoZ9fXgAz/NN
	ytjwDQUIeclMfwhggqpkcwb87Wl4xFlsUAF+lFzpNxHd6eB8/Y1bPdrwWIMW6vZw
	QFibRsYynUelyMSc2aHHNyeTGtQBHNgKqat7QdYmgSzsluzZBsjOnA6z1uxvHxEL
	8+egTkTTO7RnDc/nbLhjZ9EB1zSLAj/3V5IyuRoAhB3wgvMqnMhRPw0eaLxvSYlj
	q1y2QeuTeQZmKlt/cXLFlPWPrdtfYX7iGi5PbFan75Kuo7pGwGuEH3Ceg4jJzQ45
	VAExJLhsSt34C35DA+uEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707752626; x=
	1707756226; bh=tFNsDEhQ57EVClFgdSKVMQSx6jeGAta1H7vo9rDP8Y8=; b=R
	LVwQ2MYVvX/uAzKK1jG1oMIavDKqA923fbYqzGduKrrcVqDacQQvyv+qmb0mLlwy
	A0hn+8aCltyTNblF/zSBb3aulkTxP8FOv4//Ga7Ua1JXEIoAcvlW2x1tLU4IR86v
	mw9atSWwiIPYMUgHpUp3d9pXW7HXO4mFWIm63vjoZ55aav1Y1c7gORienECL8bJv
	4+bmgXfgXLSKdntgY9HVdpr++nRJCQ+xs0qnFJp7SWdGYGIAI74dQO/WMCflZiOR
	WgOJwtFEFliEyhqK3i/8OUWcYpT+VHdr9oMLRtlytpfZEzmm6kcMZGNRbb+BY130
	EhSodeISL8Hjkf5dl6gWw==
X-ME-Sender: <xms:sTzKZZ9mafqgAuWIWZM-50Lmuj4jDutHjqSFiD6W53ImdcNkGm2Cww>
    <xme:sTzKZdunnRU4oLQR6inECEvAD1zw-tKtwjoynzIVrdyB5_M6axDQDbxDcDGY_BSZR
    re6RD11C5Q9TQTexw0>
X-ME-Received: <xmr:sTzKZXCSM3g2QIeLxweT-QpYoMUK1ZmPIkgquh0aXYi63zUO8LOy-Y-3Cc7VIDlkElu5pVkXGWaFHkjyzAqKljMaff8vzzjJSmzY0to>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpefgjedvhefgtddugffhgfehhfffieelffehjeefueetfeefieffvdejkeegtdef
    ffenucffohhmrghinhepnhhrpghmrghpshdrihgupdhnrhgpmhgrphhsrdhinhhfohenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehquggvsehn
    rggttgihrdguvg
X-ME-Proxy: <xmx:sTzKZddlqecHHotDK_5EcD3Qmb_EUcQ8D5MD97_rFOGS3qfonZuicw>
    <xmx:sTzKZeNKF2WNA5mFv_EWtz6-_UmmHe43Ax8Gf20GLzDz21P83pLrjw>
    <xmx:sTzKZflwXVzSb8Mvn74EsU0llX3ABGC0MFewpXj5GH73LjXh2ES5rQ>
    <xmx:sjzKZaCxCTOvzvklo-WYz3R4ijOgYbnoMW5kIoQgR1s8tKs9y5T3eT367ki2ta9X>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 10:43:44 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v7 2/3] ss: pretty-print BPF socket-local storage
Date: Mon, 12 Feb 2024 16:43:30 +0100
Message-ID: <20240212154331.19460-3-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212154331.19460-1-qde@naccy.de>
References: <20240212154331.19460-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ss is able to print the map ID(s) for which a given socket has BPF
socket-local storage defined (using --bpf-maps or --bpf-map-id=). However,
the actual content of the map remains hidden.

This change aims to pretty-print the socket-local storage content following
the socket details, similar to what `bpftool map dump` would do. The exact
output format is inspired by drgn, while the BTF data processing is similar
to bpftool's.

ss will use libbpf's btf_dump__dump_type_data() to ease pretty-printing
of binary data. This requires out_bpf_sk_storage_print_fn() as a print
callback function used by btf_dump__dump_type_data(). vout() is also
introduced, which is similar to out() but accepts a va_list as
parameter.

ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
in which case each socket containing BPF local storage will be followed by
the content of the storage before the next socket's info is displayed.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 misc/ss.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 136 insertions(+), 11 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 19de107f..b9a2f8d5 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -53,7 +53,9 @@
 
 #ifdef HAVE_LIBBPF
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include <linux/btf.h>
 #endif
 
 #if HAVE_RPC
@@ -1039,11 +1041,10 @@ static int buf_update(int len)
 }
 
 /* Append content to buffer as part of the current field */
-__attribute__((format(printf, 1, 2)))
-static void out(const char *fmt, ...)
+static void vout(const char *fmt, va_list args)
 {
 	struct column *f = current_field;
-	va_list args;
+	va_list _args;
 	char *pos;
 	int len;
 
@@ -1054,18 +1055,27 @@ static void out(const char *fmt, ...)
 		buffer.head = buf_chunk_new();
 
 again:	/* Append to buffer: if we have a new chunk, print again */
+	va_copy(_args, args);
 
 	pos = buffer.cur->data + buffer.cur->len;
-	va_start(args, fmt);
 
 	/* Limit to tail room. If we hit the limit, buf_update() will tell us */
-	len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, args);
-	va_end(args);
+	len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, _args);
 
 	if (buf_update(len))
 		goto again;
 }
 
+__attribute__((format(printf, 1, 2)))
+static void out(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vout(fmt, args);
+	va_end(args);
+}
+
 static int print_left_spacing(struct column *f, int stored, int printed)
 {
 	int s;
@@ -3396,6 +3406,9 @@ static struct bpf_map_opts {
 	struct bpf_sk_storage_map_info {
 		unsigned int id;
 		int fd;
+		struct bpf_map_info info;
+		struct btf *btf;
+		struct btf_dump *dump;
 	} maps[MAX_NR_BPF_MAP_ID_OPTS];
 	bool show_all;
 } bpf_map_opts;
@@ -3406,10 +3419,36 @@ static void bpf_map_opts_mixed_error(void)
 		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
 }
 
+static int bpf_maps_opts_load_btf(struct bpf_map_info *info, struct btf **btf)
+{
+	if (info->btf_value_type_id) {
+		*btf = btf__load_from_kernel_by_id(info->btf_id);
+		if (!*btf) {
+			fprintf(stderr, "ss: failed to load BTF for map ID %u\n",
+				info->id);
+			return -1;
+		}
+	} else {
+		*btf = NULL;
+	}
+
+	return 0;
+}
+
+static void out_bpf_sk_storage_print_fn(void *ctx, const char *fmt, va_list args)
+{
+	vout(fmt, args);
+}
+
 static int bpf_map_opts_load_info(unsigned int map_id)
 {
+	struct btf_dump_opts dopts = {
+		.sz = sizeof(struct btf_dump_opts)
+	};
 	struct bpf_map_info info = {};
 	uint32_t len = sizeof(info);
+	struct btf_dump *dump;
+	struct btf *btf;
 	int fd;
 	int r;
 
@@ -3445,8 +3484,25 @@ static int bpf_map_opts_load_info(unsigned int map_id)
 		return -1;
 	}
 
+	r = bpf_maps_opts_load_btf(&info, &btf);
+	if (r) {
+		close(fd);
+		return -1;
+	}
+
+	dump = btf_dump__new(btf, out_bpf_sk_storage_print_fn, NULL, &dopts);
+	if (!dump) {
+		btf__free(btf);
+		close(fd);
+		fprintf(stderr, "Failed to create btf_dump object\n");
+		return -1;
+	}
+
 	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = map_id;
-	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].btf = btf;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps++].dump = dump;
 
 	return 0;
 }
@@ -3498,8 +3554,11 @@ static void bpf_map_opts_destroy(void)
 {
 	int i;
 
-	for (i = 0; i < bpf_map_opts.nr_maps; ++i)
+	for (i = 0; i < bpf_map_opts.nr_maps; ++i) {
+		btf_dump__free(bpf_map_opts.maps[i].dump);
+		btf__free(bpf_map_opts.maps[i].btf);
 		close(bpf_map_opts.maps[i].fd);
+	}
 }
 
 static struct rtattr *bpf_map_opts_alloc_rta(void)
@@ -3550,10 +3609,73 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
 	return stgs_rta;
 }
 
+static void out_bpf_sk_storage_oneline(struct bpf_sk_storage_map_info *info,
+	const void *data, size_t len)
+{
+	struct btf_dump_type_data_opts opts = {
+		.sz = sizeof(struct btf_dump_type_data_opts),
+		.emit_zeroes = 1,
+		.compact = 1
+	};
+	int r;
+
+	out(" map_id:%d", info->id);
+	r = btf_dump__dump_type_data(info->dump, info->info.btf_value_type_id,
+				     data, len, &opts);
+	if (r < 0)
+		out("failed to dump data: %d", r);
+}
+
+static void out_bpf_sk_storage_multiline(struct bpf_sk_storage_map_info *info,
+	const void *data, size_t len)
+{
+	struct btf_dump_type_data_opts opts = {
+		.sz = sizeof(struct btf_dump_type_data_opts),
+		.indent_level = 2,
+		.emit_zeroes = 1
+	};
+	int r;
+
+	out("\n\tmap_id:%d [\n", info->id);
+
+	r = btf_dump__dump_type_data(info->dump, info->info.btf_value_type_id,
+				     data, len, &opts);
+	if (r < 0)
+		out("\t\tfailed to dump data: %d", r);
+
+	out("\n\t]");
+}
+
+static void out_bpf_sk_storage(int map_id, const void *data, size_t len)
+{
+	struct bpf_sk_storage_map_info *map_info;
+
+	map_info = bpf_map_opts_get_info(map_id);
+	if (!map_info) {
+		/* The kernel might return a map we can't get info for, skip
+		 * it but print the other ones. */
+		out("\n\tmap_id: %d failed to fetch info, skipping\n",
+		    map_id);
+		return;
+	}
+
+	if (map_info->info.value_size != len) {
+		fprintf(stderr, "map_id: %d: invalid value size, expecting %u, got %lu\n",
+			map_id, map_info->info.value_size, len);
+		return;
+	}
+
+	if (oneline)
+		out_bpf_sk_storage_oneline(map_info, data, len);
+	else
+		out_bpf_sk_storage_multiline(map_info, data, len);
+}
+
 static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 {
 	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX + 1], *bpf_stg;
-	unsigned int rem;
+	unsigned int rem, map_id;
+	struct rtattr *value;
 
 	for (bpf_stg = RTA_DATA(bpf_stgs), rem = RTA_PAYLOAD(bpf_stgs);
 		RTA_OK(bpf_stg, rem); bpf_stg = RTA_NEXT(bpf_stg, rem)) {
@@ -3565,8 +3687,11 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 			(struct rtattr *)bpf_stg);
 
 		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
-			out(" map_id:%u",
-				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
+			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
+
+			out_bpf_sk_storage(map_id, RTA_DATA(value),
+					   RTA_PAYLOAD(value));
 		}
 	}
 }
-- 
2.43.0


