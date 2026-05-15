Return-Path: <netdev+bounces-288464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA5lJsORB2pU9AIAu9opvQ
	(envelope-from <netdev+bounces-288464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF684558357
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64823058E18
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B87405C4B;
	Fri, 15 May 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AFVVya00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF43405C34
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880550; cv=none; b=gAgG8y7S1O0X9Rcy25Xnju6YTGyt3b5ScIGQ2gAGy29k7XO99XEYIUd6bNjtXqz3atW/+qtDQKgBPIn5E21/7A2aEDiTsjUjwZDdKZ/ljSqE6Vt3KrYc++RcL+Xp1XR5+Muk2HasS0NPo0LbZFHMdN9DuPuXT4OSji/Uj1iJPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880550; c=relaxed/simple;
	bh=C/G/FsQ9RGpw1P6Vr/QGhLlkl1IcMIHtpATYSPTA2dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thcslWksRjFbW2Y2aQvKMjVh2wTJ/ERzPrT0sh1VFLxX0D/hbWVfOuwgpzwoUFsWomTRUzug3iLz4YjnXrwL4IkkVBA4E4O+lzSW/259+DRFmdQdxT16K+fATFcTjG58VqUmxo/ppLmwDqLOYEk8doPHNrIRIDI2vQcZJM4AQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AFVVya00; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-479d5ff103aso231247b6e.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880548; x=1779485348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhpcEGsJtg6xA75eyhLGe0ZGIZNiEQlJkWDyY4hwOKc=;
        b=AFVVya00kzU2dwJX4++xaV1p7vqxhz/DNG5SdOnoucvS6dcKTlevOhs7ceDskeqYsm
         f/oqdBi+AhyZ/M2I9O177penwZPr0wisi8LVbOOtsbJM6cBKawE2rwqWms2vtYvf/zYK
         YnH5T26+LltuVM1leSKvwCGFZwF9nTd25iAvWa2HbyibBKSho3s01f3osRBfVY03SoDP
         6xaBNSKOxXYqA8QPo3NhKoSE/B1F+arbFF3hn8Q+yTk4xKg4MkxThYhALw/x96IuHs7A
         0Fuu2Da+OM2OEs8HlOamIUkbUpIsXpz+vLTYk0sLclH5dj/gy5lNriRfYyz41ol8CW7Z
         mU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880548; x=1779485348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhpcEGsJtg6xA75eyhLGe0ZGIZNiEQlJkWDyY4hwOKc=;
        b=U1YACVZ4CBZXI/we7aDb10kXZI6Y38/MrfL+Fnjgz3naL+t3yage4NK2QiTX3ZBZVi
         X3GV96RZnZZhz4/U8UsK+pOdmlPyp68yLW/sQvjhfZ5shM+7pxhozWL6lBc2Mdm11mhl
         sjhRI2OA9+zMGgZ/dA4u3WfcWUhzDC8DopWdJcFHi5fzl0xraXk0ioqPC9564KCJj5jU
         dWw7EH72g6Sjaf6QSiaF4aJlRyzKBMRJ2cTDRKG5OqKfWZqCT0O0VvtNCTz8Sz8xmQvo
         NMZN03R4PPeQyKgwnjJkSn/gcnCzmlLGwcD/nWYpzKe9z3Uj2DE5+cXnEWvVyPQK4Zjj
         S7yg==
X-Gm-Message-State: AOJu0Yw5pv/YY6MF7CNNYK84l4Ip5toMsV5N85S975LO43iZFmS43H8W
	0mfjbM1ZaGnVaLg1Evhoz2d7WCodP7N0tkifUPs2L3dx5h1vYwjpEdG35gTlYyVF0Sow4i/5wT5
	2hi+KhTT0HPdYn0cS2MpKl29EZMwiiQlAwK9Yzk8KkX34zzKZ9IyT8m6k2iSKPC6T4FdtVO/fQ6
	P0E85tDp1Xf5rJW4grkD5x+OLeYZJMzZafTqg2zXdv2eyqShM=
X-Gm-Gg: Acq92OFZNVz6eKlOIaAqdwrSh3vARk1x9Pjm24AETCdt7jyGLMdEvcf34cZi7/Q4YyX
	Hqu4L+b7ChtKb3rVAPKjjrnJAVFUHKkj1IqClgBQTivdBBb2OvxbzXpS1HpNRZzR6zZ/v0BV3me
	PwGV2LCPvnYH5ugLB9paNkObF7gWMTyPIjFpDDak/kmnsDogkWClLGaOqcSVDUF04kpdtom9+YU
	0BrSOnAXKbJGxmfo175Qv99Gur7FE9XVCHzQJfU7ZiQRoFpdF/RRq+vjXxPK7ysYD8BbiWxqTXy
	Atco+t3wMgZ6V5MOvoG22LtdNYJdvPYae3p6S6YN7VAJVTAIujDUu2kzsyzJIKMGF+vP5t11H2f
	3y3LBPspZPbmJhSsOV3Act6H30E5IS+4RZR7EXgcp9ktPxJLETgvl7i2iYptj6NCEyPcO3QxYSS
	1j0sobtibMo/q701RvV+SQI8HWtxzhKTXoHnJGpwNJ3fZONy/mmUBl8B+B+A==
X-Received: by 2002:a05:6820:a04:b0:69b:3a3b:de68 with SMTP id 006d021491bc7-69c94301000mr3546798eaf.23.1778880547791;
        Fri, 15 May 2026 14:29:07 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:29:07 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v14 8/9] tls: device: add tracepoints for RX KeyUpdate path
Date: Fri, 15 May 2026 15:27:14 -0600
Message-Id: <20260515212715.3151307-9-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515212715.3151307-1-rjethwani@purestorage.com>
References: <20260515212715.3151307-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF684558357
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288464-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

Add three trace events covering the RX rekey state machine in
tls_device.c:

  tls_device_rekey_start     - rekey accepted; inflight=1 means old-key
                               data is still queued, dev_add deferred
  tls_device_rekey_reencrypt - old-key undo pass for a boundary record;
                               retry=1 means decrypted flags were flipped
  tls_device_rekey_done      - boundary crossed, old_aead_recv freed,
                               deferred dev_add issued if pending

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 10 ++++++
 net/tls/trace.h      | 79 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 1c58cbd55ffb..f6072924bfb5 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1234,6 +1234,9 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 		if (ctx->old_key_reencrypted) {
 			struct sk_buff *frag_iter;
 
+			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
+							 ctx->rekey.old_nic_boundary,
+							 true);
 			skb->decrypted = !skb->decrypted;
 			skb_walk_frags(skb, frag_iter)
 				frag_iter->decrypted = !frag_iter->decrypted;
@@ -1253,12 +1256,17 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 			/* For mixed records, first old key rencrypt and if
 			 * SW AEAD fails then retry with decrypted flags toggled
 			 */
+			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
+							 ctx->rekey.old_nic_boundary,
+							 false);
 			if (!is_decrypted)
 				ctx->old_key_reencrypted = 1;
 			return tls_device_reencrypt_old_key(sk, ctx,
 							   sw_ctx, tls_ctx);
 		}
 
+		trace_tls_device_rekey_done(sk, rec_start_seq,
+					    ctx->rekey.old_nic_boundary);
 		crypto_free_aead(ctx->rekey.old_aead_recv);
 		ctx->rekey.old_aead_recv = NULL;
 
@@ -1827,6 +1835,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
 				context->rekey.old_nic_boundary = rcv_nxt;
 				context->dev_add_pending = 1;
 			}
+			trace_tls_device_rekey_start(sk, copied_seq, rcv_nxt,
+						    before(copied_seq, rcv_nxt));
 		}
 	}
 
diff --git a/net/tls/trace.h b/net/tls/trace.h
index 2d8ce4ff3265..56fcf95c5aaf 100644
--- a/net/tls/trace.h
+++ b/net/tls/trace.h
@@ -192,6 +192,85 @@ TRACE_EVENT(tls_device_tx_resync_send,
 	)
 );
 
+TRACE_EVENT(tls_device_rekey_start,
+
+	TP_PROTO(struct sock *sk, u32 copied_seq, u32 nic_boundary,
+		 bool inflight),
+
+	TP_ARGS(sk, copied_seq, nic_boundary, inflight),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		copied_seq	)
+		__field(	u32,		nic_boundary	)
+		__field(	bool,		inflight	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->copied_seq = copied_seq;
+		__entry->nic_boundary = nic_boundary;
+		__entry->inflight = inflight;
+	),
+
+	TP_printk(
+		"sk=%p copied_seq=%u nic_boundary=%u inflight=%d",
+		__entry->sk, __entry->copied_seq, __entry->nic_boundary,
+		__entry->inflight
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_reencrypt,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary, bool retry),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary, retry),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+		__field(	bool,		retry		)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+		__entry->retry = retry;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u retry=%d",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary,
+		__entry->retry
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_done,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary
+	)
+);
+
 #endif /* _TLS_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1


