Return-Path: <netdev+bounces-107981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D421091D5B8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B83B20958
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365F79F9;
	Mon,  1 Jul 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="VJmKpDbg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245388494
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796890; cv=none; b=AAJccLcLcGT/qAYKmrd0TZRXHGu9/CXB1KDBJdHVUfTrn07Q89CbK7Li09QWd7/8OIcVhm9y821AuLUlshIiaDQeR5UXwDMyHlevNPI+02gvaw/UoOnwoqD1Fa1ZSil22hkZBjN5EnnkIY32o+IEBulQcDBJlTi/XGuvmMkrQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796890; c=relaxed/simple;
	bh=RMo+Aoe/0AR30CK9/W77DohGKdDGc0/aPJUSUoAaV/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sldsK3jXwCUFfIlYWHum07Xge0GlSmw7eGaSDxC7Rx0sW0TOK0HRoD+pUFDO6vzmwd3EtyT7X1UG+zvsV2PJ4QhItJ0ZI2K5pcgaxq+FD1trqv3EgPa/LIk03Au5LBdNDHSSfA3q6SK753LJcfNAsh5GhdLwC7blnOqxcDUShfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=VJmKpDbg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1232953a12.2
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796888; x=1720401688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIDEpdck9YV2zPdfWntiOz8NVusw1OMyqGgNFj+H7EQ=;
        b=VJmKpDbgkhMNl/ICJQygD+VbtSu2/7fk2iNyn5H64t0fvQgmKlpXfTlfHGO9GxclYY
         oeI9mGMHam0TTR2up815XbVfy0U9zmaiDCKqu4BcWq3MlzWi637//4RVQlSV393y3gJV
         PXVjE3SyjS7kzr7FMmt5Ps4wu6/Z59+Okh0w4d7H74TcCOR8Nm2QopRtgi4vbHJYx8zT
         0Vw2Nj+FVO1SaGK1lZkkoJkN0z4Ns7ZxytTE/gHgQTQpwnA/zUe2QWA3g5i8g0Z/Auf1
         CO0/wPQ2jGcFqLOtbMlrx2HyhieSonCPIgXUEPzrnh+VOW8TsY40LLOGr2/EcUI/tIm5
         jDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796888; x=1720401688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIDEpdck9YV2zPdfWntiOz8NVusw1OMyqGgNFj+H7EQ=;
        b=DAoSLjCEJR0Jop9FrW+y8ZOr9nijRAW8H5JJFHZzYqc1wVmRYWMICdLbt+WMw9DMgR
         1/PItSfURWSPT4UKeTzfmSoPizvqL2wJ60fikfXK+QEY+UU8fTKxO4L2f9jrC+pUUkPJ
         LUmE39d7s2MP61UP55aWg5uRPzIs7WsNCxBW25F0QfqnXzklLX187p4n71mQ1B6lHeag
         X0XMh7HzEqet/DDbT4riFKDFCyFwbLvo2YRhGlcbw8i3vpEfPkdCe75DPTXRJqXAoqUH
         5UbVA/osNSt0LIPV6FrFflDalxQSlyjYnAO7ElQCcP/2esfXzzUwYonAZX7CfcTbPZtH
         NhFg==
X-Forwarded-Encrypted: i=1; AJvYcCXaBYK5Wbh4ZCVZpupptpbOUjBxDvVQGnFV3vqgg8FtMmExsEMCNI28S2YqtX0N+HqkM4BAtzjg26edxAIpsisUtqqEy3XB
X-Gm-Message-State: AOJu0YysC6JmQmZmgC73Jxc/bP2Y+XYqcqUodKeGONyUcCuZ8tNiXZu3
	kWA3u5Vq/0zcQ2E6ThUhPmONpm4qqDei0LyXLhtXu1kdjHY0PBafvTGWUkOysA==
X-Google-Smtp-Source: AGHT+IGiOkImm91NnX2VzM+Sqbujp57DznsSvbtQZ6AoTnKAFy3efDpy0SAelsICUMznMNS3sF0WgA==
X-Received: by 2002:a05:6a20:7344:b0:1be:e3d8:1a85 with SMTP id adf61e73a8af0-1bef610d0c2mr3960764637.36.1719796888541;
        Sun, 30 Jun 2024 18:21:28 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:28 -0700 (PDT)
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
Subject: [PATCH net-next 4/7] ice: Don't do TX csum offload with routing header present
Date: Sun, 30 Jun 2024 18:20:58 -0700
Message-Id: <20240701012101.182784-5-tom@herbertland.com>
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
 drivers/net/ethernet/intel/ice/ice_txrx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8bb743f78fcb..fd57ac52191e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1842,15 +1842,12 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 				  ICE_TX_CTX_EIPT_IPV4_NO_CSUM;
 			l4_proto = ip.v4->protocol;
 		} else if (first->tx_flags & ICE_TX_FLAGS_IPV6) {
-			int ret;
-
 			tunnel |= ICE_TX_CTX_EIPT_IPV6;
 			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
-			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
-					       &l4_proto, &frag_off);
-			if (ret < 0)
-				return -1;
+			if (ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+						      &l4_proto, &frag_off) < 0)
+				goto no_csum_offload;
 		}
 
 		/* define outer transport */
@@ -1869,6 +1866,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
+no_csum_offload:
 			if (first->tx_flags & ICE_TX_FLAGS_TSO)
 				return -1;
 
@@ -1928,9 +1926,10 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		cmd |= ICE_TX_DESC_CMD_IIPT_IPV6;
 		exthdr = ip.hdr + sizeof(*ip.v6);
 		l4_proto = ip.v6->nexthdr;
-		if (l4.hdr != exthdr)
-			ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_proto,
-					 &frag_off);
+		if (l4.hdr != exthdr &&
+		    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+					      &l4_proto, &frag_off) < 0)
+			goto no_csum_offload;
 	} else {
 		return -1;
 	}
@@ -1961,10 +1960,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		break;
 
 	default:
-		if (first->tx_flags & ICE_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto no_csum_offload;
 	}
 
 	off->td_cmd |= cmd;
-- 
2.34.1


