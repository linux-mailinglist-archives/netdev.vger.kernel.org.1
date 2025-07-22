Return-Path: <netdev+bounces-209109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDDB0E532
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C257B4B3F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BA9285C91;
	Tue, 22 Jul 2025 21:03:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF41DDA1E;
	Tue, 22 Jul 2025 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218180; cv=none; b=e1FFyV3LPCF2i4EsscKs0etJlNjm2JYgFZVxtwMYICBm0HRlxo1XdD9gKVpWq1BwoGqsIbNnU03aSDKHd65t8muu5WKV9vNT+Z896iQU3Mthn/VGIIlaqO1/tGLoqyUeolxa9z33bYiQ7RABf9RXdQzlamUxklQ6Ojkg2OYXMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218180; c=relaxed/simple;
	bh=E0D//Lllffocn21w8dN1gM6AVbghal6Bi+dO0ieemqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPxPJ6Z0WgJWvjZvnIDw4ex0HfK65y0SxE2x+VL3f1cj/XSC6OThMYyDk+w6dOfCZLxKsZ8TEl+hpIalR8qlrj1w1qKbP2/vb5goZ9UZC0BI+5W4LuDoINg4PvJ+ezyJr/jqqPlSD/I+wnU1tDa0biTOmSYXCFObaSJImkI5srU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234fcadde3eso69478125ad.0;
        Tue, 22 Jul 2025 14:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753218178; x=1753822978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVO5+Ety+ghsfIfSBnPYYSDL6rVLioQ1+bUs8K6RMeI=;
        b=iIYZv5X7eweQwcpN3N7dJpOjeJH3cdTOOJd+m3sBcGjmj3zNiiDOd0S4AkqQekoXex
         u0AM1U8PzoXZ7lrKmfJpBmYTvfaBbIDtMfVpAO27AahYqR2E67NJZ0SKZPyOJKNCNtAV
         30s4tIFugegLMe0zVE+D8emtVwoyqZhitqaPo/gxaoUgHD2wuBx9qD7VbHbBSaXnHL9m
         XDII7IMcixD+HpiUohJ4yDdlnWWo6tjzJNw/bzBybs3uahKoAD7ZnvcRzSG0vfm2GOPi
         +liPUatLj+4MfNaBEcOSWhHynicQ7GaDVH0K7fi6EuQpNIz8JHKYQ43euIKmV7tCjRgC
         4f6g==
X-Forwarded-Encrypted: i=1; AJvYcCVcNe3ISoHfElVY8yGMrGaoOpyG+d/GdJgHZg0+VfpN2BalOMzVBv804x+HH2IB1ygV0IToiSlXMV9gQ5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpB08h6mH3EklNhKqtlICRYfOK2XC4wQxbZB70iS2/+aAOZp6
	RqA48bg1zBLx7/pvHM+C/UEoSL/vGSymZOCcDFSNUO0Cc9VZebp2pV9G1Z0j
X-Gm-Gg: ASbGncucMmnhh2d5xQiF/8OXHVuTq6kj4YnQTCXIuz+nmMU1MHNyK2LrHNe94IdwrlT
	v1k77nbzdQEcaigbvZGKHgseMXZscSR0+vBcQa1/HaSrFB8wLLMFgADr7kUxbZAIJtWWPSjcI7B
	gnTdVW6xcmDcij978wYUIkJIpuHu1ELfLj8WUjkHn28y6b9H1FVjb2d1AUCfMHk7A3PCpcx/1Fk
	EpvAf0Hg+5fWM/SowCw8j6imdpbITZRvAt9jQ40P5lvqYyxfsBhkf/6hK53BQ/F8dyWBNLpmIP4
	o9fKicoDTQt+dP7yHBA7uSM6pxzgRhIYOeUhNvP4N46mo6QVVECXN7G8WJJxnttDZvr83Vw4HxT
	rI+1ugGSOFcagkI5asH/AaEqD7hXIxwW05+oEl1B69pyjW41MZeQ4qhsyXxc=
X-Google-Smtp-Source: AGHT+IGwmMMgy9wwkuMbllwygd7KwbV5KBfB1B6APxMb1/7rLiL2gEk816iLcO7Kl9M/emxiP0Rxuw==
X-Received: by 2002:a17:902:e84a:b0:237:e818:30f2 with SMTP id d9443c01a7336-23f981d33c5mr6218065ad.50.1753218178275;
        Tue, 22 Jul 2025 14:02:58 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6b7891sm82163855ad.115.2025.07.22.14.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:02:57 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: Warn when overriding referenced dst entry
Date: Tue, 22 Jul 2025 14:02:56 -0700
Message-ID: <20250722210256.143208-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722210256.143208-1-sdf@fomichev.me>
References: <20250722210256.143208-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WARN_ON_ONCE with CONFIG_NET_DEBUG to warn on overriding referenced
dst entries. This should get a better signal than tracing leaked
objects from kmemleak.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/skbuff.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5520524c93bf..c89931ac01e5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1159,6 +1159,12 @@ static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
 	return (struct dst_entry *)(skb->_skb_refdst & SKB_DST_PTRMASK);
 }
 
+static inline void skb_dst_check(struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb) &&
+			       !(skb->_skb_refdst & SKB_DST_NOREF));
+}
+
 /**
  * skb_dst_set - sets skb dst
  * @skb: buffer
@@ -1169,6 +1175,7 @@ static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
  */
 static inline void skb_dst_set(struct sk_buff *skb, struct dst_entry *dst)
 {
+	skb_dst_check(skb);
 	skb->slow_gro |= !!dst;
 	skb->_skb_refdst = (unsigned long)dst;
 }
@@ -1185,6 +1192,7 @@ static inline void skb_dst_set(struct sk_buff *skb, struct dst_entry *dst)
  */
 static inline void skb_dst_set_noref(struct sk_buff *skb, struct dst_entry *dst)
 {
+	skb_dst_check(skb);
 	WARN_ON(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
 	skb->slow_gro |= !!dst;
 	skb->_skb_refdst = (unsigned long)dst | SKB_DST_NOREF;
-- 
2.50.1


