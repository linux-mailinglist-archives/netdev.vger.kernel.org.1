Return-Path: <netdev+bounces-272400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBiOKLAwxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:24:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CD34058E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125C73035D71
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E013C7DEB;
	Fri, 27 Mar 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2HzcHjB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4E3C3BEB
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596220; cv=none; b=fHOjHz1sIpsJjaxTJeymjrZBlgfCJNH2+y6QJtNs6eiYvdOZU2abk/cvxLQQ2yBnmXGtomcpI6reAR+pylRvnkFw1K901vBQZ0sa1GHUnwJg7fTS46kqu7hLCG3A70Zrby5RsNjlVig8vDSOWFPlRpNswgfHc0ERYQ7IBDAJl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596220; c=relaxed/simple;
	bh=r+G9qCQlC2UPALPlilVAYlqAgt+L21Z8ORPZYuoYQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eg50lrfQU7A5ltfQ7ABxtsdAG6C8MtE5RM40nzgA9gvb59r9gtDmO6j7vaMFrnTDDWgjWg9GgVg7ZHK0WYuLn4vUMrqZqKuAUPRxOdp5y+shyZ2YU7osXpy7tMjhIehCjuzXwf9N7Yxirmhryyo9B+IzinOrUFcyhaFRrf9wWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2HzcHjB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596216; x=1806132216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r+G9qCQlC2UPALPlilVAYlqAgt+L21Z8ORPZYuoYQ5Y=;
  b=d2HzcHjB3vw74nH48CpfsD4PVAtlY0OzC3DO86o237gdbbs/QiETsxf7
   v4bPP0Yxv15ncWI1pXIl7EGsLqzfpPDP55+kSHTEJhJQ3GmepgBebOvtE
   FA5SvHJWra+wuI6DjXwwNgOc4gJYnoP7PmlyojK1yc5iyqvPiR4GBIWoO
   NrEjNbs8QXScfMEwAttFqHK6vF4SWdj/EcoZ5QIzIexSYJjYNXDZCXKSJ
   qT0nwed8UegIWt1H9a7leF7evTc5a9w4gGjuI/3jjzjaqbWlFxu8qv+BY
   5oACE/B7D5ptSr2L1MHMpTUkHHbQsXO8ycCoYFZlcoohGhH/57GINTvrF
   g==;
X-CSE-ConnectionGUID: 3w3aP0wET5qBQGpyp8BYqg==
X-CSE-MsgGUID: /AxB15D1Qd6DONZWp3OaPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733962"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733962"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:35 -0700
X-CSE-ConnectionGUID: XY/SgQUmTIyPDG7gpUf/Xw==
X-CSE-MsgGUID: Ll3cd2eDSzuEUk/PQinWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739078"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] ice: fix null-ptr dereference on false-positive tx timeout
Date: Fri, 27 Mar 2026 08:23:24 +0100
Message-ID: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	TAGGED_FROM(0.00)[bounces-272400-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F5CD34058E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Kubiak <michal.kubiak@intel.com>

Due to some kernel bugs the Tx timeout event may be false-positive.
For example, the kernel commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()") fixes race conditions that can
also occur during the ice driver initialization.

In case of such false-positive Tx timeouts there can be no real Tx
transaction started, so the SKB pointer can be NULL. Therefore, the call
devlink_fmsg_dump_skb() can crash because of NULL-ptr dereference.

Fix that by checking the SKB pointer before dereferencing it.

Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/devlink/health.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 8e9a8a8..4275329 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -409,7 +409,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
 	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
 				     event->tx_ring->count * sizeof(struct ice_tx_desc));
-	devlink_fmsg_dump_skb(fmsg, skb);
+	if (skb)
+		devlink_fmsg_dump_skb(fmsg, skb);
 	devlink_fmsg_obj_nest_end(fmsg);
 
 	return 0;
-- 
2.52.0


