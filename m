Return-Path: <netdev+bounces-272293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHcDBHzHxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:55:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1933D47E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FB523046FAF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965F3C199F;
	Thu, 26 Mar 2026 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="rtYAUz1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949D3909A6
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569196; cv=none; b=se4jGlEDZWkZ96Y5/xCsRY/B0N6uFQuHsGcCOY+5mp09tvsu5rC2i8xnMRjEmYYP3T6IAL5aT7eBVtjl9Xy4ND/yvNSs9OOCn0mC6ipqmWNdJrQqFQM5bquOeRgGTg2/2UCyXHeE+Kpt7uihxsJyeLYdfVQIRIBToVCNY3JexFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569196; c=relaxed/simple;
	bh=uWnYZfxpXWzMEdoD4OoQj78mYr7rYihNxdLMDApkweE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN1hcNRlEPhC+5wkZDgLIz3kqaCYFP2akGetGao6L2rChQ9uiaHsc5h95J2q1Eqg5oeD7Nd9y2QAZv3nMEEwysaVPwZ9YhfCmE42wzHwdhSRhd9Lb1+XC3EAmH+686c0gD2aN7v8Zc8NxjMUNU7K3bdJWsTTUWOki2oASbRKdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=rtYAUz1S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0c8362d93so5833425ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569190; x=1775173990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGwTwQhNH9Rzs+EHOpg8GEhPLriykUGXInx1g7lVTBM=;
        b=rtYAUz1SqOlo8UK0hQgpJEeyQJoG4AReT6crtCujEHQd7PfnfHqepLv3RznAvdysJj
         oanqLPh4BNyzZWaN73p5d5i64tKgTeQe2V4AlHrrlIcnUhRPmExgW52eXXF6Yz9kwUsn
         Lc4UBfZ7pIvKHGZTw7djU0K/AHnmhAeIrgcalnTzHZza4kGI7oKF2aJChu9Fp860lIII
         C4/eE5FsVohrH/snN/xPB8AXhp7YiNnnuuQA358orNp2Unu0ICJPXg8UBuur1XBOZvv3
         4qTKg6T1ykz6IaI4K7WKRkZbtwqcitEbNg9avgd0wtmyk4+pXNKT5+nlLpBC/eSHtBtL
         ov+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569190; x=1775173990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGwTwQhNH9Rzs+EHOpg8GEhPLriykUGXInx1g7lVTBM=;
        b=aXP8P72mJEbIFneqYPxEIk1HhqIGjzd7Yofgra08gVDQ6CLWn467q/43O2WyYS6FjX
         vJIFog+1FHZJeKzboUlQiWD4rhn8460heMcoY6IjEvakEDFmZ7E51edGi90L4NSz7Ok0
         tjfEj6ggb57rSVzGldGw7DuAI1vPS8FZatG8yK1nz6EjK3cniCuhkto5KwjFJEUWxzqm
         tBt3dvUoxZkoPPNwNxkNplzoTngsWsK1mp2tAhjOs05iopP0vtg4AGaZRvCBbiE0xHZ0
         TYPkY0OboaPmMQ8gq34gYOMPsnBi4xQTA6OVm7chlNECcS+p/nzY6U15CCHF8tMukNDn
         06fQ==
X-Gm-Message-State: AOJu0YxrvGMH0IxaesrOB7gzhwUASYAZ6YpQ1dmqgiVvtptezw+ccnc8
	XMvHcvNII3BU4teodZgGwB1vSvKWhcrBBWT00lnq8ToW/sSR/77ej9ojtCo3k9Qdzc/nAZSxrMJ
	OhKdGxig=
X-Gm-Gg: ATEYQzwXM60PUPQf4moJgWuWDmrorB9kQ5OHZ+0QDhYgQJbrAJWSxTOFbCQr0S+qIwM
	tOKWHi+f6ZwGWnVizm5iJcKaQPgjud02JWZNtEEsQY6tPq5E/C2Nqsq+4w+1fpL9MM11JCbTzey
	tMSilTjXEwrYIBKpNACixO/mSDQFlGKQeW6I4ZIJAGbtF4oDxmzQsiv+tnjLRaMUFLUTDRQ7ZJM
	3+DeR6hhUq8AE2H6zplxNFd54gbwE/52sloR/7vnHdKS1GEqSH4TLGgSD5FE9B7YSS9VT/P3c/X
	NgWQZ8CobVx+Z26zUPNuCfoKXIDDTgdej7GY6sj1Nzdce/KIObQ5ft+Pmuwhu2mb7OVjkeDORc0
	Kn6VWrR5B9SOnfDGmVqBnJAIw+UPuxUWu+hG/vfTuaIs/A0BuqjfmA9WpCzuOEY+B52i8It6+3A
	Q3bdvT6ALJBozUChU=
X-Received: by 2002:a17:902:e809:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2b0cdc3da4emr4232045ad.23.1774569190139;
        Thu, 26 Mar 2026 16:53:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc881fe7sm44411865ad.48.2026.03.26.16.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:53:09 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 11/12] net: netdevsim: Add support for SW USO
Date: Thu, 26 Mar 2026 16:52:30 -0700
Message-ID: <20260326235238.2940471-12-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272293-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama.to:mid,dama-to.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 4CF1933D47E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for UDP Segmentation Offloading in software (SW USO). This
is helpful for testing when real hardware is not available. A test which
uses this codepath will be added in a following commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 v4:
   - Added parentheses around the gso_type check for clarity. No functional
     change.

 rfcv2:
   - new in rfcv2

 drivers/net/netdevsim/netdev.c | 100 ++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c71b8d116f18..f228bcf3d190 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -30,6 +30,7 @@
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
 #include <net/busy_poll.h>
+#include <net/tso.h>
 
 #include "netdevsim.h"
 
@@ -120,6 +121,98 @@ static int nsim_forward_skb(struct net_device *tx_dev,
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
@@ -132,6 +225,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int rxq;
 	int dr;
 
+	if (skb_is_gso(skb) &&
+	    skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		return nsim_uso_segment_xmit(dev, skb);
+
 	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out_drop_any;
@@ -938,7 +1035,8 @@ static void nsim_setup(struct net_device *dev)
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


