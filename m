Return-Path: <netdev+bounces-107982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA691D5BB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7600FB20C48
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F47DDB3;
	Mon,  1 Jul 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="e6b0Ff8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF8B663
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796892; cv=none; b=H74Zz7JEJGxnw+jX7D1h2PWoJKHNYqFF7VyQFp+ERgDyE+RoiHFWmKsfTuaYLJiauVTuEaHnbzqevGbux6e3rjK128maKEb3T1iz3pjqye96hWXdFqGp6iT5fzJthv++8XJzsUn0IgMytFk8BgYDDegF2LFT4yEIB8vuv8/TJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796892; c=relaxed/simple;
	bh=wif0J0u+OszYckvNl0pn9Yf2TVfSrCe634fBjLmlvA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8eM9NGKMZ6fV04TPHXYtmMQZAV5QgechQ0FeO71eVTuUwReLtTNSBnNkA341ccje7kQtMuc8kvQzKZMW73L3DETiCx5u+zEMWPjDrMXf+I4MptMGJ/1zpsBCHkyZ8CMdq1x+kbM3KgGG9FxXobO56xg06mek6YPNQMqwdzxnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=e6b0Ff8W; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so1054951a12.2
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796890; x=1720401690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vAVAXTRO3CNYNew1s5viXhPasACaseI44kQDWAlbhc=;
        b=e6b0Ff8Wlm5UUwBOVBNf4uolIW6GHAhPVvQ8xENJZcVsbtuRFMRx3HRWbcKlxnUrCD
         rKG6O6o4TJ9QU5sP7/7EwzZNr7N9KQ98zDc+0Nc+isvGifJpKP6JSbjfJrjHlohpYyZn
         4nCMF428YXsHnhc8mOycT+dEgXaJ8DSC0+cdSMh34gOYv9ncYU/M7oj+fQT1HIw+V1Uw
         kR8O+L3mH72pmj+L6Cs1pJNjCKXaBj1zB3RyQv/X0QvxkWge5lJrXKth0HMFf/orPEXR
         pKKixr8Y2xvbK5nr3fZqPaUrB+Lo2wQiHR2Mz1XJsU2h6WNSVfr3l7h+1ZXnlCnw5w4E
         N+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796890; x=1720401690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vAVAXTRO3CNYNew1s5viXhPasACaseI44kQDWAlbhc=;
        b=luXF29H+JrK5faO7T/QNl5en/ORdbTyzv0XJMvwhtJ01xa0At7GVrLps9OFPxbo8CW
         G4Dwj7n6ip77mnzi9uQOg50bU1yNNyOuNoK8Oa8Usl5uWDjFF/b/fXJDYYZBkcID7pXS
         m48lsn0AkTPkI1fMV61abQLwQoHK/JSVn96irAREcg9b6rDfD5A2j4YmiXKNSwpb9A4m
         8QvbBc9wrRnd/angEi1XS/0f/onbNughntFhI2gGO6RpW1T6o2xrfwtYIG08EOU6XBsK
         Pt8RR/8Ak+hL2mfV2Rqi7q5xx5hPxIu0+6qqMYLRLUj4WBe9ettxDstXYfw2B/KCsfl4
         d5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXaaqOtQPCfjNDv9/N8Bxoh9yhfuB12f8UHsYYC1WZuoQkTOPE88YcW2CHofxfwpuTNRE+IzjcxOQWVzN1nfBb1tyzPLq8d
X-Gm-Message-State: AOJu0YyAXrwX+hM2F/NZ1+6wEbmpRIgnL1Jp1Xjl9b7yG+GzJjx3zXPj
	yG00dxXXy83jRhyoRvvGqLdqJFRgtRhCSlFfv/lzpZN7+irlrQRtQ503N3mrEA==
X-Google-Smtp-Source: AGHT+IFUn87s2SThoTPnzXdiVkAN2+XxvMLqQUjGR80ZFzc70hh+Z3wNtZm6GufYj46vqfuZ43NyJw==
X-Received: by 2002:a05:6a20:258a:b0:1be:c3c1:7be8 with SMTP id adf61e73a8af0-1bef61407bbmr3534011637.26.1719796890341;
        Sun, 30 Jun 2024 18:21:30 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:29 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@sipanda.io>,
	Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next 5/7] idpf: Don't do TX csum offload with routing header present
Date: Sun, 30 Jun 2024 18:20:59 -0700
Message-Id: <20240701012101.182784-6-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701012101.182784-1-tom@herbertland.com>
References: <20240701012101.182784-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Herbert <tom@sipanda.io>

When determining if the L4 checksum in an IPv6 packet can be offloaded
on transmit, call ipv6_skip_exthdr_no_rthdr to check for the presence
of a routing header. If a routing header is present, that is the
function return less than zero, then don't offload checksum and call
skb_checksum_help instead.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 27b93592c4ba..3b0bc4d7d691 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -57,10 +57,12 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 			tunnel |= IDPF_TX_CTX_EXT_IP_IPV6;
 
 			l4_proto = ip.v6->nexthdr;
-			if (ipv6_ext_hdr(l4_proto))
-				ipv6_skip_exthdr(skb, skb_network_offset(skb) +
-						 sizeof(*ip.v6),
-						 &l4_proto, &frag_off);
+			if (ipv6_ext_hdr(l4_proto) &&
+			    ipv6_skip_exthdr_no_rthdr(skb,
+						      skb_network_offset(skb) +
+						      sizeof(*ip.v6), &l4_proto,
+						      &frag_off) < 0)
+				goto no_csum_offload;
 		}
 
 		/* define outer transport */
@@ -76,6 +78,7 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
+no_csum_offload:
 			if (is_tso)
 				return -1;
 
@@ -131,10 +134,12 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 	} else if (off->tx_flags & IDPF_TX_FLAGS_IPV6) {
 		cmd |= IDPF_TX_DESC_CMD_IIPT_IPV6;
 		l4_proto = ip.v6->nexthdr;
-		if (ipv6_ext_hdr(l4_proto))
-			ipv6_skip_exthdr(skb, skb_network_offset(skb) +
-					 sizeof(*ip.v6), &l4_proto,
-					 &frag_off);
+		if (ipv6_ext_hdr(l4_proto) &&
+		    ipv6_skip_exthdr_no_rthdr(skb,
+					      skb_network_offset(skb) +
+					      sizeof(*ip.v6), &l4_proto,
+					      &frag_off) < 0)
+			goto no_csum_offload;
 	} else {
 		return -1;
 	}
@@ -161,12 +166,7 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 		l4_len = sizeof(struct sctphdr) >> 2;
 		break;
 	default:
-		if (is_tso)
-			return -1;
-
-		skb_checksum_help(skb);
-
-		return 0;
+		goto no_csum_offload;
 	}
 
 	offset |= l4_len << IDPF_TX_DESC_LEN_L4_LEN_S;
-- 
2.34.1


