Return-Path: <netdev+bounces-73730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D10E85E0BE
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33ED1286BC2
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D867FBA4;
	Wed, 21 Feb 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="qMAEEDC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASSqi2xU"
X-Original-To: netdev@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186E7BB01
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528603; cv=none; b=mTdBRdGLSTj6KAm8OR2yB3SkBqnEkLhEBwcxDpOMsc+G0sy+K0DM5MEiuDOlFlw89xiyAk3xeFagjJbjGK6NvviVMe7eKNrSALh+5b5Y2sHqZMfGFCRVjRSwJeZIzJOEK0pPZHwTRiCgTO8ZwBBM+DRXV0ENn/R6w6vAXzPKQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528603; c=relaxed/simple;
	bh=6hV68C4tBvlpX9OidBYO0K76L354M+c8P85unvCNPtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdwUHINp7zUqQ3UcjFC1uU8x4j2Aj0LhWXQrvf4d0wrNSfE6JzyN2WHYa7Z6aVPF9SMM0zgx//BXleiAfkxiqInUrT3tsDXP9j5NWxFI9aOuUDRewg9RJcVSZeCLh0g31z17x+ooQh844pIjhnW7I65lC/gLddGtKkUTNce9VlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=qMAEEDC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASSqi2xU; arc=none smtp.client-ip=64.147.123.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.west.internal (Postfix) with ESMTP id E6F602B00286;
	Wed, 21 Feb 2024 10:16:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Feb 2024 10:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1708528599; x=
	1708532199; bh=FxSHBdUZiEpqj1r9P471kz+KvJLc7VOgGKxZ+ruwvmY=; b=q
	MAEEDC7JmesygRIpL2zMVqyJpRfExdKWrJJPPy6D4qgSfr47EZUFU1tput0xhAAb
	TKAVnsx62/VHyMnjQ7jhk2ZiUFeC04CxnOLV10pdKQoKNoV7uYyNyO1TQ347k4Rk
	j0PfhN7l62xfpiSA2yo54kVot65IduwwVoO1LShYU/1RPIvqNYFZZ4nhG1ph2z7Z
	OtxFxFnirIYGUClXr0PPmnq3p7XOEwsQZUhmya7hwDaWXAJCk01iKve4y+8IzChm
	dQqx0IYbtxwb0R4V60jiyzfkO//fSM3BDz7TNTC+y+aAvT1NR42071mqz2e7jgnM
	IdyenhIMdZgbQR+JNkVeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708528599; x=
	1708532199; bh=FxSHBdUZiEpqj1r9P471kz+KvJLc7VOgGKxZ+ruwvmY=; b=A
	SSqi2xUFqjQBKGga/qzxpAC4uP1x60BAaBVmSKcyC5OLZoinYtncEwfIKtJch9Kd
	q5YXMfpCg6SK1yKb0Lap9ffRIcLVWbgcrrI+WAv6q4lr8o5JT99SfI1A4lc8ed5G
	QScHKT2OsZag3WwlbUjTBNpGcHLjLYt7a7FYQc6HgeMAxr4tgWPSAUDx/B4z8CVT
	07vw7dk5duf9qPBOqI1Dr6EeokwdE65LqU2mnRnoBMWOYRYlrqIW1Q68aJaQmpso
	A3ulrSrOFLWEqZd3F47sxmV40TOpffSZ/2vOrCC5mgDBH+qEplS6zUYdjZGXV8na
	c1ZQIe3Aw9qi+GHEJPFWA==
X-ME-Sender: <xms:1hPWZfbggPwKiK58W7KVgtDet1iOmVFs1Rnzdc9zEe0hl4Ot4cW7Pg>
    <xme:1hPWZebouksfjrWXz-VgAAw0TYGzW89H2Jd1uCWbFrCBhlGfj0l3GIDdwVsvFDRiK
    aExNpGJ3Kdc8TrwYwI>
X-ME-Received: <xmr:1hPWZR8mPEuoPmE8vVpTWDFQxMGSva0PEA7hebSqPvA0tIsrLxlLmz4OVJv1Yn0xipHvVOd9r0e2IctArHL76SoMOs6JT5t038pV22r5Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpeefkedvvdffkedvkeeggeeiheegieeljedtheegffekieeuffffteeikedtieff
    teenucffohhmrghinhepnhhrpghmrghpshdrihgunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepqhguvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:1hPWZVqBU159MXXbcgdv2b4uwGQ2NkVW22FR5de8KjETVP7-prsnyw>
    <xmx:1hPWZaqzALfNX2ssYfD9s0adkIKXsFGcahqVbmGBu9Vg2boO-UAkTw>
    <xmx:1hPWZbTXVRqQ12BwPp5lTC9Xx5mGHz9WeHtogqAgKyYxU0ZtdaIbxA>
    <xmx:1xPWZbdvYPmRoIvRCRdiimc3JPj1FnJC9-GoYGJa9L6kCuPnnVtVpFv1CCc>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 10:16:37 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v9 1/3] ss: add support for BPF socket-local storage
Date: Wed, 21 Feb 2024 16:16:19 +0100
Message-ID: <20240221151621.166623-2-qde@naccy.de>
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

While sock_diag is able to return BPF socket-local storage in response
to INET_DIAG_REQ_SK_BPF_STORAGES requests, ss doesn't request it.

This change introduces the --bpf-maps and --bpf-map-id= options to request
BPF socket-local storage for all SK_STORAGE maps, or only specific ones.

The bigger part of this change will check the requested map IDs and
ensure they are valid. The column COL_EXT is used to print the
socket-local data into.

When --bpf-maps is used, ss will send an empty
INET_DIAG_REQ_SK_BPF_STORAGES request, in return the kernel will send
all the BPF socket-local storage entries for a given socket. The BTF
data for each map is loaded on demand, as ss can't predict which map ID
are used.

When --bpf-map-id=ID is used, a file descriptor to the requested maps is
open to 1) ensure the map doesn't disappear before the data is printed,
and 2) ensure the map type is BPF_MAP_TYPE_SK_STORAGE. The BTF data for
each requested map is loaded before the request is sent to the kernel.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 misc/ss.c | 272 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 269 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 5296cabe..8924b2bf 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -51,6 +51,24 @@
 #include <linux/tls.h>
 #include <linux/mptcp.h>
 
+#ifdef HAVE_LIBBPF
+/* If libbpf is new enough (0.5+), support for pretty-printing BPF socket-local
+ * storage is enabled, otherwise we emit a warning and disable it.
+ * ENABLE_BPF_SKSTORAGE_SUPPORT is only used to gate the socket-local storage
+ * feature, so this wouldn't prevent any feature relying on HAVE_LIBBPF to be
+ * usable.
+ */
+#define ENABLE_BPF_SKSTORAGE_SUPPORT
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#if (LIBBPF_MAJOR_VERSION == 0) && (LIBBPF_MINOR_VERSION < 5)
+#warning "libbpf version 0.5 or later is required, disabling BPF socket-local storage support"
+#undef ENABLE_BPF_SKSTORAGE_SUPPORT
+#endif
+#endif
+
 #if HAVE_RPC
 #include <rpc/rpc.h>
 #include <rpc/xdr.h>
@@ -3380,6 +3398,202 @@ static void parse_diag_msg(struct nlmsghdr *nlh, struct sockstat *s)
 	memcpy(s->remote.data, r->id.idiag_dst, s->local.bytelen);
 }
 
+#ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
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
+} bpf_map_opts;
+
+static void bpf_map_opts_mixed_error(void)
+{
+	fprintf(stderr,
+		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
+}
+
+static int bpf_map_opts_load_info(unsigned int map_id)
+{
+	struct bpf_map_info info = {};
+	uint32_t len = sizeof(info);
+	int fd;
+	int r;
+
+	if (bpf_map_opts.nr_maps == MAX_NR_BPF_MAP_ID_OPTS) {
+		fprintf(stderr,
+			"ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",
+			MAX_NR_BPF_MAP_ID_OPTS, map_id);
+		return 0;
+	}
+
+	fd = bpf_map_get_fd_by_id(map_id);
+	if (fd < 0) {
+		if (errno == -ENOENT)
+			return 0;
+
+		fprintf(stderr, "ss: cannot get fd for BPF map ID %u%s\n",
+			map_id, errno == EPERM ?
+			": missing root permissions, CAP_BPF, or CAP_SYS_ADMIN" : "");
+		return -1;
+	}
+
+	r = bpf_obj_get_info_by_fd(fd, &info, &len);
+	if (r) {
+		fprintf(stderr, "ss: failed to get info for BPF map ID %u\n",
+			map_id);
+		close(fd);
+		return -1;
+	}
+
+	if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
+		fprintf(stderr,
+			"ss: BPF map with ID %s has type ID %d, expecting %d ('sk_storage')\n",
+			optarg, info.type, BPF_MAP_TYPE_SK_STORAGE);
+		close(fd);
+		return -1;
+	}
+
+	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = map_id;
+	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
+
+	return 0;
+}
+
+static struct bpf_sk_storage_map_info *bpf_map_opts_get_info(
+	unsigned int map_id)
+{
+	unsigned int i;
+	int r;
+
+	for (i = 0; i < bpf_map_opts.nr_maps; ++i) {
+		if (bpf_map_opts.maps[i].id == map_id)
+			return &bpf_map_opts.maps[i];
+	}
+
+	r = bpf_map_opts_load_info(map_id);
+	if (r)
+		return NULL;
+
+	return &bpf_map_opts.maps[bpf_map_opts.nr_maps - 1];
+}
+
+static int bpf_map_opts_add_id(const char *optarg)
+{
+	size_t optarg_len;
+	unsigned long id;
+	char *end;
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
+	/* Force lazy loading of the map's data. */
+	if (!bpf_map_opts_get_info(id))
+		return -1;
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
+static struct rtattr *bpf_map_opts_alloc_rta(void)
+{
+	struct rtattr *stgs_rta, *fd_rta;
+	size_t total_size;
+	unsigned int i;
+	void *buf;
+
+	/* If bpf_map_opts.show_all == true, we will send an empty message to
+	 * the kernel, which will return all the socket-local data attached to
+	 * a socket, no matter their map ID
+	 */
+	if (bpf_map_opts.show_all) {
+		total_size = RTA_LENGTH(0);
+	} else {
+		total_size = RTA_LENGTH(RTA_LENGTH(sizeof(int)) *
+					bpf_map_opts.nr_maps);
+	}
+
+	buf = malloc(total_size);
+	if (!buf)
+		return NULL;
+
+	stgs_rta = buf;
+	stgs_rta->rta_type = INET_DIAG_REQ_SK_BPF_STORAGES | NLA_F_NESTED;
+	stgs_rta->rta_len = total_size;
+
+	/* If inet_show_netlink() retries fetching socket data, nr_maps might
+	 * be different from 0, even with show_all == true, so we return early
+	 * to avoid inserting specific map IDs into the request.
+	 */
+	if (bpf_map_opts.show_all)
+		return stgs_rta;
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
+				    (struct rtattr *)bpf_stg);
+
+		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
+			out(" map_id:%u",
+			    rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+		}
+	}
+}
+
+static bool bpf_map_opts_is_enabled(void)
+{
+	return bpf_map_opts.nr_maps || bpf_map_opts.show_all;
+}
+#endif
+
 static int inet_show_sock(struct nlmsghdr *nlh,
 			  struct sockstat *s)
 {
@@ -3387,8 +3601,9 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	unsigned char v6only = 0;
 
-	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
+			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
+			   NLA_F_NESTED);
 
 	if (tb[INET_DIAG_PROTOCOL])
 		s->type = rta_getattr_u8(tb[INET_DIAG_PROTOCOL]);
@@ -3485,6 +3700,11 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	}
 	sctp_ino = s->ino;
 
+#ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
+	if (tb[INET_DIAG_SK_BPF_STORAGES])
+		show_sk_bpf_storages(tb[INET_DIAG_SK_BPF_STORAGES]);
+#endif
+
 	return 0;
 }
 
@@ -3566,13 +3786,14 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 {
 	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
 	DIAG_REQUEST(req, struct inet_diag_req_v2 r);
+	struct rtattr *bpf_rta = NULL;
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
@@ -3625,6 +3846,20 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 		iovlen += 2;
 	}
 
+#ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
+	if (bpf_map_opts_is_enabled()) {
+		bpf_rta = bpf_map_opts_alloc_rta();
+		if (!bpf_rta) {
+			fprintf(stderr,
+				"ss: cannot alloc request for --bpf-map\n");
+			return -1;
+		}
+
+		iov[iovlen++] = (struct iovec){ bpf_rta, bpf_rta->rta_len };
+		req.nlh.nlmsg_len += bpf_rta->rta_len;
+	}
+#endif
+
 	msg = (struct msghdr) {
 		.msg_name = (void *)&nladdr,
 		.msg_namelen = sizeof(nladdr),
@@ -3633,10 +3868,13 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 	};
 
 	if (sendmsg(fd, &msg, 0) < 0) {
+		free(bpf_rta);
 		close(fd);
 		return -1;
 	}
 
+	free(bpf_rta);
+
 	return 0;
 }
 
@@ -5357,6 +5595,10 @@ static void _usage(FILE *dest)
 "       --tos           show tos and priority information\n"
 "       --cgroup        show cgroup information\n"
 "   -b, --bpf           show bpf filter socket information\n"
+#ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
+"       --bpf-maps      show all BPF socket-local storage maps\n"
+"       --bpf-map-id=MAP-ID    show a BPF socket-local storage map\n"
+#endif
 "   -E, --events        continually display sockets as they are destroyed\n"
 "   -Z, --context       display task SELinux security contexts\n"
 "   -z, --contexts      display task and socket SELinux security contexts\n"
@@ -5482,6 +5724,9 @@ wrong_state:
 
 #define OPT_INET_SOCKOPT 262
 
+#define OPT_BPF_MAPS 263
+#define OPT_BPF_MAP_ID 264
+
 static const struct option long_opts[] = {
 	{ "numeric", 0, 0, 'n' },
 	{ "resolve", 0, 0, 'r' },
@@ -5527,6 +5772,10 @@ static const struct option long_opts[] = {
 	{ "mptcp", 0, 0, 'M' },
 	{ "oneline", 0, 0, 'O' },
 	{ "inet-sockopt", 0, 0, OPT_INET_SOCKOPT },
+#ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
+	{ "bpf-maps", 0, 0, OPT_BPF_MAPS},
+	{ "bpf-map-id", 1, 0, OPT_BPF_MAP_ID},
+#endif
 	{ 0 }
 
 };
@@ -5732,6 +5981,19 @@ int main(int argc, char *argv[])
 		case OPT_INET_SOCKOPT:
 			show_inet_sockopt = 1;
 			break;
+#ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
+		case OPT_BPF_MAPS:
+			if (bpf_map_opts.nr_maps) {
+				bpf_map_opts_mixed_error();
+				return -1;
+			}
+			bpf_map_opts.show_all = true;
+			break;
+		case OPT_BPF_MAP_ID:
+			if (bpf_map_opts_add_id(optarg))
+				exit(1);
+			break;
+#endif
 		case 'h':
 			help();
 		case '?':
@@ -5866,6 +6128,10 @@ int main(int argc, char *argv[])
 	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
 		user_ent_destroy();
 
+#ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
+	bpf_map_opts_destroy();
+#endif
+
 	render();
 
 	return 0;
-- 
2.43.1


