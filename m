Return-Path: <netdev+bounces-303829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0JN3KIOBRWpDBQsAu9opvQ
	(envelope-from <netdev+bounces-303829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:07:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2A6F1BD3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:07:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LKP7H5Xw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303829-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73DA311BCB6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F933AE71F;
	Wed,  1 Jul 2026 21:03:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332303A8739
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939793; cv=none; b=bcNQEsAbfnGs/MGnNyf358JWEXLqCHH7eWydMrlLY88jyhFoONlkTzNmx/q6KMhUw1/MWW8BfUUP95+UrM0nMlPOBFZ+9M+RUNs+hOk74YNHL+lnzisSgr56IrO0yOIXC+oTx13dXQWZKxjHzZbdgcrTmt7I24bGfa+hBPvPS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939793; c=relaxed/simple;
	bh=YKi1Ytc5nn5iMhkn7ySgYfTkJdBOyJ082isRyb6GFuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuGi47e/YHakivYGCB/AvbmSIJe+f+wvUc+caUCOfSop9kD3jHbDpftEkx2i+FozlWfYyVsSEGU7eyXLBjfqWLrRY9Lu0EycWFv+QvAuayC223Pj3tvra4g36sRVlgQlFTxOWfjlGZ762/3C6tyiXW+4jNsB0ck4KJVqyd58Lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKP7H5Xw; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939792; x=1814475792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKi1Ytc5nn5iMhkn7ySgYfTkJdBOyJ082isRyb6GFuY=;
  b=LKP7H5XwYWfuQL2lPsfphS8ZVTO7zgrGB+8R3saUVpL0i8cj2bXjhWab
   fRDLQO/OYwZtrFnp0CogQGylB7135ZkZSGhltg53xGLoIBtWiM/3a+qVD
   uDoI/wtHL9/o0Hy7KVqqew1mBrIOo6CRae4+c3ZFrczm03le5omMrCQSG
   n48HK+Tqo8MXEZRyxDJzflE0zM+GsjK8wTf2CDjugS3xElI6NkS/pq1o9
   HGIFAFyFAIypJAUFTm1WQCBlpAEuGEEFg8K+6Ou5iGE8OGapgxesy6Bq7
   5ga5tXCxlkrjPbDsSvw6pUgztrgsPj9008rPsHZIeuJKt/b5xc5bDO1B7
   w==;
X-CSE-ConnectionGUID: wtKCZDkoREynK8Xn0WCLpA==
X-CSE-MsgGUID: TzeJkehVQuyrNrrqxitRUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069095"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069095"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:10 -0700
X-CSE-ConnectionGUID: Ucg6y6++R2O3rK7mE9C2gg==
X-CSE-MsgGUID: szqycWZkRcycJdFWYrlV7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561399"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	kohei.enju@gmail.com,
	horms@kernel.org,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 03/11] igc: allow configuring RSS key via ethtool set_rxfh
Date: Wed,  1 Jul 2026 14:02:52 -0700
Message-ID: <20260701210303.1745310-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303829-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:kohei@enjuk.jp,m:anthony.l.nguyen@intel.com,m:dima.ruinskiy@intel.com,m:kohei.enju@gmail.com,m:horms@kernel.org,m:avigailx.dahan@intel.com,m:andrew@lunn.ch,m:koheienju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[enjuk.jp,intel.com,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,enjuk.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2E2A6F1BD3

From: Kohei Enju <kohei@enjuk.jp>

Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
RSSRK registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 30 +++++++++++---------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0e76ffe7be65..fbba3e84673a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1539,24 +1539,28 @@ static int igc_ethtool_set_rxfh(struct net_device *netdev,
 	int i;
 
 	/* We do not allow change in unsupported parameters */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!rxfh->indir)
-		return 0;
 
-	num_queues = adapter->rss_queues;
+	if (rxfh->indir) {
+		num_queues = adapter->rss_queues;
 
-	/* Verify user input. */
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
 
-	igc_write_rss_indir_tbl(adapter);
+		igc_write_rss_indir_tbl(adapter);
+	}
+
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igc_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.47.1


