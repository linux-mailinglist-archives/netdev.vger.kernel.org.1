Return-Path: <netdev+bounces-69459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DA84B573
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7848B287DD1
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF861DDF6;
	Tue,  6 Feb 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipdjLfcV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64C3D54A
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223302; cv=none; b=fIHHDK4XSmZP5vJGGj7RsuQMwscGU/T/TGCdGT4/c+RLvbvZyP1TSWIHqC7RIuXcUO9UGzLH7jmLCkYlr06bRcwtN5JGLPPOKIOZvB8LAmLLvkGWvPhv7X46R0taYIcipm16qUYOzpiksoxpW1NM3wjlpwrimVYenfPY8Cwdcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223302; c=relaxed/simple;
	bh=fxxjh3UqiJAydxb1IXIY8ysNe/Wha4hgqHcWwa+iSdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ei8JgD3/FaKBl7BjRKPBigO2uQWNOlRQofv83k2KqUUQJL6u07hLWLATwnKzuQbZtsH3eGZqOnR8YSGqT43AV9ULl0rXd0xnVsPePGaRdF7JgMWAEFUTjJUCUDswrRz8l2I4iBHwgP0bZvoGy7+/voIEy4zjHnXSkXXJzhA/Y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipdjLfcV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707223301; x=1738759301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fxxjh3UqiJAydxb1IXIY8ysNe/Wha4hgqHcWwa+iSdw=;
  b=ipdjLfcVFR2z68sKQViS4su7HeYENOpVcsyuE8Yxgagf06qG2nmZ12zB
   LKfm83VhQ5qdUax21yDCe75Qx0+GoCWlZcUHlf1NQfT1TBAUlmEFb5lvM
   50MKWerlLetsiKoWcmbYdtT5elTvPtqHKZL1WS9ZWqPMH969dzIJXq9zV
   B+CWimzqwq4pdpBYo4hw5QA7lLztCPbawjek/fUeHqxtn1Rlc3h0sqMYp
   BPvJfKX8XIoxgw3hQ8WFx/QxoS9263+d68sv3zhiPXB7lguCebVEn1arK
   R15RYP3XMQYt2ukXHrjSgpTulSooZGdlGxBG0vc+hvx3gt2sC6u9vkxOu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18255144"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18255144"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5619960"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa005.fm.intel.com with ESMTP; 06 Feb 2024 04:41:38 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 0/2] i40e: disable XDP Tx queues on ifdown
Date: Tue,  6 Feb 2024 13:41:30 +0100
Message-Id: <20240206124132.636342-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seth reported in [0] that he couldn't get traffic flowing again after a
round of down/up of interface that i40e driver manages.

While looking into fixing Tx disable timeout issue I also noticed that
there is a doubled function call on Rx side which is fixed in patch 1.

Thanks,
Maciej

[0]: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/

v2:
- include vsi->base_queue when calculating tx_q_end
- add tags from Simon and Seth

Maciej Fijalkowski (2):
  i40e: avoid double calling i40e_pf_rxq_wait()
  i40e: take into account XDP Tx queues when stopping rings

 drivers/net/ethernet/intel/i40e/i40e_main.c | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

-- 
2.34.1


