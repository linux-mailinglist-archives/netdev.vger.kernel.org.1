Return-Path: <netdev+bounces-108266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F491E8F4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B109D282FAE
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A807D17108A;
	Mon,  1 Jul 2024 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="aG8APn6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A017085A
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863741; cv=none; b=piXnwkYIt0fUNJj750QIGVVodpYznPyuz+vbSDKkDnNoLGKCyJ2k2hXgxPtaBbIp8zD8ZzQVW6MUNlEQOFwpusf5oAqHO/B8cc5G860Y6/Vc/pMIR/YigTd/53cMQiS43ER5YHLDVGalaMZV4lLyMkZbiG2yLUERGomJsXHbEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863741; c=relaxed/simple;
	bh=8/pFF11Z3KOiR4xQOxoh/MwK7AhPgQ8WdN0Mbaaew8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjBUhRe93GdRPqMAvTp0/qeO3pHSn61Vvwo/LoMZcvzv3vIfrp1yH2r9k+MEVCRW4QsKkI1EJFPqBG1Xq+sx8WL4C1lNk8IejrNgkLDVIPderoq7Y5UXGu0zJQxvCxIjruy2zXHN4mt/lBrdUPFEeheYeaiAnoDi9ltapM4X5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=aG8APn6T; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9c6e59d34so27534685ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863739; x=1720468539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAIOpAMqiMCAKIQhW4VVXKTt/GHh68CBtrTOA/aQ9pg=;
        b=aG8APn6TuEMNqQcYYZ/LMxPKF95/qKkN9pq8j+h+KTmH4ymlU+irjhzunOsMInTaqc
         pZx73UMaMnjUjDqkXHgTXg5TMLlYrXLcP3Fe6oDF0TJxEP6NY0tE29nrtdn6nizikIns
         qMeHu4MUznPhqw/S4YcloFVxBPmvmNfVoxcfrHT+JWbLt5Lo3egit+JCU4olqbUNN7Hn
         7SUBnDMAMmSrOu5zeS2w0Dp1U0G8UNfrStihHFNe4c/e6UlZT26nH7e8OWi+fuIWL6gN
         wrbEgI+3jGgyEjPmHV4d5omCXF+6QF/RLNwHnK5A7WxUvgaPIw8rpXB3/d4DQPLH2xHD
         ZsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863739; x=1720468539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAIOpAMqiMCAKIQhW4VVXKTt/GHh68CBtrTOA/aQ9pg=;
        b=qYfqQrkDqxS6i6L8xfHmheFA+svk1ib9q9gAhXudzbDosbObHn8hS+rZ7fGGjrI9MO
         s8OO/kIximecvMsB9tmrkbeFxxZ5IgimdhbwThbO6psiUHN3C2+eFnLnifEOLfXjfcTf
         Y1DWXvHHqZf7Yk3WRU9q8atYD2DaQI9BIMHO9rY5dnKiOAduAkNXjrwpFLgu3PoAJOgP
         yA8/fXOdlKnDsFCkM93ux/h4r0gDF1s5GbYKd4wwsmrlrx29PGfyBv5nKnq8kg+YILd2
         0SJ0FFjZwcEztCQkF0+G6Z7K2PcFuBeOR/EdWDOcbtEoOb7jmYZ4bCpGA3TU+82xHXtV
         CnSA==
X-Forwarded-Encrypted: i=1; AJvYcCUFUNAWj3AqNhkb/H/cEiXjTUIGmn6wtrBefy/hCtdqGWwbEVrR8TSMJlN2zxEv6/CsBOMaGK2EAbpke/Z0uEVmvlFGwSpU
X-Gm-Message-State: AOJu0YyrH1yvTncST4LGwQAvHiqHLtWPYzM27BO2GaPbBG4maVGqyyhx
	Wv+wctTI2oMREVVjwNh3SFFkNgnFIMKXsBsTfkRAHgYwgPwLcNqxg9dfm2LJdw==
X-Google-Smtp-Source: AGHT+IHEHsOgYK1qej/Js39qLen6fK+luAcTzkkTG9I3fYo0wFFUoUN7Z6jzgU968IwoAzJB6Bn+VA==
X-Received: by 2002:a17:903:1c4:b0:1fa:4b9:d00f with SMTP id d9443c01a7336-1fadbcf3414mr73054515ad.53.1719863739482;
        Mon, 01 Jul 2024 12:55:39 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:39 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 5/7] idpf: Don't do TX csum offload with routing header present
Date: Mon,  1 Jul 2024 12:55:05 -0700
Message-Id: <20240701195507.256374-6-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701195507.256374-1-tom@herbertland.com>
References: <20240701195507.256374-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


