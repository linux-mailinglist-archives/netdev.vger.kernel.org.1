Return-Path: <netdev+bounces-26510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29D777FBC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF9A1C20B0A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F721D28;
	Thu, 10 Aug 2023 17:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9021D22
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:59:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF810D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691690384; x=1723226384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G5MhWToLN3QrVB8A4vpmywndJbGE0Wmdn1JKIb84lkQ=;
  b=at4HoFoWftnMHKceXFwd/EXEsAna+zcOAoiHuwnwKcp3ALDzlt+rjNlD
   cVf6bVAVdfv9diohDBszMHe0OGsmwiAmRR0AT+J20MzyRDIsadlTyoXZn
   LvKzfKQBHLmihuHqMQW/kVI+N2Ebc3wzBOzTVWe3zRkXl4W22YaJP4Mei
   BcoZUYRw5S8MOc7wo1ZtZq+u0xLLlg/euW49v3e9M60JTaRfVecQu3+Wy
   +UnfTARWKfLT5fHfXUHZ3Mdmx6zyNhRynERCXxTYRhMLNLzR9WfvM4Szf
   qpKYanQVnmZ0J+klDBMulS35cBby/TB4iazvxoSW3F0Z2Agk74AVBQIKI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437825460"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="437825460"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="725933337"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="725933337"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 10:59:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	gustavoars@kernel.org,
	horms@kernel.org
Subject: [PATCH net-next 0/4][pull request] i40e: Replace one-element arrays with flexible-array members
Date: Thu, 10 Aug 2023 10:52:58 -0700
Message-Id: <20230810175302.1964182-1-anthony.l.nguyen@intel.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Gustavo A. R. Silva says:

Replace one-element arrays with flexible-array members in multiple
structures.

This results in no differences in binary output.

The following are changes since commit 29afcd69672a4e3d8604d17206d42004540d6d5c:
  Merge branch 'improve-the-taprio-qdisc-s-relationship-with-its-children'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Gustavo A. R. Silva (4):
  i40e: Replace one-element array with flex-array member in struct
    i40e_package_header
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_segment
  i40e: Replace one-element array with flex-array member in struct
    i40e_section_table
  i40e: Replace one-element array with flex-array member in struct
    i40e_profile_aq_section

 drivers/net/ethernet/intel/i40e/i40e_ddp.c  | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_type.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.38.1


