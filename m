Return-Path: <netdev+bounces-256588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKocNfbegmnfdgMAu9opvQ
	(envelope-from <netdev+bounces-256588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:53:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD34E221B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B47630976DE
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC789369979;
	Wed,  4 Feb 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR3uxsbt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85672364E81
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184316; cv=none; b=KSxDD+AI74m+0lfjgUvBvpyRxCTheOhceOlzClzZWesQ0bl1qRsXQDAFL/DPSBFQ6wcHsNXK77GRxDQRUTChH6PZgWwsi+sozrLAd9OOYbgJpOE0f76Qjg4ugm/3Mg1+p46ChAiOK8nmp0efWJsPVupEUKgMjbQAB6IrB0o9qLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184316; c=relaxed/simple;
	bh=TYocO0iWR8ddhnCV0zsSA6YVJros6WN5ONFPDaMZeg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D15XL1saaFcRhxH6qoxBNoN8Laaxe/u9NTw0TvK1wasfP8JQ4H6fO+c4vd1Tu6y8mCu44NTrblfEszQDrIrSnJYYvIjcTvQodOYnkHhFG7r6dZxDFBtWeK/G08yK7sVUkvY145elKtGPiEX+PNXx0Wo4r3SOH6RHIA/tY9nJ/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZR3uxsbt; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-894709fbae5so17451686d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770184315; x=1770789115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSGo5iNIcVr0PGkKrx31zzloJYeN7vq/RahMJPcWwQo=;
        b=ZR3uxsbtHj7vi6OzopvzvdhE2JBtTz3QjDaxoBxMxdU7HAh3yQ5yaytUek48M/ZTNs
         /BTHUNUAbxeLvsCC/UkCmJZ6hkU8fkp+u5DWBneSl9NzEl6zQk5QY0OVFdBE+yOLdLBN
         cDVX/jjRKy4ezXWobaTs9rN08pltPaEP6PqRP5x5siBV5GFA8ZbSzZkTj0QWRzSfriuA
         e/Q2tCEw3N+DcN/1OwLEBxnblbKrPrURoIDqbMtjwf0T+2tWb7X9S2k8A31VthCJ3eST
         nqCGLzuxhwtlZ4mYDRcg1mlAvWLuVekXrxm10ZqgjKPRc5eMOx8rwsaz2B27VBhxsbzZ
         DA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184315; x=1770789115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSGo5iNIcVr0PGkKrx31zzloJYeN7vq/RahMJPcWwQo=;
        b=lGj9XwO8/7FwXhWQi3miAYvR2WOZRJiQ3GOMw1eEQgy0VXCOzP4A95qVT1V2l3SB0b
         cOYKyFcm+d63ap8B0T6o63oOJH6k6ZUSEqATcxNesww0QsnmbN8Rj8ssLxyzeLJqHSyz
         n3uFdbeD/Z6ZF/rgpHVUfSQBLCNS8c4GsdSf/Y0HMgzfoYHustLGiPXPJyKLv152eoEO
         rWkyvZ9IXF55PHRRJaPlZRpJ2sw4b6qkmn4vTS5EEb0TKZuz2KIFybxiW5j7ePEnjd89
         f4z3nWYUjs9WwT6MpLyQm5V9lZpAri2z7LlKFWFmY9/DohifpH+8Cr34CqydvqYnK8Sh
         a+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmLoZHozvXHTYbLaRJMeYTz4uRpvJ7rbqdfX/smtVogi2xpabVpDdHdRVoAaX/ovNiYT49CTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZfBHHVefhwpjld0kSWFfNg1oen38AyV3l14mjBnUq47TfdmZ
	unxMXdP9vb9T7Tv64qXAmfaecGAfeew4CcqtrancJr2UDSoYuNdUtmRbBelySroPidr7ByT/Rm7
	hDh7/4P2iwQBOVA==
X-Received: from qva10.prod.google.com ([2002:a05:6214:800a:b0:894:4b2f:fa75])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:495:b0:895:1cbb:5d53 with SMTP id 6a1803df08f44-89522189114mr24960076d6.40.1770184315525;
 Tue, 03 Feb 2026 21:51:55 -0800 (PST)
Date: Wed,  4 Feb 2026 05:51:47 +0000
In-Reply-To: <20260204055147.1682705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260204055147.1682705-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204055147.1682705-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] tcp: move __reqsk_free() out of line
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256588-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 4FD34E221B
X-Rspamd-Action: no action

Inlining __reqsk_free() is overkill, let's reclaim 2 Kbytes of text.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 2/4 grow/shrink: 2/14 up/down: 225/-2338 (-2113)
Function                                     old     new   delta
__reqsk_free                                   -     114    +114
sock_edemux                                   18      82     +64
inet_csk_listen_start                        233     264     +31
__pfx___reqsk_free                             -      16     +16
__pfx_reqsk_queue_alloc                       16       -     -16
__pfx_reqsk_free                              16       -     -16
reqsk_queue_alloc                             46       -     -46
tcp_req_err                                  272     177     -95
reqsk_fastopen_remove                        348     253     -95
cookie_bpf_check                             157      62     -95
cookie_tcp_reqsk_alloc                       387     290     -97
cookie_v4_check                             1568    1465    -103
reqsk_free                                   105       -    -105
cookie_v6_check                             1519    1412    -107
sock_gen_put                                 187      78    -109
sock_pfree                                   212      82    -130
tcp_try_fastopen                            1818    1683    -135
tcp_v4_rcv                                  3478    3294    -184
reqsk_put                                    306      90    -216
tcp_get_cookie_sock                          551     318    -233
tcp_v6_rcv                                  3404    3141    -263
tcp_conn_request                            2677    2384    -293
Total: Before=24887415, After=24885302, chg -0.01%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: use EXPORT_SYMBOL_GPL() instead of EXPORT_IPV6_MOD_GPL for
    __reqsk_free (Kuniyuki)

 include/net/request_sock.h      |  9 +--------
 net/ipv4/inet_connection_sock.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 23bb909771fbacbbd31f614b1754f0c24e602645..5a9c826a7092ddfdbe5a6450a1b01677cb7e670b 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -123,14 +123,7 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 	return sk;
 }
 
-static inline void __reqsk_free(struct request_sock *req)
-{
-	req->rsk_ops->destructor(req);
-	if (req->rsk_listener)
-		sock_put(req->rsk_listener);
-	kfree(req->saved_syn);
-	kmem_cache_free(req->rsk_ops->slab, req);
-}
+void __reqsk_free(struct request_sock *req);
 
 static inline void reqsk_free(struct request_sock *req)
 {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 60f2ee039c05f46bdb95f6211a8f9eafbedb9610..5dfac6ce1110b3276fa8aaa02440c774c6a58176 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -919,6 +919,16 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 }
 EXPORT_SYMBOL(inet_reqsk_alloc);
 
+void __reqsk_free(struct request_sock *req)
+{
+	req->rsk_ops->destructor(req);
+	if (req->rsk_listener)
+		sock_put(req->rsk_listener);
+	kfree(req->saved_syn);
+	kmem_cache_free(req->rsk_ops->slab, req);
+}
+EXPORT_SYMBOL_GPL(__reqsk_free);
+
 static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 					     struct sock *sk)
 {
-- 
2.53.0.rc2.204.g2597b5adb4-goog


