Return-Path: <netdev+bounces-241434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC7C83FF4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CCBB4E3CA0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12272D7DD9;
	Tue, 25 Nov 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNwmAUNn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B12D63F6;
	Tue, 25 Nov 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059702; cv=none; b=JtjQ5KaG2LUcOm7NoUUDw2xJ0FV5zBvGttAw1rgMybGRQcVxRt8cXamOetMmmpjOXxiBwLm++I1G7xFimQD1Q7En2V0sSvh34LBQwhwN19wBRg182rn/2M4pIiCilAKL1yNSsQiLOsxGRqHjSMgbeo6JgnnzGl2FFgYZ+nWENOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059702; c=relaxed/simple;
	bh=/COM01iDe7ScHeWoXirsZZeq3NXY859DqpHTEVVreL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b36fB+9Smmhl3fs0tn8rZsmj43tzWS8dVGVwYRa/KCCpf4Xq6EXdsjqQOA0gtSJBJqhjQUspwFjGTH1LHi7kZLTkqSCyoCiLmKoP/WQqrccd8NIaV18XCsE3r2UkB1TJNoJXZ0E7H8i+rGn7swf0/ILXaezpKp3L1B12YlMhH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNwmAUNn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059701; x=1795595701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/COM01iDe7ScHeWoXirsZZeq3NXY859DqpHTEVVreL0=;
  b=PNwmAUNnk/9UpmfWx8URnW4v3h/WRfqS54cDEwsmOR49ZOf0SV4Vv5Xw
   tBLPj68x4Ob0qbdfKIcmL1QEluGbmWzKjTvgUpWLjK1IWmrlk492MVO26
   cIMZ3TH3su+ws3PwI/hx4vW7LfvQbOqPxtYp1U0bLi+/GIveO43tkztw+
   /tqeJ6cmLMFNTczg6c0ftM4fHclZfSQMy9vprvFuE0lb5YUu6idI7NDGh
   ZghQRILaFFn5yOA9BXLq05p/4F3jKXsVQ0EI3ZrqpyYOy+m6nJcY1SWQ6
   yMWmFAjQAmwqDte71JeUFNW6u33K7vVxZ36dQyxYs1mE3JCpXbCliGJLy
   A==;
X-CSE-ConnectionGUID: h55GyWOJTMuMbYSNA4nPoA==
X-CSE-MsgGUID: /a1aLIAuRFSb+YaB0mFjQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76694420"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76694420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:35:00 -0800
X-CSE-ConnectionGUID: z7z3X2RGTY+yf1PRMR7r2w==
X-CSE-MsgGUID: KPiifWWsT5iYc8fdiJgy8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196749750"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 00:34:58 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 0/8] ice: in VEB, prevent "cross-vlan" traffic
Date: Tue, 25 Nov 2025 09:34:48 +0100
Message-ID: <20251125083456.28822-1-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Currently, packets that match MAC address of a VF will be sent to loopback
even if they would cross VLAN boundaries.  Effectively, this drops them.
In this patch series, we aim to address this behaviour by adding MAC,VLAN
to complement what MAC-only filters do to select packets for loopback.

To reproduce the issue have E810 connected to another adapter, then:

    ip l set $pfa vf 0 vlan 4
    ip l set $pfa vf 1 vlan 7
    ip l set $pfb vf 0 trust on spoof off vlan 4
    ip l set $pfb vf 1 trust on spoof off vlan 7
    ip l set $vfa0 netns $netns0 up
    ip l set $vfa1 netns $netns1 up
    ip netns exec $netns0 ip a add 10.0.0.1/24 dev $vfa0
    ip netns exec $netns1 ip a add 10.0.0.2/24 dev $vfa1
    ip l add $br type bridge
    ip l set $vfb0 master $br up
    ip l set $vfb1 master $br up
    ip l set $br up

Where $pfa is the E810 and $pfb is its link partner.  Send the packets
between $vfa0 and $vfa1.  We expect to see ICMP packets at the $br.
Instead, ARP is unable to resolve the 10.0.0.1 because the reply is
stuck in the internal switch.

Changes in v2:
  - Use FIELD_GET et al. when handling fi.lb_en and fi.lan_en.
  - Rename /LB_LAN/ s/_MASK/_M/ because one of uses would need to break
    line.
  - Close open parenthesis in ice_vsi_update_bridge_mode() description.
  - Explain returns in ice_vsi_update_bridge_mode().

v1: https://lore.kernel.org/intel-wired-lan/20251120162813.37942-1-jakub.slepecki@intel.com/T/

Jakub Slepecki (7):
  ice: in dvm, use outer VLAN in MAC,VLAN lookup
  ice: allow creating mac,vlan filters along mac filters
  ice: do not check for zero mac when creating mac filters
  ice: allow overriding lan_en, lb_en in switch
  ice: update mac,vlan rules when toggling between VEB and VEPA
  ice: add functions to query for vsi's pvids
  ice: in VEB, prevent "cross-vlan" traffic from hitting loopback

Michal Swiatkowski (1):
  ice: add mac vlan to filter API

 drivers/net/ethernet/intel/ice/ice_fltr.c     | 104 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fltr.h     |  10 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  56 ++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  56 +++++++---
 drivers/net/ethernet/intel/ice/ice_switch.c   |  79 +++++++++----
 drivers/net/ethernet/intel/ice/ice_switch.h   |  13 ++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   8 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |  12 ++
 9 files changed, 295 insertions(+), 45 deletions(-)

-- 
2.43.0


