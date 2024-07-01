Return-Path: <netdev+bounces-107984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840791D5BD
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CB52811E3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A5DF42;
	Mon,  1 Jul 2024 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="L/rTapdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08E171AF
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796895; cv=none; b=ceud++jSy2u0JpYCLN//Ig39JEoHJ5/GxJyB+Yr9fJDGgAuUKwowrVgNMSm1sVahk/fjTFR4gNU87wJ3tncZdS82Z4/a3RLtM/KnDCmfgpXSBz59v7hKpE6xBNCzlf/aBNnPvN2R+VGe1zQNtMYzHLvp/9E42FzZ4IZ6yBlC7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796895; c=relaxed/simple;
	bh=7lntupVKf9E5CTX9AHlZIfAIM30yPoqZyJUXX6Q1i+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rn8FM5lSN1LzQSlvG3y0qHwiuZk+sk6arH55hwyq8zzHx1BqEF6TeMZ74yE3+LPqLtR7fQ0OWkjM/1dWbbgJzc0sWxyoBZX26HVFv0MsstV7khK80zNhSpxPt4si4edrQWpzZYGk2d0unHWrpWWwMJGBs2Nh0SH3lP+AuTasdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=L/rTapdT; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c1d2f7ab69so1178504eaf.3
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796893; x=1720401693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgH/Dp12PQwRCvuuv6JrWA4Cp78PNWk7TmUD/JNFAMs=;
        b=L/rTapdTTNs842z914C6M7Tz45ZMfgO22jy+OzR/wqvtT+splWCuz9daObGgtPMYjZ
         FvGRYMR2ubcp+kZMzIwMLMIoXTrOXe1FNpkU7vxpC+tj0RhNod6fBnbgGAcLsH1oMyv2
         ISlC7NcYjb3ubvKr12bmPrz5PMY7nCjO7OlXwWXrvpUy3pZ/DjPIpe5f/Co3d67DOcGE
         wh8WqtIEk+mAKraccokK5vYH5Xa0CANf10SRSBrq2x0jtXbWIPpuqQa21KxUcLo6lkR0
         hAwj5SK8+uG7t5p9kYrB/+aAj1A397ABGDbYKF00e3dyNoK6i5Yr0szR8Hen4QetBZPs
         BggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796893; x=1720401693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgH/Dp12PQwRCvuuv6JrWA4Cp78PNWk7TmUD/JNFAMs=;
        b=kWSavOnt90kE2neonpteh60Hs2tYsFn8HvBH7yChTPHPXpQmsebH7BlZcBXLFbWKGg
         48LJdFRSGHbGZYx6GlQikGUWMnD61s31PmGuT0nnNHSPOyYo2ys/QjB0hg24XNX5CtXF
         C+RK17Me8rQZf9kqnFx2YsQNnlne0dOjcgKyv8oxXlDpnnaUzwyH8/aTfqSma4eS9CFj
         OhInnsE5Wx/u8GEmeQirPlIj9DPgnY71dXN4d1RjBaI5JPS3m4zS87eGFp2vmOwRhv5/
         ltLHYXJPISP2BxHWAxG/iH3G+9jwvSrpzilv3iOeXQH7WnnuSNIAXaqfrhXuCDr6ty0q
         0V5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDhPrQ/H2x0fmK5u7vykR86c0eeuewxhQ+Qb+kG80myeHIzJAv7UYLM9G3ppRMgfotzsI7ml53bH5AgHflUQa0EghcqLxC
X-Gm-Message-State: AOJu0YzltMcS2FNTH9OIvRa1O1Isb2bmzjfnZrirUp9PJcq/tw/X1hYb
	mvsmm0tgmO6wq0G2ToNRxL4bpZuOK/YczxESUnaPisKbJwLKPhsxaNSYLalE5g==
X-Google-Smtp-Source: AGHT+IFzBF1ZL7zf+pOcYvGW69tV6V/Ch7C1+ZokI6vHL2H4wySQpwbiOhS0pLt0CY7t+rGnYThpXw==
X-Received: by 2002:a05:6358:2c93:b0:1a3:69b:9bba with SMTP id e5c5f4694b2df-1a6acec70e1mr414138655d.20.1719796893249;
        Sun, 30 Jun 2024 18:21:33 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:32 -0700 (PDT)
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
Subject: [PATCH net-next 7/7] fm10k: Don't do TX csum offload with routing header present
Date: Sun, 30 Jun 2024 18:21:01 -0700
Message-Id: <20240701012101.182784-8-tom@herbertland.com>
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
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index fc373472e4e1..b422fe7be427 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -832,9 +832,11 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 		if (likely((transport_hdr - network_hdr.raw) ==
 			   sizeof(struct ipv6hdr)))
 			break;
-		ipv6_skip_exthdr(skb, network_hdr.raw - skb->data +
-				      sizeof(struct ipv6hdr),
-				 &l4_hdr, &frag_off);
+		if (ipv6_skip_exthdr_no_rthdr(skb, network_hdr.raw - skb->data +
+					      sizeof(struct ipv6hdr),
+					      &l4_hdr, &frag_off) < 0)
+			goto no_csum_offload;
+
 		if (unlikely(frag_off))
 			l4_hdr = NEXTHDR_FRAGMENT;
 		break;
@@ -851,6 +853,7 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 			break;
 		fallthrough;
 	default:
+no_csum_offload:
 		if (unlikely(net_ratelimit())) {
 			dev_warn(tx_ring->dev,
 				 "partial checksum, version=%d l4 proto=%x\n",
-- 
2.34.1


