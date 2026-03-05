Return-Path: <netdev+bounces-264342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEMKItNtqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:49:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38B210D97
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6686930427D1
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F62C11E2;
	Thu,  5 Mar 2026 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqxErU2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162A3947AB
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711318; cv=none; b=lcTaAbE5HyU5sp9lHSL8efI9Z2A6kFMaR+davP7Is8/71yZ8C+H5ouqoMILIuXXoxvgv7pM2QjiSFrFhuae+mqfY6DbHuHQxs9xvhg/RSolOhYErPuPMIKf+XxPOM8Tb7VVkcysSWQPN0JsNGNlNPV76UER8Ny/QJoghabIlBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711318; c=relaxed/simple;
	bh=OEN1YbMsflmAm8UcI2IiSisc6hpe7q+tRprstAsyxa8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MZ6T5Lbn7Wo/JsZhoNd1mSTikUS/VbbqX24UTJgwtqT7V0+sBwqUGaVSkAOHNMZC1tQCebNsiu1rTp8NkAhXtk1saNo5YYlNFyxzH+C5YAHuiHyI03iUSW3gkkCpWInm2iPT024yw+EkmTsPVOIc7O7W7QMGmRncwV68uQfR/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqxErU2C; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506a1999e44so700920761cf.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772711316; x=1773316116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eZ6kavmCvcAIpqq/W1lV/5ixK47/Dwrv0w1o/tG1/ec=;
        b=HqxErU2CBCaUm+U2FXAshe8ql3O6xAUyDWLQD7oeBML6eGFZp77T3ih4Bnk7UJCMWy
         R9/dmjmLxYEJ11p/r0LNf8BYS/zC60rn0icSR3Nzzrvt4SOx96g6o7qOj+HHmxkv+j4G
         HF2UqICGCVJjS0WkyTvuegmdZDetZQiPYrNABw5Bfxk+E8bHAjwlL9CUO0sxODHXdJkx
         rd3KLUrWRfS9XnAAwHmli3OGcvIV7Vp5C5roK8L6nhDq0KenHL0lg9EwKPIQusdpFIXU
         oKY6XZMSeMxbFWVY7beVbO6waH2mWzt1/2Q+IXthPj8zRLGkr33TZmMpROjuYzmeEjV4
         xw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711316; x=1773316116;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZ6kavmCvcAIpqq/W1lV/5ixK47/Dwrv0w1o/tG1/ec=;
        b=bgsmFymDEqx/1dlwjJAl5jtoMJ+dEVF0ytDezFZhhTkRDBjTQw1/PR0u2XQzsq8UAX
         TaMwh9/wkLJ4JnPIFMH7VJ3gayAfH1X6i47XmTpmdD0Q7pA3wZMx4sENrP0/ig7y9Tv1
         YqV9LmrYSj0YaGuSDzHDRRDhKV2QwodnueFgeH2GcTmMh5RNB5e+OLk1QInrYCJt/ygy
         Bk91G73L4smvPodS3DvXC/wt15DwLFCTL/2FSVtI2S0Nd9JDjastiZ6lwamaAWCSAPV3
         7LOeomK1pTXtZRgaNp8P/ZFA72cV8yJBtZFismNsDTuRUKyRGtyibGE3aZKp1ZwqKVuF
         vzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9GhhWxDF7p/9SacOGpl5TDrg65izkHsdbogXOe2POgUKSJpvn6CHfOMqsd0kBxL3afbvvJb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTRTO4TMhN4Pn4hVcwL2C1JAu3Rk35tSulPWqaXyDk/H2s61F
	SwBlethzo3W/USXxhj/jTzH/D30Pt/kRakc7XTeQ65Q4tJGhEC96b+FUzMO893XDZXh6NCnF6rL
	62tktfOVaEf+0KQ==
X-Received: from qtbku23.prod.google.com ([2002:a05:622a:a97:b0:506:b5cb:4b69])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1ba5:b0:506:be2c:a96a with SMTP id d75a77b69052e-508db2cd281mr64220771cf.17.1772711315651;
 Thu, 05 Mar 2026 03:48:35 -0800 (PST)
Date: Thu,  5 Mar 2026 11:48:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305114829.2163276-1-edumazet@google.com>
Subject: [PATCH v2 net-next] inet_diag: report delayed ack timer information
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2F38B210D97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264342-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

inet_sk_diag_fill() populates r->idiag_timer with the following
precedence order:

1 - Retransmit timer.
4 - Probe0 timer.
2 - Keepalive timer.

This patch adds a new value, last in the list, if other timers
are not active.

5 - Delayed ACK timer.

A corresponding iproute2 patch will follow to replace "unknown"
with "delack":

ESTAB 10     0   [2002:a05:6830:1f86::]:12875 [2002:a05:6830:1f85::]:50438

    timer:(unknown,003ms,0) ino:152178 sk:3004 cgroup:unreachable:189 <->

    skmem:(r1344,rb12780520,t0,tb262144,f2752,w0,o250,bl0,d0) ts usec_ts
    ...

Also add the following enum in uapi/linux/inet_diag.h
as suggested by David Ahern.

enum {
	IDIAG_TIMER_OFF,
	IDIAG_TIMER_ON,
	IDIAG_TIMER_KEEPALIVE,
	IDIAG_TIMER_TIMEWAIT,
	IDIAG_TIMER_PROBE0,
	IDIAG_TIMER_DELACK,
};

Neal Cardwell suggested to test for ICSK_ACK_TIMER:
inet_csk_clear_xmit_timer() does not call sk_stop_timer()
because INET_CSK_CLEAR_TIMERS is unset.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/uapi/linux/inet_diag.h |  9 +++++++++
 net/ipv4/inet_diag.c           | 13 +++++++++----
 net/ipv4/tcp_diag.c            |  4 ++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index 86bb2e8b17c9f197fd49cf7996d5e4f555a9b8e8..21f0d735fbae206cf2e1e573912a324bb2eb64d9 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -129,6 +129,15 @@ struct inet_diag_msg {
 	__u32	idiag_inode;
 };
 
+enum {
+	IDIAG_TIMER_OFF,
+	IDIAG_TIMER_ON,
+	IDIAG_TIMER_KEEPALIVE,
+	IDIAG_TIMER_TIMEWAIT,
+	IDIAG_TIMER_PROBE0,
+	IDIAG_TIMER_DELACK,
+};
+
 /* Extensions */
 
 enum {
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 9d215485b5c7e7ba29dd53c924f0245439d74af5..34b77aa87d0a48bcbceb7f2935a210a347812cc6 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -241,7 +241,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 
 	inet_diag_msg_common_fill(r, sk);
 	r->idiag_state = sk->sk_state;
-	r->idiag_timer = 0;
+	r->idiag_timer = IDIAG_TIMER_OFF;
 	r->idiag_retrans = 0;
 	r->idiag_expires = 0;
 
@@ -284,20 +284,25 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 	if (icsk_pending == ICSK_TIME_RETRANS ||
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
-		r->idiag_timer = 1;
+		r->idiag_timer = IDIAG_TIMER_ON;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_retransmits);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(tcp_timeout_expires(sk) - jiffies);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
-		r->idiag_timer = 4;
+		r->idiag_timer = IDIAG_TIMER_PROBE0;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(tcp_timeout_expires(sk) - jiffies);
 	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
-		r->idiag_timer = 2;
+		r->idiag_timer = IDIAG_TIMER_KEEPALIVE;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
+	} else if ((READ_ONCE(icsk->icsk_ack.pending) & ICSK_ACK_TIMER) &&
+		   timer_pending(&icsk->icsk_delack_timer)) {
+		r->idiag_timer = IDIAG_TIMER_DELACK;
+		r->idiag_expires =
+			jiffies_delta_to_msecs(icsk_delack_timeout(icsk) - jiffies);
 	}
 
 	if ((ext & (1 << (INET_DIAG_INFO - 1))) && handler->idiag_info_size) {
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index d83efd91f461c8ad0157faeebae051b32cb07bf4..4a316387414adaeb350b8d46ac0248833c3d111d 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -212,7 +212,7 @@ static int tcp_twsk_diag_fill(struct sock *sk,
 	r->idiag_retrans      = 0;
 
 	r->idiag_state	      = READ_ONCE(tw->tw_substate);
-	r->idiag_timer	      = 3;
+	r->idiag_timer	      = IDIAG_TIMER_TIMEWAIT;
 	tmo = tw->tw_timer.expires - jiffies;
 	r->idiag_expires      = jiffies_delta_to_msecs(tmo);
 	r->idiag_rqueue	      = 0;
@@ -247,7 +247,7 @@ static int tcp_req_diag_fill(struct sock *sk, struct sk_buff *skb,
 	r = nlmsg_data(nlh);
 	inet_diag_msg_common_fill(r, sk);
 	r->idiag_state = TCP_SYN_RECV;
-	r->idiag_timer = 1;
+	r->idiag_timer = IDIAG_TIMER_ON;
 	r->idiag_retrans = READ_ONCE(reqsk->num_retrans);
 
 	BUILD_BUG_ON(offsetof(struct inet_request_sock, ir_cookie) !=
-- 
2.53.0.473.g4a7958ca14-goog


