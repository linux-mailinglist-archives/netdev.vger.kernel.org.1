Return-Path: <netdev+bounces-218607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A11B3D8DD
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A73B9DE2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 05:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09B221CA14;
	Mon,  1 Sep 2025 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtKHHL2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A523D7C4;
	Mon,  1 Sep 2025 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705018; cv=none; b=ZolsbshXG2ZHZH0qeuo9VnYNMa93dVbiZBoQNPmhsXmU8h6DF6LdUH1pn529zEGAxrG7LfBcpE4K1OczNrR41zEtuW5xXN4qgxbrsIcJxyFf0FWACF9LtZh7g4Z96vpdSsYik7n8FJytjDRHeG3mlejPe8HYkjs0fS0KgWW6tg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705018; c=relaxed/simple;
	bh=llhJJljrqXE/nWKIJH6bsdO9U75zcLrBsfAa7Q+iaFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlZh3wIqIIhAPYMSm8/hEPivFxLU3GhxWeELeFpgZJwnzFDy6HdzXf53BOuYys5m/dBnB2kd4O01QzweIOOVIJwN4T9DNf3HrFmdmZhY/Ju4IdrQfHVpR6RcBd6h4IKNQkmfe/yQrQnw2a70Rf5aN+/qLkiUujBN1wAKe3pDvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtKHHL2g; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c645aaa58so2644492a12.2;
        Sun, 31 Aug 2025 22:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756705016; x=1757309816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KAcVYU3uNaOGJX0D+bRdMikx+btd5MUoQ4qyYq/2YM=;
        b=FtKHHL2g0EmlTR2s3i5Ra3njZcJsHfIfy5ljWwXf6eDakKxJk2q9UZMS6oAYsrWeWD
         L7SFGMZq1tZLo4Sh4mKPibUG8or7rt0Ex/JS6aRw1uMwd8F7UObMqYni7ihhNtAqslVF
         tA4Z7MnuEHPVoYM525C+YcnauMQlqqU++m5phqa0JzslnccNnZhb/BqEndblISl82HvJ
         suqL93KBKZr8IbYVXki4sDwDDJAYTZ6NiXtwD/z27a2F7Ib3wmorYkRrpMtzDCUWv8DM
         4NB50M0klvuiHWHFOBFRSPS4NU9HifRYUtC5t4mMm9ms/gh3zln4X56PU+/qzxBhZMkq
         21ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756705016; x=1757309816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KAcVYU3uNaOGJX0D+bRdMikx+btd5MUoQ4qyYq/2YM=;
        b=hFgbNCFe0IxMgoSjoeJuhjRrWs/UTHZC5MO7Mea/iuBfzZKRWxqE8Kbf+2YsrxUklX
         yKdQmWARCpE4lpWqssCfYsmEmYuIV65eQ88TBZLI9WmNmQK2uQMgpqF5bR+ALM+fzs0Q
         WDdcbp1BIybKE2271cvAIPNwbX2VId7z114R+SnynzDF9FoKmxQspRbnUVi2jnGHAzXD
         jgsM9Rtd7bGu7XGebHUQyH8bYtg7hDRqojpyuYHH4nxOofj5sjZu66z8J70NuNQR3mOT
         XC+wR3OiwWMON+HeT1LeYEootIlIvU8RjsHSc+WsTr1P/BuRrqHeuEqvmcw2SE4O64bw
         yhHw==
X-Forwarded-Encrypted: i=1; AJvYcCVOCcjBo/cN8amqP4YRzg+zU4luwmVniaSNJIfNtslwyddv63sgZyNKGfOeb95GNqTrOjggrljf@vger.kernel.org, AJvYcCVeZ4hNUkuVNIiwTgSYdXZ28PZp4xu8HSTgukepGx2PHO/Cu/YJb6yR58qvbFn2nECIMmrDKiyREJf01g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfD60y2d2BT5C4dVmxVIEc0v8eRPFFksqaHHRbhjK2uxqinp1
	ARHzl+/sFnPTPLmwuY6on4ruddmIt9qDZDBgQUZe4yU/9dlLANOK8q66266pOA==
X-Gm-Gg: ASbGncu+a4TQ6FsIa961r7EUKImvgPRVbD9WVa7epnUdrUQSFsxasmqlORcB9GXLb/W
	5G9gj4jcZWk9m88kBB+TNi3Gs2VQhIS/ktJ1RkekxKlfelwuWZtD2R2fNn5U2meepJ91e/w4oJM
	4PMeNPD37xePCvYBAUh2WLE6kJKfsJ4WwBCVP2yWJoTn0kzJC6w3md64bT22DDwbpEnRe6ysGjv
	kiIc7S/aCyI+De+cAcIVvQt9YFJ9+kMHQebulp63PFTWV8lQ+7+vD+Cm1u+OuCaJ8mt0J/1wcGf
	Lohe9dBCRh57RaqBcvv7gqTnrsowdyuTD2KXo1Fr1JrNFienX4871EsEnteAcVm0sOIONCDppTw
	nuYBn/PZI6kwktL555KiCEtVmqA==
X-Google-Smtp-Source: AGHT+IGSocsv1UrbOfElqChC8G4ok7ZHIlxd4vHe9Yfc5PSkMlMar8u2FM+ORvRGYMuaN4FFKpyUSQ==
X-Received: by 2002:a17:902:e842:b0:242:9be2:102b with SMTP id d9443c01a7336-249446d2e9dmr82660375ad.0.1756705016354;
        Sun, 31 Aug 2025 22:36:56 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037027casm93399325ad.5.2025.08.31.22.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 22:36:55 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: chuck.lever@oracle.com,
	kernel-tls-handshake@lists.linux.dev
Cc: "David S . Miller" <davem@davemloft.net>,
	donald.hunter@gmail.com,
	edumazet@google.com,
	hare@kernel.org,
	horms@kernel.org,
	jakub.kicinski@kernel.org,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wilfred.mallawa@wdc.com,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] net/tls: allow limiting maximum record size
Date: Mon,  1 Sep 2025 15:36:19 +1000
Message-ID: <20250901053618.103198-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
support. For these devices, supporting TLS record size negotiation is
necessary because the maximum TLS record size supported by the controller
is less than the default 16KB currently used by the kernel.

This patch adds support for retrieving the negotiated record size limit
during a handshake, and enforcing it at the TLS layer such that outgoing
records are no larger than the size negotiated. This patch depends on
the respective userspace support in tlshd [2] and GnuTLS [3].

[1] https://www.rfc-editor.org/rfc/rfc8449
[2] https://github.com/oracle/ktls-utils/pull/112
[3] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/netlink/specs/handshake.yaml |  3 +++
 include/net/tls.h                          |  2 ++
 include/uapi/linux/handshake.h             |  1 +
 net/handshake/genl.c                       |  5 ++--
 net/handshake/tlshd.c                      | 29 +++++++++++++++++++++-
 net/tls/tls_sw.c                           |  6 ++++-
 6 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..0dbe5d0c8507 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -87,6 +87,9 @@ attribute-sets:
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
index 662e7de46c54..645eeb76622f 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -55,6 +55,7 @@ enum {
 	HANDSHAKE_A_DONE_STATUS = 1,
 	HANDSHAKE_A_DONE_SOCKFD,
 	HANDSHAKE_A_DONE_REMOTE_AUTH,
+	HANDSHAKE_A_DONE_RECORD_SIZE_LIMIT,
 
 	__HANDSHAKE_A_DONE_MAX,
 	HANDSHAKE_A_DONE_MAX = (__HANDSHAKE_A_DONE_MAX - 1)
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index f55d14d7b726..fb8962ae7131 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -16,10 +16,11 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 };
 
 /* HANDSHAKE_CMD_DONE - do */
-static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
+static const struct nla_policy handshake_done_nl_policy[__HANDSHAKE_A_DONE_MAX] = {
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
+		.maxattr	= HANDSHAKE_A_DONE_MAX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 081093dfd553..8847cbf20d45 100644
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
index bac65d0d4e3e..85b1243b4210 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1037,6 +1037,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	ssize_t copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
 	struct tls_rec *rec;
+	u32 tls_record_size_limit;
 	int required_size;
 	int num_async = 0;
 	bool full_record;
@@ -1058,6 +1059,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		}
 	}
 
+	tls_record_size_limit = min_not_zero(tls_ctx->tls_record_size_limit,
+					     TLS_MAX_PAYLOAD_SIZE);
+
 	while (msg_data_left(msg)) {
 		if (sk->sk_err) {
 			ret = -sk->sk_err;
@@ -1079,7 +1083,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_record_size_limit - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.51.0


