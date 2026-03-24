Return-Path: <netdev+bounces-271307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDE6K6z+wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:14:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19F31CBB0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E91A73010245
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609B355F39;
	Tue, 24 Mar 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXmTKLqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A84263F5E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386857; cv=none; b=MYKehkMzSPbTzEmABM90MXfQ3CJYawVaiaIk4YJES5V6vhaLBU33TzI50LIozh4r7x0qZs9D383TwLtAKZkTV8RCva7RR82seC4yh+00xwQ1xcOpF8tj7eH3E20ZLfgg7FXhZWfif1Kn6imfQAPfmcL7P6h3C0P+QCwVL+WN4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386857; c=relaxed/simple;
	bh=WTJ0FoNX4JRvTtdag8FV7/OCbrmsBPZzdhfTzbOgQRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Knhnpg8jCoCHRH17+8PQHtoc552/XE02RCzpdPqPNzUKY8NSQ+z2l+6JShGT2KyYa/nJFtiQS88RkYI2Qe4p5d2ojdF/f38tQLeu6a6SElxY750zfmdMRngsz+YVeBtp1FJGWaBULkkT/TDJP0NBE3WsmL/Rjx4NHbQ/NrIvhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXmTKLqm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b45bb7548so4114780f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774386855; x=1774991655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0hlD208AFhSuYBqKy08Cy7ZWLhaCTrSsTAnuOoWAHk=;
        b=TXmTKLqm7AsK7gztZ6mV8Ewd4GENIh8q3TefU3KOZHVJN/I6ey4VMxXWEu9tmOUKLg
         xf/D9p3qCEE4tkNPYLbgIHfopKCsI+rpCgAz89u5bL6k8zZ3hoZgiQpcoI0NQs7HLzkh
         dSRMvJpzPlsr9DJ62CXMVdKma9pRN3Kyiozvxumdg6DhfNFWRINRO1HemFJ1U/LiYppj
         rkgc2TqfdXJVc8TOnoBnp1XSL0NzvNZhYnDa0Dhi6f6iVHOXs6Vw/ZPMYk7HxxYgZoF1
         +vjif1OsKv4oByskdF5ZPZx+loTG7305fWAeLACWpcAtLjaJLFAAANWydsAMHfsGyWGo
         7GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774386855; x=1774991655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0hlD208AFhSuYBqKy08Cy7ZWLhaCTrSsTAnuOoWAHk=;
        b=sE1XUAQQX9d7IqKKGCUbZjCgt6D2jZjRLXvJ4M9afe0SY+gFRY/PRV3Yv/tuTWZ8m8
         V6pkvbr8fedPAbDjOE3FO1ny9idxQ7V9/Zk7MAK75D9t9/ozDHghrFA2VG2xI3C9jEeK
         aWeRfQ28A7scjxOBSCxbD7lwuyKFcrFt3tW8bydEkucfSwCEiGionxVHjDzchc7HRTRc
         5a7x5k69yW467u8cI9jD4POM3mDa6WJtW1tx4wHWNNE0NFa6jC6aaCRWRlZszBlNbi8m
         uPIHCxiHmC7+3two467BUs6whJ3eNMeERYxkEkg8m6LIvAfC1CoPQGOuO2U8vpm+PFvG
         jF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcQ/YJVsB6XKZPtTyp3ENom2uEtFJerNlgPHvHKc6m3Gzv0uOAWA4g1/G8+NNOpsxFwVHCyGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwirJjyTusxcqp6Akc7kZ13S2vOmX5fcQfEG4fXRBJAoZL6R7Bx
	cim24cNp/gec+0abOar5bp9fTNYYwXzGK9NL0FAwXDtebydymKt9/aIa
X-Gm-Gg: ATEYQzyXP12D1hqYmm0BlGWPpi/epzzumBBm48waxMT7IKSbHzfZoaazypgkiG5Wj4s
	OsiB/lmhZMwtdeuzNrwiYUPUN/9lpVAJ7FLOBXMTjyYw0tcDmO8L2Q/on9xMjrUfMySbzMU+Gl1
	eOGsO3fJXbocFwAaCbufkGitLuNNORC1GOl/jznwlP2gl4OeL/VRXqR47ytmMQz6LPNeyrFRmeH
	kXRvFoKk8C1VCSgTog6VtENgnJaY4UYj+VxQvv8YfdB8zYb8x+3/0iiq6s48ohIM4wpWuxu4RSC
	qKLicgnU+HP//QnVYgT16/EnkO8A1jJ6itQQ6neFlx339gzQSQ/NZ2CzhjSmsJV14ZmNBcmo+C7
	0VWJQ5wrb6DDrlAcRfZJFJtXatwiFGYkZcGn92DEivQkbvRUMH5TiGeSk2mozOIBs4GOl/oj3a9
	tpyZ31Yi/hjOMH0TGHsIRuer9HMRzjD5V3H+LwNAQNMGqIAXw6/HbrxOJ6JyUE+Vb+s8iTjiizZ
	BuRQFH3NpP+
X-Received: by 2002:a05:6000:2382:b0:43b:3dcc:8b04 with SMTP id ffacd0b85a97d-43b88999317mr1450893f8f.2.1774386854626;
        Tue, 24 Mar 2026 14:14:14 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm42951219f8f.35.2026.03.24.14.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:14:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: m-malladi@ti.com,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong recycle in ZC RX dispatch
Date: Tue, 24 Mar 2026 21:14:02 +0000
Message-ID: <20260324211402.342474-1-devnexen@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ti.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271307-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B19F31CBB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
never copies the packet data from the XDP buffer into it. The skb is
passed up the stack containing uninitialized heap memory instead of
the actual received packet, leaking kernel heap contents to userspace.

Add the missing memcpy from xdp->data into the skb data area.

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
index fd4e7622f123..9638a03bebb4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -902,6 +902,7 @@ static void emac_dispatch_skb_zc(struct prueth_emac *emac, struct xdp_buff *xdp,
 
 	skb_reserve(skb, headroom);
 	skb_put(skb, pkt_len);
+	memcpy(skb->data, xdp->data, pkt_len);
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


