Return-Path: <netdev+bounces-278665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEoGLQUo32nmPQAAu9opvQ
	(envelope-from <netdev+bounces-278665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:54:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D417B4009F8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D60A30505D2
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748293845B9;
	Wed, 15 Apr 2026 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZw231Vk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8183803DA
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232174; cv=none; b=Mrdsm+9W5MEhRl6pjo1SR0KKDuiNNkDDc70R2sKOd7bAbaf/Di3Bo3dBzJjWccWBuDzkA2Y3gg1ydR0xvZa68mpdslie5anTGdpgOJWKXYn7ru92/QKEAB6TOAovazxRJ3tlcVslDQ2zmAhq3NZulukIZHk9cPm1ndC+Jhl5Rcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232174; c=relaxed/simple;
	bh=2Aq3pfPRvVrmtMj6siX9e7aTtBH+G4VAek6abs0ZbdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRDYT5586f92LqFlHP3TUvFwBqpqywYMIex5CVC7lKEynIA0jn/5VNxRdDSuDy1fUhjejk5aIObjA3BoqiDYz0+7mmRwG/O8jkhjPb6sb3E07WwKYXh9Uq+3pW7PJGtV+3pc8UVduBFqLYq4/Zs+zqk/uIMwKT4SNc/isHd+sx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZw231Vk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232173; x=1807768173;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2Aq3pfPRvVrmtMj6siX9e7aTtBH+G4VAek6abs0ZbdY=;
  b=YZw231VkwkDMILTt1tosc/vstoCtT1yu3PvNnWBLwGaDJOc1CJx7tvwH
   ct/qNL+VRYpZECIAzNtaUq7mddqBhKDyklFgg1Qa3kkurWL5+NuMC+9MT
   lTpdWEU7Ht7NB4VmAHDjiJZ3wOPkUdXPViqzmSaFyOY1ZywmN8XEdpBqI
   FuS+ZnY8fEYUncP+dOd/RygolfiJJdy1LWyHNxVZBu+U9qiOukucm6TU5
   xX+8ZdtMFbyWcUxCWixP4Q6zMoBzu1EYu4BHNjYJDwxryC8HWHHy56Pc+
   XpbqGk/DhGaE1W3xKrbnOeJcjqEN+g2mdrnzY4hlsbd8PnELLQgybxo/s
   Q==;
X-CSE-ConnectionGUID: B0mcHASCSQWJHxFI630FRQ==
X-CSE-MsgGUID: HYQuB4J/S7ajwV6xEdtyQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105993"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105993"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:27 -0700
X-CSE-ConnectionGUID: QU0fwcJqTKaF07nMAoVstg==
X-CSE-MsgGUID: xu3KzodJTNa5xJ3yiDksaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714831"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:48:08 -0700
Subject: [PATCH net 13/13] e1000e: Unroll PTP in probe error handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-13-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Matt Vollrath <tactii@gmail.com>, Avigail Dahan <avigailx.dahan@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=zbCaj3zgw/ipZ2rwuqarxmSQNfHrtynVq9uAaV76RjI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ao9XS68Pa3klkazOxjTjhMQD0+wDtZGN/vurtu+aX
 rS5bMObjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZyfi8jw50JvcwW24pYr4db
 FF2pjGXt0q2z/ndY7vn/MoZJAXvP8TD8j7ObuVmiYLXC68bpSTvEG0/pedaZMN48EMgo+Lrwtzw
 HPwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-278665-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D417B4009F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matt Vollrath <tactii@gmail.com>

If probe fails after registering the PTP clock and its delayed work,
these resources must be released.

This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
before the jump to err_register.

Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during SIOCSHWTSTAMP ioctl")
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9befdacd6730..7ce0cc8ab8f4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7706,6 +7706,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_register:
 	if (!(adapter->flags & FLAG_HAS_AMT))
 		e1000e_release_hw_control(adapter);
+	e1000e_ptp_remove(adapter);
 err_eeprom:
 	if (hw->phy.ops.check_reset_block && !hw->phy.ops.check_reset_block(hw))
 		e1000_phy_hw_reset(&adapter->hw);

-- 
2.53.0.1066.g1eceb487f285


