Return-Path: <netdev+bounces-288342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKPzDuk4B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:16:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5138552003
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85CA8300D34D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5A3CB2F6;
	Fri, 15 May 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="lmHwvnil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945563CC333
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858175; cv=none; b=SZyd4rUI6zdTpzWg3NQwcRoUaTTqLZIDQ+fRxDKuLlX4oKmbZlcxiWdsx7SACAE4N5+e7GW3hebfMbFrtnTTZUOtjnRy41MIHDn0HqnaYvOaU4HFAiliHwB4uHOwbzxboiN8nwJD+QFgZslF/7G0YRfMOD8ckqtRonwwye1M0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858175; c=relaxed/simple;
	bh=j/JtzMkIpgce34VYyGskUNs64HhUE6kYkeklt0ZtZig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToipGHqnR++vZEET0eT3yyFOE809Z1CByPFLAwrMu79LtWsnMK/4b9waciUxLGX7q0wTNnXGhA/duktwae7k73C6GnNGpQUVhKZDlBGGXgKC37WDX9uKQG/1rNKsdiBCXCEKpyRAMMxZrsL+UoD88tb1G2mtmytj+X+rnBi56MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=lmHwvnil; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651ce87d785so1210505d50.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1778858173; x=1779462973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3mh0bTathtWuR9OagZuWnPfTDRYwjb2Qrr+cXSGHw4=;
        b=lmHwvnillnbksuxlXpEmx99WxtLGBXT/ZMp5xaGoXhc03oWDSy6J/X5tdX/KM3lU9R
         jU4HmSi+41OqY69DDEag9pNmxvta3kQPrPO0IoMxv8orwF4Xj3keieOe71ciiqCPmsxZ
         /6ikV1FS2XyUCNeqGZJIGIKU7SuXayenwyy1xCxtkCBqj35IPvKESMExJUSUOULC/kU3
         /ao7+W1jaPDww47JjdewtJ8kQmr7q1r2a9qU2yCRJrx7Fo5GyZTFUlwmdgNnXeOqPGEm
         mCWwUryGdCe8IvEW3x7QTo1hGUbc45IkJjijxUgADM6Vhnt56ElUZXkygSxYdBNYytPu
         derw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858173; x=1779462973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3mh0bTathtWuR9OagZuWnPfTDRYwjb2Qrr+cXSGHw4=;
        b=FD0X4e5QqrUqGCcGq+mmrssGKebvLMzOu4bxoX5+V8UnYsLd8X6U7+/MK5ijzOyM+4
         GtjZzDvbvluwlqcf9YdYwUF7kwePUZenOEMtDA53SCOsS4wx1EUzRSMMrB3tCMcoZEDi
         svy7cHERyrH5q40TZm7LZsQ7TTh2X76ZUVMJ+EpN0OZSJjh0C5ujD9rAaanez2znHBrh
         NYAJ1juv+KFIky8FVPc7YQsTWuwQjQ/S+ZELhJPZKa/IpH6twCO1JYU6GLtb+LYvRToA
         cEVDElXJNKeUPRXVyyYWz4evt13S0n1vBxXUUSkkHxBgY00Y5kyL+kSqWnUertw6M7mZ
         JBaw==
X-Forwarded-Encrypted: i=1; AFNElJ9Rd4jwd3KpnC+agqpZHEctBHIgPJ0FM6rdk7bl3HH6ivL8zHrSvmxwXCpNfU+j34aQ/ZMK7f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjxvzqYqo6XE1iTnnvZ8xnHepN6nm3mZR+dVR2N9luy7fPwIP
	P4uEcXJbCXabzw3OhZ9igprSEDsuzI9mOXS/QIN+2NxyJwQjVM+XmWwXxj+HLLRfl5eJ
X-Gm-Gg: Acq92OEhmjha4OVk6zzxXYl7eTo2vqc+6SWCv/ZnjwhpOC3kfwJhMz+Y7SvPpOd9jiD
	QaHp6yrsTG/GChs2u/RsgTFBzcOHkcgD31Rl0kxzBmBYf5J+v+wI63a6cQ+avMdS3leC05RX9+D
	0RZlPmAHyBjvx7i/FfBHyayf59dtUyDlpoou84siTkBYFOBVLzaj4D7sqy1FHDJhrREQEFAMYit
	LJfk/dxf2yui7VzbK88QsudWi4LqSoQQhXu8fqE1XlUveuNuGMDRc8ad8llbiK7ips6YTkYpirn
	KCXtR39qa8ELaydsgyxqSz83/jMrSNPkZMdtYQ3cvVFl6nPArwMz5K6cssvm5p1Iumu5ygiRsr3
	RcMV2VHuSTOdIp4qpH6bsrj8FgAlnMhSeVj0aMyoE3UI/Qd+1p5Mgc6lSdRlPn/iurPzLcMIVbG
	OmgleiffUA+wpRYg3OL57m5q1q92k5fdqXmdoaArzZX/BoQIJEDcdE1qpo/v0g9ID1J906RLGDa
	dE3xBP7VwNrzPK6wcCQOyNFcg==
X-Received: by 2002:a53:ac9c:0:b0:653:1298:2757 with SMTP id 956f58d0204a3-65e227bbac6mr2466784d50.3.1778858172447;
        Fri, 15 May 2026 08:16:12 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm2724116d50.2.2026.05.15.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:16:11 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: tls: preserve split open record on async encrypt
Date: Fri, 15 May 2026 11:15:55 -0400
Message-ID: <20260515151556.189841-2-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515151556.189841-1-clusk@northecho.dev>
References: <20260515151556.189841-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5138552003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[northecho-dev.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-288342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clusk@northecho.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[northecho-dev.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the BPF sk_msg verdict sets apply_bytes smaller than the current
open record, tls_push_record() splits ctx->open_rec into the record
being encrypted and a remainder record. The synchronous path reattaches
the remainder to ctx->open_rec before continuing.

If the selected AEAD provider completes asynchronously,
tls_do_encryption() returns -EINPROGRESS after unhooking ctx->open_rec.
tls_push_record() currently returns immediately in that case, before
the split remainder is reattached. The remainder is no longer reachable
through ctx->open_rec or ctx->tx_list, which can silently drop
transmitted data and leak the unreachable tls_rec.

Keep the split remainder rooted even when encryption of the first record
is pending asynchronously, and continue the BPF verdict drain loop after
an async record has been queued. Re-rooting alone is insufficient: the
final split remainder can otherwise remain as ctx->open_rec until close,
where it is freed instead of transmitted.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---
 net/tls/tls_sw.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268..6d3df74dd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -840,16 +840,19 @@ static int tls_push_record(struct sock *sk, int flags,
 	rc = tls_do_encryption(sk, tls_ctx, ctx, req,
 			       msg_pl->sg.size + prot->tail_size, i);
 	if (rc < 0) {
-		if (rc != -EINPROGRESS) {
-			tls_err_abort(sk, -EBADMSG);
-			if (split) {
-				tls_ctx->pending_open_record_frags = true;
-				tls_merge_open_record(sk, rec, tmp, orig_end);
-			}
+		if (rc == -EINPROGRESS)
+			goto split_done;
+
+		tls_err_abort(sk, -EBADMSG);
+		if (split) {
+			tls_ctx->pending_open_record_frags = true;
+			tls_merge_open_record(sk, rec, tmp, orig_end);
 		}
 		ctx->async_capable = 1;
 		return rc;
-	} else if (split) {
+	}
+split_done:
+	if (split) {
 		msg_pl = &tmp->msg_plaintext;
 		msg_en = &tmp->msg_encrypted;
 		sk_msg_trim(sk, msg_en, msg_pl->sg.size + prot->overhead_size);
@@ -857,6 +860,11 @@ static int tls_push_record(struct sock *sk, int flags,
 		ctx->open_rec = tmp;
 	}
 
+	if (rc < 0) {
+		ctx->async_capable = 1;
+		return rc;
+	}
+
 	return tls_tx_records(sk, flags);
 }
 
@@ -871,6 +879,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	struct sock *sk_redir;
 	struct tls_rec *rec;
 	bool enospc, policy, redir_ingress;
+	bool async = false;
 	int err = 0, send;
 	u32 delta = 0;
 
@@ -920,6 +929,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	switch (psock->eval) {
 	case __SK_PASS:
 		err = tls_push_record(sk, flags, record_type);
+		if (err == -EINPROGRESS) {
+			async = true;
+			err = 0;
+		}
 		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
@@ -989,7 +1002,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	}
  out_err:
 	sk_psock_put(sk, psock);
-	return err;
+	return err ?: (async ? -EINPROGRESS : 0);
 }
 
 static int tls_sw_push_pending_record(struct sock *sk, int flags)
-- 
2.54.0


