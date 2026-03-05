Return-Path: <netdev+bounces-264495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA2yOCe9qWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:28:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5AC216312
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0316330182B7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52E13AE703;
	Thu,  5 Mar 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0jK/OPn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81A1FBCA7;
	Thu,  5 Mar 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731682; cv=none; b=SR1GOZwHhE9l/a0LN/EUZUvKS+Z0cuKeJJXMe89nTF3GokOEEWlPZeUlK7ciCYpUcXb/enrHsOjvMUxJLJGNvGXc+xSPqoQHsqhv0ThpmsNrmZlCCYvyXiP8nbTa0dLtuXhAb06XYfgu5JBfiZ27HnTYqI6khKnvLFqd8AwqZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731682; c=relaxed/simple;
	bh=JrH33n0V7DQGy8wQ55Ys4A0vDDepY+3rB3gaaYu/P8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XU49881RllPDn5viYqvlpLkhof4GrSnbNZKXWj1x1FS6NXYqTIPA4cFw+UWgDugOCWkiQ/hdjI0eilrAZeVPbfVQ/DNOu9G3S/7RW+ZWNIKKFDnkZHa/5bVzbLRwZfsvqrZPctE7KsYebr2WTQ/8l5RV/Xwuu6kLLoCEE6dnguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0jK/OPn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772731682; x=1804267682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JrH33n0V7DQGy8wQ55Ys4A0vDDepY+3rB3gaaYu/P8k=;
  b=P0jK/OPnEsapZfT/oAjyi6LK83Ewh9lcTAz/h3l/rVWST7QhAWU6Uh1j
   KtnB65Xsw4ipooilUnoF5u7r0kA45Oc6Yqio/82W8cBcV48xYCxomI/dL
   cQvftaDscKnCJAF0gjwv+KhObfJvsr+6XVBW0UfpSClX1Y81RHkg+G9xT
   gm0CteIbwGuESxVUwjTMzemsFtQl3NgQRhjbTwQFa1mmqlP98EUmjXkfz
   oHpT9siSuDV+IUSLoLzazyXjyoXQHw3uZ6l+kKnQv/gb0AEjHfiRMRLT6
   KEsFCbmKAey2wkFI3oJuMyNBW61OcqDBuOCG9jkK6Ak+H7nnE08ys8cNt
   A==;
X-CSE-ConnectionGUID: 8I+AVzsaQkS6ZOX/nTerig==
X-CSE-MsgGUID: EvleGCCzSIirMgdi2y5TjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84158855"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="84158855"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:28:00 -0800
X-CSE-ConnectionGUID: TSAcaiO/SSaE/Lkbkn4H8w==
X-CSE-MsgGUID: AacHuLLiSfqnJ6DgA7oVhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="218877231"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:28:00 -0800
Received: from ray2.sr71.net (unknown [10.125.109.20])
	by smtp.ostc.intel.com (Postfix) with ESMTP id E14776362;
	Thu,  5 Mar 2026 09:27:58 -0800 (PST)
From: Dave Hansen <dave.hansen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove bouncing T7XX reviewer
Date: Thu,  5 Mar 2026 09:28:05 -0800
Message-ID: <20260305172806.3118806-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F5AC216312
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,mediatek.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-264495-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This reviewer's email no longer works. Remove it from MAINTAINERS.

Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: Liu Haijun <haijun.liu@mediatek.com>
Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 427e45e12762e..8f4f5190df166 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16366,7 +16366,6 @@ F:	net/dsa/tag_mtk.c
 
 MEDIATEK T7XX 5G WWAN MODEM DRIVER
 M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
-R:	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
 R:	Liu Haijun <haijun.liu@mediatek.com>
 R:	Ricardo Martinez <ricardo.martinez@linux.intel.com>
 L:	netdev@vger.kernel.org
-- 
2.43.0


