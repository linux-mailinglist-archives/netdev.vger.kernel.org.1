Return-Path: <netdev+bounces-225616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05071B96145
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBF43BCB5E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646A1F2C45;
	Tue, 23 Sep 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESwKgd2D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB51F30AD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635305; cv=none; b=FD+WnEyy2xagoFLa5cuCKgDuYKD+ArsUvIhwGkG8TotNctYhCNDqoAO8cWRLahc0WCi86esv5B49ARotlDdRdysTsprRqsjiAID6+Clc5thDJM6VoXUZsPdvv1IlZXdrRfz+0bESEzvMpGnQlQwmbOh9IN03u7V8JlG4j6O19J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635305; c=relaxed/simple;
	bh=HecwYUyrid0xMGLMnbC+ufAuUXuusGNqgcgYugb9nXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8gk2E3aZAF+A+KicV1EQhvdC37tL+0tFO/gIQXVcwDR4KYW5kJBGSvIggXhPVsLPHqDZapcEJIroiJFwD7PySrg72rjxtgPUg3ZyotOl8AYiJYvlFz2ub0Akk/eMz28v65SmCeIo2FZ5lUegPeZC3/Yc9+FP7uUVyNhI3sKAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESwKgd2D; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso4623156f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635303; x=1759240103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqceO+LaStJ322Q7yMtxuQJ1IFb3U25G3RFZku/rYxI=;
        b=ESwKgd2DepNM0U/m9YOHtMGudX63NIbqeEbyS33rtdTqN8gnBWR/c7Q3EIkMBHyuDw
         lY8MVrZQg7csPCrdszMjmkQZY2wcME+HjwYSD16E9yYggQEQKZwZvXopgl8q/p9UQQrU
         Qylgal3ZV6gXDs4/uumcIGALmVno8sOcSHmIQ0BnTZdMQHyLbeeyCJRK3FyxTZvCQETz
         hafvipIIw+V52/Fb0jnbxpRzG6CaDkoZsaV6P22eqR2px7eAsRPrfD9Rl+6LlOl4CzPz
         HMzrwE5kPkeEKmvmZSHuFI++Yl5vRywtKQNrq7yyFwcGT9CTEHMAr5mfvf4tbJULuB2R
         YaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635303; x=1759240103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqceO+LaStJ322Q7yMtxuQJ1IFb3U25G3RFZku/rYxI=;
        b=ajriSu8XRBSSLd4g96Wr8Tv0ptEU9dkrCCcN+/WN9xHuUoX1LQuNxTQJwMHngA9Q32
         pwSJDaHt1B2pMbBdGPRe+0WbrjZ27ivUEAvVPPGbaNE5BswftvdjfwKbV2M7FvJ4d1v0
         7sB0p6YbN0TdvWVvqjjZMMjag+sb8FtxVTn5b11qVmAEIlkcKu+YXFoPuqX1CJFnu6On
         85SgLQHbYHYl+I/UZmthP/nYUpN7MqtMPZK+qTO6OCRz3kklv7s9dRXUaErv3Edc//Sv
         pHfY2TLSDJ9Ku8rcnvn0yZN8ovdFBSVPSDqZI6Qk3KjJS8XmTN+Mz/Am6XEwe/Y5FMqA
         otRA==
X-Gm-Message-State: AOJu0YxgkNJZLifNBjLyCvrIaHVALJYXx+l+6L1VIHwBTaC4FybEhHTb
	tuDWMGXkVJw1kmSeEUei4oe1CsZxHaV90+ztAdKQh9ymBGVNDbdQRdvX
X-Gm-Gg: ASbGncs/pbHoOC2k6eU+og01Ac6AC0a7Kw3kOqf399fZ4v0Rinld5To0dWjjkXldrfY
	dLpOx2cW0iLvdDn7b24HKn9LC4pkRCtmXxFESu9pNkkobXY/FvzKv8uZlkvILrC86NZeV3N8z16
	Mp1qC3nsktusa5i4imuHKEDs2gl62I8Xa4mgLcN41by0mZm1LpeLO/v+Zp9K4W3gXkKrquqCmJg
	+lgWST4ITU86ifq3ffhqDHOTNyFRKOwXOfZvt+oYs/iHpTje+fuWlV1qLwYzddnBM81T2JO498Q
	hKfQpMDRAzUWP05c3xPsqV2s+t2jWFwyLCpUcY0RnS8NwtCCn+qFDbc8Dcc5G6Dub9fORpBVNUU
	OOPdNh1DskoIqOHlyw4ArfZppWfKoeU3AXhVqnKx4+WahCL73EPNkwO2U3uw=
X-Google-Smtp-Source: AGHT+IF6mFtV8xDhlf6PKrdbXlR0gBCKFvrcTqDC+frIILdUqOUx3P1iZIy2HedbxuT3id4Z09A31w==
X-Received: by 2002:a05:6000:2f87:b0:3eb:7f7d:aefb with SMTP id ffacd0b85a97d-405ccbd73damr2499840f8f.53.1758635302498;
        Tue, 23 Sep 2025 06:48:22 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee073f3d73sm23742602f8f.8.2025.09.23.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:22 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 13/17] udp: Support gro_ipv4_max_size > 65536
Date: Tue, 23 Sep 2025 16:47:38 +0300
Message-ID: <20250923134742.1399800-14-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

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
index 0c40426628eb..0ac03f5596ac 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2643,7 +2643,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 {
 	struct sock *sk = NULL;
 	struct udphdr *uh;
-	unsigned short ulen;
+	unsigned int ulen;
 	struct rtable *rt = skb_rtable(skb);
 	__be32 saddr, daddr;
 	struct net *net = dev_net(skb->dev);
@@ -2667,6 +2667,9 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		goto short_packet;
 
 	if (proto == IPPROTO_UDP) {
+		if (!ulen)
+			ulen = skb->len;
+
 		/* UDP validates ulen. */
 		if (ulen < sizeof(*uh) || pskb_trim_rcsum(skb, ulen))
 			goto short_packet;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b1f3fd302e9d..1e7ed7718d7b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -924,12 +924,15 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
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
2.50.1


