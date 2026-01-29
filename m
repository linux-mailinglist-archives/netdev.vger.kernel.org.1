Return-Path: <netdev+bounces-254602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IItWKzwVe2n5BAIAu9opvQ
	(envelope-from <netdev+bounces-254602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:07:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1FAD1C8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5956230156C0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABF37BE63;
	Thu, 29 Jan 2026 08:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E37369993
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674037; cv=none; b=ff5aeeISUXP9U/raNjHkhPqVpu0q9KHCXiEfdupfxs/PX9Zwbamkl34bQKlbIsATC50MHWFFHwNkLIdeV35QsY58q1k/NopKbVQqUvuBuVKCxDM0BkA0iK5HsMmTjqRPQ1pH6x5rx025DWiqdsvFJqAIgVhi6Dpjn+qt6HoKpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674037; c=relaxed/simple;
	bh=L4jc0RFkSEobO61Huzyq9HmNenulyjlvnXHrYnr4Gm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCaotsRvhD0SMVhSedPNfOi7mQYF2dQDbTr84S838uPHIjJzZUIIHc/rPK7VKHKGO7cVj0Ih6N0np7S7XoZqIH5iVSzCI2yX1J+HdDPmmR7VJ8gd6D7woXPl8CgeuGTe2759QUEA56a7he7kqmuIrCM5Sh+q8zeh854pO43KJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vlN3J-0006b0-QZ; Thu, 29 Jan 2026 09:06:57 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 29 Jan 2026 09:06:41 +0100
Subject: [PATCH RFC v2 1/2] tun: support rx-tstamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-v6-7-topic-virtio-net-ptp-v2-1-30a27dc52760@pengutronix.de>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
In-Reply-To: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254602-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.trumtrar@pengutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70B1FAD1C8
X-Rspamd-Action: no action

Demonstrate support for new virtio-net features

VIRTIO_NET_HDR_F_TSTAMP

This is not intended to be merged.

A full feature test also requires a patched qemu binary that knows
these features and negotiates correct vnet_hdr_sz in
virtio_net_set_mrg_rx_bufs. See
https://github.com/strumtrar/qemu/tree/v10.2.0/virtio-rx-stamps

Not-yet-signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/tun.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8192740357a09..aa988a9c4bc99 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2065,23 +2065,29 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr_v1_hash_tunnel hdr;
-		struct virtio_net_hdr *gso;
+		struct virtio_net_hdr_v1_hash_tunnel_ts hdr;
+
+		memset(&hdr, 0, sizeof(hdr));
 
 		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
-						&hdr);
+						(struct virtio_net_hdr_v1_hash_tunnel *)&hdr);
 		if (ret)
 			return ret;
 
-		/*
-		 * Drop the packet if the configured header size is too small
-		 * WRT the enabled offloads.
-		 */
-		gso = (struct virtio_net_hdr *)&hdr;
-		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
-					 iter, gso);
-		if (ret)
-			return ret;
+		if (vnet_hdr_sz >= sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts)) {
+			__le64 tstamp = cpu_to_le64(ktime_get_ns());
+
+			hdr.tstamp_0 = (tstamp & 0x000000000000ffffULL) >> 0;
+			hdr.tstamp_1 = (tstamp & 0x00000000ffff0000ULL) >> 16;
+			hdr.tstamp_2 = (tstamp & 0x0000ffff00000000ULL) >> 32;
+			hdr.tstamp_3 = (tstamp & 0xffff000000000000ULL) >> 48;
+		}
+
+		if (unlikely(iov_iter_count(iter) < vnet_hdr_sz))
+			return -EINVAL;
+
+		if (unlikely(copy_to_iter(&hdr, vnet_hdr_sz, iter) != vnet_hdr_sz))
+			return -EFAULT;
 	}
 
 	if (vlan_hlen) {

-- 
2.52.0


