Return-Path: <netdev+bounces-271407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D7yJoiBw2n9rAQAu9opvQ
	(envelope-from <netdev+bounces-271407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:32:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6813202E0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA482305A2C4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D9356A38;
	Wed, 25 Mar 2026 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOngbjWk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBD346E43
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420346; cv=none; b=NBDGCo5uJl/IjFwfQBPRjo4hSNRf8qrLF3R9h0PuXjyyyxQYvRBSUlDbd0xNUsPLUHn/8Tk9BdpKT5cVJqK34r8dOelTvjCJ3QHu5f7+EvlFQI72XS62XerDinvLibMaZ9r31zoUypFQqjbD4i9FxcwzZejCiNP1Fh+9yYf4fNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420346; c=relaxed/simple;
	bh=371lIzolESrhOMrQZ+kRiBnks0CP6to8wN6H9X/ogJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP/i6GTbeRQxIWiZmXEC5cNsh/lv7pIPWAQjtvXAQe1+X1VJuGzKGTJAWxh7ibvY1Bwp1nwL+b7ZguEmJlLXnedSP3nUvcF7KpHN3U3OblKb/XCmr2Gaz5o79MyVbC8p0lUIU21JyZYebX4E3vtZjAa2b0fnlkg1JZ1ArOZEjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOngbjWk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774420345; x=1805956345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=371lIzolESrhOMrQZ+kRiBnks0CP6to8wN6H9X/ogJ4=;
  b=jOngbjWk4dBYGijj4zX/Tj6JOyp4+AHswVnL9aINmna8QmlpZuqzL+83
   YGP8xl1IKGIU7MP/hpRn54mm2VGrS8qXrYkFxFe2iDHWHSfQvUwx/Qu7y
   KS1c+J5QNLI9dm/D+J6PP/FA+en9ceGOoVMfBH2+1CMvjOQC7lrNCfVPi
   cGUv5pUg+Fn8N3vhOrvZP0IUVH+viBa6EaqAXCOdqa+u4hQl37axLu1kJ
   rWcDlDzKXEmUq+pvH16w6ip6JG1gsWH3gi88KQjBgZyY1BlTNxEBJSYG+
   pIJwxmsBcW5jVP56HaqnVUa+g+PmYMFn7M1gYKHoJ/wqJWnHHXdHNnaU3
   Q==;
X-CSE-ConnectionGUID: pWlo3TfEQOaUutKxTRwnjw==
X-CSE-MsgGUID: DAnkBM78Rna+Lip8d89hxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79308064"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79308064"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 23:32:03 -0700
X-CSE-ConnectionGUID: PJGG7ggXR1eJGOyTslFP1w==
X-CSE-MsgGUID: Ws/d7Gt3TA6RpYxTaD8ssQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="221693633"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 24 Mar 2026 23:31:57 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.24])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 691D32FC8;
	Wed, 25 Mar 2026 06:31:55 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Michal Schmidt <mschmidt@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 2/2] devlink: unregister shared devlink resources on destroy
Date: Wed, 25 Mar 2026 07:26:53 +0100
Message-ID: <20260325063143.261806-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271407-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 1C6813202E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since shared devlink acts as a normal devlink instance, capable of all
usual devlink operations, it must unregister its resources.

I plan to make use of devlink resources on a shared instance for ice
driver by separate series, coming soon.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/sh_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index b85e5cb1edbe..5de138bf3630 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -71,6 +71,7 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
 
 	list_del(&shd->list);
 	devl_lock(devlink);
+	devl_resources_unregister(devlink);
 	devl_unregister(devlink);
 	devl_unlock(devlink);
 	kfree(shd->id);
-- 
2.51.1


