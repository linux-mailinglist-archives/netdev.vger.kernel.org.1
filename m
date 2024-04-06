Return-Path: <netdev+bounces-85436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C189ABEF
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 18:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B385B1C20E0A
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D83BBEF;
	Sat,  6 Apr 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzmQoH18"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311E3BBDE
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419709; cv=none; b=tJcLzmTLCea5MgiPhGxQc0/pbocEgvjZE3lRsWWfYRZYQtvy7ycYGSh1kp48WRq4SjRodMquKYKYVnN809/hlBSUV+lCWd0099vI9z0nu9QV3c9/8Pmzxj2wfliSlk/aFujJU6NbpzWSTSgWgNL92FZfR+4wsrDESTpeCdNHwpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419709; c=relaxed/simple;
	bh=vTNGd7GlQFlmL7fk9IIxTXxwjqkKhfwH3ra1i6ezJvk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t2/QH6OFlmhZsfVn7MUORJfBdIzF0k3+HrHKQwlkq4573fYzelCSWj02PgIPGn6NnDwL/6pDB2sSQB533OzPWLBuXPxriPrQvmF09HyapplrcsRXL/MO++EbWv5jcvv253MIN/2TTDnYiaIjxfT4n04SLZVXQnI1jgFPOxdO4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzmQoH18; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61504a34400so51805387b3.0
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712419707; x=1713024507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PKZElC4x1HXDbWUPL21kWttnUchzm11pjN3JykcEkpg=;
        b=WzmQoH18/JyvqfJeAV+Fk83ISoT+b8E4VvK+aUwqvkkMkjTbuaMcPlIoIZ9u9Fa8az
         4L/Di440FxVaAiAkICHzsNNTnCZW/FBHipHOCZK1k1o/Yrp8Zfw6RCMPmWBFl5MF9SdA
         5aaWYf49r8V+fJcrjVQfpynAwRQ4b6X2ttn9gu16WM/+AQINKqWoFHRQBmYFJWHG4EzD
         pgVKCmqEqEiO1o2RXNXlVOMnDkMtkAkuE5VaH51guCo7uuUIni6pT9bF8m5c1n6E+uyZ
         SxWy/a/wR8BFVw6CJUBp3TbQXPFkXMGjB7JahqfyxugzI6erRXk8nAJkRspSLrZ8U07E
         UtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712419707; x=1713024507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKZElC4x1HXDbWUPL21kWttnUchzm11pjN3JykcEkpg=;
        b=knX0MINu8JzZY4/wVBw4qN5f9t8/45qV0Can+2HNXZuvtr9FSxIIOYRjCgoSne+h7Z
         2MjYaUu/FxZNUxtgTY92Hl9CICwrMyNSaWELVEnyw+qDr3Vt/NV8PMtmnw7okBTzEjQV
         ocMHnKR0bnpPl7DWb6KBbgnmG0yx4ieswo1qcqledlcEjWknVPgvkXtM1zTbO+0g67co
         Plq69aX0PDeS4F/FR5hqc0a6lUhdCRN9Ch7oBNpOyo01bmP7RYoO/Gi08lmS1ye7tO6Z
         hAUArtKGCVbthNn59XveRyN1aHxoVTBk6zIwtHrLL77BiLydvYhGGZC72D2Y5HEMcKyB
         5J8A==
X-Forwarded-Encrypted: i=1; AJvYcCWTe8WqnVgHieUGPtUiKbflYudCYQYFN99cR8WxZbrBPUpd6btN/Iaz3u70hn5YM/wit1wWI/r1eCg4Bewl4HC/4IvcpeAq
X-Gm-Message-State: AOJu0YxQqRmVZSqoysATLSIpwjJpJOn8dZfGZOx3SCIiTruRaY/6oXXV
	vqPsB3K17a2SAzlP6QlOBu3zwtaLgPGeD1sp76/hEumCVr9TI24Ds1oNx3rSbec9ATsXZqQzCHL
	RGE1RPiyttA==
X-Google-Smtp-Source: AGHT+IHGJeXfe8kAgFlVq9V4SBtBs0jkgLXJNAbqm3iNTHzZb1PiRExauQVI6GP4bORLt1/Az/gyAIUbWFU/xg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:6003:b0:615:2ae1:6cd3 with SMTP
 id hf3-20020a05690c600300b006152ae16cd3mr1006623ywb.3.1712419706843; Sat, 06
 Apr 2024 09:08:26 -0700 (PDT)
Date: Sat,  6 Apr 2024 16:08:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406160825.1587913-1-edumazet@google.com>
Subject: [PATCH net-next] net: display more skb fields in skb_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Print these additional fields in skb_dump()

- mac_len
- priority
- mark
- alloc_cpu
- vlan_all
- encapsulation
- inner_protocol
- inner_mac_header
- inner_network_header
- inner_transport_header

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2a5ce6667bbb9bb70e89d47abda5daca5d16aae2..fa0d1364657e001c6668aafaf2c2a3d434980798 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1304,13 +1304,16 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 	has_trans = skb_transport_header_was_set(skb);
 
 	printk("%sskb len=%u headroom=%u headlen=%u tailroom=%u\n"
-	       "mac=(%d,%d) net=(%d,%d) trans=%d\n"
+	       "mac=(%d,%d) mac_len=%u net=(%d,%d) trans=%d\n"
 	       "shinfo(txflags=%u nr_frags=%u gso(size=%hu type=%u segs=%hu))\n"
 	       "csum(0x%x ip_summed=%u complete_sw=%u valid=%u level=%u)\n"
-	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n",
+	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n"
+	       "priority=0x%x mark=0x%x alloc_cpu=%u vlan_all=0x%x\n"
+	       "encapsulation=%d inner(proto=0x%04x, mac=%u, net=%u, trans=%u)\n",
 	       level, skb->len, headroom, skb_headlen(skb), tailroom,
 	       has_mac ? skb->mac_header : -1,
 	       has_mac ? skb_mac_header_len(skb) : -1,
+	       skb->mac_len,
 	       skb->network_header,
 	       has_trans ? skb_network_header_len(skb) : -1,
 	       has_trans ? skb->transport_header : -1,
@@ -1319,7 +1322,10 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 	       skb->csum, skb->ip_summed, skb->csum_complete_sw,
 	       skb->csum_valid, skb->csum_level,
 	       skb->hash, skb->sw_hash, skb->l4_hash,
-	       ntohs(skb->protocol), skb->pkt_type, skb->skb_iif);
+	       ntohs(skb->protocol), skb->pkt_type, skb->skb_iif,
+	       skb->priority, skb->mark, skb->alloc_cpu, skb->vlan_all,
+	       skb->encapsulation, skb->inner_protocol, skb->inner_mac_header,
+	       skb->inner_network_header, skb->inner_transport_header);
 
 	if (dev)
 		printk("%sdev name=%s feat=%pNF\n",
-- 
2.44.0.478.gd926399ef9-goog


