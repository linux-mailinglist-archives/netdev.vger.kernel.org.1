Return-Path: <netdev+bounces-254277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCMZMSAaemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6687CA29A4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92AC63004F02
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729261E572F;
	Wed, 28 Jan 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afLnYKu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11825CC40
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609745; cv=none; b=P6qI9z1WyPMkcLAYTJyznM5whlNgtB0qMdBD++PBELUDjGyt7AXC569tdN6gCnFgkTKdQyZJ8KHa8jKUbPHDC+5vZatg4ID7T4vX0aaWD+uYY0mKIKQ6yTLDdYABhPHvRac2EF8yLRNUjlqrJNLC6u7bCrWOO1a9p8NfqUKO+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609745; c=relaxed/simple;
	bh=/wwlQlbY0Tf+Y6iCo7UFEe/NHXl+KvdrxZYN3PhgYW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jpcFcfN4nThnR3Mw5dh8kh93+/5HIQNmyjGzOfCPdoHLonE/2BrPD6xAW43RiX1WlTDcEeR8plIGwtb7IXilPR3ORv6odByyjxiexjzfTKh6zdcPq4wIWQt2J5vDoal4UaSmMC6Sshlb9LYGu+YtWJiLJ5VnK8S4xgdyDhyIkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afLnYKu3; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c71655aa11so150595985a.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769609743; x=1770214543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypwNblDnLh8+YheOl8QdRP/NyQ82ewFbydVwOfg6i+U=;
        b=afLnYKu3KMzlcE1ROD0VW2zkxzBrqGMHuhNSHuEWPJ9YXAD/dFyMeHAoLXp0Z0Tssa
         gcu980IchpzWzn2fTCbT9Eq2EEB13EeNzIztB0kBSWLnouCRs6DpEl6YEXNGJffqmHXG
         R94TZ5u9rSoQG4ReFUZPOSajMfh1N2t53vCKnGFRIuNb0+emXuNnL7I1a/flAcPW/aQ4
         BJf4TfYJeDR9fXcFLJ5w4R6LZhGBkltPOFUF8Z69f7qPGhAlhfR6MqSCD1waHUZmETIj
         D1ULMJv67aqztyswm7otp5NvMbl7dXmcV/GnbkQviOoHfz4vbhGlT27Bxdi7MEdENFCT
         Yo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769609743; x=1770214543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypwNblDnLh8+YheOl8QdRP/NyQ82ewFbydVwOfg6i+U=;
        b=mcOW28Lck59wR03F+SgE/lwaWcpItbUjca5GtyEWV/pQzsM6VPLo6L1gu46GCimb9K
         2N2B2e7TewxmBC9xKHuxLS/+X//RpXEeRHuUhzdkX08Iq8C0aRbNF5Gvyk13zYPDQEWY
         jbqz9uFw1p2Kd24+IJm1xbz+3R2qINriGnFd/w6hnOruw3S6HxqirbJ+K/UZnPGhozfT
         ceEpQf9L1bLUBQA+s0Z3lkXRU3dvkpDmtIo1+kaF3/DLc8FZNqcyRnnhdIyiZIEu/Lr4
         PhQrzYBpzJfdtHrkvHz3Y7yU5RChHJxDQQtT+NoQudRYV0wZFzNGz8w4N0VtycO8+ADc
         uhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5B3HUicId/NHMlJwLgtmiRq06mKE8eJ9yMV6UlQK/TKysBbzTbfTGfifWHbtlJRYVUzIvtHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCNy7wLAPQ63pICTRV6znhNl2fzc2p0Ndmvly88XATVWDGtuH
	a3o4W1CXFHuGUoLAgIgIJKbuCjs0TRb86wUVQeGdF7qpG1SbYveOLAcstIxmBfHN6iAYxO+sxGE
	1tSbV7CEynmVNqQ==
X-Received: from qkat28.prod.google.com ([2002:a05:620a:ac1c:b0:8c3:91c8:a752])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:31a6:b0:8b2:db27:425e with SMTP id af79cd13be357-8c70b8f129dmr715914985a.50.1769609742755;
 Wed, 28 Jan 2026 06:15:42 -0800 (PST)
Date: Wed, 28 Jan 2026 14:15:38 +0000
In-Reply-To: <20260128141539.3404400-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260128141539.3404400-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260128141539.3404400-2-edumazet@google.com>
Subject: [PATCH v2 net 1/2] net: add skb_header_pointer_careful() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, GangMin Kim <km.kim1503@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254277-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6687CA29A4
X-Rspamd-Action: no action

This variant of skb_header_pointer() should be used in contexts
where @offset argument is user-controlled and could be negative.

Negative offsets are supported, as long as the zone starts
between skb->head and skb->data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: use skb_headroom() instead of skb_headlen() (AI feedback)

 include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d4a8452e90fe78adcdcfdefb79169..112e48970338fa8b24bb001e00c30631f4fab814 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4301,6 +4301,18 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
 				    skb_headlen(skb), buffer);
 }
 
+/* Variant of skb_header_pointer() where @offset is user-controlled
+ * and potentially negative.
+ */
+static inline void * __must_check
+skb_header_pointer_careful(const struct sk_buff *skb, int offset,
+			   int len, void *buffer)
+{
+	if (unlikely(offset < 0 && -offset > skb_headroom(skb)))
+		return NULL;
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
 static inline void * __must_check
 skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
 {
-- 
2.52.0.457.g6b5491de43-goog


