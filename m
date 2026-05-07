Return-Path: <netdev+bounces-285193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHHzKHhT/GlnOQAAu9opvQ
	(envelope-from <netdev+bounces-285193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BE4E5461
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6030130E39F8
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2934BA53;
	Thu,  7 May 2026 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3kAySoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817238A711
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143397; cv=none; b=X6TEay5U4MTZkoK6bBAxxPtgk0udYoCxjBhBz437fIasMuODLuCX2d9CXTjwqXBfJ+huwOAarSdq7N3/fg7RFLOQJGkI+rOTxQXb6tbOsmR4SlaZyimvHUpB+epT+GuB3fPWioV6dvHBQ7V/yv5ljIhd7lScl9fV5pXtX9r975Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143397; c=relaxed/simple;
	bh=ZMAU549aj2S6PZnpoM5zmF/BB8sp9vi6fV00BpWoeUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kkwZh1kFZJLR05XeZxAUthyzzpMA7Rlpx8n6V2AlWlVWXPyGrqwbldPEeonpd1aWkc7idqvaF02bomkJy2TDu5aq5qtUsOIBYy3HSk1KNbGAiUZQJ2dkM7U/aDjBGq5A6+BCpxwR1roiciy5D1T5HQSCqm9t83hwLsb5Y6iEc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3kAySoN; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8e8950b3ee1so179401085a.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778143389; x=1778748189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIpd9DJUk1AnIU7fkmU+5m29Sz2tmvPVJ0G7Dh1iZQQ=;
        b=g3kAySoNZ19P+5DnqqyIPZS1MOUf2IjYVSodsXwYi3VbM4+bJhnA71Hv5XpW0wyQrN
         3Fcw27ff5GaS2oVegZUvweDBU5wbnW04esfbDOo8IWSH2aSWth0aRsEZQ7jI9Xe8A+Zb
         LgaQv90+dtzUAo6fyMPurUdPXpjMMcLITmL/hz/x7ZNQWcYjTAP88kskq7YmqQhTviuH
         dJNVEvi9rQvIE8Kg/ZErDCTu6rHjkweQs+oDhqu1EIRY1G/o59FqgpJ5Kdh8YOSIDXDn
         4iC98z6HgW2olE9wW5zlt1LdQlms5nqJvO4K5tBNFrmpSLYbbpYuaNGnEMU6Ro3LT4v/
         AQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143389; x=1778748189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIpd9DJUk1AnIU7fkmU+5m29Sz2tmvPVJ0G7Dh1iZQQ=;
        b=V/4Ew/tUNJOrEFMp0mbAx9dAPYrbRZ0t0gcDRk81kvWp+j79gqEZteO9no+tYFhyrc
         ad1eAe7IsT5rTtfrWqdbSNvQqp6cnsbvX2UPF9aPHyZG2FvOse04yWT2xkJtDqsQ391w
         wL37a8/HfprKjaTmUruh/3yELdFjN9KezNOyfrX8908l2ClT1FJdJ57n57aIhqplTZmi
         UIfa3h9XcdhwN+XQATG3bdL6mwZjlmpsCmvbPyX5+cB8Trj9hZgrFpr2oS6eKEjHfSwO
         w4GG45g//pU3MczF2bQ4RfuFGl3F/F5NbKRR2Ul1U2YTjREmMmpJlb/bIcO/SCprxUTI
         YJEg==
X-Forwarded-Encrypted: i=1; AFNElJ/xAgp640pbdZxoBfLtoObp+oGs07dNAzf21jNTkAjK4sppEsLfbQraGmjvZlaQ4kjh697oGc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+biD79yTjOx1vStVRn+mKN6R1oj4lZu0fSFMzGCm7aRzE5BrZ
	npDKohoM6fKmgo6onplAiakBrug8HfIlpp45G26HM5UhCN2dGAuZs/PvWjzR+Fw6fUfNX4oWVFS
	FZoAIlsoYSJiHxw==
X-Received: from qkww18.prod.google.com ([2002:a05:620a:952:b0:8ec:481e:ba3a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40d0:b0:8ee:630e:3507 with SMTP id af79cd13be357-904d4391035mr1001209585a.1.1778143388784;
 Thu, 07 May 2026 01:43:08 -0700 (PDT)
Date: Thu,  7 May 2026 08:43:03 +0000
In-Reply-To: <20260507084305.2506115-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507084305.2506115-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: constify sk_skb_reason_drop() sock parameter
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 432BE4E5461
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

sk_skb_reason_drop() does not change sock parameter, make it
const so that we can call it from TCP stack without a cast
on a (const) listener socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h     | 3 ++-
 include/trace/events/skb.h | 4 ++--
 net/core/skbuff.c          | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b9edb0d1342319d4340c0a9997eeb..746e741a8ef99b3052ad581650e5d0db2a95dbb3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1313,7 +1313,8 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
 	return true;
 }
 
-void __fix_address sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+void __fix_address sk_skb_reason_drop(const struct sock *sk,
+				      struct sk_buff *skb,
 				      enum skb_drop_reason reason);
 
 static inline void
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index b877133cd93a80f6b130fab64f334ecdeab8c8fd..2945aa7fe9a7ded5bdec5be3a67382de95239517 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,14 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
 TRACE_EVENT(kfree_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location,
-		 enum skb_drop_reason reason, struct sock *rx_sk),
+		 enum skb_drop_reason reason, const struct sock *rx_sk),
 
 	TP_ARGS(skb, location, reason, rx_sk),
 
 	TP_STRUCT__entry(
 		__field(void *,		skbaddr)
 		__field(void *,		location)
-		__field(void *,		rx_sk)
+		__field(const void *,	rx_sk)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
 	),
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b5186cf622a3ed5a6e87c09d46bc3fd6..acca1365672c4f98b004c2548133d70c9cf5ddc1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1206,7 +1206,7 @@ void __kfree_skb(struct sk_buff *skb)
 EXPORT_SYMBOL(__kfree_skb);
 
 static __always_inline
-bool __sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+bool __sk_skb_reason_drop(const struct sock *sk, struct sk_buff *skb,
 			  enum skb_drop_reason reason)
 {
 	if (unlikely(!skb_unref(skb)))
@@ -1235,7 +1235,8 @@ bool __sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
  *	'kfree_skb' tracepoint.
  */
 void __fix_address
-sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
+sk_skb_reason_drop(const struct sock *sk, struct sk_buff *skb,
+		   enum skb_drop_reason reason)
 {
 	if (__sk_skb_reason_drop(sk, skb, reason))
 		__kfree_skb(skb);
-- 
2.54.0.563.g4f69b47b94-goog


