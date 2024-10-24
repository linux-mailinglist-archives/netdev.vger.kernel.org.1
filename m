Return-Path: <netdev+bounces-138606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725AB9AE478
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314702832FB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF7A1D5150;
	Thu, 24 Oct 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFFHOqNw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6051D174F
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771959; cv=none; b=fA3kUdTu7YPoMrPgeTpOy0f4IArs8+33XvXDzNZEhCeawttIUT+xoFtaTpxh9eMwGqPC+Nvm64nknM3WsVoMUS9X2ayU+pQncXHtvcVIbGPw8aQON24ZEgzmrtj5AzUzhOWJASSYSKkFqYqPmHXhsrJv3JfhZqTRnbBBjQiNWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771959; c=relaxed/simple;
	bh=fBo/M28zaE+Gi6IeMuAGUsuNyb5P4s2Gmpx5MaRTckQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAgzc3UPYD7F+tYqE9iXO6vxsDn/2UrHG9UEWi1W4rh5XtDAiwdOXs0MHbTFLlOkHO0f5gBvZWy7B9XXl+ZHpkdwsy5U4CST2p4/YNnzJ5XhtaAJtVvKoLhsr26gwgd51/b4PGB6B2cnAfZI+V3DHCro+NYfrCHi5SThXAF9dXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFFHOqNw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729771957; x=1761307957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBo/M28zaE+Gi6IeMuAGUsuNyb5P4s2Gmpx5MaRTckQ=;
  b=TFFHOqNwAsgx6ILpoDqj4KuqEkGGQc6hX55Xa2jSlanheLugOLrt65uL
   RKIxZqJlBv2Sq8uKVOeCVfekFRNzjOegiipJmzQG1/u9AGgHzUF4jMZcu
   jGIB3Ivs5mlUxI5sJl2NIh9pembRsN43pnNSWtiSt/f2gms7rRGwLwI5B
   92vZHk429qnWLkdGlPnz3ji/OThX9bXginNaXS90w0qCrkhsSRqikWvuT
   Bu9FPz/3ucH36r6osQkUOiIUZNEcfZlobNrTEnGTMxZeVG745BHuFJymY
   63h4OzO9Cx/RMO4Iq6RTuxf2fAe3iTnR8QJtsjoy8Rfmy4bBu8EW9SpS9
   g==;
X-CSE-ConnectionGUID: 7MyxF0ibR7KS/1WXgKO+Bg==
X-CSE-MsgGUID: MBi7neFPTNmrKWfEQu5R9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40008264"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40008264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 05:12:37 -0700
X-CSE-ConnectionGUID: Xchv+PjWTH2wqs+JDEzb2w==
X-CSE-MsgGUID: qWGN/3CLQNqQiRc2UDQKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85184435"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 24 Oct 2024 05:12:34 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM
Subject: [iwl-next v5 1/9] ice: count combined queues using Rx/Tx count
Date: Thu, 24 Oct 2024 14:12:22 +0200
Message-ID: <20241024121230.5861-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241024121230.5861-1-michal.swiatkowski@linux.intel.com>
References: <20241024121230.5861-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous implementation assumes that there is 1:1 matching between
vectors and queues. It isn't always true.

Get minimum value from Rx/Tx queues to determine combined queues number.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b552439fc1f9..c2f53946f1c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3818,8 +3818,7 @@ static u32 ice_get_combined_cnt(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, q_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
-		if (q_vector->rx.rx_ring && q_vector->tx.tx_ring)
-			combined++;
+		combined += min(q_vector->num_ring_tx, q_vector->num_ring_rx);
 	}
 
 	return combined;
-- 
2.42.0


