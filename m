Return-Path: <netdev+bounces-64119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E680831308
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 08:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B051C222AB
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 07:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2ADB64C;
	Thu, 18 Jan 2024 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="Y52JpVJQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hrYJflNu"
X-Original-To: netdev@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413BBE67
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562092; cv=none; b=MwAY4S5kFSCNlzfGbiNOTpItU7R14kyyRM70SFZAXs2snYFA+Ewkjuycl7lLORPHNhlgF2afGgsqKKNESYi7gTUBFHNh4OZdo5CQ4hlbKneO2LIBz/cu6jLX+r2PdaqwX4sSBuPY4jw4Cux0t98tiWGYqAA3v+ciaMJjKSwVfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562092; c=relaxed/simple;
	bh=3XUy6HlX8i8KOhGgcAjlv8wDLyqTnXgbTJcLPPpTIrg=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=f2N0w9X9HkMs9g/EDfccDFu+wx1Q7pATn9bNUkaMgo8q+i6vH96qRod84GVFMODWAxPXhsI+ny99fSB/ygwLJ1ux4a3VxDkoZmcOeNdT0a/up4X8d4uWoFjFimINVRY+zVUFT5TGaMbMFdrUfad6vT/SATp1KgR2AFGYE6fUSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=Y52JpVJQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hrYJflNu; arc=none smtp.client-ip=64.147.123.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id BC0482B00221;
	Thu, 18 Jan 2024 02:14:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 Jan 2024 02:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705562088; x=
	1705565688; bh=2sqXE/9ot0FddCKeDZwEh6b42lvIcI09XrbuQ/XZe/w=; b=Y
	52JpVJQWy59/kpqe2E0nEUgIhfRSLyqXnXvaWvmZ+DbbH4BkaYfcSSATwPBzQ8Ms
	0A8vUZH0+dWnbpnEn5kqY7aN+bAMFzoKg/1PnU92pxAX3xDeQ1q0nCbCgbJ7ySnJ
	WIWziPzHBf96sL0o1S/s22k+idDZtstbHxPhYT7YltbG3yxx+B1F3UZOTwaeWQmS
	5NIocZPXU1oxpljqCK29aeqTDgBEcxN06oGGmPqnyV78I6zDVwcjAO1x2Uq9XqzZ
	TkDQ7WGJCEej3Mkr5xKjFH23UuoHLArGofS/GcFYqFd9mTqgKj2Bi3MTkSMkeYuh
	XRtzSm24JuLLS1MZP+9AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705562088; x=
	1705565688; bh=2sqXE/9ot0FddCKeDZwEh6b42lvIcI09XrbuQ/XZe/w=; b=h
	rYJflNuRKOyuIcWpHD3i1tVgCf01/I0sT7zKp4lj2oN0w7rp5ONDHDzwsIKjtC68
	gKBBsTnZb+aNFkkY02bafpaKSpo07VPuZ4rwB6w4Htv7o/UZFhdHaXGFeZKrvwQL
	FdRxAsgZdB+7KIQNSxfGiN3Lgm5FObs7+uTkQYEFmnCHvHQRT9mgY8hzb4ukLzxp
	rvbJv63mdWToxebxlRxYjIrDbsTdoMuAd0mM7vuK/4odEwcaY+vUIqKGorSYTlA4
	mQxxTZp9OHELf4W6i1UJClMonuPKEt8++5iiKdA1OogwTn+ICwTGNnSBfIZk32Mk
	tv8TsZbX2rwXDrrC9BLog==
X-ME-Sender: <xms:58-oZX5z93iVSNNGGuB6dnHrrMTKVdP5v_6R0heNTpoJ1mIJ8GCxHA>
    <xme:58-oZc58Pdeg6MviGob4uK4I-sOEGBDLpdUUkdoTKYMa9XnP6QB38Q2ZQysPFK78T
    BXsYNbeyatcMG_3jEY>
X-ME-Received: <xmr:58-oZeePl4yFa-21HIlgXx2mRtqWEnm9Y2ybnAj5JDhL9MxQvuIFWzVab4z1DrybRrP_hDX0O3y1IzQvambQv0kblZnvRw0Esm5OthtPPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgv
    nhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrg
    htthgvrhhnpeefkedvvdffkedvkeeggeeiheegieeljedtheegffekieeuffffteeikedt
    ieffteenucffohhmrghinhepnhhrpghmrghpshdrihgunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepqhguvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:58-oZYI7qUfQerqmUhpADN47k2owPeEFjb0jravznkFAYOM-X7xn6A>
    <xmx:58-oZbLmoGKZDPlow9tJk2oiFASgMCW9hV69LHciN8CLFA4OK7CIpg>
    <xmx:58-oZRzCxBawYnEyhg12YwqkQnjuy6ufN0ThvNEDAx2dvpHC6WJiTg>
    <xmx:6M-oZRh1xaWetWC14f5yaiKen5Zbi5hJ4tCO8cXmyV-_-UwxxoegzMvprdM>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 02:14:46 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>,
	kernel-team@meta.com
Subject: [RFC iproute2 v6 1/3] ss: add support for BPF socket-local storage
Date: Thu, 18 Jan 2024 04:15:10 +0100
Message-ID: <20240118031512.298971-2-qde@naccy.de>
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

While sock_diag is able to return BPF socket-local storage in response
to INET_DIAG_REQ_SK_BPF_STORAGES requests, ss doesn't request it.

This change introduces the --bpf-maps and --bpf-map-id= options to request
BPF socket-local storage for all SK_STORAGE maps, or only specific ones.

The bigger part of this change will check the requested map IDs and
ensure they are valid. A new column has been added named "Socket
storage" to print a list of map ID a given socket has data defined for.
This column is disabled unless --bpf-maps or --bpf-map-id= is used.

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
 misc/ss.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 266 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 5296cabe..fe0e966b 100644
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
 
@@ -3380,6 +3387,206 @@ static void parse_diag_msg(struct nlmsghdr *nlh, struct sockstat *s)
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
+			out("map_id:%u ",
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
@@ -3387,8 +3594,9 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	unsigned char v6only = 0;
 
-	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
+			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
+			   NLA_F_NESTED);
 
 	if (tb[INET_DIAG_PROTOCOL])
 		s->type = rta_getattr_u8(tb[INET_DIAG_PROTOCOL]);
@@ -3485,6 +3693,13 @@ static int inet_show_sock(struct nlmsghdr *nlh,
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
 
@@ -3566,13 +3781,14 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
@@ -3625,6 +3841,19 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
@@ -3633,10 +3862,13 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
@@ -5830,6 +6086,9 @@ int main(int argc, char *argv[])
 	if (!(current_filter.states & (current_filter.states - 1)))
 		columns[COL_STATE].disabled = 1;
 
+	if (bpf_map_opts_is_enabled())
+		columns[COL_SKSTOR].disabled = 0;
+
 	if (show_header)
 		print_header();
 
@@ -5866,6 +6125,10 @@ int main(int argc, char *argv[])
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


