Return-Path: <netdev+bounces-218986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2176B3F2CC
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 05:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB42189E3C5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2862E090C;
	Tue,  2 Sep 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF5yT2Ru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C44207A0C;
	Tue,  2 Sep 2025 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784341; cv=none; b=Lz75eNkSkcJfXgCXIKCzufJ+fS7GSezqtiUl54RIrymC1fv907CaRKJlt4ReQAvYMFEbM/L9jkPfZExg3nFxGtwplMCBffQcLTphinPNaduPQxHhvaaBQox+0fpmDFzQ69Ek2FAXA4bVWQWO9+U0b0HQFHGKIRiW3lxJ5I71wMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784341; c=relaxed/simple;
	bh=S/w4rcPpjdCSlbEXLRTbupYmKMQDjYrB2GZB3TJpTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eum+DeUeMiZ3gwY6XUMHK0hjKfqn1/C3z7t91GLrSvUKSb+0PK1SpJdu57zMu50NadnQsOyFM+wG4xxn+hP96EhCnqqasMzpAdIYcs+c7j9uoqZXg1yU+kvVCM4OjKwEdVBdzCR6OUeIjqbmL1QwCAgUPhzi6FefKXNmlWSMWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF5yT2Ru; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445824dc27so44617445ad.3;
        Mon, 01 Sep 2025 20:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756784339; x=1757389139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIaSbWL2dZQ+TqaX4gZk06wKwcC7c40+iHQ42933n6M=;
        b=QF5yT2RubznGjW7uefMi+0bMs6QTA9AZ4rJV1uLuY11eOnT0/zMYBxQciVMgOyFk+z
         //RO+ykb99bA6KXLocT4e1IXxQf38TShr7IT+a7bF5Qr/f9Y/WqhSLBHWCQbu+lwBv+D
         AEq9c2TzkNf+T8ChLY+OTSygzXWs6U//f+W3ShV1kdm5jQ5GAPpjyqO4l4xBCLbuRkT7
         /G2vP2X0EaCdeX8xmM/0VXC4bYbI6CSgvPgNwfiTXC0auT4fyLXrJqny0mO1UPyfMqw8
         Uuhxh2W810F2g0fLlqY3osy6Xq3gPm3Kfuuu7zNj78HDzm8Rgx6oVVenH+niCINWs0MR
         YBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756784339; x=1757389139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIaSbWL2dZQ+TqaX4gZk06wKwcC7c40+iHQ42933n6M=;
        b=RGKH8/MBPnSLvy7piFRIRZakCkZ4IHD5Uaz9njU9SNooRTpPNzZzdOqrtjwgKcxYp4
         AuMJw6XXzOSMUeTMJ3IlTdA88yIbebH1CD6zibPu3SwE9p84R4drmbFEpoWW9ygnINSQ
         ggIFudv5AJyQ9ZGYHSqndyQCgKvvOEf+J0ePFm5lrrN0MMyiIrjmdccEDS0MnfzOsW8G
         jrBguigUBawEVd1uDeJL6GhrDUwUZz3grhQyZSkEM70bUmqjuV4FR6MaKoBQR16g3+Of
         UGbibGqkgG7QLwxl+hJIZZMeL7D504RunQVvctMIRhQW49x9fov8dMrPTQUa4H7JUL3H
         XdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeHB3RbUWtSNNO6kZ/iC5WKE1MiwbQhbk29LGXoaTchG6gFXjmNAd1MyMMQ+1fWAYkBEN0NhQ17SZRif7k@vger.kernel.org, AJvYcCWWYZSEGUVEL6cW96ISYVRiQOPYYlnTrh4GvKYh/yTaRmsAiOxHtemKKy7aA4SwjV4uVV8xy4TN@vger.kernel.org, AJvYcCXdQF1GIM1C1Eg9H7FyKR8uxjeXPQtzX3x3g8gEhhIACOUSYhCgWZEFyILcp1rjk1cFvLUYq2T2xBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBa9lojwhbAav45uP+h4wn2u0duELi3HXdWNQ7nboQt3d30GPk
	viY6zDxfvYXn3vHlUwCZWdspI6IQbv2Dz2stSi06C+bl8+5raNkLg5zV
X-Gm-Gg: ASbGnctnUwri89wqfmM8C0Atvjs3pBVIfvmNQIpcBvC4CeErbjZFoHZAekAx+U2WVCA
	6o0m86/0CKOmdraixvEOniHC9Fcjw7UL6kXwHWUy5pZTcPRZTUbgBQnJS4H15tnmV/Ih+/x9145
	gQQhzbDr/T6EledE3Qdd1xPRJsHbHTy1NWN1KI8iB3kT/hDWSQMBL6uEQKBbK3GYsCiHS/vkMaC
	zhvVQVev9MhFz/Bbzi6wBHemSr0i+UmW65n1o67yyPuxu88UiyB+Zk1fSxPfPhOR96JCuDa4zV9
	qc4Gz1F7UE/1UjPnP5K5W0wLfn/6xTQIzXJepWB3is7x4a7AyBmQ3aZDRzB5qf5OKRWjNIw59t7
	mTARDjfrM7kX6NYL2v37/ckhBug==
X-Google-Smtp-Source: AGHT+IHpKPhunch+gKdXPihdTtHy8wS4Gp4GiQ6oSq0uQEsO4ntq613aSW+z0RvX6o0rQl/Rac+k9g==
X-Received: by 2002:a17:902:d501:b0:245:f1bb:9bf9 with SMTP id d9443c01a7336-24944870959mr155779785ad.12.1756784339123;
        Mon, 01 Sep 2025 20:38:59 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da3c43sm118118215ad.80.2025.09.01.20.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:38:58 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2] net/tls: support maximum record size limit
Date: Tue,  2 Sep 2025 13:38:10 +1000
Message-ID: <20250902033809.177182-2-wilfred.opensource@gmail.com>
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
 Documentation/networking/tls.rst |  7 ++++++
 include/net/tls.h                |  1 +
 include/uapi/linux/tls.h         |  2 ++
 net/tls/tls_main.c               | 39 ++++++++++++++++++++++++++++++--
 net/tls/tls_sw.c                 |  4 ++++
 5 files changed, 51 insertions(+), 2 deletions(-)

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
index 857340338b69..c9a3759f27ca 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -226,6 +226,7 @@ struct tls_context {
 	u8 rx_conf:3;
 	u8 zerocopy_sendfile:1;
 	u8 rx_no_pad:1;
+	u16 record_size_limit;
 
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
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a3ccb3135e51..1098c01f2749 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -812,6 +812,31 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+static int do_tls_setsockopt_record_size(struct sock *sk, sockptr_t optval,
+					 unsigned int optlen)
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
+	ctx->record_size_limit = value;
+
+	return 0;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -833,6 +858,9 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	case TLS_RX_EXPECT_NO_PAD:
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
+	case TLS_TX_RECORD_SIZE_LIM:
+		rc = do_tls_setsockopt_record_size(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -1065,7 +1093,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
 
 static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 {
-	u16 version, cipher_type;
+	u16 version, cipher_type, record_size_limit;
 	struct tls_context *ctx;
 	struct nlattr *start;
 	int err;
@@ -1110,7 +1138,13 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 		if (err)
 			goto nla_failure;
 	}
-
+	record_size_limit = ctx->record_size_limit;
+	if (record_size_limit) {
+		err = nla_put_u16(skb, TLS_INFO_TX_RECORD_SIZE_LIM,
+				  record_size_limit);
+		if (err)
+			goto nla_failure;
+	}
 	rcu_read_unlock();
 	nla_nest_end(skb, start);
 	return 0;
@@ -1132,6 +1166,7 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +	/* TLS_INFO_TXCONF */
 		nla_total_size(0) +		/* TLS_INFO_ZC_RO_TX */
 		nla_total_size(0) +		/* TLS_INFO_RX_NO_PAD */
+		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_RECORD_SIZE_LIM */
 		0;
 
 	return size;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bac65d0d4e3e..9f9359f591d3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1033,6 +1033,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	unsigned char record_type = TLS_RECORD_TYPE_DATA;
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool eor = !(msg->msg_flags & MSG_MORE);
+	u16 record_size_limit;
 	size_t try_to_copy;
 	ssize_t copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
@@ -1058,6 +1059,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		}
 	}
 
+	record_size_limit = tls_ctx->record_size_limit ?
+			    tls_ctx->record_size_limit : TLS_MAX_PAYLOAD_SIZE;
+
 	while (msg_data_left(msg)) {
 		if (sk->sk_err) {
 			ret = -sk->sk_err;
-- 
2.51.0


