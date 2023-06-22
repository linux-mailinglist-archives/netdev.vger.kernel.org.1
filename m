Return-Path: <netdev+bounces-13138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1BD73A6E8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AA8281A3C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DD3200B2;
	Thu, 22 Jun 2023 17:05:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59944200AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:05:47 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1221739
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453545; x=1718989545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K5GTZ2qggLsNjeAq5tosR3cixNxwpagg4NqSjDt7Vu0=;
  b=Iu5/XilICp598OQmrvt868SKfCR392qCDadlM4/BAVLEBewjYjRnmC0m
   GVjnscqPvLstifTRWKiIN5513L2vbbVw5pJFvDPp0wTiSv0wQL8dwt/5O
   VjlbljVp6AGnbxfiYJIenSEKIMW/pyv/hDtFCbRdC4m0ovKZJNYr4X+8O
   Y3Z/VhbIswcq+Fj/U3pBOxEjFqyGGvep75Ri9YfM6JQNyJvWxBMSe/VLk
   FMy91NF0hgUhrNOBR/Gl2bN4L8bgP7EAqm1lsq46d7hjNtSjuWxtar/kP
   fKREBUXTwkEyjvTiJaPqQYOTED1pMF3sh3FuXR0m7I5c2R2SjqO4YQGSh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390353095"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="390353095"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 10:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="714970994"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="714970994"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 10:04:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates 2023-06-22 (iavf)
Date: Thu, 22 Jun 2023 09:59:11 -0700
Message-Id: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to iavf driver only.

Przemek defers removing, previous, primary MAC address until after
getting result of adding its replacement. He also does some cleanup by
removing unused functions and making applicable functions static.

The following are changes since commit 98e95872f2b818c74872d073eaa4c937579d41fc:
  Merge branch 'mptcp-expose-more-info-and-small-improvements'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Przemek Kitszel (3):
  iavf: fix err handling for MAC replace
  iavf: remove some unused functions and pointless wrappers
  iavf: make functions static where possible

 drivers/net/ethernet/intel/iavf/iavf.h        | 10 ---
 drivers/net/ethernet/intel/iavf/iavf_alloc.h  |  3 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c | 45 -----------
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 78 ++++++++-----------
 drivers/net/ethernet/intel/iavf/iavf_osdep.h  |  9 ---
 .../net/ethernet/intel/iavf/iavf_prototype.h  |  5 --
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 43 +++++-----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  4 -
 8 files changed, 55 insertions(+), 142 deletions(-)

-- 
2.38.1


