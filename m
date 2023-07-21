Return-Path: <netdev+bounces-19917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15A75CD1E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC0B1C216C3
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDDF1F93B;
	Fri, 21 Jul 2023 16:06:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433041ED4B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:06:39 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C022D47
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689955596; x=1721491596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lOeOl84AWVoX4kLwRKamcHLKM/R5Flhh/fCd7KTD2C4=;
  b=Tg3WFJbkl0wdVlo2tN9bm0LgiIY3m4E5Pz947k+7RmhMK8jHKlssKtnK
   35mHjmukR4d04a1XjfKvui6EKEjq8tvY4uwTwHcGHkl6q3XD/ebmzb7/j
   Ks+P/GFqlcXsDodPp/uYl2vYxLRzGMxZxE2OUD5lxnuOMCUuyNtAv5J1R
   esO5+P747P8/dVtpHciCEmM0bbnNo+WP9M3b8d2zU74ifEo7TtkdRQHFc
   JsW5zjk5tk3WtqIrC8wE7QdwjJ3Ujobb9slv067hNdR1KtSivdygvgTL0
   ruOXBNhkVv2ZxN3QLBJgQcnX3aNqq5+R8knQJoa6zt89zTJeAAnZ0/2VN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357047083"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357047083"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868279393"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 09:04:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2023-07-21 (i40e, iavf)
Date: Fri, 21 Jul 2023 08:58:09 -0700
Message-Id: <20230721155812.1292752-1-anthony.l.nguyen@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to i40e and iavf drivers.

Wang Ming corrects an error check on i40e.

Jake unlocks crit_lock on allocation failure to prevent deadlock and
stops re-enabling of interrupts when it's not intended for iavf.

The following are changes since commit 57f1f9dd3abea322173ea75a15887ccf14bbbe51:
  Merge tag 'net-6.5-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Jacob Keller (2):
  iavf: fix potential deadlock on allocation failure
  iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Wang Ming (1):
  i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

 drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.38.1


