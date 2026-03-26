Return-Path: <netdev+bounces-272002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDsrEakfxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-272002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:59:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C4334D66
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550823170ADD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4C3FBED0;
	Thu, 26 Mar 2026 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwARNHFY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101D3FCB00;
	Thu, 26 Mar 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525820; cv=none; b=SFGdoIZQn3OpA+K2kZ7CJkpUoxaqDTAp3duqVYTe3Ln/1LZi91cY6GA0RA3dbCuy69vevMSsHhXDPxIZROBU1XopdU0cHpZiMNOYDqqCSdDtnU3+r5KE7gmbULYZydAkE/DfgIbgEFXA4s9udEOdFH8QG0mHZ7boFxbAGXnXGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525820; c=relaxed/simple;
	bh=myyyHzF18ETXSFGD0y8bKJpnNgDMMQUFoiUMdnyxD5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAFWN3UiraSc2ZHHEt8l4UJId3DpMUAO5JC3YMutEmJ4ZW0gZagMv5q0EFW5mqwsOdxV08vPtnPpaOjSqvRCR1DC6MoVmuZlNg/d/q7BjTvgYcNGUPNkJm5jwjCg7Gyed6+3dq9t5aNqgx0gHO1cL+fACHmFyR4hT5aiomgsSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwARNHFY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525812; x=1806061812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=myyyHzF18ETXSFGD0y8bKJpnNgDMMQUFoiUMdnyxD5c=;
  b=iwARNHFYjDFnr/zLT+wHws34g/psqJVYCSt3rcsjD8XbZtkHAvTS9oKh
   q5VQXXT9oZngMiOU76I0OztAnMiLPSToJiiqM3Jrluk6TrA0vz2wX8/Mu
   ayqStuOMHrPUvvp4nH/7kRowstXhflE2YkLj7F7zEW/YPYNelKp0bUw2v
   mS+H9GUq3cFobq2N+BZsX8JDY9R9ki1hVbbhTF/4frDVf0HlM+Kmr9HFK
   TOXJ2y72jpJUmmQYVPgp0uqpV+UKJgrVvs4TFtWZK2DrgOV3yX8KsYfzu
   zpsE6F5HnU+PNByLnJ8FgZycc4HAI6KYNMrT8CxFSPkNlLNYQHqKF0etA
   A==;
X-CSE-ConnectionGUID: zDXg+7H3RVKstg+UUV205g==
X-CSE-MsgGUID: czvlOV5/S96M0Zyu++mqKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776291"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776291"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:59 -0700
X-CSE-ConnectionGUID: li8zI4mfRx+bARUZsilJ5Q==
X-CSE-MsgGUID: 10ADcOp/R4WF/QyFiY/ExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029100"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:57 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 11/11] gve: remove home-grown xsk's frame size validation
Date: Thu, 26 Mar 2026 12:49:19 +0100
Message-Id: <20260326114919.519456-12-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272002-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC5C4334D66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since this check is now present in core in xp_assign_dev(), remove
redundant statement from gve_xsk_pool_enable().

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9eb4b3614c4f..b63e0a0459fb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1596,11 +1596,6 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 		dev_err(&priv->pdev->dev, "xsk pool invalid qid %d", qid);
 		return -EINVAL;
 	}
-	if (xsk_pool_get_rx_frame_size(pool) <
-	     priv->dev->max_mtu + sizeof(struct ethhdr)) {
-		dev_err(&priv->pdev->dev, "xsk pool frame_len too small");
-		return -EINVAL;
-	}
 
 	err = xsk_pool_dma_map(pool, &priv->pdev->dev,
 			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
-- 
2.43.0


