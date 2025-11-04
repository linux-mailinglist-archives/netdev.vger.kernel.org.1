Return-Path: <netdev+bounces-235446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A494EC30AF8
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 12:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E693A7D5B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DC82E2DDD;
	Tue,  4 Nov 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGNDqEQh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVIcykZX"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83892E426B
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254727; cv=none; b=HbtmBBZUjvp6aOZdvUW8A1/uvzmDy3cJo1Jb++449lLDrYJa13iab4wjgKYnpYVR0kToQJ/rqqGC9e4r1c9Y/i60YGbsyHngvpMyvIpaXVngtOoSAmwPbGziVXzuXnU2loBa6i9vSeJZU+uOammlIyRvyYWkiCwceLmTO6J+d/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254727; c=relaxed/simple;
	bh=/YkuHa6v1dNtoE23mdpsRTScQ6ZC42fxCgxw7gY2lbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rD4RNfGDZeo0j0Wu+JET1l3SGXeQIOeK9S+y4pBs+1Dk/mXbD1H1sSc3mG+8xVzDzAQa33xeQTmBf2PTMzggmGZiyv9IqVhNRvQulccxfrj5+DszJVP5dFyfFfhdvP9+2rRQzCpQys35H3sDtWaolM9RsaFBDHdLxqexu6V07Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGNDqEQh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVIcykZX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Nov 2025 12:12:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762254723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GeSlkKbtcpufCLOJlTlGV4t9LhwRk+9N4J8rKH3yPSM=;
	b=VGNDqEQhcThh4Cl+MtKeaN2cGbZ1Krt7fKgcOv27R7nYrOn6UBOOM7vIy62aUaVUw7EJgt
	iv7Vp0Xbq98wae8mFNIlnK7mNLZvjLvPxNRXltxPgjreebE0+0lrJ5LFCbwrEnSbFF0IwR
	ffET1/7yOxCHQD2DhIDekJGY5hjCfUaSsTPeL9DIXn7KRPQvkjeAEAwytiil0SxdHQruSx
	NvJqujWauN47OZKxlzt52lpUnYXABLLZSvvxE7OppxrhIi6VbOwCY/VNz22q//25Z1iI/d
	b2xWlzfNmKkNo8b/BNofNrn/2f+pK2WlEhWFOopn9zsrtySaEszTr+1aXEYLMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762254723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GeSlkKbtcpufCLOJlTlGV4t9LhwRk+9N4J8rKH3yPSM=;
	b=iVIcykZXAbJqUCb8O5ew69FPvjZtvE1ETAQ5EblF90LFxjjB4oaNOrvPkf6sGK4gaCeMkM
	0zcQuuCKfoYHAcBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>,
	linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH net] net: gro_cells: Provide lockdep class for gro_cell's
 bh_lock
Message-ID: <20251104111201.5eBxkOKb@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

One GRO-cell device's NAPI callback can nest into the GRO-cell of
another device if the underlying device is also using GRO-cell.
This is the case for IPsec over vxlan.
These two GRO-cells are separate devices. From lockdep's point of view
it is the same because each device is sharing the same lock class and so
it reports a possible deadlock assuming one device is nesting into
itself.

Provide a lockclass for the bh_lock on for gro-cell device allowing
lockdep to distinguish between individual devices.

Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
Reported-by: Gal Pressman <gal@nvidia.com>
Closes: https://lore.kernel.org/all/66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/gro_cells.h | 1 +
 net/core/gro_cells.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/gro_cells.h b/include/net/gro_cells.h
index 596688b67a2a8..2453d0139c205 100644
--- a/include/net/gro_cells.h
+++ b/include/net/gro_cells.h
@@ -10,6 +10,7 @@ struct gro_cell;
 
 struct gro_cells {
 	struct gro_cell __percpu	*cells;
+	struct lock_class_key		cells_bh_key;
 };
 
 int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb);
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index fd57b845de333..a91fdc47e8096 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -88,6 +88,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net_device *dev)
 
 		__skb_queue_head_init(&cell->napi_skbs);
 		local_lock_init(&cell->bh_lock);
+		lockdep_set_class(&cell->bh_lock, &gcells->cells_bh_key);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
 
-- 
2.51.0


