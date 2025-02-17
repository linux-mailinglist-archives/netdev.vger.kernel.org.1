Return-Path: <netdev+bounces-166945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908FFA3802D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3741669E7
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365821765B;
	Mon, 17 Feb 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZ7knV3J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57C216E1C
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788100; cv=none; b=hGIXhGguc0i9SPBikH2aGuZfNACZaEC50nCRRCWq8WpWWSlnVTgkSVOCN6K+8ED9xyeQBGy3ufH8qz3GOfGShpMokD+Bvhe3hlIv9w4j+MCLCgTmCcEDH5gM8wn6BaDXwgvrFMPQmfRv2pNoaXOZxuHrdMgMjcg1vIErulGEpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788100; c=relaxed/simple;
	bh=nZjPci26EeRl0Lt6rghvQSdqDIAy8u8SjCiDpqkLlmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaHkjJGl2f3Fz6Xxic0vPlM9wt3vg/+J9ZkqFa/BJnUsuGi9xir0JkQN83tQVToeTHKUt6ckQX25m6mmjeq4uEZkShPASjz3gE8zjnY2rpl5a1LV7aYmRDp1OPoAeiPuXtsebpPF8kQcT85OhySjeu5tJY0s9uC85XJD3Z0LFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZ7knV3J; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739788098; x=1771324098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nZjPci26EeRl0Lt6rghvQSdqDIAy8u8SjCiDpqkLlmY=;
  b=IZ7knV3JrHl102JtgOdObWMo62w5UN35tmBPs+gkGTtI2pzFIG6V3vCC
   ECSDloAhT2GEmO1qoJesQd2Zj0mcPUbCThRdFx5uGN94vTcnm2YE+0Apa
   wVbxBi7wOp0rNzv4nlR8agCZ+P/aSpn2mJuk0ao5bhBI3TbSCvMdmNXYU
   4ym/50Ap0UsC0qfiYcxyNeXotMfOq6bEbs91Ea6lXmT8RcK8UcbKNSdvv
   GmzoDj7hE/MsvR8XkHokLiX7Zlk4+jCmJBzC3ixs3NvfnsEDpxvtJyc8e
   6A+DdjPMad9AzkIk/B2UfnpAyIhH62R8I1QFljhageSFDIAcCNHbPfCgh
   g==;
X-CSE-ConnectionGUID: QBFU0/0HQ9qO5MbiTvdGag==
X-CSE-MsgGUID: TeajUg2USMCytKcgoV75OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40168361"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40168361"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 02:28:17 -0800
X-CSE-ConnectionGUID: 8J+pHJF7RWyOP6n2c9qmcQ==
X-CSE-MsgGUID: cWad0JMQTii9ikODgIM0Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114598207"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa010.fm.intel.com with ESMTP; 17 Feb 2025 02:28:16 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net 0/4] ice: improve validation of virtchnl parameters
Date: Mon, 17 Feb 2025 11:27:41 +0100
Message-ID: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces improvements to the `ice` driver and `virtchnl`
interface by adding stricter validation checks and preventing potential
out-of-bounds scenarios.

Jan Glaza (3):
  virtchnl: make proto and filter action count unsigned
  ice: stop truncating queue ids when checking
  ice: validate queue quanta parameters to prevent OOB access

Lukasz Czapnik (1):
  ice: fix input validation for virtchnl BW

 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 39 +++++++++++++++----
 include/linux/avf/virtchnl.h                  |  4 +-
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.47.0


