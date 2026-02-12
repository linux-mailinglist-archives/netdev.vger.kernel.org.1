Return-Path: <netdev+bounces-258510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLLTNG1AjmlTBQEAu9opvQ
	(envelope-from <netdev+bounces-258510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:04:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D51311EE
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91CC230194BD
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182932C928;
	Thu, 12 Feb 2026 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cXJiJx6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BF2ED84C
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930269; cv=none; b=PL+wTYxWBB1UO+cepBPYYjb8jFL4RpDjQDTq67A4BTKEAhyLiErX8s5cz3U4yZrcemN9keduFiZX7AfIUapus3POQbuKua9NHViS3P985veSU2UfV1tu9tySyCvNZ1ywSsvMiv4NPotXhXpdk97eCCbCIb3rWs/2YUR3ayp6R+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930269; c=relaxed/simple;
	bh=yAe8BnHCNFSiFCM4pa3XN3YNYoC1hE1u4sJ4y/8rSEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gycgwkie2hz+W8CNjZwBqne1KNf/OD9EODpU8rhaO3I5bf1naXGGR48HSa/ZnawxXXgsECHcUM7hxdfpv/a3lAA4nEg3jk53PzPPXjhYdznwkhSpx9zi8yQMjpNMSPHOyN8ESV6opIuqq1SYXiXBbWAOcTlNeAkuYMvk7nfAhd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cXJiJx6n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48069a48629so2344255e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770930267; x=1771535067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+yybNwc9BQ7vv7LSVWYtNCJjONVpbvSsqoqXTOBfK4=;
        b=cXJiJx6njXR4tnVp3gCETmD3veB8177TlIwUTNq8zk1bapMK5qYLI5dWeYHJ+GMmZx
         w5ACE525X/0Gy+44uq4rX3cpxqubFheRdPG/WEcKZHU/kQV3W5mcsWQPGUObIb4n5w81
         xOg84kNeSbS2QCrvC6IyBFbCqtTJI4XMKwC4YA5pk35C8ppicVc12O2SjaAlk7nzp+DC
         pQkuv8Bk5i4WniVKWTOzLbSZTgk1sxtRap7I87itSsvIp4DiAOx0Xvqkc3XnK2V0EkFh
         TJxLPqVMVG1LKGDWgEzBIuLfSpI9VxMLLKWfViwwXC8hDvLZT87iri9j3A9bnpjESZuh
         VwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930267; x=1771535067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+yybNwc9BQ7vv7LSVWYtNCJjONVpbvSsqoqXTOBfK4=;
        b=cwkz/8QlzLJBFlYp+dUfNH78d+s8fCFtchWzKYTTYLZHRFC7yTjNHJqcpR8SPvQvAW
         IodcxGat1D8H0xGHx3p6rmKz4Pw5mWpQzG61ANpT+RUmHJySfnBehvvdT+f0EbMMLZ7E
         dT2Hk77iXYSR1k/5J6hTBaYfdjR62kesG0p8uw4tiMFcpAfSBH2pc7mnq9t3LBQBlqtr
         I29BTSpzdo2OIdIdfBR/ylBwAJYpHzjJBphVXvI/R2FWZf30Zxj+mGKfgoQfb0txP0L7
         2K4lu/bPiTThKDqALIsUZRE9YeuNcF4uMEoKvvH1eOKyy6lfsREI7ZN5KpAmMpH8AdX8
         R0eA==
X-Gm-Message-State: AOJu0Yw95w2N1MXu+CZSlTQNFx0MwKas2yPbRwgUmhNBDJvUw/6R0BHz
	foKd9hgR2+fQZ6QnJ4jn2sFbk74jRriOsH7PdNyQ9/me6bTPF+v2VZLW24uzqnrFx6QxJXE9fYP
	bRwFVrhH5rPZr5HPCNCv3A9gOlGlCgsCSaJKhlQWaagDNApUiXG+CVdc4vK/lLCPY
X-Gm-Gg: AZuq6aLCoCDhnWQzITg7I0Hg/IKGFON21TuuZHZ04tbzA2NJv0/NLUnkmDpF83qGyS1
	gEXR8bIMU8d8/D8+K8Lby0svPXC9kVR+EMYW6jMUw+8d+Dx1qbPPI4DtFze4f4YcAkiPU/MuwFY
	R7H993aCiK8L3C2xGXMktcRXd7SwElNHC9vDKbUTszNTB3j8Mx39p9HaPmsRUlMJW+wRKbXrpgN
	Gffdk7Rrn8ZjNa3Zr5EGHd72rELNvgCbLSx1FCirSpd3HX6V15tcEZe/42D5+vSsjLOMPoxWIuC
	NrEQAWjvxSTfdTOijkJMJwL8CD3jG0buhwFRhHiGxVctAjomOsVPDCtVTOq2r8M+GhYMdG9pboX
	apDFTf8+MTwOSUkIdIXuL31pxGm5NupS+8KMZBdB5PHQ86Rt6f1hOXWt2S7QePZBpnoY40PQcyw
	0y8UYcw/hC3z6atLUux+MgPHtDz1vtqku6ARwI
X-Received: by 2002:a05:600c:34c3:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-48371035be8mr6326665e9.23.1770930266627;
        Thu, 12 Feb 2026 13:04:26 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:af2a:8088:67a4:6046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483719b8e71sm5170925e9.2.2026.02.12.13.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:04:26 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/3] ovpn: fix possible use-after-free in ovpn_net_xmit
Date: Thu, 12 Feb 2026 22:03:28 +0100
Message-ID: <20260212210340.11260-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212210340.11260-1-antonio@openvpn.net>
References: <20260212210340.11260-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E9D51311EE
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

When building the skb_list in ovpn_net_xmit, skb_share_check will free
the original skb if it is shared. The current implementation continues
to use the stale skb pointer for subsequent operations:
- peer lookup,
- skb_dst_drop (even though all segments produced by skb_gso_segment
  will have a dst attached),
- ovpn_peer_stats_increment_tx.

Fix this by moving the peer lookup and skb_dst_drop before segmentation
so that the original skb is still valid when used. Return early if all
segments fail skb_share_check and the list ends up empty.
Also switch ovpn_peer_stats_increment_tx to use skb_list.next; the next
patch fixes the stats logic.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 3e9e7f8444b3..f70c58b10599 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -365,7 +365,27 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* verify IP header size in network packet */
 	proto = ovpn_ip_check_protocol(skb);
 	if (unlikely(!proto || skb->protocol != proto))
-		goto drop;
+		goto drop_no_peer;
+
+	/* retrieve peer serving the destination IP of this packet */
+	peer = ovpn_peer_get_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		switch (skb->protocol) {
+		case htons(ETH_P_IP):
+			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
+					    netdev_name(ovpn->dev),
+					    &ip_hdr(skb)->daddr);
+			break;
+		case htons(ETH_P_IPV6):
+			net_dbg_ratelimited("%s: no peer to send data to dst=%pI6c\n",
+					    netdev_name(ovpn->dev),
+					    &ipv6_hdr(skb)->daddr);
+			break;
+		}
+		goto drop_no_peer;
+	}
+	/* dst was needed for peer selection - it can now be dropped */
+	skb_dst_drop(skb);
 
 	if (skb_is_gso(skb)) {
 		segments = skb_gso_segment(skb, 0);
@@ -396,34 +416,24 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		__skb_queue_tail(&skb_list, curr);
 	}
-	skb_list.prev->next = NULL;
 
-	/* retrieve peer serving the destination IP of this packet */
-	peer = ovpn_peer_get_by_dst(ovpn, skb);
-	if (unlikely(!peer)) {
-		switch (skb->protocol) {
-		case htons(ETH_P_IP):
-			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
-					    netdev_name(ovpn->dev),
-					    &ip_hdr(skb)->daddr);
-			break;
-		case htons(ETH_P_IPV6):
-			net_dbg_ratelimited("%s: no peer to send data to dst=%pI6c\n",
-					    netdev_name(ovpn->dev),
-					    &ipv6_hdr(skb)->daddr);
-			break;
-		}
-		goto drop;
+	/* no segments survived: don't jump to 'drop' because we already
+	 * incremented the counter for each failure in the loop
+	 */
+	if (unlikely(skb_queue_empty(&skb_list))) {
+		ovpn_peer_put(peer);
+		return NETDEV_TX_OK;
 	}
-	/* dst was needed for peer selection - it can now be dropped */
-	skb_dst_drop(skb);
+	skb_list.prev->next = NULL;
 
-	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb_list.next->len);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
 
 drop:
+	ovpn_peer_put(peer);
+drop_no_peer:
 	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
-- 
2.52.0


