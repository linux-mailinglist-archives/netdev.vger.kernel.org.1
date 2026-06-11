Return-Path: <netdev+bounces-297940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j6OFHPBGKmpqlgMAu9opvQ
	(envelope-from <netdev+bounces-297940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D97E766E88F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gXy1mXHy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297940-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297940-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 104283048C37
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E733F5B4;
	Thu, 11 Jun 2026 05:22:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E03546E7
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:22:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155328; cv=none; b=XJjt9Vw0J82ANUwC9YSnU90xhBv1EEEx+uyFDXyvo6FgtMLjndCwm7g9F6VmW9asxmtN7hhM8cYNAvkJl0zekt6Hzlg/eZ505NFyEi5RIeDgYzGQsvM8rxDBWcOW7qEfunGqsmL2yJrG8+xvqlY+1OUtYBPp33MtStOO6CAs/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155328; c=relaxed/simple;
	bh=hJno5jC2C+vPsGOzW3AiPZp0qhSHErWSjGpY/uMCtRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJUTxCi89J0oLwwLEJP3DrsEGPTXhxbN9bhQ8O9+2yiXn+/tBkCXSsAI1OI+6Sjr4toTpLKz05dXxkMJulMYD9Wvng+7sEWEejKTSjTW48ZwXK4kA213OeTE8ek0NrWgHBACdYvSK/1iBuu1qjQbRqANdZrO86N+DTG5Qtu/xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXy1mXHy; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781155325; x=1812691325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hJno5jC2C+vPsGOzW3AiPZp0qhSHErWSjGpY/uMCtRE=;
  b=gXy1mXHykQX2chHUxQt0yHQhjPZnNrbi/W+umVOLdF6cBFfvQL5mkWaB
   3nJvVmH9MA0xCNtTUOld1iuEqELGElF7ELEPHiJxe41skdzWn3KeF9E37
   n4XvlGovCn1/f09QAR82qbYPnpQ2xzmNxZ5uWn+ePCaspGIY9/U0SBHbl
   gNN4omhgRPotiwVhfCC4xOxNVDMsF8Su9eCHwKmOB2YD+uV9EXpFJU+Kl
   0Owl3RszmHAq7/9qBt/3d896YdPriZIR0s4QtoIFzLNEegcGOq/Dx8hNa
   db2MP3lYxZJJ2dIBmoJrrhfYxrmvrdf9ge1JP5V1ySKIKxDZtOZAWBwOf
   w==;
X-CSE-ConnectionGUID: rMl4UM4nSB2n9pm64MEPOw==
X-CSE-MsgGUID: otkPOhJgSKuWkcC9T6X5ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82069840"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="82069840"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:22:04 -0700
X-CSE-ConnectionGUID: R43zxcsUQseyD3c5LWfOLw==
X-CSE-MsgGUID: gmL9S5vERHumw2cmgivP7g==
X-ExtLoop1: 1
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:21:59 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v2 0/2] Add drm_ras netlink error event support
Date: Thu, 11 Jun 2026 10:51:45 +0530
Message-ID: <20260611052144.784969-4-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297940-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:riana.tauro@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D97E766E88F

Define a new netlink event 'error-event' and a new multicast group
'error-notify' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Wire this support to xe drm_ras to notify userspace whenever a GT or
SoC error occurs in PVC.

$ sudo ynl --family drm_ras --output-json --subscribe error-notify

{
    "name": "error-event",
     "msg": {
         "device-name": "0000:03:00.0",
         "node-id": 1,
         "node-name": "uncorrectable-errors",
         "error-id": 1,
         "error-name": "core-compute",
         "error-value": 1
     }
}

Rev2: use ynl in document and commit message
      fix cosmetic review comments
      simplify caller 

Riana Tauro (2):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_drm_ras: Add error-event support in XE drm_ras

 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
 drivers/gpu/drm/drm_ras.c                | 88 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 26 +++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |  3 +
 drivers/gpu/drm/xe/xe_hw_error.c         |  5 +-
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 ++++
 10 files changed, 220 insertions(+), 1 deletion(-)

-- 
2.47.1


