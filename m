Return-Path: <netdev+bounces-63279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8CF82C16B
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBC01F224E0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE936DCE1;
	Fri, 12 Jan 2024 14:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 2.mo547.mail-out.ovh.net (2.mo547.mail-out.ovh.net [46.105.35.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F606D1D6
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=naccy.de
Received: from ex4.mail.ovh.net (unknown [10.108.9.49])
	by mo547.mail-out.ovh.net (Postfix) with ESMTPS id 210902160D;
	Fri, 12 Jan 2024 14:00:13 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (130.93.52.54) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 15:00:12 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>, <kernel-team@meta.com>
Subject: [PATCH v4 2/3] ss: pretty-print BPF socket-local storage
Date: Fri, 12 Jan 2024 15:04:28 +0100
Message-ID: <20240112140429.183344-3-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140429.183344-1-qde@naccy.de>
References: <20240112140429.183344-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS13.indiv4.local (172.16.1.13) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 5038683562103926524
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnheptdehffefgeevleejudehkeeigeegheeffefhleettdehtdehffduffduleetvedtnecuffhomhgrihhnpehnrhgpmhgrphhsrdhiugdpnhhrpghmrghpshdrihhnfhhonecukfhppeduvdejrddtrddtrddupddufedtrdelfedrhedvrdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdhkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdpoffvtefjohhsthepmhhoheegjedpmhhouggvpehsmhhtphhouhht

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

COL_SKSTOR's header is replaced with an empty string, as it doesn't need to
be printed anymore; it's used as a "virtual" column to refer to the
socket-local storage dump, which will be printed under the socket information.
The column's width is fixed to 1, so it doesn't mess up ss' output.

ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
in which case each socket containing BPF local storage will be followed by
the content of the storage before the next socket's info is displayed.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 misc/ss.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 12 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index f38e4744..38e2ba6c 100644
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
@@ -136,7 +138,7 @@ static struct column columns[] = {
 	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
-	{ ALIGN_LEFT,	"Socket storage",	"",	1, 0, 0 },
+	{ ALIGN_LEFT,	"",			"",	1, 0, 0 },
 	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
 };
 
@@ -1041,11 +1043,10 @@ static int buf_update(int len)
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
 
@@ -1056,18 +1057,27 @@ static void out(const char *fmt, ...)
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
@@ -1215,6 +1225,9 @@ static void render_calc_width(void)
 		 */
 		c->width = min(c->width, screen_width);
 
+		if (c == &columns[COL_SKSTOR])
+			c->width = 1;
+
 		if (c->width)
 			first = 0;
 	}
@@ -3396,6 +3409,9 @@ static struct bpf_map_opts {
 	struct bpf_sk_storage_map_info {
 		unsigned int id;
 		int fd;
+		struct bpf_map_info info;
+		struct btf *btf;
+		struct btf_dump *dump;
 	} maps[MAX_NR_BPF_MAP_ID_OPTS];
 	bool show_all;
 } bpf_map_opts;
@@ -3406,10 +3422,27 @@ static void bpf_map_opts_mixed_error(void)
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
 static int bpf_map_opts_load_info(unsigned int map_id)
 {
 	struct bpf_map_info info = {};
 	uint32_t len = sizeof(info);
+	struct btf *btf;
 	int fd;
 	int r;
 
@@ -3445,8 +3478,16 @@ static int bpf_map_opts_load_info(unsigned int map_id)
 		return -1;
 	}
 
+	r = bpf_maps_opts_load_btf(&info, &btf);
+	if (r) {
+		close(fd);
+		return -1;
+	}
+
 	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = map_id;
-	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;
 
 	return 0;
 }
@@ -3469,6 +3510,29 @@ static struct bpf_sk_storage_map_info *bpf_map_opts_get_info(
 	return &bpf_map_opts.maps[bpf_map_opts.nr_maps - 1];
 }
 
+static void out_bpf_sk_storage_print_fn(void *ctx, const char *fmt, va_list args)
+{
+	vout(fmt, args);
+}
+
+static struct btf_dump *bpf_map_opts_get_btf_dump(
+	struct bpf_sk_storage_map_info *map_info)
+{
+	struct btf_dump_opts dopts = {
+		.sz = sizeof(struct btf_dump_opts)
+	};
+
+	if (!map_info->dump) {
+		map_info->dump = btf_dump__new(map_info->btf,
+					       out_bpf_sk_storage_print_fn,
+					       NULL, &dopts);
+		if (!map_info->dump)
+			fprintf(stderr, "Failed to create btf_dump object\n");
+	}
+
+	return map_info->dump;
+}
+
 static int bpf_map_opts_add_id(const char *optarg)
 {
 	size_t optarg_len;
@@ -3498,8 +3562,11 @@ static void bpf_map_opts_destroy(void)
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
@@ -3538,10 +3605,54 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
 	return stgs_rta;
 }
 
+#define SK_STORAGE_INDENT_STR "    "
+
+static void out_bpf_sk_storage(int map_id, const void *data, size_t len)
+{
+	uint32_t type_id;
+	struct bpf_sk_storage_map_info *map_info;
+	struct btf_dump *dump;
+	struct btf_dump_type_data_opts opts = {
+		.sz = sizeof(struct btf_dump_type_data_opts),
+		.indent_str = SK_STORAGE_INDENT_STR,
+		.indent_level = 2,
+		.emit_zeroes = 1
+	};
+	int r;
+
+	map_info = bpf_map_opts_get_info(map_id);
+	if (!map_info) {
+		/* The kernel might return a map we can't get info for, skip
+		 * it but print the other ones. */
+		out(SK_STORAGE_INDENT_STR "map_id: %d failed to fetch info, skipping\n",
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
+	type_id = map_info->info.btf_value_type_id;
+
+	dump = bpf_map_opts_get_btf_dump(map_info);
+	if (!dump)
+		return;
+
+	out(SK_STORAGE_INDENT_STR "map_id: %d [\n", map_id);
+	r = btf_dump__dump_type_data(dump, type_id, data, len, &opts);
+	if (r < 0)
+		out(SK_STORAGE_INDENT_STR SK_STORAGE_INDENT_STR "failed to dump data: %d", r);
+	out("\n" SK_STORAGE_INDENT_STR "]");
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
@@ -3553,8 +3664,13 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 			(struct rtattr *)bpf_stg);
 
 		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
-			out("map_id:%u ",
-				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+			out("\n");
+
+			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
+			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
+
+			out_bpf_sk_storage(map_id, RTA_DATA(value),
+				RTA_PAYLOAD(value));
 		}
 	}
 }
@@ -5982,6 +6098,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (oneline && bpf_map_opts_is_enabled()) {
+		fprintf(stderr, "ss: --oneline, --bpf-maps, and --bpf-map-id are incompatible\n");
+		exit(-1);
+	}
+
 	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
 		user_ent_hash_build();
 
-- 
2.43.0


