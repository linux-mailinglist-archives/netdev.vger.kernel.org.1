Return-Path: <netdev+bounces-69368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9879984AD03
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 04:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372311F2448D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD5745E0;
	Tue,  6 Feb 2024 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAyz3WO7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC2768FE
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190722; cv=none; b=iNMahfJQJ3pJlcltgMQ9wjYIRwH5pSZrWes9MTxWuSta/YwmVqvsXcM+7qCjVX3a8rX1tLyLZSL2GuReisHRk+PfRAjuE39lERRzxG3cBbt2q0S49ma4OVh/AlnUTksXf1TjSRg5s3KgwqYRkJEleigQMqdSPxKVIGjSAdjYbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190722; c=relaxed/simple;
	bh=fOVVUq5YZJbAxXbHKCRGKfuq9aA9oE8cegWnzCKCG58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSjEGZnDs3Ne58BhUPGyfmDYZIzbJm/p8Pkw/oikn/397XWDWX35DHyOFhFZ4WI6v4nGE8RsHkJNVSrokN7qRqdKi67y7U3SjuSN4bMeMk9raMBDF+XHz4FSQP1j4JFuVo1oOZNyUkyWMzX6kHSguSaT++v8GTSIcU2HF7tNVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAyz3WO7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707190722; x=1738726722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fOVVUq5YZJbAxXbHKCRGKfuq9aA9oE8cegWnzCKCG58=;
  b=AAyz3WO7pANb6eX2fX9bnZq9qoXhQjX/qAOPCQmf+AEEnTn1hlqhOVQr
   O6fVhD65EdMDAC41tHsue71F6d9H1noE85fURH/vIrJJ6bKKAoBbQlMhK
   IkQpnQa6uWcuXJcJVV1s89Q1TqinFBHafIfjjB50PgRtNIwo+sSreKI3c
   8lJAmv8mgZQwgKH9Y4tDXgZUTjA5t2mYm6FkmKbPBY9Pc7P4w/9TYHUvr
   yUdqDRax+Hgs4OIvj1RXuSgYobNT1Fl1uC/T14QC0gG4RN6hko5tlYt/b
   CN0P6i7Pun1RujWreUnlBi1rkl5j8s95QJteHsh58RYgtkU0zfOPpSEpA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824868"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="824868"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 19:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5653951"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by orviesa004.jf.intel.com with ESMTP; 05 Feb 2024 19:38:41 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	przemyslaw.kitszel@intel.com,
	igor.bagnucki@intel.com,
	aleksander.lobakin@intel.com,
	Alan Brady <alan.brady@intel.com>
Subject: [PATCH v4 09/10 iwl-next] idpf: fix minor controlq issues
Date: Mon,  5 Feb 2024 19:38:03 -0800
Message-Id: <20240206033804.1198416-10-alan.brady@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240206033804.1198416-1-alan.brady@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While we're here improving virtchnl we can include two minor fixes for
the lower level ctrlq flow.

This adds a memory barrier to idpf_post_rx_buffs before we update tail
on the controlq.  We should make sure our writes have had a chance to
finish before we tell HW it can touch them.

This also removes some defensive programming in idpf_ctrlq_recv. The
caller should not be using a num_q_msg value of zero or more than the
ring size and it's their responsibility to call functions sanely.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index c7f43d2fcd13..4849590a5591 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -516,6 +516,8 @@ int idpf_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 			/* Wrap to end of end ring since current ntp is 0 */
 			cq->next_to_post = cq->ring_size - 1;
 
+		dma_wmb();
+
 		wr32(hw, cq->reg.tail, cq->next_to_post);
 	}
 
@@ -546,11 +548,6 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 	int err = 0;
 	u16 i;
 
-	if (*num_q_msg == 0)
-		return 0;
-	else if (*num_q_msg > cq->ring_size)
-		return -EBADR;
-
 	/* take the lock before we start messing with the ring */
 	mutex_lock(&cq->cq_lock);
 
-- 
2.40.1


