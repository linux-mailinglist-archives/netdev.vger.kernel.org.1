Return-Path: <netdev+bounces-13089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA873A229
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE94281996
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5B1ED5B;
	Thu, 22 Jun 2023 13:49:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33CC1D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:49:00 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07221988
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687441739; x=1718977739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5bqKBe2QicSBfNf44K15xcLQj/tbykVfFY2zzwg5tFo=;
  b=JxMc71DgTnL2X44TWz4HKbZydyyQFbfv/Dd/GXB8xupEbOepZIzu818b
   5mxizMGFHB3NQHL6kJbfzHnlmZmlQ0v+SecTqJpE+Sdt6fST0xd8iPsgd
   S+utCiX2/6F0LKZTXTRF9u0EMzukfonCm4t13fPILakFskaAXc0MPCg3X
   ZCedCmzqeTx6H/jlXC8+ioYcBdM9Tu4MHP1tIFkTnk707TtlahQOP99J6
   guqV2XaPnd1za+Mp5HV5zuil7eZJ+vIRpvrN6K8P0XBhkMaXpw7f/wWp9
   MaXPt+15zS8+plMC1Td7QaDbjUX6g3aTwxb0QdSl1LdcRFOB3eoJnIft5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390234089"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="390234089"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804791810"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="804791810"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2023 06:48:58 -0700
Received: from giewont.igk.intel.com (giewont.igk.intel.com [10.211.8.15])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C075734918;
	Thu, 22 Jun 2023 14:48:57 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 0/2] ice: Direction metadata in tc filter
Date: Thu, 22 Jun 2023 15:35:11 +0200
Message-Id: <20230622133513.28551-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add matching on direction metadata when adding a filter via tc. Also rename
related enum values for readability.

Marcin Szycik (2):
  ice: Add direction metadata
  ice: Rename enum ice_pkt_flags values

 .../ethernet/intel/ice/ice_protocol_type.h    |  9 ++---
 drivers/net/ethernet/intel/ice/ice_switch.c   | 11 ++++--
 drivers/net/ethernet/intel/ice/ice_switch.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 34 +++++++++----------
 4 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.31.1


