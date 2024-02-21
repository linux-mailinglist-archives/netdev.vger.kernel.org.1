Return-Path: <netdev+bounces-73731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56F85E0BF
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35152286F16
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D680028;
	Wed, 21 Feb 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="qklEtnF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmZXeTGG"
X-Original-To: netdev@vger.kernel.org
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E78004B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528607; cv=none; b=KKdHDrqUCG3PPNRi5EpJLCCmBxdR2eHGE3UTE3pcwrC2ZPA5vBJY2z9HtVhe0SyjVjMl3V3tvFMyExN8zolnsczI09dZwXuV35UeXi4uZ47DGIOPkWJKkaQXjtPwJVRW8hjy2jXqAOGLF/MFKkChQ7zm5BQ2urO+PN+CBddOI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528607; c=relaxed/simple;
	bh=nNC1CuqU0Vf9Yb1nKijl2/wFsY/bV+q31cYkt/lvwBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbiQZxIuYMMzQ8g7u23NyUo27Azw+NG5x/hs3SWiFE2tXkXZQYLnB85cG0Ph0BW4IFa5OB4E+Gyb6EOBq9Gaqu6OwcaFBe4o/uIp5bSJ09yMRAoZxv2HMnnkxQNigbr99HAdR3lWKNH8zIPQg+r4BIedFcOSjPdXOYOFu/F/rwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=qklEtnF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmZXeTGG; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id CCA8A2CC02C4;
	Wed, 21 Feb 2024 10:16:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 21 Feb 2024 10:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1708528603; x=
	1708532203; bh=2Aw6jw8KxtiDrkMsqPO8gEYqEyy5KVjwEHI5hnp3DTw=; b=q
	klEtnF0ecfGTpp0jcFJjvfzQFR+j78kx1JEde/6ZcnyYfRQQAUiRsUM2+2ggQh0L
	7DQbhO54ZhduwIk1SmwkKcGrjr/wbT91iB5eUdqlUUFT1ioNaVugAtoA6Zg5hiS7
	CNDlAcHo1KzpNOAdv+BzxiIZbtdb/p72RBXDcKxVRW47XolDS2OCxNRMavhnpV8J
	n+HNKHC0eIIVEDA0teEBIfX+SJ0MTbkwP6WygOMUH3VCyup+KDTLuFBcq4Le2yNZ
	ZiWJSF+VpJ8eEUSQc1iqFG6r5yHokNeJ91XwUrJBBFM5AwVa8hjm34viqNkKTdiu
	JUpX+00IlzNEI+GIpzkZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708528603; x=
	1708532203; bh=2Aw6jw8KxtiDrkMsqPO8gEYqEyy5KVjwEHI5hnp3DTw=; b=k
	mZXeTGG2SfM2uqXcb9e3cYCxyiwesHMCBrxwrCKwSqrBTy8/JEgOPxLMg7kgDm6r
	RPHCf1+Kwer7VhVOWi0nIx0QVRlJw+dLHHU05bS/G23peu1NLCR16/Hd3wiCYnc5
	rEDIEuJ+DTrtRqjB224eYAFnmIW1SQ0XMdr9G6elPlQJZJmZ8V+tOHswJre93kkm
	8y2bbESfqjdjRac5Uu2HSBBwGbRlEZYIclrvGRsBZnnSzaGHiQ9/TgXnmpyWfpxK
	Tyds5xI2ViiFjvHy56NeKuI++Qd+sfjUndD0xf2NW16QVt92QSPWBY4pDc2Yalr4
	XUW8uh37nbGrjcp3pSqKA==
X-ME-Sender: <xms:2hPWZSGWI9TMxQLVo1zMBdbGexarLg_yctr_kLUpM7e_KEmAf3FJAg>
    <xme:2hPWZTWuaphf9FJ4F3635UtDdoXc6LqiiQal64JCpHUzTL88IHMsuuwL3TlmAiClg
    NKudWJH7a8mT_vM3AE>
X-ME-Received: <xmr:2hPWZcIiLES1rW8b38EZXHQfdwQf6W8v8h_PBlZ2ozrqoclhXCIdsJ7EKOMA2vUUShEXN5hHpPlBilrsnNK1MjppqwF3JSs64RqkIN6-2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpefgjedvhefgtddugffhgfehhfffieelffehjeefueetfeefieffvdejkeegtdef
    ffenucffohhmrghinhepnhhrpghmrghpshdrihgupdhnrhgpmhgrphhsrdhinhhfohenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehquggvsehn
    rggttgihrdguvg
X-ME-Proxy: <xmx:2hPWZcGEwDn4PlALUKNS7PVYIXEVLYu74G5IDKCYp2XX6iaiu9wIDg>
    <xmx:2hPWZYWwbYooZRJPgOOryL0G4gEdbuFQ8ixkO_JjU0owJyNmV_s8qA>
    <xmx:2hPWZfNCzg6kL10CDywUkZ5mUqRJL_G1KisCn3-8YLLNPFutERy24A>
    <xmx:2xPWZaLFljZHmytLwKQfaPkIrkK4z2SLL9XNVoeyWX7yFrS_E2Ia9gQ5Xr5HMLnG>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 10:16:41 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v9 2/3] ss: pretty-print BPF socket-local storage
Date: Wed, 21 Feb 2024 16:16:20 +0100
Message-ID: <20240221151621.166623-3-qde@naccy.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240221151621.166623-1-qde@naccy.de>
References: <20240221151621.166623-1-qde@naccy.de>
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
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 misc/ss.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 137 insertions(+), 11 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 8924b2bf..ea0b3702 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -61,7 +61,9 @@
 #define ENABLE_BPF_SKSTORAGE_SUPPORT
 
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include <linux/btf.h>
 
 #if (LIBBPF_MAJOR_VERSION == 0) && (LIBBPF_MINOR_VERSION < 5)
 #warning "libbpf version 0.5 or later is required, disabling BPF socket-local storage support"
@@ -1052,11 +1054,10 @@ static int buf_update(int len)
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
 
@@ -1067,18 +1068,27 @@ static void out(const char *fmt, ...)
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
@@ -3409,6 +3419,9 @@ static struct bpf_map_opts {
 	struct bpf_sk_storage_map_info {
 		unsigned int id;
 		int fd;
+		struct bpf_map_info info;
+		struct btf *btf;
+		struct btf_dump *dump;
 	} maps[MAX_NR_BPF_MAP_ID_OPTS];
 	bool show_all;
 } bpf_map_opts;
@@ -3419,10 +3432,36 @@ static void bpf_map_opts_mixed_error(void)
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
 
@@ -3460,8 +3499,25 @@ static int bpf_map_opts_load_info(unsigned int map_id)
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
@@ -3513,8 +3569,11 @@ static void bpf_map_opts_destroy(void)
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
@@ -3567,10 +3626,74 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
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
+		 * it but print the other ones.
+		 */
+		out("\n\tmap_id: %d failed to fetch info, skipping\n", map_id);
+		return;
+	}
+
+	if (map_info->info.value_size != len) {
+		fprintf(stderr,
+			"map_id: %d: invalid value size, expecting %u, got %lu\n",
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
@@ -3582,8 +3705,11 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 				    (struct rtattr *)bpf_stg);
 
 		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
-			out(" map_id:%u",
-			    rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
+			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
+
+			out_bpf_sk_storage(map_id, RTA_DATA(value),
+					   RTA_PAYLOAD(value));
 		}
 	}
 }
-- 
2.43.1


