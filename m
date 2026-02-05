Return-Path: <netdev+bounces-257252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFSgCL7IhGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:43:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF35F5636
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA9283006905
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21843635E;
	Thu,  5 Feb 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fX0aGaB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0184413249
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309812; cv=none; b=Y7P7tyVIk2HzGlXgkfFQH40FqU/chyxLJSPOmqMLWxBxKZRYy8An+CVTlR76QUWYT8ptmafY73/NhpISgSgeygCo3Uk69BinOrRAmSKpgwpEBmCyEWnn/69nTEo6QMVnbSOiZuLZ/DNDBs3/vDMRUNlayFC7fgJPabnlSIrAzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309812; c=relaxed/simple;
	bh=8h8j9OK0mZMYUzyZFD1RF4R3BRD0BC+GnN9qCUU1z84=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CNBElHs9yw/ry/hJcUrfZa8G03mY9j1dSsz5fCmPOc+Dakcx3Mm2GVvlD74JcMMC7sOkOLTf5k8aFVUWxtQ/xbSxankHVChgBtMs5k98bmritGjVv7o6yGOP8DGmy5lTxYMAVvwa3Hqe0VBpR3gcU1jR92/osFyxKYtxKb/5s6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fX0aGaB8; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6b315185aso480259785a.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770309811; x=1770914611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N8VQop6KsFWN4a9hBGwheQJNo5bn3aJHAhq0FdAJflc=;
        b=fX0aGaB85a1UVGASm0p/vMb6Vrj7JuBcCrGb8RhH4Gh5467fJN3CalGCP+5SuCXjxY
         mLU3XqFpN7iE8k2xErqWiLO6mwaNcC9vpZk+LdTuAkP+RN+xn7uEulY8vZ4QA7qjbVV7
         +ar048F+JdDtWiBXPqZYXGttIb3GCXD9joPAb/tvP6TzJxVUl61LJt6eJo+OF3heD+UI
         XopGzYwrFBwzABMaj1ftmhY/652Ysw1zSTI2pFFHXV3ZJTIwze9Gz1ttPDjl5s1GU4i4
         XE0XUYEJtyx8vkSvtbVaA2zpSyYwV4y/taB08GFo0juf+6eI6bWmwQmeZ6Pd295GYthe
         G8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770309811; x=1770914611;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8VQop6KsFWN4a9hBGwheQJNo5bn3aJHAhq0FdAJflc=;
        b=pA3791VT2L2rpVEx+yz+pteZyCO6pUyB7ipQNjLkuo7ZRZinZEOGBkP3cRAYHz1Nvc
         Z8x8tIhOtTNYrQmH3CFRgyBzpQQ8wLYEzLy40uRA33VwQ1CFEjzWUz9+scyUxODD7HUy
         xWH/7LqiVIowcEWWZyL0fLVU7vSDLROb0R24y5MdtutjWbpR0Y/w7bNldgQQR/0OsSBv
         dVsjkMyixQG2+pMrBizNjNfx57ybIo29+ERyqByBLfGp8S7wDXjAU1n/VrPgoQjWGM/X
         gP3BodCRMwEUbRqKOFrRzEuuawN39EZc5CsusVpXNvS3anR2LBf346glGLXDD3KyXZ9X
         T7yA==
X-Forwarded-Encrypted: i=1; AJvYcCWUMtLWfrVAw0sJHWzXwGo5norteZRguYGlMjsxuJPQC+vUVpXL2gMHVvTSH7hixtuUSBJJ5BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83DA3s1sN+kMmPxLH8bGk7WB7nUWzfzbPiSe063Rk9H5ozQMs
	fhpf8KeZnfRNAhKHAKrLh2pU2TnZ1fpWK6mEZ4VMr6Lj6edGunpvZeU1bi1KQMtz0AZpyt7YTX9
	Im2XZUy4XTd1wFw==
X-Received: from qkbbk21.prod.google.com ([2002:a05:620a:1a15:b0:8c7:f48:b8f1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7084:b0:8c7:16fb:ed45 with SMTP id af79cd13be357-8ca2f83c861mr907315685a.27.1770309810720;
 Thu, 05 Feb 2026 08:43:30 -0800 (PST)
Date: Thu,  5 Feb 2026 16:43:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205164329.3401481-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: inline tcp_filter()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257252-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BF35F5636
X-Rspamd-Action: no action

This helper is already (auto)inlined from IPv4 TCP stack.

Make it an inline function to benefit IPv6 as well.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/0 up/down: 30/-49 (-19)
Function                                     old     new   delta
tcp_v6_rcv                                  3448    3478     +30
__pfx_tcp_filter                              16       -     -16
tcp_filter                                    33       -     -33
Total: Before=24891904, After=24891885, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h   | 8 +++++++-
 net/ipv4/tcp_ipv4.c | 8 --------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 8f9f52f3408c2e87adaad3e26ffc7162776309f1..40e72b9cb85f08714d3f458c0bd1402a5fb1eb4e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1633,8 +1633,14 @@ static inline bool tcp_checksum_complete(struct sk_buff *skb)
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		     enum skb_drop_reason *reason);
 
+static inline int tcp_filter(struct sock *sk, struct sk_buff *skb,
+			     enum skb_drop_reason *reason)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	return sk_filter_trim_cap(sk, skb, __tcp_hdrlen(th), reason);
+}
 
-int tcp_filter(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason *reason);
 void tcp_set_state(struct sock *sk, int state);
 void tcp_done(struct sock *sk);
 int tcp_abort(struct sock *sk, int err);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 01fd563472608cc10744d3a5d4fb998b83c4be97..6264fc0b2be53854598d7c37ce1c7928d2e0b507 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2109,14 +2109,6 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 }
 EXPORT_IPV6_MOD(tcp_add_backlog);
 
-int tcp_filter(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason *reason)
-{
-	struct tcphdr *th = (struct tcphdr *)skb->data;
-
-	return sk_filter_trim_cap(sk, skb, th->doff * 4, reason);
-}
-EXPORT_IPV6_MOD(tcp_filter);
-
 static void tcp_v4_restore_cb(struct sk_buff *skb)
 {
 	memmove(IPCB(skb), &TCP_SKB_CB(skb)->header.h4,
-- 
2.53.0.rc2.204.g2597b5adb4-goog


