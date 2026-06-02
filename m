Return-Path: <netdev+bounces-294308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HhPgGMEOH2pKewAAu9opvQ
	(envelope-from <netdev+bounces-294308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:11:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A0C6308E9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:11:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=eCH5oOBX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294308-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294308-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1855C3040C2B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4E23B2AA;
	Tue,  2 Jun 2026 17:09:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B013F54C4
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:09:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420173; cv=none; b=M6nFC+6TOI3+xeFxFn1SXlYmCWoJ2unTiRYGQrS9dbAlKZ3aOtL/gKsU8OZOcExoAAmP7yaryik7oZg5qXD5pVfG18VvovMt05BgVpAu5ld4TnIcgZJEorcML+1+uvDvo3/eM6Lwsp90ZQLqtRQPGNFchPMpszWbhL6IhfA2SJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420173; c=relaxed/simple;
	bh=zV8mJg/ulwrxR+PEa19yPUKXBMuYknTDOr05srO4sXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o30n6xbwoUT/ZPZnlBKSbS7wc2coxsGPyFLPjRe0nw4BdM6sUys7JwDcgB9QW19uvvPBGwnMIkDfxQCdTAOG/+n72VwjqEFIKiB7rmUv6a7SZP8TZpxbmX/mh/XtZuuOzwdjdvbOXfOgHEMQk8lMfHOI1gw0MTJjGjc4sCPykYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCH5oOBX; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780420173; x=1811956173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zV8mJg/ulwrxR+PEa19yPUKXBMuYknTDOr05srO4sXU=;
  b=eCH5oOBXs57DNV1PYYYADZkWm+D/eTk2iizEFcD+GQqa7U+mFXkSLNen
   zFFViZeVESX1u8D2VD625RBz84j+ILpxkAtP7+gpDFgCFhySsyZxkTMMv
   h/2EcHVPShH0qjeWfQqrwJ0GQOlr/V5CtLELR3cB52OxBtrEijmM3G6U/
   2t7kg0G0dAklTeTzGICAfCKRE13Lc/BMegsJtX9Yj9O1bxlvcgAwLkBTw
   Ukq+Al0Vg4u7mjHBqWRbVBqkbn51OKnLMeK3PCG5S9OP54VrzPC5VQiZN
   UGhaj37cUQT2o0aFNXlcaU+/1NsqyjUCi5EOAyhM+ZEFdeitcYM6MMly+
   A==;
X-CSE-ConnectionGUID: uVtmYjvwRHGlcqTA+Mvr9g==
X-CSE-MsgGUID: Huc5eSg3ThqwD+xOZ/VSXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81074144"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81074144"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 10:09:32 -0700
X-CSE-ConnectionGUID: 96dHYEVyQCSSfybcPWMgKA==
X-CSE-MsgGUID: Q5t1NlO3Tf+ZAuzRdz3W0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241475795"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa008.fm.intel.com with ESMTP; 02 Jun 2026 10:09:31 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH net v2 0/3] idpf: queue based scheduling fixes
Date: Tue,  2 Jun 2026 10:20:21 -0700
Message-Id: <20260602172024.2285947-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-294308-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4A0C6308E9

This series fixes some TxQ scheduling mode issues exposed by recent FW
changes, as well as some issues reported by Sashiko.

Patch 1 prevents XDP from being enabled if queue based scheduling is not
supported by the firmware.

Patch 2 fixes a data race when accessing next_to_clean in
IDPF_DESC_UNUSED. 

Patch 3 fixes a NULL ptr dereference in the Tx path when queue based
scheduling is enabled, and also adds support to process both 4 and 8
byte completion descriptors to avoid timeouts in queue based scheduling
mode.


Joshua Hay (3):
  idpf: do not enable XDP if queue based scheduling is not supported
  idpf: fix next_to_clean data races
  idpf: fix skb datapath queue based scheduling crashes and timeouts

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 60 ++++++++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 15 +++--
 drivers/net/ethernet/intel/idpf/xdp.c         | 10 ++++
 4 files changed, 62 insertions(+), 26 deletions(-)

-- 
2.39.2


