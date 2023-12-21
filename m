Return-Path: <netdev+bounces-59733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827081BE60
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3947F1F24BCB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7959902;
	Thu, 21 Dec 2023 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1NoRTQE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970EBA5F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703184175; x=1734720175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N8LjdwY5abDnhSHvop36FD8NTBM/nqrlxepQcmCJ6t4=;
  b=Q1NoRTQEYZNS81nlWWp6HIuqa7QU2e7/S2LG6eRDsdzU7BIdYpBlVtO0
   //XMxOhpaoXksLVGjVztYYWrtmOk1XC0A8SoUNvD2a+qs+EYgcE6IEC4y
   8/rTdYX++Jq6PmqbSLSKTdfV0QEFGX4LWMfWDMnui024Fpipziq1DY7vB
   riJIgqNmTAMYXCpvZPhx+EyhOU4XFRlF+GbcRQ/sZA4j/dIgZFXIQNFsl
   Jm1AzSi9BqtB5Fx/Zr2TCYoSiEH5OSYuHJ69ypXMUTWEPLTckNfZMB6T/
   mUvssdMbkGGNivMRtnV/3Mm0Cmfu/WivkYE/TgwfGzM8MTVl+ZKWygRmq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17576068"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="17576068"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1023949858"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1023949858"
Received: from rkeeling-mobl.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.34.164])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:42:48 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
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
	gal@nvidia.com,
	alexander.duyck@gmail.com,
	ecree.xilinx@gmail.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next 0/2] Bug fixes for RSS symmetric-xor 
Date: Thu, 21 Dec 2023 11:42:33 -0700
Message-Id: <20231221184235.9192-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of fixes for the symmetric-xor recently merged in net-next [1].

The first patch copies the xfrm value back to user-space when ethtool is
built with --disable-netlink. The second allows ethtool to change other
RSS attributes while not changing the xfrm values.

Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/ [1]

Ahmed Zaki (2):
  net: ethtool: copy input_xfrm to user-space in ethtool_get_rxfh
  net: ethtool: add a NO_CHANGE uAPI for new RXFH's input_xfrm

 include/uapi/linux/ethtool.h |  1 +
 net/ethtool/ioctl.c          | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1


