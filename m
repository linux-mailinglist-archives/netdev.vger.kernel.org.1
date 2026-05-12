Return-Path: <netdev+bounces-287270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI5wB1p9A2pV6QEAu9opvQ
	(envelope-from <netdev+bounces-287270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:19:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D655287BF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1882B3001CD4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF87368D6F;
	Tue, 12 May 2026 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAQwiONS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC42D6E6C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613588; cv=none; b=KSzmhckbywHztkBcSsAS7jq49oEOGzssG2d/UUo4mAabnhGe3LcI1SWYtsD51LtqtHaI+hpKyQUUwqVO7iF1x3f4HHnSiheMHmd9tgzhhRxfudOnC6bkkbYPSPqmRXszysuUry8KidhDcBG2GWXwd1g9t0Zm5IsIpgPLLkiUTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613588; c=relaxed/simple;
	bh=EuMqPelopBeDArrWKk2175+d6q9fCx7CditHqqGkoHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhhvXcrEVwG1L8RqhLE8E6ujty/V0KYLaGc2Vdn8RmMKfYMw6bl3zRCrH4Aora7nPHp9c+LcMYjo7jhnhG9nyT2oVKkyquLsoeITfoHWhRgBj0+Y1c1l/zdhoPS6Qr5fm+67jIZ5LKpofqsCLfEzSLYm1U5ZzcuE7mYD6Z/VTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAQwiONS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778613587; x=1810149587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EuMqPelopBeDArrWKk2175+d6q9fCx7CditHqqGkoHw=;
  b=UAQwiONSlutOl+9ga2LdPap6fi6bmza8XDeFe4pORw2ZzNhcs62fY23F
   i65U5NPSqhE/xoZTJqX746MxAmUSHVzsmLO/Xm2IoldsGp70YOCZEyKEl
   7OxAF842Zd2lJJ7HtrvpDst29gja3VSU4H6eLiaPllRL5Ncl7vZebroD3
   gQbaSr6GE4r0mlVH6DF3h7MpXoZNXcEGlrcgI4guICMuqxZnM34+9eIym
   dHZzB3Gga6iggBQlY5idriDSh30VSm9uIsQCOYzfy5eSCTmZcq/fMXcpQ
   db4rZWj2fUGCCyBzBcSdfoJyG6/7Jy8cCq+NqE9yMMC9J7pm71krXlEbz
   A==;
X-CSE-ConnectionGUID: ihxtnv+NT+eu9wAGKAJo8A==
X-CSE-MsgGUID: bQ4YD+7yTTiorqoM8lx3dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406336"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83406336"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:19:46 -0700
X-CSE-ConnectionGUID: yF3zCk34Q4idbIEjgBERiQ==
X-CSE-MsgGUID: 5kT/gbdrRSm7FarWzwopQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237781373"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:19:41 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	maarten@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com,
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/9] Introduce error threshold to drm_ras
Date: Wed, 13 May 2026 00:46:01 +0530
Message-ID: <20260512191610.1817578-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 39D655287BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287270-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series reuses some pieces of [1] and introduces error threshold to
drm_ras infrastructure. This allows user to get and set the threshold
value of a specific error.

Detailed description in commit message and documentation.

[1] https://patchwork.freedesktop.org/series/164393/

v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
    Document threshold value bounds checking responsibility (Riana)
    Add RAS operation status codes (Riana)

Raag Jadav (6):
  drm/ras: Update counter helpers with counter naming
  drm/ras: Introduce get-error-threshold
  drm/ras: Introduce set-error-threshold
  drm/xe/ras: Get error threshold support
  drm/xe/ras: Set error threshold support
  drm/xe/drm_ras: Wire up error threshold callbacks

Riana Tauro (3):
  drm/xe/uapi: Add additional error components to xe drm_ras
  drm/xe/xe_ras: Move xe drm_ras registration
  drm/xe/xe_ras: Control xe drm_ras registration with a flag

 Documentation/gpu/drm-ras.rst                 |  18 ++
 Documentation/netlink/specs/drm_ras.yaml      |  40 +++-
 drivers/gpu/drm/drm_ras.c                     | 174 +++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  27 +++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/xe_device.c                |  19 +-
 drivers/gpu/drm/xe/xe_device_types.h          |   2 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  27 +++
 drivers/gpu/drm/xe/xe_hw_error.c              |  13 --
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_ras.c                   | 150 +++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   5 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  50 +++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c       |  29 +++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h       |   3 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 include/drm/drm_ras.h                         |  29 +++
 include/uapi/drm/drm_ras.h                    |   3 +
 include/uapi/drm/xe_drm.h                     |  11 +-
 20 files changed, 581 insertions(+), 31 deletions(-)

-- 
2.43.0


