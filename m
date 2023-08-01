Return-Path: <netdev+bounces-23365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D506A76BB72
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9785D280C16
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFA23593;
	Tue,  1 Aug 2023 17:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8023582
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:37:44 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A5268C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911454; x=1722447454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2IBki901Gydl5G4aZOyqvJsOBeTyXIbutpMAbu6Si3I=;
  b=A/bivVve4yP94YmBkX8oVGOwwfzod3NGeMFQmPWbaJ2JHZxiPN/sWrcn
   laNwyPpCTTWnoUboEoAOl26wCSPjFSmURk52HQKdf1guXngkoF+tih3vb
   HQcxBY+Ynrr9O0kP7TmW3lCYZpMupQZe9BzEmcz8Y6KZ9o6w2fmcVriwG
   RhgEhZile5iiBbLakyJTv2K6q9meiXG6huFThKdDsKPERMD0Tae28rmrW
   FRC2r4QRoSVbd+LNwRDOeKSiyVu4Pv+SjV2qPOcjhv6ELdVw2FRWowtdh
   lmSOuBhndI84yxVWLY5PeqV1VnUAubjxEE0VNTbYjUKsOTLMwRxAqU/dC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455740651"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455740651"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798769689"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="798769689"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2023 10:37:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates 2023-08-01 (ice)
Date: Tue,  1 Aug 2023 10:31:05 -0700
Message-Id: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to ice driver only.

Wojciech allows for LAG interfaces to be used for bridge offloads and
adds support for untagged VLAN traffic to be used in them as well.

Marcin tracks additional metadata for filtering rules to aid in proper
differentiation of similar rules. He also renames some flags that
do not entirely describe their representation.

Karol and Jan add additional waiting for firmware load on devices that
require it.

Przemek refactors RSS implementation to clarify/simplify configurations.

The following are changes since commit 01e6f8ad8d26ced14b0cf288c42e55d03a7c5070:
  net: dsa: qca8k: use dsa_for_each macro instead of for loop
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

Wojciech Drewek (2):
  ice: Accept LAG netdevs in bridge offloads
  ice: Support untagged VLAN traffic in br offload

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  54 +++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 205 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_common.h   |   5 +
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  57 ++++-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |   9 -
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
 15 files changed, 290 insertions(+), 173 deletions(-)

-- 
2.38.1


