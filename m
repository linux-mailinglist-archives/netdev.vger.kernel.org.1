Return-Path: <netdev+bounces-76720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCB86E9B4
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1537286CE0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953B3BB33;
	Fri,  1 Mar 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nh736mtj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D43B2A6
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321870; cv=none; b=FKMzNdw30O6BFIFgTBI8ueCr7VHr8kDsMIAdY6vkKbd9pEVyb5ftkHBrYuZZwni6eMHBaAs5iTEBai5ZC5MTvb6sazcvPPenV77n4o0y/JVMSriygQnStBSrJgTV79+d87YI+I5cgJFWlOrtWVNKMAR2U2IFLytL86k0KEFndWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321870; c=relaxed/simple;
	bh=7QlOKeJz6CBEcvJtiJQkpdCoWIKOR4kjFWDUUQS6z7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RY23SI8IJ6PVkAG14XeBzpHwFaomzpNz+Fom49AcnA5dMx7A2Q9hbmj7eVcdx0z6OBOe7I6wDJVffWgnrNN7FI/bPEqbuswqWs9a/Uln9jwcYEji/RrZOij9x6DeTzwKP80JwbX6Rz0seZ5S6sTW2HXVm9AxxUK9eXBHUe8kPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nh736mtj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc15b03287so3588234276.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 11:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709321868; x=1709926668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+XDD+X98TQ5bJaUIivjQNWZ3/8yjB1dtyzn9J17zj0=;
        b=nh736mtjX4b+rTBpyK60iul0KdsdwWOXRiGt+DAwGgBa3H9Ukh+SfdUQHqTLxxUfxJ
         fysBhk6pbH+cnSDc2tICViWtF2aFGZfdmkdGI1hYtmyPqNhPN6X6D9wCg2TCptCH0wwy
         uTsfOGykKCfRD9ZMbQRdCULzLgwGslSKJIeEIYgluOKY/7aFEVyEJTEUZWuexeGLiHrM
         vnuR1l1PfbH5lkCr8JuIbV8cJmMMeQU2Y21uUJpdqGnA0dM+5ssQsNys0sEWocV4otNW
         aXa14lyoLzKAp3n0JqQlAW6eUa9tpmxCNDDPSOkKVb6bUn7KPnuA04tLgJVs6eTEgiTB
         zO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321868; x=1709926668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+XDD+X98TQ5bJaUIivjQNWZ3/8yjB1dtyzn9J17zj0=;
        b=MpbF/KI+AywfsZHDcJ+GLwSI9oBOrX+cOX4F8MJy0cMsnKJK/AZVqStoClidfY0lGT
         ITF+7BHbTSRHfcWAS3hiiy7cXgL6tne0XKAD2AHs4r5Ui5137Znd894dcgO+lNkXfkzB
         iL2LSwQtacBBQScFnJ1eOmkJUb3O9qgh8ONZVKWSUb0cpBKZr0Xx2w7a/AhpB6Eriaj7
         nWCHsXfos8oHor1UfM5GJg0e1y86Tu8iQEg9K8Y2Hz2c9TkdIqtGFfeHS0vgOG9CndaS
         OP8DcdcHIUaB+WThr8NBzBc2P6odXLSibwk/jmsPBoTaZkLxsscN1nhF7KFZ3lFhyQlr
         T+3w==
X-Forwarded-Encrypted: i=1; AJvYcCUSfMXEnj7FvrcslV2kYV9uoWMiR8yWr6qkEWZEb7hImmX3Ed6S4uFcRDsDsLDMwoJLj5qKTi7T9MZtJozI7OsJi6oRYgnq
X-Gm-Message-State: AOJu0Yzyyv7uo/sijHC86lLa4cbcpIKZb45vrjIYfsEBAf1TNdeRvrEO
	AFVbiH+97G8zCBNhoSmKK5jMuhZ14P/p+It+gdhDCkY3pmGjgZbE91JEQJV/fTms2MEjSXlgTtt
	odfoXnsNKqg==
X-Google-Smtp-Source: AGHT+IFxE/drwjekMEekDuZWSXSaUKxWObSixaj/U0m0NMV2MECBIlQAHUSQLEcuVaxLEKMSO13El6Sv77dcsA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:188f:b0:dc6:b768:2994 with SMTP
 id cj15-20020a056902188f00b00dc6b7682994mr114391ybb.0.1709321868184; Fri, 01
 Mar 2024 11:37:48 -0800 (PST)
Date: Fri,  1 Mar 2024 19:37:38 +0000
In-Reply-To: <20240301193740.3436871-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301193740.3436871-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301193740.3436871-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net: gro: change skb_gro_network_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change skb_gro_network_header() to accept a const sk_buff
and to no longer check if frag0 is NULL or not.

This allows to remove skb_gro_frag0_invalidate()
which is seen in profiles when header-split is enabled.

sk_buff parameter is constified for skb_gro_header_fast(),
inet_gro_compute_pseudo() and ip6_gro_compute_pseudo().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/gro.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index ffc2c96d263b0399a81465d903a6181271b4a3f7..3c3666e46b3055caa619f2da0b6b8b20192a03b4 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -139,7 +139,7 @@ static inline void skb_gro_pull(struct sk_buff *skb, unsigned int len)
 	NAPI_GRO_CB(skb)->data_offset += len;
 }
 
-static inline void *skb_gro_header_fast(struct sk_buff *skb,
+static inline void *skb_gro_header_fast(const struct sk_buff *skb,
 					unsigned int offset)
 {
 	return NAPI_GRO_CB(skb)->frag0 + offset;
@@ -151,24 +151,17 @@ static inline bool skb_gro_may_pull(const struct sk_buff *skb,
 	return hlen <= NAPI_GRO_CB(skb)->frag0_len;
 }
 
-static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
-{
-	NAPI_GRO_CB(skb)->frag0 = NULL;
-	NAPI_GRO_CB(skb)->frag0_len = 0;
-}
-
 static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned int hlen,
 					unsigned int offset)
 {
 	if (!pskb_may_pull(skb, hlen))
 		return NULL;
 
-	skb_gro_frag0_invalidate(skb);
 	return skb->data + offset;
 }
 
-static inline void *skb_gro_header(struct sk_buff *skb,
-					unsigned int hlen, unsigned int offset)
+static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
+				   unsigned int offset)
 {
 	void *ptr;
 
@@ -178,13 +171,16 @@ static inline void *skb_gro_header(struct sk_buff *skb,
 	return ptr;
 }
 
-static inline void *skb_gro_network_header(struct sk_buff *skb)
+static inline void *skb_gro_network_header(const struct sk_buff *skb)
 {
-	return (NAPI_GRO_CB(skb)->frag0 ?: skb->data) +
-	       skb_network_offset(skb);
+	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
+		return skb_gro_header_fast(skb, skb_network_offset(skb));
+
+	return skb_network_header(skb);
 }
 
-static inline __wsum inet_gro_compute_pseudo(struct sk_buff *skb, int proto)
+static inline __wsum inet_gro_compute_pseudo(const struct sk_buff *skb,
+					     int proto)
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
 
@@ -422,7 +418,8 @@ static inline struct udphdr *udp_gro_udphdr(struct sk_buff *skb)
 	return uh;
 }
 
-static inline __wsum ip6_gro_compute_pseudo(struct sk_buff *skb, int proto)
+static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
+					    int proto)
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
 
-- 
2.44.0.278.ge034bb2e1d-goog


