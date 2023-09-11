Return-Path: <netdev+bounces-32929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284CA79AB32
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581A41C20866
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70416410;
	Mon, 11 Sep 2023 20:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405161640C
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:27:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36651185
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694464051; x=1726000051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/9qXLLe0yfN+vUOtR4PXxSutFeWGBEj/ANhk/n0pzUQ=;
  b=kYCcla9OeBGuGo1fHT0EsfXUPVq2V24brcq/msiiccuYv4w6uo7x5kQt
   034vJoQrIvGrIpf98CcTuuRl8SyrbIZH9dj3xtqOCoe2Ovu9/7uZkZTRN
   WLXYTgIEMhns9giNhUhdlVTtsxUIpjzwmQpGiwFtBk3YcdtKSTgVK5Php
   CHJ29Sb2mLh44Wt/pZ2riLng12woQRt8KqZbxcuK5jF2gb46fysgcpOJH
   at1jbTeLHDCvrdBi62WKTcqiJRZ1Lu+VPlEnJOMzd09ZIqYHksDq0UQYf
   2xh8Om08SuwKFmxgDxUEVjgun/xJP+KZTFTDBOh5UjrgUrMMMk5XStT7x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409156692"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409156692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746581351"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="746581351"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2023 13:27:30 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net v2 0/2][pull request] Intel Wired LAN Driver Updates 2023-09-11 (i40e, iavf)
Date: Mon, 11 Sep 2023 13:27:13 -0700
Message-Id: <20230911202715.147400-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to i40e and iavf drivers.

Andrii ensures all VSIs are cleaned up for remove in i40e.

Brett reworks logic for setting promiscuous mode that can, currently, cause
incorrect states on iavf.
---
v2:
 - Remove redundant i40e_vsi_free_q_vectors() and kfree() calls (patch 1)

v1: https://lore.kernel.org/netdev/20230905180521.887861-1-anthony.l.nguyen@intel.com/

The following are changes since commit 5a124b1fd3e6cb15a943f0cdfe96aa8f6d3d2f39:
  net: ethernet: mtk_eth_soc: fix pse_port configuration for MT7988
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Andrii Staikov (1):
  i40e: fix potential memory leaks in i40e_remove()

Brett Creeley (1):
  iavf: Fix promiscuous mode configuration flow messages

 drivers/net/ethernet/intel/i40e/i40e_main.c   | 10 ++-
 drivers/net/ethernet/intel/iavf/iavf.h        | 16 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 43 +++++------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 75 ++++++++++++-------
 4 files changed, 81 insertions(+), 63 deletions(-)

-- 
2.38.1


