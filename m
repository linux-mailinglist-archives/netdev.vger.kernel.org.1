Return-Path: <netdev+bounces-225611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FCDB96126
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC091791EC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6318C2153C1;
	Tue, 23 Sep 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi5Uu7FE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947BD218AD4
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635291; cv=none; b=fNyUHLoDhyoI7x8bw08Vm1/7Ua96E3iE9ykT2Ogn1JnPx8ICvq7xJA1nsih6qm+CGvv/16DnRxykTXwnG8/gDQHeK/wRZi9wzggM45lLRipieN5ssHEgaDAj8xCgVZS7sxu9HCAB+1lcBZUPO87SN0Hz94iYaD0vbdVeHPdkMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635291; c=relaxed/simple;
	bh=XZp276NPdc/FQ5nsh8KGf614UeKySK1cn+XDFG6RsmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4VAO0Vb4qVAfW5y0ke0U7RvRiMViqASG/vLFXDdERj342oiD5vK6qrWRIbCon+iKwqmPXH/SbEMlmRVonRgIAkuhwZBnOj4K3ToUhS7Nwfi1jJKp9Hawq5td2SAFNTIlLdv0j2DcuRwALNZcKSHDbgJ64h90QeQMDBjgcLvlxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi5Uu7FE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46c889b310dso26448465e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635288; x=1759240088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEELF53X/oyK/iLXDVVAz2PmIQGvhzwOkPBm+ufqyBs=;
        b=Pi5Uu7FEMfyQ8TScvhzvtakwszFy3ZbZqsMHsVsT7uZJUUCDghTdWQDlH0+Mxa2V6+
         X66g8NK0O+zrrEqDIKgYhNbXho2v6sRJidg819G07GTeq9b6FEbUHKGlmQdvZrvzjTey
         iliPJx+VuIsqJ5yDnXP/VbnSSAg9E/6lfxVIj0M0Tu6mQuAreATwCJyLUcwPp8xsNj8/
         VGAugIfQqoW9vrSZOmqTJBD7565rOu/ytdaH4S9pE05iwkThDpcA46Gw0Q+VwIIx8TSV
         QYgrpZLvMExpQxSuxcowOu/ESAoKktO4Skx+tG5vFyZvMlibZ4K411vESbPvB3I2cMD9
         NgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635288; x=1759240088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEELF53X/oyK/iLXDVVAz2PmIQGvhzwOkPBm+ufqyBs=;
        b=PT0Mxt/NzEBA1732XZQ5KQpduC+EdZEnAnXXZ2KlB6dC3OskFGoa0mqspg2Brxp6/Z
         /8tNa+oOAmZnpvLxSBJ5k2cUu3xt1/3fLTj73iZ+wYeHSoQNm6LRN4mlCCm1bEGsGqLa
         kSK94aXY4mH0sqQOKcdL8oMEeVKTxQnKdpww9kVs3gbQtUdX9/6ELfFAhz+LLrtr7/qa
         R0iI1VijoOTv6OSU08ZVl4LQMY25r+Qg+LKtGXjfY79C2n8/aRcP7y+RfEpavGsq7hDL
         43nNK37MnYlva5Vt31x/xzoVmRDeQU/tb/LF+qsxijnjIFnSKfwvlBVIXrLX6CjYLCZP
         yeSA==
X-Gm-Message-State: AOJu0YzNAUfiDdgPi5gKHDeuxXZMC86Oj/k7gnhgoRS8E31AjkDkTknZ
	mYtCe8M6r0ZMURg3C4YZz2XIxegWaXE1CG+OpfwjCKXTol5R4+S4usMQ
X-Gm-Gg: ASbGncvgttrH454WQRUnQ5SNHKQ7s1yIOrqTotsbtrqlge/UGiTQhntpwg5v8fOk3VJ
	u7mRh1i6kTklvb+n4K1H5gQ2Ctl6vaoyojCzOmvgOJxdLu/BQhuNPa6SpHIJd4yWh4B0r0PcZeb
	7xM9EqC63/8EJz7d9aWv9jQoeqhOx33+3jIsIPpwsa91qgdEl9OcPMgO2KaxkNqyvf+VrqLovUb
	xraLWJuN+/Ygv/tsvtTeV/s4Z2cWxPZin5qcgnzxyPGROOtfhR4oZ0wlzinWB8rpkFpmx7tvUI4
	lInjU8ouQ2ZLH1K3+vqWdv2xzuhT9CI3dNxMBr1Aypoj2st+0T7McxxgxUG25HDhXwebQNCQa7Y
	1uZ1f2YWj2mTVfWanxA1RNTdsRkLEdUQDQPyCkpObMLnku0Ms0Qnmf0A/AOE=
X-Google-Smtp-Source: AGHT+IF/3t7s+m5PxBwr7Y6UdKkBoIlXtsZa277kUqAiiBj96QiAmO7XceBKvT+5eaExjKyehOOqiA==
X-Received: by 2002:a05:600c:4fcf:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-46e1e167fa7mr27308995e9.14.1758635287844;
        Tue, 23 Sep 2025 06:48:07 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4613d14d564sm322241435e9.14.2025.09.23.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:07 -0700 (PDT)
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
Subject: [PATCH net-next 08/17] bnxt_en: Remove jumbo_remove step from TX path
Date: Tue, 23 Sep 2025 16:47:33 +0300
Message-ID: <20250923134742.1399800-9-maxtram95@gmail.com>
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
unnecessary steps from the bnxt_en TX path, that used to check and
remove HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59612d1e176..b3c31282b002 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -517,9 +517,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_free;
-
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -13792,7 +13789,6 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 			      u8 **nextp)
 {
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(skb->data + nw_off);
-	struct hop_jumbo_hdr *jhdr;
 	int hdr_count = 0;
 	u8 *nexthdr;
 	int start;
@@ -13821,24 +13817,7 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
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
2.50.1


