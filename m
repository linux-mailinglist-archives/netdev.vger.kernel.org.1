Return-Path: <netdev+bounces-78113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA718741D4
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC34E284A88
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0218EAF;
	Wed,  6 Mar 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgsTC8mQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30119BA2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759946; cv=none; b=So47TtUoveSeWRiyoLOgzKOZcuhdU30+Xr1UO4Qz5Gc/wnDpP+Y22unPDvw34bidyWhADnNQ6Ky3lwg3nqOR6oLWGqP8C2KDDwk15PvQ/6jpvdC2og2c9VYOz+PjnSBrvhxB66l0ievuQS58HDTPB6YUIHB1AsIULAEOEv58rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759946; c=relaxed/simple;
	bh=Q61lhuSLt8VK7LfFcw4xP3mubNSGMBQ+uF1gy6tw4Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIiWQESJsU2eNQdP2FZWQC3GcnUcpiuHCs/CclkMMGlbIkV2rCweXfN/ev6M80322XtMAJLaLzGZgwpDjRWrIr86EcHfLCHzOfe3e5LBl/TlAmxYDekgjtQnCDucu7bc6RCbuKqjtNk6oaHYhzstooHeo87462EW51ZFAg2gYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgsTC8mQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709759945; x=1741295945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q61lhuSLt8VK7LfFcw4xP3mubNSGMBQ+uF1gy6tw4Iw=;
  b=IgsTC8mQehsZStK2bq7SmSj/ODC6llztvn6CeG6zGaFLLmYEG19Wx4Hd
   h9Kc8s8PXzGaCfm+fne0dNexaWnDeI1ruaIyjGBeaiHl+hFBnU52hYZtn
   ua1tXQQATq/zfZFFw2oDQIJAdM01/kbD03OaWVp0SC5jpcHXbwPWJ/RIW
   sUOeSWwmssVfC1ciKyzBzAiuX5b3UjmgPWPPLxIghcL9ja2KGaCZCGKgJ
   aaBIfZYSfagdQtLRrRacc/Dm4iovHhEG7VWsy9oM+PpwWBl/Hbzzf7c31
   Gq9mO8JWuO3C14uBcP3xeZdt4MuIEZexsL3plsaNgjw6+EWLeya2+1RL2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15539727"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="15539727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 13:19:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="10039704"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2024 13:19:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	hayatake396@gmail.com,
	mkubecek@suse.cz,
	vladimir.oltean@nxp.com,
	laforge@gnumonks.org,
	mailhol.vincent@wanadoo.fr
Subject: [PATCH net-next 0/2][pull request] ethtool: ice: Support for RSS settings to GTP
Date: Wed,  6 Mar 2024 13:18:51 -0800
Message-ID: <20240306211855.970052-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Takeru Hayasaka enables RSS functionality for GTP packets on ice driver
with ethtool.

A user can include TEID and make RSS work for GTP-U over IPv4 by doing the
following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`

In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
gtpu(4|6)u, and gtpu(4|6)d.

gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format does
not include a TEID.
gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format that
includes a TEID.
gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U extended
header includes Uplink, applicable to both IPv4 and IPv6.
gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downlink,
for both IPv4 and IPv6.

The following are changes since commit eeb78df4063c0b162324a9408ef573b24791871f:
  inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Takeru Hayasaka (2):
  ethtool: Add GTP RSS hash options to ethtool.h
  ice: Implement RSS settings for GTP using ethtool

 .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
 drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
 include/uapi/linux/ethtool.h                  | 48 +++++++++++
 5 files changed, 210 insertions(+), 9 deletions(-)

-- 
2.41.0


