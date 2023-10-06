Return-Path: <netdev+bounces-38689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E267BC264
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD72281A95
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB41CA82;
	Fri,  6 Oct 2023 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ql5OQ9Py"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0E8F4A
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:47:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430FB9;
	Fri,  6 Oct 2023 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696632462; x=1728168462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bdO/eXGWqqUwhqjwYhaRyZqthYwKjApWktfkShRAH8I=;
  b=Ql5OQ9Py59eUqRMsb/N52QGKkYWn8YpVj5O+sVrW30PGmXsn4mZ4RSeD
   CGgHvcoXVRv4f+l0pnZvImB2kKTEuj96cUhNr+fg9cQ+D+BzjeVgNmpzK
   sjlyC3xO7nobLGvgKBGykzJICpaTshP3NWGyDDQNjHs5vSWWSymDtRHdW
   qjN+EZsXii0CrOKoqep5pcYZk/0sdxOyscDH7A6X4BUIcXMfFTs0m+G7B
   lf7UssgBSRM6d5RTE3K5ckl9cBjSgX7nx+bGFfobVCCS1/2cO5oOLTW+K
   cFfsaymQMPHvidMIIxPic0R8G6qsVMzUK3tqSyOsGsdtXZWm6yKOIdWaY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363201029"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="363201029"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 15:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="1083610273"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="1083610273"
Received: from dianaman-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.35.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 15:47:37 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
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
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v2 0/6] Support symmetric RSS (Toeplitz) hash
Date: Fri,  6 Oct 2023 16:47:20 -0600
Message-Id: <20231006224726.443836-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch 1 adds the support at the Kernel level, allowing the user to set a
symmetric RSS hash for any flow type via:

    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric

Support for the new "symmetric" flag will be later sent to the "ethtool" 
user-space tool.

Patch 2 fixes a long standing bug with the register values. The bug has
been benign for now since only symmetric Toeplitz hash (Zero) has been
used.

Patches 3 and 4 lay some groundwork refactoring. While the first is
mainly cosmetic, the second is needed since there is no more room in the
previous 64-bit RSS profile ID for the symmetric attribute introduced in 
the next patch.

Finally, patches 5 and 6 add the symmetric Toeplitz support for the ice 
(E800 PFs) and the iAVF drivers.

---
v2: fixed a "Reviewed by" to "Reviewed-by", also need to cc maintainers.

Ahmed Zaki (4):
  net: ethtool: allow symmetric RSS hash for any flow type
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
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  22 +-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  14 +-
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
 include/uapi/linux/ethtool.h                  |   1 +
 net/ethtool/ioctl.c                           |  11 +
 23 files changed, 629 insertions(+), 298 deletions(-)

-- 
2.34.1


