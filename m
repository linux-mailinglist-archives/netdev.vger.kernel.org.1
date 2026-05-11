Return-Path: <netdev+bounces-286868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA0FEjdpAmoxsgEAu9opvQ
	(envelope-from <netdev+bounces-286868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:41:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB55175C6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D98543097E90
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81642361666;
	Mon, 11 May 2026 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjLe09tM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180C331A78;
	Mon, 11 May 2026 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542624; cv=none; b=Ro976xcEw/MzxzfZdh1ItU4neN8ccacmEvtTmPbkbnaDB48ujBXrRlX+Yeyvwu4EUZRokkE8uN4f2G6zxT4mLbT2NrChuG7uYAAR3u4ftPiT/ayRGwBi8mgVh1Jc+bOc961GD+pi7sFcngcjrNQTrG8hjdOD6LcKDLZEPNJ6RPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542624; c=relaxed/simple;
	bh=jhnNpw7Tz9YNTDn5gSXM/OGnATSxI7/qoJ9Vwt+/2hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6a1fhMMjBJ0584+QkAKK5fuMgTLSYS9H2seD6JUUMgPbWdapz9V93xi25HVuHDfM2lDJTnfAQMGTlFOdpIdDSurp2eVJy3rlFJfDQ92mcVwovP+aM3IjQfDnALshX4zY2wdUtylDezLz09laIkmXq7xIo+T+r+4PkpZ0Ylupuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjLe09tM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778542623; x=1810078623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhnNpw7Tz9YNTDn5gSXM/OGnATSxI7/qoJ9Vwt+/2hQ=;
  b=LjLe09tM6/G5yAYhT8Us5QgHu52njd7vFeeVpL+YknS0OnkH40xwHwi9
   TVvSLXINSqMF97VY4B+pefdQPtVNHAq4Q08Te+9Jrs1AF5M5HlOHSKQos
   W9L3GLpbNsaMEEJJcWeyTVlFtdr1TGxTveimdijWz8IxcZk2kK+oCFJ4H
   EO0gH0SW1PmCtl/S9Qf9HGaH87COBq7vxm3Rr6M7zcqT4llKJm5scs1kY
   HO2Z5pzcplD7JEedh07vud+EkNYjkgs3k9O0MbgCXaBeHURkIVj3cD9E2
   Sg/uS0FXADtqo7E9lbMSA/1xeI4voG61Fq+4+lYiwFISeGrMlAJc5Z+lT
   Q==;
X-CSE-ConnectionGUID: yFZI+YjvSG6GVlXD1DMyWA==
X-CSE-MsgGUID: 1mrYJbO6TJibcOFK9rrUDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90027443"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90027443"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:37:02 -0700
X-CSE-ConnectionGUID: oNxBHVO9SaS1Rc8yfAnM/g==
X-CSE-MsgGUID: 6NekB70dSIeznRfpxS1bpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237687354"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa009.jf.intel.com with ESMTP; 11 May 2026 16:36:57 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v8 net-next 7/8] ice: add Tx reference clock index handling to AN restart command
Date: Tue, 12 May 2026 01:31:58 +0200
Message-Id: <20260511233159.2558165-8-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
References: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B1AB55175C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286868-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Extend the Restart Auto-Negotiation (AN) AdminQ command with a new
parameter allowing software to specify the Tx reference clock index to
be used during link restart.

This patch:
 - adds REFCLK field definitions to ice_aqc_restart_an
 - updates ice_aq_set_link_restart_an() to take a new refclk parameter
   and properly encode it into the command
 - keeps legacy behavior by passing REFCLK_NOCHANGE where appropriate

This prepares the driver for configurations requiring dynamic selection
of the Tx reference clock as part of the AN flow.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 ++
 drivers/net/ethernet/intel/ice/ice_common.c     | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_common.h     | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c        | 3 ++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 3cbb1b0582e3..42878abac9eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1169,6 +1169,8 @@ struct ice_aqc_restart_an {
 	u8 cmd_flags;
 #define ICE_AQC_RESTART_AN_LINK_RESTART	BIT(1)
 #define ICE_AQC_RESTART_AN_LINK_ENABLE	BIT(2)
+#define ICE_AQC_RESTART_AN_REFCLK_M	GENMASK(4, 3)
+#define ICE_AQC_RESTART_AN_REFCLK_NOCHANGE 0
 	u8 reserved2[13];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b617a6bff891..ee7fa4654fe3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4124,12 +4124,13 @@ int ice_get_link_status(struct ice_port_info *pi, bool *link_up)
  * @pi: pointer to the port information structure
  * @ena_link: if true: enable link, if false: disable link
  * @cd: pointer to command details structure or NULL
+ * @refclk: the new TX reference clock, 0 if no change
  *
  * Sets up the link and restarts the Auto-Negotiation over the link.
  */
 int
 ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
-			   struct ice_sq_cd *cd)
+			   struct ice_sq_cd *cd,  u8 refclk)
 {
 	struct ice_aqc_restart_an *cmd;
 	struct libie_aq_desc desc;
@@ -4145,6 +4146,8 @@ ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
 	else
 		cmd->cmd_flags &= ~ICE_AQC_RESTART_AN_LINK_ENABLE;
 
+	cmd->cmd_flags |= FIELD_PREP(ICE_AQC_RESTART_AN_REFCLK_M, refclk);
+
 	return ice_aq_send_cmd(pi->hw, &desc, NULL, 0, cd);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e700ac0dc347..9f5344212195 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -215,7 +215,7 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 		enum ice_fec_mode fec);
 int
 ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
-			   struct ice_sq_cd *cd);
+			   struct ice_sq_cd *cd, u8 refclk);
 int
 ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, struct ice_sq_cd *cd);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 837b71b7b2b7..8cdc4fda89e9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3769,7 +3769,8 @@ int ice_set_link(struct ice_vsi *vsi, bool ena)
 	if (vsi->type != ICE_VSI_PF)
 		return -EINVAL;
 
-	status = ice_aq_set_link_restart_an(pi, ena, NULL);
+	status = ice_aq_set_link_restart_an(pi, ena, NULL,
+					    ICE_AQC_RESTART_AN_REFCLK_NOCHANGE);
 
 	/* if link is owned by manageability, FW will return LIBIE_AQ_RC_EMODE.
 	 * this is not a fatal error, so print a warning message and return
-- 
2.39.3


