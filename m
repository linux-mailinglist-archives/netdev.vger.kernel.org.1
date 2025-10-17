Return-Path: <netdev+bounces-230311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC5BE68D6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 359694FD5EE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121630FF2B;
	Fri, 17 Oct 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgvUKsPF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226430FC3D;
	Fri, 17 Oct 2025 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681453; cv=none; b=T5460xRd4oNjzkyoAqpkH6LwRNiwZQ1rK8lElfZ2D8fb5UWc7BGDDa6X9WFoYwDYVe3ZuFrE3KLf6exaN+1pv5d/Deg/z0G3KbDPK+uPqgyWVHqZAHxzQ6s+NaUx6DieGNYDBWSHOdCz3k8S0dzXIMuNzuOFJHPO2yUKPiTm2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681453; c=relaxed/simple;
	bh=XHH3YtsgJTonABcDP1cjjeeuWzSJz8QnHP+0ONp0oR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PhYzASfZfxGPe1UH6ibNbdYAhayKEs1NxDT+UgZ6ApXfuqJeirlOGM1innLAGCUaAQDlKRp/Q2gQxOSzeyZeUa3tlOwAXZPnNj7kQmiowL8a30YVMOl76UHZKNkVOZW1osCUY3BiuOK5Nu9GURR4KvXMdHLiM8Z2rcEFAJ0HcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgvUKsPF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681452; x=1792217452;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=XHH3YtsgJTonABcDP1cjjeeuWzSJz8QnHP+0ONp0oR0=;
  b=GgvUKsPF3OH0VShbI7TFn8JePCS5jkRQ04DH+BcBlYIllCFMc4ZKFBR6
   /T7SP8F5klfrYSXLmAwxhUw59lPW9wXnmr9eM3z6uhRdf/S5naEeJ+YVg
   yTSornSPbsUZEOOZbuCq+b3EWH3e6NN1K+A8E6KkcWNmXKhjJ44swPa12
   wEFnEhFEE2HexcEj6zN2ECa529DDlZMyRxbOVyrE6WhGytt1CbFFpUWIH
   eEQ4EC24gVyv+BK68iLJH34Nx7MBzXA5CvSryt1sKE076GNjwclVxgK72
   OPGc0OqNZMPszAsAR1Lj6dTiN3iX5hhVUKcz6j/qMwEznw/o99j0XBGjU
   Q==;
X-CSE-ConnectionGUID: 0RP2h5PhS9O0XcClVeiriw==
X-CSE-MsgGUID: rlVCi3zdQwuFfzA6kO+8bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50453907"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50453907"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:51 -0700
X-CSE-ConnectionGUID: LhbTq0mKQja6eSo6yrDPjw==
X-CSE-MsgGUID: N6FlrEnoRc+UZ37A+WrQkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183059468"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 00/14] Intel Wired LAN Driver Updates
 2025-10-15 (ice, iavf, ixgbe, i40e, e1000e)
Date: Thu, 16 Oct 2025 23:08:29 -0700
Message-Id: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGDd8WgC/4WNQQ6CMBBFr0Jm7ZgOQiquuIdhAWWQUSymbRBDu
 Lu1F3D5/s9/fwPPTtjDJdvA8SJeZhshP2RgxtbeGKWPDLnKS1JU4v2B8p7Q8hrwFyIpjHFFRXF
 SWhdDSRDHL8eDrEl8BcshDaCJzSg+zO6THhdK/T/5QqhQV0arrur7tjvXYgNPRzM/odn3/Qt/F
 4y1xgAAAA==
X-Change-ID: 20251015-jk-iwl-next-2025-10-15-914430774f51
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Mohammad Heib <mheib@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>, 
 Dan Nowlin <dan.nowlin@intel.com>, Junfeng Guo <junfeng.guo@intel.com>, 
 Ting Xu <ting.xu@intel.com>, Jie Wang <jie1x.wang@intel.com>, 
 Qi Zhang <qi.z.zhang@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rinitha S <sx.rinitha@intel.com>, Hariprasad Kelam <hkelam@marvell.com>, 
 Kohei Enju <enjuk@amazon.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 =?utf-8?q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>, 
 Avraham Koren <Avrahamx.koren@intel.com>, jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=4886;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=XHH3YtsgJTonABcDP1cjjeeuWzSJz8QnHP+0ONp0oR0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyPdx8tTeY5PclbOprLWM1pubHf56VK2w579Yasc82ae
 F5+mvqzjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZi+4mRYdOj1ONlPP3dKdcP
 dzZGb9KQVDJTMvReEZp97UNz3DSuVEaGCXOsjv1OP2C/3/zvmoZZ2ldrPgVkthp8yFkXbfPlykk
 VBgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

Mohammad Heib introduces a new devlink parameter, max_mac_per_vf, for
controlling the maximum number of MAC address filters allowed by a VF. This
allows administrators to control the VF behavior in a more nuanced manner.

Aleksandr and Przemek add support for Receive Side Scaling of GTP to iAVF
for VFs running on E800 series ice hardware. This improves performance and
scalability for virtualized network functions in 5G and LTE deployments.

Jacob revives one-year-old work from Jesse Brandeburg to implement the
standardized statistics interfaces from ethtool in the ice driver.

Kohei improves the behavior of the RSS indirection table for ixgbe,
ensuring it is preserved across device reset and when the device is
administratively closed and re-open.

Vitaly introduces a new private flag to control the K1 power state of ICH
network controllers supported by the e1000e driver. This flag has been
extensively discussed on the list and deemed the best available option to
provide a field workaround without impacting the many configurations that
have no issues with the K1 power state.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Fixed the accidental diffstat and '--' separator in patch 6
- Add missing Return annotation ice_hash_remove
- Add missing Return annotation for ice_map_ip_ctx_idx
- Improve Return annotation for ice_hash_moveout
- Add missing Return annotation for ice_ptg_attr_in_use
- Verified with ingest_mdir.py tests :D
- Link to v1: https://lore.kernel.org/r/20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com

---
Aleksandr Loktionov (4):
      ice: add flow parsing for GTP and new protocol field support
      ice: add virtchnl and VF context support for GTP RSS
      ice: improve TCAM priority handling for RSS profiles
      iavf: add RSS support for GTP protocol via ethtool

Jesse Brandeburg (5):
      net: docs: add missing features that can have stats
      ice: implement ethtool standard stats
      ice: add tracking of good transmit timestamps
      ice: implement transmit hardware timestamp statistics
      ice: refactor to use helpers

Kohei Enju (1):
      ixgbe: preserve RSS indirection table across admin down/up

Mohammad Heib (2):
      devlink: Add new "max_mac_per_vf" generic device param
      i40e: support generic devlink param "max_mac_per_vf"

Przemek Kitszel (1):
      ice: Extend PTYPE bitmap coverage for GTP encapsulated flows

Vitaly Lifshits (1):
      e1000e: Introduce private flag to disable K1

 drivers/net/ethernet/intel/e1000e/e1000.h          |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h             |    4 +
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.h     |   31 +
 drivers/net/ethernet/intel/ice/ice_flex_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.h          |   94 +-
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |   20 +
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    2 +
 drivers/net/ethernet/intel/ice/ice_type.h          |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   48 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |    2 +
 include/linux/avf/virtchnl.h                       |   50 +
 include/net/devlink.h                              |    4 +
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   45 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   41 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    3 +
 drivers/net/ethernet/intel/i40e/i40e_devlink.c     |   48 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   31 +-
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.c     |  119 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   89 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  144 ++-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |  101 +-
 drivers/net/ethernet/intel/ice/ice_flow.c          |  270 +++-
 drivers/net/ethernet/intel/ice/ice_lag.c           |    3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   13 +-
 drivers/net/ethernet/intel/ice/ice_parser.c        |    3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   15 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    3 +-
 drivers/net/ethernet/intel/ice/virt/rss.c          | 1314 +++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   45 +-
 net/devlink/param.c                                |    5 +
 .../networking/devlink/devlink-params.rst          |    4 +
 Documentation/networking/devlink/i40e.rst          |   32 +
 Documentation/networking/statistics.rst            |    4 +-
 33 files changed, 2361 insertions(+), 229 deletions(-)
---
base-commit: 2df75cc5bdc48f8a6f393eaa9d18480aeddac7f2
change-id: 20251015-jk-iwl-next-2025-10-15-914430774f51

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


