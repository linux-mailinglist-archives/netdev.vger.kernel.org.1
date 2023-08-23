Return-Path: <netdev+bounces-30067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2EC785DD8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A29D281365
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A51E527;
	Wed, 23 Aug 2023 16:48:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039EC8E0
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:48:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E2711F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692809324; x=1724345324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4MVYphu33PfsIG74pDv6rnAjxNwK5BmRgidfHBMPxaE=;
  b=AAl7fUJq2BDPkf/8pTW90/zXfgUm6yJMujV8b+Dq9Krtt4WT8PhQrtj1
   LnG3G5POCNHwNFKN1ZauKcir9CxVcIwiQDGw/Q96Qd4WnSV9PqsXqnrkF
   xP1DZvZ3/Lxcb3h0Cw0c75YpWQkYUmGqswMBZiFyOBnjtTOtasH24URpm
   OtnL/SSdaJsn9/rC7rSOMVUyiIzwfjjBm4RJXNKiiFyMyJoqEAosu/esu
   3EqIADtb2sRe+uQPGvrgHMRGnzFa7r9lr/j4C1+0Ppj+VdRAadRPD4U0k
   GxkekpLqR6uB2blMP9irYRaIrsWseMHTsnSIVrezVCLDBRV1nzg5TFIfe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438141112"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438141112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802200507"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802200507"
Received: from spiccard-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.44.134])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:48:42 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [RFC PATCH net-next 0/3] Support Symmetric Toeplitz RSS hash
Date: Wed, 23 Aug 2023 10:48:28 -0600
Message-Id: <20230823164831.3284341-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are looking for comments from the community on how to best add support
for the "Symmetric Toeplitz" hash RSS algorithm available on Intel's E800 
NICs. 

The first patch adds the support via "ethtool -X hfunc <alg>". Patches 2
and 3 add support in the ice driver. Support for the iavf driver will be
added later.

Ahmed Zaki (3):
  net: ethtool: add symmetric Toeplitz RSS hash function
  ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
  ice: add support for symmetric Toeplitz RSS hash function

 drivers/net/ethernet/intel/ice/ice.h          |  2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  8 +--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 11 +++-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 12 ++---
 drivers/net/ethernet/intel/ice/ice_main.c     | 52 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  8 ++-
 include/linux/ethtool.h                       |  4 +-
 net/ethtool/common.c                          |  1 +
 8 files changed, 80 insertions(+), 18 deletions(-)

-- 
2.39.2


