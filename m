Return-Path: <netdev+bounces-301326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8na9C6VcOmpv7AcAu9opvQ
	(envelope-from <netdev+bounces-301326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD16B6269
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:14:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Xy2U62Qs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301326-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301326-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B1F63005EBA
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D1370D5E;
	Tue, 23 Jun 2026 10:14:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6741370D43
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:14:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209694; cv=none; b=T0dIlulLK8cv5flJMSY6ERXRXt7agMBXXHSafpUmuAeYxt1L3IWSFPiiZ2WYszNl6XrdVP8yY1mvGPrPPhJFTaxr++f7f2+7TmIy5KcQZ7ljhqmNVjtWdKVO8jkWFCh14uQ8ZCcU0hMP6cgwapV8LGRNniJjFIkOsr4vyQdCk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209694; c=relaxed/simple;
	bh=SMkf0D+YV5OJmnBlJj4MkBurBCKh39zccp5DMkHXsoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cd2ZdWTHtoqUgc8nhIPpjF3B8gJM2a6nnHfzxn7GNCbX+62dKDzS67TY4b+/emD6cZ6QQ203KYYHwStkqADF1S0uF6sOVU/LuDw6D1UMKfGmOuT0Vg8Gf6pLbByzQ7p768SDZYkQJ4CNRNqxNnM1fjppuxF8pXck24njfSqs6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy2U62Qs; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209693; x=1813745693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SMkf0D+YV5OJmnBlJj4MkBurBCKh39zccp5DMkHXsoY=;
  b=Xy2U62QsJKpu1JtXtAwdzlKBMg1sxY1OeHCd2cz7ffbFiAPm410KXE7U
   eB85BLT0jOuQ+lefm2xHmbd8Aq85IFn3sqsWvgVshEiKGWILTW9+cZddh
   SZYz1q6VRdCKvPMIMbGU2PTtRS+JJMUT1/UCxO4ZKUasU2HhqeOq+vpGr
   QeStK7IiJhbbvhBfRtqYhLndsLGC8+hMoH5VztoLzhh/qTent7AwadXfC
   oZvIfmhC5awzwNpLsD1HaYplajMuTWAnqhxyrOMOZzVzSAILm0LSEWos7
   RYu30pclDXNbtB7Cwo3B+ziUNnxdPUOEGeA/QmsJoUqBIReLfqjgfMBTW
   Q==;
X-CSE-ConnectionGUID: vaPD6WmmR2GMJOx6D08SGA==
X-CSE-MsgGUID: CVHR8RV8QymsSsnB1Zw1MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82053137"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82053137"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:14:52 -0700
X-CSE-ConnectionGUID: R1kV7eFJQm+LHHdZwJKo8w==
X-CSE-MsgGUID: GJD4eZNlTgyFMek7vzSAjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="273175461"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa002.fm.intel.com with ESMTP; 23 Jun 2026 03:14:47 -0700
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
	dev@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	mallesh.koujalagi@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 0/5] Introduce error threshold to drm_ras
Date: Tue, 23 Jun 2026 15:39:54 +0530
Message-ID: <20260623101043.255897-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-301326-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:riana.tauro@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,m:raag.jadav@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34BD16B6269

This series introduces error threshold to drm_ras infrastructure. This
allows user to get and set the error threshold of a specific counter.

Detailed description in commit message and documentation.

v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
    Document threshold bounds checking responsibility (Riana)
    Add RAS operation status codes (Riana)
    Use goto (Riana)

v3: Move documentation from yaml to rst file (Riana)
    s/value/threshold (Riana)
    Use goto for error handling (Riana)
    Reuse status codes and uapi mapping from counter series (Riana)
    Access request/response counter using local pointer (Riana)
    Mark unused field as reserved (Riana)
    Return -ENOENT on info absence (Riana)

v4: Clarify 0 threshold expectations (Riana)
    Drop redundant wrapping (Riana)
    Make debug logs consistent (Riana)
    Update kdoc (Riana)

Raag Jadav (5):
  drm/ras: Cancel and free message on get counter failure
  drm/ras: Introduce error threshold
  drm/xe/ras: Add support for error threshold
  drm/xe/drm_ras: Wire up error threshold callbacks
  drm/xe/sysctrl: Reuse xe_sysctrl_create_command()

 Documentation/gpu/drm-ras.rst                 |  18 ++
 Documentation/netlink/specs/drm_ras.yaml      |  32 ++++
 drivers/gpu/drm/drm_ras.c                     | 178 +++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  27 +++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  34 ++++
 drivers/gpu/drm/xe/xe_ras.c                   | 105 +++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  51 +++++
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |  28 +--
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 include/drm/drm_ras.h                         |  28 +++
 include/uapi/drm/drm_ras.h                    |   3 +
 13 files changed, 487 insertions(+), 27 deletions(-)

-- 
2.43.0


