Return-Path: <netdev+bounces-291028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEPsL7c1EWpeiwYAu9opvQ
	(envelope-from <netdev+bounces-291028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:05:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A025BD2C5
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE0430177A4
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76C233941;
	Sat, 23 May 2026 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXKa36XC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EF4204E
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512748; cv=none; b=MoTL0uYxW/XysnQZW9AXVvCN0Y3aKprLIYmnQgsYPd75IgoVqh2l6tjn92dTmPTayJY3u7NNs+RdqZkd9Vm7hFTEapu0OoPxAeMzfDoerJ2+em2yTQT7nA9j4Kp63zUPFaIOwQlgOSjoMUsIeVP1B8Iv1r45ESeoqnCBQomt38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512748; c=relaxed/simple;
	bh=oDS8N6xhUFY5za2tnraZ+5wty3X3X4mA/8BTEGBeA9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNJ4fFIqmiwdVfJVO+Fj5v1gajSOMar775RD/1fveYOpzaQIUWQ5ZY1G3+erPON+GeyW5ilZfBeauXZEhwciDe5uMNnUq15DUsekji8TbItMduqrVUbQBFl0qb7Zu0QQpq60JdEaJ8lVFixqkVh9ggJABgJWFKNhtjwCd+pF9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXKa36XC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779512746; x=1811048746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oDS8N6xhUFY5za2tnraZ+5wty3X3X4mA/8BTEGBeA9g=;
  b=lXKa36XCoNE+pH8h5BxDILCW3Tv0hJ1scjbfUvYNAo4YpmcwXKch7T8z
   8RxAmFoHNvrk0vrfJu+iLxTXcpRpvLW6NkiNao8vhMh/HyEecnq7oT3wo
   d4ia8TpS6p27GOPeF9HXZH+uBH3fYo3NbPR3dUzinH9LBMjS6oDHJb9/V
   UZmWT+Wp3qp0oLzW9AldX9OS3jnHBdCOH1TCxoG/A5pkVFJWx6SJJcDbP
   fzB0yTZAKM9UgkDj79asxa25BaNEazmCncH04e9B4djxfEqgL9fHS+8ne
   //RnaoDTHZcbvOtVljrczizgtqGvPtUA3VphqeMdXsMo7H7KY/dmhMK3R
   g==;
X-CSE-ConnectionGUID: rmg7+YlsS9uZQHWOVYdPiw==
X-CSE-MsgGUID: i7+veOmdTdm2hKpfwtACgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013524"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="83013524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 22:05:45 -0700
X-CSE-ConnectionGUID: eSV9SZH7T1Kddhot6eatEA==
X-CSE-MsgGUID: MCfeo5ECTUGhuu/h0Osb6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="279199745"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:42 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	dev@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/4] DRM RAS Fixes
Date: Sat, 23 May 2026 10:30:18 +0530
Message-ID: <20260523050212.557292-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291028-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 30A025BD2C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Detailed description in commit message.

v2: Use goto (Riana)
    Retain info as NULL on failure (Riana)

Raag Jadav (4):
  drm/ras: Cancel and free message on get counter failure
  drm/xe/drm_ras: Make counter allocation drm managed
  drm/xe/drm_ras: Add per node cleanup action
  drm/xe/hw_error: Use HW_ERR prefix in log

 drivers/gpu/drm/drm_ras.c        | 19 +++++-----
 drivers/gpu/drm/xe/xe_drm_ras.c  | 62 +++++++++++++-------------------
 drivers/gpu/drm/xe/xe_hw_error.c | 12 +++----
 3 files changed, 41 insertions(+), 52 deletions(-)

-- 
2.43.0


