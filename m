Return-Path: <netdev+bounces-272413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPPUJbsyxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3062340768
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32692305EA62
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B93CE487;
	Fri, 27 Mar 2026 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJOK5gO9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E503CA4A2
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596665; cv=none; b=RA5mGJ7gl139L8ImZktFDhgrR5PsUEmUe+yiJovnwwgT9EGaBE32LA6X+CB5purd3gMray7KLGEbHCf6p2plgiWEKA7OaoMgrkqYCztHM+kLERGAtz+Nx9h8qcexdC+M++hiw8WSIptgpSLPdeX0j/AdSyDI3IqgkbOzbNEjYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596665; c=relaxed/simple;
	bh=l+5PB8hG8ASiz0Q+Qy0iNx3ZoIMPNW7rHg47asvNjxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVaGJHsc/0bl93aZ7jYPB3wOsRNeEum/EsILLze6OlRbbr+KX/s/x4qATqUuE6/aJKLXvuZaKg8MecIBxe9mVR55pYgkwLCKmkuQdglxyau4Z7WQJ3zXr07ALruRiVPruSOY1dgDebsCUGT3KuW6jwRVK1qkPFyAnyrU/44SjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJOK5gO9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596658; x=1806132658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+5PB8hG8ASiz0Q+Qy0iNx3ZoIMPNW7rHg47asvNjxA=;
  b=lJOK5gO9itbqiLdD/gTvThXVL22j8cjPcVC9NUtdBvKlbFMWdQL8BgPw
   l+QRrsuZP9d56LG1mQHceKp6yOEpQURWOB65pu1lSmhFyAgjdx4aDYz3d
   PGhb1JVY2ZP1k0Dbt1i0tP1Ha7JQLt57n1+rYXAi0275RVdwmafo1qvfu
   JIYvLc/1BNZtNdZ0zszGi8aMu2DAEjRce4VN01mRbv3G/+XbqK/EgWwCp
   yDclzS9aDR04BN+gY1NJeTKDEhhkKuWGvQ12mWbYVzJW+I/NL5HAm9wUu
   p2FR8y/cRl+MkyHbUDZIvZK22NXQcvBvKy3JJSxqXyxSrXHR6TQxpX/YI
   A==;
X-CSE-ConnectionGUID: XrVIpTurSf6PPjWfpjgl1A==
X-CSE-MsgGUID: 0rQsd35iRvOcn+qnEYsp7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734303"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734303"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:30:53 -0700
X-CSE-ConnectionGUID: qYt7L5tcQa6CZ+Bhdp9cFw==
X-CSE-MsgGUID: XGN6zzyPTyaMtWGSdXzjew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740371"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:52 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: remove ixgbe_ping_all_vfs() from watchdog link-up handler
Date: Fri, 27 Mar 2026 08:30:38 +0100
Message-ID: <20260327073046.134085-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272413-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: A3062340768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Basierski <sebastianx.basierski@intel.com>

When multiple VFs are brought up simultaneously, a VF can receive a
CTS (Clear To Send) mailbox message instead of the expected RESET |
(N)ACK response, because the watchdog is sending a gratuitous ping
right as the VF mailbox transaction is in progress.

Remove the ixgbe_ping_all_vfs() call from ixgbe_watchdog_link_is_up().
Link-state changes are already communicated to VFs through the normal
mailbox protocol; the extra ping here is redundant and races with VF
initialization.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1885fe8..52f0cdc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8163,9 +8163,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 
 	/* update the default user priority for VFs */
 	ixgbe_update_default_up(adapter);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 /**
-- 
2.52.0


