Return-Path: <netdev+bounces-231477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80EBF9726
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 852F14E4465
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079319C54E;
	Wed, 22 Oct 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxqORTZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8B7DA66
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092420; cv=none; b=JPUJICg3oeaULN+XgLNtMWJRDNH2OGHzhKugZBnwDHf31nkqMnryJygEYnaDCHF09QPFl4QYO16uDcYbFnwwsVCil8EG7PsvLtJL6RBJ4EHYZrEZFOreWU/jARP6rSkXgqY8d3UojZ/qd+/zoJ6dCtzxV3kEkzt38wXCp1Ks6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092420; c=relaxed/simple;
	bh=CxJjQEtSRciuN/yaJMf58GHY7wZzFO6GcnAk26Ue4e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vq+ChXlM0MVTdcd/lropI0TmRYLl6Sd4OTqQwMuvvnAqlaWL5vUDsXG09Oz1Mr0wTOyhNAhE8WySp5Aa1NVMOOjgmxGH4LKvi66q8bJSeUHC7wyBI0k4Y9zW6zEc4vsRGA1yw8kIbLGb1+AHHjAWZgRy4stWxUD9JqAm2wRUOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxqORTZw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5515eaefceso5082207a12.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761092418; x=1761697218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7CC5KiCyQRes+/Q+dJgQGBWAYblavqSaxCcfd2V4e0=;
        b=jxqORTZwxNF18urTEIB59crr7lyrOVO+UJ5dipbvGMqsis6PyKYxiqx1JG/+gR5VE/
         P1AQRP//qZZ+sHtN1KYTvF7a+Tl1n4WUrSQFbjwG6oZ0xS2c0iA5d9baRJpQ3j9CdA/9
         MPmU8A93ppXUCu+JVNaiKOm5gGsh0N015+KqXfgoWROA3vxei15uu3OZkLdZPmTfePJD
         WhMMN1l/OJZEyuxyajgUmpSYT4TeNBt4VemHR/tgXJFbLv6jAji+yQoGAdusJAEwJxHm
         4cpM6y5EWM/RkRjYhHFLsZWyI3ZIldQR977UKtfovjnfU26RWOK/GGyglI/fi/XWv7uy
         q4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092418; x=1761697218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7CC5KiCyQRes+/Q+dJgQGBWAYblavqSaxCcfd2V4e0=;
        b=nZjOzhg5iSBTt77+5vl7I36QG478+4WZ0DAe+bL9BeKxASFTzPTsf+7p+liO54sKW4
         hoApxBGeV4XaUigpdo+Idd3kW7pBNH+4Fms7QoYNzUibZXv2ABlkRF76GyP532fVTpnB
         JN0dfG6YEPfZn0I2pd042tM1Y0eyymPnMxfCLglxrN4TI+BcW/ynMFMezxGGUQRme0V/
         6K1WxSvuownMZck4JXapXa0Yrmj5YgAKyXglMQiHiucIfhE0lGaOmKN926c4BTmWZUes
         l70smAsf59ju29aMqw/GDRaj8DQQ8aLVyp+TX8JA6pYlRHpxUB+mjcfFYnLxlV9/7zuH
         YprQ==
X-Gm-Message-State: AOJu0YzYmxzbpX1a4QpyG8s1hWOSt0SJFhNXdtMV8pQLI+6MnANUDQAy
	RGPK/IlBUlNeqOWL2qEDXkbOH3ji9g1711kzwTypDmGg0v62sv0gd3GNr/8EWC/i
X-Gm-Gg: ASbGncsrl27ZpfcWJ8ru0QHebMGxi7A6XdPmBMRPxtQWgYXDhRl63mRl4pUt3cQWfK0
	OHfcGbfYMiT5IqUelJyJx5oneEuPYDdiTAaT3qZxAcFlWOM4qKWvQUdTO1o7BdYSFCyrjr5WZod
	iS7xyl3zFwpA2UFsNfupNkBfKcddQy8aVrtrhIq6fHedT2wVMLehJjZ8jBHHh6Iw15IOoDEbg6n
	9Hnm3PCbjlOm8XnmxTiEc/aEpi/ec3CqhCqAZBKpMwbo6d1AdRRy0BcEP4MoznTyil3pf10OzhB
	mi1rCu8AWKjquaaW4xJYvrzTDgoO9aIu9UZLQ+MrZC3HvjtxTT7/dmP2TgIt2jEaoUJUU0bovsp
	ECue93Tk5AWo7W8F93xtlyFaSBAHc/rqZIRlsxYv+pMn3FwRQLkZnsMp5DoIY5hoh/Pu1Ke49bY
	dXY+5uQ5Yf
X-Google-Smtp-Source: AGHT+IF6K3puMMF/VwJpVpPgNw5oEgtDkIrXWDky51zezoFPd5SugRkbQY/Tc2zS73/dT1q4Z/GbWw==
X-Received: by 2002:a17:902:ef44:b0:268:f83a:835a with SMTP id d9443c01a7336-290ccab5e9bmr210607575ad.60.1761092417873;
        Tue, 21 Oct 2025 17:20:17 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcf9sm120759805ad.91.2025.10.21.17.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:20:17 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH net-next v8 1/2] net/tls: support setting the maximum payload size
Date: Wed, 22 Oct 2025 10:19:36 +1000
Message-ID: <20251022001937.20155-1-wilfred.opensource@gmail.com>
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

Currently, there is no way to inform the kernel of such a limit. This patch
adds support to a new setsockopt() option `TLS_TX_MAX_PAYLOAD_LEN` that
allows for setting the maximum plaintext fragment size. Once set, outgoing
records are no larger than the size specified. This option can be used to
specify the record size limit.

[1] https://www.rfc-editor.org/rfc/rfc8449

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
V7 -> V8:
 - Fixup HTML doc indentation
 - Drop the getsockopt() change in V7 where ContentType was included in the
   max payload length
---
 Documentation/networking/tls.rst | 20 ++++++++++
 include/net/tls.h                |  3 ++
 include/uapi/linux/tls.h         |  2 +
 net/tls/tls_device.c             |  2 +-
 net/tls/tls_main.c               | 64 ++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c                 |  2 +-
 6 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 36cc7afc2527..980c442d7161 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -280,6 +280,26 @@ If the record decrypted turns out to had been padded or is not a data
 record it will be decrypted again into a kernel buffer without zero copy.
 Such events are counted in the ``TlsDecryptRetry`` statistic.
 
+TLS_TX_MAX_PAYLOAD_LEN
+~~~~~~~~~~~~~~~~~~~~~~
+
+Specifies the maximum size of the plaintext payload for transmitted TLS records.
+
+When this option is set, the kernel enforces the specified limit on all outgoing
+TLS records. No plaintext fragment will exceed this size. This option can be used
+to implement the TLS Record Size Limit extension [1].
+
+* For TLS 1.2, the value corresponds directly to the record size limit.
+* For TLS 1.3, the value should be set to record_size_limit - 1, since
+  the record size limit includes one additional byte for the ContentType
+  field.
+
+The valid range for this option is 64 to 16384 bytes for TLS 1.2, and 63 to
+16384 bytes for TLS 1.3. The lower minimum for TLS 1.3 accounts for the
+extra byte used by the ContentType field.
+
+[1] https://datatracker.ietf.org/doc/html/rfc8449
+
 Statistics
 ==========
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..f2af113728aa 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -53,6 +53,8 @@ struct tls_rec;
 
 /* Maximum data size carried in a TLS record */
 #define TLS_MAX_PAYLOAD_SIZE		((size_t)1 << 14)
+/* Minimum record size limit as per RFC8449 */
+#define TLS_MIN_RECORD_SIZE_LIM		((size_t)1 << 6)
 
 #define TLS_HEADER_SIZE			5
 #define TLS_NONCE_OFFSET		TLS_HEADER_SIZE
@@ -226,6 +228,7 @@ struct tls_context {
 	u8 rx_conf:3;
 	u8 zerocopy_sendfile:1;
 	u8 rx_no_pad:1;
+	u16 tx_max_payload_len;
 
 	int (*push_pending_record)(struct sock *sk, int flags);
 	void (*sk_write_space)(struct sock *sk);
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index b66a800389cc..b8b9c42f848c 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -41,6 +41,7 @@
 #define TLS_RX			2	/* Set receive parameters */
 #define TLS_TX_ZEROCOPY_RO	3	/* TX zerocopy (only sendfile now) */
 #define TLS_RX_EXPECT_NO_PAD	4	/* Attempt opportunistic zero-copy */
+#define TLS_TX_MAX_PAYLOAD_LEN	5	/* Maximum plaintext size */
 
 /* Supported versions */
 #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
@@ -194,6 +195,7 @@ enum {
 	TLS_INFO_RXCONF,
 	TLS_INFO_ZC_RO_TX,
 	TLS_INFO_RX_NO_PAD,
+	TLS_INFO_TX_MAX_PAYLOAD_LEN,
 	__TLS_INFO_MAX,
 };
 #define TLS_INFO_MAX (__TLS_INFO_MAX - 1)
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index caa2b5d24622..4d29b390aed9 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -462,7 +462,7 @@ static int tls_push_data(struct sock *sk,
 	/* TLS_HEADER_SIZE is not counted as part of the TLS record, and
 	 * we need to leave room for an authentication tag.
 	 */
-	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
+	max_open_record_len = tls_ctx->tx_max_payload_len +
 			      prot->prepend_size;
 	do {
 		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 39a2ab47fe72..56ce0bc8317b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -541,6 +541,28 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
 	return 0;
 }
 
+static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char __user *optval,
+					    int __user *optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	u16 payload_len = ctx->tx_max_payload_len;
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(payload_len))
+		return -EINVAL;
+
+	if (put_user(sizeof(payload_len), optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &payload_len, sizeof(payload_len)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int do_tls_getsockopt(struct sock *sk, int optname,
 			     char __user *optval, int __user *optlen)
 {
@@ -560,6 +582,9 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_getsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_MAX_PAYLOAD_LEN:
+		rc = do_tls_getsockopt_tx_payload_len(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -809,6 +834,32 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
+					    unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	u16 value;
+	bool tls_13 = ctx->prot_info.version == TLS_1_3_VERSION;
+
+	if (sw_ctx && sw_ctx->open_rec)
+		return -EBUSY;
+
+	if (sockptr_is_null(optval) || optlen != sizeof(value))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&value, optval, sizeof(value)))
+		return -EFAULT;
+
+	if (value < TLS_MIN_RECORD_SIZE_LIM - (tls_13 ? 1 : 0) ||
+	    value > TLS_MAX_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	ctx->tx_max_payload_len = value;
+
+	return 0;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -830,6 +881,11 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_MAX_PAYLOAD_LEN:
+		lock_sock(sk);
+		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
+		release_sock(sk);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -1019,6 +1075,7 @@ static int tls_init(struct sock *sk)
 
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -1108,6 +1165,12 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 			goto nla_failure;
 	}
 
+	err = nla_put_u16(skb, TLS_INFO_TX_MAX_PAYLOAD_LEN,
+			  ctx->tx_max_payload_len);
+
+	if (err)
+		goto nla_failure;
+
 	rcu_read_unlock();
 	nla_nest_end(skb, start);
 	return 0;
@@ -1129,6 +1192,7 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
 		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
 		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_MAX_PAYLOAD_LEN */
 		0;
 
 	return size;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d17135369980..9937d4c810f2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1079,7 +1079,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_ctx->tx_max_payload_len - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.51.0


