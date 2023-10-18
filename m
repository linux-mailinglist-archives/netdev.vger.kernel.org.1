Return-Path: <netdev+bounces-42319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AF7CE3CC
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D127D1C20A16
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36143C089;
	Wed, 18 Oct 2023 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8uiqr87"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF43C086;
	Wed, 18 Oct 2023 17:07:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F5318A;
	Wed, 18 Oct 2023 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697648814; x=1729184814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/AH7FG5H24zeN3zHGTfVvmBBV3l6sDBNWvaVvqh4yB8=;
  b=J8uiqr87GaVcsF5u7wksAIpMqTmdygxTunuej1A7tl1Ea3Z6RyQU3DDi
   Lk6p5UUiBH/kTIJ6345wM6c2cXX5/LMKYpIbaL4L2OTvqe392karZcnXB
   VRwUOXWCyEEQnpo6LkC/0C18xhKOTW4JR0PuggT6wFUxHC2WBEqzrdZAy
   iYJBDJSF3cX29ADmwOrl6ePeM6aA9ZIAgGfoJHhHkec6V9iVZMoFbOwP8
   GhYVxWybZQYf28pIXOFCFTQ8zRheHUjzE1Gx8i1v8NOACW61Tvm57rdMi
   SebbOtN8TqBfcakXptQRB4YN0ykU2hcL7Wk0fB2OXTpocNZ28bXXJZjU5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="388924762"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="388924762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 10:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="822494033"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="822494033"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.38.47])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 10:06:43 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	horms@kernel.org,
	mkubecek@suse.cz,
	willemdebruijn.kernel@gmail.com,
	linux-doc@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v5 0/6] Support symmetric RSS (Toeplitz) hash
Date: Wed, 18 Oct 2023 11:06:29 -0600
Message-Id: <20231018170635.65409-1-ahmed.zaki@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch 1 adds the support at the Kernel level, allowing the user to set a
symmetric RSS hash for any flow type via:

    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor

Support for the new "symmetric-xor" flag will be later sent to the
"ethtool" user-space tool.

Patch 2 fixes a long standing bug with the register values. The bug has
been benign for now since only (asymmetric) Toeplitz hash (Zero) has been
used.

Patches 3 and 4 lay some groundwork refactoring. While the first is
mainly cosmetic, the second is needed since there is no more room in the
previous 64-bit RSS profile ID for the symmetric attribute introduced in 
the next patch.

Finally, patches 5 and 6 add the symmetric Toeplitz support for the ice 
(E800 PFs) and the iAVF drivers.

---
v5: move sanity checks from ethtool/ioctl.c to ice's and iavf's rxfnc
    drivers entries (patches 5 and 6).
v4: add a comment to "#define RXH_SYMMETRIC_XOR" (in uapi/linux/ethtool.h)
v3: rename "symmetric" to "symmetric-xor" and drop "Fixes" tag in patch 2.
v2: fixed a "Reviewed by" to "Reviewed-by", also need to cc maintainers.

Ahmed Zaki (4):
  net: ethtool: allow symmetric-xor RSS hash for any flow type
  ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
  ice: refactor the FD and RSS flow ID generation
  iavf: enable symmetric RSS Toeplitz hash

Jeff Guo (1):
  ice: enable symmetric RSS Toeplitz hash for any flow type

Qi Zhang (1):
  ice: refactor RSS configuration

 Documentation/networking/scaling.rst          |   6 +
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |   8 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  33 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  25 +-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  35 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  43 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |   4 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   7 +
 drivers/net/ethernet/intel/ice/ice_flow.c     | 439 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_flow.h     |  46 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 117 ++---
 drivers/net/ethernet/intel/ice/ice_main.c     |  49 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  55 ++-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  35 +-
 include/linux/avf/virtchnl.h                  |  16 +-
 include/uapi/linux/ethtool.h                  |  21 +-
 22 files changed, 652 insertions(+), 306 deletions(-)

-- 
2.34.1


