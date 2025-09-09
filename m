Return-Path: <netdev+bounces-221402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF604B5071E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74481C234BD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22580258EE9;
	Tue,  9 Sep 2025 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etzaXcfz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B623C506
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449963; cv=none; b=O8qMoLLZLMy62NAjMC3QKnd8vaITl4ptMZj1QSrSS0k8piexrbAozvYt3CfZKyi9t3QXopz66QdaHRytCFbuOhfpENfnJ0qVVHRaJD0WnFF6KZMwi0sQQVRP8/cIjyLE45gnlXWtZDqPTZUDDgR8pCT95o6OkLByXMNNWeUHFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449963; c=relaxed/simple;
	bh=f4Z7sZJ3Pgb51Rp+WK+mZ/BcK0XnwXWUnPJWIeRtL3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHKAVyI9AiGcLLkqiPwihcYUxQ/z6s1JbwZUySX1awHy2zGIc2AF+a9ZA+FXNOr0rHpoXwzTACa3nombaQDU8VS1eRccB6wWdAZ1QdTPcIGim9NeqTv9bK3EM9vZ4zAUITuJMSyr4lAT/Aiiy2bt2PeakvMcwh4254wna4p8QPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etzaXcfz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757449962; x=1788985962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f4Z7sZJ3Pgb51Rp+WK+mZ/BcK0XnwXWUnPJWIeRtL3k=;
  b=etzaXcfzVioU4srLhB7TcLr+vm02ke4nhpd9oLNjkFVOCtgHGVxRxJqH
   UcygbcoYabAZFvrTQRTJnVYsVvVEpsFypNrDAyKPBbo5Z1G7XE+RKNH6L
   yT1MRlzcAwr2jPFJYY9UA7N/WmGRb0jMUyWJIU+D/8J4hK+QqVYioqW7B
   lihN4CSzDzYnPpogeetVw6i+LUJdneH6u7LX/Ou3Cy8mx8GmSmME5x9Fl
   CqSDzrJu11wSK3R82DJi+ZksQFKqG6zytftWSOrCNGDSqmJX+nhlFAYmQ
   eQZDeITFPFZYhAP5F1cTcmpacW05WlyT/6zuPYLD3sXuYg0yR0FMqazXG
   w==;
X-CSE-ConnectionGUID: TuSYjKMzQZmQ0h7W0QRSag==
X-CSE-MsgGUID: a2N/rhHqQbiLkSbhu/5zsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59606751"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="59606751"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 13:32:41 -0700
X-CSE-ConnectionGUID: VaMIfMXkQr+9neYoE/F1CQ==
X-CSE-MsgGUID: As/POrrcRSaeOebPNM3DIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173287020"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Sep 2025 13:32:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2025-09-09 (igb, i40e)
Date: Tue,  9 Sep 2025 13:32:30 -0700
Message-ID: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For igb:
Tianyu Xu removes passing of, no longer needed, NAPI id to avoid NULL
pointer dereference on ethtool loopback testing.

Kohei Enju corrects reporting/testing of link state when interface is
down.

For i40e:
Michal Schmidt corrects value being passed to free_irq().

Jake sets hardware maximum frame size on probe to ensure
expected/consistent state.

The following are changes since commit e3c674db356c4303804b2415e7c2b11776cdd8c3:
  tunnels: reset the GSO metadata before reusing the skb
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Jacob Keller (1):
  i40e: fix Jumbo Frame support after iPXE boot

Kohei Enju (1):
  igb: fix link test skipping when interface is admin down

Michal Schmidt (1):
  i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Tianyu Xu (1):
  igb: Fix NULL pointer dereference in ethtool loopback test

 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c | 34 +++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 18 ++++++----
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  2 ++
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  5 +--
 drivers/net/ethernet/intel/igb/igb_main.c     |  3 +-
 6 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.47.1


