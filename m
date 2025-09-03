Return-Path: <netdev+bounces-219403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4ECB4120B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFF9547AE8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB01624E9;
	Wed,  3 Sep 2025 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcyeOIce"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9141E4AB;
	Wed,  3 Sep 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756864134; cv=none; b=PGqJcCREKivxjNQwA58vszWCQOupz19yjWuOpB2+3y+FRLN9UcZ8Bao192OQOPW0kp6pzPpvmOfgMUIFSyXHqoSOnwHPVkYRJ9lMFYiGjrKwCtHmP1/SImzOfKglhdtYAr89jhLRgbjzsUEmHKGDSFMSh00bhzCadiZcS4Bgnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756864134; c=relaxed/simple;
	bh=ZnCjDt/xxTJ8WVNMGDipRAm1kFiiKXZtWA01pycrP0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKkq9FtLp73KcAMPc3kTDp2ZtcGL/ssQqnZkU+xbAB5a/ab/tEqFfMU3QkUoi0Fd7CmlOb4mlQQHps5sR9d6JCq8weWoZ1zaZJM11gLWhN0vjbbRbYhYH75XYJeIyosp1KLzDGZ4I+JlVPnjhqcXkufP4LTL1EsgiFaNjAXAEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcyeOIce; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24c7848519bso7986065ad.1;
        Tue, 02 Sep 2025 18:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756864132; x=1757468932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5K5+6/E2TguN5jCxa+s4/alaOTKBjPVsyrGrnuZMwE=;
        b=gcyeOIceN+l576zavfKe13dB7UW0cT1A/1rE3WtVyBmkPmAZnQAaYxG7NbJh4gks5c
         xBAqiJNjNhwpiKYoNZkA8+V/2YkTlvfKVoQKxc/VQa3r2G7ENy1+qaCn13wWDkBOwZ/6
         C/v8JiS1SsLw//8lRoY36vZhzIL2jmx9kTuSSTx9d2uEzqFhVIjy9F/j/j6fLnNSxqk9
         LAXgRwEvmH53bxpt2gVATuKIWrYnCO6PZUWf8Gy75UrRufj4J1yQWJaoBYCI+M62ec1w
         M/oNNZ9ALijrrgDnOxcBhnb+F4TtkYvudxkoq7TZX4R+/NJbwGoEDjHB5LwwRiCnhzlo
         FGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756864132; x=1757468932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5K5+6/E2TguN5jCxa+s4/alaOTKBjPVsyrGrnuZMwE=;
        b=BQYEDddA0R0vJnPVRWh3oWQdEBCHrrcaPs0xOkDH4VMY2fv9obZHOI9aflmvrIkCAf
         Ku1LS/pWWS+ECeIylI0THn3aC6NNsSgEmmjIioHZ1z0QJN2ERqWnkMybitfqJbgc3/xW
         mPg3MqTq5AX3xA7BLiOqyi7PskOHwA7vYhCTLVp88qzwth53AHtf3LWiDd7UYkIZFMcV
         HMgBNMz07g+y/8s20bLubFqe06nLOjd6xdRwrMtwPdhvd3YvOxM5T0m0lTiy7ZbOqRC/
         4wt7YXa8EhBlZwrOPzcFxPorqGy8oODl0hzkYoAOs8Y0C+05kJtH2wh0/D6P0kW/S+d4
         QvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4EHTd+UPGAHBHOzTMa5AJpRX9Ns51/eIvpS+cBnuv9asinQFbA1hwaNsG5qEY4Ma8n0KSYBtC@vger.kernel.org, AJvYcCVpNf3Vqlerz5KirBS/643nxttTm6v6uuymOmkq19tHhKaN0Aa96S4m1TsDxquzpptN6d+Vto9H2QlmAun7@vger.kernel.org, AJvYcCVpP5hhBNZpeUKoEfohUaMWWnRbo5D6CZOy/+F5Ii/m1jJxmhWVcX6O1EnkW5SgNqVc1O/ZnMWNzLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/4M0Du52DR1DC4igdjwrIbI5ZNIeLAh9/bkmPijQuKBRdYAx
	jL+rxyKXgV5G4scWGBLhHsRc7b+23LnPUleS8eY+WJ+zRNTu2wbJAVvc
X-Gm-Gg: ASbGncshXku6Pa3vhQSqeSVXa7DE8GUNMc8PzGSo2C5h0eEXvjVCsOPHAtsSJBG0f7/
	lMOQL710TeebtA0jzw0h+zl9K4UBCpiURp3vOl2ICc4dsyfMQEUKn5GWQd2shLowqZQss/CzXcn
	pvAtq/M8vMuIg50MlY0Of9sKe3tH4rCLqiFN9S4CLktUgw1K6+vePKb9cjlSDchfBCJw9IKW7yn
	8aHY2YuXrdtD8CjElAL6f5XYMV6wdgsU2w9LDLcm1oz7mAXkjazQ2sJs1FViig33DsGguqhcS7l
	Ju15FuZp/jGHfwaXISnWyCzh2oI2U9NRkLWSGVykOPKzUTM4COXeayLcH3smWYrMeBFGhAovmZn
	kdkZwEiapdx9P2hreZbPmwRTL6BQB9zXul6tX
X-Google-Smtp-Source: AGHT+IGRZOLBXxfWgkvB4KXAx7D2vpFOgMQKicQCcFgaF/uJ0Bfv4GrX0PHrR2EsiBuYdopRl+7NAA==
X-Received: by 2002:a17:902:e5d0:b0:24b:1766:cc70 with SMTP id d9443c01a7336-24b1766d2d6mr53722235ad.39.1756864132354;
        Tue, 02 Sep 2025 18:48:52 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037022d9sm145737495ad.23.2025.09.02.18.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 18:48:51 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	corbet@lwn.net,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com,
	dlemoal@kernel.org,
	sd@queasysnail.net,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v3] net/tls: support maximum record size limit
Date: Wed,  3 Sep 2025 11:47:57 +1000
Message-ID: <20250903014756.247106-2-wilfred.opensource@gmail.com>
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
the respective userspace support in tlshd and GnuTLS [2].

[1] https://www.rfc-editor.org/rfc/rfc8449
[2] https://gitlab.com/gnutls/gnutls/-/merge_requests/2005

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
V2 -> V3:
 - Added crucial missing change to tls_sw_sendmsg_locked() that actually
   enforces the record size limit.
 - Added record size enforcement in tls_device.c 
 - Changed `record_size_limit` -> `tx_record_size_limit` easier to see that it's
   tx only.
 - Added do_tls_getsockopt() support for TLS_TX_RECORD_SIZE_LIM
 - tx_record_size_limit is set to TLS_MAX_PAYLOAD_SIZE in tls_init() and
   updated when record size is specified by userspace.
---
 Documentation/networking/tls.rst |  7 ++++
 include/net/tls.h                |  1 +
 include/uapi/linux/tls.h         |  2 +
 net/tls/tls_device.c             |  2 +-
 net/tls/tls_main.c               | 65 +++++++++++++++++++++++++++++++-
 net/tls/tls_sw.c                 |  2 +-
 6 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 36cc7afc2527..0232df902320 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -280,6 +280,13 @@ If the record decrypted turns out to had been padded or is not a data
 record it will be decrypted again into a kernel buffer without zero copy.
 Such events are counted in the ``TlsDecryptRetry`` statistic.
 
+TLS_TX_RECORD_SIZE_LIM
+~~~~~~~~~~~~~~~~~~~~~~
+
+During a TLS handshake, an endpoint may use the record size limit extension
+to specify a maximum record size. This allows enforcing the specified record
+size limit, such that outgoing records do not exceed the limit specified.
+
 Statistics
 ==========
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..6db532d310d5 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -226,6 +226,7 @@ struct tls_context {
 	u8 rx_conf:3;
 	u8 zerocopy_sendfile:1;
 	u8 rx_no_pad:1;
+	u16 tx_record_size_limit;
 
 	int (*push_pending_record)(struct sock *sk, int flags);
 	void (*sk_write_space)(struct sock *sk);
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index b66a800389cc..3add266d5916 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -41,6 +41,7 @@
 #define TLS_RX			2	/* Set receive parameters */
 #define TLS_TX_ZEROCOPY_RO	3	/* TX zerocopy (only sendfile now) */
 #define TLS_RX_EXPECT_NO_PAD	4	/* Attempt opportunistic zero-copy */
+#define TLS_TX_RECORD_SIZE_LIM	5	/* Maximum record size */
 
 /* Supported versions */
 #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
@@ -194,6 +195,7 @@ enum {
 	TLS_INFO_RXCONF,
 	TLS_INFO_ZC_RO_TX,
 	TLS_INFO_RX_NO_PAD,
+	TLS_INFO_TX_RECORD_SIZE_LIM,
 	__TLS_INFO_MAX,
 };
 #define TLS_INFO_MAX (__TLS_INFO_MAX - 1)
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..bf16ceb41dde 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -459,7 +459,7 @@ static int tls_push_data(struct sock *sk,
 	/* TLS_HEADER_SIZE is not counted as part of the TLS record, and
 	 * we need to leave room for an authentication tag.
 	 */
-	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
+	max_open_record_len = tls_ctx->tx_record_size_limit +
 			      prot->prepend_size;
 	do {
 		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a3ccb3135e51..94237c97f062 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -544,6 +544,28 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
 	return 0;
 }
 
+static int do_tls_getsockopt_tx_record_size(struct sock *sk, char __user *optval,
+					    int __user *optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	u16 record_size_limit = ctx->tx_record_size_limit;
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(record_size_limit))
+		return -EINVAL;
+
+	if (put_user(sizeof(record_size_limit), optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &record_size_limit, sizeof(record_size_limit)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int do_tls_getsockopt(struct sock *sk, int optname,
 			     char __user *optval, int __user *optlen)
 {
@@ -563,6 +585,9 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_getsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_RECORD_SIZE_LIM:
+		rc = do_tls_getsockopt_tx_record_size(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -812,6 +837,31 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+static int do_tls_setsockopt_tx_record_size(struct sock *sk, sockptr_t optval,
+					    unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	u16 value;
+
+	if (sockptr_is_null(optval) || optlen != sizeof(value))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&value, optval, sizeof(value)))
+		return -EFAULT;
+
+	if (ctx->prot_info.version == TLS_1_2_VERSION &&
+	    value > TLS_MAX_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	if (ctx->prot_info.version == TLS_1_3_VERSION &&
+	    value > TLS_MAX_PAYLOAD_SIZE + 1)
+		return -EINVAL;
+
+	ctx->tx_record_size_limit = value;
+
+	return 0;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -833,6 +883,9 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_RECORD_SIZE_LIM:
+		rc = do_tls_setsockopt_tx_record_size(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -1022,6 +1075,7 @@ static int tls_init(struct sock *sk)
 
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	ctx->tx_record_size_limit = TLS_MAX_PAYLOAD_SIZE;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -1065,7 +1119,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
 
 static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 {
-	u16 version, cipher_type;
+	u16 version, cipher_type, tx_record_size_limit;
 	struct tls_context *ctx;
 	struct nlattr *start;
 	int err;
@@ -1110,7 +1164,13 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 		if (err)
 			goto nla_failure;
 	}
-
+	tx_record_size_limit = ctx->tx_record_size_limit;
+	if (tx_record_size_limit) {
+		err = nla_put_u16(skb, TLS_INFO_TX_RECORD_SIZE_LIM,
+				  tx_record_size_limit);
+		if (err)
+			goto nla_failure;
+	}
 	rcu_read_unlock();
 	nla_nest_end(skb, start);
 	return 0;
@@ -1132,6 +1192,7 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
 		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
 		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_RECORD_SIZE_LIM */
 		0;
 
 	return size;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bac65d0d4e3e..28fb796573d1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1079,7 +1079,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_ctx->tx_record_size_limit - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.51.0


