Return-Path: <netdev+bounces-272304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGjICkrXxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:03:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD8633DB2B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323E9307741C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7739C2D948D;
	Fri, 27 Mar 2026 01:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E52853F3;
	Fri, 27 Mar 2026 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573267; cv=none; b=ugO9q4zrm7hc0ZkPOPgEAvskOif5pSSDWyXERsh0U3aD3n0MEnhoEg4AMc+N6xXUcHqlUgp9fVapEfhzKkVo7kpLGzw8nzWI+DW+lijXG1tg7FLU/NwMrTZX+VwTqK1EsHk8L8HxE4qaPOU0lMD4fgkIadCIrgEz1yttcEZ9qc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573267; c=relaxed/simple;
	bh=/wXkpPYQ/ht04jeXAlinV81LSM8FswD2vthCmMl94bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnlpX6IVh8EcOGUJ316AaWkPnGT8aoACjn1iNCbAaWxOu/ewEBHWfG2BSPoi+bZ2ws85r4ow1/XsZbvauSi4jkBu9J166rAN98cw1vKmT5HorjKu/eNEiwfKTs6OYgPpjyRDu6ade67OHtJsGbAtzGeehlgbVbt0OBr/gdBtn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5vZJ-000000007Pa-2Vp4;
	Fri, 27 Mar 2026 01:00:57 +0000
Date: Fri, 27 Mar 2026 01:00:54 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Yang <mmyangfl@gmail.com>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v8 3/4] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
Message-ID: <875f2b347c84671bf6ebde0a9db765d7aa4e79c2.1774572749.git.daniel@makrotopia.org>
References: <cover.1774572749.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774572749.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-272304-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: 7FD8633DB2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MxL862xx offloads bridge forwarding in hardware, so set
dsa_default_offload_fwd_mark() to avoid duplicate forwarding of
packets of (eg. flooded) frames arriving at the CPU port.

Link-local frames are directly trapped to the CPU port only, so don't
set dsa_default_offload_fwd_mark() on those.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v8: no changes
v7: no changes
v6: no changes
v5: move link-local check before dsa_strip_etype_header()
v4: no changes
v3: no changes
v2: don't set dsa_default_offload_fwd_mark() on link-local frames

 net/dsa/tag_mxl862xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
index 01f2158682718..8daefeb8d49df 100644
--- a/net/dsa/tag_mxl862xx.c
+++ b/net/dsa/tag_mxl862xx.c
@@ -86,6 +86,9 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
 		return NULL;
 	}
 
+	if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
+		dsa_default_offload_fwd_mark(skb);
+
 	/* remove the MxL862xx special tag between the MAC addresses and the
 	 * current ethertype field.
 	 */
-- 
2.53.0

