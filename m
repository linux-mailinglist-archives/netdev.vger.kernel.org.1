Return-Path: <netdev+bounces-107980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF291D5B7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C98281197
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0228BEE;
	Mon,  1 Jul 2024 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="R96VnkEr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98A79F9
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796889; cv=none; b=SnVH4jw7XJjf/xCblNwn2/DPS0YDuK0lTncrpAKMM7j2s2FaTel8po0qociotPvveTpWVvrvRuE85R9cCoK2aMA4kHEzJe6+33iWHbzmJo4JMUd954f9jt3S1Ls6wSp/XuFdgRZF2H81ZDbb2mNfmYs446oQaw46hTjKncWKGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796889; c=relaxed/simple;
	bh=7/4Lq6MtRNwh8HFYEIyExRTRZxYKzcnNgn00qYFVkRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qm8jFj8nYSYjLnWO4TsJQHPBm/lnM3zfyjXnad9tAmEVUod6JOWVPFMc9M+xb32qddieWUn3qbLwiwXkeFZdQJW5qK3JWF0QvfCiiP97ZF98JZyxVgHnvJnX3+BEcOnPYFDnmqtbBMKkANhpYA6Ux8uJXdXjWoK2FT4UVxMBIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=R96VnkEr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7ecfc9e22so1353522a91.0
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796887; x=1720401687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cEAYfC/pSHNYZfAgkJDsHZADd0LSeJUjHpSBEFaKBo=;
        b=R96VnkErGCed27YoXCgu9J0DVOrNNuMTq420FMKETMGut3EC4P56Dd/pwDIz3ZuEof
         A1y9NQkr0NXRR6qLT31eg0fKAOfazj9Yy859VUs9LRhx2EOWEbYT+ORmX4SGcqEvav09
         LCWRhxeMjdCGC5JB9d4sgUynXY0pkPB/K9Uc778kCDoWPVllsffXxIVLYZzme03CJWOM
         7QK9Pc1AvYsK0GjrJry5oZGgWRc+TwGyg91jpxg4DFIY4+x0QmvNlr/5LoDAUq0VFN25
         OsGCazGfZUinZAFDAVyBxlv5gQBnt4qgxbgEQygkUquMGjMq7wkyP+wqqs7Mf1TOSvs2
         mYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796887; x=1720401687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cEAYfC/pSHNYZfAgkJDsHZADd0LSeJUjHpSBEFaKBo=;
        b=CFXOeF+WwyytlMn1JLWH7X8NTuAf/qgg6VZHp75I2rRNA8JdEYakmgRyNn795wnEAT
         87tM/XxskabxUyjM5OmTgUiHoT34QHTwv1wOKFts9EB2wVR/4lyVkM7SJ16U1T7c2kvs
         tLbnlmA0e0Y1MfbaMi9cr8LWMedahHf0DQSiOVrEvJxky0OYP6yN7Q5iWbC7GgmBalUc
         X8qjTtftUvBqPXxYZmN2eOGFhfatIIyo8wnzgPZYzzRplxLZJTu4DXsb9q6TodRkmzpA
         RUaYJyW/jq8VMJYihbSMMnoVjjf47lC5u7guhVRVm/k1xIDU8v6nYKs2pynVREep8U7/
         /cjg==
X-Forwarded-Encrypted: i=1; AJvYcCUvFOxhr2GMi60pxF9kpo5+PhXewQR51/Yh27c2tzqthiG2essGz9F0cMR88UBYhnEKe9iycUcVyDx4uROu6utvGLleYYjZ
X-Gm-Message-State: AOJu0YwUHsk9QClGBGrbYFNyEMLfvDYOn6Pq+LLHf65s5iLxKRufhEjO
	gPOBR1JNLtl9pJn054IPhgODWWuknEK6AvNXV6E98S0hzwmrTjADdxoPxWjA4iLxWF9iSgMg/6K
	Ycw==
X-Google-Smtp-Source: AGHT+IGnDOzoiGPre9Plji8WTvfyNU5J5D2Vyuydhgo84cX0pup4HdtGNG1H8BSFvdlqPNTK7UPpfw==
X-Received: by 2002:a17:90a:ee56:b0:2c7:da20:5252 with SMTP id 98e67ed59e1d1-2c93d6eed7amr1911889a91.6.1719796887063;
        Sun, 30 Jun 2024 18:21:27 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:26 -0700 (PDT)
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
Subject: [PATCH net-next 3/7] iavf: Don't do TX csum offload with routing header present
Date: Sun, 30 Jun 2024 18:20:57 -0700
Message-Id: <20240701012101.182784-4-tom@herbertland.com>
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
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 26b424fd6718..44cad541bed4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1651,9 +1651,10 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 
 			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
-			if (l4.hdr != exthdr)
-				ipv6_skip_exthdr(skb, exthdr - skb->data,
-						 &l4_proto, &frag_off);
+			if (l4.hdr != exthdr &&
+			    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+						      &l4_proto, &frag_off) < 0)
+				goto no_csum_offload;
 		}
 
 		/* define outer transport */
@@ -1672,6 +1673,7 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
+no_csum_offload:
 			if (*tx_flags & IAVF_TX_FLAGS_TSO)
 				return -1;
 
@@ -1725,9 +1727,10 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 
 		exthdr = ip.hdr + sizeof(*ip.v6);
 		l4_proto = ip.v6->nexthdr;
-		if (l4.hdr != exthdr)
-			ipv6_skip_exthdr(skb, exthdr - skb->data,
-					 &l4_proto, &frag_off);
+		if (l4.hdr != exthdr &&
+		    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+					      &l4_proto, &frag_off) < 0)
+			goto no_csum_offload;
 	}
 
 	/* compute inner L3 header size */
@@ -1753,10 +1756,7 @@ static int iavf_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		if (*tx_flags & IAVF_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto no_csum_offload;
 	}
 
 	*td_cmd |= cmd;
-- 
2.34.1


