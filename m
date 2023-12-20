Return-Path: <netdev+bounces-59239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5488D81A056
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3521F29899
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AD236B1D;
	Wed, 20 Dec 2023 13:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 4.mo545.mail-out.ovh.net (4.mo545.mail-out.ovh.net [46.105.45.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A802D61A
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from ex4.mail.ovh.net (unknown [10.111.182.250])
	by mo545.mail-out.ovh.net (Postfix) with ESMTPS id 8223A26693;
	Wed, 20 Dec 2023 13:19:11 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (77.136.66.130) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:19:09 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>, <kernel-team@meta.com>
Subject: [PATCH v3 1/2] ss: add support for BPF socket-local storage
Date: Wed, 20 Dec 2023 14:23:25 +0100
Message-ID: <20231220132326.11246-2-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220132326.11246-1-qde@naccy.de>
References: <20231220132326.11246-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS10.indiv4.local (172.16.1.10) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 16847684731373154044
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepfeduvedtffduleeuudetteffueeijeevfeetieefgfeugfeugeelhfehhfevfeevnecuffhomhgrihhnpehnrhgpmhgrphhsrdhiugenucfkphepuddvjedrtddrtddruddpjeejrddufeeirdeiiedrudeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdhkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdpoffvtefjohhsthepmhhoheeghedpmhhouggvpehsmhhtphhouhht

While sock_diag is able to return BPF socket-local storage in response
to INET_DIAG_REQ_SK_BPF_STORAGES requests, ss doesn't request it.

This change introduces the --bpf-maps and --bpf-map-id= options to request
BPF socket-local storage for all SK_STORAGE maps, or only specific ones.

The bigger part of this change will check the requested map IDs and
ensure they are valid. A new column has been added named "Socket
storage" to print a list of map ID a given socket has data defined for.
This column is disabled unless --bpf-maps or --bpf-map-id= is used.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
Co-authored-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 misc/ss.c | 299 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 296 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 01d29dc5..689972d7 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -51,6 +51,11 @@
 #include <linux/tls.h>
 #include <linux/mptcp.h>
 
+#ifdef HAVE_LIBBPF
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#endif
+
 #if HAVE_RPC
 #include <rpc/rpc.h>
 #include <rpc/xdr.h>
@@ -101,6 +106,7 @@ enum col_id {
 	COL_RADDR,
 	COL_RSERV,
 	COL_PROC,
+	COL_SKSTOR,
 	COL_EXT,
 	COL_MAX
 };
@@ -130,6 +136,7 @@ static struct column columns[] = {
 	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
+	{ ALIGN_LEFT,	"Socket storage",	"",	1, 0, 0 },
 	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
 };
 
@@ -3374,6 +3381,238 @@ static void parse_diag_msg(struct nlmsghdr *nlh, struct sockstat *s)
 	memcpy(s->remote.data, r->id.idiag_dst, s->local.bytelen);
 }
 
+#ifdef HAVE_LIBBPF
+
+#define MAX_NR_BPF_MAP_ID_OPTS 32
+
+struct btf;
+
+static struct bpf_map_opts {
+	unsigned int nr_maps;
+	struct bpf_sk_storage_map_info {
+		unsigned int id;
+		int fd;
+	} maps[MAX_NR_BPF_MAP_ID_OPTS];
+	bool show_all;
+	struct btf *kernel_btf;
+} bpf_map_opts;
+
+static void bpf_map_opts_mixed_error(void)
+{
+	fprintf(stderr,
+		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
+}
+
+static int bpf_map_opts_add_all(void)
+{
+	unsigned int i;
+	unsigned int fd;
+	uint32_t id = 0;
+	int r;
+
+	if (bpf_map_opts.nr_maps) {
+		bpf_map_opts_mixed_error();
+		return -1;
+	}
+
+	while (1) {
+		struct bpf_map_info info = {};
+		uint32_t len = sizeof(info);
+
+		r = bpf_map_get_next_id(id, &id);
+		if (r) {
+			if (errno == ENOENT)
+				break;
+
+			fprintf(stderr, "ss: failed to fetch BPF map ID\n");
+			goto err;
+		}
+
+		fd = bpf_map_get_fd_by_id(id);
+		if (fd == -1) {
+			if (errno == -ENOENT) {
+				fprintf(stderr, "ss: missing BPF map ID %u, skipping",
+					id);
+				continue;
+			}
+
+			fprintf(stderr, "ss: cannot get fd for BPF map ID %u%s\n",
+				id, errno == EPERM ?
+				": missing root permissions, CAP_BPF, or CAP_SYS_ADMIN" : "");
+			goto err;
+		}
+
+		r = bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (r) {
+			fprintf(stderr, "ss: failed to get info for BPF map ID %u\n",
+				id);
+			close(fd);
+			goto err;
+		}
+
+		if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
+			close(fd);
+			continue;
+		}
+
+		if (bpf_map_opts.nr_maps == MAX_NR_BPF_MAP_ID_OPTS) {
+			fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",
+				MAX_NR_BPF_MAP_ID_OPTS, id);
+			close(fd);
+			continue;
+		}
+
+		bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
+		bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+	}
+
+	bpf_map_opts.show_all = true;
+
+	return 0;
+
+err:
+	for (i = 0; i < bpf_map_opts.nr_maps; ++i)
+		close(bpf_map_opts.maps[i].fd);
+
+	return -1;
+}
+
+static int bpf_map_opts_add_id(const char *optarg)
+{
+	struct bpf_map_info info = {};
+	uint32_t len = sizeof(info);
+	size_t optarg_len;
+	unsigned long id;
+	unsigned int i;
+	char *end;
+	int fd;
+	int r;
+
+	if (bpf_map_opts.show_all) {
+		bpf_map_opts_mixed_error();
+		return -1;
+	}
+
+	optarg_len = strlen(optarg);
+	id = strtoul(optarg, &end, 0);
+	if (end != optarg + optarg_len || id == 0 || id >= UINT32_MAX) {
+		fprintf(stderr, "ss: invalid BPF map ID %s\n", optarg);
+		return -1;
+	}
+
+	for (i = 0; i < bpf_map_opts.nr_maps; i++) {
+		if (bpf_map_opts.maps[i].id == id)
+			return 0;
+	}
+
+	if (bpf_map_opts.nr_maps == MAX_NR_BPF_MAP_ID_OPTS) {
+		fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %lu\n",
+			MAX_NR_BPF_MAP_ID_OPTS, id);
+		return 0;
+	}
+
+	fd = bpf_map_get_fd_by_id(id);
+	if (fd == -1) {
+		if (errno == -ENOENT) {
+			fprintf(stderr, "ss: missing BPF map ID %lu, skipping",
+				id);
+			return 0;
+		}
+
+		fprintf(stderr, "ss: cannot get fd for BPF map ID %lu%s\n",
+			id, errno == EPERM ?
+			": missing root permissions, CAP_BPF, or CAP_SYS_ADMIN" : "");
+		return -1;
+	}
+
+	r = bpf_obj_get_info_by_fd(fd, &info, &len);
+	if (r) {
+		fprintf(stderr, "ss: failed to get info for BPF map ID %lu\n", id);
+		close(fd);
+		return -1;
+	}
+
+	if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
+		fprintf(stderr, "ss: BPF map with ID %s has type '%s', expecting 'sk_storage'\n",
+			optarg, libbpf_bpf_map_type_str(info.type));
+		close(fd);
+		return -1;
+	}
+
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+
+	return 0;
+}
+
+static void bpf_map_opts_destroy(void)
+{
+	int i;
+	
+	for (i = 0; i < bpf_map_opts.nr_maps; ++i)
+		close(bpf_map_opts.maps[i].fd);
+}
+
+static bool bpf_map_opts_is_enabled(void)
+{
+	return bpf_map_opts.nr_maps;
+}
+
+static struct rtattr *bpf_map_opts_alloc_rta(void)
+{
+	size_t total_size = RTA_LENGTH(RTA_LENGTH(sizeof(int)) * bpf_map_opts.nr_maps);
+	struct rtattr *stgs_rta, *fd_rta;
+	unsigned int i;
+	void *buf;
+
+	buf = malloc(total_size);
+	if (!buf)
+		return NULL;
+
+	stgs_rta = buf;
+	stgs_rta->rta_type = INET_DIAG_REQ_SK_BPF_STORAGES | NLA_F_NESTED;
+	stgs_rta->rta_len = total_size;
+
+	buf = RTA_DATA(stgs_rta);
+	for (i = 0; i < bpf_map_opts.nr_maps; i++) {
+		int *fd;
+
+		fd_rta = buf;
+		fd_rta->rta_type = SK_DIAG_BPF_STORAGE_REQ_MAP_FD;
+		fd_rta->rta_len = RTA_LENGTH(sizeof(int));
+
+		fd = RTA_DATA(fd_rta);
+		*fd = bpf_map_opts.maps[i].fd;
+
+		buf += fd_rta->rta_len;
+	}
+
+	return stgs_rta;
+}
+
+static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
+{
+	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX + 1], *bpf_stg;
+	unsigned int rem;
+
+	for (bpf_stg = RTA_DATA(bpf_stgs), rem = RTA_PAYLOAD(bpf_stgs);
+		RTA_OK(bpf_stg, rem); bpf_stg = RTA_NEXT(bpf_stg, rem)) {
+
+		if ((bpf_stg->rta_type & NLA_TYPE_MASK) != SK_DIAG_BPF_STORAGE)
+			continue;
+
+		parse_rtattr_nested(tb, SK_DIAG_BPF_STORAGE_MAX,
+			(struct rtattr *)bpf_stg);
+
+		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
+			out("map_id:%u",
+				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+		}
+	}
+}
+
+#endif
+
 static int inet_show_sock(struct nlmsghdr *nlh,
 			  struct sockstat *s)
 {
@@ -3381,8 +3620,8 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	unsigned char v6only = 0;
 
-	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
+		nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)), NLA_F_NESTED);
 
 	if (tb[INET_DIAG_PROTOCOL])
 		s->type = rta_getattr_u8(tb[INET_DIAG_PROTOCOL]);
@@ -3479,6 +3718,13 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	}
 	sctp_ino = s->ino;
 
+#ifdef HAVE_LIBBPF
+	if (tb[INET_DIAG_SK_BPF_STORAGES]) {
+		field_set(COL_SKSTOR);
+		show_sk_bpf_storages(tb[INET_DIAG_SK_BPF_STORAGES]);
+	}
+#endif
+
 	return 0;
 }
 
@@ -3560,13 +3806,14 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 {
 	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
 	DIAG_REQUEST(req, struct inet_diag_req_v2 r);
+	struct rtattr *bpf_stgs_rta = NULL;
 	char    *bc = NULL;
 	int	bclen;
 	__u32	proto;
 	struct msghdr msg;
 	struct rtattr rta_bc;
 	struct rtattr rta_proto;
-	struct iovec iov[5];
+	struct iovec iov[6];
 	int iovlen = 1;
 
 	if (family == PF_UNSPEC)
@@ -3619,6 +3866,19 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 		iovlen += 2;
 	}
 
+#ifdef HAVE_LIBBPF
+	if (bpf_map_opts_is_enabled()) {
+		bpf_stgs_rta = bpf_map_opts_alloc_rta();
+		if (!bpf_stgs_rta) {
+			fprintf(stderr, "ss: cannot alloc request for --bpf-map\n");
+			return -1;
+		}
+
+		iov[iovlen++] = (struct iovec){ bpf_stgs_rta, bpf_stgs_rta->rta_len };
+		req.nlh.nlmsg_len += bpf_stgs_rta->rta_len;
+	}
+#endif
+
 	msg = (struct msghdr) {
 		.msg_name = (void *)&nladdr,
 		.msg_namelen = sizeof(nladdr),
@@ -3627,10 +3887,13 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 	};
 
 	if (sendmsg(fd, &msg, 0) < 0) {
+		free(bpf_stgs_rta);
 		close(fd);
 		return -1;
 	}
 
+	free(bpf_stgs_rta);
+
 	return 0;
 }
 
@@ -5350,6 +5613,10 @@ static void _usage(FILE *dest)
 "       --tos           show tos and priority information\n"
 "       --cgroup        show cgroup information\n"
 "   -b, --bpf           show bpf filter socket information\n"
+#ifdef HAVE_LIBBPF
+"       --bpf-maps      show all BPF socket-local storage maps\n"
+"       --bpf-map-id=MAP-ID    show a BPF socket-local storage map\n"
+#endif
 "   -E, --events        continually display sockets as they are destroyed\n"
 "   -Z, --context       display task SELinux security contexts\n"
 "   -z, --contexts      display task and socket SELinux security contexts\n"
@@ -5466,6 +5733,9 @@ static int scan_state(const char *state)
 
 #define OPT_INET_SOCKOPT 262
 
+#define OPT_BPF_MAPS 263
+#define OPT_BPF_MAP_ID 264
+
 static const struct option long_opts[] = {
 	{ "numeric", 0, 0, 'n' },
 	{ "resolve", 0, 0, 'r' },
@@ -5510,6 +5780,10 @@ static const struct option long_opts[] = {
 	{ "mptcp", 0, 0, 'M' },
 	{ "oneline", 0, 0, 'O' },
 	{ "inet-sockopt", 0, 0, OPT_INET_SOCKOPT },
+#ifdef HAVE_LIBBPF
+	{ "bpf-maps", 0, 0, OPT_BPF_MAPS},
+	{ "bpf-map-id", 1, 0, OPT_BPF_MAP_ID},
+#endif
 	{ 0 }
 
 };
@@ -5712,6 +5986,16 @@ int main(int argc, char *argv[])
 		case OPT_INET_SOCKOPT:
 			show_inet_sockopt = 1;
 			break;
+#ifdef HAVE_LIBBPF
+		case OPT_BPF_MAPS:
+			if (bpf_map_opts_add_all())
+				exit(1);
+			break;
+		case OPT_BPF_MAP_ID:
+			if (bpf_map_opts_add_id(optarg))
+				exit(1);
+			break;
+#endif
 		case 'h':
 			help();
 		case '?':
@@ -5810,6 +6094,11 @@ int main(int argc, char *argv[])
 	if (!(current_filter.states & (current_filter.states - 1)))
 		columns[COL_STATE].disabled = 1;
 
+#ifdef HAVE_LIBBPF
+	if (bpf_map_opts.nr_maps)
+		columns[COL_SKSTOR].disabled = 0;
+#endif
+
 	if (show_header)
 		print_header();
 
@@ -5846,6 +6135,10 @@ int main(int argc, char *argv[])
 	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
 		user_ent_destroy();
 
+#ifdef HAVE_LIBBPF
+	bpf_map_opts_destroy();
+#endif
+
 	render();
 
 	return 0;
-- 
2.43.0


