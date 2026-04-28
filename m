Return-Path: <netdev+bounces-281698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGx4IHxm8GkITAEAu9opvQ
	(envelope-from <netdev+bounces-281698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:49:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A198247F3E6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF4B43013FE3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B392D3733;
	Tue, 28 Apr 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wlg3ZW4b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309A2DECA8
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362524; cv=none; b=Xz6kKkbA+3vPc1OxlUKnPkC5lrDyP+V7pskfAX1m9arfAtbIiNqgPfXW6eJ3sFI2enhF2voV4AOZn5BqE2KeYJtch3Ix/tjvtm2H/o1AmeqFe26ZHNp1cJ/BaoYqm8S5t1Y48OINcS7227vO1c4dBeDJPwc2WVoZAHuR45dDNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362524; c=relaxed/simple;
	bh=1J1mF9VLA4ad+WVCKHtPLi8k9wXENH/phrj6cZ2eDTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erkHWVSA3oD80s6vJ+dpZa+7haLFj8xfAf26yPkR294GwSRKsM/pITz15d7Qz+QBJTWcGF8lqYn4g9FchUsLtcL/uFhby3WXMF96j6RfzjtQN4meP7PYC0sZCQsoQu2YGBXRHN8Mozy4PClW0yGUglG4VdgFdytG65e5mLuBAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wlg3ZW4b; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777362523; x=1808898523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1J1mF9VLA4ad+WVCKHtPLi8k9wXENH/phrj6cZ2eDTM=;
  b=Wlg3ZW4bvuLlDi81nsjK8C8Mu6W8iWuUNKWASrneUxOb/PQkcM0D4mGk
   XaX5aBJGkodkCw/c2B3cNBan3uWfArfmNuDNhgh/tJ1e55SLb811vibyO
   jkrace46HmkebSHu75lB2Z+9K5bYyKlCzBiNvNsj08HnN6rWfGs2mdqsN
   NzbNkK1f3LY2HkD1cBk1i4cEflaN8hcyydL2ugC+N+208K4LSYSF9s0bF
   vgq2PZd0MplGjxUdSCGExmS6248hdS2psOIucDD4BVZEItmkgzT2N2oKu
   4mHN971TmxzDN3GUtxQGCPGTfEDzAf+YlsUKZ+FcPuklRuPnpZbNMvEYs
   w==;
X-CSE-ConnectionGUID: 9VKO7rIdRliUuBo9QksYMg==
X-CSE-MsgGUID: TTKmO3LkSWGBj/WMBMwNDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82114973"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82114973"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:48:41 -0700
X-CSE-ConnectionGUID: 6zDqpDuoQdS5dOu/lJqulA==
X-CSE-MsgGUID: 81SKb8KxQ/S+MTVdb8qPmQ==
X-ExtLoop1: 1
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2026 00:48:37 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jramaseu@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net v1 0/2] Rework ice Tx checksum
Date: Tue, 28 Apr 2026 09:06:45 +0200
Message-ID: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A198247F3E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281698-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

Jakub find the problem with how ice handles Tx checksum offload [1].

The issue is that IP_CSUM/IPV6_CSUM should support only basic packet
types. Kernel assumes that if there are extensions headers and there is
no HW_CSUM software fallback should be applied. Here is a patch that
introduced that [2].

However, software fallback can't be applied when TSO offload happens.
That is the situation that this patchset is fixing.

When TSO is enabled and IP_CSUM/IPV6_CSUM is on, kernel is assuming
hardware will be able to calculate the checksum, but later on the
extension headers are checked and if there is no HW_CSUM the
skb_bad_offload() is called.

Following the documentation ice driver is capable of HW_CSUM support, so
switch from IP_CSUM/IPV6_CSUM to HW_CSUM. Other Intel drivers (even
previous like i40e, ixgbe) also supports HW_CSUM.

The HW_CSUM was used to indicate that GCS (Intel name for checksumming
offload using additional descriptor) is support, which is variation of
HW_CSUM. Even without GCS th HW_CSUM is supported. First patch is
switching to use custom Tx ring flags to allow HW_CSUM usage.

[1] https://lore.kernel.org/netdev/20260310150557.1138437-1-jramaseu@redhat.com/
[2] https://lore.kernel.org/all/5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr/

Michal Swiatkowski (2):
  ice: always do GCS if hardware supports it
  ice: use NETIF_F_HW_CSUM instead of IP/IPV6

 drivers/net/ethernet/intel/ice/ice_lib.c  |  4 ++++
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +--------------------
 drivers/net/ethernet/intel/ice/ice_txrx.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h |  1 +
 4 files changed, 7 insertions(+), 21 deletions(-)

-- 
2.49.0


