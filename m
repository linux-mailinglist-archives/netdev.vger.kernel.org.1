Return-Path: <netdev+bounces-59734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33881BE61
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3D7282EEB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E164A9F;
	Thu, 21 Dec 2023 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMZOeKUa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5064A92
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703184179; x=1734720179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCLO/LkJ1uxUQZ0zssZAjSjoxxI43U2fLHp+cLvJquQ=;
  b=ZMZOeKUaIshSy5OmMaOZHuJSD2aSJcm6l0iO4M9zekGeDHteHabvk+aL
   8EQs2QnMx/SzdiZQ2tXthD0/BJjGHZWskw1oJYDySIBm2NeZubw6pkAkV
   djSInwWGys/HhSv4gk2wx9IGaPXh9Jj9pPDY+n31bsS31+hHMI2hE8VZu
   IlivOWkcido5CPYTb1fxPKFNlaafeaWCy/s9vgU9DZyvqzpsOaaagxktk
   wPU2Pea2u2/xQFx7mkNpgkn0HCBZwSobiDobQUdvTrBQVgHqfhNeFLvKb
   L7K5VJbn6sdRSrh0VeltkRsV8+j4KhEw73qOlDvw7N2ML7iV2BpGYHT6m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17576101"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="17576101"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1023949912"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1023949912"
Received: from rkeeling-mobl.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.34.164])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:42:53 -0800
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 1/2] net: ethtool: copy input_xfrm to user-space in ethtool_get_rxfh
Date: Thu, 21 Dec 2023 11:42:34 -0700
Message-Id: <20231221184235.9192-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221184235.9192-1-ahmed.zaki@intel.com>
References: <20231221184235.9192-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ioctl path of ethtool's get channels is missing the final step of
copying the new input_xfrm field to user-space. This should have been
part of [1].

Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/ [1]
Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 net/ethtool/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 86d47425038b..9adc240b8f0e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1251,6 +1251,11 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, hfunc),
 			 &rxfh_dev.hfunc, sizeof(rxfh.hfunc))) {
 		ret = -EFAULT;
+	} else if (copy_to_user(useraddr +
+				offsetof(struct ethtool_rxfh, input_xfrm),
+				&rxfh_dev.input_xfrm,
+				sizeof(rxfh.input_xfrm))) {
+		ret = -EFAULT;
 	} else if (copy_to_user(useraddr +
 			      offsetof(struct ethtool_rxfh, rss_config[0]),
 			      rss_config, total_size)) {
-- 
2.34.1


