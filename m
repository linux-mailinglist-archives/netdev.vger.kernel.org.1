Return-Path: <netdev+bounces-212133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CA0B1E35D
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788A81AA2650
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450E27380F;
	Fri,  8 Aug 2025 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ4rHLQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C84227B8C;
	Fri,  8 Aug 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637983; cv=none; b=fnop95qKc017sgb3G25wPgaHUErSSnFtw1XtWVV3D+ROdnRvufvJzBQF39TxLlCZF+3uYf2GxWhzx0m43zpObSwXpy45IYBDQnGYfS78gCtOsBmhfjlGx4VIV0KGnQ0qhudHjBkK6DfVzP+0WkliPauU9bCXMomvpGrdyX9P74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637983; c=relaxed/simple;
	bh=bTW6AmC5c7gOdIhkD5QyPjS5NYHKojLOvV6+qOVYeOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejQNXSiNUMmR5ixBmHHTpLdBw+W4xyVScShfGGwCOu2YBPXFT4NDqSOgbh7hfWiVLOwHB2I7/Fwo+W+3gOzlwuR+0VmaDAQOladm8PGn46JN+2wIM+VcH2j6C91b7hDwqKOAxMwILZy9eltlv5RcptRMMYIxQslzaXvN17cTBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ4rHLQ8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2402b5396cdso11962205ad.2;
        Fri, 08 Aug 2025 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754637981; x=1755242781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y4ayNTu6yezCxVLa6u9JCyNf94KaDdFdQJuTS0HgYw=;
        b=UQ4rHLQ8TC7ITLv5eNc6JGKWTTQH75TzeLn6+MFZC1Hz/ceEvxbaB/HSAE9fTrurN5
         83vI3sX+j8Wa7jp9v2BbivvocFu7cAA9eghgv+7TUSu4V/VSnmPfkBle5HISXUfcQQtV
         D/3dEwejQWiNiau4BzhjWZRZlPuGumkyCsT7blbGdvFmRFxmMPjUQiG2xJ1Pfnq/06RA
         943zkFol/cYPvESjHmGlTAzGVBGsXj5HSuRCZbupemy7lPiHfyc27PMXHgCJTyXG1uRy
         /iBb/U6tTn+LIDI70iBsE5KoqsFBZcpfSeQdC5kcONiuYfXxkAWau1H8KOEQCbHT4BwP
         //IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637981; x=1755242781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y4ayNTu6yezCxVLa6u9JCyNf94KaDdFdQJuTS0HgYw=;
        b=GPK+hhJjVwU4Cvn6a6SQRTIZmvzi6+oclw+IFDRCcni2Io6lpE+bYRBt3GVNgaqD6Z
         YybkOEpoigdqFeZuY8tZ1XV4BrvHPe/NI2cJAYcigVqjwWmBX69Wnzp6aL1N4v88Zttw
         X5AVysG3OoJCthx6/a+Glg4Gw9tXc2KjNBsVVB+AC+Cio9xZEdjbe8b4Agz84VStuyCT
         uZYAuwndWdQCLs5CFw5pc3xv5S+dJCbaaIfGrxYVdnE+KA97h2gFep7IYsRsI1EidCtg
         H/QDusgEJGNXwkh+uDeg1E1MtxcXQoGa+eyyoZLniped+iUTXQUriUOZLFWNMpck9Cyb
         38sw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqECVWxhgTSbRXH/tR/fA1GOPat8xbOxbf6w5RX6nfl0aP+Tr7iZzMU5rtseXSa4jA2M6Wn8O8gN5iSo=@vger.kernel.org, AJvYcCX1s9AVSWrQpfJYoHcYvJ7PkRCDpmS/reyFgqFMRqdOzhrlZZ/w+yUZuXxk7IF5feqkAeDB5JhG@vger.kernel.org
X-Gm-Message-State: AOJu0YzogXz+QbF2ft9PQFAOiTXqAwyFR0wMEuLuuchFCrM+jX7mis7X
	JbGQul7S3NCIPArq5SpnkxIgSa6SWsCGIKJO1LvcfrHg6a+wJueD/j9q
X-Gm-Gg: ASbGnctz617LB7zPlpLdbDH2cL36MIKzY7OnY+PJ0RbFaKziyb4Euq+j3S6e8hkrWBG
	Z0TCrbtrXCjjXc9u0zVvvWSBZ76VR9BJNH1LauoioNQXCCe+KIpRjadvNcd3KTEeofwgZaH+Duq
	jlhRttQHkGKuMPc/cD2cfuq2pKCJTVnb0rNWrIIBGuyjtlEVey2ryKYxEpyVvjHXA3VQh7gAHm3
	/4leag7pSxAyFmgKJxpvBvGl0BVfsrb0jBDt9KcAOw87NDAUKbQOH9ilJeh9qQmv9ET0acbCvq7
	L5JoqR01W7cQQP9GnyOehgkgjGTRzm2XdduIg6XRq968PccmQIZi3zVLOE1reysCeCzzgVBXzY1
	vSrykEd897JOXFZTvNbXeATBQ2A==
X-Google-Smtp-Source: AGHT+IGflRqKZEJeTlZ+3G18yZXjIctHwjF5xth0gKvqXF8D+64xqjeuX6ZXwpFG7i6RdN2TJ8I7Dg==
X-Received: by 2002:a17:902:c94b:b0:240:b28:22a3 with SMTP id d9443c01a7336-242c21e088bmr30761125ad.29.1754637981186;
        Fri, 08 Aug 2025 00:26:21 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm186893565ad.63.2025.08.08.00.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:26:20 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com
Cc: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC v2 1/1] net/tls: allow limiting maximum record size
Date: Fri,  8 Aug 2025 17:24:01 +1000
Message-ID: <20250808072358.254478-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808072358.254478-3-wilfred.opensource@gmail.com>
References: <20250808072358.254478-3-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a handshake, an endpoint may specify a maximum record size limit.
Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
maximum record size. Meaning that, the outgoing records from the kernel
can exceed a lower size negotiated during the handshake. In such a case,
the TLS endpoint must send a fatal "record_overflow" alert [1], and
thus the record is discarded.

This patch adds support for retrieving the negotiated record size limit
during a handshake, and enforcing it at the TLS layer such that outgoing
records are no larger than the size negotiated. This patch depends on
the respective userspace support in tlshd [2] and GnuTLS [3].

[1] https://www.rfc-editor.org/rfc/rfc8449
[2] https://github.com/oracle/ktls-utils/pull/112
[3] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 Documentation/netlink/specs/handshake.yaml |  3 +++
 include/net/tls.h                          |  2 ++
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 ++--
 net/handshake/tlshd.c                      | 29 +++++++++++++++++++++-
 net/tls/tls_sw.c                           |  6 ++++-
 6 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index b934cc513e3d..4e6bc348f1fd 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -84,6 +84,9 @@ attribute-sets:
         name: remote-auth
         type: u32
         multi-attr: true
+      -
+          name: record-size-limit
+          type: u32
 
 operations:
   list:
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..02e7b59fcc30 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -250,6 +250,8 @@ struct tls_context {
 			       */
 	unsigned long flags;
 
+	u32 tls_record_size_limit;
+
 	/* cache cold stuff */
 	struct proto *sk_proto;
 	struct sock *sk;
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 3d7ea58778c9..0768eb8eb415 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -54,6 +54,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..44c43ce18361 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT] = { .type = NLA_U32, },
 };
 
 /* Ops table for handshake */
@@ -35,7 +36,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.cmd		= HANDSHAKE_CMD_DONE,
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
-		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
+		.maxattr	= HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index d6f52839827e..f4e793f6288d 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -19,6 +19,7 @@
 #include <net/handshake.h>
 #include <net/genetlink.h>
 #include <net/tls_prot.h>
+#include <net/tls.h>
 
 #include <uapi/linux/keyctl.h>
 #include <uapi/linux/handshake.h>
@@ -37,6 +38,8 @@ struct tls_handshake_req {
 	key_serial_t		th_certificate;
 	key_serial_t		th_privkey;
 
+	struct socket		*th_sock;
+
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 };
@@ -52,6 +55,7 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_consumer_data = args->ta_data;
 	treq->th_peername = args->ta_peername;
 	treq->th_keyring = args->ta_keyring;
+	treq->th_sock = args->ta_sock;
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
@@ -85,6 +89,27 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
 	}
 }
 
+static void tls_handshake_record_size(struct tls_handshake_req *treq,
+				      struct genl_info *info)
+{
+	struct tls_context *tls_ctx;
+	struct nlattr *head = nlmsg_attrdata(info->nlhdr, GENL_HDRLEN);
+	struct nlattr *nla;
+	u32 record_size_limit;
+	int rem, len = nlmsg_attrlen(info->nlhdr, GENL_HDRLEN);
+
+	nla_for_each_attr(nla, head, len, rem) {
+		if (nla_type(nla) == HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT) {
+			record_size_limit = nla_get_u32(nla);
+			if (treq->th_sock) {
+				tls_ctx = tls_get_ctx(treq->th_sock->sk);
+				tls_ctx->tls_record_size_limit = record_size_limit;
+			}
+			break;
+		}
+	}
+}
+
 /**
  * tls_handshake_done - callback to handle a CMD_DONE request
  * @req: socket on which the handshake was performed
@@ -98,8 +123,10 @@ static void tls_handshake_done(struct handshake_req *req,
 	struct tls_handshake_req *treq = handshake_req_private(req);
 
 	treq->th_peerid[0] = TLS_NO_PEERID;
-	if (info)
+	if (info) {
 		tls_handshake_remote_peerids(treq, info);
+		tls_handshake_record_size(treq, info);
+	}
 
 	if (!status)
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fc88e34b7f33..70ffc4f5e382 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1024,6 +1024,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	ssize_t copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
 	struct tls_rec *rec;
+	u32 tls_record_size_limit;
 	int required_size;
 	int num_async = 0;
 	bool full_record;
@@ -1045,6 +1046,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		}
 	}
 
+	tls_record_size_limit = min_not_zero(tls_ctx->tls_record_size_limit,
+					     TLS_MAX_PAYLOAD_SIZE);
+
 	while (msg_data_left(msg)) {
 		if (sk->sk_err) {
 			ret = -sk->sk_err;
@@ -1066,7 +1070,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_record_size_limit - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.50.1


