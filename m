Return-Path: <netdev+bounces-287464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEEXEjkvBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:58:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1052F32B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FB64301F15B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D15B3D6498;
	Wed, 13 May 2026 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b="Pe8RNwIT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CC3D7A03
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659039; cv=none; b=JOUei1xY0rxbSaDlkKwmcQLOJGSlgEqWzzCEu+7H7bOFI1FDMS0yUjDsIeXtU8rCof7CG5TMIIAuUXbrS+aW992wi+AIfUYmphIEj/kuNE7dWotiwjS1N6xZJXQlAmIydXNIcxYxkuiaC78V8N3boYQvyPz28jbqmAUq/XEuuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659039; c=relaxed/simple;
	bh=JeEZ2y/kQIl3PXoTw3a8lczu2MLsHScPguiLvakYiFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version; b=ICxpbni/1+2ivAQFm3n6vSQYNfGiFcEtlYdUVcYu5gp68WSGZaqsUjLbv2zmHo2rvLSY8dfuJexmHpcC81X/BxHso7Z1jqQq9bYsdgyClDX0wjfdzG+jkw1FoAxJXmQPVTSKaXSOpf0lsMboWKboi1nnMQ0B+m/2PJ2zhH38Y4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=fail (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.b=Pe8RNwIT reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: HQurPqdXT2aYyBrohUPqUw==
X-CSE-MsgGUID: geDEUCqwReG1HZhSiogXJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83452599"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83452599"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:57:18 -0700
X-CSE-ConnectionGUID: FpMcPjCrQfSnNjaMek5ycA==
X-CSE-MsgGUID: 6bu4IZbXRv+blliSlSmlqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261759677"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2026 00:57:16 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	"Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>,
	Simon Horman <horms@kernel.org>
Subject: [Intel-wired-lan] [PATCH iwl-net v4 2/5] ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
Date: Wed, 13 May 2026 09:57:07 +0200
Message-ID: <20260415142841.3222399-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Patchwork-Id: 2223537
X-Patchwork-Delegate: anthony.l.nguyen@intel.com
X-Original-To: incoming@patchwork.ozlabs.org
Delivered-To: patchwork-incoming@legolas.ozlabs.org
Authentication-Results: legolas.ozlabs.org; dkim=pass (2048-bit key; unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Pe8RNwIT; dkim-atps=neutral
Authentication-Results: legolas.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=osuosl.org (client-ip=140.211.166.138; helo=smtp1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=patchwork.ozlabs.org)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384) (No client certificate requested) by legolas.ozlabs.org (Postfix) with ESMTPS id 4fwk6H4tgFz1yHc for <incoming@patchwork.ozlabs.org>; Thu, 16 Apr 2026 00:28:55 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1]) by smtp1.osuosl.org (Postfix) with ESMTP id 81E738547A; Wed, 15 Apr 2026 14:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1]) by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id 2E2N68K3N7Rb; Wed, 15 Apr 2026 14:28:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BED6885475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org; s=default; t=1776263332; bh=pxj7Qwt60KGAtfFfKHYnQEoASeCXoLziv0VtzU/+0sc=; h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id: List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe: From; b=Pe8RNwITcjLMlj1TDDPLMF5bDL05NwI7r967pAEBlquV5SSvE8p57Jcvf2aPpZULH MEFBe+ZliQXaNF2CE4AH9Iu3cQaq/c50Nw/0OCsBFtNMtcaaqx21xODgs+5WVrBkb9 GciPWBczm78fMZmDLtEtwkB64IG5rYpzfEVLdZdhAJ6yyMwVXSPRJsUHTam6MQgcWy kmDg+xS/hdDruVQBADlvF7i4rQabzxCMI9+L3157Oig8sotVXifGwuYjTX9GACg3k3 VZfaFbydJ3hBqCmqSTJckrgVab0xoQH5zmyqN+znIGHz8tlOFTC1T4lG740Q0w5EA/ pj92YU/P1Xfig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142]) by smtp1.osuosl.org (Postfix) with ESMTP id BED6885475; Wed, 15 Apr 2026 14:28:52 +0000 (UTC)
X-Original-To: intel-wired-lan@lists.osuosl.org
Delivered-To: intel-wired-lan@lists.osuosl.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138]) by lists1.osuosl.org (Postfix) with ESMTP id 111AE375 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1]) by smtp1.osuosl.org (Postfix) with ESMTP id F303285475 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1]) by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP id lSK_9kYaxotX for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 00A7085476
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00A7085476
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16]) by smtp1.osuosl.org (Postfix) with ESMTPS id 00A7085476 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:48 +0000 (UTC)
X-CSE-ConnectionGUID: uFR6w5AiSY+JU3IxZ20FSQ==
X-CSE-MsgGUID: tM5Md4u1QMqGm+ua/YjVCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423739"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423739"
Received: from orviesa003.jf.intel.com ([10.64.159.143]) by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:28:48 -0700
X-CSE-ConnectionGUID: hEZbVS5VQyS9lDfZNZSLpQ==
X-CSE-MsgGUID: DCC3lyWYQqqoOGpiW8fkbQ==
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467859"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225]) by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:47 -0700
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intel.com; i=@intel.com; q=dns/txt; s=Intel; t=1776263329; x=1807799329; h=from:to:cc:subject:date:message-id:in-reply-to: references:mime-version:content-transfer-encoding; bh=TGdgV50bxeF5VneOtp3k0+KNHoKWBcOE5NH18XEnokc=; b=CO4VJZbolJy7MxG9ZEF7JVdtMMn2HwA5kpUKXE8t7zUai+b3hFHaSn9E 4kAc2k3lP09wysux5p6tb51WjlQdGTG6PS0aqB7ICYd+532HsOc8LaPtR jnr0AVOT4jb0wKdySIVsjy15cXV4vin/72jMXZ/AsfzYN0Zp4FRbIkmnD VHhWJWgR3M8DEw8eP+ZEepfiiHaVNqnGls/51RAF+N5DOyr5rCURhzixb vp7HqGb0oBsRXj9N+Lt/922YVXQVb/0ZY0kgiN8Ay5x4IUl1QwpKBFhOf OIFVxuT9SC05gkC+PMmoH0uK3vk4MBd/Ik/VX2sc55ejZ9KJu/BJGlflo g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CO4VJZbo
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAA1052F32B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.59 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[osuosl.org:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287464-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[osuosl.org:-];
	RCVD_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.453];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

During an NVM update the PHY reset clears the Technology Ability Field
(IEEE 802.3 clause 37 register 7.10) back to hardware defaults.  When
the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
register is recalculated from stale autonegotiated capability bits,
which the MDD (Malicious Driver Detect) logic treats as an invalid
change and halts traffic on the PF.

Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
ixgbe_watchdog_update_link() so that flow-control autoneg and the PHY
registers are re-programmed in the correct order after any reset.

Skip setup_fc() on backplane links: on 82599 backplane interfaces
setup_fc() resolves to prot_autoc_write() ->
ixgbe_reset_pipeline_82599() which toggles IXGBE_AUTOC_AN_RESTART.
Calling it unconditionally on link-up creates an infinite link-flap
loop because each AN-restart triggers another link-up event.  Guard
with a get_media_type() check and skip setup_fc() when the media type
is ixgbe_media_type_backplane; fc_enable() is still called.

Also handle the failure path: if setup_fc() returns an error its output
is invalid and calling fc_enable() on the unchanged hardware state would
repeat the exact MDD-triggering condition the fix is meant to prevent.
Skip fc_enable() in that case while still calling
ixgbe_set_rx_drop_en() which configures the independent RX-drop
behaviour.

Fixes: 93c52dd0033b ("ixgbe: Merge watchdog functionality into service task")
Suggested-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2 -> v3:
 - Skip setup_fc() for ixgbe_media_type_backplane: unconditional call on
   82599 backplane links triggers prot_autoc_write() ->
   ixgbe_reset_pipeline_82599() -> IXGBE_AUTOC_AN_RESTART, causing an
   infinite link-flap loop (Simon Horman).

v1 -> v2:
 - Add Fixes: tag; reroute to iwl-net; handle setup_fc() failure by
   skipping fc_enable() so stale FC state is never committed to hardware.

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..fc3bae9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8029,6 +8029,18 @@ static void ixgbe_watchdog_update_link(struct ixgbe_adapter *adapter)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
 
 	if (link_up && !((adapter->flags & IXGBE_FLAG_DCB_ENABLED) && pfc_en)) {
-		hw->mac.ops.fc_enable(hw);
+		/* Skip setup_fc() on backplane links: it resolves to
+		 * prot_autoc_write() -> ixgbe_reset_pipeline_82599() and
+		 * toggles IXGBE_AUTOC_AN_RESTART, causing infinite link-flap
+		 * on 82599 backplane interfaces.
+		 * If setup_fc() fails its output is invalid; skip fc_enable()
+		 * to avoid committing stale capability bits that trigger MDD.
+		 */
+		if (hw->mac.ops.setup_fc &&
+		    hw->mac.ops.get_media_type(hw) != ixgbe_media_type_backplane &&
+		    hw->mac.ops.setup_fc(hw))
+			e_warn(drv, "setup_fc failed, skipping fc_enable\n");
+		else
+			hw->mac.ops.fc_enable(hw);
 		ixgbe_set_rx_drop_en(adapter);
 	}

