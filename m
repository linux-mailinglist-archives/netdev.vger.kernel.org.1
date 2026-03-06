Return-Path: <netdev+bounces-264855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNBDNqb2qmlaZAEAu9opvQ
	(envelope-from <netdev+bounces-264855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:45:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C302241F2
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F328F300E158
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215A3E7161;
	Fri,  6 Mar 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhtnmbrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95C1F16B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811806; cv=none; b=rsLUWF39pwS2AqZGIrugucxR3OAtmch9xj0zoW6DjaRKL2EqIEiWAfyxgXGQCQdbBaqr/jVBwkwFU8BbAmXqqfupj0R90hGrvuQqsfz/2n3nDAb+Ld6vR7F7oLV8bSmqqrziMW1tOkthpIO9i1xg6BzeNUVpPGhUWF6w7uKsVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811806; c=relaxed/simple;
	bh=Ag7VYELtAizJ3Ktu3lr0HPNTpWIrnBEwDc9r03+XSQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KuHE1vZi4McTmr+hHRDmRIojIerKDKOabhZKGHcnUeG9n9XZZnlTkFRH25hz6zuuvJLRapazqk7O7h5NoWpXwvWd2lvrblG8i6iAHkKFSPwc4mSaXZd16SQQJYSy9XrR4sbuXcsEtqhlH0sCDFzAVB8vsN8r0MF4BjB4UYZYjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhtnmbrZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79878791ec6so148883417b3.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772811804; x=1773416604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HyWlErDl4bVEU6bpo22F1kRA/Wy4PamUCZg+mcd+l3M=;
        b=yhtnmbrZDwn/8XDfhDCoYtlxojvxuarozZbwUG6Jhpp5EtFUj2sbGTfXy6aqRjDOBc
         hJjsIQ/d4NXDISAajakqLfEYhB1APcPhmgnUj/w88dlaJ+eGCmw13TQs10z01YSLmq8a
         CT/Vdu3J5M0jpzLptzKvIGRW006tuOmMJZZgQK69jYtMXoj3xHXBHEM+OWUf+Op9BuLb
         R6XjWRQBW6TGlv4D2MsFHlhXkjZ3VrPHI42j3WhCec2xj7kP3dTREUL6b2Xl3SySj1qA
         +sxBVeUWjUQXhDxv/YkRk7kDb3vn2ej2w95bXM/Wo74z8d+xERbhsnME+hK1xktZAH7p
         FeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772811804; x=1773416604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyWlErDl4bVEU6bpo22F1kRA/Wy4PamUCZg+mcd+l3M=;
        b=N/RZzYw4UP1YBC2qVVJEQlI7zqekIrSl4L4zLBeGYcbO/rVlc7MaOpVK5xhjZpDmgg
         PfaLTswAX3Gc5wDxD2q9E1h8vsXRT0+qR5C0DYjxCncqRzicZREPb3TxsEHojC/qnXqc
         0xvj2D9ZgPtFSOZEbrAk8O+pBxVrPwFDZ5FUX//RbZo2/RCBxrGC4k2GKq/3ZPTXCPXm
         hV7szYp67Xb34aFE38w/A4oBPe5dh8nrrwu47za38opTXUW4pSUUQRlImQ3xvU7VvY5r
         K6OsJoMDtMo1TRlEXqfR8oFAHWwKj+AmlnYYOkRcOFreYaosfnO3F3rfTrjf6uZyvnnn
         TqRA==
X-Forwarded-Encrypted: i=1; AJvYcCUw7uW0msTZjfT+t7A4hSmliLbiJN+ueq+7rxsB6eEdhwh+wCypsyOmAjIBp9Jf0YFHXCFN0XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3rrIZ9yCfwDW/fse9v1agU/R4n8kEBIO5z/D8eblnr0T9EHD
	uLeAYh2SYtSl47UjgT79Zdxs72VHyblVixuEQbm4nWjQd7JYGATEHa7eV2qqf+6zo9qVvJz3Btt
	jp14OYnfx+pGErA==
X-Received: from ywbcc13.prod.google.com ([2002:a05:690c:94d:b0:795:2443:c4b9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:d90:b0:794:f36a:c97 with SMTP id 00721157ae682-798dd799ce3mr22161987b3.55.1772811803753;
 Fri, 06 Mar 2026 07:43:23 -0800 (PST)
Date: Fri,  6 Mar 2026 15:43:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306154322.1086539-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: avoid dst->ops->check() call in tcp_v{4,6}_do_rcv()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 55C302241F2
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
	TAGGED_FROM(0.00)[bounces-264855-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

If incoming skb dst matches the socket cached one,
there is no need to call again dst->ops->check().

Network layer already validated the skb dst for us,
usually from tcp_v{4,6}_early_demux().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 net/ipv6/tcp_ipv6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 190e8a238876d966822531c74f17b896181e359f..b8e0562f68d7a1d02a5bb8c3b0aa0fe3b574d0dc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1855,7 +1855,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 
 		sock_rps_save_rxhash(sk, skb);
 		sk_mark_napi_id(sk, skb);
-		if (dst) {
+		if (dst && unlikely(dst != skb_dst(skb))) {
 			if (sk->sk_rx_dst_ifindex != skb->skb_iif ||
 			    !INDIRECT_CALL_1(dst->ops->check, ipv4_dst_check,
 					     dst, 0)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 164dceb842af767d93d0a2389564f543b2ba2fbf..074b83c9a551fafa52972a41506cdaf5299e24bd 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1596,7 +1596,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 
 		sock_rps_save_rxhash(sk, skb);
 		sk_mark_napi_id(sk, skb);
-		if (dst) {
+		if (dst && unlikely(dst != skb_dst(skb))) {
 			if (sk->sk_rx_dst_ifindex != skb->skb_iif ||
 			    INDIRECT_CALL_1(dst->ops->check, ip6_dst_check,
 					    dst, sk->sk_rx_dst_cookie) == NULL) {
-- 
2.53.0.473.g4a7958ca14-goog


