Return-Path: <netdev+bounces-28190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD6D77E9CE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F91C21141
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7D1773C;
	Wed, 16 Aug 2023 19:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA917AA7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 19:40:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887C2712
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692214800; x=1723750800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a3U+uFW4d83XYu/doU1VhqiyNxU5LEfuQ5OFQq0GO5I=;
  b=TXYq8tSH+nvi3hFfQjk0ARJ9o8D66TUcGFoKzBnbwOouCkFHQIOXhnsc
   kjk1DFtNMn357rSr5N/8UtqVpgz0S9TveEQ0xSSvsTPiMQWndH2yu4nTW
   hAKxJjDZGCHysqX6VW8n6+gwA7UOzHNCxshsOm4VscQr5CvaP1NCevi8c
   ZqTxfMrMgTX5dwsg7pyIaYHv7NW62oi677ipwuYcz6BFT2Uhj2Sami+Y8
   i/mRcHw7SYDBzVwgBjlmA0jw+z8ffDOHe4SRQLQ4zl/+DiwlDLv0qJQd3
   RySpnN4Qb/vzqEPzVNCZmL+ZGBUcQqk3ZERlNDMZ+tBMZBU4jPN9x79r/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375386504"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="375386504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 12:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763749442"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="763749442"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 12:39:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2023-08-16 (iavf, i40e)
Date: Wed, 16 Aug 2023 12:33:06 -0700
Message-Id: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
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
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to iavf and i40e drivers.

Piotr adds checks for unsupported Flow Director rules on iavf.

Andrii replaces incorrect 'write' messaging on read operations for i40e.

The following are changes since commit de4c5efeeca7172306bdc2e3efc0c6c3953bb338:
  Merge tag 'nf-23-08-16' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Andrii Staikov (1):
  i40e: fix misleading debug logs

Piotr Gardocki (1):
  iavf: fix FDIR rule fields masks validation

 drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 16 ++--
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 10 +++
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 77 ++++++++++++++++++-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  2 +
 4 files changed, 93 insertions(+), 12 deletions(-)

-- 
2.38.1


