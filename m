Return-Path: <netdev+bounces-306787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kSIqKsgLUmoZLgMAu9opvQ
	(envelope-from <netdev+bounces-306787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:24:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D467410B5
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:24:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JggGDIeZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306787-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306787-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45358302F702
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4533388868;
	Sat, 11 Jul 2026 09:22:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E373859E6
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761765; cv=none; b=OitstBUdKVrR4cRplgJ+uf5H1YhdWVwyvcVsatI+RRWKRkIn1IlxiyRrNxh7bbfIOD4XnlATnIuQiMOIDvGq+fb4gGNio+MnlxIfK3be/G2DwGd874fPphglvfbV1hBCGnJkq/uOKw9kEhzUYEGE4JNhqAO37m4Ct0BC0PgMWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761765; c=relaxed/simple;
	bh=d/05l7thhA7v4kdOPvMOhBc5uyfO23xiLBqmqmtQuWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr9ZAc/HQUDdiftnr1GBgvbbTpZAIQzSDvRAP0YyT8a/uaswa6Wrrf6o3CB6cE8I3rCrGONmes0R7IYA3i71q0jfppsW2vr1hYuW/lArCrTro1jJrkNvQYFKBeoKV1yoAKmvJpKBwAVmreQg7Uc7vDTuvfjkUULE37+oFGMObq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JggGDIeZ; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c160420289bso187017766b.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761763; x=1784366563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ee81QMzMnMBleRcpGN+zxaM1CeeUL+H5Cdvj06WMGpc=;
        b=JggGDIeZuj6R+wPk896LTWqRYKiYKuN0RfrJ8yB7noU25+PfmnLx+0/qDK7hMoB0Ss
         BDGcVtQOm95WQSxH7mZXhUS6iwXa5bkSEc++P262oHZ/k9k1xnHYPc/EUzc9vocE6FE5
         lRb+kCwO80YRp93FSfPhSQyHCf4uFH55G5dhPyJBWrkSda0bGeCjaI1/CNb1iofXh9k4
         mICkSupXBGeHLMkpbPysecJTm1Hea7u2hX5GL+U7qD+xVlm4xysdoBTN/NvrchBf5Cn8
         X0ViCwPWvoA9MfDG6ZJb7vGTfNPX5DTrz3h6UXgzZBk/Uxs/ehrs4IwxVc1OcGyEKQfu
         6Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761763; x=1784366563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ee81QMzMnMBleRcpGN+zxaM1CeeUL+H5Cdvj06WMGpc=;
        b=RE7SYQseSEag6DRYE1EVhpAuK2RJ1r6ahYkMD5r7k+qdctN2LNaFaW35cxWCYRm0Xq
         nveufNqbpjhCaRS2pUYeXg1BFFmXY0Kt5COFweAwwVg4iI4XQaT14S243CZ/HI2gRN/H
         Ns9eOXS5OdcAC8pI84BWifeXbM3JR7bNBW71+P9fNu3hR4Xm38aoHgFDxLdnhae7nkwG
         CBS3wGh0CNxlPE5F8jm773l8d76gu3mRKpu9eCWqGk5B7msRxioD+kJYX7eJtlIh3Fs1
         bG/LQ1LTjIxfyoK1rcPZVBQ0NgZxGuDp422Dyh3tjQjM3JNjdpEs0d8UxTcQNKi31/wf
         ydJA==
X-Forwarded-Encrypted: i=1; AHgh+RrmmBDDOQ6ae8p63mZ+0Ff63/erHh2Lh9E/10rugoEtfVVYfO2Dh06uZb5jCJG8zfFd2+9E3p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKG3ALRBmwQw4DeMIO9H8i1dewujGSNUHasLFFJP2E1rcgYVGn
	Q6mEtqp9QepCQwwjTd9gVfkWq/ObcYQaw7VYRm2S9XXOk1Rk8SPQuU/V
X-Gm-Gg: AfdE7cnb40GgF4aq69tOYdV1zf7/cX1YRoASVmZpQ9OQ8l4AYWWFKm9l2rCiABm10QQ
	30V+ObW2aEQqWAM8BeoNBeOYcY3/46ECmxrVdH2uf7OU/uFy7Yvedzpux5Ekvdq6SGwLVMjglq1
	xN9XwusAJ8OBMVteWLE+KdVvXFl+I+Emll5bhoxr3ZlfJA+1qqYT9VNGdeE6lEriWpQ2F4dCL6q
	B7RY6jCdPFEcBoebhBI1FtvUr0L6NyK39TjJfprgnVznpyXkwxjjyKZg6waSiWdLlXjplXsy0Wm
	AGVFz/yunmSPxiwcOgghuQnre1oNMd5GVO0qDUEjvaA7mR7NfzF5eaFoyumDeHS8rw+7AQEbUX9
	gt22HdAhV+WSOOAepkLlioXhC0Xj1vq78dDXaBDpNfkkP77J/XET5cKuKXua80fg8iscKEt4052
	oU2QESipr9CvF5HNqyKLlaWRE3gR5nmyBHMDfWbDbKEUxZ6kWAXfksLQ+4lQ8jwsL7YQGS5O4fQ
	vBU1WCW7ulrSGVYXvhEhLYWDDoXtezLeqRfmHZR9loPo1mpkxXkhrhkEw==
X-Received: by 2002:a17:907:3f8d:b0:bec:2ad0:cba5 with SMTP id a640c23a62f3a-c161e9c9f93mr76187266b.29.1783761762659;
        Sat, 11 Jul 2026 02:22:42 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm517493566b.27.2026.07.11.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:22:41 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 1/9] net: allow __tcp_read_sock actors to steal skbs
Date: Sat, 11 Jul 2026 10:22:11 +0100
Message-ID: <5466eea5fc519674df08dea564da17635a1cd6fc.1783619193.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783619193.git.asml.silence@gmail.com>
References: <cover.1783619193.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306787-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3D467410B5

Currently __tcp_read_sock() owns skbs and expects them to be present
when the actor function returns (modulo collapsing). For zcrx
optimisations I want to be able to take ownership of the skb in the
callback, add a helper doing that. It's only implemented for tcp, hence
keep "tcp" in the helper name. It could be later extended to other
protocols but would need some whitelisting mechanism.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/net.h |  1 +
 include/net/tcp.h   | 13 +++++++++++++
 net/ipv4/tcp.c      | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index f268f395ce47..ed882aeac4a5 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -165,6 +165,7 @@ typedef struct {
 		void *data;
 	} arg;
 	int error;
+	bool stolen;
 } read_descriptor_t;
 
 struct vm_area_struct;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a744..3d25707b73c3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3089,6 +3089,19 @@ static inline int tcp_recv_should_stop(struct sock *sk)
 	       signal_pending(current);
 }
 
+static inline bool tcp_read_sock_steal_skb(read_descriptor_t *desc,
+					   struct sk_buff *skb,
+					   struct sock *sk)
+{
+	if (skb_shared(skb))
+		return false;
+
+	desc->stolen = true;
+	__skb_unlink(skb, &sk->sk_receive_queue);
+	skb_orphan(skb);
+	return true;
+}
+
 INDIRECT_CALLABLE_DECLARE(union tcp_seq_and_ts_off
 			  tcp_v4_init_seq_and_ts_off(const struct net *net,
 						     const struct sk_buff *skb));
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 432fa28e47d4..309a0e6b0173 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1677,6 +1677,7 @@ static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		return -ENOTCONN;
 	while ((skb = tcp_recv_skb(sk, seq, &offset)) != NULL) {
 		if (offset < skb->len) {
+			u8 tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
 			int used;
 			size_t len;
 
@@ -1689,6 +1690,7 @@ static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 				if (!len)
 					break;
 			}
+			desc->stolen = false;
 			used = recv_actor(desc, skb, offset, len);
 			if (used <= 0) {
 				if (!copied)
@@ -1701,6 +1703,14 @@ static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			copied += used;
 			offset += used;
 
+			if (desc->stolen) {
+				if (tcp_flags & TCPHDR_FIN) {
+					++seq;
+					break;
+				}
+				goto next;
+			}
+
 			/* If recv_actor drops the lock (e.g. TCP splice
 			 * receive) the skb pointer might be invalid when
 			 * getting here: tcp_collapse might have deleted it
@@ -1721,6 +1731,7 @@ static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			break;
 		}
 		tcp_eat_recv_skb(sk, skb);
+next:
 		if (!desc->count)
 			break;
 		WRITE_ONCE(*copied_seq, seq);
-- 
2.54.0


