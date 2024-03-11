Return-Path: <netdev+bounces-79218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6C878513
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B91C21783
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC5B4D9E3;
	Mon, 11 Mar 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuiznKwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D14AEC5
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173985; cv=none; b=o9O6pDgpq92urhx6BGsm+N+IISt/jT9yEpBKz74EFiW4EEMbRwqASzcuCbODJqpQFI8isTIgpubjRjpN1GfRmYeykcZBj+6F7uLUnRdL6IfdLOgS7CX2ZgqBtbmPddRH5acG+FVMYx+u+m8qSurepgcLYDQgoKEyFr6S3iisJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173985; c=relaxed/simple;
	bh=zpl4+pea2QyZRsUBe8AADXmkkOOZ83ucZ0Qmz+Ci4pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYkCl23sn5iLdhvYPNhrXiS1bw5Sny6lKK7RXlnGbQQcYd3bp+iVNmLaJOcGJtb5W46auLsNOFoFM1LdWlOKFmeaB1MDajHMGILxApkQJ0tYNgfGDQbRp9jtEjXiVfiyOW80jkEEdyCMOGuDNmg0U/TQ2yRWBx5adU7bA1fC4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuiznKwt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690cd7f83cdso9220516d6.3
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173982; x=1710778782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5oanC8cGNFSm8+2XWd5Ku+yt8pvzZr1aBNymUsANxY=;
        b=HuiznKwt4awG/fNER6GSTp+hPn9J0q3HCMThEMs0mYdv2Wg0GSiwJfx6hTJEvqiQuU
         Imk7X9DTND/Ie1WwpHM4V0YBre8R9wdIWmBDyf+dQaOJvL/IBr1qQH6ZQAUa+kFp5gDD
         8UuaMbgZ+Xi8QsI2MNud8VgOjBj4PJeOWhdhPhciKivAko295OG9VLmd6m1tulbP5Fwf
         5q4tdGW7wFk3fFXxlqmTWeCojkP3YzLimizXLECXWi5cMAdOhX5m65DexqnXQYox/bQY
         Ek6vweBjfkcOZv1oVCeXDUxhjl9JAxIHgXH1mWwO1u6vlpX6F69LZVut49/+2RaraLrY
         56zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173982; x=1710778782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5oanC8cGNFSm8+2XWd5Ku+yt8pvzZr1aBNymUsANxY=;
        b=mV0hO8bXt0JtJkyZAZIygoj8aBiQFgW2KMoHmbOu8aK31KT4F8m72fN/3uD9LxsCS9
         HOafha0paierh2EZqrK5Zd3XboDoIjQy05rbNfCj2pGK7MMX2fbbNSCrg6vO4iqou0po
         QEX1tORG1ic74pzSOAx5OTwM1JW9mjAwaQypN787I0Py2kmdYEvIDS4izdK/Q4JYcv06
         j0ighpCiIpEXSAVcCh3+FEJEg7hNC1QHcPu/QdRNghBJZiCrDbF7XYPIbIVrbrD/2uDE
         6+JhVwmC39vwcLdInvgpSej48O6l2W96dffPj40vzyDipI/kW783oMmfhujw45ZaWOaJ
         7Nfg==
X-Gm-Message-State: AOJu0YxYGOvn8kivKZVvsB+ecQMyO8IY86EvPY2zkzBiuTeNIsJGk/OU
	MQJB2Ghs2FbgkkIiY024gNxCgC6qUgTfJMUiZ6eGEGSo8pNPj/iwfB1vhkwb//0=
X-Google-Smtp-Source: AGHT+IFWv/7bcOcUhzC3UsOzTSPf+edguv8X2gaDgXQeQf+I5NonZbAEEEWND2IDOm7NvNC0Y9YJzg==
X-Received: by 2002:a0c:f5c8:0:b0:690:b65c:766c with SMTP id q8-20020a0cf5c8000000b00690b65c766cmr7751232qvm.55.1710173982237;
        Mon, 11 Mar 2024 09:19:42 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a056214013200b0068fc5887c9fsm2788245qvs.97.2024.03.11.09.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:19:41 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>
Subject: [RFC PATCH net-next 2/5] net: include quic.h in include/uapi/linux for QUIC protocol
Date: Mon, 11 Mar 2024 12:10:24 -0400
Message-ID: <ce7e1e189f97af7f899a0a8539498b3870dcde7f.1710173427.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710173427.git.lucien.xin@gmail.com>
References: <cover.1710173427.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces quic.h to the include/uapi/linux directory,
providing header file with necessary definitions for QUIC. Including
quic.h enables both user space applications and kernel consumers to
access QUIC-related Send/Receive Control Messages, Socket Options and
Events/Notifications APIs.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
---
 include/uapi/linux/quic.h | 189 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 include/uapi/linux/quic.h

diff --git a/include/uapi/linux/quic.h b/include/uapi/linux/quic.h
new file mode 100644
index 000000000000..8cde5c989573
--- /dev/null
+++ b/include/uapi/linux/quic.h
@@ -0,0 +1,189 @@
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
+#ifndef __uapi_quic_h__
+#define __uapi_quic_h__
+
+#include <linux/socket.h>
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
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
+enum {
+	QUIC_STREAM_FLAG_NEW		= (1 << 0),
+	QUIC_STREAM_FLAG_FIN		= (1 << 1),
+	QUIC_STREAM_FLAG_UNI		= (1 << 2),
+	QUIC_STREAM_FLAG_ASYNC		= (1 << 3),
+	QUIC_STREAM_FLAG_NOTIFICATION	= (1 << 4),
+	QUIC_STREAM_FLAG_DATAGRAM	= (1 << 5),
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
+	uint8_t	crypto_level;
+};
+
+struct quic_stream_info {
+	uint64_t stream_id;
+	uint32_t stream_flag;
+};
+
+enum quic_msg_flags {
+	MSG_NOTIFICATION	= 0x8000,
+	MSG_STREAM_UNI		= 0x800,
+	MSG_DATAGRAM		= 0x10,
+};
+
+/* Socket Options APIs */
+#define QUIC_SOCKOPT_EVENT				0
+#define QUIC_SOCKOPT_STREAM_OPEN			1
+#define QUIC_SOCKOPT_STREAM_RESET			2
+#define QUIC_SOCKOPT_STREAM_STOP_SENDING		3
+#define QUIC_SOCKOPT_CONNECTION_CLOSE			4
+#define QUIC_SOCKOPT_CONNECTION_MIGRATION		5
+#define QUIC_SOCKOPT_KEY_UPDATE				6
+#define QUIC_SOCKOPT_TRANSPORT_PARAM			7
+#define QUIC_SOCKOPT_TOKEN				8
+#define QUIC_SOCKOPT_ALPN				9
+#define QUIC_SOCKOPT_SESSION_TICKET			10
+#define QUIC_SOCKOPT_CRYPTO_SECRET			11
+#define QUIC_SOCKOPT_TRANSPORT_PARAM_EXT		12
+#define QUIC_SOCKOPT_RETIRE_CONNECTION_ID		13
+#define QUIC_SOCKOPT_ACTIVE_CONNECTION_ID		14
+
+#define QUIC_VERSION_V1			0x1
+#define QUIC_VERSION_V2			0x6b3343cf
+
+struct quic_transport_param {
+	uint8_t		remote;
+	uint8_t		disable_active_migration;
+	uint8_t		grease_quic_bit;
+	uint8_t		stateless_reset;
+	uint8_t		disable_1rtt_encryption;
+	uint8_t		disable_compatible_version;
+	uint64_t	max_udp_payload_size;
+	uint64_t	ack_delay_exponent;
+	uint64_t	max_ack_delay;
+	uint64_t	active_connection_id_limit;
+	uint64_t	max_idle_timeout;
+	uint64_t	max_datagram_frame_size;
+	uint64_t	max_data;
+	uint64_t	max_stream_data_bidi_local;
+	uint64_t	max_stream_data_bidi_remote;
+	uint64_t	max_stream_data_uni;
+	uint64_t	max_streams_bidi;
+	uint64_t	max_streams_uni;
+	uint64_t	initial_smoothed_rtt;
+	uint32_t	plpmtud_probe_timeout;
+	uint8_t		validate_peer_address;
+	uint8_t		receive_session_ticket;
+	uint8_t		certificate_request;
+	uint8_t		congestion_control_alg;
+	uint32_t	payload_cipher_type;
+	uint32_t	version;
+};
+
+struct quic_crypto_secret {
+	uint8_t level; /* crypto level */
+	uint16_t send; /* send or recv */
+	uint32_t type; /* TLS_CIPHER_* */
+	uint8_t secret[48];
+};
+
+enum {
+	QUIC_CONG_ALG_RENO,
+	QUIC_CONG_ALG_MAX,
+};
+
+struct quic_errinfo {
+	uint64_t stream_id;
+	uint32_t errcode;
+};
+
+struct quic_connection_id_info {
+	uint32_t source;
+	uint32_t dest;
+};
+
+struct quic_event_option {
+	uint8_t type;
+	uint8_t on;
+};
+
+/* Event APIs */
+enum quic_event_type {
+	QUIC_EVENT_NONE,
+	QUIC_EVENT_STREAM_UPDATE,
+	QUIC_EVENT_STREAM_MAX_STREAM,
+	QUIC_EVENT_CONNECTION_CLOSE,
+	QUIC_EVENT_CONNECTION_MIGRATION,
+	QUIC_EVENT_KEY_UPDATE,
+	QUIC_EVENT_NEW_TOKEN,
+	QUIC_EVENT_END,
+	QUIC_EVENT_MAX = QUIC_EVENT_END - 1,
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
+	uint64_t id;
+	uint32_t state;
+	uint32_t errcode;
+	uint64_t finalsz;
+};
+
+struct quic_connection_close {
+	uint32_t errcode;
+	uint8_t frame;
+	uint8_t phrase[];
+};
+
+union quic_event {
+	struct quic_stream_update update;
+	struct quic_connection_close close;
+	uint64_t max_stream;
+	uint8_t local_migration;
+	uint8_t key_update_phase;
+};
+
+#endif /* __uapi_quic_h__ */
-- 
2.43.0


