Return-Path: <netdev+bounces-70998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDC851855
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FE82877C4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C2F3CF52;
	Mon, 12 Feb 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="TPzXCBIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKTtZ9zz"
X-Original-To: netdev@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE83C6A6
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752626; cv=none; b=cqqPoCZHLIPB1akyQrzN1/L50sO4lTwjS9q0euyJvuLVNlao2cgsEWfu7v1WHx/v2qe2Xt01I2JTvAur2HeQtCQkMwjh9Na57UNshZDRw6OlKZlTqoohCnDO2KHkk+PMXLirDxhFQKR3aCmNU+CsQVHe0Wykpbj7HFZKTR6cZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752626; c=relaxed/simple;
	bh=6i2tuzJPvn9vTknlf2nhU2cEQAaFYDCWwTp7cY1ny5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPmbjKXEgNjLaLm6q9z64KLk1RHHU6nDNQvaajBh0VWcqemxcfSgPm+AapVKN1Zjt2VxdaZ160sETI0MyQ+k8I4mhvFWrS4UFbPQ9oIssFv1DMVOzw5EehRegkrws7eGQ8Uc33DUyATTRMnzdNhnxewC3M9Rl3gdp4TQzM5dmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=TPzXCBIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WKTtZ9zz; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id 087732CC046E;
	Mon, 12 Feb 2024 10:43:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 12 Feb 2024 10:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707752622; x=
	1707756222; bh=itntwKWyOfo+oPxNkuPrQvsLJEAC5/K9EIJgnGkk6uY=; b=T
	PzXCBIfZZ+3eNzkBfnQZftkEowYo8oMi05FOmW+Ti2oj5+H8r+UroDlp7lnTxETp
	SQ6j1nVtpS06YqN4H7qjPsYncSpiqfrl5bbavKs8u9Uxr13ZYdnC8dfYLgInMDXm
	jjCjgploVkHYszU1wJuqfFz/cNeeX5uN9T46Uz7tjbSprfq8XlY2xnqtCbePhioj
	GybzNNKaugi3PpPLFdrGJJdAJsEvnj4okXM30nm+kQp8M3nzH7IMWjHwHDuTTfrz
	1Ra12BLhcW05WdA9e9DqzG7Id08pHAf6SD/usF7sTULfYW7LShuimfY2uOyXEViI
	H0VmiridwDt4Awj+K6lcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707752622; x=
	1707756222; bh=itntwKWyOfo+oPxNkuPrQvsLJEAC5/K9EIJgnGkk6uY=; b=W
	KTtZ9zzJi/ZSki++oUFN9rBkQOA5fbIk08nrQ2Q3w+rWiLDLc/QMvd0g+yHcox9z
	5XgaOuOSfOG8EcnC73NScyUKCpEY+rmkGP1/C/AGuTTXuvMQSCl3sErwa75tXHJQ
	zVaB+TCAOTZK6/WmM8aVHfM7XnVN4Y24U9KGbJFKANRIyuOuW7ZF1NtpmX3ESe+V
	Y9nFQL5tyt/sUf0DJUNto8NzosDyX5KV1Rbal+lPbLH9MkAYar+qS/97qUVVpdDv
	dgbgPL7xhQ8EatYoABhbbWH1QVVP5SeJBrEp0jG70PP5TgR4VbYrWQoqWwCAjyVV
	hdRk72/valiiSpFawouIg==
X-ME-Sender: <xms:rTzKZafwY25aI2jOjBFnpEro1THXG6xVpVLl3NaQ691gAp8PZGngIQ>
    <xme:rTzKZUOdrb7NhUrMqLal0oUB_bCLe6ZJ9yyBRleOXPUeOMiE6LdMfiM4vJHCzeBou
    uH7mLrAWMV9tpMzXdI>
X-ME-Received: <xmr:rTzKZbh_WjZnleCC2LxtRjkBX-z3268PsosZ1UgCSVrYEMoq9Cy8mjMjhKBWxNhNc3qiwdkH2SxcP6_RflN8uzl5pCoYstForO9alnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpeefkedvvdffkedvkeeggeeiheegieeljedtheegffekieeuffffteeikedtieff
    teenucffohhmrghinhepnhhrpghmrghpshdrihgunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepqhguvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:rTzKZX8dywV_KNIV3oulR1JdXfDwQnfP2_r7ngy2ZA2p3NWMnzcnww>
    <xmx:rTzKZWttU4Nphb_CoyQtqyHHo-leICzDR0br42yVWBMCtYyZLpxzEA>
    <xmx:rTzKZeFUXgjZtfp386yeijXWj8qwGn4QHQD4NdHVbiuu4FMX2KiCNw>
    <xmx:rTzKZajNWibIJq54kSehMIts_aojMHe2XkggAvGhhDcKLBKtdIGdIdJpUCegAFzK>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 10:43:40 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v7 1/3] ss: add support for BPF socket-local storage
Date: Mon, 12 Feb 2024 16:43:29 +0100
Message-ID: <20240212154331.19460-2-qde@naccy.de>
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

While sock_diag is able to return BPF socket-local storage in response
to INET_DIAG_REQ_SK_BPF_STORAGES requests, ss doesn't request it.

This change introduces the --bpf-maps and --bpf-map-id= options to request
BPF socket-local storage for all SK_STORAGE maps, or only specific ones.

The bigger part of this change will check the requested map IDs and
ensure they are valid. The column COL_EXT is used to print the
socket-local data into.

When --bpf-maps is used, ss will send an empty INET_DIAG_REQ_SK_BPF_STORAGES
request, in return the kernel will send all the BPF socket-local storage
entries for a given socket. The BTF data for each map is loaded on
demand, as ss can't predict which map ID are used.

When --bpf-map-id=ID is used, a file descriptor to the requested maps is
open to 1) ensure the map doesn't disappear before the data is printed,
and 2) ensure the map type is BPF_MAP_TYPE_SK_STORAGE. The BTF data for
each requested map is loaded before the request is sent to the kernel.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
Co-authored-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 misc/ss.c | 262 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 5296cabe..19de107f 100644
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
@@ -3380,6 +3385,206 @@ static void parse_diag_msg(struct nlmsghdr *nlh, struct sockstat *s)
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
+		fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",
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
+		fprintf(stderr, "ss: BPF map with ID %s has type '%s', expecting 'sk_storage'\n",
+			optarg, libbpf_bpf_map_type_str(info.type));
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
+	// Force lazy loading of the map's data.
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
+	 * a socket, no matter their map ID. */
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
+	 * to avoid inserting specific map IDs into the request. */
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
+			(struct rtattr *)bpf_stg);
+
+		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
+			out(" map_id:%u",
+				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
+		}
+	}
+}
+
+static bool bpf_map_opts_is_enabled(void)
+{
+	return bpf_map_opts.nr_maps || bpf_map_opts.show_all;
+}
+
+#else
+
+static bool bpf_map_opts_is_enabled(void)
+{
+	return false;
+}
+
+#endif
+
 static int inet_show_sock(struct nlmsghdr *nlh,
 			  struct sockstat *s)
 {
@@ -3387,8 +3592,9 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	unsigned char v6only = 0;
 
-	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
+			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
+			   NLA_F_NESTED);
 
 	if (tb[INET_DIAG_PROTOCOL])
 		s->type = rta_getattr_u8(tb[INET_DIAG_PROTOCOL]);
@@ -3485,6 +3691,11 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	}
 	sctp_ino = s->ino;
 
+#ifdef HAVE_LIBBPF
+	if (tb[INET_DIAG_SK_BPF_STORAGES])
+		show_sk_bpf_storages(tb[INET_DIAG_SK_BPF_STORAGES]);
+#endif
+
 	return 0;
 }
 
@@ -3566,13 +3777,14 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
@@ -3625,6 +3837,19 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
@@ -3633,10 +3858,13 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
 
@@ -5357,6 +5585,10 @@ static void _usage(FILE *dest)
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
@@ -5482,6 +5714,9 @@ wrong_state:
 
 #define OPT_INET_SOCKOPT 262
 
+#define OPT_BPF_MAPS 263
+#define OPT_BPF_MAP_ID 264
+
 static const struct option long_opts[] = {
 	{ "numeric", 0, 0, 'n' },
 	{ "resolve", 0, 0, 'r' },
@@ -5527,6 +5762,10 @@ static const struct option long_opts[] = {
 	{ "mptcp", 0, 0, 'M' },
 	{ "oneline", 0, 0, 'O' },
 	{ "inet-sockopt", 0, 0, OPT_INET_SOCKOPT },
+#ifdef HAVE_LIBBPF
+	{ "bpf-maps", 0, 0, OPT_BPF_MAPS},
+	{ "bpf-map-id", 1, 0, OPT_BPF_MAP_ID},
+#endif
 	{ 0 }
 
 };
@@ -5732,6 +5971,19 @@ int main(int argc, char *argv[])
 		case OPT_INET_SOCKOPT:
 			show_inet_sockopt = 1;
 			break;
+#ifdef HAVE_LIBBPF
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
@@ -5866,6 +6118,10 @@ int main(int argc, char *argv[])
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


