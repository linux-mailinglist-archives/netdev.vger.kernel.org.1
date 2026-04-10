Return-Path: <netdev+bounces-277500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJtzHtM42WkjnggAu9opvQ
	(envelope-from <netdev+bounces-277500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:52:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D243DB372
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EB2B302CF8A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B633DEFE5;
	Fri, 10 Apr 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuFb5voC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B63230BE9
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843394; cv=none; b=HAB8AX3y2qnXxvjtV0zwsVpeA/rz2135KrPSp7PNqP8odWFHYaQQRutxAw5Ao/CkmPlyDVGNRpY9T3Me7XDg8DJO0+q71VlByWG76kfPPPi38psjRWnIAwU4SARNFvZKmJ+ywwb923vbqfPSsgxF0x8o5BgrBxG5+L0xCbICTj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843394; c=relaxed/simple;
	bh=rgUPj2SbMNuzUiJlniaJmJhZ4ApbJNHsomKCgXNlwvo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rh1WTunW27uSlGg2JwB4nWLydONm+4eYk9HR2W7OzFYEywr4Rt8V/6ClPa9At+hlA1lwSNjIORHn6tvnHH4lrcS8g51oColQSFU8xI4/IXRjkm7Y+y07DVCzs90EMHLMgURS714ABNh6XbI/dp/wDQ0mO3nuxxcZANQRrXli7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuFb5voC; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89cd03be011so51643116d6.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775843392; x=1776448192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qF/dIdXkJEiI+cDWNOIJMntWsKT2yKOgBQOOaMqdwWs=;
        b=kuFb5voCHJFcEZ5yJR3oifYSMbY+6xhW85tXuv9ru7NIvlkBh8HGZpyyHKE6FlS2U/
         kD4wa6mI53LFPYStpvuUFDo00msPrZj4RgrLjiFl2vkEEENaE9sUVsuvj4beGKPynjRO
         rLPfyoinaFAa5gUJMqNszLom5cIENIZo/HV+BiDmZ381r6Q53g8le8/4g6E717ew5JHg
         ifoUhVnqZ5PI109Ue32ACIYc5iatm/6fBR71XEJBfSiZZklqzf509Z2f6+HLrtDE+eFt
         fGEk47dBN35A3uZvQPozwa7GCcbNFaOSEquE6m651hkPfXyxsOcR6n3Cv6aeT8IFDxdp
         22NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775843392; x=1776448192;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qF/dIdXkJEiI+cDWNOIJMntWsKT2yKOgBQOOaMqdwWs=;
        b=HnwXI8uR+L3ZPk+shD2+x9hwCoBAH8JzzJ2dNEu7tX+SxG7cLNv9BWH3WQLKiyK/la
         joCtdiWUhRkNblKUeNZxfdSnwhg6ETJNbI7JVqW3vY0SV6J70Bg7Q3z0Bn7bO7WtTL5o
         duI8S+Ydhi9/TF+/7IkVRHrnBo3Dpdp9DH+5jEu01m33lAASmbmW39ndEzGBWb5Mi/8D
         VwsW65fig/i1COpsWras6m21rX2BafkhPN0aj1h0goTj0t045z6TUdFae9kXi7JyDoR3
         65MCjnPhtzwCUv7IeTJik0jQ8DOF0O9piBb9yEyx0z5EriwqFK68fr+9+gofe3QdwDaH
         k3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUzEjBg9i7JRry5tnLwTRUIYwFf0NNE5BhLapfRrQ4bK9t1VfbSD/JT4VYu7fdfa8kybdXJA7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiAUbqB69+Fx6m/hynydPtCfY+HPXSJLMxVibMIAXThQdG2xp
	ybYlbR6FNVQOqrr7TSWbbRJttTjF3ydUYnyss0np3vMqUDYUWMMGVLIkfj+Ht/I43Tz1NqRGE2Z
	UPle3m9tl0/citQ==
X-Received: from qtbob16.prod.google.com ([2002:a05:622a:7d90:b0:50b:68b1:a11])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d08:0:b0:50d:85c1:3616 with SMTP id d75a77b69052e-50dd5ba7225mr63554301cf.43.1775843391940;
 Fri, 10 Apr 2026 10:49:51 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:49:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410174950.745670-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add indirect call wrapper in tcp_conn_request()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277500-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 75D243DB372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Small improvement in SYN processing, to directly call
tcp_v6_init_seq_and_ts_off() or tcp_v4_init_seq_and_ts_off().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    | 6 ++++++
 net/ipv4/tcp_input.c | 5 ++++-
 net/ipv4/tcp_ipv4.c  | 2 +-
 net/ipv6/tcp_ipv6.c  | 2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6156d1d068e142f696ec9dfff63e3aaebb0171bc..8c3762a9d6fd4e23ed3e1af7fbc8404ad17b1923 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3085,4 +3085,10 @@ static inline int tcp_recv_should_stop(struct sock *sk)
 	       signal_pending(current);
 }
 
+INDIRECT_CALLABLE_DECLARE(union tcp_seq_and_ts_off
+			  tcp_v4_init_seq_and_ts_off(const struct net *net,
+						     const struct sk_buff *skb));
+INDIRECT_CALLABLE_DECLARE(union tcp_seq_and_ts_off
+			  tcp_v6_init_seq_and_ts_off(const struct net *net,
+						     const struct sk_buff *skb));
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7171442c3ed7ae62ec45c093cc58ad5a5c978ed9..021f745747c59d8b9e200c5954af7807a4d08866 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7658,7 +7658,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		goto drop_and_free;
 
 	if (tmp_opt.tstamp_ok || (!want_cookie && !isn))
-		st = af_ops->init_seq_and_ts_off(net, skb);
+		st = INDIRECT_CALL_INET(af_ops->init_seq_and_ts_off,
+					tcp_v6_init_seq_and_ts_off,
+					tcp_v4_init_seq_and_ts_off,
+					net, skb);
 
 	if (tmp_opt.tstamp_ok) {
 		tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 69ab236072e7142d5ca9d0703d99f02c1e17c738..9309294370a7ba256103813b6e1cb6b79b54cd44 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -105,7 +105,7 @@ static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) = {
 
 static DEFINE_MUTEX(tcp_exit_batch_mutex);
 
-static union tcp_seq_and_ts_off
+INDIRECT_CALLABLE_SCOPE union tcp_seq_and_ts_off
 tcp_v4_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
 {
 	return secure_tcp_seq_and_ts_off(net,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8dc3874e8b9252da60f21ad77a5ca834532e650a..4e39e8dd8e1e04d3771455fee65aecb88436a578 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -105,7 +105,7 @@ static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static union tcp_seq_and_ts_off
+INDIRECT_CALLABLE_SCOPE union tcp_seq_and_ts_off
 tcp_v6_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
 {
 	return secure_tcpv6_seq_and_ts_off(net,
-- 
2.53.0.1213.gd9a14994de-goog


