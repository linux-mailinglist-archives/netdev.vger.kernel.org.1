Return-Path: <netdev+bounces-216890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77764B35C8C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B08360E76
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B096321457;
	Tue, 26 Aug 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUoUrpnD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3F2FF67A;
	Tue, 26 Aug 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207692; cv=none; b=cH6fUm79zOysYgGsR8KI3OQBPxFB1w9zpEyuP+AYTA54IA0L+9XmTiRvk8Re29/Cs5zKGOBp4HQDVxK9d7R+LzgVUsFMyTPyub9g+FD5hNFi7bPnPv1uzGB1jWFqjUyyE5+0m1Naa+hi4nP/tYO4ZypDGU4eES6ogHXPnMbk7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207692; c=relaxed/simple;
	bh=snGzQYNQvDQYmyS6qxvd5dXjyUh38x2uCaudcKbJlMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CicPKH+ZpbbMevtmKG481nIenuSd72Cs5wEA5LxQE9iMaM0h7zeGDA4MlpeSH/XBK+wAqac28+/60moR7ArTwvXm04zKVjpV0R0f+IIjBXwSMuoSnODyZL0Etn0g8WpPryB+R3J3zYnNpJuNSLEYI+NuTrfj0rkcgwNiLQ7nm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUoUrpnD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207691; x=1787743691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=snGzQYNQvDQYmyS6qxvd5dXjyUh38x2uCaudcKbJlMU=;
  b=BUoUrpnDjCMKQre0OHWy/iET4RF3WMN7cx+p1w3x7UA6gKR1TJozTA04
   jk9EGw7HBMYBw/hSAQv2EB7zYxZpT20gvppW4kW4YVU/bOmZ3k/cUYTA2
   TkkcTVbpzPFL9Fze+GLNNP0xucGd7g89abp7LzkaXFlltNOGOPeHFpjhh
   mEumt5LLk3XCMY8BUn0oen0jK7ERkOImf3Caoi5LM6DkvA5VGDFi0qADA
   HsakeXMZNjP/wVy51cJOELCe8K0PREvxCaSdZuoMfLMxz9LorD12ciIKo
   +yLN3iAs1xYTs/pIbLk8II3Cw2eoHtqmKcX9h1eq0dMwUoWbcoWI5FIvG
   Q==;
X-CSE-ConnectionGUID: RDTEqAjASdyL/GunREIKOQ==
X-CSE-MsgGUID: L2eiFYUDSIG5f+Y5vkDA+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269251"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:11 -0700
X-CSE-ConnectionGUID: XfP2nCX9TK2FW6WHbg4ENQ==
X-CSE-MsgGUID: fS14aHsiRiqxJg1pB/dF4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725751"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:08 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next 0/7] net: stmmac: fixes and new features
Date: Tue, 26 Aug 2025 13:32:40 +0200
Message-Id: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series starts with three fixes addressing KASAN panic on ethtool
usage, Enhanced Descriptor printing and flow stop on TC block setup when
interface down.
Everything that follows adds new features such as ARP Offload support,
VLAN protocol detection and TC flower filter support.

Karol Jurczenia (4):
  net: stmmac: check if interface is running before TC block setup
  net: stmmac: enable ARP Offload on mac_link_up()
  net: stmmac: set TE/RE bits for ARP Offload when interface down
  net: stmmac: add TC flower filter support for IP EtherType

Konrad Leszczynski (1):
  net: stmmac: replace memcpy with strscpy in ethtool

Piotr Warpechowski (2):
  net: stmmac: correct Tx descriptors debugfs prints
  net: stmmac: enhance VLAN protocol detection for GRO

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 68 +++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++-
 include/linux/stmmac.h                        |  1 +
 5 files changed, 76 insertions(+), 15 deletions(-)

-- 
2.34.1


