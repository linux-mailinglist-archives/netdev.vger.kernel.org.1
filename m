Return-Path: <netdev+bounces-156610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BE3A07228
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD8F162C26
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C112185AC;
	Thu,  9 Jan 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DPKE/jdT"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11661216613
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416146; cv=none; b=AkE61SAgdGtoGp7a/Op5QH2V6xpymBd8zHTzRQNiRrInnBoNdg+8gQ0DTWL/6LGjcNlEEv4TFGqUX/ssGTc/BIL6XuAhDk6vswxH3GSGyOr/TJGTR6dTM6zjUtwZwKtdQTqq6Z1JFklsSWCVqb33nIefPxSsKOiVkRAqKaJ3MnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416146; c=relaxed/simple;
	bh=AriilF8p1AgxhdMoECP3p1Mx9heMDbzxBtJsRZoO/WQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccnzQmx/nRbvZMOVYffKTqlh3b5Oy/t0XEt+DzU9DkIexWxzOg1kGFWun0TN7IriNEHoY7DpjPXLFKCTwxEJ/LjI2YO9im3u7FC1dvtFTl/LNii2vsTfZYq2lF//CStuAAs39dK96RmJNaTOMpTHrEOF3zCBxXPJ8ZAkM6qf2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DPKE/jdT; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EB9EE20851;
	Thu,  9 Jan 2025 10:48:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OP06WTfHz24x; Thu,  9 Jan 2025 10:48:59 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 753B820882;
	Thu,  9 Jan 2025 10:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 753B820882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736416137;
	bh=QvPkWjky5d4FvFiaRD3oMpAoff1rWxmLDtVopDToBhA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=DPKE/jdTKFoWmZgcxfSsuQScGu432a+jZ+TonfDyNhY/lz6LZBnA9yOK2x93Y8xlZ
	 ZMp5asDqUyO7A1SyN3D7MW/5LrmSUIHsTJcg49K+IJNyMvPGchf5gqBpNJnuNsRwiu
	 QlVBHgDxmhNsBJSKyYhckpoxXBqIXfv0iS81d16I2ZrxRv+ik3X9Hflzvtpd0M0wuX
	 uv7TKKuZ6Oo9UUjiuW440xM6d2UO6fIaxn4xbeGBnODh+3pU2lEyt5EynAHB6Wrtwp
	 tuTMOTDdooEaUS33RL4PYyWV8rYjmYnFPSDfQXIcT9p6m+m8XddsWPJhqZ8a/qIsPM
	 gAW6Rkdb1JZYg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:48:57 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:48:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id AB3403184196; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/17] xfrm: iptfs: add reusing received skb for the tunnel egress packet
Date: Thu, 9 Jan 2025 10:43:16 +0100
Message-ID: <20250109094321.2268124-13-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109094321.2268124-1-steffen.klassert@secunet.com>
References: <20250109094321.2268124-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Christian Hopps <chopps@labn.net>

Add an optimization of re-using the tunnel outer skb re-transmission
of the inner packet to avoid skb allocation and copy.

Signed-off-by: Christian Hopps <chopps@labn.net>
Tested-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 123 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 15 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 4af1f7b5818e..8538fb02ae8a 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -601,12 +601,12 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 				    struct list_head *sublist)
 {
 	u8 hbytes[sizeof(struct ipv6hdr)];
-	struct sk_buff *first_skb, *next, *skb;
+	struct sk_buff *defer, *first_skb, *next, *skb;
 	const unsigned char *old_mac;
 	struct xfrm_iptfs_data *xtfs;
 	struct iphdr *iph;
 	struct net *net;
-	u32 remaining, iplen, iphlen, tail;
+	u32 first_iplen, iphlen, iplen, remaining, tail;
 	u32 capturelen;
 	u64 seq;
 
@@ -614,6 +614,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 	net = xs_net(x);
 	skb = skbseq->root_skb;
 	first_skb = NULL;
+	defer = NULL;
 
 	seq = __esp_seq(skb);
 
@@ -688,23 +689,92 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			skb_prepare_seq_read(save, data, tail, skbseq);
 		}
 
-		if (!first_skb)
+		if (first_skb) {
+			skb = NULL;
+		} else {
 			first_skb = skb;
+			first_iplen = iplen;
+
+			/* We are going to skip over `data` bytes to reach the
+			 * start of the IP header of `iphlen` len for `iplen`
+			 * inner packet.
+			 */
+
+			if (skb_has_frag_list(skb)) {
+				defer = skb;
+				skb = NULL;
+			} else if (data + iphlen <= skb_headlen(skb) &&
+				   /* make sure our header is 32-bit aligned? */
+				   /* ((uintptr_t)(skb->data + data) & 0x3) == 0 && */
+				   skb_tailroom(skb) + tail - data >= iplen) {
+				/* Reuse the received skb.
+				 *
+				 * We have enough headlen to pull past any
+				 * initial fragment data, leaving at least the
+				 * IP header in the linear buffer space.
+				 *
+				 * For linear buffer space we only require that
+				 * linear buffer space is large enough to
+				 * eventually hold the entire reassembled
+				 * packet (by including tailroom in the check).
+				 *
+				 * For non-linear tailroom is 0 and so we only
+				 * re-use if the entire packet is present
+				 * already.
+				 *
+				 * NOTE: there are many more options for
+				 * sharing, KISS for now. Also, this can produce
+				 * skb's with the IP header unaligned to 32
+				 * bits. If that ends up being a problem then a
+				 * check should be added to the conditional
+				 * above that the header lies on a 32-bit
+				 * boundary as well.
+				 */
+				skb_pull(skb, data);
+
+				/* our range just changed */
+				data = 0;
+				tail = skb->len;
+				remaining = skb->len;
+
+				skb->protocol = protocol;
+				skb_mac_header_rebuild(skb);
+				if (skb->mac_len)
+					eth_hdr(skb)->h_proto = skb->protocol;
+
+				/* all pointers could be changed now reset walk */
+				skb_abort_seq_read(skbseq);
+				skb_prepare_seq_read(skb, data, tail, skbseq);
+			} else {
+				/* We couldn't reuse the input skb so allocate a
+				 * new one.
+				 */
+				defer = skb;
+				skb = NULL;
+			}
+
+			/* Don't trim `first_skb` until the end as we are
+			 * walking that data now.
+			 */
+		}
 
 		capturelen = min(iplen, remaining);
-		skb = iptfs_pskb_extract_seq(iplen, skbseq, data, capturelen);
 		if (!skb) {
-			/* skip to next packet or done */
-			data += capturelen;
-			continue;
-		}
+			skb = iptfs_pskb_extract_seq(iplen, skbseq, data,
+						     capturelen);
+			if (!skb) {
+				/* skip to next packet or done */
+				data += capturelen;
+				continue;
+			}
 
-		skb->protocol = protocol;
-		if (old_mac) {
-			/* rebuild the mac header */
-			skb_set_mac_header(skb, -first_skb->mac_len);
-			memcpy(skb_mac_header(skb), old_mac, first_skb->mac_len);
-			eth_hdr(skb)->h_proto = skb->protocol;
+			skb->protocol = protocol;
+			if (old_mac) {
+				/* rebuild the mac header */
+				skb_set_mac_header(skb, -first_skb->mac_len);
+				memcpy(skb_mac_header(skb), old_mac, first_skb->mac_len);
+				eth_hdr(skb)->h_proto = skb->protocol;
+			}
 		}
 
 		data += capturelen;
@@ -735,6 +805,16 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		/* this should not happen from the above code */
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
 
+	if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb) {
+		/* first_skb is queued b/c !defer and not partial */
+		if (pskb_trim(first_skb, first_iplen)) {
+			/* error trimming */
+			list_del(&first_skb->list);
+			defer = first_skb;
+		}
+		first_skb->ip_summed = CHECKSUM_NONE;
+	}
+
 	/* Send the packets! */
 	list_for_each_entry_safe(skb, next, sublist, list) {
 		skb_list_del_init(skb);
@@ -742,7 +822,20 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			kfree_skb(skb);
 	}
 done:
-	return false;
+	skb = skbseq->root_skb;
+	skb_abort_seq_read(skbseq);
+
+	if (defer) {
+		consume_skb(defer);
+	} else if (!first_skb) {
+		/* skb is the original passed in skb, but we didn't get far
+		 * enough to process it as the first_skb, if we had it would
+		 * either be save in ra_newskb, trimmed and sent on as an skb or
+		 * placed in defer to be freed.
+		 */
+		kfree_skb(skb);
+	}
+	return true;
 }
 
 /**
-- 
2.34.1


