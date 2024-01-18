Return-Path: <netdev+bounces-64120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D92831309
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 08:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5172837F7
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73BB9474;
	Thu, 18 Jan 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="M5DeNxkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUkVX8p4"
X-Original-To: netdev@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E85B645
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562094; cv=none; b=WRRzGZaEOlhoXWLv5Z1Z5zWGmZmp+SQ1swnXsnVf3mtp1YGhrEfFWqiB2qK9/Io8bXiHXoodub2HhpBAlJWMvcmOMgd5weZajZeWYVLlRdLHTHJH9tlqSq2aGMdX3IHyefoik4bVPWj9fqakpblYvYmeLJ5cL8x1WX0+ikjogX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562094; c=relaxed/simple;
	bh=kVZ5agr0N7Xeks82aHKluWMsPnY68vxM5pgPq3ijljo=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=M6h1iKvMxh62ZbXS0Ev7Ju0lmw/XO/QpeFH0EbpGuvULa78Q+iRIhs/u7HBRqG3PE1SJ2u4RVid5KZCki7zyxnkilLrqlD7pcIH4mwjesG3nDk9kUd//T0bAuuZpA0AifjcLIphu9AxGouu1Q1deQ/0Eci4UdxpctGqUs0RhYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=M5DeNxkA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUkVX8p4; arc=none smtp.client-ip=64.147.123.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 82C3E2B00230;
	Thu, 18 Jan 2024 02:14:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Jan 2024 02:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705562091; x=
	1705565691; bh=+0cTACQquTQqkwl334i60uarQMTMfdLLzqA/4fEBfd0=; b=M
	5DeNxkASRcpoQBS+Mi9On6wglcBpr0BzalsUT/eNK9s76tLZ81yaOqup6YZxENxp
	oNKM5d2/uuN+pKoaioOuBn5kJKPlRU/dzsyYmC+lrxyE0r8hUhQnEF48oXF8pnhx
	Q4JjB1+/oAI8m8qFt1Y9g6YLkidh9rv6Oxvk5e0dqsTYSz17/4uONIlN8OUtkhHz
	2WnQK4IQPl1fr/0e8CGgLZ6uDxuVDgTChwhWVxXV2Om71yRBhKXLkMVolfvGWNU6
	WiameCu9cK2uPryW3l9W1FIDNdjVsNtqGy0d4Zgqa2fCGaBGgbZY8PFOuBIcqA6P
	ghPW4IscecUA7fAK5H1Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705562091; x=
	1705565691; bh=+0cTACQquTQqkwl334i60uarQMTMfdLLzqA/4fEBfd0=; b=d
	UkVX8p4bSL7yapC+ydLSf0JhykIx0bceOYje7026zoBkXG+jnKIzIRmR5TlJbPbX
	nrvW0f8kENt9PKbKiD8I4RLGNekahaqDhUPMD5uapziLWRLIJX/gP66krKeAToNt
	iILm8tevus9Me8Fcwtw6uxb+t1UqKyHjjsz1IX1kCfmwXtyJXJSnBPLrtxqpkQOy
	7/nAZuI++RaWWRb0ePBO2JnCtW5pJOqRbsZd7t3s1eUOZU82y4oC2jUwUbZORcQR
	HCLk8MJ7UwgjuHIxQmE7G5SH9asYsw1r6hfl1v+aVM1QqlB6E8+B8Eqb6g1fbJZW
	NrVDNJBo/6WtecoiJRVfQ==
X-ME-Sender: <xms:6s-oZfttIuKyYTiXFsqp60yEkiOw_cyhOcWFXnkbBn3-NZ5fzXrRqQ>
    <xme:6s-oZQdy0oziQDOzvQh-8yBeYJ1-BXNR9eKhRYXyiRad9ajFNCYUO8zvOKEHbRTJe
    jFdojYPAWwOTWQO05g>
X-ME-Received: <xmr:6s-oZSwv4S8mlbv-DM1vaz_vHP2BCHjRK8E0nYSLl6Hz73jvsS15aisPqEzDS4_eP1_9ShqptC-kVahpLM6Z6D5MdVy3o0ucC0O2bKVd8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgv
    nhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrg
    htthgvrhhnpefgjedvhefgtddugffhgfehhfffieelffehjeefueetfeefieffvdejkeeg
    tdefffenucffohhmrghinhepnhhrpghmrghpshdrihgupdhnrhgpmhgrphhsrdhinhhfoh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehquggv
    sehnrggttgihrdguvg
X-ME-Proxy: <xmx:6s-oZeMJtpyugeOCCgIQx4tzKCno0vCcPD3TYE5hTTYFt81DyPBT1Q>
    <xmx:6s-oZf_r63kvRJ0hahzMsm9an2e2gaOWAsGcGcOhQv8cXPQYYJVRBw>
    <xmx:6s-oZeUxdRFaQsmtWoMgCICvYSGAK5oIHby7--M1LTFT_xLX2Ivd7w>
    <xmx:6s-oZanFH7JVI1DPjgn1YSoPIP-fvrsQCnc03-OBNWofvBMEos-XQWStjuQ>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 02:14:49 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>,
	kernel-team@meta.com
Subject: [RFC iproute2 v6 2/3] ss: pretty-print BPF socket-local storage
Date: Thu, 18 Jan 2024 04:15:11 +0100
Message-ID: <20240118031512.298971-3-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118031512.298971-1-qde@naccy.de>
References: <20240118031512.298971-1-qde@naccy.de>
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

COL_SKSTOR's header is replaced with an empty string, as it doesn't need to
be printed anymore; it's used as a "virtual" column to refer to the
socket-local storage dump, which will be printed under the socket information.
The column's width is fixed to 1, so it doesn't mess up ss' output
(expect if --oneline is used).

ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
in which case each socket containing BPF local storage will be followed by
the content of the storage before the next socket's info is displayed.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 misc/ss.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 144 insertions(+), 12 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index fe0e966b..9ba7d846 100644
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
@@ -1215,6 +1225,13 @@ static void render_calc_width(void)
 		 */
 		c->width = min(c->width, screen_width);

+		/* When printing BPF socket-local storage (without --oneline),
+		 * set the BPF output column width to prevent ss from reserving
+		 * space for it and messing up its output as the BPF data is not
+		 * printed on the same line. */
+		if (c == &columns[COL_SKSTOR] && !oneline)
+			c->width = 1;
+
 		if (c->width)
 			first = 0;
 	}
@@ -3398,6 +3415,9 @@ static struct bpf_map_opts {
 	struct bpf_sk_storage_map_info {
 		unsigned int id;
 		int fd;
+		struct bpf_map_info info;
+		struct btf *btf;
+		struct btf_dump *dump;
 	} maps[MAX_NR_BPF_MAP_ID_OPTS];
 	bool show_all;
 } bpf_map_opts;
@@ -3408,10 +3428,36 @@ static void bpf_map_opts_mixed_error(void)
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

@@ -3447,8 +3493,25 @@ static int bpf_map_opts_load_info(unsigned int map_id)
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
@@ -3500,8 +3563,11 @@ static void bpf_map_opts_destroy(void)
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
@@ -3552,10 +3618,73 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
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
+	out(" map_id: %d ", info->id);
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
+	out("\n\tmap_id: %d [\n", info->id);
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
@@ -3567,8 +3696,11 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 			(struct rtattr *)bpf_stg);

 		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
-			out("map_id:%u ",
-				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
+			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
+
+			out_bpf_sk_storage(map_id, RTA_DATA(value),
+				RTA_PAYLOAD(value));
 		}
 	}
 }
--
2.43.0


