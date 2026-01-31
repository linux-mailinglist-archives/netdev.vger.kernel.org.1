Return-Path: <netdev+bounces-255467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOdMDvw4fmn7WQIAu9opvQ
	(envelope-from <netdev+bounces-255467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:16:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B3C326F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F83530382AD
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E949347BBB;
	Sat, 31 Jan 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvQami6F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91918345CD9
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879791; cv=none; b=FoSOep0yRuZSt6llFvsuMkXFX/2qblXRLyncjkkgRbYWaApg7urmeXJAKOmXdvfOejoqLCe15wyRsBJtaeis8kSfQl3JZotZuZ+eALZh3z0hhX80/9IJeGxN3pDW9y8fp7lbuRH7adCiP5bJLphPBy//f/XpA6M9HBnVc04LvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879791; c=relaxed/simple;
	bh=yHopSMXDBMMcoBjx9jbnywnCG20y2n2IGcs3V4FIwzk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IQVQhBbdphIywxFAbHFCByeovTTya5kUl60gOnGmurAIbYsL+o3DrAboyr1K3ZpRSHUg/yIsS319qy9+2Y/HsSPXshONAQn4OC6qYxfk2D0PjTSkT6EzEHvmA4GepL05Ps75ubKvBvvciL2frwQYlxsY6qg7E4aLDDfY+7VORDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvQami6F; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-89473f5a755so106278096d6.0
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769879788; x=1770484588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J6YEsEshXwESZt3m5/fo9MO3bsnz5IVpBfwyJCOBE0Q=;
        b=YvQami6FecdA6WKyox0EJXuiIyz/vhQgZFf0RWB7ZXOhWwvVxiuQKRBsvOq2WgGNTr
         ZnmSvElBWCTVNslUz8tjKC7Vn1m8VrcUCAAxqJoDBQWLTe0tK2Tr+b1MclTo6ZiBRXjw
         +/ObgdwqM1cpt3vmoYsi0/ZCAqLO8USGhoa2OBUG8I7bKRE6kxj1Xo1VZ4MnpM37xqFP
         QAuVVWXvEBCVwQjjbNgtCOD3KX73e9KjeTG40WLYaPu/fGLYugLubkVSdKKP4dNSFPxw
         Qo5g56AFeUwe5Qnc2zqwCGUP2SWLz6sgwBi5exybkYfNJEAYl6HololQXOAWHn1s6Kxi
         9GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769879788; x=1770484588;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6YEsEshXwESZt3m5/fo9MO3bsnz5IVpBfwyJCOBE0Q=;
        b=RIQ2LzgYP9jtDQmIpzZnIdT5JEK8rPic9hZXWrnUSSmchSZ2z7Ue1ykXU+b3r/rPdl
         uANtLwGWMDPGNZCpAeIDlws3rbuqHC++rDNXHkfs7cFpxr5FdeMdDuYiTgmTEtQetvUM
         t0bIU+dEIN1kwlD7QSFrt+tA0q+wN6EZjoUXVXcjneMVsIhsODhgwfqf6uOe59JRU+5a
         RcG/Gh8MNHMBGwmXjPMKQISUz4VfAmCdBvxAuQuB5GXhnSpRp6MAkMViZurhe7MFKA9+
         D9P6HJ08S/1pqHsGApKDdSCTg5W6M2iBHo00TowFboNNxaCHuTTqOC2/xuSPOKlEI4BK
         lyPw==
X-Forwarded-Encrypted: i=1; AJvYcCWvVmZ5iccG3dNkstSFd9LTYdWbNd2/pVMlCtKJt/eGBWEsPJWlv7WON1dCfgxr3tV4ftYovEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDRy9Mw8ns8mKqw1+z7mF96wCvQ4TpMxcAZwMb4p7rl7pFJLM
	xZrVHKItirxumaHBw5uPRCXGY3MHP9URd2JwZlcU+WT9NylhT1//noFxeJIerTu0lG+nc6iI2o4
	rc0JZ3cA0iGiWfA==
X-Received: from qvbkd26.prod.google.com ([2002:a05:6214:401a:b0:888:db8:f98c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1306:b0:894:7051:bdaa with SMTP id 6a1803df08f44-894e9f7110amr81679656d6.21.1769879788620;
 Sat, 31 Jan 2026 09:16:28 -0800 (PST)
Date: Sat, 31 Jan 2026 17:16:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131171627.1852894-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move __reqsk_free() out of line
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255467-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C9B3C326F
X-Rspamd-Action: no action

Inlining __reqsk_free() is overkill, let's reclaim 2 Kbytes of text.

scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 2/2 grow/shrink: 1/14 up/down: 194/-2276 (-2082)
Function                                     old     new   delta
__reqsk_free                                   -     114    +114
sock_edemux                                   18      82     +64
__pfx___reqsk_free                             -      16     +16
__pfx_reqsk_free                              16       -     -16
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
Total: Before=22582599, After=22580517, chg -0.01%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h      |  9 +--------
 net/ipv4/inet_connection_sock.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 9b9e04f6bb8931088d9bb2fa7d4420fecf235895..0cd5a400e5265d8aa1b2452967b4007521c2eee8 100644
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
index 13372d2cbed53e83510e24a34bc57c7de0a17004..c048a36f26b130dd167e0594d190bcc3bb49e635 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -918,6 +918,16 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
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
+EXPORT_IPV6_MOD_GPL(__reqsk_free);
+
 static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 					     struct sock *sk)
 {
-- 
2.53.0.rc1.225.gd81095ad13-goog


