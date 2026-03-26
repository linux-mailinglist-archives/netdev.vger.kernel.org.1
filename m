Return-Path: <netdev+bounces-272000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONDvDEsgxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-272000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:02:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD2334DD8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05344305FFF5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52363F7874;
	Thu, 26 Mar 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlWTABZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437793FCB25;
	Thu, 26 Mar 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525812; cv=none; b=iBSJV1j16zQXjp1LUkPhXQ1aw+oGSqcnblIb9RssARQ4x30I7Oks33P3UpXmvzttyEf9gAvTySS8TEDOckEVzk1bov9hLd+IdPq05AXD+1PB/m+6x+7e2YUIFIyevUhNhx+cAjlJsWSpSFxW+Au/WGJ750pLwo67aKOhJ5B7y88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525812; c=relaxed/simple;
	bh=oluwlQFzzCfiu8mfA4R0GeAYSOqtZbYrzFHAiZhWfA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VC2XqXcb73ZwQZpejzPK0ND0Aeyd+5hhaWuyqR6gqeIfV7fkfcrJnOdjZX6MwCir/WbbbEDOAMi0hYMMLdKE+alxMOf62+uiZGTpAE+uQ9juBMCW1hZUzNJ0VxJHmjYKkT+0GWLwq4Niqa8rFOJwGbQmeWycdZt2815jBHOLjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlWTABZ6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525803; x=1806061803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oluwlQFzzCfiu8mfA4R0GeAYSOqtZbYrzFHAiZhWfA0=;
  b=JlWTABZ6nXLM13CltgYJdxtx7qd4Kwz2r2BGYPsEfdYKl6mrZNVFcnBV
   +CF69/SPwJwSCeDs0vQWN9ZkY6k0DAg3hB6QRjGkjVTVwE2s+XyDiDZrQ
   kh3s8iNy2wZ5SLEFqxSDAkSnM1TLm2on/wxlJrmDYgfFhqla+LFBxguUZ
   r3YbAoyy1T6d/o8D8ZbiOwRJZHFdOR8034DHzcAuNa+fMqZxHd5AgnF33
   YsndiZ6Jg+zYWsnwgfEsSpBfSvGZnEx+jveoZWxGJZJ/ebdvdMnqxirMx
   xzlWQq7uNOlsrf8JNzghSFxPPKqoqT4akUE+Imxho8iirJL8ioMN56TKh
   w==;
X-CSE-ConnectionGUID: Ucu/9ddgREiuyXeHDoLtPQ==
X-CSE-MsgGUID: 6Q3wjSSgSUOZwbWua2Ww5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776281"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776281"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:54 -0700
X-CSE-ConnectionGUID: IwOd2XjmSJOiOj02HF4brA==
X-CSE-MsgGUID: Dy4TQ+SPSHC3PqpKBI4euA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029085"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:52 -0700
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
Subject: [PATCH v4 net 09/11] idpf: remove xsk frame size check against alignment
Date: Thu, 26 Mar 2026 12:49:17 +0100
Message-Id: <20260326114919.519456-10-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272000-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: C7AD2334DD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We provide alignment within xsk_pool_get_rx_frame_size() now, so this
validation is redundant.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/idpf/xsk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index d95d3efdfd36..a5b6177fd44c 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -558,16 +558,6 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 	bool restart;
 	int ret;
 
-	if (pool && !IS_ALIGNED(xsk_pool_get_rx_frame_size(pool),
-				LIBETH_RX_BUF_STRIDE)) {
-		NL_SET_ERR_MSG_FMT_MOD(bpf->extack,
-				       "%s: HW doesn't support frames sizes not aligned to %u (qid %u: %u)",
-				       netdev_name(vport->netdev),
-				       LIBETH_RX_BUF_STRIDE, qid,
-				       xsk_pool_get_rx_frame_size(pool));
-		return -EINVAL;
-	}
-
 	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
 	if (!restart)
 		goto pool;
-- 
2.43.0


