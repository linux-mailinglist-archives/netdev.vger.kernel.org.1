Return-Path: <netdev+bounces-256118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUSM8N+gWnlGgMAu9opvQ
	(envelope-from <netdev+bounces-256118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 05:51:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7236BD47E2
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 05:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6817300D343
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 04:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0F207DE2;
	Tue,  3 Feb 2026 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzDXmVw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBA1C6FF5
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094273; cv=none; b=iSn7x7PNdB2Vst8Ewzwl5dJ7djVAGGCMn31ufqgCYOSJiP7jF+mE27N9OcsMljBOW1Qc/A4BF5DvzzQqVAi1gYK9xf+tRUkGJK1PaYD/5G3H5N2lrN0lqymjBIgmvvTpPv3PE7hzgMiAW6HqfqodV5XOYYLihYQsQqfmcM9+Vck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094273; c=relaxed/simple;
	bh=qCxhDSjPVbgQgwamC4WBMiuCQMqvPPssesO6UZIaYLs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G3/pX4Ro8CInbR7tT4qBY/yH2lOIR567f8okn0jPGYJgZkn2e22xuflBW7BiU8NXg+LKKUXMc730QobM9cH3t7k5R3+MRgaVpd65FXmGpqJCRzzE9bSQORcqcAziwTk5VAOjW2bkkjyXjq3InUhg6pSD4GjZPsWXAiBQwU98pUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzDXmVw6; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70d16d5a9so268247085a.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 20:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770094271; x=1770699071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=83Lb2rnusb9ptppFnISdDciKlw5xSufxQySa/7IEWw4=;
        b=LzDXmVw6869YUCh0BBNeGp+FGtLXWFCSUZQQiNO78Hy+V39hhgUzXEhDHDlgBG/XRs
         LwK/+/a148im2+SsPXFwk+AqeJntNRXQxupoCfPQJFAA6NqKhq4ESw3VguONIYos8VtW
         tyIx6kTo4wp2N41O65I22ULJv9BcpNn3wZJbkrd+bzCxVo/pwP8zlU3SnGLfIHYl+5MA
         P8eI1E6CucQk5286Zygac1rbfLN519YNkfLPT/0cBbx2WW0el+wLKX7sv942HDCL/sOz
         I1XR5qQHIx/7RSm0K7QKJWT8p3llA9SB80bworkAtIjBK6rEX93hL/6F0ur8Ei1bTQOZ
         DjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770094271; x=1770699071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83Lb2rnusb9ptppFnISdDciKlw5xSufxQySa/7IEWw4=;
        b=h1s95Y/1FT/MjOpgXHJnA0WrYXg9Qi0RzMEfmgNLQOcvhaVLCt6kFsbHAxMpSi8gB2
         nAkyWhRCv0TSTo+xEDzYBR9mXuj0lqpdf8zQ5qECsyAnWkNQ0TBMneZLOHybv2mM2EAl
         pYQUsTzooE8Fc8A1DvA5gUqh9/v3j6lrMNrOqONDj4nZ53M032kzhRNakVI0DD2Jya3Z
         tZm3BD9/DDcEKM1hRp9PL0XF1aVEFVsoU/0xbDvvDnTKnd5ePmjoQasjnMjyBxAAOcJR
         tZdjJE5jI2ENQSSzNjdAxO1e2fryWasCWds8ORj4Woi6flpQbKg9Ra46ULpfo9KAtpHv
         g0vA==
X-Forwarded-Encrypted: i=1; AJvYcCXOnIxbFTc8reMnOppMHfYmMoslPh7GL3LKUDO11LSP3aRvsYzPNj26RPDV1U75SN5AhWxamq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYf1JAvNdRd8/rUu+SPYkMNiokzjuEyoqHRJ2vHrBrtXwKOx6S
	7Hy9ikK/C25wzQ3cdAS6XlpED0jZQK7TGpaCt3ioo7EPPJQebW6jfdnlhSLPmuleJL4UrHDsNzd
	Zdn0RgRM+j5Orfw==
X-Received: from qknpy5.prod.google.com ([2002:a05:620a:8785:b0:8c5:33d4:7766])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4504:b0:8c6:a539:55d7 with SMTP id af79cd13be357-8c9eb320f07mr1722852485a.55.1770094271098;
 Mon, 02 Feb 2026 20:51:11 -0800 (PST)
Date: Tue,  3 Feb 2026 04:51:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203045110.3499713-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tcp_rbtree_insert() to tcp_output.c
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
	TAGGED_FROM(0.00)[bounces-256118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7236BD47E2
X-Rspamd-Action: no action

tcp_rbtree_insert() is primarily used from tcp_output.c
In tcp_input.c, only (slow path) tcp_collapse() uses it.

Move it to tcp_output.c to allow its (auto)inlining to improve
TCP tx fast path.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 4/1 up/down: 445/-115 (330)
Function                                     old     new   delta
tcp_connect                                 4277    4478    +201
tcp_event_new_data_sent                      162     248     +86
tcp_send_synack                              780     862     +82
tcp_fragment                                1185    1261     +76
tcp_collapse                                1524    1409    -115
Total: Before=24896043, After=24896373, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c  | 19 -------------------
 net/ipv4/tcp_output.c | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a2a872382fc0..10f864179982 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5756,25 +5756,6 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 	return next;
 }
 
-/* Insert skb into rb tree, ordered by TCP_SKB_CB(skb)->seq */
-void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
-{
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent = NULL;
-	struct sk_buff *skb1;
-
-	while (*p) {
-		parent = *p;
-		skb1 = rb_to_skb(parent);
-		if (before(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb1)->seq))
-			p = &parent->rb_left;
-		else
-			p = &parent->rb_right;
-	}
-	rb_link_node(&skb->rbnode, parent, p);
-	rb_insert_color(&skb->rbnode, root);
-}
-
 /* Collapse contiguous sequence of skbs head..tail with
  * sequence numbers start..end.
  *
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f907f24f74f7..b09f2bcfc237 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -66,6 +66,25 @@ void tcp_mstamp_refresh(struct tcp_sock *tp)
 static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 			   int push_one, gfp_t gfp);
 
+/* Insert skb into rb tree, ordered by TCP_SKB_CB(skb)->seq */
+void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct sk_buff *skb1;
+
+	while (*p) {
+		parent = *p;
+		skb1 = rb_to_skb(parent);
+		if (before(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb1)->seq))
+			p = &parent->rb_left;
+		else
+			p = &parent->rb_right;
+	}
+	rb_link_node(&skb->rbnode, parent, p);
+	rb_insert_color(&skb->rbnode, root);
+}
+
 /* Account for new data that has been sent to the network. */
 static void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *skb)
 {
-- 
2.53.0.rc1.225.gd81095ad13-goog


