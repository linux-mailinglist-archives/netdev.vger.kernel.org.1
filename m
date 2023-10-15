Return-Path: <netdev+bounces-41107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA427C9C9E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 01:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE00E28166D
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59914F9E;
	Sun, 15 Oct 2023 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1ubDWIZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7E14AB8
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:51:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B81AD
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697413864; x=1728949864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8nl5ahvXJDF1WoW7ftzJdmLFO0AXB8NwzYNKaesAV64=;
  b=m1ubDWIZf+e6NCCIAkTiV/oV0KwwwUdKk//I/6zoka6REsoEO61DcWkS
   gm7YZsSPrUfyeDS7C+JLeNI8YR6KUv9/szklqT9M0dSngj4mpe8NcbZog
   f+8jCMGT3gw++xiMrl3JmEEc8/emT1E9s0pRDbyCaYJE2o5TQBq/kosNs
   Jz/QjUg1QayyNmEzp5btj0eBfJPkPenWEvJjOYPw8o8OpRoUr0uCTH9M+
   T85Ssmnw4oBKYx1TKL+R/tDFXGBiuCFWXq08LAkKIh23BDHVwMJV08bpy
   Xnqm9RM1brFWtlpXKX1r+1Jo5ht8RABZldAAEX73w9mBkV3IognLTj6VW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="370496071"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="370496071"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 16:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929159757"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="929159757"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.144])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2023 16:51:02 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	vladimir.oltean@nxp.com,
	jdamato@fastly.com,
	pawel.chmielewski@intel.com,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	kuba@kernel.org,
	d-tatianin@yandex-team.ru,
	pabeni@redhat.com,
	davem@davemloft.net,
	jiri@resnulli.us,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH net-next v5 0/3] ethtool: Add link mode maps for forced speeds
Date: Sun, 15 Oct 2023 19:43:01 -0400
Message-ID: <20231015234304.2633-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
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

The following patch set was initially a part of [1]. As the purpose of the
original series was to add the support of the new hardware to the intel ice
driver, the refactoring of advertised link modes mapping was extracted to a
new set.

The patch set adds a common mechanism for mapping Ethtool forced speeds
with Ethtool supported link modes, which can be used in drivers code.

[1] https://lore.kernel.org/netdev/20230823180633.2450617-1-pawel.chmielewski@intel.com

Changelog:
v4->v5:
Separated ethtool and qede changes into two patches, fixed indentation,
and moved ethtool_forced_speed_maps_init() from ioctl.c to ethtool.h

v3->v4:
Moved the macro for setting fields into the common header file

v2->v3:
Fixed whitespaces, added missing line at end of file

v1->v2:
Fixed formatting, typo, moved declaration of iterator to loop line.

Paul Greenwalt (2):
  ethtool: Add forced speed to supported link modes maps
  qede: Refactor qede_forced_speed_maps_init()

Pawel Chmielewski (1):
  ice: Refactor finding advertised link speed

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 193 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  46 ++---
 include/linux/ethtool.h                       |  37 ++++
 include/linux/linkmode.h                      |  29 +--
 6 files changed, 195 insertions(+), 113 deletions(-)


base-commit: ac4dec3fd63c7da703c244698fc92efb411ff0d4
-- 
2.40.0


