Return-Path: <netdev+bounces-256748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GoKHVxqg2l+mgMAu9opvQ
	(envelope-from <netdev+bounces-256748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:48:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17BE9669
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28AF33052AFE
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B641C30A;
	Wed,  4 Feb 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4tAevyV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CD410D35;
	Wed,  4 Feb 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219863; cv=none; b=kgqTDhGUiDrmZoQPG2Jp4lnoqhdtWw2teslnjsZ7JQQY/uts4I7bDemKxwhvz7g0OuOEcyUY2fAIampUt1HfeRs/3mO503Wr55kCLYpIcV9R2r03VG5LsLOsI4JB7NWXPY8vatsBrVZ/XWCi8ZytPCRcuDNMVWmI7IFpdqSq0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219863; c=relaxed/simple;
	bh=Gvwar865M8JYk60u78S+84i/r5rhjn3Vi0FJPnewpIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=atBfqm8jeJJRwJ5QnQwhXii5mf9YVS3XhnTlWP3ukxECPUzJGU1yOr3JXbTxMM5QWUzeQ72JfX/o52BToZaCUdGGCwm22Rra9l7Z+50e28MvwyYPV0B9tIO6j3SORzy89bMo1huj+CXKpRcFk9iFHeedYSDtCWByvKyHkm8w2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4tAevyV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219862; x=1801755862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gvwar865M8JYk60u78S+84i/r5rhjn3Vi0FJPnewpIk=;
  b=j4tAevyV/2aWaDJuavWsu1MtN/pneWvCIogZNjbL5QxBYkw2nMojZ/Da
   dmeOVBnGBcbqhpLbctpFp5b0+tSLai1OMousVKryorDKmskkNrfy+i35f
   Cy1kScEndawCH/liKa6PvbWvHrpOFc1BS+a0MFytRg1EFlIFbCOyltnTL
   8annMnT4glU5na45jPRy+AyqG3Gp7h69Dqt5nfU89JCd1YifOwnGyL2sM
   wfd9ZhMc7BSH6IlW5+apAKG/l3n04FQfeZe9LbUJU9HJELT8XfQtTr/0W
   fAJoRFYN3dEJW4472u0KEna9AoYe1FeN9huQtmEFdooe+tPeQ+dCju4RS
   w==;
X-CSE-ConnectionGUID: 6pITT/pkQnelZuY1n1iz2g==
X-CSE-MsgGUID: s32adMegTiOAul6dQYATDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88987084"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88987084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:44:22 -0800
X-CSE-ConnectionGUID: M8LwvVyoQGq/Fp5bZVQpAg==
X-CSE-MsgGUID: BjTEwex8RuSWz07n+7Zpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209494102"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2026 07:44:19 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 0/7] ice: in VEB, prevent "cross-vlan" traffic
Date: Wed,  4 Feb 2026 16:44:11 +0100
Message-ID: <20260204154418.1285309-1-jakub.slepecki@intel.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-256748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub.slepecki@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: DF17BE9669
X-Rspamd-Action: no action

Currently, packets that match MAC address of a VF will be sent to loopback
even if they would cross VLAN boundaries.  Effectively, this drops them.
In this patch series, we aim to address this behaviour by adding MAC,VLAN
to complement what MAC-only filters do to select packets for loopback.

To reproduce the issue have an E810 ($pfa) connected to another adapter
($pfb), then:

    # echo 2 >/sys/class/net/$pfa/device/sriov_numvfs
    # ip l set $pfa vf 0 vlan 4
    # ip l set $pfa vf 1 vlan 7
    # ip l set $pfa_vf0 netns $pfa_vf0_netns up
    # ip l set $pfa_vf1 netns $pfa_vf1_netns up
    # ip netns exec $pfa_vf0_netns ip a add 10.0.0.1/24 dev $pfa_vf0
    # ip netns exec $pfa_vf1_netns ip a add 10.0.0.2/24 dev $pfa_vf1

And for the $pfb:

    # echo 2 >/sys/class/net/$pfb/device/sriov_numvfs
    # ip l set $pfb vf 0 trust on spoof off vlan 4
    # ip l set $pfb vf 1 trust on spoof off vlan 7
    # ip l add $br type bridge
    # ip l set $pfb_vf0 master $br up
    # ip l set $pfb_vf1 master $br up
    # ip l set $br up

We expect $pfa_vf0 to be able to reach $pfa_vf1 through the $br on
the link partner.  Instead, ARP is unable to resolve 10.0.0.2/24.
ARP request is fine because it's broadcastd and bounces off $br, but
ARP reply is stuck in the internal switch because the destination MAC
matches $pfa_vf0 and filter restricts it to the loopback.

In testing I used: ip utility, iproute2-6.1.0, libbpf 1.3.0

Changes in v4:
  - Removed "ice: do not check for zero mac when creating mac filters"
    patch.

Changes in v3:
  - Improve structure of reproduction description in cover letter.
  - LB_LAN masks and values no longer rely on boolean promotion.
  - ice_fill_sw_info() deals with u8 the entire time instead of building
    building lb_en and lan_en values at the end from booleans.
  - Refer to reproduction in cover letter in current 4/7.
  - Fixed some slip-ups "this patch" and "this commit" in commit
    messages across the series.  I did not consider this change for
    reviewed-by drop.

Changes in v2:
  - Use FIELD_GET et al. when handling fi.lb_en and fi.lan_en.
  - Rename /LB_LAN/ s/_MASK/_M/ because one of uses would need to break
    line.
  - Close open parenthesis in ice_vsi_update_bridge_mode() description.
  - Explain returns in ice_vsi_update_bridge_mode().

v3: https://lore.kernel.org/intel-wired-lan/20260120103440.892326-1-jakub.slepecki@intel.com/T/
v2: https://lore.kernel.org/intel-wired-lan/20251125083456.28822-1-jakub.slepecki@intel.com/T/
v1: https://lore.kernel.org/intel-wired-lan/20251120162813.37942-1-jakub.slepecki@intel.com/T/

Jakub Slepecki (6):
  ice: in dvm, use outer VLAN in MAC,VLAN lookup
  ice: allow creating mac,vlan filters along mac filters
  ice: allow overriding lan_en, lb_en in switch
  ice: update mac,vlan rules when toggling between VEB and VEPA
  ice: add functions to query for vsi's pvids
  ice: in VEB, prevent "cross-vlan" traffic from hitting loopback

Michal Swiatkowski (1):
  ice: add mac vlan to filter API

 drivers/net/ethernet/intel/ice/ice_fltr.c      |  104 ++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fltr.h      |   10 +
 drivers/net/ethernet/intel/ice/ice_lib.c       |   56 ++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h       |    2 
 drivers/net/ethernet/intel/ice/ice_main.c      |   56 ++++++--
 drivers/net/ethernet/intel/ice/ice_switch.c    |   83 ++++++++---
 drivers/net/ethernet/intel/ice/ice_switch.h    |   24 ++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c    |    8 -
 drivers/net/ethernet/intel/ice/ice_vlan_mode.c |   12 +
 9 files changed, 306 insertions(+), 49 deletions(-)

-- 
2.43.0


