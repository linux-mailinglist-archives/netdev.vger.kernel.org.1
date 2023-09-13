Return-Path: <netdev+bounces-33652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D121779F0D3
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F80A281791
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16628200BD;
	Wed, 13 Sep 2023 18:04:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5611798E
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:04:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FED19AE
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628264; x=1726164264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=90IEas/fTmrxOygnHRl9bcXpKaiTuS8YkuD6uKPvGbo=;
  b=l7rBh9QByO0UKxsNvA42zcyR8cK/EGM7jHCYEXvJzWc9COeor8fFItJL
   LUgjeHSFTE521c3z2jgt7/HNkaB79IXElqVUyaazMmYtM+xDwPSlPeOHp
   uD8/mZRlS2HzOScY4x3ICrR4WqSlx9RCOpJwLkplNroUpT/Wjt/RmF/Vh
   HSN5Nl1npfZIzRsmvQMH6k0WQDIUS2CbnT8SycTgOU+rGbRsGXZAD3DYv
   MPu03qyt+tZQJ2bq7mLH0fItQOQK1XKYC7J2lZXcHHNenKO4h22OJyQCy
   LNTwGcSYkrdiENmyL1Z6EYTBxklLqbSJ5/nNCz4oi1UG7s19dI2cyeVOs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378658436"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378658436"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747417157"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="747417157"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 11:03:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ahmed.zaki@intel.com
Subject: [PATCH net-next 0/4][pull request] Support rx-fcs on/off for VFs
Date: Wed, 13 Sep 2023 11:03:30 -0700
Message-Id: <20230913180334.2116162-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ahmed Zaki says:

Allow the user to turn on/off the CRC/FCS stripping through ethtool. We
first add the CRC offload capability in the virtchannel, then the feature
is enabled in ice and iavf drivers.

We make sure that the netdev features are fixed such that CRC stripping
cannot be disabled if VLAN rx offload (VLAN strip) is enabled. Also, VLAN
stripping cannot be enabled unless CRC stripping is ON.

Testing was done using tcpdump to make sure that the CRC is included in
the frame after:

    # ethtool -K <interface> rx-fcs on

and is not included when it is back "off". Also, ethtool should return an
error for the above command if "rx-vlan-offload" is already on and at least
one VLAN interface/filter exists on the VF.

The following are changes since commit ca5ab9638e925613f73b575041801a7b2fd26bd4:
  Merge branch 'selftests-classid'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Haiyue Wang (2):
  ice: Support FCS/CRC strip disable for VF
  ice: Check CRC strip requirement for VLAN strip

Norbert Zulinski (1):
  iavf: Add ability to turn off CRC stripping for VF

Paul M Stillwell Jr (1):
  virtchnl: Add CRC stripping capability

 drivers/net/ethernet/intel/iavf/iavf.h        |  2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 59 +++++++++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  4 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 69 +++++++++++++++++--
 include/linux/avf/virtchnl.h                  | 11 ++-
 6 files changed, 141 insertions(+), 7 deletions(-)

-- 
2.38.1


