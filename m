Return-Path: <netdev+bounces-185309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E340FA99BE0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BD95A19A5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1902223DCE;
	Wed, 23 Apr 2025 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dC83HcUN"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4982701CE;
	Wed, 23 Apr 2025 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450084; cv=none; b=UOOrxBlmunzvHcUshNrLAZ5jwnhVULCBfuCbwsi6ZgP782xfj1Ezdv/tG4ejGEp0Vjdwz+AU3WxeFSaVngtiC+gKLg34ziAp7FO+iM8Xxkl243jAIMUmXkuECpGbdZgtQmjGWK3TFBbCvoFkpQH8CWiWlZiyQE4FAw326ykMG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450084; c=relaxed/simple;
	bh=AcwVzUr6pE9bCY23yNLgHQDCmdVftwicqQIJmHKGyDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcgJL+/Qo/uK4bGG2BljFt5MIYrxkNUXKSJjWVBQ18ejK1kKsPFhXX4Db1BFD+58tIZoMSD1CDoZW7U9vJKieodkjNmdQomDQ1tqBw2TUC0J11T9/M/9imunLB0oM1zThnWA+vBmz+2vKnPWPahkHjKy00kJAMOZg8UFrwzSJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dC83HcUN; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Apr 2025 16:14:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745450079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDDbX7bPNdKQ1x+LjPkSgx3kPvorivXURC3759U0Hwc=;
	b=dC83HcUNXbOPHMnABNyrAUBKas+oUXCQMM8lCYq/T45+uP9FP7na4/9OFo799pMnTXs3bP
	WGFUHBWlVfLY2ARD0TTwqPgoL7P+W2vBGXFV4GJ+fKzmSyEYjYfsU9RvWv4OczuO824l3u
	vvavC7aHQOLC18z/S3YNlQAJGiIf8zo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <rlsgeosg3j7v5nihhbxxxbv3xfy4ejvigihj7lkkbt3n6imyne@2apxx2jm2e57>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416180229.2902751-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

Can you please squash the following patch in this one?

From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Wed, 23 Apr 2025 15:41:18 -0700
Subject: [PATCH] memcg: multi-memcg percpu charge cache - fix

Add BUILD_BUG_ON() for MEMCG_CHARGE_BATCH

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 23894e60c3c0..80ff002b0259 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1909,6 +1909,13 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	bool evict = true;
 	int i;
 
+	/*
+	 * For now limit MEMCG_CHARGE_BATCH to 127 and less. In future if we
+	 * decide to increase it more than 127 then we will need more careful
+	 * handling of nr_pages[] in struct memcg_stock_pcp.
+	 */
+	BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S8_MAX);
+
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-- 
2.47.1


