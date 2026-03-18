Return-Path: <netdev+bounces-268912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOxeKvteumnFUgIAu9opvQ
	(envelope-from <netdev+bounces-268912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:14:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB12B7A82
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF06631B74A8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936A36C0B0;
	Wed, 18 Mar 2026 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MI+/NFXb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58136C0A0
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821263; cv=none; b=VkAmYHXQaapVNpAc67ML5ViuxG7F6oja5LvEMmuc7uVU99/qC+lJBLe8Ya4lw1r2ZSJLae34B88bo3T7kWFtjBW8ZqpDZG9TDceeqxaj0n8kssKPEDCT2RNkxYh3abSX45URJHpu7v/IFW4ajIabuQu1letsmKHdas68zC57yVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821263; c=relaxed/simple;
	bh=84LnzcZCMYp6duMUvt8hli/mHgvmoXyWC9z9VVw9BfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwYUqdEBFWC1aKAdIEigsxhi6dhYWavruOuVTNi2qkb7RD+8oyH4m9jmxpOicJptvoLXg3c3PP+v0uipsJ0XVE3p0Cdlxf8sdmBbOq605io8S+RJ1wR4wMpMS4Nu/9X+iiZa1HCf3q4HiNwkT3njQbs8WJ3GniPbSH59yEwY5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MI+/NFXb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773821261; x=1805357261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84LnzcZCMYp6duMUvt8hli/mHgvmoXyWC9z9VVw9BfA=;
  b=MI+/NFXbZfUTOY0MBWmoqBqro309j80moFVkpTCkzUlSxp7opGhhLvV9
   +kOkdgWVu1V/51zoxy62MsE8SWbzdt6+1vNblm967IwdNB5Iy446TPSIB
   g6/Mh4NTRDd7aKcrwpDwYVzTe5joxBRV2bMoO5fzfmJEhCUI1CDdIK0SD
   HUjTqrae6EaS8qd6+NICrz/IdFLT/o6LKiWq6UEUzWmZCC3Ovrhhr7Gnb
   cGMhslN6NRZbHk0ZLTw9scXZxOEGPS6Q0km+H5Eu4VGwWAHdBcyi+i01R
   5EwvTxysew0PvkffyjwZRq3DNRRM/sGuw+Qc9OtdgICLdH7+RkfChW9p6
   A==;
X-CSE-ConnectionGUID: jaTU0oU0T0WuNuo88Yymuw==
X-CSE-MsgGUID: 8k8DsMRGR3Cn98r9/+uj2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74755244"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74755244"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:07:41 -0700
X-CSE-ConnectionGUID: jdC19aAIR+2gvK0MrbS1bw==
X-CSE-MsgGUID: nV1zGSKUSb67sYXQUFbPUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221628545"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 18 Mar 2026 01:07:39 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/2] virtchnl: add VIRTCHNL_VLAN_ETHERTYPE_88E7 support
Date: Wed, 18 Mar 2026 09:07:35 +0100
Message-ID: <20260318080737.3012293-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318080737.3012293-1-aleksandr.loktionov@intel.com>
References: <20260318080737.3012293-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-268912-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BBB12B7A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IEEE 802.1ah (Provider Backbone Bridging) uses ethertype 0x88E7 as the
Backbone Service Tag (B-TAG). Some deployments stack 802.1ah on top of
existing QinQ or single-tagged VLAN infrastructure, creating scenarios
where a VF needs to negotiate support for the 0x88E7 ethertype with the
PF in order to install correct VLAN filters.

Add VIRTCHNL_VLAN_ETHERTYPE_88E7 = BIT(3) to the virtchnl_vlan_support
capability bitmask so that VF drivers can advertise and negotiate 0x88E7
VLAN ethertype support through the existing VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS
handshake.

The new bit follows the established BIT(N) pattern of the enum and does
not conflict with any existing flag.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 include/linux/avf/virtchnl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 11bdab5..511c882 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -636,6 +636,7 @@ enum virtchnl_vlan_support {
 	VIRTCHNL_VLAN_ETHERTYPE_8100 =		BIT(0),
 	VIRTCHNL_VLAN_ETHERTYPE_88A8 =		BIT(1),
 	VIRTCHNL_VLAN_ETHERTYPE_9100 =		BIT(2),
+	VIRTCHNL_VLAN_ETHERTYPE_88E7 =		BIT(3),
 	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1 =	BIT(8),
 	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2 =	BIT(9),
 	VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2_2 =	BIT(10),
-- 
2.52.0


