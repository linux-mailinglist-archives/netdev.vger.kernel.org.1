Return-Path: <netdev+bounces-270530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAPWEMI3wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:53:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7902F2422
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E76530B501E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074E3AB295;
	Mon, 23 Mar 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBubgH7g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7353AA4F1
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269859; cv=none; b=VG4c/tjU0W1zEeWYGor2UqRMNmIiv9SgkGVXtQLJ3sKMEZdMMUrU1uCPikwx0KVEio9c3LJmmFSSblaq+amXL7fDjjNM9vwgTfJPPp3LRvvTQOxysqbc/5UWbyDj4GhCRKOy8pUQCTX5TOO6GuNsWxGDRQSiMuG2tMljmM6LOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269859; c=relaxed/simple;
	bh=548r9gMCA/18ni+gpqyQyctulc+/2CPQGCx4cl6n0N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNx10Mvo/N4LsUrOFPtXRkMdgKD10PqPMDsqmD8JvyHeJ/4qXkMGmQj0CnE/w/kzdoo8KX1mNqiXegUYQnl9+q/8tEe4SCg6xLGdO8DqUOTaUmQPuYb+29Z7eakfqaabkOW6vp4lUaY+Y6b2EmN0RAZjE4VKwYhRmwaZU5gUELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBubgH7g; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4870206f73bso15543555e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269857; x=1774874657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj+QJzuLWIO+IQAqw2AbMXAfv5dEr1RKmvP+yOmL/nY=;
        b=LBubgH7g+LY6B1ZtUNH8MhBvDiGTz7NGkQMCpbPtF5jLvhtfBYNrQ6lskTLNMH2BVl
         CmEe6FpW0guOIMdJpsJS0G0eokrbH2ZTzYPPYW9S41q3wOJV/W0qnvT9Ih40Po0FFTpw
         ep5Ukvk9AvwfWfWVHFVNF3bn0r8WgU5KLuC0Aig2TAOakPWVl60VW4gkivdYW13ghJCa
         4bJ7xYUUNo7CbEt9F1d0SaSEbgARUQOp45AlYLTYD8T3XdhMN+an18pWR0zJhuXIZ0L2
         2IDc8ItuKIZ8NJ+9PDXv9d/oxf8AbodtnD6kVaSaUhAnTmoKDYBARu6gp7FjVqzBamHK
         sG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269857; x=1774874657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tj+QJzuLWIO+IQAqw2AbMXAfv5dEr1RKmvP+yOmL/nY=;
        b=TyKRKsm0YiJgIX0Uaf79FykVhqB0Q1R71fruFpSJ/imKgmS+yIiMKSCfipMVMzkWhv
         Veizt9Vk/h6V7k8mm23LEevG4PTWI2rwSjiIAqmR3nCbufDmfiW/0YTkaic/PXKhinM3
         bNifoVS1IehgfJno5K/TdkI5wonojC0gK4BSUf1Ij5itXudorJqYytCmZvrWYAw0jig/
         JMsoF2HNNRHTv6g0ve6NSjScMjcXBkOXpNJ2S7QebxJG20AAOSkoAZzvEmlRMdQOVGws
         D1tzb0suxCXqa+YmCoYdpdNZejzBVFThZphs4Og9Ibu9F/+dbTrG0037aDCmzYpQ+QWL
         hOow==
X-Forwarded-Encrypted: i=1; AJvYcCV7m3vsBo9ZE8Fy0h61NvQ4JgrwgGzEuVmDnd4DStyFpNSa9KbiaHjXzHxtjVmdTV8QEtTYgpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENo9WuSZtMnCdkllMzyfQUM4AO2LFWefOl5n6A+puBHNClmnW
	GQgBk0a9VrHK6/cWoh1211BdqnqzQpMlugdpe/aBJSDvALeplZ+/Py6u1GZ0/w==
X-Gm-Gg: ATEYQzwuFAgKq19W/4n0BOXVoDd1UfUCspE2aZxoXJy1IjVcGVq3RcO6QTq4H8n6r8K
	rhrxVMYsSW8UohdlX9kUwkEi/BsdYAz4VolrVAmFFKySxALThVJkWVRMc1jkPV/zIcBydRhKYrX
	vxAhtWp8vPucXV/ovUjclZMwTXhx9HrcGWLyP0VgwhbLyYFKCaGB1f6lXNTzKxqnUktG0/X8yj6
	QXgBiMIb+pKqIZnTC9zA8I6ANW5YQLyp8Gh5UK+LQuDkyBiJeG+jEyxfazG4oJEOSlatmSXYD3y
	Ygh5RCXsk/MLle1WbeDrWp786EOzHjcgaDdsodEr+SKuIhRqQtHCzjqV8VnUdAo6s5lXNqXxy+Q
	rsqrsxl+RbfDKuLO0Z6rOwEwGcxy1GRLcO3ZftTokuxVZ1XfUWE6KZDLo/P+ln7Fseqd6Hvp3aT
	PDQ2Jo6VS02uNDQ+BzlfFAcwiG3AVzDjoBNd14MM5xC32h4o+3HzAt1BimMZWnx5k16dQGKMgtC
	s6tjlSicA==
X-Received: by 2002:a05:600c:a43:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-486fedb586dmr169582445e9.9.1774269856705;
        Mon, 23 Mar 2026 05:44:16 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 12/16] io_uring/zcrx: consolidate dma syncing
Date: Mon, 23 Mar 2026 12:44:01 +0000
Message-ID: <19f2d50baa62ff2e0c6cd56dd7c394cab728c567.1774261953.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270530-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF7902F2422
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Split refilling into two steps, first allocate niovs, and then do DMA
sync for them. This way dma synchronisation code can be better
optimised. E.g. we don't need to call dma_dev_need_sync() for each every
niov, and maybe we can coalesce sync for adjacent netmems in the future
as well.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 070b4941d001..bf3dd15678c9 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -300,21 +300,23 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 	}
 }
 
-static void io_zcrx_sync_for_device(struct page_pool *pool,
-				    struct net_iov *niov)
+static void zcrx_sync_for_device(struct page_pool *pp, struct io_zcrx_ifq *zcrx,
+				 netmem_ref *netmems, unsigned nr)
 {
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
+	struct device *dev = pp->p.dev;
+	unsigned i, niov_size;
 	dma_addr_t dma_addr;
 
-	unsigned niov_size;
-
-	if (!dma_dev_need_sync(pool->p.dev))
+	if (!dma_dev_need_sync(dev))
 		return;
+	niov_size = 1U << zcrx->niov_shift;
 
-	niov_size = 1U << io_pp_to_ifq(pool)->niov_shift;
-	dma_addr = page_pool_get_dma_addr_netmem(net_iov_to_netmem(niov));
-	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
-				     niov_size, pool->p.dma_dir);
+	for (i = 0; i < nr; i++) {
+		dma_addr = page_pool_get_dma_addr_netmem(netmems[i]);
+		__dma_sync_single_for_device(dev, dma_addr + pp->p.offset,
+					     niov_size, pp->p.dma_dir);
+	}
 #endif
 }
 
@@ -1044,7 +1046,6 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 			continue;
 		}
 
-		io_zcrx_sync_for_device(pp, niov);
 		netmems[allocated] = netmem;
 		allocated++;
 	} while (--entries);
@@ -1067,7 +1068,6 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
 		if (!niov)
 			break;
 		net_mp_niov_set_page_pool(pp, niov);
-		io_zcrx_sync_for_device(pp, niov);
 		netmems[allocated] = net_iov_to_netmem(niov);
 	}
 	return allocated;
@@ -1092,6 +1092,7 @@ static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 	if (!allocated)
 		return 0;
 out_return:
+	zcrx_sync_for_device(pp, ifq, netmems, allocated);
 	allocated--;
 	pp->alloc.count += allocated;
 	return netmems[allocated];
-- 
2.53.0


