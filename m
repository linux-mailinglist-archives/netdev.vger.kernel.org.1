Return-Path: <netdev+bounces-25125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E47730B4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6761C20CEE
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD916404;
	Mon,  7 Aug 2023 20:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6B3D9C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:55:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96E10F8
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691441715; x=1722977715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2WyO3cf73Rdb/ZXHW16vbwxb+yETO8U052IGXPC3WHE=;
  b=QspIYLplOQzcpPWENbGpjOjEs/8fO0BBE79o4zeBaWmcWpFDSodmaCvy
   +M6+zH78q/g/v5bEa5fjuzfed4GtoBrks2y2KBQm3dDAY1y1OvcYOG/jJ
   4ae3hSmk0oI4bj/AA/yxNowV/20JqIzrWa53RvevXsO7ENw0/SElM7rx8
   JSP5AGBHSESlv6YqAy2QJ/FTNNfEB1SPqVZLNGd9peJjRvYmK/Bllkro4
   lZWpZZwXIDbaghyvqT7HtZkEGZhtDeWit6oq0z06j6cS2MMKCDaED+T+j
   CDUPlmHPqtE1atQqQ7l6km0kQwjNkfb48oVQOgFjlcNk1CNhWDJBX/XLW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350952441"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="350952441"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="734226829"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="734226829"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2023 13:55:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 0/6][pull request] Intel Wired LAN Driver Updates 2023-08-07 (ice)
Date: Mon,  7 Aug 2023 13:48:29 -0700
Message-Id: <20230807204835.3129164-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to ice driver only.

Wojciech allows for LAG interfaces to be used for bridge offloads.

Marcin tracks additional metadata for filtering rules to aid in proper
differentiation of similar rules. He also renames some flags that
do not entirely describe their representation.

Karol and Jan add additional waiting for firmware load on devices that
require it.

Przemek refactors RSS implementation to clarify/simplify configurations.
---
v2:
- Drop patch 'ice: Support untagged VLAN traffic in br offload'
- Make ice_aq_get_netlist_node() static
- Remove excess declaration of ice_is_pf_c827()

v1: https://lore.kernel.org/netdev/20230801173112.3625977-1-anthony.l.nguyen@intel.com/

The following are changes since commit cc97777c80fdfabe12997581131872a03fdcf683:
  udp/udplite: Remove unused function declarations udp{,lite}_get_port()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jan Sokolowski (1):
  ice: add FW load wait

Karol Kolacinski (1):
  ice: Add get C827 PHY index function

Marcin Szycik (2):
  ice: Add direction metadata
  ice: Rename enum ice_pkt_flags values

Przemek Kitszel (1):
  ice: clean up __ice_aq_get_set_rss_lut()

Wojciech Drewek (1):
  ice: Accept LAG netdevs in bridge offloads

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  54 +++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 205 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  47 +++-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  20 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  37 ++++
 .../ethernet/intel/ice/ice_protocol_type.h    |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |  11 +-
 drivers/net/ethernet/intel/ice/ice_switch.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  34 +--
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   6 +-
 14 files changed, 279 insertions(+), 161 deletions(-)

-- 
2.38.1


