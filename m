Return-Path: <netdev+bounces-225607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8360AB96129
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BA019C3C8D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494A31F4165;
	Tue, 23 Sep 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAKOD0AV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162E1FFC48
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635282; cv=none; b=QlbfyPMCNl6iRFpq16EoyThMuuoj3SnCjTme2Hati4YWcd4zBm8slXNx58uj8QP22kTv+KCa0s0xlw6uzgOoRSaR9bzMaQdxhb6FjsousJpmGcfKpPL97jaDQyCqQo7Cyy7BuDFEksJ4nGUZKpxkavfUIWTdQMavglsLFIy2Zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635282; c=relaxed/simple;
	bh=2Y1/2ihY8o2FQQ9ZuAAQlF/ueUF039KEDpMosDJsv8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQckfzwP0ayDyEsqXEw0qs30c+VDXecXskSCNZx9iTB37mpDDtgqR98qv8AiLUCg4SBKGgLHFTKbB+TaO79v3k8i4XFgEyqVhms5H5ksG2pI5kSOuqw5ypXLQeBVMqFZ5z8KMjyRTpURqtT/s4c8SHY24JdJoiyeLjO8+d/o8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAKOD0AV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso1898225e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635278; x=1759240078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BreM+5rfdgBZgiqUgdbmY/g4daNFsqWrYaUkHcBqRs=;
        b=GAKOD0AVAldi6N8HMIczGiycf2mCf7HZ8TQ3rq58kEqfGGYi3hp/N9SbGxLt4WLi9H
         EO0SGGuy7QVlwU1a6uFNXo5oG/rFi97FyEz5gVjapIstvtXv2iv22v1KKmRVWimJGw0Z
         S9/Fh5kN6XjueThvvpJwT3O+V67c2kDLZxNIjNUkbvvWO5+G7hBxttMxcFv6qeqsL5Ky
         4fcGfSmo50HNcUD7NdSIO8KBRKNU8ssMos9vCBC0fV+hmoF5DTQuFx774dmZsO9XiJk6
         mRpDNjY8lCcbfoCz4f1PJmLDl+cCcBRr/GMJKnHQ+DZkr1g2KsVon8HpuSCP+1zBtQe/
         QIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635278; x=1759240078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BreM+5rfdgBZgiqUgdbmY/g4daNFsqWrYaUkHcBqRs=;
        b=sNxfI934dwSxX7rLfCIr2JO3KEhM6K7Mu0THI7hQ5WD63pp8cYo28xnNLedIuMVSTk
         3giLhca9t8wI/2U9u+qiA/7jV1N2jR7jXJ8LAmEFFl4xMmB3rdEt0sHz78obQGuAgAqA
         2P/1c6U3XIVZBWSQnidWuovmRDr0yn2lBsWRu/3pGt6M/KTdY9+MZ7ywrYgAwD5HmtgY
         BP46n0N0ENFMgqa+qGE6hMyI96qOz5UCrmUdTJplWjawgHf0P3nhaGF12xsNGnLBuRzP
         xrMZhezHMQFAk57umxs+G6DlvEc9neXijTuWQ/f+AO+fu3baehj4gCDgWNYE347sbu50
         Nk1g==
X-Gm-Message-State: AOJu0YyJr3chz4VoeCn01/GhonJhlPRhRXyNdBUVl8vcGW/FqNbVW/aB
	qKfXO9d1zcGPYQ2TO57eL1iZDIapI7p+G6omUjh6ErRO0m7trYcZZ+GP
X-Gm-Gg: ASbGncux/oxeO3HCaral0f5Odz04Hq7ZDALO8X3o0AVDnsaRbFtkqBDDkmkVhsHk2W+
	9PJZjc6sKF6O3RYOm0rObrx6AxUHGeptDyXcGzW1awBWoHCxc/SbcxlSVpj9PQ7vPD1gWAtgSRV
	p46wE0was91UJLh0IUChhNPMQIO/N0r3RjDfhzoO+7W68eQYByVYLwqPQjjjaBE+TbfsnkG+qfN
	z05/JIbJr/nchKpS6QlTfJUMsF2JY0FRRmAeCfOqimAFm6ZMplLTDKQT+eWMwfMvFR794vNfVXS
	zJJmTW8UmYc4ez1YyjKCQ4geH67EzYFo2a+0ZXQ5cz3JbIvLXrEEozcCMHkRb08EuqiMPvGSukG
	axoiHxKsEOoPSyBCh22Ll0CicERLgHPUE/PQqhjpqYHGRepWyLbY41dvcq8w=
X-Google-Smtp-Source: AGHT+IF3kyRkqBgO4u/fkoOUBfpl6EeCigTtTBhRQNeEXNBMGsWeeTffU8YURj0Z6Tyn4nBUKRcwvA==
X-Received: by 2002:a05:600c:198f:b0:45d:e110:e673 with SMTP id 5b1f17b1804b1-46e1d97d668mr25998155e9.4.1758635277942;
        Tue, 23 Sep 2025 06:47:57 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e20a3a3a3sm22471185e9.19.2025.09.23.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:47:57 -0700 (PDT)
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
Subject: [PATCH net-next 04/17] net/ipv6: Remove jumbo_remove step from TX path
Date: Tue, 23 Sep 2025 16:47:29 +0300
Message-ID: <20250923134742.1399800-5-maxtram95@gmail.com>
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

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the GSO TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/core/dev.c         | 6 ++----
 net/ipv6/ip6_offload.c | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fc4993526ead..c7a4ea33d46d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3787,8 +3787,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
 	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
 	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-	    !ipv6_has_hopopt_jumbo(skb))
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;
@@ -3891,8 +3890,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index e5861089cc80..3252a9c2ad58 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -110,7 +110,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct ipv6hdr *ipv6h;
 	const struct net_offload *ops;
-	int proto, err;
+	int proto;
 	struct frag_hdr *fptr;
 	unsigned int payload_len;
 	u8 *prevhdr;
@@ -120,9 +120,6 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
-	err = ipv6_hopopt_jumbo_remove(skb);
-	if (err)
-		return ERR_PTR(err);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.50.1


