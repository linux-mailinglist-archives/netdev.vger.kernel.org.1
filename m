Return-Path: <netdev+bounces-288994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMHMD5f0CmpZ+QQAu9opvQ
	(envelope-from <netdev+bounces-288994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:14:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D2D56B59A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BAB230678BC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401313E1698;
	Mon, 18 May 2026 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSXPmAUG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C33EFFC4
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101258; cv=none; b=iFRtEG0zH3Es1x9+TwxU5HTK6eLlgDRhgbuqXLXjPaUxscgbT3bk7DaXs86gT/CU8A2V+47GcAPLgGHdv4imeBsYaNSymHXSiHxcehRxlUadKrCZymrcZv0gfl4bG4c1aVQ9hPdFSsdE8EpC1EnyjRJhgXjc0njQVwIuBgLw4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101258; c=relaxed/simple;
	bh=xWNtN1cj4AsYyc9Iat1gRK5QjeGRUVeuYGCtX8xSifY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2XUbC/ZqWePuVNluoU7NixDcOouYkz+Y4hYY7LtmEkbkyJwEf/REJk3pSY5rm6KdqJcP+zqtsf0yTnvR/3WhQ/STTKvP8LHuBaYM6ieKeCpjaPOficFy3RB+56In0NRxxh8lmeeWrDn1YPaZQ0RS16iaps73NZgyOCWLullGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSXPmAUG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779101252; x=1810637252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xWNtN1cj4AsYyc9Iat1gRK5QjeGRUVeuYGCtX8xSifY=;
  b=JSXPmAUGXSiRuvborsMtFXxs8ljmRqNW+jGz3/AfYcEnAluOB256bRhh
   bWK/dqfadRh4x95rSI7BUs+1W8n6XF/8hP9k2b3GsWqD2lNqQd2RYmWPn
   pNj9VQSz5D+rWXMAdCLR9I2ij4cYNOQ9l4rmWHu4c0oW2vbYoy/uIH8q3
   /ruJBmVNoxCUZYdg+ygSDwN5XDpBgVmtu9wvktm7BwxbUcSeXiHsBX1SJ
   +SI7kHb4cqy5UbAVAVrKi+6CFiZRKCoDlu+h5c4mP7T5Jk4eiVwLtrY0b
   cAzNrNZug7uuKKiV/GDyiUaUQtZunheth9FH6+9ypJuOXpf7a6w9ihfH8
   Q==;
X-CSE-ConnectionGUID: eAxgpeUzRWSqf11SNlJ+2Q==
X-CSE-MsgGUID: wjI88GkyRkSPC74aO1a6LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79802322"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79802322"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:47:29 -0700
X-CSE-ConnectionGUID: X+NZTGi4RM2XZrI7tfDYYw==
X-CSE-MsgGUID: 882RT+XzTd6br+NdoXihdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="243688370"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:47:24 -0700
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
Subject: [PATCH 0/2] Add drm_ras netlink error event support
Date: Mon, 18 May 2026 16:50:49 +0530
Message-ID: <20260518112048.1746280-4-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43D2D56B59A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288994-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Define a new netlink event 'error-event' and a new multicast group
'error-notify' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Wire this support to xe drm_ras to notify userspace whenever a GT or
SoC error occurs in PVC.

$ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --output-json \
--subscribe error-notify

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

Riana Tauro (2):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_drm_ras: Add error-event support in XE drm_ras

 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 50 ++++++++++++++
 drivers/gpu/drm/drm_ras.c                | 86 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 29 ++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |  6 ++
 drivers/gpu/drm/xe/xe_hw_error.c         |  7 +-
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 +++++
 10 files changed, 228 insertions(+), 1 deletion(-)

-- 
2.47.1


