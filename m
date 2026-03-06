Return-Path: <netdev+bounces-264787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNZwDonSqmn3XQEAu9opvQ
	(envelope-from <netdev+bounces-264787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:11:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B32216B5
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54460300E3C6
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD613939AB;
	Fri,  6 Mar 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmtQst2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046061C5D44
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802694; cv=none; b=kOLy5NTJQ6FLcfwqm1W6F/ZZK6zLirekLH623PbC9CxUji5iGGx5gW/sJYtEMsBrxM2olpjS5SW4KcRQhlRTy3VUdWMmgXuXThCKNx1hRqujvR8GHXQVMngmI1U2FChjEKynnTGqHlyQdJEw8iVntKyfoC3ecbGMsMWqEuVSZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802694; c=relaxed/simple;
	bh=VxSMMFFEYE+EaLt35AYPPP718hPeEIUR8a6ifoZ3sPE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iXx4o7xOmdvcCxkBaxtJf6tCGpW9S9BY0wG6WXXN/UXudQlEUjxtjTvoxzl2URGcP/+PhOFxPLm7KcAzl8p/RIjC/aWtoylAlgUTESOU5RNmw1PGO5AEiNAJH93bgRvwoUY+NFCFpRqiNpPrNWrQrIQr4iVajuaZyYyAj1PSFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmtQst2g; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50620483ff6so648399401cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772802692; x=1773407492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ktdv9ZRhyx+YQbCXtLuWbyBpMa/nQXIoSrOSTJ4Z+0A=;
        b=JmtQst2gI5pKItiwsPHeJwmm/8/OEKEAWxZLPAoHcYvdCq1oT62lhvBdAWzfyExc9b
         4JA3gWe/9XGUcZFezEyTf13y96Smd/0teAcHg1tuGz9cxXPcHCl9ImyruKaAMNc2DkAv
         tYuvEHV+ZZDNN3OYLuENoaoAbm0NE2INPEDS1W88gdlgTZVYL3X4jvgnq3fTgA7Zo410
         J6NxTImUFgBzcxJ30rzLaEcUIPUX/SziVltpRgldJJEwmKVyJY3DodokV9+YtVkln4hK
         lc8YfqXZftcn6prysWoN+TT2z5bJSfClW9Zuimzc+6+y4PJSQ9ad4ycC27/ddw3eDkh8
         iMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802692; x=1773407492;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ktdv9ZRhyx+YQbCXtLuWbyBpMa/nQXIoSrOSTJ4Z+0A=;
        b=rRliISP7N4lZvQPmtnNPMci2A/QYQiVhj+DiiPrquUP+Ls9pB7LW1dWptR5z18bDww
         vkVZbD5eP37Vpm9uLCzlmueOTiVDaUhtiE7VnxqXCAi5bH7OUmYt/tdSCiUfAjtcSesj
         wFuskQULm7xDpJLUKm4q5SA/E7yVvc+y4iPmf4Fk9TpPRoTmk9ISdru7TIrA96KUjaRt
         q4+d+U0p7ahrZnBxYxaqMoanWAOfMaCT6+iP8XLfNxjnVSN/t4/mjGTBOPTK8evMwmWb
         xaaJIuwyVs3uKweCVSwKhRlcy7WsG9hCORzxnbSEWeybQhaRp9waWwkxklo4J2ywrIMA
         m89Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW4alKakpF0QcF129W3CcoNJRc8lQF/6/BxF6XhQVFq62ysyUHUY+RlzOWniQj7nkRQVRLRlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvif5SrPUoiYeuee24Rbxt+x046zb626+mzzbnHtDdIl/A0CLr
	j1h2MKHpYPBGSrw7rh53I0HdBMISvHzGR1MOX1s5umuQRtWtGLnzwuCBMgAt9I4CpyoWNkykO96
	7cL0P+39Wn27AHg==
X-Received: from qtbmm17.prod.google.com ([2002:ac8:6411:0:b0:508:fb47:2427])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:58a:b0:502:a241:1eec with SMTP id d75a77b69052e-508f46d163fmr24548781cf.3.1772802691569;
 Fri, 06 Mar 2026 05:11:31 -0800 (PST)
Date: Fri,  6 Mar 2026 13:11:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306131130.654991-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tcp_v4_early_demux() to net/ipv4/ip_input.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A98B32216B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264787-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

tcp_v4_early_demux() has a single caller : ip_rcv_finish_core().

Move it to net/ipv4/ip_input.c and mark it static, for possible
compiler/linker optimizations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h   |  1 -
 net/ipv4/ip_input.c | 39 +++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c | 38 --------------------------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a6464142380696e4948a836145ac7aca4ca3ec15..f07aef7faa65f8bfcdf93c9fe943f9b4d4a0dddb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -363,7 +363,6 @@ int tcp_v4_err(struct sk_buff *skb, u32);
 
 void tcp_shutdown(struct sock *sk, int how);
 
-int tcp_v4_early_demux(struct sk_buff *skb);
 int tcp_v4_rcv(struct sk_buff *skb);
 
 void tcp_remove_empty_skb(struct sock *sk);
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 19d3141dad1f8b031981aea40c311509583e9256..9860178752b8ccd70fd97d2a713b7c1a981fcc71 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -319,6 +319,45 @@ static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
 	       ip_hdr(hint)->tos == iph->tos;
 }
 
+static int tcp_v4_early_demux(struct sk_buff *skb)
+{
+	struct net *net = dev_net_rcu(skb->dev);
+	const struct iphdr *iph;
+	const struct tcphdr *th;
+	struct sock *sk;
+
+	if (skb->pkt_type != PACKET_HOST)
+		return 0;
+
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) +
+				sizeof(struct tcphdr)))
+		return 0;
+
+	iph = ip_hdr(skb);
+	th = tcp_hdr(skb);
+
+	if (th->doff < sizeof(struct tcphdr) / 4)
+		return 0;
+
+	sk = __inet_lookup_established(net, iph->saddr, th->source,
+				       iph->daddr, ntohs(th->dest),
+				       skb->skb_iif, inet_sdif(skb));
+	if (sk) {
+		skb->sk = sk;
+		skb->destructor = sock_edemux;
+		if (sk_fullsock(sk)) {
+			struct dst_entry *dst = rcu_dereference(sk->sk_rx_dst);
+
+			if (dst)
+				dst = dst_check(dst, 0);
+			if (dst &&
+			    sk->sk_rx_dst_ifindex == skb->skb_iif)
+				skb_dst_set_noref(skb, dst);
+		}
+	}
+	return 0;
+}
+
 static int ip_rcv_finish_core(struct net *net,
 			      struct sk_buff *skb, struct net_device *dev,
 			      const struct sk_buff *hint)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 190e8a238876d966822531c74f17b896181e359f..f27995a6456198866ec2f9860b18d911e8dc1bcd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1914,44 +1914,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_do_rcv);
 
-int tcp_v4_early_demux(struct sk_buff *skb)
-{
-	struct net *net = dev_net_rcu(skb->dev);
-	const struct iphdr *iph;
-	const struct tcphdr *th;
-	struct sock *sk;
-
-	if (skb->pkt_type != PACKET_HOST)
-		return 0;
-
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct tcphdr)))
-		return 0;
-
-	iph = ip_hdr(skb);
-	th = tcp_hdr(skb);
-
-	if (th->doff < sizeof(struct tcphdr) / 4)
-		return 0;
-
-	sk = __inet_lookup_established(net, iph->saddr, th->source,
-				       iph->daddr, ntohs(th->dest),
-				       skb->skb_iif, inet_sdif(skb));
-	if (sk) {
-		skb->sk = sk;
-		skb->destructor = sock_edemux;
-		if (sk_fullsock(sk)) {
-			struct dst_entry *dst = rcu_dereference(sk->sk_rx_dst);
-
-			if (dst)
-				dst = dst_check(dst, 0);
-			if (dst &&
-			    sk->sk_rx_dst_ifindex == skb->skb_iif)
-				skb_dst_set_noref(skb, dst);
-		}
-	}
-	return 0;
-}
-
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		     enum skb_drop_reason *reason)
 {
-- 
2.53.0.473.g4a7958ca14-goog


