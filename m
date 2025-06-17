Return-Path: <netdev+bounces-198681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2BAADD071
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C61A189A574
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E62EBDD7;
	Tue, 17 Jun 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ5YycKn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118A2EBDD0
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171377; cv=none; b=U3XIfOO8D7hdXJnWgc+f5BfI6qUuNxkDQOzwMart1VEBuQVUpVRJs11qiqc/4R2YZeHq88siNdlkDexpdpyMoIZzPNlDNIhM6KDmzFoarzISVcj/JCPMK6UvF+xucksJRqV9YFLBe86SYyUYxOajr2I2jRRQmZKdymivLW20DzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171377; c=relaxed/simple;
	bh=IkdzTDOnCVz+pp0XXy5lIUtkl/UdLE+N42T889pXOvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXfxSRyZlypzPwTGaweZoJIQ4k5oHI17ooV17cHUzfO09QSSeY2DEoZ+mEO/wRyELYWIJkv9545en3DFA5IBOmqmBL5fmHS67+qqpN95l85g9BkxRmXAancXX00CdepFWPY2FJiKpvrVGN/64zNlvfyULYXtUbAiPEVxDiTedy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ5YycKn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so10360874a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171374; x=1750776174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1CC0lezYqaB9rAs8sazcxq/muZtdyXXodE6LVJIx48=;
        b=UQ5YycKnupbZIOX6VKXatyw9hhmNrBiOsJssAaPEZhIxLtPfQ4rHvZRK0BonVEvYFy
         rCbT6oy0rSfd4DewfYynUi0RgPlKXvQNtZvgRdlI/k6nbLeo2K32IBmWjkuTN+Kbb3IE
         VdDqFMv/eUtDceMO3qXNHAdRcZa1At+haJca2NFyeOitXshoinKw3ObEBsgAymK9wLQs
         A4xgnaH7EdMY2KQA/j36ITizrpZX/fc0Ei8uWu7v2baw/09MvGJZeqcDx9qmw/hopQbs
         MiHcmJCL8k7V+Z8I8MkzHVVVDEFMxNHsRX7m517pTzctmniAllc3qOzoo1r4ybgFn2+I
         GuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171374; x=1750776174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1CC0lezYqaB9rAs8sazcxq/muZtdyXXodE6LVJIx48=;
        b=rhXEpmUQO553iHXooRiKgBmZd03fUvIs2EtaLFMbm4Re7zW18EBDpH0Q0xCEOFTdRv
         WPurh428KkFFxw3CqnxRnIV82HI75ZvO76Uvp/4ou8fyh3YkPtAo6SRb/QC1D1/1NX5V
         8DHeppHncG+VPQwkcGssiSIWhnMa6SUAcdA65a/bjCMTfkTymkmDD39CUqg4/veqPwkk
         gaWegyVLM9/AmynfgtGq7+hVN+9iVjayzn0TE62U/iNEGsu95sFght/bY9RHP8M2kChB
         eVmM1NC/gesuB/5xvGbZ8CmOAq0ueTbA9suTq4hxQHbEyQiHCfxCIN8BRQdI3kyrXYXg
         SCVQ==
X-Gm-Message-State: AOJu0YzSVdwz3RMa2BxsVGgOvvMhoEAkE0a9cfJH3eDTGxaD70IcQMet
	eVh0BM5I+JQ7oRcC+FnmXYqFvhSPPYALjhSBdYNAV7HS07H/0qPjsEN3
X-Gm-Gg: ASbGnct6CAmVaPZrn6jntY5xjyCdHiImjmpgPA/xid840VY80fUO0fglUzOnL4fyJGP
	xHwmOJwWshXF/OPfXElJ89cbB1k/tp04hn8aX9VsPjvMzgcB8g5VuoQmyr41rwxLM/84P26sdOs
	C//YZy+I7DxorHyNMrKsKWMxK5Ladskl9SfA/0UWStkFPAU8yYT3FGexZMQ7zm9SVl/YR9i8eJN
	O4sFIk99aITba1G81XfjWF3fOGFGBwr6iwMZx/TPZlvXj9faoIEU7xVUhh1B8xfQCqDDx06x4aX
	RnVZDeImhMub3rcY07ADl8K8R/mw5P4HsPjDJukfK2L+3Qqf3IqzAw5PBMedrSYYetwLAyZQ04C
	jnWIvuqVLebOK
X-Google-Smtp-Source: AGHT+IHBjTUuyMMzqazEb2B+Jsr46hhBJsxTL99wfi537PzNjRsBIrDDIPwrbnL/foK47O/9fXqSRw==
X-Received: by 2002:a17:907:e8a:b0:adf:86df:de9b with SMTP id a640c23a62f3a-adfad329db8mr1297369866b.16.1750171373948;
        Tue, 17 Jun 2025 07:42:53 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec88ff249sm863051066b.82.2025.06.17.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:53 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 13/17] udp: Support gro_ipv4_max_size > 65536
Date: Tue, 17 Jun 2025 16:40:12 +0200
Message-ID: <20250617144017.82931-14-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Currently, gro_max_size and gro_ipv4_max_size can be set to values
bigger than 65536, and GRO will happily aggregate UDP to the configured
size (for example, with TCP traffic in VXLAN tunnels). However,
udp_gro_complete uses the 16-bit length field in the UDP header to store
the length of the aggregated packet. It leads to the packet truncation
later in __udp4_lib_rcv.

Fix this by storing 0 to the UDP length field and by restoring the real
length from skb->len in __udp4_lib_rcv.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/ipv4/udp.c         | 5 ++++-
 net/ipv4/udp_offload.c | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index dde52b8050b8..6200e09d9a37 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2642,7 +2642,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 {
 	struct sock *sk = NULL;
 	struct udphdr *uh;
-	unsigned short ulen;
+	unsigned int ulen;
 	struct rtable *rt = skb_rtable(skb);
 	__be32 saddr, daddr;
 	struct net *net = dev_net(skb->dev);
@@ -2666,6 +2666,9 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		goto short_packet;
 
 	if (proto == IPPROTO_UDP) {
+		if (!ulen)
+			ulen = skb->len;
+
 		/* UDP validates ulen. */
 		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
 			goto short_packet;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 85b5aa82d7d7..ee12847a0347 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -930,12 +930,15 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
 int udp_gro_complete(struct sk_buff *skb, int nhoff,
 		     udp_lookup_t lookup)
 {
-	__be16 newlen = htons(skb->len - nhoff);
+	unsigned int newlen = skb->len - nhoff;
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 	struct sock *sk;
 	int err;
 
-	uh->len = newlen;
+	if (newlen <= GRO_LEGACY_MAX_SIZE)
+		uh->len = htons(newlen);
+	else
+		uh->len = 0;
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
-- 
2.49.0


