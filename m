Return-Path: <netdev+bounces-198676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B317ADD04D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82AF16B72A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0A62EB5C2;
	Tue, 17 Jun 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw6rxMHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC12EB5AB
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171368; cv=none; b=ICIKebEO2XDswoP7hQKKG5m/b5KCpQRhvUlapHwm5SskDdFq10XsFnb3/fEPpCjF9XJI0WQPcWzxHEPBu4GLMGFU8bZ1g9yzfE1bGoCmI9BYDsX6+/0AJOfBdny0ir0bRP/OVLKTI5iJKLbYI5ZonhpYZa5WC9UhpZdKqJq5eKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171368; c=relaxed/simple;
	bh=yqrzwZtXS6VWsKtMpqhPxEWKbw0C5/RqukDPGLCEAro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD1KehfYhXIb+TBm5rnl4QKdrGZ/ZsX+JsUUgrLVXvSHDqw1Hcr7P/batBkGOKCApEOzbbjL657FaYe9d1NZFw8jF+Ib8TFXd1T18azCvloRaq1P+5iJIdifsEm4rfJHZyYYy4G/6FVksk21f1YqMGb2FPCuIwoOFUhNsrApGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw6rxMHY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so12903792a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171365; x=1750776165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk7VWcVEbFnLsY2SleKq0fg8xNpOYOiGVUBmMjWbD8k=;
        b=mw6rxMHYWX5RorcrqeKrNgi++zKCCm5rRlIaVxAzbfdEGXkqXH/Qs38xl6U237z1zq
         blrWCLYfuAblh6dnvgKtoGO1+jlxzutNSpBsLJfXU5njDY+W4kPKv6vfru5dQoyn1Y/b
         NkMhc5+PHw7A2V0cD/Vh6hjxyVnMxVQhTrn09iyAM9O6FOWPnQs5vr00RwJ/Fu4AACeA
         FePK48szh8ZoefBQamFQdjIEFXGHiZw4xJpo7r4Bp7Hm9Osi3PVdzuD3rFMZErAWmttf
         CZ9GvVJKDNem0xXuSQBqd8BqJ19qij2Z0W+7+1z9IZonh8PpCaUCnLq7kReozK0urMnD
         0ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171365; x=1750776165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk7VWcVEbFnLsY2SleKq0fg8xNpOYOiGVUBmMjWbD8k=;
        b=J3KPoeGBaB+4GwFqHT793ZbimNJII2Ngwa6+d7705Aidx6wdz8RWrIFSt9ehwxsbcA
         qXOL3sbVpj6VpT5agru8W8sqW663J6aDljqIMRR/V9FT0O5fjf/ox35rDB49JtE+42/d
         JbFRbo+QtNV+7ToPiWyE+vIlPnQHFVLHYcBbRc+xZY1ezVXvjATOLWZRGCBfTyopzVF0
         L56H2gM4LToUuQUc9JW0rLiRsNkAXGXSsNMINGFDYC2dMRqBNSC78WjF5q+bxAhLGfWJ
         77nzvbtl30JbPEbFcIeZYkTtwRXFSAujSze0FxhuzIQ8NcjG+qU2C36NET81xljoq7wb
         L89Q==
X-Gm-Message-State: AOJu0YxgIUORT14DQ3pbPtVKGOYPoIGE643QTqtG1NPhj/3SuvJIOCdE
	vXhWZcixpcv8tAKesdwH4aFLY8OhPwKVbAm7VIxVuG6ZLPvVtC1BCMVr
X-Gm-Gg: ASbGncu7AIiWgJRNxH77UpgZF/zGire7nUYTU5EuL4w3laZ/+Nm2QVIodaHagCrlR6n
	Wgr0Qv5azCIli+K3I/RZ7XfDzzUoqS1Dm/cfySegbGdOYqboqdpEsyiArJU2h4A9K/5FUn+sx5G
	TiJPHEeL8ySjv6J8a1ro4douQNzUYBCaTVKNgCL3pVx7oGiaaU4S7jlU4a8sYwrNhMz5YA/oZeL
	WzodjCWwNKzFGZ0DbyuiTyYC0jbNmS5Ucy2o79+eDRBx9LfkHoEAK9rD2cpOawYOZXwihzxIHgx
	F+HUS49vf4S/Y/BXeNbHpm1TDttz/lF+aWV8TAOyyZpYlj/MiSIyuUSDg2a+pLXYeyU6/et8eOC
	MytWhbweElKib
X-Google-Smtp-Source: AGHT+IGXtcZ0BhyRT1r5y5IgQMghaL1rsQBJaS5sskmA7chn0qYPAm/Sd4I3XcA225eBLKOoosB/eQ==
X-Received: by 2002:a05:6402:440a:b0:607:1b7a:b989 with SMTP id 4fb4d7f45d1cf-608d0862b0emr12309921a12.12.1750171364834;
        Tue, 17 Jun 2025 07:42:44 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6097bf50ab5sm2399485a12.43.2025.06.17.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:44 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 08/17] bnxt_en: Remove jumbo_remove step from TX path
Date: Tue, 17 Jun 2025 16:40:07 +0200
Message-ID: <20250617144017.82931-9-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the bnxt_en TX path, that used to check and
remove HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d5495762c945..7f10bcf45280 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -511,9 +511,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_free;
-
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -13663,7 +13660,6 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 			      u8 **nextp)
 {
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(skb->data + nw_off);
-	struct hop_jumbo_hdr *jhdr;
 	int hdr_count = 0;
 	u8 *nexthdr;
 	int start;
@@ -13692,24 +13688,7 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 		if (hdrlen > 64)
 			return false;
 
-		/* The ext header may be a hop-by-hop header inserted for
-		 * big TCP purposes. This will be removed before sending
-		 * from NIC, so do not count it.
-		 */
-		if (*nexthdr == NEXTHDR_HOP) {
-			if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
-				goto increment_hdr;
-
-			jhdr = (struct hop_jumbo_hdr *)hp;
-			if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
-			    jhdr->nexthdr != IPPROTO_TCP)
-				goto increment_hdr;
-
-			goto next_hdr;
-		}
-increment_hdr:
 		hdr_count++;
-next_hdr:
 		nexthdr = &hp->nexthdr;
 		start += hdrlen;
 	}
-- 
2.49.0


