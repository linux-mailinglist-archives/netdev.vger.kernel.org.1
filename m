Return-Path: <netdev+bounces-271539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL1VDj7lw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D99325EC6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A1143258AC2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4A3D7D84;
	Wed, 25 Mar 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfPuW1QA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31B19CD0A
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443097; cv=none; b=I80ZDGRQBSZ0/QBntQH6LY7ozutI9dXBNHgWzDLXwKtk3vUf5s3WA7GNh/b9l4eWC1O+j/WxhCwmCZCkgwTQiY1gAk9MvKXC1jHU0n3fYw90ONX7pyf6t5cGQk5nsel5k+BfsTPEGYLPRXEAwnJSxRSQa2djS1WUHF24TVpCmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443097; c=relaxed/simple;
	bh=t+Mmq97q0+Y4r7U9kkN220HidCPG3ilvBfQAl/C7/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZryyE/InzfG8gJqqinzlDW4iC0KAGPVUujiYTNgGhuoXw8waMVRf6zrpCXmEZEyymPFDhju8U2kmv2bnCyW3H+CCd8fwjAlJ6CDEB3lt/fahw0c0ikjYk7DQxwWR9o99uTeKY2knekrLf3Z+Eloa+jfQ619zGWpd/VzYSK5NNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfPuW1QA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439fe4985efso4384677f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774443094; x=1775047894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+00FPqAZdZFOBnToh7PSc/BbUeRaxTEXoOHmtGunL0=;
        b=PfPuW1QAkcf5+sYEU+pMiIaSaKKode9mgkyiKMlXM5bw/Vb++Wquc8YBAwBf6+kA/y
         NjKjJsZ6TkN25FXWE3920/Sf8is18aSEJTD7zE8yux+I/t7zRI5v3TtIH1WFBV0Pb6y9
         7RCEacegcECAvlpGaXXRcnh7/NJBTZ9vrS8oVrgaVPHEqq39wUFzTFcYFcyPXC/ZW5c0
         pHNn9jPkRT07UJiv0zpKrDxa7JVCmAQXAbo3H5qTfszhvhuwpN0Xeh6un38QD4ziL7/6
         sEWIiTijjyHzfLOygmB6xNbkCiZbvvEsp9yfipSsoYOcLswIe+6myD2q63oakvTJdU1f
         k7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443094; x=1775047894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+00FPqAZdZFOBnToh7PSc/BbUeRaxTEXoOHmtGunL0=;
        b=gTduHQc0jbkX4Zmztvc922R885wk6DAwuusyl7Pvg/8BLl7ZNO3pZwnsax1+GgaZ6z
         VKa657BhgSlIQj7m4j/7qqrbveqdzEeJU+asqBcXSJz6wPBwMjI7CCFXwbD8LXvg/gnU
         Z0rjIB7f9R49MHfpi5TskmW1pBwHjHkJOlhmbWMqbc0aO1c8NENftiFyNv56cxl9Eo0E
         kbDrwQSe+DH56cKMKFrNfSN8qrin6pKPISHvncD6Mpz+iW4OJSpi+/FK9PCXM1jkABz1
         gqylzYwZhuys74yfuxeJbPSvqZ3zjsuz+qj0dioBl+sC/GKVGwiprjiK+IMhCnwQn4hA
         eAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdoIXUgLSMJztBAdPaMeDRmHCuxSIN8V5ZmgJt5x3EMplflStE7goiBadqPAW8ZjZHrNnJiY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYsAA+cYMai3EY6YhB5uV5JqJAWTAj5hVli8BfZq8NSTWXCrP
	4GYNlyQg0nhgNazJ5Q0nADwXb3G5UfCySq760OWo4l0LaY01fmM8a7ch
X-Gm-Gg: ATEYQzx9ral8/lyOai9begUzvgzMAu1HVqJ4pOTpQVYNgPuHL5cK2cSWStzGNV/9f9g
	FUrRi5Hho/oY8KqJ5c2NDPSUqpl8+oyar61CRjiv1k0n96hgqCp6j7m7+rdPZepby5sPCuD1HZd
	omNzWVFpGSFn6Qrm9iM1PbYIhEajzcK5UUDBkNV07Vd+er8GTWhuqJlgerfYmpfqVDKGY7ibHAc
	TnOEOo9b/t8Ehz8LWXdZewQgMQViWMmeXuBXbwNFMpy+N0k49uiN41tgdSvOvo6iOIbTLK9GvgK
	u65nuJ2kND2O3oibJiWwUlFpbtYGES9E+M/TjgnMMnVqUaWvB7RxQ54EytWsBiCjIF2875ZtmnH
	aci5KP7LqGlIJ7C5supaZRDFIZnMdVHvOBtK8LLNJX8n+lTdU0RfNsP9S9PK6EBt3O8okdtUu1d
	voVF1SylwIRni7kKWrQK54o6aXS4fk9Msv/bFg3WyyAKYse3WS6cRn3GXH/Kj48fOxzkmbAa5wM
	Xr2hXIr1LIy
X-Received: by 2002:a5d:5d07:0:b0:43b:4ec7:f924 with SMTP id ffacd0b85a97d-43b88a05423mr4922876f8f.34.1774443093930;
        Wed, 25 Mar 2026 05:51:33 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b90f170dfsm543125f8f.5.2026.03.25.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:51:33 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: m-malladi@ti.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong recycle in ZC RX dispatch
Date: Wed, 25 Mar 2026 12:51:30 +0000
Message-ID: <20260325125131.53399-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,intel.com,kernel.org,lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-271539-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8D99325EC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
never copies the packet data from the XDP buffer into it. The skb is
passed up the stack containing uninitialized heap memory instead of
the actual received packet, leaking kernel heap contents to userspace.

Copy the received packet data from the XDP buffer into the skb using
skb_copy_to_linear_data().

Additionally, remove the skb_mark_for_recycle() call since the skb is
backed by the NAPI page frag allocator, not page_pool. Marking a
non-page_pool skb for recycle causes the free path to return pages to
a page_pool that does not own them, corrupting page_pool state.

The non-ZC path (emac_rx_packet) does not have these issues because it
uses napi_build_skb() to wrap the existing page_pool page directly,
requiring no copy, and correctly marks for recycle since the page comes
from page_pool_dev_alloc_pages().

Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index fd4e7622f123..a28a608f9bf4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -902,6 +902,7 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
 
 	skb_reserve(skb, headroom);
 	skb_put(skb, pkt_len);
+	skb_copy_to_linear_data(skb, xdp->data, pkt_len);
 	skb->dev = ndev;
 
 	/* RX HW timestamp */
@@ -912,7 +913,6 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
 		skb->offload_fwd_mark = emac->offload_fwd_mark;
 	skb->protocol = eth_type_trans(skb, ndev);
 
-	skb_mark_for_recycle(skb);
 	napi_gro_receive(&emac->napi_rx, skb);
 	ndev->stats.rx_bytes += pkt_len;
 	ndev->stats.rx_packets++;
-- 
2.53.0


