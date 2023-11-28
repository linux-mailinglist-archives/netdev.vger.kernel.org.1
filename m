Return-Path: <netdev+bounces-51567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D75B7FB310
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1286D1F20EE1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60FD13AF5;
	Tue, 28 Nov 2023 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 12603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 23:45:25 PST
Received: from 7.mo547.mail-out.ovh.net (7.mo547.mail-out.ovh.net [46.105.53.191])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDBD4D
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:45:25 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.109.143.210])
	by mo547.mail-out.ovh.net (Postfix) with ESMTPS id 4139920245;
	Tue, 28 Nov 2023 02:35:38 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (92.184.96.55) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 Nov 2023 03:32:15 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH 3/3] ss: pretty-print BPF socket-local storage
Date: Mon, 27 Nov 2023 18:30:58 -0800
Message-ID: <20231128023058.53546-4-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128023058.53546-1-qde@naccy.de>
References: <20231128023058.53546-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS12.indiv4.local (172.16.1.12) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 5907033864805805736
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeivddggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnheptdehffefgeevleejudehkeeigeegheeffefhleettdehtdehffduffduleetvedtnecuffhomhgrihhnpehnrhgpmhgrphhsrdhiugdpnhhrpghmrghpshdrihhnfhhonecukfhppeduvdejrddtrddtrddupdelvddrudekgedrleeirdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehgeejpdhmohguvgepshhmthhpohhuth

ss is able to print the map ID(s) for which a given socket has BPF
socket-local storage defined (using --bpf-maps or --bpf-map-id=). However,
the actual content of the map remains hidden.

This change aims to pretty-print the socket-local storage content following
the socket details, similar to what `bpftool map dump` would do. The exact
output format is inspired by drgn, while the BTF data processing is similar
to bpftool's.

ss will print the map's content in a best-effort fashion: BTF types that can
be printed will be displayed, while types that are not yet supported
(e.g. BTF_KIND_VAR) will be replaced by a placeholder. For readability
reasons, the --oneline option is not compatible with this change.

The new out_prefix_t type is introduced to ease the printing of compound
types (e.g. structs, unions), it defines the prefix to print before the actual
value to ensure the output is properly indented. COL_SKSTOR's header is
replaced with an empty string, as it doesn't need to be printed anymore;
it's used as a "virtual" column to refer to the socket-local storage dump,
which will be printed under the socket information. The column's width is
fixed to 1, so it doesn't mess up ss' output.

ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
in which case each socket containing BPF local storage will be followed by
the content of the storage before the next socket's info is displayed.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 misc/ss.c | 558 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 551 insertions(+), 7 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 5b255ce3..545e5475 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -51,8 +51,13 @@
 #include <linux/tls.h>
 #include <linux/mptcp.h>
 
+#ifdef HAVE_LIBBPF
+#include <linux/btf.h>
+#endif
+
 #ifdef HAVE_LIBBPF
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #endif
 
@@ -136,7 +141,7 @@ static struct column columns[] = {
 	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
-	{ ALIGN_LEFT,	"Socket storage",	"",	1, 0, 0 },
+	{ ALIGN_LEFT,	"",			"",	1, 0, 0 },
 	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
 };
 
@@ -1212,6 +1217,9 @@ static void render_calc_width(void)
 		 */
 		c->width = min(c->width, screen_width);
 
+		if (c == &columns[COL_SKSTOR])
+			c->width = 1;
+
 		if (c->width)
 			first = 0;
 	}
@@ -3386,6 +3394,8 @@ static struct bpf_map_opts {
 	struct bpf_sk_storage_map_info {
 		unsigned int id;
 		int fd;
+		struct bpf_map_info info;
+		struct btf *btf;
 	} maps[MAX_NR_BPF_MAP_ID_OPTS];
 	bool show_all;
 	struct btf *kernel_btf;
@@ -3397,6 +3407,32 @@ static void bpf_map_opts_mixed_error(void)
 		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
 }
 
+static int bpf_maps_opts_load_btf(struct bpf_map_info *info, struct btf **btf)
+{
+	if (info->btf_vmlinux_value_type_id) {
+		if (!bpf_map_opts.kernel_btf) {
+			bpf_map_opts.kernel_btf = libbpf_find_kernel_btf();
+			if (!bpf_map_opts.kernel_btf) {
+				fprintf(stderr, "ss: failed to load kernel BTF\n");
+				return -1;
+			}
+		}
+
+		*btf = bpf_map_opts.kernel_btf;
+	} else if (info->btf_value_type_id) {
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
 static int bpf_map_opts_add_all(void)
 {
 	unsigned int i;
@@ -3412,6 +3448,7 @@ static int bpf_map_opts_add_all(void)
 	while (1) {
 		struct bpf_map_info info = {};
 		uint32_t len = sizeof(info);
+		struct btf *btf;
 
 		r = bpf_map_get_next_id(id, &id);
 		if (r) {
@@ -3450,8 +3487,18 @@ static int bpf_map_opts_add_all(void)
 			continue;
 		}
 
+		r = bpf_maps_opts_load_btf(&info, &btf);
+		if (r) {
+			fprintf(stderr, "ss: failed to get BTF data for BPF map ID: %u\n",
+				id);
+			close(fd);
+			goto err;
+		}
+
 		bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
-		bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+		bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
+		bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
+		bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;
 	}
 
 	bpf_map_opts.show_all = true;
@@ -3470,6 +3517,7 @@ static int bpf_map_opts_add_id(const char *optarg)
 	struct bpf_map_info info = {};
 	uint32_t len = sizeof(info);
 	size_t optarg_len;
+	struct btf *btf;
 	unsigned long id;
 	unsigned int i;
 	char *end;
@@ -3521,12 +3569,34 @@ static int bpf_map_opts_add_id(const char *optarg)
 		return -1;
 	}
 
+	r = bpf_maps_opts_load_btf(&info, &btf);
+	if (r) {
+		fprintf(stderr, "ss: failed to get BTF data for BPF map ID: %lu\n",
+			id);
+		return -1;
+	}
+
 	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
-	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;
 
 	return 0;
 }
 
+static const struct bpf_sk_storage_map_info *bpf_map_opts_get_info(
+	unsigned int map_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < bpf_map_opts.nr_maps; ++i) {
+		if (bpf_map_opts.maps[i].id == map_id)
+			return &bpf_map_opts.maps[i];
+	}
+
+	return NULL;
+}
+
 static inline bool bpf_map_opts_is_enabled(void)
 {
 	return bpf_map_opts.nr_maps;
@@ -3568,10 +3638,472 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
 	return stgs_rta;
 }
 
+#define OUT_PREFIX_LEN 65
+
+/* Print a prefixed formatted string. Used to dump BPF socket-local storage
+ * nested structures properly. */
+#define OUT_P(p, fmt, ...) out("%s" fmt, *(p), ##__VA_ARGS__)
+
+typedef char(out_prefix_t)[OUT_PREFIX_LEN];
+
+static void out_prefix_push(out_prefix_t *prefix)
+{
+	size_t len = strlen(*prefix);
+
+	if (len + 5 > OUT_PREFIX_LEN)
+		return;
+
+	strncpy(&(*prefix)[len], "    ", 5);
+}
+
+static void out_prefix_pop(out_prefix_t *prefix)
+{
+	size_t len = strlen(*prefix);
+
+	if (len < 4)
+		return;
+
+	(*prefix)[len - 4] = '\0';
+}
+
+static inline const char *btf_typename_or_fallback(const struct btf *btf,
+	unsigned int name_off)
+{
+	static const char *fallback = "<invalid name_off>";
+	static const char *anon = "<anon>";
+	const char *typename;
+
+	typename = btf__name_by_offset(btf, name_off);
+	if (!typename)
+		return fallback;
+
+	if (strcmp(typename, "") == 0)
+		return anon;
+
+	return typename;
+}
+
+static void out_btf_int128(const struct btf *btf, const struct btf_type *type,
+	const void *data, out_prefix_t *prefix)
+{
+	uint64_t high, low;
+	const char *typename;
+
+#ifdef __BIG_ENDIAN_BITFIELD
+	high = *(uint64_t *)data;
+	low = *(uint64_t *)(data + 8);
+#else
+	high = *(uint64_t *)(data + 8);
+	low = *(uint64_t *)data;
+#endif
+
+	typename = btf_typename_or_fallback(btf, type->name_off);
+
+	if (high == 0)
+		OUT_P(prefix, "(%s)0x%lx,\n", typename, low);
+	else
+		OUT_P(prefix, "(%s)0x%lx%016lx,\n", typename, high, low);
+}
+
+#define BITS_PER_BYTE_MASKED(bits) ((bits) & 7)
+#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
+#define BITS_ROUNDUP_BYTES(bits) \
+	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
+
+static void out_btf_bitfield(const struct btf *btf, const struct btf_type *type,
+	uint32_t bitfield_offset, uint8_t bitfield_size, const void *data,
+	out_prefix_t *prefix)
+{
+	int left_shift_bits, right_shift_bits;
+	uint64_t high, low;
+	uint64_t print_num[2] = {};
+	int bits_to_copy;
+	const char *typename;
+
+	bits_to_copy = bitfield_offset + bitfield_size;
+	memcpy(print_num, data, BITS_ROUNDUP_BYTES(bits_to_copy));
+
+	right_shift_bits = 128 - bitfield_size;
+#if defined(__BIG_ENDIAN_BITFIELD)
+	high = print_num[0];
+	low = print_num[1];
+	left_shift_bits = bitfield_offset;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	high = print_num[1];
+	low = print_num[0];
+	left_shift_bits = 128 - bits_to_copy;
+#else
+#error neither big nor little endian
+#endif
+
+	/* shake out un-needed bits by shift/or operations */
+	if (left_shift_bits >= 64) {
+		high = low << (left_shift_bits - 64);
+		low = 0;
+	} else {
+		high = (high << left_shift_bits) | (low >> (64 - left_shift_bits));
+		low = low << left_shift_bits;
+	}
+
+	if (right_shift_bits >= 64) {
+		low = high >> (right_shift_bits - 64);
+		high = 0;
+	} else {
+		low = (low >> right_shift_bits) | (high << (64 - right_shift_bits));
+		high = high >> right_shift_bits;
+	}
+
+	typename = btf_typename_or_fallback(btf, type->name_off);
+
+	if (high == 0) {
+		OUT_P(prefix, "(%s:%d)0x%lx,\n", typename, bitfield_size, low);
+	} else {
+		OUT_P(prefix, "(%s:%d)0x%lx%016lx,\n", typename, bitfield_size,
+		high, low);
+	}
+}
+
+static void out_btf_int(const struct btf *btf, const struct btf_type *type,
+	uint32_t bit_offset, const void *data, out_prefix_t *prefix)
+{
+	uint32_t *int_type = (uint32_t *)(type + 1);
+	uint32_t nbits = BTF_INT_BITS(*int_type);
+	const char *typename;
+
+	typename = btf_typename_or_fallback(btf, type->name_off);
+
+	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
+		BITS_PER_BYTE_MASKED(nbits)) {
+		out_btf_bitfield(btf, type, BTF_INT_OFFSET(*int_type), nbits,
+			data, prefix);
+		return;
+	}
+
+	if (nbits == 128) {
+		out_btf_int128(btf, type, data, prefix);
+		return;
+	}
+
+	switch (BTF_INT_ENCODING(*int_type)) {
+	case 0:
+		if (BTF_INT_BITS(*int_type) == 64)
+			OUT_P(prefix, "(%s)%lu,\n", typename, *(uint64_t *)data);
+		else if (BTF_INT_BITS(*int_type) == 32)
+			OUT_P(prefix, "(%s)%u,\n", typename, *(uint32_t *)data);
+		else if (BTF_INT_BITS(*int_type) == 16)
+			OUT_P(prefix, "(%s)%hu,\n", typename, *(uint16_t *)data);
+		else if (BTF_INT_BITS(*int_type) == 8)
+			OUT_P(prefix, "(%s)%hhu,\n", typename, *(uint8_t *)data);
+		else
+			OUT_P(prefix, "<invalid unsigned int type>,");
+		break;
+	case BTF_INT_SIGNED:
+		if (BTF_INT_BITS(*int_type) == 64)
+			OUT_P(prefix, "(%s)%ld,\n", typename, *(int64_t *)data);
+		else if (BTF_INT_BITS(*int_type) == 32)
+			OUT_P(prefix, "(%s)%d,\n", typename, *(int32_t *)data);
+		else if (BTF_INT_BITS(*int_type) == 16)
+			OUT_P(prefix, "(%s)%hd,\n", typename, *(int16_t *)data);
+		else if (BTF_INT_BITS(*int_type) == 8)
+			OUT_P(prefix, "(%s)%hhd,\n", typename, *(int8_t *)data);
+		else
+			OUT_P(prefix, "<invalid signed int type>,");
+		break;
+	case BTF_INT_CHAR:
+		OUT_P(prefix, "(%s)0x%hhx,\n", typename, *(char *)data);
+		break;
+	case BTF_INT_BOOL:
+		OUT_P(prefix, "(%s)%s,\n", typename,
+			*(bool *)data ? "true" : "false");
+		break;
+	default:
+		OUT_P(prefix, "<unknown type>,\n");
+		break;
+	}
+}
+
+static void out_btf_ptr(const struct btf *btf, const struct btf_type *type,
+	const void *data, out_prefix_t *prefix)
+{
+	unsigned long value = *(unsigned long *)data;
+	int actual_type_id;
+	const struct btf_type *actual_type;
+	const char *typename = NULL;
+
+	actual_type_id = btf__resolve_type(btf, type->type);
+	if (actual_type_id > 0) {
+		actual_type = btf__type_by_id(btf, actual_type_id);
+		if (actual_type)
+			typename = btf__name_by_offset(btf, actual_type->name_off);
+	}
+
+	typename = typename ? : "void";
+
+	OUT_P(prefix, "(%s *)%p,\n", typename, (void *)value);
+}
+
+static void out_btf_dump_type(const struct btf *btf, int bit_offset,
+	uint32_t type_id, const void *data, size_t len, out_prefix_t *prefix);
+
+static void out_btf_array(const struct btf *btf, const struct btf_type *type,
+	const void *data, out_prefix_t *prefix)
+{
+	const struct btf_array *array = (struct btf_array *)(type + 1);
+	const struct btf_type *elem_type;
+	long long elem_size;
+
+	elem_type = btf__type_by_id(btf, array->type);
+	if (!elem_type) {
+		OUT_P(prefix, "<invalid type_id %u>,\n", array->type);
+		return;
+	}
+
+	elem_size = btf__resolve_size(btf, array->type);
+	if (elem_size < 0) {
+		OUT_P(prefix, "<can't resolve size for type_id %u>,\n", array->type);
+		return;
+	}
+
+	for (int i = 0; i < array->nelems; ++i) {
+		out_btf_dump_type(btf, 0, array->type, data + i * elem_size,
+			elem_size, prefix);
+	}
+}
+
+static void out_btf_struct(const struct btf *btf, const struct btf_type *type,
+	const void *data, out_prefix_t *prefix)
+{
+	struct btf_member *member = (struct btf_member *)(type + 1);
+	const struct btf_type *member_type;
+	const void *member_data;
+	out_prefix_t prefix_override = {};
+	unsigned int i;
+
+	for (i = 0; i < BTF_INFO_VLEN(type->info); i++) {
+		uint32_t bitfield_offset = member[i].offset;
+		uint32_t bitfield_size = 0;
+
+		if (BTF_INFO_KFLAG(type->info)) {
+			/* If btf_type.info.kind_flag is set, then
+			 * btf_member.offset is composed of:
+			 *      bitfield_offset << 24 | bitfield_size
+			 */
+			bitfield_size = BTF_MEMBER_BITFIELD_SIZE(bitfield_offset);
+			bitfield_offset = BTF_MEMBER_BIT_OFFSET(bitfield_offset);
+		}
+
+		OUT_P(prefix, ".%s = ",
+			btf_typename_or_fallback(btf, member[i].name_off));
+
+		/* The prefix has to be overwritten as this function prints the
+		 * field's name, so we don't print the prefix once here before
+		 * the name, then again in out_btf_bitfield() or out_btf_int()
+		 * before printing the actual value on the same line. */
+
+		member_type = btf__type_by_id(btf, member[i].type);
+		if (!member_type) {
+			OUT_P(&prefix_override, "<invalid type_id %u>,\n",
+				member[i].type);
+			return;
+		}
+
+		member_data = data + BITS_ROUNDDOWN_BYTES(bitfield_offset);
+		bitfield_offset = BITS_PER_BYTE_MASKED(bitfield_offset);
+
+		if (bitfield_size) {
+			out_btf_bitfield(btf, member_type, bitfield_offset,
+				bitfield_size, member_data, &prefix_override);
+		} else {
+			out_btf_dump_type(btf, bitfield_offset, member[i].type,
+				member_data, 0, &prefix_override);
+		}
+	}
+}
+
+static void out_btf_enum(const struct btf *btf, const struct btf_type *type,
+	const void *data, out_prefix_t *prefix)
+{
+	const struct btf_enum *enums = (struct btf_enum *)(type + 1);
+	int64_t value;
+	unsigned int i;
+
+	switch (type->size) {
+	case 8:
+		value = *(int64_t *)data;
+		break;
+	case 4:
+		value = *(int32_t *)data;
+		break;
+	case 2:
+		value = *(int16_t*)data;
+		break;
+	case 1:
+		value = *(int8_t *)data;
+		break;
+	default:
+		OUT_P(prefix, "<invalid type size %u>,\n", type->size);
+		return;
+	}
+
+	for (i = 0; BTF_INFO_VLEN(type->info); ++i) {
+		if (value == enums[i].val) {
+			OUT_P(prefix, "(enum %s)%s\n",
+				btf_typename_or_fallback(btf, type->name_off),
+				btf_typename_or_fallback(btf, enums[i].name_off));
+			return;
+		}
+	}
+}
+
+static void out_btf_enum64(const struct btf *btf, const struct btf_type *type,
+	const void *data, out_prefix_t *prefix)
+{
+	const struct btf_enum64 *enums = (struct btf_enum64 *)(type + 1);
+	uint32_t lo32, hi32;
+	uint64_t value;
+	unsigned int i;
+
+	value = *(uint64_t *)data;
+	lo32 = (uint32_t)value;
+	hi32 = value >> 32;
+
+	for (i = 0; i < BTF_INFO_VLEN(type->info); i++) {
+		if (lo32 == enums[i].val_lo32 && hi32 == enums[i].val_hi32) {
+			OUT_P(prefix, "(enum %s)%s\n",
+				btf_typename_or_fallback(btf, type->name_off),
+				btf__name_by_offset(btf, enums[i].name_off));
+			return;
+		}
+	}
+}
+
+static out_prefix_t out_global_prefix = {};
+
+static void out_btf_dump_type(const struct btf *btf, int bit_offset,
+	uint32_t type_id, const void *data, size_t len, out_prefix_t *prefix)
+{
+	const struct btf_type *type;
+	out_prefix_t *global_prefix = &out_global_prefix;
+
+	if (!btf) {
+		OUT_P(prefix, "<missing BTF information>,\n");
+		return;
+	}
+
+	type = btf__type_by_id(btf, type_id);
+	if (!type) {
+		OUT_P(prefix, "<invalid type_id %u>,\n", type_id);
+		return;
+	}
+
+	switch (BTF_INFO_KIND(type->info)) {
+	case BTF_KIND_UNION:
+	case BTF_KIND_STRUCT:
+		OUT_P(prefix, "(%s %s) {\n",
+			BTF_INFO_KIND(type->info) == BTF_KIND_STRUCT ? "struct" : "union",
+			btf_typename_or_fallback(btf, type->name_off));
+
+		out_prefix_push(global_prefix);
+		out_btf_struct(btf, type, data, global_prefix);
+		out_prefix_pop(global_prefix);
+		OUT_P(global_prefix, "},\n");
+		break;
+	case BTF_KIND_ARRAY:
+		{
+			struct btf_array *array = (struct btf_array *)(type + 1);
+			const struct btf_type *content_type = btf__type_by_id(btf, array->type);
+
+			if (!content_type) {
+				OUT_P(prefix, "<invalid type_id %u>,\n", array->type);
+				return;
+			}
+
+			OUT_P(prefix, "(%s[]) {\n",
+				btf_typename_or_fallback(btf, content_type->name_off));
+			out_prefix_push(global_prefix);
+			out_btf_array(btf, type, data, global_prefix);
+			out_prefix_pop(global_prefix);
+			OUT_P(global_prefix, "},\n");
+		}
+		break;
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+		{
+			int actual_type_id = btf__resolve_type(btf, type_id);
+
+			if (actual_type_id < 0) {
+				OUT_P(prefix, "<invalid type_id %u>,\n", type_id);
+				return;
+			}
+
+			return out_btf_dump_type(btf, 0, actual_type_id, data,
+				len, prefix);
+		}
+		break;
+	case BTF_KIND_INT:
+		out_btf_int(btf, type, bit_offset, data, prefix);
+		break;
+	case BTF_KIND_PTR:
+		out_btf_ptr(btf, type, data, prefix);
+		break;
+	case BTF_KIND_ENUM:
+		out_btf_enum(btf, type, data, prefix);
+		break;
+	case BTF_KIND_ENUM64:
+		out_btf_enum64(btf, type, data, prefix);
+		break;
+	case BTF_KIND_FWD:
+		OUT_P(prefix, "<forward kind invalid>,\n");
+		break;
+	case BTF_KIND_UNKN:
+		OUT_P(prefix, "<unknown>,\n");
+		break;
+	case BTF_KIND_VAR:
+	case BTF_KIND_DATASEC:
+	default:
+		OUT_P(prefix, "<unsupported kind %u>,\n",
+			BTF_INFO_KIND(type->info));
+		break;
+	}
+}
+
+static void out_bpf_sk_storage(int map_id, const void *data, size_t len,
+	out_prefix_t *prefix)
+{
+	uint32_t type_id;
+	struct bpf_sk_storage_map_info *map_info;
+
+	map_info = bpf_map_opts_get_info(map_id);
+	if (!map_info) {
+		OUT_P(prefix, "map_id: %d: missing map info", map_id);
+		return;
+	}
+
+	if (map_info->info.value_size != len) {
+		OUT_P(prefix, "map_id: %d: invalid value size, expecting %u, got %lu\n",
+			map_id, map_info->info.value_size, len);
+		return;
+	}
+
+	type_id = map_info->info.btf_vmlinux_value_type_id ?: map_info->info.btf_value_type_id;
+
+	OUT_P(prefix, "map_id: %d [\n", map_id);
+	out_prefix_push(prefix);
+
+	out_btf_dump_type(map_info->btf, 0, type_id, data, len, prefix);
+
+	out_prefix_pop(prefix);
+	OUT_P(prefix, "]");
+}
+
 static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 {
-	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX + 1], *bpf_stg;
-	unsigned int rem;
+	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX+1], *bpf_stg;
+	out_prefix_t *global_prefix = &out_global_prefix;
+	unsigned int rem, map_id;
+	struct rtattr *value;
 
 	for (bpf_stg = RTA_DATA(bpf_stgs), rem = RTA_PAYLOAD(bpf_stgs);
 		RTA_OK(bpf_stg, rem); bpf_stg = RTA_NEXT(bpf_stg, rem)) {
@@ -3583,8 +4115,15 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
 			(struct rtattr *)bpf_stg);
 
 		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
-			out("map_id:%u",
-				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+			out("\n");
+
+			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
+			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
+
+			out_prefix_push(global_prefix);
+			out_bpf_sk_storage(map_id, RTA_DATA(value),
+				RTA_PAYLOAD(value), global_prefix);
+			out_prefix_pop(global_prefix);
 		}
 	}
 }
@@ -5978,6 +6517,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (oneline && (bpf_map_opts.nr_maps || bpf_map_opts.show_all)) {
+		fprintf(stderr, "ss: --oneline, --bpf-maps, and --bpf-map-id are incompatible\n");
+		exit(-1);
+	}
+
 	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
 		user_ent_hash_build();
 
-- 
2.43.0


