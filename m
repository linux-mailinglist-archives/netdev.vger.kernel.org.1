Return-Path: <netdev+bounces-283121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMqQF+9K9GkUAQIAu9opvQ
	(envelope-from <netdev+bounces-283121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:40:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12224AAB1A
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E7B7305ED99
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3193373BFC;
	Fri,  1 May 2026 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWmFwkVg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB90367F21;
	Fri,  1 May 2026 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617524; cv=none; b=EzOYVcZsAkus4YrlyjX6ll/jXCKK7VJ59FKz0pMdlEDcGmQ+8pqtU2xd43F3h+1Y/cRFwyyPfLaIgZJzL9KzPOVPeBbAMD+Af079Jvo2Zdu8an9b6c2ljAbOPP2JU3nXeF3tiyBWRbhLDJ1ZgGWmI8xaT9Cpuay23EbC44cdZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617524; c=relaxed/simple;
	bh=XXZI7pQh1J2x8jCwKraX2UOMZwG+RSwyWryaNcpYiOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSIfz6bfI4AOnM79EYmKnFmrFvJo3/GwkM4AoWZSaWcrnBOstXS/5mcLaOv6LJAiq2+scU0U9MW290YdX0Ed+Iu/kK8fRdeqUJaclj1Vpqg41F3mhGOcmyYlQ/v8xsI0YseE4Q0DqIClgGO0BRkuBfCMYjNIhHQQI99m3kIF8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWmFwkVg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617521; x=1809153521;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XXZI7pQh1J2x8jCwKraX2UOMZwG+RSwyWryaNcpYiOk=;
  b=IWmFwkVg9CD42/jueEXYHwqziM9qJfmdQhRJqElS3vf3SJPOfs0/sb/S
   qNYvcKZPkBoKjZP4Zh9ThFEMZa1YMb89rQQynMSuWemHPHt8p6gLxqM8G
   P1jGS5fdE8f98M/VmqDn4mUAfvQwvsaa2/8OA8MTBVws/sp9rQJ+vUQe+
   cWAG3tB9F9q+Xi3OZO6qeRmHcrWNrvZprD7W4Ey35zGvdnar2IOs2xbgy
   WVoDZ1FsmswSm06SwYyMYJhwhUpaCyTUMIVOYfkONqAoLsn660hIbI/no
   DXDBJsgOEDMnNU4UGdRTg7EUmAVgt6K7ouyA1XY6+iTMAgFygVJ2cVq70
   Q==;
X-CSE-ConnectionGUID: ljCI5P/bQ1GNgrrwE9uN6w==
X-CSE-MsgGUID: Iu2RuN4CQyGc6o9SOXQmsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271925"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271925"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:33 -0700
X-CSE-ConnectionGUID: v4WENUiMRjaf1eMRA68JXQ==
X-CSE-MsgGUID: CeNn1GWdRVejcGthQMADbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752871"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 Apr 2026 23:37:22 -0700
Subject: [PATCH net-next 11/15] ice: mention fw_activate action along with
 devlink reload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-11-6f27ae1cd073@intel.com>
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
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=XXZI7pQh1J2x8jCwKraX2UOMZwG+RSwyWryaNcpYiOk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXqm8sSLnqh1fnpzTeui+RHrP7a9yZ9+3H2Gb91Zr0
 69Pm1JXd5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAnARNob/RVecJPa9tz39hd1q
 /1nL2WzqCW95fuUfCH4sss7/zgeZY4wMxxq/3vhw9MmZwFLp8OgWpUP+QktO9l9Msl7eaynvbpH
 KCgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: D12224AAB1A
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
	TAGGED_FROM(0.00)[bounces-283121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
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

The ice driver reports a helpful status message when updating firmware
indicating what action is necessary to enable the new firmware. This is
done because some updates require power cycling or rebooting the machine
but some can be activated via devlink.

The ice driver only supports activating firmware with the specific action
of "fw_activate" a bare "devlink dev reload" will *not* update the
firmware, and will only perform driver reinitialization.

Update the status message to explicitly reflect that the reload must use
the fw_activate action.

I considered modifying the text to spell out the full command, but felt
that was both overkill and something that would belong better as part of
the user space program and not hard coded into the kernel driver output.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index c143e546dd8c..36314610927b 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -726,7 +726,7 @@ static int ice_finalize_update(struct pldmfw *context)
 	switch (priv->reset_level) {
 	case ICE_AQC_NVM_EMPR_FLAG:
 		devlink_flash_update_status_notify(devlink,
-						   "Activate new firmware by devlink reload",
+						   "Activate new firmware by devlink reload action fw_activate",
 						   NULL, 0, 0);
 		break;
 	case ICE_AQC_NVM_PERST_FLAG:

-- 
2.54.0.rc2.531.gaf818d63126a


