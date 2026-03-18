Return-Path: <netdev+bounces-269168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CWVJ+L6umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:20:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3095A2C1EFC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C2531B610E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5433F8E13;
	Wed, 18 Mar 2026 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="aQyNEZvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6B3EFD34
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861240; cv=none; b=XKEPY4pqEPQ7pOtSpKEGOiZqEDngRTlJIphRK1I7ttdGTVJFA+6AYtf2bNi1crPWgxCVnfe6HvsYwvaKYVV7Kwah/wIw7omOI+LQSvpQhMpSTWMqCY+XGr5UFK/kDsURQpp6jJZ/2oEvJY2zKZOPAJdN78Wsj+N50mBcGwa1V18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861240; c=relaxed/simple;
	bh=G3lAJEGIzOMjHC/w2zD2WcOKWET3ZX4PkXRW3E0aC98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUIVvIHzdWhesb4i+Npi1Od6nhM2bKOQ/AguCuiQq1FZY5j8mH4wv7+XSGOK99liQRevv1ltqViitdovTM4qA+Uo55g37HLwyoZJAsGc/+rYtTpMpW83JPr4kfW0WE8Xb1xQqNgrxzdys04vv1jqEceIGQYJJuHd4It9Vx4LrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=aQyNEZvS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so208919a91.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861236; x=1774466036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzxTmIvDilrbiI026msD2EOVwu+JY7leoshXAkQYWUA=;
        b=aQyNEZvSTwEUhJF5q6o2Xnh/zuhRhHD6Rot8YtOFJnhLl38xZWuMunSE2rZuZYAjMS
         Rm7h54FGt83Att7sM+Gb/cn100skDu1gsk+jZ7uy4v00sY+Q+ja0g+SJfRkToltP2nu1
         8RYg9tHuHKodstPStk+QrTNQHEZ8UQ9QKe6g8wqMUzL/FlE228Am7/FBe4gWB4YdjNlg
         qbbLDho9ChzaRZ5awr9p7XmGE5mzy6LxyXqqoQa2aDuaf/27MqdfvyBX8qMTem5BG/n6
         irGawt5jAvRiM8gwgGfe6sCxoI0HXjbHMkkGTc7Bgn34UQZLwL82NzaaGsuhrgTiB9n9
         +v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861236; x=1774466036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzxTmIvDilrbiI026msD2EOVwu+JY7leoshXAkQYWUA=;
        b=j3T30NV9PE0ey32y8pr+SgCb7avt59axHQMSIhcgNPz8TacS6v2geOHSEyinbOYGpN
         xBVizyYUJszCaXMwMCcSI6Lo/bnKgF87xeIiiINZFQQz8txxKboqu76mt6dkCRgbBrjk
         r3jFB6uykseTjZ7yXViWnL5HjWExVIz4JfpsJe9frrrp9Hh+Os6WcJYrCE78FYBGS17Z
         j58ywNQrYSjzddal74y2irvAg+8uAqFZ15aW0Az4A63jC0pegbKegQux+uxSWcaPksZ4
         f8Oi2uoqrd9KELILSz2Om47t4tAtbOoPtVvtd8xTEVGbJy8uUNDjiIHcjtqY7zhvcS0l
         PNSw==
X-Gm-Message-State: AOJu0YwPAPbhOm4rpetIChYS4PKO+GSOJ/zx4Y9rfED8taSRDDiZd0O2
	6QfQaOQ/bv6SAkUoCWurPuY9gIHaCJDc+3B0nkSqw+oE1AqekysfDZAjqvw2nsv5SN1gd/7N0UL
	L4oI5pec=
X-Gm-Gg: ATEYQzzNmxYQWNRo0rOde3fQeWdSYPsWJn2yVSbok+1z0g0gICAU7ofUeTtHFYWwA76
	08tQQfpTv1eYvm7aVki4B84Y+L97ysUv+4xSvH8pIQMeP4uJ/9pm+tjwAPkpEBy4TkoD3uuSlkm
	Dt6s8HAg/ziGAqHR8ek+Zz4xnIvaLmibFqhiWFu9ofgQCEPaM1ZpCCox5DpkQkN3XeAOho3XgUb
	flOdeJc0yJeMAMTGdiZ0WEyEEz8PqgNmmF8Fo2J1PNgwrvE31KnFqzV/Bzra1Ifx0NjhEnoxkjb
	it+39ODzB2ipt11L3/H2SjNIPvz8gYLVqmqxJ4hstrxbZyzJ+8g+wWS1pa9rgV1jheEsjulftM2
	VHEG5WmbpTLxl0gNn3bq3O1uAiuxKjcjAU3A5L8+60vhVzwS4ruWjdLVgJEXbnK7q8OPDxSfI2k
	n7O+Q=
X-Received: by 2002:a17:902:ea02:b0:2b0:67cc:adc3 with SMTP id d9443c01a7336-2b06e339ee6mr43173795ad.14.1773861235661;
        Wed, 18 Mar 2026 12:13:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e63a971sm61344895ad.83.2026.03.18.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:55 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v3 11/12] net: netdevsim: Add support for SW USO
Date: Wed, 18 Mar 2026 12:13:16 -0700
Message-ID: <20260318191325.1819881-12-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269168-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3095A2C1EFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for UDP Segmentation Offloading in software (SW USO). This
is helpful for testing when real hardware is not available. A test which
uses this codepath will be added in a following commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 rfcv2:
   - new in rfcv2

 drivers/net/netdevsim/netdev.c | 100 ++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c62..f7dd7692a5d9 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,7 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <net/tso.h>
 
 #include "netdevsim.h"
 
@@ -117,6 +118,98 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
 }
 
+static netdev_tx_t nsim_uso_segment_xmit(struct net_device *dev,
+					 struct sk_buff *skb)
+{
+	unsigned int hdr_len, mss, total_payload, num_segs;
+	struct netdevsim *ns = netdev_priv(dev);
+	struct net_device *peer_dev;
+	unsigned int total_len = 0;
+	struct netdevsim *peer_ns;
+	struct nsim_rq *rq;
+	struct tso_t tso;
+	int i, rxq;
+
+	hdr_len = tso_start(skb, &tso);
+	mss = skb_shinfo(skb)->gso_size;
+	total_payload = skb->len - hdr_len;
+	num_segs = DIV_ROUND_UP(total_payload, mss);
+
+	udp_hdr(skb)->check = 0;
+	if (!tso.ipv6)
+		ip_hdr(skb)->check = 0;
+
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out_drop_free;
+
+	peer_dev = peer_ns->netdev;
+	rxq = skb_get_queue_mapping(skb);
+	if (rxq >= peer_dev->num_rx_queues)
+		rxq = rxq % peer_dev->num_rx_queues;
+	rq = peer_ns->rq[rxq];
+
+	for (i = 0; i < num_segs; i++) {
+		unsigned int seg_payload = min_t(unsigned int, mss,
+						 total_payload);
+		bool last = (i == num_segs - 1);
+		unsigned int seg_remaining;
+		struct sk_buff *seg;
+
+		seg = alloc_skb(hdr_len + seg_payload, GFP_ATOMIC);
+		if (!seg)
+			break;
+
+		seg->dev = dev;
+
+		tso_build_hdr(skb, skb_put(seg, hdr_len), &tso,
+			      seg_payload, last);
+
+		if (!tso.ipv6) {
+			unsigned int nh_off = skb_network_offset(skb);
+			struct iphdr *iph;
+
+			iph = (struct iphdr *)(seg->data + nh_off);
+			iph->check = ip_fast_csum(iph, iph->ihl);
+		}
+
+		seg_remaining = seg_payload;
+		while (seg_remaining > 0) {
+			unsigned int chunk = min_t(unsigned int, tso.size,
+						   seg_remaining);
+
+			memcpy(skb_put(seg, chunk), tso.data, chunk);
+			tso_build_data(skb, &tso, chunk);
+			seg_remaining -= chunk;
+		}
+
+		total_payload -= seg_payload;
+
+		seg->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (nsim_forward_skb(dev, peer_dev, seg, rq, NULL) == NET_RX_DROP)
+			continue;
+
+		total_len += hdr_len + seg_payload;
+	}
+
+	if (!hrtimer_active(&rq->napi_timer))
+		hrtimer_start(&rq->napi_timer, us_to_ktime(5),
+			      HRTIMER_MODE_REL);
+
+	rcu_read_unlock();
+	dev_kfree_skb(skb);
+	dev_dstats_tx_add(dev, total_len);
+	return NETDEV_TX_OK;
+
+out_drop_free:
+	dev_kfree_skb(skb);
+	rcu_read_unlock();
+	dev_dstats_tx_dropped(dev);
+	return NETDEV_TX_OK;
+}
+
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
@@ -129,6 +222,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int rxq;
 	int dr;
 
+	if (skb_is_gso(skb) &&
+	    skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		return nsim_uso_segment_xmit(dev, skb);
+
 	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out_drop_any;
@@ -986,7 +1083,8 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_HW_CSUM |
 			    NETIF_F_LRO |
 			    NETIF_F_TSO |
-			    NETIF_F_LOOPBACK;
+			    NETIF_F_LOOPBACK |
+			    NETIF_F_GSO_UDP_L4;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_HW_OFFLOAD;
-- 
2.52.0


