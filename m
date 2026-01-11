Return-Path: <netdev+bounces-248829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C8CD0F743
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFEC83042B50
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C734CFCC;
	Sun, 11 Jan 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AYFlH5B2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5DD349B06
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149608; cv=none; b=Yy93+Y3uPYiNiFwlOE2wii+I+CiL3AUDfY+txGjN25p1ud3tsgqFV+2ZAG8gMFimop+PhU9aFS9vAYzjkz2h6OnB+YegfORhx2vsnPFNWK6Kewr0UpJIlDbTXuzgTFQbWUesvnB/I4d1UjPOCv8vrHfe7mmkZ+8ORtV1SK6hHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149608; c=relaxed/simple;
	bh=Mn15dmieKuClfRdYiSBIZkNBP/2QL6cmDNIBoJpWIyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEh31OTDsHydHCPkiWIBXTm8pBCZCA0sn0B3HmLys4iqxBy1eUy8O0QHJZHLTMY/o9Y19u+DC126gl73/z6QUKvymAo9sMJAkJGkF2CqA5SrpeV/z4VlTZmM0luxNQ7kER14IhMVeXUrzT5GkjSFYH0g+XnmCf25if83rQ/6c0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AYFlH5B2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8bb6a27d390so360259185a.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 08:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768149606; x=1768754406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwl+48/4YOCOU19HCgqW+kqkHNskBuphQR6lNrCSG+4=;
        b=AYFlH5B2HmYQh+cpYrl8G29CZBU0YbENddorXyJyVjWlNaqs3X7AOibMmQXwvgD6He
         AThJFBaIj6n/dcg6VSkMKoojZ9KY54mBAfwmr4KT274lxlnzncONpq2ybF6+PHjJYBv5
         Q+FFKN0NLSS8u04a2TqakfcxRCUSy6aYOOsskf+ZGnPhG6SNQmYCMXAyRkhnm15iQq/L
         qY5X9QSd3No5CFr9a71MC77f4SwAs9NnnDBE8Ub25kBKinnrHQTl7M/sEUBF2/212+zY
         eZ91wKzimtekA5aKdzrlG5W+lTS3SkziAaxZ+Ov3CWSnB5iD9uskTkA+xFGCleyjT+FG
         gVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149606; x=1768754406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rwl+48/4YOCOU19HCgqW+kqkHNskBuphQR6lNrCSG+4=;
        b=f7gVDgACid6YOJbTR9nbi8VvVxXx9NJOSWbX59wDirSuG9x83rdJGXLz7dlQbka6Zp
         cQy9nEKUmRGOLZY7qqB20dhjSucRahSkNA/Icwp5jiFVMk/parCogq+UXgsLsWLWGQw7
         ADtmCMN8TdTOYlWu9tnmNyvzJeCG6fFoWfRof7MNf4cfcNZ+W9YU2JjiUWsPuAbMgtK3
         NRenFu223NEGAY9d35Ee5AoqoAoUvcmWuu+tX/phDJxqIbcULEoh5o1fkItc280V5IcG
         w6MvKHGYTORQSORddCzsqNy6p8h6hvQWDRke7nqlPB/6vWbXTYx1GxfZh7/ewx723TLX
         4F5g==
X-Gm-Message-State: AOJu0YxRgDnqcL24YVW6zYth9//AuloFue1U+7p+3hWTU2/gZ26OtMcF
	Im9yYUPY917rusia0MOgEjc162ragi/nSepHqN0DCdh9//Fm6T5N9LQOUqp8geYMGA==
X-Gm-Gg: AY/fxX5mC3OvmOTKb8n75al4Zdz4YJKcGrLxHbXfBkWSu9rCvzpdEc+lSZW1qIYxRDL
	OjoPlj4BlbiIE/HV/4HwWfFYbUW2cjSSA4A4r6v4+INuezANQki1XqV10W3H4ax8JsTwP6X86G/
	katfxDAJndxi8yt+pGnb8hC4x6B0MJlru9CYzzUYhdX9q3Q/rpjAGbMFnm0KJlcpV8Yis+YshNA
	s2WCTHKJGLrS7bThfqa/yxFXMx3M7kPRb17fj0RPcOiAcfvt0fYj9GtuGZwCRXPJBez10PILYPr
	XNRlW9S7gZ7gcuc2Xy5elaRGPsV3JEgkL4HGs4cJF2DAEptQ75+DscnrbTCyZotu+A05JPu3eLj
	mg46IZsjVf3cUrChuyyFQphN6AwxVMCZwaaPm9iBOdK6lsAZbMExs+lSUWg92v7wm30i0DBKBLV
	iEj2Vugdg5Jo4=
X-Google-Smtp-Source: AGHT+IFYLyVuenp031MG79UgIB9Gjt7vRn7bFrZ35LJUro0VwCMf5bD+8Q3XLfZ6gj8+MzVEL7+Daw==
X-Received: by 2002:a05:620a:298c:b0:8b2:ec5c:20bf with SMTP id af79cd13be357-8c38936ea1fmr2095119085a.29.1768149605640;
        Sun, 11 Jan 2026 08:40:05 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1276589085a.10.2026.01.11.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:40:04 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	zyc199902@zohomail.cn,
	lrGerlinde@mailfence.com,
	jschung2@proton.me,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/6] net: Introduce skb ttl field to track packet loops
Date: Sun, 11 Jan 2026 11:39:42 -0500
Message-Id: <20260111163947.811248-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111163947.811248-1-jhs@mojatatu.com>
References: <20260111163947.811248-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to keep track of loops across the stack, in particular when going
across from egress->ingress and back,we need to _remember the global loop
state in the skb_.
We introduce a per-skb ttl field to keep track of this state.

This patch liberates two bits:
1) The bit "skb->from_ingress" is reclaimed for ttl. Since it is currently
only used for ifb, it is safe to move this to local-per-layer skb/tc state
on the qdisc_skb_cb struct.
2) A second bit that was available on the skb.

Use cases:
1) Mirred increments the ttl whenever it sees an skb. If the skb shows
up multiple times we catch it when it exceeds MIRRED_NEST_LIMIT iterations
of the loop.

2) netem increments when using the "duplicate" feature and catches it when
it sees the packet the second time.

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 drivers/net/ifb.c              |  2 +-
 include/linux/skbuff.h         | 24 ++----------------------
 include/net/sch_generic.h      | 22 ++++++++++++++++++++++
 net/netfilter/nft_fwd_netdev.c |  1 +
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index d3dc0914450a..137a20e4bf8c 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -124,7 +124,7 @@ static void ifb_ri_tasklet(struct tasklet_struct *t)
 		rcu_read_unlock();
 		skb->skb_iif = txp->dev->ifindex;
 
-		if (!skb->from_ingress) {
+		if (!qdisc_skb_cb(skb)->from_ingress) {
 			dev_queue_xmit(skb);
 		} else {
 			skb_pull_rcsum(skb, skb->mac_len);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..7f18b0c28728 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -840,6 +840,7 @@ enum skb_tstamp_type {
  *	@no_fcs:  Request NIC to treat last 4 bytes as Ethernet FCS
  *	@encapsulation: indicates the inner headers in the skbuff are valid
  *	@encap_hdr_csum: software checksum is needed
+ *	@ttl: time to live count when a packet loops.
  *	@csum_valid: checksum is already valid
  *	@csum_not_inet: use CRC32c to resolve CHECKSUM_PARTIAL
  *	@csum_complete_sw: checksum was completed by software
@@ -1000,6 +1001,7 @@ struct sk_buff {
 	/* Indicates the inner headers are valid in the skbuff. */
 	__u8			encapsulation:1;
 	__u8			encap_hdr_csum:1;
+	__u8			ttl:2;
 	__u8			csum_valid:1;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
@@ -1016,9 +1018,6 @@ struct sk_buff {
 	__u8			offload_l3_fwd_mark:1;
 #endif
 	__u8			redirected:1;
-#ifdef CONFIG_NET_REDIRECT
-	__u8			from_ingress:1;
-#endif
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
 	__u8			nf_skip_egress:1;
 #endif
@@ -5352,30 +5351,11 @@ static inline bool skb_is_redirected(const struct sk_buff *skb)
 	return skb->redirected;
 }
 
-static inline void skb_set_redirected(struct sk_buff *skb, bool from_ingress)
-{
-	skb->redirected = 1;
-#ifdef CONFIG_NET_REDIRECT
-	skb->from_ingress = from_ingress;
-	if (skb->from_ingress)
-		skb_clear_tstamp(skb);
-#endif
-}
-
 static inline void skb_reset_redirect(struct sk_buff *skb)
 {
 	skb->redirected = 0;
 }
 
-static inline void skb_set_redirected_noclear(struct sk_buff *skb,
-					      bool from_ingress)
-{
-	skb->redirected = 1;
-#ifdef CONFIG_NET_REDIRECT
-	skb->from_ingress = from_ingress;
-#endif
-}
-
 static inline bool skb_csum_is_sctp(struct sk_buff *skb)
 {
 #if IS_ENABLED(CONFIG_IP_SCTP)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3a7268b567e..42d8a1a9db4c 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -459,6 +459,9 @@ struct qdisc_skb_cb {
 	u8			post_ct:1;
 	u8			post_ct_snat:1;
 	u8			post_ct_dnat:1;
+#ifdef CONFIG_NET_REDIRECT
+	u8			from_ingress:1;
+#endif
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -1140,6 +1143,25 @@ static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
 	q->to_free = skb;
 }
 
+static inline void skb_set_redirected(struct sk_buff *skb, bool from_ingress)
+{
+	skb->redirected = 1;
+#ifdef CONFIG_NET_REDIRECT
+	qdisc_skb_cb(skb)->from_ingress = from_ingress;
+	if (qdisc_skb_cb(skb)->from_ingress)
+		skb_clear_tstamp(skb);
+#endif
+}
+
+static inline void skb_set_redirected_noclear(struct sk_buff *skb,
+					      bool from_ingress)
+{
+	skb->redirected = 1;
+#ifdef CONFIG_NET_REDIRECT
+	qdisc_skb_cb(skb)->from_ingress = from_ingress;
+#endif
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 152a9fb4d23a..d62c856ef96a 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_dup_netdev.h>
 #include <net/neighbour.h>
 #include <net/ip.h>
+#include <net/sch_generic.h>
 
 struct nft_fwd_netdev {
 	u8	sreg_dev;
-- 
2.34.1


