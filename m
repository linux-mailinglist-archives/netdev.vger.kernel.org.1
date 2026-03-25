Return-Path: <netdev+bounces-271476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NNsKWasw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:35:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 122543224CC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E1453010175
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689513537C7;
	Wed, 25 Mar 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq/MrWFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC832D441
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430960; cv=none; b=NXTWY4uYT6xQTgTN1phGoFa02uXEIp7w41wV23NX6N1kUrsGOzkalJJc4XfqFsNNz3WIwIoVDLSOY9Et/vZxvVu0nE/hbhHthxhi7uZ8vU71VbLc0OkObjfMuO9xwXhqvde/UqO696IkkCZQmO6yImQ1R5d1MAJlttoBUkD+PXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430960; c=relaxed/simple;
	bh=Fl4i/2qN90vAZ3AxnzKlLBVeZaxs7Fb4skAITwEHPgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQso82iWnNm6H8hpvil4GUGjTCh6L6U4NdaQmE+LDbcl0bYEoRH5fYVhngBm0BkuzYi9JDyCeKnNqQTzsZZ9+els79Kz0I8bGPFimi5O+0STev18uXN2GxQJTALAbuKcUT5yxNxHm6JsJsuuCiWEWajNFYa+wRLGEPfz4bkoqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq/MrWFW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b9b1900bso3306520f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774430956; x=1775035756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13dm/ncu2NQrsod/TJ+EG09PLS3Jy1pWWd8SpfRZVX0=;
        b=hq/MrWFW4ROABy00qJ4jt0w/1JY+u72n0oRWE5VdRY7HJQcLAHZExTuE4nYVWgJuCa
         QWovtQy2EOAbAu6+yDDQWetOiO9OhwGcMiyNqKC0VN844gE/4H4X76V5VH0fLdSafk0R
         fWmSGfXLd7t8bAjmHMB16gNi5Wfg8JJPqLMRRkevWQU4tt4rvOMzlCuKIz+o5yJen4AP
         zFtfHJH768gQ6ZetXQLvK2mSo3DdbNL7UN8Lf5U6OzRn/2UuhjJBnBk2PNtgyhmBsd7n
         7ETQEdbVzhnnmKpymEgZ16bWpe8eErnwa8bncrZcxQIrf4D7YLYbjSe3D+l2DTFg/och
         SnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774430956; x=1775035756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=13dm/ncu2NQrsod/TJ+EG09PLS3Jy1pWWd8SpfRZVX0=;
        b=RAbeURc1uBdBZ4cwqmkX3EK7jh7GTpQKvNubsLsGhEV154bPb/dMbRRhq1DRyhKa2p
         CRvusvurO1vZmH47iYlMX4+36K487bR110KWGDKnyHfabQsiZdOpctkCUijrG1Pnxn5Q
         PF6K5R8EU04k01ksxx1fbAY8Am/KypXOSxjvnfR96/aq9sjvDgpOZMC/uqB6mEKC8E53
         1js5vc0lT6AaHhI5MIH+hP+KOoL51nB5+lnWQAsYHYoSKqjI0FIX8HfDdT73W0ZLkjD0
         vjLA3i2QpMHRBE7xSVRtNxEcR2fbakWXCOcYhd8bP9Q0aiNeOqQK0QRj3nMjc+8+1mLt
         AZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe/7uTNWmd8avMWoqYZQAQQWGDfCWL6CBIPjSTJvt0IsRuCAwPDM8NdqVVmOaWX7GxPQ7LLsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwrwwJh+SEQTwQczJhKnuMDsnTxbBvWOulKvQYK+OvJMOhqNnb
	/Y4OxUivwGKJ2kMbRihI+YV+pLTgE0yCuzbRVn2tKgFxJKd3xee+gGdv
X-Gm-Gg: ATEYQzykK/1s8YBUr0Et5kqpqnROGqQC6oUIC5+kg2bA/8ngDSQqHA8rkckjwfYM5Lx
	0rJQ2fmVB7UoxgPGdLxXaKw39dmq7hEj7tEMa94kIiy4ihmNHyKoUnCVk2LuUuDSWvX6+2xzxx+
	8aMZe3/5tTeJCxSKVv9VWEP/2OCFYcemZgiwmh39BStTDAJ+f4JIRTgZ1BAajKWEx5fXOnGLWjJ
	Yhz0rKSVYvcBKiufwXirPJBghqCGI2nLI/seGclyFhOhFoXeaQtWMbIFZt3h6NR2C6DfyK2UHoo
	v7mZoOqeDCjpZq94a/+0YNbx1mo4lA325tD/Y77hqbi8wxETpGlEphgukIDaLd6Sx/WmWrle/Gj
	RgCxgaFDqlKtzfoCKr/6uLLm13xLKnQBLQTwM3XLQyigfD7piNYhtSJpQ/sMcPRve6JjDUaE3z8
	pf9DIlD/BuUCTkuWTkNn7dtX1ujY4I+L1fjGKIZOhE7bERPtODM5S04RBKDfo/sijObNfvXL5WR
	V/iRN+uDAdEdG/3ckNhsew=
X-Received: by 2002:a05:6000:4381:b0:43b:4468:b114 with SMTP id ffacd0b85a97d-43b889db4b2mr3732457f8f.23.1774430955917;
        Wed, 25 Mar 2026 02:29:15 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm46000145f8f.8.2026.03.25.02.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:29:15 -0700 (PDT)
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
Date: Wed, 25 Mar 2026 09:28:57 +0000
Message-ID: <20260325092857.47962-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324211402.342474-1-devnexen@gmail.com>
References: <20260324211402.342474-1-devnexen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ti.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271476-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 122543224CC
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


