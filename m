Return-Path: <netdev+bounces-265377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P5cAqVgrmlbCwIAu9opvQ
	(envelope-from <netdev+bounces-265377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF7234037
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 06:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE9D23007889
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 05:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1882134CFD7;
	Mon,  9 Mar 2026 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHjUVd+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBF1E834E
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035682; cv=none; b=KDGUHwPkBWlbkvd+jV4ouLNt8GpCkO2tBmbjsekpdK0xdy4Qri471sKCANG0MHtHjTwcN6pIgiT7L4cYJmI1eH2Od73LCPTKM3V9TngyYeOEwhNPZwecdbeWsuMyRQRbQAXABPWAUQP/kgseph6CWnmMsHsclLZB4PiX2PAMDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035682; c=relaxed/simple;
	bh=naXvgUL1vrrylA++ctQr+L9oQ71V0LFb27f4Yj4ef0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOelDaRveGZQt2Vd4zlizHlB1jiFIxrofy6LV0eFTFp5E7409Qptja+1Q7XuKLFBL0+fSskyQ3f3p1p6RMZW7YoFF+rvgqhBcHGcka3LgIB/OedXxCUOPm+hxG/X8THTzPQe0lv9UD0IuKLUuAtyScUk+siTac6m5/YgByRMTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHjUVd+v; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c739d32b72cso1730671a12.2
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773035680; x=1773640480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZOR83ZELRZ96AOmva1kehfsvl1uJwm5zQkZMO8Il2Y=;
        b=XHjUVd+vX7DcB+Fj7synsk8LCV3UWf+1e66c906/v23ZdJ/zJStor8Bbf9TTQ7aEDz
         iiXNwAYiGpKi+6UTqVRpQL8VUgAUs/qAfgBGWhPOcmbyMVXux9oWwYxGgKnyTmOSFRwl
         u/+xnYaTuFgcxCbEYuxd9hZZrXCCm3dqsRr+w967bOxDrE5toqCnNUH4Wfh3td8Ss4U8
         K+CHHDwKrSDbKbxIpn0HJUhlL4BlTuIUJiAwjMX3aESfrpLsgT2Itc8Wxzdxf99ZaqVa
         1kGLJ9cNWgE6Aefdn9BU1KmRboXWQjjkWJbk8zCoEKSGtE9xxKOvk5k2wa/2Dbw/rfXg
         2SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035680; x=1773640480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZOR83ZELRZ96AOmva1kehfsvl1uJwm5zQkZMO8Il2Y=;
        b=chWN6krXYDJy6L4khIw990GfBRonglMEAsBN54tFq3UaFyZv9odi57hrOaJJSnpQdk
         QuonXaKGukbYNTaQKoeB0TH5rqWh7d4ZMkv1vKl9qH/FEH0Phb+gMK20R4iGqdKVbC1P
         KMC2cgZavPSomD7o9PgMy3wVSRF4sPMFpiloZERs+YYgno6p1kvE0Mq8mhx1iICv4pcp
         WAlZVvaJYJ55YzFlX0gYFcvgnox7CuDDKcOtWOSeO/HnkYaAAROc09e+fKsOYWJy2ycQ
         ioUYwyCi2I8A+dXwNQUj6ZESHqYZBSaEOJvLOx4HnRIW8lYoGIJidOPeKVuFtCi+0zwK
         TsQA==
X-Gm-Message-State: AOJu0YwkoDimEQjZMyADzourCq7S+sPXtBZzTa3bpAkG085kzk4bwLQl
	AWwVeBdUbazJbVGYArKGRZeMEeVh4/J2n5g4gw3Y1tJlGnR8rTRQA0xKNaxEqg==
X-Gm-Gg: ATEYQzxDaBDLNDNzBomwk6pfQ9O860xz+d0GGBYRPnN4r6lokpQbD2UxGV8a9bwl7M9
	ZrxBYLuhoxZFLmACsMEpxnHT6NSC8lwoxCKtn1vuzJsqXCwYBxlG9AsuhPxjwXynL/szq9GcU5N
	S0UCXW2mWjJbIOaX7TBUksCFmiHxuOy1QmlDHShuBsD4gJ7YvCB/ilru4YaLkGEsDMKJmTBoGGd
	J/Ux4XjBdczWq4cA8Oy0wuFOza9IKkA5DX2XkuHP9L3sFW6HVHdrSXwCKMDKh1ztTuL7CghSvTy
	hvrMcIG0FdsW4i/GugBIesxkw+WLDsCi+vKEPzB41I0/BZRF6l6Cz3piCT7JtUKPhSVJy4Vnq7o
	dRtInPxybHypd6UON001UBiCK7A+z6suGLvDkxZ+SvMaHYbZOVDHEi4VFXPpEJzuSzfhu3Bp3xx
	cO3EVqxl8GwsleqdkUEx1UO8d6CMs7IHAIZR0INth6vibG7gsBbNBdnkTmTY4pAdVqRWpjwpw=
X-Received: by 2002:a05:6a20:a10e:b0:398:7853:c495 with SMTP id adf61e73a8af0-3987853c6d0mr5367983637.3.1773035679994;
        Sun, 08 Mar 2026 22:54:39 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170923sm7933716a12.17.2026.03.08.22.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:54:39 -0700 (PDT)
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
Subject: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Date: Mon,  9 Mar 2026 15:48:36 +1000
Message-ID: <20260309054837.2299732-3-wilfred.opensource@gmail.com>
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
X-Rspamd-Queue-Id: 9CEF7234037
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Currently, for TLS 1.3, ktls does not support record zero padding [1].
Record zero padding is used to allow the sender to hide the size of the
traffic patterns from an observer. TLS is susceptible to a variety of traffic
analysis attacks based on observing the length and timing of encrypted
packets [2]. Upcoming Western Digital NVMe-TCP hardware controllers
implement TLS 1.3. Which from a security perspective, can benefit from having
record zero padding enabled to mitigate against traffic analysis attacks [2].

Thus, for TX, add support to appending a randomized number of zero padding
bytes to end-of-record (EOR) records that are not full. The number of zero
padding bytes to append is determined by the remaining record room and the
user specified upper bound (minimum of the two). That is
rand([0, min(record_room, upper_bound)]).

For TLS 1.3, zero padding is added after the content type byte, as such,
if the record in context meets the above conditions for zero padding,
attach a zero padding buffer to the content type byte before a record is
encrypted. The padding buffer is freed when the record is freed.

By default, record zero padding is disabled, and userspace may enable it
by using the setsockopt TLS_TX_RANDOM_PAD option.

[1] https://datatracker.ietf.org/doc/html/rfc8446#section-5.4l
[2] https://datatracker.ietf.org/doc/html/rfc8446#appendix-E.3

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/net/tls.h  |  1 +
 net/tls/tls.h      |  6 ++++-
 net/tls/tls_main.c |  2 ++
 net/tls/tls_sw.c   | 58 ++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..1feef72cc339 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -229,6 +229,7 @@ struct tls_context {
 	u8 zerocopy_sendfile:1;
 	u8 rx_no_pad:1;
 	u16 tx_max_payload_len;
+	u16 tx_record_zero_pad;
 
 	int (*push_pending_record)(struct sock *sk, int flags);
 	void (*sk_write_space)(struct sock *sk);
diff --git a/net/tls/tls.h b/net/tls/tls.h
index e8f81a006520..3a86eb145332 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -121,8 +121,12 @@ struct tls_rec {
 	/* AAD | msg_encrypted.sg.data (data contains overhead for hdr & iv & tag) */
 	struct scatterlist sg_aead_out[2];
 
+	/* TLS 1.3 record zero padding */
+	char *zero_padding;
+	u16 zero_padding_len;
+
 	char content_type;
-	struct scatterlist sg_content_type;
+	struct scatterlist sg_content_trail[2];
 
 	struct sock *sk;
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..b0702effbc26 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1076,6 +1076,8 @@ static int tls_init(struct sock *sk)
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
+	/* TX record zero padding is disabled by default */
+	ctx->tx_record_zero_pad = 0;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a656ce235758..84b167607e1f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -389,6 +389,7 @@ static void tls_free_rec(struct sock *sk, struct tls_rec *rec)
 {
 	sk_msg_free(sk, &rec->msg_encrypted);
 	sk_msg_free(sk, &rec->msg_plaintext);
+	kfree(rec->zero_padding);
 	kfree(rec);
 }
 
@@ -430,6 +431,7 @@ int tls_tx_records(struct sock *sk, int flags)
 		 */
 		list_del(&rec->list);
 		sk_msg_free(sk, &rec->msg_plaintext);
+		kfree(rec->zero_padding);
 		kfree(rec);
 	}
 
@@ -450,6 +452,7 @@ int tls_tx_records(struct sock *sk, int flags)
 
 			list_del(&rec->list);
 			sk_msg_free(sk, &rec->msg_plaintext);
+			kfree(rec->zero_padding);
 			kfree(rec);
 		} else {
 			break;
@@ -779,12 +782,29 @@ static int tls_push_record(struct sock *sk, int flags,
 	sk_msg_iter_var_prev(i);
 
 	rec->content_type = record_type;
+
 	if (prot->version == TLS_1_3_VERSION) {
-		/* Add content type to end of message.  No padding added */
-		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
-		sg_mark_end(&rec->sg_content_type);
+		/*
+		 * Add content type to end of message with zero padding
+		 * if available.
+		 */
+		sg_init_table(rec->sg_content_trail, 2);
+		sg_set_buf(&rec->sg_content_trail[0], &rec->content_type, 1);
+		if (rec->zero_padding_len) {
+			rec->zero_padding = kzalloc(rec->zero_padding_len,
+						    sk->sk_allocation);
+			if (!rec->zero_padding)
+				return -ENOMEM;
+
+			sg_set_buf(&rec->sg_content_trail[1],
+				   rec->zero_padding, rec->zero_padding_len);
+			sg_mark_end(&rec->sg_content_trail[1]);
+		} else {
+			sg_mark_end(&rec->sg_content_trail[0]);
+		}
+
 		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
-			 &rec->sg_content_type);
+			 rec->sg_content_trail);
 	} else {
 		sg_mark_end(sk_msg_elem(msg_pl, i));
 	}
@@ -805,19 +825,21 @@ static int tls_push_record(struct sock *sk, int flags,
 	i = msg_en->sg.start;
 	sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
 
-	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
-		     tls_ctx->tx.rec_seq, record_type, prot);
+	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size +
+		     rec->zero_padding_len, tls_ctx->tx.rec_seq,
+		     record_type, prot);
 
 	tls_fill_prepend(tls_ctx,
 			 page_address(sg_page(&msg_en->sg.data[i])) +
 			 msg_en->sg.data[i].offset,
-			 msg_pl->sg.size + prot->tail_size,
-			 record_type);
+			 msg_pl->sg.size + prot->tail_size +
+			 rec->zero_padding_len, record_type);
 
 	tls_ctx->pending_open_record_frags = false;
 
 	rc = tls_do_encryption(sk, tls_ctx, ctx, req,
-			       msg_pl->sg.size + prot->tail_size, i);
+			       msg_pl->sg.size + prot->tail_size +
+			       rec->zero_padding_len, i);
 	if (rc < 0) {
 		if (rc != -EINPROGRESS) {
 			tls_err_abort(sk, -EBADMSG);
@@ -1033,6 +1055,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	unsigned char record_type = TLS_RECORD_TYPE_DATA;
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool eor = !(msg->msg_flags & MSG_MORE);
+	bool tls_13 = (prot->version == TLS_1_3_VERSION);
+	bool rec_zero_pad = eor && tls_13 && tls_ctx->tx_record_zero_pad;
 	size_t try_to_copy;
 	ssize_t copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
@@ -1043,6 +1067,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	int record_room;
 	int num_zc = 0;
 	int orig_size;
+	int max_zero_pad_len, zero_pad_len = 0;
 	int ret = 0;
 
 	if (!eor && (msg->msg_flags & MSG_EOR))
@@ -1085,8 +1110,19 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			full_record = true;
 		}
 
+		if (rec_zero_pad && !full_record)
+			zero_pad_len = record_room - try_to_copy;
+
+		if (zero_pad_len > prot->tail_size) {
+			max_zero_pad_len = min(zero_pad_len,
+					       tls_ctx->tx_record_zero_pad);
+			zero_pad_len =
+				get_random_u32_inclusive(0, max_zero_pad_len);
+			rec->zero_padding_len = zero_pad_len;
+		}
+
 		required_size = msg_pl->sg.size + try_to_copy +
-				prot->overhead_size;
+				prot->overhead_size + rec->zero_padding_len;
 
 		if (!sk_stream_memory_free(sk))
 			goto wait_for_sndbuf;
@@ -2555,6 +2591,7 @@ void tls_sw_release_resources_tx(struct sock *sk)
 				       struct tls_rec, list);
 		list_del(&rec->list);
 		sk_msg_free(sk, &rec->msg_plaintext);
+		kfree(rec->zero_padding);
 		kfree(rec);
 	}
 
@@ -2562,6 +2599,7 @@ void tls_sw_release_resources_tx(struct sock *sk)
 		list_del(&rec->list);
 		sk_msg_free(sk, &rec->msg_encrypted);
 		sk_msg_free(sk, &rec->msg_plaintext);
+		kfree(rec->zero_padding);
 		kfree(rec);
 	}
 
-- 
2.53.0


