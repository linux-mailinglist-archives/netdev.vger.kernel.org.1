Return-Path: <netdev+bounces-304734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4StCMKSbSWph4QAAu9opvQ
	(envelope-from <netdev+bounces-304734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:47:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25475708A5A
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:47:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XLPwZYb4;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304734-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304734-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C14AC302C5E5
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 23:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1423CDBAB;
	Sat,  4 Jul 2026 23:47:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA42E8897
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 23:47:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208830; cv=none; b=JKbgnHIlzGEK/oBR9bsacrw198kwL7g1HqLPCKZWa8xhW9XFDAnYr5WEvzI2r3Q90kKDj5AO6FR9VXZap1Z2JQu/YFNF3ogZffPPVC37+Ai7tADAOWU1nRCUbDCzMgArNy8bZon1iO87+9NYGd8BOQGSRkiDFejZMwJ1aIrfH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208830; c=relaxed/simple;
	bh=WmdVxG1qjyumTLg0dAYkqMTScBrx63gA3nVyRq5XgG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpLHwuDbd91n+Mfkyvw/YOPcNT7PyyVOAiMIQWwkbzBIlhuVQ4zPuIJZIJk7Et6CiECNcYtimfo5x5hCkqsYTl5E9R9qD4mwtWkLHgVudzd/RoS6LWqLngt6YFQ8bgABMBT526SKyf97b/DlqIubUPCY/yXNWy9m7xT5k/Y/tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLPwZYb4; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4629324e267so224761f8f.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 16:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783208827; x=1783813627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2AK/8mBVRm/uASU3oq6CXiRGB/9zBaQ2taBmIKBqgA=;
        b=XLPwZYb41pfPaC0ovv/karFQTLFAp2SmbTk8rr5dI8DrZp72Rg/iXc0JEPsGyi1dtr
         /VJeETSB+GHfAZ3+htxi+kX9npUCJJACKmUChGbYhocbGsqxmUpYbA1BPKs6knjw63G/
         LQ/VDJAf0sj2dT5zfiW3llo1MngL6Dg85Y0BH+YJhdtEYxrlXvb9wg0FOWQZ645fXJdC
         MVV4g0vCja8KwRecPY4O168utBPrlqC7x05p/iVzOHQ1hJ6BIARlnHWfy97v8EhIQ90r
         e3IVpz2R+1bLmQ4gLl0kTbS1I7BPjNDsgV9FNS3V+LNqRcxteTwIIykhz8MK1POwCg9d
         nfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783208827; x=1783813627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2AK/8mBVRm/uASU3oq6CXiRGB/9zBaQ2taBmIKBqgA=;
        b=iwX5m3Y9WN5MPP7l9E7JiaanEMh95PpPKL31qulrJRKUSJi1qP6xDfxRwg+YecA4wf
         tv7jUm6EtJMPp1/1jFUEFQa65dBHuW1PTmd6sn0rU6nIRrLa4fp7reLmdWFjmbhfFOyv
         BfIwaSPFJT/1XsF18ZU7F3rXTVw2iMZ9WdYRthH2Yv9/jMihc1a5A94e+LL9/PDcH/Iy
         GwE67Ygqru1PiZEOiBcVkJk9/N/um42bYwA9GhLd8XV0E67GOKyb7H4CjCSKCe3uvX1n
         Uu1ynODD3zZ1v+IfBi4TZN1odamTn9tnA7O4QMnD+nFPV0BvilEwWoSmrR1Uc87qPwsH
         gt8Q==
X-Gm-Message-State: AOJu0Yyoh5HzKSKTJyvwS6KeqSOco4UHjNICXso30t44Fd77zzXoQdpQ
	cCSoRFjGfqj5WY80Da6unPMfNprFefUGPwX/A+2BSlRIi1RXJnPBiApmbt+9TinJ9mg=
X-Gm-Gg: AfdE7clgPcwTVnux/Qgotv2dvFwA15Nf4PhtG4xD5z68apZyju+TSaWKMI0YnOBrz/d
	ZscGEilRC/6A9VgcdEKQ22pzh7S6zauRACbpGxoaQHBn3RkPDMlZ+ua1ShZIetBy2jRVp/BdsSQ
	7wlfOLuEvDhQtueKxTKErlRCfWypnEwhXDc34RieVLiFbRGeAQXZA8OmOEQcXPK04s+ODOVPjUq
	5EaH3WzHaZoeOKs0D8uBUrZQeKFEMUXFLosn+2V4QD1ILml98SRAEORXhyALWMZWnUvscsFCRPD
	/gnXGmruUJnpCmpPTn+In6r84xqDtQLQTPK1+uBcVCRJj9ghEj/2RSMuHT89dbgTwMiFdIDREAA
	9/kXUwaa1NZF5M3o70PITKr+yL1bvW9yZmNni08ehh0Qc2OfWD0iXguLU/DjQbGep/hl/dzj8JU
	3C8VDV7osI9LPyoK2LHXYiVy6BJ/TkIhkY77TPrYeZ5E/MweQz0ArDTealk/4mX103hHHLPrUAt
	wBStjvTaP6mhWbbjC1n0lCVhTT3GHduB9wVk9y2mBz1WmCQ+F8=
X-Received: by 2002:a05:600c:83c6:b0:493:cc01:8067 with SMTP id 5b1f17b1804b1-493d0f48594mr30891745e9.8.1783208826853;
        Sat, 04 Jul 2026 16:47:06 -0700 (PDT)
Received: from hpubt (dynamic-2a02-3100-5cf8-ddfc-6651-06ff-fed8-72a4.310.pool.telefonica.de. [2a02:3100:5cf8:ddfc:6651:6ff:fed8:72a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm216014125e9.10.2026.07.04.16.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:47:06 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next 1/4] net: hsr: add PRP interlink (RedBox) datapath and duplicate discard
Date: Sat,  4 Jul 2026 23:47:01 +0000
Message-ID: <20260704234704.4297-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704234704.4297-1-xiexinet@gmail.com>
References: <20260704234704.4297-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304734-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25475708A5A

A PRP RedBox proxies SANs that sit behind an interlink port: their frames
must reach the PRP network with the SAN source MAC preserved, and PRP
unicast must be steered between the LAN and the SAN segment correctly.

Add the PRP interlink forwarding rules to prp_drop_frame() and give RedBox
nodes a second duplicate-discard slot so the two LAN copies of a frame
destined to a SAN collapse to a single delivery out the interlink.

The destination classification (is the unicast DA a PRP-network node or a
proxied SAN) is resolved once per frame in fill_frame_info(), gated to PRP
RedBox devices, and cached in struct hsr_frame_info, so prp_drop_frame()
stays O(1) and does not walk the node tables for every candidate egress
port in the softIRQ path. HSR RedBox frame classification is untouched.

Factor the LAN A/B duplicate test into prp_is_lan_dup() so the new PRP
interlink rules do not change hsr_drop_frame() behaviour, including the
NETIF_F_HW_HSR_FWD path which keeps using the LAN-duplicate test only.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_forward.c  | 49 ++++++++++++++++++++++++++++++++++++------
 net/hsr/hsr_framereg.c | 10 ++++++---
 net/hsr/hsr_framereg.h |  2 ++
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a6..efcd0acef 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -440,12 +440,37 @@ static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 	return dev_queue_xmit(skb);
 }
 
+static bool prp_is_lan_dup(struct hsr_frame_info *frame,
+			   struct hsr_port *port)
+{
+	enum hsr_port_type rx = frame->port_rcv->type;
+
+	return (rx == HSR_PT_SLAVE_A && port->type == HSR_PT_SLAVE_B) ||
+	       (rx == HSR_PT_SLAVE_B && port->type == HSR_PT_SLAVE_A);
+}
+
 bool prp_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
 {
-	return ((frame->port_rcv->type == HSR_PT_SLAVE_A &&
-		 port->type == HSR_PT_SLAVE_B) ||
-		(frame->port_rcv->type == HSR_PT_SLAVE_B &&
-		 port->type == HSR_PT_SLAVE_A));
+	enum hsr_port_type rx = frame->port_rcv->type;
+
+	/* Supervision frames are not delivered to a SAN on the interlink. */
+	if (frame->is_supervision && port->type == HSR_PT_INTERLINK)
+		return true;
+
+	if (prp_is_lan_dup(frame, port))
+		return true;
+
+	/* LAN to interlink: keep PRP-network unicast off the SAN segment. */
+	if ((rx == HSR_PT_SLAVE_A || rx == HSR_PT_SLAVE_B) &&
+	    port->type == HSR_PT_INTERLINK)
+		return frame->dst_in_node_db;
+
+	/* Interlink to LAN: keep SAN-to-SAN unicast local. */
+	if ((port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B) &&
+	    rx == HSR_PT_INTERLINK)
+		return frame->dst_in_proxy_node_db;
+
+	return false;
 }
 
 bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
@@ -453,7 +478,7 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
 	struct sk_buff *skb;
 
 	if (port->dev->features & NETIF_F_HW_HSR_FWD)
-		return prp_drop_frame(frame, port);
+		return prp_is_lan_dup(frame, port);
 
 	/* RedBox specific frames dropping policies
 	 *
@@ -466,7 +491,7 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
 	 * are addressed to interlink port (and are in the ProxyNodeTable).
 	 */
 	skb = frame->skb_hsr;
-	if (skb && prp_drop_frame(frame, port) &&
+	if (skb && prp_is_lan_dup(frame, port) &&
 	    is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
 	    hsr_is_node_in_db(&port->hsr->proxy_node_db,
 			      eth_hdr(skb)->h_dest)) {
@@ -706,6 +731,18 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 	frame->is_vlan = false;
 	proto = ethhdr->h_proto;
 
+	/* PRP RedBox only: classify the unicast destination once so the
+	 * per-egress-port decision in prp_drop_frame() stays O(1). HSR RedBox
+	 * does its own classification and must not pay these node-table walks.
+	 */
+	if (hsr->prot_version == PRP_V1 && hsr->redbox &&
+	    is_unicast_ether_addr(ethhdr->h_dest)) {
+		frame->dst_in_node_db =
+			hsr_is_node_in_db(&hsr->node_db, ethhdr->h_dest);
+		frame->dst_in_proxy_node_db =
+			hsr_is_node_in_db(&hsr->proxy_node_db, ethhdr->h_dest);
+	}
+
 	if (proto == htons(ETH_P_8021Q))
 		frame->is_vlan = true;
 
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index e44929871..7a7c52a95 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -199,7 +199,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	spin_lock_init(&new_node->seq_out_lock);
 
 	if (hsr->prot_version == PRP_V1)
-		new_node->seq_port_cnt = 1;
+		new_node->seq_port_cnt = hsr->redbox ? 2 : 1;
 	else
 		new_node->seq_port_cnt = HSR_PT_PORTS - 1;
 
@@ -649,9 +649,13 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 	if (frame->port_rcv->type == HSR_PT_MASTER)
 		return 0;
 
-	/* for PRP we should only forward frames from the slave ports
-	 * to the master port
+	/* RedBox: forward LAN frames out the interlink to a SAN, deduping the
+	 * two LAN copies on a dedicated slot.
 	 */
+	if (port->type == HSR_PT_INTERLINK)
+		return hsr_check_duplicate(frame, 1);
+
+	/* For PRP only slave-to-master frames are forwarded. */
 	if (port->type != HSR_PT_MASTER)
 		return 1;
 
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index c65ecb925..127a3fb64 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -27,6 +27,8 @@ struct hsr_frame_info {
 	bool is_local_dest;
 	bool is_local_exclusive;
 	bool is_from_san;
+	bool dst_in_node_db;
+	bool dst_in_proxy_node_db;
 };
 
 void hsr_del_self_node(struct hsr_priv *hsr);
-- 
2.53.0


