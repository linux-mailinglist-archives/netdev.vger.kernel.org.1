Return-Path: <netdev+bounces-241177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4387C810A4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5B73ADF37
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C41313293;
	Mon, 24 Nov 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOvti2a4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6B25A321
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994630; cv=none; b=Pm3D6bFcjyEsuQgy0FuaY6cvtllyYPZ2hb3Q98dYTaV7NH6is1XoYHbvQX2eq70qq8YbOOSw+78MvDstZaJHSi1VWNzLERuJwdxTVlOSGFplPsX8nWzIlYi20q6HSfvpD66MHQ6v7/B9Qe39EOG2civtf2bqtmwVh0RjtMKHAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994630; c=relaxed/simple;
	bh=FVUlIjEIuL4587qHY6OZEvWyZTVo1ehIFbUmbv4QxYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARC2j5Yx0CR/a3jc89uKtuS+CdsgeemMjvqSoSj3CP3FNm6Xs27A2/4/wBiTqztjtqkvYMJojMJaZV6TrgsA/9TVWa/emOnhaB5BTQVPgK6FuEkeZSeOo4oVsAz0OjtgvmFpguxiy3ZRjG09LD80L38CLCRJQozT89tD9Wd3pJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOvti2a4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2a4b6876fso626731385a.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763994623; x=1764599423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPjZmqLuPPN8/q51Woic/+R57idJPzEbNh7G5tM98lc=;
        b=VOvti2a4YOMTBvGFOkE6W55ReP+QsDEAnzyhHV+d2WsO9q8br+2CU3EsgE0qEtWABL
         4JbrG5UD7vM+r7NAL/AI9lAp8NNOFv8W04/TpX4PhMEBza9q4q6KqLao7/CLnFdRi2el
         dTo9f6yC7ccnNoSieBarktbHohuZc+xsDW8XC4tqsbhe9x/Iu+TLqWfLDcoIsEhaalyB
         6ygoATafKMp/n12o2cNZTpo3YgNaDPbiV23a6DoyC3aon1gcGPPLjk0lHOdq/U9AkPfc
         IOO5TQLjKUtbnhevPsMFPgqgNtUf7BOjL3s15xxRg2H+xbnTBI8XWs2hUEmzo15wniWr
         XhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763994623; x=1764599423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPjZmqLuPPN8/q51Woic/+R57idJPzEbNh7G5tM98lc=;
        b=a+MrsQXVFjx2NfbnEJ/lzoTPQVsmud2MSkFYZn5CeczIGADGCaQH0vhXKUzaUQbqOR
         Tn+yP2S47gHMRLQNxfnNqoZGhbMemUgWn8LzBCjcKMpYgkKosWt3MHrfXuIjinVXQlmV
         7GNLb+YxEIpU6j5QVyM+TbXz1PDecxV8rw7TZ/8yXOB7Hn6CABzNjmsawd1Kw3SKwxkc
         gMGDGzG09a8EqxOZqIbL5GHCCSZLHzIy8Itqbmx+jrHLxHiJnKi1g+r5YKvmVKBWIYvL
         M6FKbqOHHAduvaYlk75oa5KYDufR9CEHgetnBs0JpQKISDXBuLJpMpR4UA6j1vNnafv5
         jGGg==
X-Gm-Message-State: AOJu0YxqxaqaRt9HJxWCbehyZR/jR90gljXKbTlS2Ww80vN0Ab+iTXHl
	zjAPaRUpemzKvTBBziF5PF/L13MWEJyjqfA/BkNR21HriK9iUkI1zycYTs5x503qrGo=
X-Gm-Gg: ASbGncsMgdW5mSV0IZsUEzpuR0ayjMyiNFcr0bI3UcYRAfGdvmKUo2ANE15AdAOaBER
	dCBnUyzF/pJqSUmxJ8lJOakqthlXfydes58BDwJuY88kn6ORitRFtLkgQSe9JNaou39uwISdzel
	NN3wM1oTx9x6/8wzjFkP66aEN+c4+yWJGWLxrnDNQnIaFYAjQcQ81Csxx16F5VeJpQBzGFI9hUF
	iQ/TpoPVoJ48dXoDRScdkPBLYXZlTm7QgIV67RgJgr3PRzAuPax9vypaXCD14UOdOE2nUDpAQLm
	opiZY9+1cr01V/aBzP+4Ql768v8PYh26l4BxE/kK4pcOu7CkcAxZm1VmPaYxiI1O7ZRyWwgbIMc
	WoS+0m6haso3kL8WOd0jqHd+ZvXjdDoL/EoWGNsmgPwiufhLK+zJUyA5M1pC6gm6Bw0IL599REB
	Sq3TD9WXoC3tMF3hF2zrlCRslwEFbyrysLBotkTzIj3BmtkaKyaCg=
X-Google-Smtp-Source: AGHT+IGyRUjb+sJxVZWQhnD9lVuVzFETx9nFBEPC8ENcMcibjcpV0AfOvWoL2ds1PiWAy7OLO7b30A==
X-Received: by 2002:a05:620a:4005:b0:84f:9d72:40f9 with SMTP id af79cd13be357-8b33d203908mr1490019885a.15.1763994620468;
        Mon, 24 Nov 2025 06:30:20 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3294321fdsm929713485a.12.2025.11.24.06.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:30:19 -0800 (PST)
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
Subject: [PATCH net-next v5 05/16] quic: provide quic.h header files for kernel and userspace
Date: Mon, 24 Nov 2025 09:28:18 -0500
Message-ID: <51325773b1d9905af21de5eed795dde56514b497.1763994509.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1763994509.git.lucien.xin@gmail.com>
References: <cover.1763994509.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds quic.h to include/uapi/linux, providing the necessary
definitions for the QUIC socket API. Exporting this header allows both
user space applications and kernel subsystems to access QUIC-related
control messages, socket options, and event/notification interfaces.

Since kernel_get/setsockopt() is no longer available to kernel consumers,
a corresponding internal header, include/linux/quic.h, is added. This
provides kernel subsystems with the necessary declarations to handle
QUIC socket options directly.

Detailed descriptions of these structures are available in [1], and will
be also provided when adding corresponding socket interfaces in the
later patches.

[1] https://datatracker.ietf.org/doc/html/draft-lxin-quic-socket-apis

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Thomas Dreibholz <dreibh@simula.no>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2:
  - Fix a kernel API description warning, found by Jakub.
  - Replace uintN_t with __uN, capitalize _UAPI_LINUX_QUIC_H, and
    assign explicit values for QUIC_TRANSPORT_ERROR_ enum in UAPI
    quic.h, suggested by David Howells.
v4:
  - Use MSG_QUIC_ prefix for MSG_* flags to avoid conflicts with other
    protocols, such as MSG_NOTIFICATION in SCTP (reported by Thomas).
  - Remove QUIC_CONG_ALG_CUBIC; only NEW RENO congestion control is
    supported in this version.
v5:
  - Add include/linux/quic.h and include/uapi/linux/quic.h to the
    QUIC PROTOCOL entry in MAINTAINERS.
---
 MAINTAINERS               |   2 +
 include/linux/quic.h      |  19 +++
 include/uapi/linux/quic.h | 235 ++++++++++++++++++++++++++++++++++++++
 net/quic/socket.c         |  38 ++++++
 net/quic/socket.h         |   7 ++
 5 files changed, 301 insertions(+)
 create mode 100644 include/linux/quic.h
 create mode 100644 include/uapi/linux/quic.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b70591763d9..dc236dbffa1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23140,6 +23140,8 @@ M:	Xin Long <lucien.xin@gmail.com>
 L:	quic@lists.linux.dev
 S:	Maintained
 W:	https://github.com/lxin/quic
+F:	include/linux/quic.h
+F:	include/uapi/linux/sctp.h
 F:	net/quic/
 
 SCx200 CPU SUPPORT
diff --git a/include/linux/quic.h b/include/linux/quic.h
new file mode 100644
index 000000000000..d35ff40bb005
--- /dev/null
+++ b/include/linux/quic.h
@@ -0,0 +1,19 @@
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
+#ifndef _LINUX_QUIC_H
+#define _LINUX_QUIC_H
+
+#include <uapi/linux/quic.h>
+
+int quic_kernel_setsockopt(struct sock *sk, int optname, void *optval, unsigned int optlen);
+int quic_kernel_getsockopt(struct sock *sk, int optname, void *optval, unsigned int *optlen);
+
+#endif
diff --git a/include/uapi/linux/quic.h b/include/uapi/linux/quic.h
new file mode 100644
index 000000000000..990b70c3afb0
--- /dev/null
+++ b/include/uapi/linux/quic.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#ifndef _UAPI_LINUX_QUIC_H
+#define _UAPI_LINUX_QUIC_H
+
+#include <linux/types.h>
+#ifdef __KERNEL__
+#include <linux/socket.h>
+#else
+#include <sys/socket.h>
+#endif
+
+/* NOTE: Structure descriptions are specified in:
+ * https://datatracker.ietf.org/doc/html/draft-lxin-quic-socket-apis
+ */
+
+/* Send or Receive Options APIs */
+enum quic_cmsg_type {
+	QUIC_STREAM_INFO,
+	QUIC_HANDSHAKE_INFO,
+};
+
+#define QUIC_STREAM_TYPE_SERVER_MASK	0x01
+#define QUIC_STREAM_TYPE_UNI_MASK	0x02
+#define QUIC_STREAM_TYPE_MASK		0x03
+
+enum quic_msg_flags {
+	/* flags for stream_flags */
+	MSG_QUIC_STREAM_NEW		= MSG_SYN,
+	MSG_QUIC_STREAM_FIN		= MSG_FIN,
+	MSG_QUIC_STREAM_UNI		= MSG_CONFIRM,
+	MSG_QUIC_STREAM_DONTWAIT	= MSG_WAITFORONE,
+	MSG_QUIC_STREAM_SNDBLOCK	= MSG_ERRQUEUE,
+
+	/* extented flags for msg_flags */
+	MSG_QUIC_DATAGRAM		= MSG_RST,
+	MSG_QUIC_NOTIFICATION		= MSG_MORE,
+};
+
+enum quic_crypto_level {
+	QUIC_CRYPTO_APP,
+	QUIC_CRYPTO_INITIAL,
+	QUIC_CRYPTO_HANDSHAKE,
+	QUIC_CRYPTO_EARLY,
+	QUIC_CRYPTO_MAX,
+};
+
+struct quic_handshake_info {
+	__u8	crypto_level;
+};
+
+struct quic_stream_info {
+	__s64	stream_id;
+	__u32	stream_flags;
+};
+
+/* Socket Options APIs */
+#define QUIC_SOCKOPT_EVENT				0
+#define QUIC_SOCKOPT_STREAM_OPEN			1
+#define QUIC_SOCKOPT_STREAM_RESET			2
+#define QUIC_SOCKOPT_STREAM_STOP_SENDING		3
+#define QUIC_SOCKOPT_CONNECTION_ID			4
+#define QUIC_SOCKOPT_CONNECTION_CLOSE			5
+#define QUIC_SOCKOPT_CONNECTION_MIGRATION		6
+#define QUIC_SOCKOPT_KEY_UPDATE				7
+#define QUIC_SOCKOPT_TRANSPORT_PARAM			8
+#define QUIC_SOCKOPT_CONFIG				9
+#define QUIC_SOCKOPT_TOKEN				10
+#define QUIC_SOCKOPT_ALPN				11
+#define QUIC_SOCKOPT_SESSION_TICKET			12
+#define QUIC_SOCKOPT_CRYPTO_SECRET			13
+#define QUIC_SOCKOPT_TRANSPORT_PARAM_EXT		14
+
+#define QUIC_VERSION_V1			0x1
+#define QUIC_VERSION_V2			0x6b3343cf
+
+struct quic_transport_param {
+	__u8	remote;
+	__u8	disable_active_migration;
+	__u8	grease_quic_bit;
+	__u8	stateless_reset;
+	__u8	disable_1rtt_encryption;
+	__u8	disable_compatible_version;
+	__u8	active_connection_id_limit;
+	__u8	ack_delay_exponent;
+	__u16	max_datagram_frame_size;
+	__u16	max_udp_payload_size;
+	__u32	max_idle_timeout;
+	__u32	max_ack_delay;
+	__u16	max_streams_bidi;
+	__u16	max_streams_uni;
+	__u64	max_data;
+	__u64	max_stream_data_bidi_local;
+	__u64	max_stream_data_bidi_remote;
+	__u64	max_stream_data_uni;
+	__u64	reserved;
+};
+
+struct quic_config {
+	__u32	version;
+	__u32	plpmtud_probe_interval;
+	__u32	initial_smoothed_rtt;
+	__u32	payload_cipher_type;
+	__u8	congestion_control_algo;
+	__u8	validate_peer_address;
+	__u8	stream_data_nodelay;
+	__u8	receive_session_ticket;
+	__u8	certificate_request;
+	__u8	reserved[3];
+};
+
+struct quic_crypto_secret {
+	__u8	send;  /* send or recv */
+	__u8	level; /* crypto level */
+	__u32	type; /* TLS_CIPHER_* */
+#define QUIC_CRYPTO_SECRET_BUFFER_SIZE 48
+	__u8	secret[QUIC_CRYPTO_SECRET_BUFFER_SIZE];
+};
+
+enum quic_cong_algo {
+	QUIC_CONG_ALG_RENO,
+	QUIC_CONG_ALG_MAX,
+};
+
+struct quic_errinfo {
+	__s64	stream_id;
+	__u32	errcode;
+};
+
+struct quic_connection_id_info {
+	__u8	dest;
+	__u32	active;
+	__u32	prior_to;
+};
+
+struct quic_event_option {
+	__u8	type;
+	__u8	on;
+};
+
+/* Event APIs */
+enum quic_event_type {
+	QUIC_EVENT_NONE,
+	QUIC_EVENT_STREAM_UPDATE,
+	QUIC_EVENT_STREAM_MAX_DATA,
+	QUIC_EVENT_STREAM_MAX_STREAM,
+	QUIC_EVENT_CONNECTION_ID,
+	QUIC_EVENT_CONNECTION_CLOSE,
+	QUIC_EVENT_CONNECTION_MIGRATION,
+	QUIC_EVENT_KEY_UPDATE,
+	QUIC_EVENT_NEW_TOKEN,
+	QUIC_EVENT_NEW_SESSION_TICKET,
+	QUIC_EVENT_MAX,
+};
+
+enum {
+	QUIC_STREAM_SEND_STATE_READY,
+	QUIC_STREAM_SEND_STATE_SEND,
+	QUIC_STREAM_SEND_STATE_SENT,
+	QUIC_STREAM_SEND_STATE_RECVD,
+	QUIC_STREAM_SEND_STATE_RESET_SENT,
+	QUIC_STREAM_SEND_STATE_RESET_RECVD,
+
+	QUIC_STREAM_RECV_STATE_RECV,
+	QUIC_STREAM_RECV_STATE_SIZE_KNOWN,
+	QUIC_STREAM_RECV_STATE_RECVD,
+	QUIC_STREAM_RECV_STATE_READ,
+	QUIC_STREAM_RECV_STATE_RESET_RECVD,
+	QUIC_STREAM_RECV_STATE_RESET_READ,
+};
+
+struct quic_stream_update {
+	__s64	id;
+	__u8	state;
+	__u32	errcode;
+	__u64	finalsz;
+};
+
+struct quic_stream_max_data {
+	__s64	id;
+	__u64	max_data;
+};
+
+struct quic_connection_close {
+	__u32	errcode;
+	__u8	frame;
+	__u8	phrase[];
+};
+
+union quic_event {
+	struct quic_stream_update	update;
+	struct quic_stream_max_data	max_data;
+	struct quic_connection_close	close;
+	struct quic_connection_id_info	info;
+	__u64	max_stream;
+	__u8	local_migration;
+	__u8	key_update_phase;
+};
+
+enum {
+	QUIC_TRANSPORT_ERROR_NONE			= 0x00,
+	QUIC_TRANSPORT_ERROR_INTERNAL			= 0x01,
+	QUIC_TRANSPORT_ERROR_CONNECTION_REFUSED		= 0x02,
+	QUIC_TRANSPORT_ERROR_FLOW_CONTROL		= 0x03,
+	QUIC_TRANSPORT_ERROR_STREAM_LIMIT		= 0x04,
+	QUIC_TRANSPORT_ERROR_STREAM_STATE		= 0x05,
+	QUIC_TRANSPORT_ERROR_FINAL_SIZE			= 0x06,
+	QUIC_TRANSPORT_ERROR_FRAME_ENCODING		= 0x07,
+	QUIC_TRANSPORT_ERROR_TRANSPORT_PARAM		= 0x08,
+	QUIC_TRANSPORT_ERROR_CONNECTION_ID_LIMIT	= 0x09,
+	QUIC_TRANSPORT_ERROR_PROTOCOL_VIOLATION		= 0x0a,
+	QUIC_TRANSPORT_ERROR_INVALID_TOKEN		= 0x0b,
+	QUIC_TRANSPORT_ERROR_APPLICATION		= 0x0c,
+	QUIC_TRANSPORT_ERROR_CRYPTO_BUF_EXCEEDED	= 0x0d,
+	QUIC_TRANSPORT_ERROR_KEY_UPDATE			= 0x0e,
+	QUIC_TRANSPORT_ERROR_AEAD_LIMIT_REACHED		= 0x0f,
+	QUIC_TRANSPORT_ERROR_NO_VIABLE_PATH		= 0x10,
+
+	/* The cryptographic handshake failed. A range of 256 values is reserved
+	 * for carrying error codes specific to the cryptographic handshake that
+	 * is used. Codes for errors occurring when TLS is used for the
+	 * cryptographic handshake are described in Section 4.8 of [QUIC-TLS].
+	 */
+	QUIC_TRANSPORT_ERROR_CRYPTO			= 0x0100,
+};
+
+#endif /* _UAPI_LINUX_QUIC_H */
diff --git a/net/quic/socket.c b/net/quic/socket.c
index a0eedf59545a..a0ebc6b56879 100644
--- a/net/quic/socket.c
+++ b/net/quic/socket.c
@@ -121,6 +121,25 @@ static int quic_setsockopt(struct sock *sk, int level, int optname,
 	return quic_do_setsockopt(sk, optname, optval, optlen);
 }
 
+/**
+ * quic_kernel_setsockopt - set a QUIC socket option from within the kernel
+ * @sk: socket to configure
+ * @optname: option name (QUIC-level)
+ * @optval: pointer to the option value
+ * @optlen: size of the option value
+ *
+ * Sets a QUIC socket option on a kernel socket without involving user space.
+ *
+ * Return:
+ * - On success, 0 is returned.
+ * - On error, a negative error value is returned.
+ */
+int quic_kernel_setsockopt(struct sock *sk, int optname, void *optval, unsigned int optlen)
+{
+	return quic_do_setsockopt(sk, optname, KERNEL_SOCKPTR(optval), optlen);
+}
+EXPORT_SYMBOL_GPL(quic_kernel_setsockopt);
+
 static int quic_do_getsockopt(struct sock *sk, int optname, sockptr_t optval, sockptr_t optlen)
 {
 	return -EOPNOTSUPP;
@@ -135,6 +154,25 @@ static int quic_getsockopt(struct sock *sk, int level, int optname,
 	return quic_do_getsockopt(sk, optname, USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
 }
 
+/**
+ * quic_kernel_getsockopt - get a QUIC socket option from within the kernel
+ * @sk: socket to query
+ * @optname: option name (QUIC-level)
+ * @optval: pointer to the buffer to receive the option value
+ * @optlen: pointer to the size of the buffer; updated to actual length on return
+ *
+ * Gets a QUIC socket option from a kernel socket, bypassing user space.
+ *
+ * Return:
+ * - On success, 0 is returned.
+ * - On error, a negative error value is returned.
+ */
+int quic_kernel_getsockopt(struct sock *sk, int optname, void *optval, unsigned int *optlen)
+{
+	return quic_do_getsockopt(sk, optname, KERNEL_SOCKPTR(optval), KERNEL_SOCKPTR(optlen));
+}
+EXPORT_SYMBOL_GPL(quic_kernel_getsockopt);
+
 static void quic_release_cb(struct sock *sk)
 {
 }
diff --git a/net/quic/socket.h b/net/quic/socket.h
index 0aa642e3b0ae..7ee190af4454 100644
--- a/net/quic/socket.h
+++ b/net/quic/socket.h
@@ -9,6 +9,7 @@
  */
 
 #include <net/udp_tunnel.h>
+#include <linux/quic.h>
 
 #include "common.h"
 #include "family.h"
@@ -29,6 +30,7 @@ struct quic_sock {
 	struct inet_sock		inet;
 	struct list_head		reqs;
 
+	struct quic_config		config;
 	struct quic_data		ticket;
 	struct quic_data		token;
 	struct quic_data		alpn;
@@ -49,6 +51,11 @@ static inline struct list_head *quic_reqs(const struct sock *sk)
 	return &quic_sk(sk)->reqs;
 }
 
+static inline struct quic_config *quic_config(const struct sock *sk)
+{
+	return &quic_sk(sk)->config;
+}
+
 static inline struct quic_data *quic_token(const struct sock *sk)
 {
 	return &quic_sk(sk)->token;
-- 
2.47.1


