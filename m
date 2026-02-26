Return-Path: <netdev+bounces-261186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R7KpAyfIn2lYdwQAu9opvQ
	(envelope-from <netdev+bounces-261186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:12:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393241A0C9A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36C2301BF51
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0715237418D;
	Thu, 26 Feb 2026 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGIU/ua0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A132BE056
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079136; cv=none; b=HLdiEPvizO+SmkC2HIL23Bksrbs81fA4eMxKsVOV1ZP/jIfikvQ8B0I1o4uDM1lAbMLZ12Asr2VbkCTy1a0bpT6RnF08/1unTDdv0e1K7xirWeeh8g0WZj6+GFkIGiDkT+eQrFV0vNdPR8i/XOkPk//Lh9YjvN9JTXTWaXKk7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079136; c=relaxed/simple;
	bh=S1HxwiGdoE03ft7nkt26MVpvIH+mhgM1D0qykqRuiuw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OmLxrewRccPhKpdBrV/QvnM5bAn2ArucJt5wDWNHF8Iet6KWgR7X6E6ApRdvNxhi5HDiftZgsIHqEXkhA45RXZ4Ya/qtaMOQqHAAXlteq95Q5GOj6pdGs0KdvRMKYe1a4jdFeDByd3AGOLTCF9bw2gV/TsyQ2wOk1jFIVlxq4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iGIU/ua0; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64ca6895833so474977d50.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 20:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772079134; x=1772683934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T0Rc0t9GoeUJOQ9U6UQiIRp0nW7xZbKdLAtp+mVwQ9Q=;
        b=iGIU/ua0f00DRRtHzf4BPAmxeJCyD5VUDBuG8XsmrTh/i9uWEMqW4jbJ2JsUgnElE0
         8V0xT8iFq0u1g1OXE99Pn5U/iXdj4cnjeAp/icBUWO3HLKGRDNGhTkc5OTMZY5h3+fsZ
         vM4KYa/TM+p3C0KR0WDI55iQZfrTx5pnglpAhNkHe3YETD9JZ36+MZtLGRaiGURt6Jvy
         6y2AafFrVZJSAQRjU/XerLeuIIlZtZHGxCEe4sYUbsepnODhAoVkAUVdgHFnjZwGMWzo
         TkVcqEV0zQh1ep6ledQjZJ3QVhaZJ8S6yDjiblBWMoq2GBRqKDHFKvagoUAev5YXQf9H
         EabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772079134; x=1772683934;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0Rc0t9GoeUJOQ9U6UQiIRp0nW7xZbKdLAtp+mVwQ9Q=;
        b=Qi/t5wiNYv3f0PZm1882dV4pLUa7xNqfptKtOZhjn8+mVcnPlQfEob0GWzQ6uZymn8
         Rv/RopGDrdqJQQxOcIJvkgUX1c6eptT8YDUSdJlTwfBWovUqr3PNRGEpDJqmrFx/WpxG
         NNiqBNa2/b/VSb8LLokNUvLnq3iegrG/0OPoZ3+MdaSa2uE1SUq10ywTrFIuL3+uCYC8
         L4Z9qD1BjiWdQi3IiYkx6dXiyje3sRXvKEyr2kwgRyTqVomu3XGjDxc6OVk1vK1Pu+Rm
         wtEhrf4A5vdfDXmgNKnvdzehRAzsRDJfMrcZq51bfMRi0x+sfqP9/1/Akuy4QZINeIU0
         Ih3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5Jchqa1ZN1SAPKozx8ambGZZ/4ue+gMx8pUoel2hxboi6754lEq3kjwO8hWD4p6O66HEzhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTYO4lZ8zFZg+1VNZptV7C/y8zWJFMLSVLo+n/QCilagjP6l7B
	3dJ+Xzk8zb7VlxbfH2ftZYcf1b57NTBo7uMy29Vg7Mb9ranpfGDPv+XQZVBhhV5/UvqXXS27sgH
	GltLGziRIFXDN5w==
X-Received: from yxow16.prod.google.com ([2002:a53:a650:0:b0:649:d431:3c9d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4452:b0:644:60d9:7512 with SMTP id 956f58d0204a3-64cb7c815eamr552796d50.86.1772079134467;
 Wed, 25 Feb 2026 20:12:14 -0800 (PST)
Date: Thu, 26 Feb 2026 04:12:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226041213.1892561-1-edumazet@google.com>
Subject: [PATCH net-next] net: inline skb_add_rx_frag_netmem()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-261186-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 393241A0C9A
X-Rspamd-Action: no action

This critical helper (via skb_add_rx_frag()) is mostly used
from drivers rx fast path.

It is time to inline it, this actually saves space in vmlinux:

size vmlinux.old vmlinux
   text    data     bss     dec     hex filename
37350766        23092977        4846992 65290735        3e441ef vmlinux.old
37350600        23092977        4846992 65290569        3e44149 vmlinux

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 13 +++++++++++--
 net/core/skbuff.c      | 11 -----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index daa4e4944ce3f2184b193f43dbab88147ae2a7e4..9cc98f850f1d7cd01eed3fe9d17b59116b49958e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2682,8 +2682,17 @@ static inline void skb_fill_page_desc_noacc(struct sk_buff *skb, int i,
 	shinfo->nr_frags = i + 1;
 }
 
-void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, netmem_ref netmem,
-			    int off, int size, unsigned int truesize);
+static inline void skb_add_rx_frag_netmem(struct sk_buff *skb, int i,
+					  netmem_ref netmem, int off,
+					  int size, unsigned int truesize)
+{
+	DEBUG_NET_WARN_ON_ONCE(size > truesize);
+
+	skb_fill_netmem_desc(skb, i, netmem, off, size);
+	skb->len += size;
+	skb->data_len += size;
+	skb->truesize += truesize;
+}
 
 static inline void skb_add_rx_frag(struct sk_buff *skb, int i,
 				   struct page *page, int off, int size,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index dc47d3efc72ed86dce5e382d505eda7bc863669a..e3aa1612ef5dce5b96deb17731d0449d79adc34f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -891,17 +891,6 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 }
 EXPORT_SYMBOL(napi_alloc_skb);
 
-void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, netmem_ref netmem,
-			    int off, int size, unsigned int truesize)
-{
-	DEBUG_NET_WARN_ON_ONCE(size > truesize);
-
-	skb_fill_netmem_desc(skb, i, netmem, off, size);
-	skb->len += size;
-	skb->data_len += size;
-	skb->truesize += truesize;
-}
-EXPORT_SYMBOL(skb_add_rx_frag_netmem);
 
 void skb_coalesce_rx_frag(struct sk_buff *skb, int i, int size,
 			  unsigned int truesize)
-- 
2.53.0.414.gf7e9f6c205-goog


