Return-Path: <netdev+bounces-306450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e1JaO5eXUGqV2AIAu9opvQ
	(envelope-from <netdev+bounces-306450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:56:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD50737DD1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:56:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KrcG75z4;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306450-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306450-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8953030B27
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA71C5F1B;
	Fri, 10 Jul 2026 06:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A05223DC6
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 06:55:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666535; cv=none; b=otY6rn91q9NQTSMQAtwBQ4++QtmUHmOR/o5OH71TphL/F0zlbxxrCBY3YNnTo7vbX2dkkqmy7+PLR7RY/CswtMyGU2xOz2DcHm/SBi5fs9vsdN4NdaXAg5k1m4NbdlD09HwdMSCMUyj1Y5v46ytTrAA1+BEdkM+zJ4Nngf6AJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666535; c=relaxed/simple;
	bh=DgwtG1s/c5y/0mNo2psEdFiXVGze2stDlFwvdlcQKlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBdxaXCV5emJQ/4bNG1nYHKJuyCJGoRmxM6tmW6vsyC+y22ILD6R3zJR+CQkjN78E4J810qbXiO/q0qqcKIvR4Y/zzBtgz1+nVznWgu9NutIv3Qc/Lyxv/yBmm9SOJstD+bn2Fxy4eCq13wx2zmauNJeSlLzoWYB6htT4Mlcvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrcG75z4; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666534; x=1815202534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DgwtG1s/c5y/0mNo2psEdFiXVGze2stDlFwvdlcQKlU=;
  b=KrcG75z4in4na/RRPZ10cn79ak5FUIPWWOlaJzpO2dstsmYu23JQH31c
   Kx+NuV62x2HfQNqRI+iwTpw8R8PqGmTNxGRKgyTudZucBEVcxcd76Jcri
   LkEzHgSOCdpuaU7ad0vFE61M1lBEhTEopCna5ahyldM7sMELR6MpRBOyQ
   CJMGslaVDg6rqGNFGxUuRSNJijGDwS8Wbxqj97pcohgsBVHp0LSgad1mN
   ysaZclB/rJuf4y4pGZyIvyicKJQFT5ULx7+dkF5uu6pUHkhhzOXLtPTyT
   3Dd82uePWuxWh50aS8N6ZArqTRxCViJE9P8UBvuaqRUEnln0IxHdSOibs
   Q==;
X-CSE-ConnectionGUID: XBZOiHFbRomhDgNT+WlYUQ==
X-CSE-MsgGUID: GZzcl6qDS96j0N0oPU2ROw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84462203"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84462203"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:55:33 -0700
X-CSE-ConnectionGUID: 4vM5WLApQ7yhum+IcDi7ug==
X-CSE-MsgGUID: /Y7eT9lUSZavDXb1TUpg1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259712005"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2026 23:55:31 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v1] i40e: fix set_ringparam error path freeing live Tx rings
Date: Fri, 10 Jul 2026 08:55:30 +0200
Message-ID: <20260710065530.4138116-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306450-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AD50737DD1

The free_tx: error label in i40e_set_ringparam() is supposed to release
the temporary tx_rings[] array built before i40e_down() is called.
Instead it passes vsi->tx_rings[i] to i40e_free_tx_resources() - a
pointer to the live, NAPI-active ring - rather than &tx_rings[i].

i40e_free_tx_resources() unconditionally NULLs out ring->desc and
ring->tx_bi.  Because i40e_down() has not run at this point, NAPI is
still scheduled and the next i40e_clean_tx_irq() call hits a NULL
descriptor pointer:

    BUG: unable to handle page fault for address: 0000000000002000
    RIP: i40e_napi_poll (i40e_txrx.c:942 i40e_txrx.c:2769)
    RAX: 0000000000000000  RBX: ffff8d0a53ea9800

The trigger is ethtool -G with a TX descriptor count change (so
tx_rings[] is allocated) followed by i40e_alloc_rx_buffers() returning
failure, e.g. under memory pressure.

Pass &tx_rings[i] instead so the temporary rings' DMA descriptors and
software buffer arrays are freed, leaving the live VSI rings intact.

Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec4..6d2b076 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
 			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(vsi->tx_rings[i]);
+				i40e_free_tx_resources(&tx_rings[i]);
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.52.0


