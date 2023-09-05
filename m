Return-Path: <netdev+bounces-32119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B5792D3F
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68321C20A33
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714DDDC2;
	Tue,  5 Sep 2023 18:15:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D82D524
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:15:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4D6180
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693937700; x=1725473700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=McKJSGoc1X87Ld5yqADF2f+pZsu/xxaF15GrxAX5XDo=;
  b=k43/2eHyrasConSfgL5crQaXOPQPmHCNgkXVd2k+rZ8XuExZk3U2PkmE
   27ozhR+GKRkTdRh6KS6hIn0gT5cSzQhPOBcKqnfqajlhBzGaIkMmijlRx
   Qm62S4eKNmCI1mDB+oISPqdliZL0VZFbgvKwGnShqB/ZCZfWCQ82vewBT
   aRkwpyRT59kd3KAeU4NfvCfnGIXzoSEvpZhnWZSVCj/Ng1NodctbvhTwI
   DDsG2xFpM9aPjD5I0hzDoN10M+NQ/KtmZ7T5nXK9jrfjOoxonAY7Dtxtk
   KewT8nwpn44ZKWioVT2mWDj3o0wjbtFyrGFW/caagmCcONdTEhnxd+tBC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="356360173"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="356360173"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 11:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741197744"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="741197744"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 05 Sep 2023 11:14:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	olga.zaborska@intel.com
Subject: [PATCH net 0/3][pull request] Change MIN_TXD and MIN_RXD to allow set rx/tx value between 64 and 80
Date: Tue,  5 Sep 2023 11:07:05 -0700
Message-Id: <20230905180708.887924-1-anthony.l.nguyen@intel.com>
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

Olga Zaborska says:

Change the minimum value of RX/TX descriptors to 64 to enable setting the rx/tx
value between 64 and 80. All igb, igbvf and igc devices can use as low as 64
descriptors.

The following are changes since commit 29fe7a1b62717d58f033009874554d99d71f7d37:
  octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Olga Zaborska (3):
  igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
  igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
  igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

 drivers/net/ethernet/intel/igb/igb.h     | 4 ++--
 drivers/net/ethernet/intel/igbvf/igbvf.h | 4 ++--
 drivers/net/ethernet/intel/igc/igc.h     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.38.1


