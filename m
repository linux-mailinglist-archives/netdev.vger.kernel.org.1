Return-Path: <netdev+bounces-108265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D500E91E8F3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F58D283E48
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B1816FF45;
	Mon,  1 Jul 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="YTV+KJIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F716F914
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863740; cv=none; b=iOzpSLVmRczAv/4iAMmPIvwtCeUT7drfEZj9nCFkRldc/7gTj6XNFUJat+ypsLJwpE7la7bGPD3RHzx2nMXPmgqtvegDBHhuOFKd3lvY1fNQRHfEMuj4yV1KKX6fpdh8TDWFw0EYYi9vcwMgcbNbcK9+pXoQ5cZOvyqQkYMdKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863740; c=relaxed/simple;
	bh=uxOmoidH78YdY000EH37e1nueV+e7fDSSclo4ruVE94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXQ22I8ad+rsfCvsxSKcmAftOu2x2pHwsIYufrFVLYY94yEIVm3KTUGrISVM4UG0hyIGRjINxY3fDZFV6Gfv+0nDCu8xscpbeQdhBSS8sDjPbDgwxYBt+TWXoKfM9d/VrZJxl/eYELU4W6eK3rUADlrqrjNuMeundjMO1HNQkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=YTV+KJIt; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-726d9b3bcf8so2359975a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863738; x=1720468538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uI8MDs8EI2Ym4TuLxEgIHn/m8yrd2PauWbLXazH6/ec=;
        b=YTV+KJItSwt+jumYjTXNhLksl3V9KtBm260DD25myJikpf09BYg4dIhS7qqo0/sMxk
         zft6qWVbO7QsFayPoJJ/lLxG+3DDTZYHJrKV0EazFLO98zXiGz89cYeJx7IYJB1U836h
         5chPytYXE8mX4Vx73Jl9iBoGpM/XggoiUqDZLE97aHo4HQd12L3isFwGsxNru82mnE9E
         8wkYYZmMdrf2Y5+4X1wwYE/tqRRibYbdk57yfLM+Or+NxqW3uOFBsV+BneIqnAG2nxAz
         78L/D6IpjPSFpXYPDsOKhh9C/ngJZbxsHmr1FrCB1UBfbFw7XbJdLPTe8unv2pd7P53T
         ATLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863738; x=1720468538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uI8MDs8EI2Ym4TuLxEgIHn/m8yrd2PauWbLXazH6/ec=;
        b=KuXQjXDU378oymH9RZLqkEIYQzySE6g4/mkxnQ5ADB8JLb/zhRDMvuKQdVaemMyto6
         Xe8kGPgVKsoZzXCVQYAmQU+d/uWoQ6YmzfiTHFx4WAbewXwz3DIIGxOEi+ifcKnvJ/D9
         XkCp3nv5GmanN+5AuXvL33cemBVcQbkAl/HVFa1tZ9ztMEQDxDsYllzUARetDrQpCyKx
         YE5nxfM+J/C0pFPp2ILT6RqQ5z6BCUW2J07S4xiOu+4LrmJXNF7Q5P5NXhoHLsz4ssYR
         /469i8YErOOl4A50M8TFysanYbqwd/kQalB55xbxehciSpplR+au7DuB02AClyExnZhc
         D1mA==
X-Forwarded-Encrypted: i=1; AJvYcCV4f0IwTumBDNAwHAmDrT6JEXJGULX21PNWSHLSg0FmYvK0HHEmEOTLY/l0YyqnCzGdZG8o8wPsv7JWWB60YyC35RyqigXv
X-Gm-Message-State: AOJu0YxCKlkny2tM9q2C+3mYbaVdyyJbW+VCPEiHryH8wrwUKudobH+9
	CONoFH9tui0mXmfaIkwnEWHYS+B8qC8a3M+EhTXzadlH5HVGWFTdUOl+hLRZ5g==
X-Google-Smtp-Source: AGHT+IGGqaFIGwOU7kSaGwmUOFhZTNMhSfJ212iLHlvjodDZA5KcdVxPkjXFcJH/5TnCeQnSmxqV2g==
X-Received: by 2002:a05:6a20:a106:b0:1bd:2559:305e with SMTP id adf61e73a8af0-1bef610cecemr6340905637.30.1719863737960;
        Mon, 01 Jul 2024 12:55:37 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:37 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/7] ice: Don't do TX csum offload with routing header present
Date: Mon,  1 Jul 2024 12:55:04 -0700
Message-Id: <20240701195507.256374-5-tom@herbertland.com>
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


