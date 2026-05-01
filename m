Return-Path: <netdev+bounces-283122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFx5FUdL9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:42:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B44AAB49
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77F58306E668
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D7364047;
	Fri,  1 May 2026 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyu3DyZg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B0373C0B;
	Fri,  1 May 2026 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617531; cv=none; b=mXhtiRf2azV+YrbcJdAHCrvHVDaAeVWxKbSFr8OKH2mH9SRL1dnItcoR5T0fc5xMZtO5Ohks1JWPLhL1+BsUFnkcn0nL2BN8Z8Ib6JcEAMIXC0oxii6HqqoND9iUw8FdZ+oOqcckbNNSTcsCCqiKBlNhEDCSA3lSzYlNvH/r2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617531; c=relaxed/simple;
	bh=hZEmZMTWms93iScRWFWbXFUbeAQnRsLmufvsHgKBvR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JACEFhabLhBZGMKux2aS7NgNTlf7Lq8/AATfeIjGmd28I4PsEWE92TdCk51Ppmcf4smIwOn/rV/n/+6gplwlzPkYvqRoRKDucdfotl2r4FC4UgFYznc/M8QakWrlHTC6y3BczC53zYL0Zs4GKHhag33E5+10oB/QKRwUY6ZyPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyu3DyZg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617525; x=1809153525;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hZEmZMTWms93iScRWFWbXFUbeAQnRsLmufvsHgKBvR8=;
  b=cyu3DyZguTEfhZrHoloQ55Tp6uhuG09v70Yav8P0tnfFCUYPTSszbpCo
   MuxllZm8DNpgPJSPCxGnd79px7XLEVY9JhB6X4pldj8r/kV06XTJorNtt
   wSVRRnfa/1zrFPQeSoZFYpHgo4aQsHQ01JwrC6LrjJdyYil1wY1LX6JGF
   XFQFNQHqQotsCV1kEA5UrPJKsYNaaqwRjqcL+vPOBKUlkQeotI1yipQ+k
   eAdi/bqduUQoB+SrHUNKxFFnJ0nopQ3yasTsyawGYYeVtDLj4GkcU4toB
   +QLc4INckq3FNAKj1Y03Z6Ov3SVa8GcQucGx/v0lB1VWqKZgHEAjbZsGh
   w==;
X-CSE-ConnectionGUID: e5PZwpG9TIisa9iD3BviCA==
X-CSE-MsgGUID: 4o54v0DnQbe1STWsiG5wNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271941"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271941"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:33 -0700
X-CSE-ConnectionGUID: vfifRqAFSMeffQQZCUC4kA==
X-CSE-MsgGUID: NW34wUKjSFiCI7MR+7U+Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752877"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:24 -0700
Subject: [PATCH net-next 13/15] ice: dpll: Fix compilation warning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-13-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=e03GxYUPA/S1DBBMfmY+CJB2v7PFQcAFMRVgEvhGnGk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXmnxSoEhQZyfLoUazVObuXrF6Vvz3YM+bjO+8lv8+
 4QFOQf4O0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZhIyEJGhm8Fn0JqNO+9++0S
 5rCiqJvz8pNpj3Uu/IuqabkeP+3VDn5Ghi8fuJSzFyZ8EVhz5VOy0dwJrw25mz8snHuWZ3NXP8d
 EfVYA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: C50B44AAB49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283122-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

Introduced by commit ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and
dynamic pin discovery"):

ice_dpll.c: In function ‘ice_dpll_init’:
ice_dpll.c:3588:59: error: ‘%u’ directive output may be truncated
writing between 1 and 10 bytes into a region of size 4
[-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
"rclk%u", i);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 62f75701d652..054a2c05f163 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3527,7 +3527,7 @@ static int
 ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 			  int start_idx)
 {
-	char pin_name[8];
+	char pin_name[16];
 	int i, ret;
 
 	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");

-- 
2.54.0.rc2.531.gaf818d63126a


