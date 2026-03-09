Return-Path: <netdev+bounces-265378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Jf/J/dgrmlbCwIAu9opvQ
	(envelope-from <netdev+bounces-265378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:56:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF523408A
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 053773043D17
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 05:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7B34D395;
	Mon,  9 Mar 2026 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diN4NXLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90534D392
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035688; cv=none; b=ECxBDdO12Y5CH9cyNNY9ppyzJeMAyrUNBmVFjKEu83/4OsOJTcm9z1elEUCNq0RPXlwHIGkttLGsM/9NER8KU+SLUB9i3y4x9beQ/I8RfmVcOQikU5g6J9FQ/jNLsKBP96eyg8K7QjpZ8ED92FVjrUW49N6amqqZD9jXNz51VEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035688; c=relaxed/simple;
	bh=UreViDwj5CK4brJrjfQ7EURHubCS5eOib6jZhMepOdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxd7F3rRdFAd1OxtCC2Ocn2fRN8Z3ZKeNQigPvjRn9X6wl8xQlswySLERoitaoqaoV1MtVghHpZUAVpBLAIBv/X4xRR0OUcnafKVMlVE9hYAepIpErqGjabcyrhEyaSitPLkEdZpeu36KyntGEx5Ut9SOHh2gjCcmRH8MaJO6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diN4NXLb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70c112cb61so6214236a12.0
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 22:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773035687; x=1773640487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eXVlNI+VPppaY/morooabCwuSYEtf9ABnZ29jfqnh4=;
        b=diN4NXLbF4APbkdr50c/3buNpeiadWd82VxtjgPvoGcoRutc3j2Nu6wHNgxkIkqdBW
         YpXtsql8z0v6B5UM1N/XMPUdZ+HiZ9WoYIAMyAN7Nogld0k4WR4b0qmEW3gihjzXvLlt
         rGxenB7Pof6NqcF9rrbN6olzW6/MUZNQP/EA1n4AYKKND2xdCdKG2Kq9UtrC7lPlFDtT
         tZPnZmxaeAzXJVtdjiEQu1u0mzcySl7jJEZxGw6svm2rf1Rsdy69EP0sn5rS8tDx+1/J
         OTnrdUSrzf6ye0uEAJILUDvQoTxLo6qHy6pjaZtqoFWAUGLC8h3uH9lrTNC9/p5TllkG
         5QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035687; x=1773640487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eXVlNI+VPppaY/morooabCwuSYEtf9ABnZ29jfqnh4=;
        b=JRHxvfSjDnJwfpF1eoCbNJn/66v0+Au4z+b9JOzqYXzGoJ5GCxsc+yjjSjaQiLb3CV
         RCASbH+4Jd9P/ghG/NQJiP1hqe/fqgcv/LXZAgzYS7neg1fqy6waalhXx8KKs67rq13t
         cgj6dtBWnGffARONlStLX9x1Pz5catwfVmMHlxHh8axvT84CEdR9Do7vvOO0+bmvLjuS
         jbNpdIMtLjiY2ZKwCP7MgcUNAQFEsaNgERy89MdTm2cYCjShuIvrqAU85AcaA4G18VPu
         PLLjEDyB1bN7/5lPCF1WyPnYSJhjn9cLgcS5DtKWrDOKNIYjPYF1/kJca/OR7qbPFt+y
         uVJg==
X-Gm-Message-State: AOJu0YxRcjVW4eqAz0VgH0OvzSfRxgH/4v9hEqSMSw56hkIIjBHXs1AH
	cLEXqbA0rEnCJTU16C7hMiYnnq/cwzv7SiqKMEkxLKuifC/mo5JBDTaq
X-Gm-Gg: ATEYQzwHxkVcGFnbEKZzYcGSiYqj3RRqpxGqcqJQ4sXGAXuT8gFNo+3asR46V5Yh4hn
	4cyDBNr9UtKTq4oM7iEyXPWzr6XwAWliu+FOI7wYmuKbflllcaRdty5NrlVfreWn5qE1sTj5ej2
	QqnhiiSgDQ9oOCW99mZc7QgoEwpmvLJTbFygSi+mtwjurDPK6WwHNERrFOExKWOSvDM0IpGvYGH
	vsvLKXeOWOmoVqeXK6IBuQX/lTcH//5EwqNFRPL4PB/KqmWRc5jsuFVgl34UNXsRiyLsSfL6if1
	1chweP+etZ2JznjcSi3nGGGshS18h3l3jFBAP/LeJGYMaxYNZqqo9Ldak2hGNnEFlJI7eAV37Dp
	M/vl/vvkdwew9m1MgobgLTfPXqvU9/Lyv+RQ1UHfEU20xW/FAdQrrzI1WAFBS94Ug9flzldEA7n
	BRaPA9UW+ZguHLaTfIztXBcPuwyhTSz5rOdAsLludQQTu2FSbHdquY+doa0ry0
X-Received: by 2002:a05:6a20:cf8b:b0:38e:90ca:5a4b with SMTP id adf61e73a8af0-39859089f98mr9851848637.45.1773035686645;
        Sun, 08 Mar 2026 22:54:46 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170923sm7933716a12.17.2026.03.08.22.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:54:46 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC net-next 2/3] net/tls: add randomized zero padding socket option
Date: Mon,  9 Mar 2026 15:48:37 +1000
Message-ID: <20260309054837.2299732-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05EF523408A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265378-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ietf.org:url,wdc.com:email]
X-Rspamd-Action: no action

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Currently, for TLS 1.3, ktls does not support record zero padding [1].
Record zero padding is used to allow the sender to hide the size of the
traffic patterns from an observer. TLS is susceptible to a variety of traffic
analysis attacks based on observing the length and timing of encrypted
packets [2]. Upcoming Western Digital NVMe-TCP hardware controllers
implement TLS 1.3. Which from a security perspective, can benefit from having
record zero padding enabled to mitigate against traffic analysis attacks
[2].

Add a new TLS_TX_RANDOM_PAD ktls socket option that allows userspace to
enable and specify an upperbound for randomized record zero padding
in TLS 1.3. When this value is set and non-zero, ktls will append a
randomized amount of [0, min(record_room, upper_bound)] bytes to records
that are end-of-record (EOR) and aren't full. This can be set back to zero
to disable appending zero padding. By default, no record zero padding is added.

The number of zero padding bytes is randomised primarilly to reduce some of
the throughput overhead of using a fixed zero padding amount up to the
record size limit.

[1] https://datatracker.ietf.org/doc/html/rfc8446#section-5.4l
[2] https://datatracker.ietf.org/doc/html/rfc8446#appendix-E.3

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 Documentation/networking/tls.rst | 21 ++++++++++
 include/uapi/linux/tls.h         |  2 +
 net/tls/tls_main.c               | 70 ++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 980c442d7161..e112a68a9bfb 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -300,6 +300,27 @@ extra byte used by the ContentType field.
 
 [1] https://datatracker.ietf.org/doc/html/rfc8449
 
+TLS_TX_RANDOM_PAD
+~~~~~~~~~~~~~~~~~
+
+Enable and set the limit for randomized zero padding [1] of outgoing
+TLS records.
+
+When enabled, TLS records that are not full and are end of record (EOR)
+will be padded with a randomly chosen amount of zero padding up to the remaining
+record capacity or the limit provided by this option (smaller of the two).
+Randomized zero padding can reduce information leakage via observable TLS
+record lengths and mitigates traffic analysis based on message size.
+
+Padding never exceeds the protocol maximum record size and full-sized records
+are unchanged.
+
+This increases bandwidth usage and may add CPU overhead due to padding
+generation and larger encryption operations. For workloads with small records,
+the bandwidth overhead may be significant.
+
+[1] https://datatracker.ietf.org/doc/html/rfc8446#section-5.4
+
 Statistics
 ==========
 
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index b8b9c42f848c..42a318cb5eb8 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -42,6 +42,7 @@
 #define TLS_TX_ZEROCOPY_RO	3	/* TX zerocopy (only sendfile now) */
 #define TLS_RX_EXPECT_NO_PAD	4	/* Attempt opportunistic zero-copy */
 #define TLS_TX_MAX_PAYLOAD_LEN	5	/* Maximum plaintext size */
+#define TLS_TX_RANDOM_PAD	6	/* TLS TX randomized record zero padding */
 
 /* Supported versions */
 #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
@@ -196,6 +197,7 @@ enum {
 	TLS_INFO_ZC_RO_TX,
 	TLS_INFO_RX_NO_PAD,
 	TLS_INFO_TX_MAX_PAYLOAD_LEN,
+	TLS_INFO_TX_RANDOM_PAD,
 	__TLS_INFO_MAX,
 };
 #define TLS_INFO_MAX (__TLS_INFO_MAX - 1)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b0702effbc26..62c525afbc14 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -563,6 +563,30 @@ static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char __user *optval
 	return 0;
 }
 
+static int do_tls_getsockopt_tx_random_pad(struct sock *sk, char __user *optval,
+					   int __user *optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	u16 pad_limit = ctx->tx_record_zero_pad;
+	int len;
+
+	if (ctx->prot_info.version != TLS_1_3_VERSION)
+		return -EOPNOTSUPP;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < sizeof(pad_limit))
+		return -EINVAL;
+
+	if (put_user(sizeof(pad_limit), optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, &pad_limit, sizeof(pad_limit)))
+		return -EFAULT;
+
+	return 0;
+}
 static int do_tls_getsockopt(struct sock *sk, int optname,
 			     char __user *optval, int __user *optlen)
 {
@@ -585,6 +609,9 @@ static int do_tls_getsockopt(struct sock *sk, int optname,
 	case TLS_TX_MAX_PAYLOAD_LEN:
 		rc = do_tls_getsockopt_tx_payload_len(sk, optval, optlen);
 		break;
+	case TLS_TX_RANDOM_PAD:
+		rc = do_tls_getsockopt_tx_random_pad(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -860,6 +887,33 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
 	return 0;
 }
 
+static int do_tls_setsockopt_tx_random_pad(struct sock *sk, sockptr_t optval,
+					   unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	u16 value;
+
+	if (ctx->prot_info.version != TLS_1_3_VERSION)
+		return -EOPNOTSUPP;
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
+	if (value >= ctx->tx_max_payload_len)
+		return -EINVAL;
+
+	ctx->tx_record_zero_pad = value;
+
+	return 0;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -886,6 +940,11 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
 		release_sock(sk);
 		break;
+	case TLS_TX_RANDOM_PAD:
+		lock_sock(sk);
+		rc = do_tls_setsockopt_tx_random_pad(sk, optval, optlen);
+		release_sock(sk);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
@@ -1173,6 +1232,13 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 	if (err)
 		goto nla_failure;
 
+	if (version != TLS_1_3_VERSION) {
+		err = nla_put_u16(skb, TLS_INFO_TX_RANDOM_PAD,
+				  ctx->tx_record_zero_pad);
+		if (err)
+			goto nla_failure;
+	}
+
 	rcu_read_unlock();
 	nla_nest_end(skb, start);
 	return 0;
@@ -1185,6 +1251,7 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
 
 static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 {
+	struct tls_context *ctx = tls_get_ctx(sk);
 	size_t size = 0;
 
 	size += nla_total_size(0) +		/* INET_ULP_INFO_TLS */
@@ -1197,6 +1264,9 @@ static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
 		nla_total_size(sizeof(u16)) +   /* TLS_INFO_TX_MAX_PAYLOAD_LEN */
 		0;
 
+	if (ctx->prot_info.version == TLS_1_3_VERSION)
+		size += nla_total_size(sizeof(u16)); /* TLS_INFO_TX_RANDOM_PAD */
+
 	return size;
 }
 
-- 
2.53.0


