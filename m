Return-Path: <netdev+bounces-71778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A835B8550D3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950FFB22B6F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C24128376;
	Wed, 14 Feb 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="FI5A9AQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijsV97Pd"
X-Original-To: netdev@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87E128370
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933129; cv=none; b=bfpdTAi5sjD9Bcs4xhhXV4yDoePCMc+QnUcmgvLN6FckqFlCuVbNqXueRT6SncgKUH3CmWL3iYzsmYTfILQ096aKl6UyquO72FUhjL7AlrWRW6FLQcVxqDs2TBwTXrxSDsiMYknszAC6y9bbVKbPrPyrMzYVtTLEhSjN4kfVTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933129; c=relaxed/simple;
	bh=0trp8+xh9PxPVkRCm1TQFQt1A0sE4qEIbqLqzxSuCoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/1LDeAAVCPL6MhYSh8ZZsBtDpI5iqn7TDAh5I717T1teuRuecEYxUMgl2HgYHZ/dvPIJhfLKMb9mm2w/VNdE7T2YfysjfPUyGBztY714nnYi/6O87fjCj5FT2gLdLth+1OeXH7GcNM2m2JoDl0lkSDEUfdwS1PLEFIn6J9YbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=FI5A9AQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijsV97Pd; arc=none smtp.client-ip=64.147.123.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id 6C6762B0015C;
	Wed, 14 Feb 2024 12:52:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Feb 2024 12:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707933124; x=
	1707936724; bh=KwWqs6lNdKASFHgsmp/IPz1e5C6zBFYsRKYENwBhGbw=; b=F
	I5A9AQXV7IPoJSq1PYBTAlbpxFxAStQ4aF8tLO1XweB1C1iO7gzjLDZs57/PYs/u
	nTJnH4zzbdx77ij3qxrQ/wS/a23JKOxoh9g2cd9GBSUw2TsmMRe2RYhlFm3vErTg
	u6HHi/AB6nNbEPgnrEcUJJ/Ue77IS/k6Kx5OcHA5CP5TBWKtQqnTiXHpfHeElVBd
	wCgO0OK7rMyYmK15+mqcyymZ5hIf8efzzaXIhZjMM20jlDcUSYhxOx/TGtaGnFR3
	/aZGiPIPuDw9k+5sFB1QGWhIWl/0l8PhfqTc96gPK8efCo+Unfb0EhPaD5+pqV2V
	FkE6Nr08TnvjRigwuvE8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707933124; x=
	1707936724; bh=KwWqs6lNdKASFHgsmp/IPz1e5C6zBFYsRKYENwBhGbw=; b=i
	jsV97PdfmS89ixiACCYFerYnb1btwFCzyv562JunCq5yIQ0Dqk1l+W4/KshZu/HZ
	KFoOFvCC0Gku9VB/6oCNt84yD6jYE+i+Wrc3TaosWs9ECseViJPHYSJnzHhMF/ds
	VvQL4/OCsj8wocSlkKwEcbncUPJGSqwkFHSMpRioTi4gCYh8Kvs6PGdAvrxfy08O
	JQhgtu6NyxT/Ko3kIWdZt/OEOx+CwlhY6uR/aw2MqWyQCF5d6L4ThlD6M7rB8fil
	7EhdOhHvZWGoRVIwxzNKfHbpaTt4BLoCdkUFqOFFRewe9F9Ix6OZZHZu0rEcUswV
	QGrHewAjVxtLOTUqvmdlg==
X-ME-Sender: <xms:xP3MZaNJaRCF02jZbvY2FynIODU3ehAg6M5dUSBd5bKi6EFEQP3CHw>
    <xme:xP3MZY_oNhmIOKyw_WHum3j4HhXAobgSNyQEK9nZzK4851n54yvOSM5X3a7Dw-MSY
    Z0NL1wYSzWE50Zj_QU>
X-ME-Received: <xmr:xP3MZRTXhW6XTDLwOWiHvekmCfbsux681hhf54TL5JJm0l7QtZ-SbJnJUMRKFHGXY3Kso-VmxA9Q636sWcZKVgtxbtk_ai-_GR0j7CafqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepfeekvddvffekvdekgeegieehgeeileejtdehgeffkeeiueffffetieektdei
    ffetnecuffhomhgrihhnpehnrhgpmhgrphhsrdhiugenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehquggvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:xP3MZav3izHmlaQe874LVBZvTMOImqWF12v-Jpd3EP-Pq6h_F54hfw>
    <xmx:xP3MZSfaA7G-NFtCb-qQDNOznmCmLmVgai70mE7cDyFXqfQqHEIxkw>
    <xmx:xP3MZe2IfUOLH2yojvgeU35JTZ838ACHyvFu57BK2nduBCQPjNT7EQ>
    <xmx:xP3MZaRdmCYEvAzEw5aLRF1EtGIfrH9khnWZRyOrTYFnDA2j4BmCnnNFgoA>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 12:52:03 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v8 1/3] ss: add support for BPF socket-local storage
Date: Wed, 14 Feb 2024 09:42:33 +0100
Message-ID: <20240214084235.25618-2-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214084235.25618-1-qde@naccy.de>
References: <20240214084235.25618-1-qde@naccy.de>
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
 misc/ss.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 263 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 5296cabe..7f47b489 100644
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
@@ -3380,6 +3385,209 @@ static void parse_diag_msg(struct nlmsghdr *nlh, struct sockstat *s)
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
@@ -3387,8 +3595,9 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	unsigned char v6only = 0;
 
-	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
+			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
+			   NLA_F_NESTED);
 
 	if (tb[INET_DIAG_PROTOCOL])
 		s->type = rta_getattr_u8(tb[INET_DIAG_PROTOCOL]);
@@ -3485,6 +3694,11 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	}
 	sctp_ino = s->ino;
 
+#ifdef HAVE_LIBBPF
+	if (tb[INET_DIAG_SK_BPF_STORAGES])
+		show_sk_bpf_storages(tb[INET_DIAG_SK_BPF_STORAGES]);
+#endif
+
 	return 0;
 }
 
@@ -3566,13 +3780,14 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
@@ -3625,6 +3840,20 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 		iovlen += 2;
 	}
 
+#ifdef HAVE_LIBBPF
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
@@ -3633,10 +3862,13 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
 
@@ -5357,6 +5589,10 @@ static void _usage(FILE *dest)
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
@@ -5482,6 +5718,9 @@ wrong_state:
 
 #define OPT_INET_SOCKOPT 262
 
+#define OPT_BPF_MAPS 263
+#define OPT_BPF_MAP_ID 264
+
 static const struct option long_opts[] = {
 	{ "numeric", 0, 0, 'n' },
 	{ "resolve", 0, 0, 'r' },
@@ -5527,6 +5766,10 @@ static const struct option long_opts[] = {
 	{ "mptcp", 0, 0, 'M' },
 	{ "oneline", 0, 0, 'O' },
 	{ "inet-sockopt", 0, 0, OPT_INET_SOCKOPT },
+#ifdef HAVE_LIBBPF
+	{ "bpf-maps", 0, 0, OPT_BPF_MAPS},
+	{ "bpf-map-id", 1, 0, OPT_BPF_MAP_ID},
+#endif
 	{ 0 }
 
 };
@@ -5732,6 +5975,19 @@ int main(int argc, char *argv[])
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
@@ -5866,6 +6122,10 @@ int main(int argc, char *argv[])
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


