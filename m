Return-Path: <netdev+bounces-234019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28105C1B689
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D071AA07FB
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA44302CA2;
	Wed, 29 Oct 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRad6eDb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011928B415
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748780; cv=none; b=BArMU3d59bBaBacWqP/qvZWp+3EVWgCzsOdcagGkI6se2VFKYcD2eZerpvt6fou5SEcuaaNkR2ymrSNYPuKKqg7WfQCh4sRpnTqzDEuHofWxsnhW7xx8TkNSn33REjF/MaqitXbPchyYBIBlZlsgdK9a69TyDTUar1L9IHDsoeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748780; c=relaxed/simple;
	bh=j6rMvmZVEyz49mcHCbuTEMV13I8K4jzzM2YzSV1V5l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qmb020OD7PoFI4XyJEvpgGJH/ZEtHvkzL8XZJCDjPpKydjX3V9BEn8mH8RCGkWQQ+3U6vbctCC9E6giwMl711zkbGrlFhQqOnFnT0iLS4Zav2nJQPnBvMhdfjNS1V4BhdABPHlMVqSUzk2ElGytLUwMVPcFV+hvXzvp7Tu6h5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRad6eDb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7f7835f4478so52609256d6.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748776; x=1762353576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAClGs/GwS0JZ7hstv19SxMgiZGTZDN2pCpYJ/jGzo0=;
        b=dRad6eDbFssHpdS3F1qLzGSsTm2PblOk1Kr/Y9JaAmzG13iQzvnsah406TofNBHbxs
         NwsdACSgXCztzl8s1K2OWH2byKTo2SOwunLq5jryItN0kNGvWBzf29BXN8Rz/sCwbCzB
         /iPT1XBFgZLMOWH6bU8NVJY+ZPe0y8mtdKSQhkunOx3u91KRgRbin3BttIeswzbrD+lI
         NyIzPGABwrxLTll7VDzuZypWGtB+CTFYngQLzTMDBrXmv8zS2elAHUxuBIZkoiiYJw3T
         u19eSk6EMg4YSuzXIrJIAqeME2N1wM3ynfyyIFMTYqe/m8XlkDtF+kcUvCFrJaq6hwjl
         otWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748776; x=1762353576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAClGs/GwS0JZ7hstv19SxMgiZGTZDN2pCpYJ/jGzo0=;
        b=eWTnhlhA9wVlbnxR5t+9+Nl+U4Vv4GAJtaE4+H9sCTDcMi139vnwOEbau7R9m5zYNP
         7xvIx6UDcXtc4Juysw7pNOcAWK0en6w11308ZoV6HVlWc3/m+UBaPV1t11sYlF6NivxB
         TGaTi17haIviraqWvAxHsLxyAeIOwimbuESXEIASuBmyoh+mXighb2+LCOa8IUYEp0tu
         HFJPReusgtR/+O44TK49dzN6HQfHt2yhbhvc5f1bNNHwvurOJhhSbQz+V/U54mtZftRv
         Zo9S1s1kGcnSMpsKz5pNSIRzp17elqWno76L1gXeM5CFoQfXW/eDC94zDDVSJGFljw8Z
         Ro7w==
X-Gm-Message-State: AOJu0YxLmJt3xCpRKB1UG/yFnp19AzS7kLS6RDEXn8Rm5S0Bdq0x0vXT
	lmW9JJojnBB3ZTkQbBz6YHSw+JNLWHQH7bExV/wAAgdrIyoGiBvWplGObpaXwLqXK78=
X-Gm-Gg: ASbGncugVIyM9un6/Bmx29gBSu+XGtf1zO3+1mHda6aeadA4sQn0FAwrDS2sIp2gkow
	+5jZYNxrI2uipwlWV1ymH37iubFsWNHSf1Yxu/QKkebFmxaWNn8hXl9S1dLsbY0GcVtgFZTtssA
	cpXUIXmCPxlV+mebMLvOOKnSfSs/7r8UUR7FuNYlwppiPsSlvuh5kExNOV9kObi3l9/eZ4axddZ
	+qJ3Ys80cSnLBYbjt+9XOaOkT3MrnC/yDpu5pK7fKPWG8PywiUOxb1EO7KAd/wjtLuKUgv03r51
	4WEIMSYz4Fre33Xmo92qY3YXHyuDhqNSvzhOeVmbn/fhgHW1baXCxfNu3lyRIwnFuA7XvjB30QZ
	MkohQ4vmFtkUaYRPHLYbbBhBCrNoF9vRJUIt6lkMZOGlUsVT3Z0QSq0eU1EG7W+SfSpvzk1u8Qp
	aJSamvY9weNztKCMLWYkCH3O1BcDrEmnHoqP/x3kBHXU5y6xaGduw=
X-Google-Smtp-Source: AGHT+IFd4Q9GM+2o/KY4KdZjw+ivrIoUr84IB37v+ZOkHo2Fcttse26OHC7m84UkoIvD/vhtl0OIxw==
X-Received: by 2002:a05:6214:2262:b0:87c:20f5:84e2 with SMTP id 6a1803df08f44-88009b33047mr45752566d6.25.1761748775822;
        Wed, 29 Oct 2025 07:39:35 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8bc4sm99556176d6.7.2025.10.29.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:39:35 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	Thomas Dreibholz <dreibh@simula.no>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v4 06/15] quic: add stream management
Date: Wed, 29 Oct 2025 10:35:48 -0400
Message-ID: <6b527b669fe05f9743e37d9f584f7cd492a7649b.1761748557.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1761748557.git.lucien.xin@gmail.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch introduces 'struct quic_stream_table' for managing QUIC streams,
each represented by 'struct quic_stream'.

It implements mechanisms for acquiring and releasing streams on both the
send and receive paths, ensuring efficient lifecycle management during
transmission and reception.

- quic_stream_send_get(): Acquire a send-side stream by ID and flags
  during TX path.

- quic_stream_recv_get(): Acquire a receive-side stream by ID during
  RX path.

- quic_stream_send_put(): Release a send-side stream when sending is
  done.

- quic_stream_recv_put(): Release a receive-side stream when receiving
  is done.

It includes logic to detect when stream ID limits are reached and when
control frames should be sent to update or request limits from the peer.

- quic_stream_id_exceeds(): Check a stream ID would exceed local (recv)
  or peer (send) limits.

- quic_stream_max_streams_update(): Determines whether a
  MAX_STREAMS_UNI/BIDI frame should be sent to the peer.

Note stream hash table is per socket, the operations on it are always
protected by the sock lock.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v3:
  - Merge send/recv stream helpers into unified functions to reduce code:
    * quic_stream_id_send/recv() → quic_stream_id_valid()
    * quic_stream_id_send/recv_closed() → quic_stream_id_closed()
    * quic_stream_id_send/recv_exceeds() → quic_stream_id_exceeds()
    (pointed out by Paolo).
  - Clarify in changelog that stream hash table is always protected by sock
    lock (suggested by Paolo).
  - quic_stream_init/free(): adjust for new hashtable type; call
    quic_stream_delete() in quic_stream_free() to avoid open-coded logic.
  - Receiving streams: delete stream only when fully read or reset, instead
    of when no data was received. Prevents freeing a stream while a FIN
    with no data is still queued.
v4:
  - Replace struct quic_shash_table with struct hlist_head for the
    stream hashtable. Since they are protected by the socket lock,
    no per-chain lock is needed.
  - Initialize stream to NULL in stream creation functions to avoid
    warnings from Smatch (reported by Simon).
  - Allocate send streams with GFP_KERNEL_ACCOUNT and receive streams
    with GFP_ATOMIC | __GFP_ACCOUNT for memory accounting (suggested
    by Paolo).
---
 net/quic/Makefile |   2 +-
 net/quic/socket.c |   5 +
 net/quic/socket.h |   8 +
 net/quic/stream.c | 514 ++++++++++++++++++++++++++++++++++++++++++++++
 net/quic/stream.h | 136 ++++++++++++
 5 files changed, 664 insertions(+), 1 deletion(-)
 create mode 100644 net/quic/stream.c
 create mode 100644 net/quic/stream.h

diff --git a/net/quic/Makefile b/net/quic/Makefile
index 13bf4a4e5442..094e9da5d739 100644
--- a/net/quic/Makefile
+++ b/net/quic/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_IP_QUIC) += quic.o
 
-quic-y := common.o family.o protocol.o socket.o
+quic-y := common.o family.o protocol.o socket.o stream.o
diff --git a/net/quic/socket.c b/net/quic/socket.c
index 08d21389c52e..d0a50b218f9f 100644
--- a/net/quic/socket.c
+++ b/net/quic/socket.c
@@ -41,6 +41,9 @@ static int quic_init_sock(struct sock *sk)
 	sk->sk_write_space = quic_write_space;
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
 
+	if (quic_stream_init(quic_streams(sk)))
+		return -ENOMEM;
+
 	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sysctl_quic_wmem[1]));
 	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sysctl_quic_rmem[1]));
 
@@ -52,6 +55,8 @@ static int quic_init_sock(struct sock *sk)
 
 static void quic_destroy_sock(struct sock *sk)
 {
+	quic_stream_free(quic_streams(sk));
+
 	quic_data_free(quic_ticket(sk));
 	quic_data_free(quic_token(sk));
 	quic_data_free(quic_alpn(sk));
diff --git a/net/quic/socket.h b/net/quic/socket.h
index aeaefc677973..3eba18514ae6 100644
--- a/net/quic/socket.h
+++ b/net/quic/socket.h
@@ -13,6 +13,7 @@
 
 #include "common.h"
 #include "family.h"
+#include "stream.h"
 
 #include "protocol.h"
 
@@ -34,6 +35,8 @@ struct quic_sock {
 	struct quic_data		ticket;
 	struct quic_data		token;
 	struct quic_data		alpn;
+
+	struct quic_stream_table	streams;
 };
 
 struct quic6_sock {
@@ -71,6 +74,11 @@ static inline struct quic_data *quic_alpn(const struct sock *sk)
 	return &quic_sk(sk)->alpn;
 }
 
+static inline struct quic_stream_table *quic_streams(const struct sock *sk)
+{
+	return &quic_sk(sk)->streams;
+}
+
 static inline bool quic_is_establishing(struct sock *sk)
 {
 	return sk->sk_state == QUIC_SS_ESTABLISHING;
diff --git a/net/quic/stream.c b/net/quic/stream.c
new file mode 100644
index 000000000000..844739fb75cf
--- /dev/null
+++ b/net/quic/stream.c
@@ -0,0 +1,514 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <linux/quic.h>
+
+#include "common.h"
+#include "stream.h"
+
+/* Check if a stream ID is valid for sending or receiving. */
+static bool quic_stream_id_valid(s64 stream_id, bool is_serv, bool send)
+{
+	u8 type = (stream_id & QUIC_STREAM_TYPE_MASK);
+
+	if (send) {
+		if (is_serv)
+			return type != QUIC_STREAM_TYPE_CLIENT_UNI;
+		return type != QUIC_STREAM_TYPE_SERVER_UNI;
+	}
+	if (is_serv)
+		return type != QUIC_STREAM_TYPE_SERVER_UNI;
+	return type != QUIC_STREAM_TYPE_CLIENT_UNI;
+}
+
+/* Check if a stream ID was initiated locally. */
+static bool quic_stream_id_local(s64 stream_id, u8 is_serv)
+{
+	return is_serv ^ !(stream_id & QUIC_STREAM_TYPE_SERVER_MASK);
+}
+
+/* Check if a stream ID represents a unidirectional stream. */
+static bool quic_stream_id_uni(s64 stream_id)
+{
+	return stream_id & QUIC_STREAM_TYPE_UNI_MASK;
+}
+
+#define QUIC_STREAM_HT_SIZE	64
+
+static struct hlist_head *quic_stream_head(struct quic_stream_table *streams, s64 stream_id)
+{
+	return &streams->head[stream_id & (QUIC_STREAM_HT_SIZE - 1)];
+}
+
+struct quic_stream *quic_stream_find(struct quic_stream_table *streams, s64 stream_id)
+{
+	struct hlist_head *head = quic_stream_head(streams, stream_id);
+	struct quic_stream *stream;
+
+	hlist_for_each_entry(stream, head, node) {
+		if (stream->id == stream_id)
+			break;
+	}
+	return stream;
+}
+
+static void quic_stream_add(struct quic_stream_table *streams, struct quic_stream *stream)
+{
+	struct hlist_head *head;
+
+	head = quic_stream_head(streams, stream->id);
+	hlist_add_head(&stream->node, head);
+}
+
+static void quic_stream_delete(struct quic_stream *stream)
+{
+	hlist_del_init(&stream->node);
+	kfree(stream);
+}
+
+/* Create and register new streams for sending. */
+static struct quic_stream *quic_stream_send_create(struct quic_stream_table *streams,
+						   s64 max_stream_id, u8 is_serv)
+{
+	struct quic_stream *stream = NULL;
+	s64 stream_id;
+
+	stream_id = streams->send.next_bidi_stream_id;
+	if (quic_stream_id_uni(max_stream_id))
+		stream_id = streams->send.next_uni_stream_id;
+
+	/* rfc9000#section-2.1: A stream ID that is used out of order results in all streams
+	 * of that type with lower-numbered stream IDs also being opened.
+	 */
+	while (stream_id <= max_stream_id) {
+		stream = kzalloc(sizeof(*stream), GFP_KERNEL_ACCOUNT);
+		if (!stream)
+			return NULL;
+
+		stream->id = stream_id;
+		if (quic_stream_id_uni(stream_id)) {
+			stream->send.max_bytes = streams->send.max_stream_data_uni;
+
+			if (streams->send.next_uni_stream_id < stream_id + QUIC_STREAM_ID_STEP)
+				streams->send.next_uni_stream_id = stream_id + QUIC_STREAM_ID_STEP;
+			streams->send.streams_uni++;
+
+			quic_stream_add(streams, stream);
+			stream_id += QUIC_STREAM_ID_STEP;
+			continue;
+		}
+
+		if (streams->send.next_bidi_stream_id < stream_id + QUIC_STREAM_ID_STEP)
+			streams->send.next_bidi_stream_id = stream_id + QUIC_STREAM_ID_STEP;
+		streams->send.streams_bidi++;
+
+		if (quic_stream_id_local(stream_id, is_serv)) {
+			stream->send.max_bytes = streams->send.max_stream_data_bidi_remote;
+			stream->recv.max_bytes = streams->recv.max_stream_data_bidi_local;
+		} else {
+			stream->send.max_bytes = streams->send.max_stream_data_bidi_local;
+			stream->recv.max_bytes = streams->recv.max_stream_data_bidi_remote;
+		}
+		stream->recv.window = stream->recv.max_bytes;
+
+		quic_stream_add(streams, stream);
+		stream_id += QUIC_STREAM_ID_STEP;
+	}
+	return stream;
+}
+
+/* Create and register new streams for receiving. */
+static struct quic_stream *quic_stream_recv_create(struct quic_stream_table *streams,
+						   s64 max_stream_id, u8 is_serv)
+{
+	struct quic_stream *stream = NULL;
+	s64 stream_id;
+
+	stream_id = streams->recv.next_bidi_stream_id;
+	if (quic_stream_id_uni(max_stream_id))
+		stream_id = streams->recv.next_uni_stream_id;
+
+	/* rfc9000#section-2.1: A stream ID that is used out of order results in all streams
+	 * of that type with lower-numbered stream IDs also being opened.
+	 */
+	while (stream_id <= max_stream_id) {
+		stream = kzalloc(sizeof(*stream), GFP_ATOMIC | __GFP_ACCOUNT);
+		if (!stream)
+			return NULL;
+
+		stream->id = stream_id;
+		if (quic_stream_id_uni(stream_id)) {
+			stream->recv.window = streams->recv.max_stream_data_uni;
+			stream->recv.max_bytes = stream->recv.window;
+
+			if (streams->recv.next_uni_stream_id < stream_id + QUIC_STREAM_ID_STEP)
+				streams->recv.next_uni_stream_id = stream_id + QUIC_STREAM_ID_STEP;
+			streams->recv.streams_uni++;
+
+			quic_stream_add(streams, stream);
+			stream_id += QUIC_STREAM_ID_STEP;
+			continue;
+		}
+
+		if (streams->recv.next_bidi_stream_id < stream_id + QUIC_STREAM_ID_STEP)
+			streams->recv.next_bidi_stream_id = stream_id + QUIC_STREAM_ID_STEP;
+		streams->recv.streams_bidi++;
+
+		if (quic_stream_id_local(stream_id, is_serv)) {
+			stream->send.max_bytes = streams->send.max_stream_data_bidi_remote;
+			stream->recv.max_bytes = streams->recv.max_stream_data_bidi_local;
+		} else {
+			stream->send.max_bytes = streams->send.max_stream_data_bidi_local;
+			stream->recv.max_bytes = streams->recv.max_stream_data_bidi_remote;
+		}
+		stream->recv.window = stream->recv.max_bytes;
+
+		quic_stream_add(streams, stream);
+		stream_id += QUIC_STREAM_ID_STEP;
+	}
+	return stream;
+}
+
+/* Check if a send or receive stream ID is already closed. */
+static bool quic_stream_id_closed(struct quic_stream_table *streams, s64 stream_id, bool send)
+{
+	if (quic_stream_id_uni(stream_id)) {
+		if (send)
+			return stream_id < streams->send.next_uni_stream_id;
+		return stream_id < streams->recv.next_uni_stream_id;
+	}
+	if (send)
+		return stream_id < streams->send.next_bidi_stream_id;
+	return stream_id < streams->recv.next_bidi_stream_id;
+}
+
+/* Check if a stream ID would exceed local (recv) or peer (send) limits. */
+bool quic_stream_id_exceeds(struct quic_stream_table *streams, s64 stream_id, bool send)
+{
+	u64 nstreams;
+
+	if (!send) {
+		if (quic_stream_id_uni(stream_id))
+			return stream_id > streams->recv.max_uni_stream_id;
+		return stream_id > streams->recv.max_bidi_stream_id;
+	}
+
+	if (quic_stream_id_uni(stream_id)) {
+		if (stream_id > streams->send.max_uni_stream_id)
+			return true;
+		stream_id -= streams->send.next_uni_stream_id;
+		nstreams = quic_stream_id_to_streams(stream_id);
+		return nstreams + streams->send.streams_uni > streams->send.max_streams_uni;
+	}
+
+	if (stream_id > streams->send.max_bidi_stream_id)
+		return true;
+	stream_id -= streams->send.next_bidi_stream_id;
+	nstreams = quic_stream_id_to_streams(stream_id);
+	return nstreams + streams->send.streams_bidi > streams->send.max_streams_bidi;
+}
+
+/* Get or create a send stream by ID. */
+struct quic_stream *quic_stream_send_get(struct quic_stream_table *streams, s64 stream_id,
+					 u32 flags, bool is_serv)
+{
+	struct quic_stream *stream;
+
+	if (!quic_stream_id_valid(stream_id, is_serv, true))
+		return ERR_PTR(-EINVAL);
+
+	stream = quic_stream_find(streams, stream_id);
+	if (stream) {
+		if ((flags & MSG_QUIC_STREAM_NEW) &&
+		    stream->send.state != QUIC_STREAM_SEND_STATE_READY)
+			return ERR_PTR(-EINVAL);
+		return stream;
+	}
+
+	if (quic_stream_id_closed(streams, stream_id, true))
+		return ERR_PTR(-ENOSTR);
+
+	if (!(flags & MSG_QUIC_STREAM_NEW))
+		return ERR_PTR(-EINVAL);
+
+	if (quic_stream_id_exceeds(streams, stream_id, true))
+		return ERR_PTR(-EAGAIN);
+
+	stream = quic_stream_send_create(streams, stream_id, is_serv);
+	if (!stream)
+		return ERR_PTR(-ENOSTR);
+	streams->send.active_stream_id = stream_id;
+	return stream;
+}
+
+/* Get or create a receive stream by ID. */
+struct quic_stream *quic_stream_recv_get(struct quic_stream_table *streams, s64 stream_id,
+					 bool is_serv)
+{
+	struct quic_stream *stream;
+
+	if (!quic_stream_id_valid(stream_id, is_serv, false))
+		return ERR_PTR(-EINVAL);
+
+	stream = quic_stream_find(streams, stream_id);
+	if (stream)
+		return stream;
+
+	if (quic_stream_id_local(stream_id, is_serv)) {
+		if (quic_stream_id_closed(streams, stream_id, true))
+			return ERR_PTR(-ENOSTR);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (quic_stream_id_closed(streams, stream_id, false))
+		return ERR_PTR(-ENOSTR);
+
+	if (quic_stream_id_exceeds(streams, stream_id, false))
+		return ERR_PTR(-EAGAIN);
+
+	stream = quic_stream_recv_create(streams, stream_id, is_serv);
+	if (!stream)
+		return ERR_PTR(-ENOSTR);
+	if (quic_stream_id_valid(stream_id, is_serv, true))
+		streams->send.active_stream_id = stream_id;
+	return stream;
+}
+
+/* Release or clean up a send stream. This function updates stream counters and state when
+ * a send stream has either successfully sent all data or has been reset.
+ */
+void quic_stream_send_put(struct quic_stream_table *streams, struct quic_stream *stream,
+			  bool is_serv)
+{
+	if (quic_stream_id_uni(stream->id)) {
+		/* For unidirectional streams, decrement uni count and delete immediately. */
+		streams->send.streams_uni--;
+		quic_stream_delete(stream);
+		return;
+	}
+
+	/* For bidi streams, only proceed if receive side is in a final state. */
+	if (stream->recv.state != QUIC_STREAM_RECV_STATE_RECVD &&
+	    stream->recv.state != QUIC_STREAM_RECV_STATE_READ &&
+	    stream->recv.state != QUIC_STREAM_RECV_STATE_RESET_RECVD)
+		return;
+
+	if (quic_stream_id_local(stream->id, is_serv)) {
+		/* Local-initiated stream: mark send done and decrement send.bidi count. */
+		if (!stream->send.done) {
+			stream->send.done = 1;
+			streams->send.streams_bidi--;
+		}
+		goto out;
+	}
+	/* Remote-initiated stream: mark recv done and decrement recv bidi count. */
+	if (!stream->recv.done) {
+		stream->recv.done = 1;
+		streams->recv.streams_bidi--;
+		streams->recv.bidi_pending = 1;
+	}
+out:
+	/* Delete stream if fully read or reset. */
+	if (stream->recv.state != QUIC_STREAM_RECV_STATE_RECVD)
+		quic_stream_delete(stream);
+}
+
+/* Release or clean up a receive stream. This function updates stream counters and state when
+ * the receive side has either consumed all data or has been reset.
+ */
+void quic_stream_recv_put(struct quic_stream_table *streams, struct quic_stream *stream,
+			  bool is_serv)
+{
+	if (quic_stream_id_uni(stream->id)) {
+		/* For uni streams, decrement uni count and mark done. */
+		if (!stream->recv.done) {
+			stream->recv.done = 1;
+			streams->recv.streams_uni--;
+			streams->recv.uni_pending = 1;
+		}
+		goto out;
+	}
+
+	/* For bidi streams, only proceed if send side is in a final state. */
+	if (stream->send.state != QUIC_STREAM_SEND_STATE_RECVD &&
+	    stream->send.state != QUIC_STREAM_SEND_STATE_RESET_RECVD)
+		return;
+
+	if (quic_stream_id_local(stream->id, is_serv)) {
+		/* Local-initiated stream: mark send done and decrement send.bidi count. */
+		if (!stream->send.done) {
+			stream->send.done = 1;
+			streams->send.streams_bidi--;
+		}
+		goto out;
+	}
+	/* Remote-initiated stream: mark recv done and decrement recv bidi count. */
+	if (!stream->recv.done) {
+		stream->recv.done = 1;
+		streams->recv.streams_bidi--;
+		streams->recv.bidi_pending = 1;
+	}
+out:
+	/* Delete stream if fully read or reset. */
+	if (stream->recv.state != QUIC_STREAM_RECV_STATE_RECVD)
+		quic_stream_delete(stream);
+}
+
+/* Updates the maximum allowed incoming stream IDs if any streams were recently closed.
+ * Recalculates the max_uni and max_bidi stream ID limits based on the number of open
+ * streams and whether any were marked for deletion.
+ *
+ * Returns true if either max_uni or max_bidi was updated, indicating that a
+ * MAX_STREAMS_UNI or MAX_STREAMS_BIDI frame should be sent to the peer.
+ */
+bool quic_stream_max_streams_update(struct quic_stream_table *streams, s64 *max_uni, s64 *max_bidi)
+{
+	if (streams->recv.uni_pending) {
+		streams->recv.max_uni_stream_id =
+			streams->recv.next_uni_stream_id - QUIC_STREAM_ID_STEP +
+			((streams->recv.max_streams_uni - streams->recv.streams_uni) <<
+			 QUIC_STREAM_TYPE_BITS);
+		*max_uni = quic_stream_id_to_streams(streams->recv.max_uni_stream_id);
+		streams->recv.uni_pending = 0;
+	}
+	if (streams->recv.bidi_pending) {
+		streams->recv.max_bidi_stream_id =
+			streams->recv.next_bidi_stream_id - QUIC_STREAM_ID_STEP +
+			((streams->recv.max_streams_bidi - streams->recv.streams_bidi) <<
+			 QUIC_STREAM_TYPE_BITS);
+		*max_bidi = quic_stream_id_to_streams(streams->recv.max_bidi_stream_id);
+		streams->recv.bidi_pending = 0;
+	}
+
+	return *max_uni || *max_bidi;
+}
+
+int quic_stream_init(struct quic_stream_table *streams)
+{
+	struct hlist_head *head;
+	int i;
+
+	head = kmalloc_array(QUIC_STREAM_HT_SIZE, sizeof(*head), GFP_KERNEL);
+	if (!head)
+		return -ENOMEM;
+	for (i = 0; i < QUIC_STREAM_HT_SIZE; i++)
+		INIT_HLIST_HEAD(&head[i]);
+	streams->head = head;
+	return 0;
+}
+
+void quic_stream_free(struct quic_stream_table *streams)
+{
+	struct quic_stream *stream;
+	struct hlist_head *head;
+	struct hlist_node *tmp;
+	int i;
+
+	if (!streams->head)
+		return;
+
+	for (i = 0; i < QUIC_STREAM_HT_SIZE; i++) {
+		head = &streams->head[i];
+		hlist_for_each_entry_safe(stream, tmp, head, node)
+			quic_stream_delete(stream);
+	}
+	kfree(streams->head);
+}
+
+/* Populate transport parameters from stream hash table. */
+void quic_stream_get_param(struct quic_stream_table *streams, struct quic_transport_param *p,
+			   bool is_serv)
+{
+	if (p->remote) {
+		p->max_stream_data_bidi_remote = streams->send.max_stream_data_bidi_remote;
+		p->max_stream_data_bidi_local = streams->send.max_stream_data_bidi_local;
+		p->max_stream_data_uni = streams->send.max_stream_data_uni;
+		p->max_streams_bidi = streams->send.max_streams_bidi;
+		p->max_streams_uni = streams->send.max_streams_uni;
+		return;
+	}
+
+	p->max_stream_data_bidi_remote = streams->recv.max_stream_data_bidi_remote;
+	p->max_stream_data_bidi_local = streams->recv.max_stream_data_bidi_local;
+	p->max_stream_data_uni = streams->recv.max_stream_data_uni;
+	p->max_streams_bidi = streams->recv.max_streams_bidi;
+	p->max_streams_uni = streams->recv.max_streams_uni;
+}
+
+/* Configure stream hashtable from transport parameters. */
+void quic_stream_set_param(struct quic_stream_table *streams, struct quic_transport_param *p,
+			   bool is_serv)
+{
+	u8 type;
+
+	if (p->remote) {
+		streams->send.max_stream_data_bidi_local = p->max_stream_data_bidi_local;
+		streams->send.max_stream_data_bidi_remote = p->max_stream_data_bidi_remote;
+		streams->send.max_stream_data_uni = p->max_stream_data_uni;
+		streams->send.max_streams_bidi = p->max_streams_bidi;
+		streams->send.max_streams_uni = p->max_streams_uni;
+		streams->send.active_stream_id = -1;
+
+		if (is_serv) {
+			type = QUIC_STREAM_TYPE_SERVER_BIDI;
+			streams->send.max_bidi_stream_id =
+				quic_stream_streams_to_id(p->max_streams_bidi, type);
+			streams->send.next_bidi_stream_id = type;
+
+			type = QUIC_STREAM_TYPE_SERVER_UNI;
+			streams->send.max_uni_stream_id =
+				quic_stream_streams_to_id(p->max_streams_uni, type);
+			streams->send.next_uni_stream_id = type;
+			return;
+		}
+
+		type = QUIC_STREAM_TYPE_CLIENT_BIDI;
+		streams->send.max_bidi_stream_id =
+			quic_stream_streams_to_id(p->max_streams_bidi, type);
+		streams->send.next_bidi_stream_id = type;
+
+		type = QUIC_STREAM_TYPE_CLIENT_UNI;
+		streams->send.max_uni_stream_id =
+			quic_stream_streams_to_id(p->max_streams_uni, type);
+		streams->send.next_uni_stream_id = type;
+		return;
+	}
+
+	streams->recv.max_stream_data_bidi_local = p->max_stream_data_bidi_local;
+	streams->recv.max_stream_data_bidi_remote = p->max_stream_data_bidi_remote;
+	streams->recv.max_stream_data_uni = p->max_stream_data_uni;
+	streams->recv.max_streams_bidi = p->max_streams_bidi;
+	streams->recv.max_streams_uni = p->max_streams_uni;
+
+	if (is_serv) {
+		type = QUIC_STREAM_TYPE_CLIENT_BIDI;
+		streams->recv.max_bidi_stream_id =
+			quic_stream_streams_to_id(p->max_streams_bidi, type);
+		streams->recv.next_bidi_stream_id = type;
+
+		type = QUIC_STREAM_TYPE_CLIENT_UNI;
+		streams->recv.max_uni_stream_id =
+			quic_stream_streams_to_id(p->max_streams_uni, type);
+		streams->recv.next_uni_stream_id = type;
+		return;
+	}
+
+	type = QUIC_STREAM_TYPE_SERVER_BIDI;
+	streams->recv.max_bidi_stream_id =
+		quic_stream_streams_to_id(p->max_streams_bidi, type);
+	streams->recv.next_bidi_stream_id = type;
+
+	type = QUIC_STREAM_TYPE_SERVER_UNI;
+	streams->recv.max_uni_stream_id =
+		quic_stream_streams_to_id(p->max_streams_uni, type);
+	streams->recv.next_uni_stream_id = type;
+}
diff --git a/net/quic/stream.h b/net/quic/stream.h
new file mode 100644
index 000000000000..acdb7c59b34e
--- /dev/null
+++ b/net/quic/stream.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_DEF_STREAMS	100
+#define QUIC_MAX_STREAMS	4096ULL
+
+/*
+ * rfc9000#section-2.1:
+ *
+ *   The least significant bit (0x01) of the stream ID identifies the initiator of the stream.
+ *   Client-initiated streams have even-numbered stream IDs (with the bit set to 0), and
+ *   server-initiated streams have odd-numbered stream IDs (with the bit set to 1).
+ *
+ *   The second least significant bit (0x02) of the stream ID distinguishes between bidirectional
+ *   streams (with the bit set to 0) and unidirectional streams (with the bit set to 1).
+ */
+#define QUIC_STREAM_TYPE_BITS	2
+#define QUIC_STREAM_ID_STEP	BIT(QUIC_STREAM_TYPE_BITS)
+
+#define QUIC_STREAM_TYPE_CLIENT_BIDI	0x00
+#define QUIC_STREAM_TYPE_SERVER_BIDI	0x01
+#define QUIC_STREAM_TYPE_CLIENT_UNI	0x02
+#define QUIC_STREAM_TYPE_SERVER_UNI	0x03
+
+struct quic_stream {
+	struct hlist_node node;
+	s64 id;				/* Stream ID as defined in RFC 9000 Section 2.1 */
+	struct {
+		/* Sending-side stream level flow control */
+		u64 last_max_bytes;	/* Maximum send offset advertised by peer at last update */
+		u64 max_bytes;		/* Current maximum offset we are allowed to send to */
+		u64 bytes;		/* Bytes already sent to peer */
+
+		u32 errcode;		/* Application error code to send in RESET_STREAM */
+		u32 frags;		/* Number of sent STREAM frames not yet acknowledged */
+		u8 state;		/* Send stream state, per rfc9000#section-3.1 */
+
+		u8 data_blocked:1;	/* True if flow control blocks sending more data */
+		u8 done:1;		/* True if application indicated end of stream (FIN sent) */
+	} send;
+	struct {
+		/* Receiving-side stream level flow control */
+		u64 max_bytes;		/* Maximum offset peer is allowed to send to */
+		u64 window;		/* Remaining receive window before advertise a new limit */
+		u64 bytes;		/* Bytes consumed by application from the stream */
+
+		u64 highest;		/* Highest received offset */
+		u64 offset;		/* Offset up to which data is in buffer or consumed */
+		u64 finalsz;		/* Final size of the stream if FIN received */
+
+		u32 frags;		/* Number of received STREAM frames pending reassembly */
+		u8 state;		/* Receive stream state, per rfc9000#section-3.2 */
+
+		u8 stop_sent:1;		/* True if STOP_SENDING has been sent */
+		u8 done:1;		/* True if FIN received and final size validated */
+	} recv;
+};
+
+struct quic_stream_table {
+	struct hlist_head *head;	/* Hash table storing all active streams */
+
+	struct {
+		/* Parameters received from peer, defined in rfc9000#section-18.2 */
+		u64 max_stream_data_bidi_remote;	/* initial_max_stream_data_bidi_remote */
+		u64 max_stream_data_bidi_local;		/* initial_max_stream_data_bidi_local */
+		u64 max_stream_data_uni;		/* initial_max_stream_data_uni */
+		u64 max_streams_bidi;			/* initial_max_streams_bidi */
+		u64 max_streams_uni;			/* initial_max_streams_uni */
+
+		s64 next_bidi_stream_id;	/* Next bidi stream ID to be opened */
+		s64 next_uni_stream_id;		/* Next uni stream ID to be opened */
+		s64 max_bidi_stream_id;		/* Highest allowed bidi stream ID */
+		s64 max_uni_stream_id;		/* Highest allowed uni stream ID */
+		s64 active_stream_id;		/* Most recently opened stream ID */
+
+		u8 bidi_blocked:1;	/* True if STREAMS_BLOCKED_BIDI was sent and not ACKed */
+		u8 uni_blocked:1;	/* True if STREAMS_BLOCKED_UNI was sent and not ACKed */
+		u16 streams_bidi;	/* Number of currently active bidi streams */
+		u16 streams_uni;	/* Number of currently active uni streams */
+	} send;
+	struct {
+		 /* Our advertised limits to the peer, per rfc9000#section-18.2 */
+		u64 max_stream_data_bidi_remote;	/* initial_max_stream_data_bidi_remote */
+		u64 max_stream_data_bidi_local;		/* initial_max_stream_data_bidi_local */
+		u64 max_stream_data_uni;		/* initial_max_stream_data_uni */
+		u64 max_streams_bidi;			/* initial_max_streams_bidi */
+		u64 max_streams_uni;			/* initial_max_streams_uni */
+
+		s64 next_bidi_stream_id;	/* Next expected bidi stream ID from peer */
+		s64 next_uni_stream_id;		/* Next expected uni stream ID from peer */
+		s64 max_bidi_stream_id;		/* Current allowed bidi stream ID range */
+		s64 max_uni_stream_id;		/* Current allowed uni stream ID range */
+
+		u8 bidi_pending:1;	/* True if MAX_STREAMS_BIDI needs to be sent */
+		u8 uni_pending:1;	/* True if MAX_STREAMS_UNI needs to be sent */
+		u16 streams_bidi;	/* Number of currently open bidi streams */
+		u16 streams_uni;	/* Number of currently open uni streams */
+	} recv;
+};
+
+static inline u64 quic_stream_id_to_streams(s64 stream_id)
+{
+	return (u64)(stream_id >> QUIC_STREAM_TYPE_BITS) + 1;
+}
+
+static inline s64 quic_stream_streams_to_id(u64 streams, u8 type)
+{
+	return (s64)((streams - 1) << QUIC_STREAM_TYPE_BITS) | type;
+}
+
+struct quic_stream *quic_stream_send_get(struct quic_stream_table *streams, s64 stream_id,
+					 u32 flags, bool is_serv);
+struct quic_stream *quic_stream_recv_get(struct quic_stream_table *streams, s64 stream_id,
+					 bool is_serv);
+void quic_stream_send_put(struct quic_stream_table *streams, struct quic_stream *stream,
+			  bool is_serv);
+void quic_stream_recv_put(struct quic_stream_table *streams, struct quic_stream *stream,
+			  bool is_serv);
+
+bool quic_stream_max_streams_update(struct quic_stream_table *streams, s64 *max_uni, s64 *max_bidi);
+bool quic_stream_id_exceeds(struct quic_stream_table *streams, s64 stream_id, bool send);
+struct quic_stream *quic_stream_find(struct quic_stream_table *streams, s64 stream_id);
+
+void quic_stream_get_param(struct quic_stream_table *streams, struct quic_transport_param *p,
+			   bool is_serv);
+void quic_stream_set_param(struct quic_stream_table *streams, struct quic_transport_param *p,
+			   bool is_serv);
+void quic_stream_free(struct quic_stream_table *streams);
+int quic_stream_init(struct quic_stream_table *streams);
-- 
2.47.1


