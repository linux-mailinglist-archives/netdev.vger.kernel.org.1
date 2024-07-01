Return-Path: <netdev+bounces-108264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CEE91E8F2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660662839F5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7AA171071;
	Mon,  1 Jul 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="TGy5PDgn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDE17085A
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863738; cv=none; b=ZszTEFzl2uAgSY0AodeJ5u2Oiqy7okn4eDTG3VJOcJm/GZy2pb5hL6Fwlj3RWq/auZ2zdJ1Ga79LjTnKmYd9HzFk7CtinvUe8+76I8uzzDXagMElKCahCLu944nEO51IHKlCryYiu+VAX7Chdhsyd5XDkpkb8W0BxJnHGo2I00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863738; c=relaxed/simple;
	bh=JnGXdB+Xt70eYBvQdqribN+L+yicY/RVPdEdddP81aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fq0L5mgGdmY+q44NJoavgSBnGio5g6NyCStyugtXkHLhENlVYrQ1b3VL9wZh2KWxEvKxj35C2SgVpPWoLKtsU7CjlcXYEksRQboipaD5/RyF7/KJhtRsxACtudxxInesSi0gHHZgoX/CDu3KlYl9kdE3ad1WCKeE9fgEf5SsVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=TGy5PDgn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa2782a8ccso16812175ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863736; x=1720468536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHOPxF8XDaYgBRjbvQ9Z/USErSaOdzoImvQNh+JNxgY=;
        b=TGy5PDgndP83aHX85oXS4QiGruBwULFzVbbuEH8L3zq0kizeFrxwr5WKSFgOcDZ72A
         UyYNz8zIWBn10dyE/Kp3qviQd7fH1dTtcl3qc7pFmLBHv1z/SsuwKQ+g/qSIqsVW/97N
         XyjdLBLmGblIIc6nKSJi5QJmN+Nzk1KymCrSwkfnFwIOv6Z5srDTVnbtLei5umJlRmGu
         jXSf5iywY7Fc9eAlQXh4+12g1KpYxy+IaJNhPAYIzLn9iGSG5vjnv7gO2yqTpUxDl9Uw
         axB4YMHhKHVgG/V45XiRgXsUGrmuHQdyPY8Mz9A/ApIvs3ExW7mvJAc0DDltjbafRZB/
         xddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863736; x=1720468536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHOPxF8XDaYgBRjbvQ9Z/USErSaOdzoImvQNh+JNxgY=;
        b=pZPsMjOaeZ1ORyp3G0IdHDmtYZs/KTKGfpV5l2eltKhz+3kRdT4WGgi3a+15jg55R4
         FEMe82wrAvXKgx/X29qRWK1tqiVXqReiZ4FqPfjhovweCEZ+cQRIYk3QbiZQohH5M0wB
         26cmGPb0hDNS8xt8FEYzLp6j8Ok/YxO9zWlPEP75NHJf1MuVOjxbceOU8slTo70mnMO1
         NzlHhqQQbzd81WCpjtIKebjXcdGxEaE09xbdRy2PYv5KyRRsfSkGkxEJ6CrhS98PMwT9
         +col+KEeVVfduFpFv7DuPtVTCcGsDkT2UXGxvCKPOoQIp0lCgOqO+a3o0QwRv/8jaAm6
         vFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx1EdeiLA47wKCDiSRgiXbjlEApWswt6bo3zKA5FlzFIwKnVw93Wuilw+pV9nUUjQgYzYTxgvShaJPoMuuaIlkbmXje5yo
X-Gm-Message-State: AOJu0YyvYcDSojeQBV3utUjoa9Hr08f1QXuLwb1OUsP9Cjm1hPZ/6Tab
	CtycZSPEMqIErpObM1dMcR63gykiQNoTJV8ggMZDCPYVnZF7RV1m+A4lXe1Efg==
X-Google-Smtp-Source: AGHT+IHOtaAQcZUNbP+b6dBFvluxRUO5cyTDX8CNNMQwCvAuFTsKNWGLRpTM2AqDilXMTSdJxiW8Gg==
X-Received: by 2002:a17:902:ea03:b0:1fa:2760:c3e3 with SMTP id d9443c01a7336-1fadbc73792mr40803415ad.6.1719863736499;
        Mon, 01 Jul 2024 12:55:36 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:36 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/7] iavf: Don't do TX csum offload with routing header present
Date: Mon,  1 Jul 2024 12:55:03 -0700
Message-Id: <20240701195507.256374-4-tom@herbertland.com>
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


