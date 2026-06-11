Return-Path: <netdev+bounces-298069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sPthMS2NKmr8sAMAu9opvQ
	(envelope-from <netdev+bounces-298069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:25:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44E670D59
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:25:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="c bAR4Kh";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=VZ+DjKQI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298069-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298069-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D1233AE949
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB23C9881;
	Thu, 11 Jun 2026 10:21:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211233C8738
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:21:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173312; cv=none; b=b3dLEtHuf63+keheB2dvx0VDzvXdD+/7RWNU8j2gBqFM1w22uBIsHpIog88Ngrzl2Fklk7eJ9TOQaI5AzQAqBV0Pdzdw7BO3jelE493gQZmJ2ytEDFCJxqmzJRkp4cAZzzhBDosWbforVzVbCOdG0u6MPSohjIyX9iozxKwqgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173312; c=relaxed/simple;
	bh=GEknocA44VLGQCFPldwKa4wrHw80zUgaD0NJ61aYPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWsXKYxPpLst+y+pObxtWl84EBZHDjH/SPwGOvNYmW8djycBuk90R+YBxkmZhsZ5sVuR2rdanTlH+RCm4Amq6m9ZFR7OvcBNPY3/Jfvr//zlFSjMxDXuYBWhR259Fr/A3vxybba9Fq5d+SL5Ay6YZEK538+Ak1JO4P7IXutFZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cbAR4Khg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZ+DjKQI; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68B3F1400078;
	Thu, 11 Jun 2026 06:21:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 06:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781173305; x=
	1781259705; bh=dCDxGNVkpPoA3MaDM+5aH3tDaTjS+nHMUgKfHXARb44=; b=c
	bAR4KhgCS5Z31AXekB9zMqM30R3W2Vf57kuwKdeisGgsoWiQ8Z80HDLnQSV9/1lk
	QANnmeD3QvUrzb/Tcr2F6Wxp6hZKz19CUzyf6UlsW2Nu6P8zaHwJFuy5D7iWU3RG
	PGhg21K65uxfZWDmn+1MXcDSQbKRqfvnfjWWXKRzLDtpoQRJmu6wASOqa53QxHV4
	cNiDv52sv1aTLQMDytdtrhREK+IS4oTA5Fb8rD8+wQ5qMNMc7lAlLGgqV0Zi6L+y
	BP7aCQdEgvfyg9Dmu24ch5+BJmdp7o4IMjMEVTjXPJJsZAvMLQR681deb4lynuKr
	zqDBlTqLDgXnjhDaIPY+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781173305; x=1781259705; bh=d
	CDxGNVkpPoA3MaDM+5aH3tDaTjS+nHMUgKfHXARb44=; b=VZ+DjKQIWHkSmSO0u
	lqOx2o8ZxvkgHNyKJgaHl9ARcCgS/hGnNzzq9hjEH7ltyOYWtbg6c5i/fne9JTm+
	BGtopZzQQ5+FRcLg/MoRlKDxzQWAU21ILJJrW3LfAgb69zTv7pQ9HY/zITYRFPX6
	X6B8Q4ZWGQ7Nv7iCVCYEyniwkRkXzMIqkQZTa5+ZoiosnFDxRU9VVRHGPkscT+5D
	1b7F/EjsFF1soYuVfkTd9kaxVFnmwxvthg4BbipYaXl281eE/e/Ua+088IYtaAXV
	+Ywb/QKnvxFSZKG63vDoqCIExeJxCdLWyBoQiCNCyZ6sqpJj8JkGv333StgBqtq7
	b9Piw==
X-ME-Sender: <xms:OYwqav7khr-eEVchkPYiI9I3nkkqWAXrFOqNYzXW8bJNjesHMfg00A>
    <xme:OYwqahyJcaOqRV_BS4qu81k0fS_l0P-pfB5nLPFOlK9Ha7aQwWN-Na82A4kDRryKc
    Ub1mseGqNuo7_hajKrkm84_kMtt60F5NuyGIECNJ1iFBW3j7F8WBtQ>
X-ME-Received: <xmr:OYwqamM-41OW17zKp4_T3y1shaLTyBgP3ITA55_P1MgoZ-4yLtcUo6T2fvpr-jHxS-qh6kJhnFTnuCB_MybydTc>
X-ME-Proxy-Cause: dmFkZTEgorHcMf1bypi5cEQWvdm/gp0IQA6k2zzA7lYu3ui+5yLfiH5ASqEFUwQfjNe0xm
    IjhhaP/JRyanosfXnYhzDHZNvVHwbzXSbev4/1gktnHHiGZ54z5CVoFGwQ9e94XiY+KLCn
    yvkPLswpQxNc1IC0DMiNSZ55OoxpIoDkyPHBj42uFSTc847Q9AAnX7h4EUMlQrnJlDDGRz
    +7uJ9mvHlB6oJj57/++NeeoFQ75Ih6sWTaN63Xp9y8P636UFnx6Z9KVpU5wZi+8YBQDxO+
    tH1/75+0zlpwL9Twd9sYT3Q0acj21Yk9kywCdXSTqTueAiy9XuowvuYqTyoDordPRM2fmy
    nwpPMpFLVCpM9jNDvKxPt8d2YPQsARyUSFTjaLno6ua35NS8zogCApyCqvcz6b5BIqdP7Q
    nQdxo/qRgrOWSMKy/w12J5wTj8jFUaI5gImedVCfCX7gCFegEz6aUvQNlN6J3Y8CMlVc8o
    2C6uvaGUKZWBtYLuUbcvqRzIzXN7dAYH16ds18nIYhKQp4Gdtnme8ax0vHNiZ0rpw5+T3i
    qbqrpby90cFRIeFvs4e8JU8TLs3kFdV/Oh+Qu9fmlyFfEykS6+MlAPbsUbkqyVEsRvg9ev
    jwLxwWrw3L9o506pFXadKI0i0VEMyCkzdelGrBQBC+Qg2yMzykusfTYOGN7w
X-ME-Proxy: <xmx:OYwqavmxksD0TBQS7APcOXb7mmz52ZdY4_ZCga8WaXibFRxVgBl4cA>
    <xmx:OYwqajQzidtebevA4uAkf9AMDiSIZfjx7sYqNjKPvZ7UySGoIA5uZQ>
    <xmx:OYwqamWBYtJ1lfuQYOofyr2ovNnWjTf2jubPYPxBeJ_dYr6Lgo4iKA>
    <xmx:OYwqavK8GWv6fFvZAo_Ke3A-uLB7Fp39N51IifEVWiMHrRAZMycWFA>
    <xmx:OYwqakKs-yUOZebSGTIgfdFYVbhqI5TsIqeTeWQZCsANs514BNwkkoXo>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 06:21:44 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net-next v2 2/2] net: remove some unused EXPORT_SYMBOL()s
Date: Thu, 11 Jun 2026 12:21:34 +0200
Message-ID: <d124db74f6f0838b652f0ee4b4530964f3cf8d49.1781165969.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781165969.git.sd@queasysnail.net>
References: <cover.1781165969.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-298069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[queasysnail.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,queasysnail.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C44E670D59

chtls was using a lot of symbols that no other module requires. Remove
those EXPORT_SYMBOL()s.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/stream.c               | 1 -
 net/ipv4/inet_connection_sock.c | 6 ------
 net/ipv4/inet_hashtables.c      | 2 --
 net/ipv4/tcp.c                  | 4 ----
 net/ipv4/tcp_ipv4.c             | 1 -
 net/ipv4/tcp_minisocks.c        | 2 --
 6 files changed, 16 deletions(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index 7a37e7dd2c43..2d748581862d 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -112,7 +112,6 @@ void sk_stream_wait_close(struct sock *sk, long timeout)
 		remove_wait_queue(sk_sleep(sk), &wait);
 	}
 }
-EXPORT_SYMBOL(sk_stream_wait_close);
 
 /**
  * sk_stream_wait_memory - Wait for more memory for a socket
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5b934ce8d98a..18b567288158 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -824,7 +824,6 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 	__IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(inet_csk_route_child_sock);
 
 /* Decide when to expire the request and when to resend SYN-ACK */
 static void syn_ack_recalc(struct request_sock *req,
@@ -901,7 +900,6 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 
 	return req;
 }
-EXPORT_SYMBOL(inet_reqsk_alloc);
 
 void __reqsk_free(struct request_sock *req)
 {
@@ -911,7 +909,6 @@ void __reqsk_free(struct request_sock *req)
 	kfree(req->saved_syn);
 	kmem_cache_free(req->rsk_ops->slab, req);
 }
-EXPORT_SYMBOL_GPL(__reqsk_free);
 
 static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 					     struct sock *sk)
@@ -1280,7 +1277,6 @@ void inet_csk_destroy_sock(struct sock *sk)
 
 	sock_put(sk);
 }
-EXPORT_SYMBOL(inet_csk_destroy_sock);
 
 void inet_csk_prepare_for_destroy_sock(struct sock *sk)
 {
@@ -1301,7 +1297,6 @@ void inet_csk_prepare_forced_close(struct sock *sk)
 	inet_csk_prepare_for_destroy_sock(sk);
 	inet_sk(sk)->inet_num = 0;
 }
-EXPORT_SYMBOL(inet_csk_prepare_forced_close);
 
 static int inet_ulp_can_listen(const struct sock *sk)
 {
@@ -1405,7 +1400,6 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 	spin_unlock(&queue->rskq_lock);
 	return child;
 }
-EXPORT_SYMBOL(inet_csk_reqsk_queue_add);
 
 struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 					 struct request_sock *req, bool own_req)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 3e795547b40c..ba0faa9ae2bb 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -252,7 +252,6 @@ void inet_put_port(struct sock *sk)
 	__inet_put_port(sk);
 	local_bh_enable();
 }
-EXPORT_SYMBOL(inet_put_port);
 
 int __inet_inherit_port(const struct sock *sk, struct sock *child)
 {
@@ -331,7 +330,6 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 	spin_unlock(&head->lock);
 	return -ENOMEM;
 }
-EXPORT_SYMBOL_GPL(__inet_inherit_port);
 
 static struct inet_listen_hashbucket *
 inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 890182a151e1..455441f1b694 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -297,7 +297,6 @@ enum {
 };
 
 DEFINE_PER_CPU(unsigned int, tcp_orphan_count);
-EXPORT_PER_CPU_SYMBOL_GPL(tcp_orphan_count);
 
 long sysctl_tcp_mem[3] __read_mostly;
 
@@ -3027,7 +3026,6 @@ void tcp_set_state(struct sock *sk, int state)
 	 */
 	inet_sk_state_store(sk, state);
 }
-EXPORT_SYMBOL_GPL(tcp_set_state);
 
 /*
  *	State processing on a close. This implements the state shift for
@@ -3506,7 +3504,6 @@ int tcp_disconnect(struct sock *sk, int flags)
 	sk_error_report(sk);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_disconnect);
 
 static inline bool tcp_can_repair_sock(const struct sock *sk)
 {
@@ -5104,7 +5101,6 @@ void tcp_done(struct sock *sk)
 	else
 		inet_csk_destroy_sock(sk);
 }
-EXPORT_SYMBOL_GPL(tcp_done);
 
 int tcp_abort(struct sock *sk, int err)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fdc81150ff6c..ec09f97cc9e6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1894,7 +1894,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 }
-EXPORT_SYMBOL(tcp_v4_do_rcv);
 
 enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e6092c3ac840..ddc4b17a826b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -392,7 +392,6 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 	tcp_update_metrics(sk);
 	tcp_done(sk);
 }
-EXPORT_SYMBOL(tcp_time_wait);
 
 void tcp_twsk_destructor(struct sock *sk)
 {
@@ -670,7 +669,6 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	return newsk;
 }
-EXPORT_SYMBOL(tcp_create_openreq_child);
 
 /*
  * Process an incoming packet for SYN_RECV sockets represented as a
-- 
2.54.0


