Return-Path: <netdev+bounces-273677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WICGFK3iy2n0MAYAu9opvQ
	(envelope-from <netdev+bounces-273677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:05:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD636B5D6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97AE0305CA4E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5950402BB4;
	Tue, 31 Mar 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifdNMVYl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263C40244F;
	Tue, 31 Mar 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969373; cv=none; b=N4XtNC7V87HE4ACFl4GjrP23uXLp6zkxZ+GPXqqpqrg/shjw0cI+Os9apzjecJmejplrd5IQCTlUvynPlYiErFEJ6tOAxWWt3cat/HZBEFD8dJLrqlueTWq1ujzi55KwhJ00KQZE/sc9GV25BeHMOzBfewUcwpNNzpN7D0aiArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969373; c=relaxed/simple;
	bh=WqEK/4h9ymztvrfhwLyCOfK1llcjY3+wVbom01OjhWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekgZNy2yQPnWvuR0Wmho6tf/Ip7n0EbWbRLG12w4cN1VbGhcQPqBhHYV7CmnM2LXw5BMIuer3SPPBrMdu4mCIihoOseaexkwgOdItU6HuL1RJzWlVxAaLwGRoPTj8go3m7aI6OTSfdTKnBklzJ0rdncCRYOKFx9kI4KRGwRKaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifdNMVYl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969372; x=1806505372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WqEK/4h9ymztvrfhwLyCOfK1llcjY3+wVbom01OjhWA=;
  b=ifdNMVYlBmPChxjfBNzW0AdeTOQCgZ5DoEmGY1UfXOMQU9Nw0fnB8MWl
   2O1hLrotFal/DpmtGsPPOj9q1f3FgRZh//SgoD3EyiHvcI16If22z9VXR
   zrdSeJJHE7DWozHL5vUqV8eck7UY9r+hKPkjPsCPofSctbsD0lxX3zHi8
   zt1YKxxL1rRChqDpGSRSw6GIA7oNYmYq5JuloiQPq072idEW5WhTu7ALt
   hGY/VfKPR1x8PyhviEefhWmaxgvDuXjz5+gFul17S5HCE+537wtn9i1nM
   hgyf/mau9uQJfF5QgXYS262z3ikt7hCYZWtpCBcwiiZnifhXA1Ew3lPJL
   A==;
X-CSE-ConnectionGUID: 7tpYFmRUQJeaOmuRgJeFUQ==
X-CSE-MsgGUID: nJF/krruSUCnCZpUpONG+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76046231"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76046231"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:02:50 -0700
X-CSE-ConnectionGUID: 6YEBjkpgTju/NU7X8OgMlA==
X-CSE-MsgGUID: AFDM/9i+TZGmB1fFNSof8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="219735663"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 08:02:47 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Joshua Washington <joshwash@google.com>
Subject: [PATCH v5 net 11/11] gve: remove home-grown xsk's frame size validation
Date: Tue, 31 Mar 2026 17:02:13 +0200
Message-Id: <20260331150213.550797-12-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
References: <20260331150213.550797-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273677-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DACD636B5D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since this check is now present in core in xp_assign_dev(), remove
redundant statement from gve_xsk_pool_enable().

Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
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


