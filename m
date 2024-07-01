Return-Path: <netdev+bounces-107979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4422291D5B6
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9081F21269
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3E8472;
	Mon,  1 Jul 2024 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="YgM9pYkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FA6FD5
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796888; cv=none; b=shU6Jo4zcLLVGjQC9mCtZDa23m01Ur9nRrrYo2wuKW/+1cM4bxOFUqpBme+dgSioiaiU0rEKthLvVP0jWO3LfT2UmR7bVrsm1rtTZfgbjGEN5QzafD0R1wPhBrNHosHgY4tg/KAI7+Pddvzc+6gLdKMn2gHJAHum1QRtov969nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796888; c=relaxed/simple;
	bh=fjk8KoUFQlWZ+h9za2M6CVDNFS+RTyvKRNPKldL2iTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YggipQGtVvcagXzDsplkk5M84HC6OaJaXXaQwBBEuNjdv4xef7xgtwqYp+AXFZTvESiF++N5gaah3J81EM3qG7N6v20S477rSfL0D3j8ekNCjofBmbgQK1rYDzZzFbKQeJxZmxHehCCuwy/88KoTkETNgkg/HXgz76dhdooY4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=YgM9pYkc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7065e2fe7d9so1880412b3a.3
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796885; x=1720401685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQQhk0i2sHpe+OIVwA9toTVFV+7i26oQdEGah4XqpXA=;
        b=YgM9pYkczqBFFOcV6c+WRx4CYPkXwUaJC574+NlNsZzVUs80Nx/pfAqZJ4xTEez0r8
         AlyuXr6Fu7S8KDJ+331nb3SEB9WeCXbNUQfPOiNxR+NO5NKXL8YKYng6vAEEzUPCPCSf
         DKeJMzpk1LaRyWTycJyVCrKqWz2cUECl5ppZX9UgyW/Akqmtphu/+UiySRAyIK454A8G
         ftyh9ZUKxodBUEPEKoHAH5vhzBJQqpA0Cs9/DhpZt+pglhcRgYbr4P5FTB5isc9LF9F0
         lJ0KzOH1enetC2XZMTiKZjhveWTxJrbAIshTG8rUUKG8RK1poM+f0qhTtOeJnKPwA7r0
         JOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796885; x=1720401685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQQhk0i2sHpe+OIVwA9toTVFV+7i26oQdEGah4XqpXA=;
        b=VZIKXuU+ANpZsCN+dQnK0A1WuPHntFMRo1z/Kd8dtO2RdLPqLRiIyh4q3tnl1uwDKx
         oV8+jZHDkIRwRPm8G3FIqzaSdhQGwcEh31aOSwfWAoy2vzAYq+Aj4D/WXjRVbRFA1zad
         ak5Ucyjm5DiU31qQtdDfhmxJGTDrs2lcsxe1T9tXE18nf0ZdhfVWciNBQbrwxsRoYzxT
         X0ErMUxhwWH6ost1IjOGAhtrxcjfVIGcd5z7mjVfEubkIsfdXCPAF+ylSTbzpMp+69YU
         Pg1lEBG8IWIYji03dKRSbcHYFQGxGzChKrX0kQvMHBkVcLRbbjAvzjyYWLCc/YTiWgTC
         hUgg==
X-Forwarded-Encrypted: i=1; AJvYcCX7DTGN05CmTrVdP48r5+D0Oocf96yIJfGwhyXMrKJ3yO94J+uuk8IqWhjzX+l5kQMG94tGF60jigPkI3XRnQTeOt9b+a5/
X-Gm-Message-State: AOJu0Yx3V0x23b7q7Ajrqub0yXeKaKUgRRhwn8iE5UE3Oe0myXQHXP2t
	ExU5qeXxnncZtV0iODVMEiKohnc5BBdRFxB8AYPoMUjtARgJJktyKWqMTAgD3w==
X-Google-Smtp-Source: AGHT+IHMfkQoAsyUBQ1Hulr7GbAzRjKB5uplnlujpGMylH5/k65pClvQQIxvkx0KZdyYpLGk7Ba0rw==
X-Received: by 2002:a05:6a20:d48c:b0:1be:d703:bc47 with SMTP id adf61e73a8af0-1bef620fba2mr6983165637.49.1719796885594;
        Sun, 30 Jun 2024 18:21:25 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:25 -0700 (PDT)
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
Subject: [PATCH net-next 2/7] i40e: Don't do TX csum offload with routing header present
Date: Sun, 30 Jun 2024 18:20:56 -0700
Message-Id: <20240701012101.182784-3-tom@herbertland.com>
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
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c006f716a3bd..b89761e3be7f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3296,16 +3296,13 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 
 			l4_proto = ip.v4->protocol;
 		} else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
-			int ret;
-
 			tunnel |= I40E_TX_CTX_EXT_IP_IPV6;
 
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
@@ -3324,6 +3321,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
+no_csum_offload:
 			if (*tx_flags & I40E_TX_FLAGS_TSO)
 				return -1;
 
@@ -3377,9 +3375,10 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 
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
@@ -3405,10 +3404,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		if (*tx_flags & I40E_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto no_csum_offload;
 	}
 
 	*td_cmd |= cmd;
-- 
2.34.1


