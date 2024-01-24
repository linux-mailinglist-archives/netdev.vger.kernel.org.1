Return-Path: <netdev+bounces-65383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D0A83A4A0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87ED21F258CB
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E317BC1;
	Wed, 24 Jan 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viEav9YP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1QKrWg8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DB17BAB
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086565; cv=none; b=NNpcylsnPb9M5xqfWv2ERm3iRt9WC5At8333Fsif2IYVn5CmQdie9k+q7cib78yGd6DkHCbJZNwKRu9PYwLA1xpgGkzgiR1NqAdotEd0BsJIxzdvakEcj/JrtrEYKrL1aEagAWbBTheL+Lf0nBz7HUZ/rvDTCxhvmJMiVxIWRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086565; c=relaxed/simple;
	bh=tLY1ofwsHENu/CKjziYljNsoNVzcpa+MdbHgyX96fxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVoYa5Vd2QYjt328IdFa5WTbhu7oRXCFoMH5WQWad+eBUMTyexRe3EW+041ibVJ08c87c8kbuPSFQvXSUK2MBTTaQG0tJvluWduN/+Vy3iWIrjhVHGxp8Esg9bKidTaI6zYZ8GW67UtmiArAUQeL5N9SwBGc89GI/IYXStgDqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viEav9YP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H1QKrWg8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706086561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X4FuCdhJchif0ZdIzxnHwtgL8xgXCxtiB3b4x2qtgyw=;
	b=viEav9YP9h95SvhqFWpPKp7flAZgvD728Hq8slaOP7HTnpvC467k3GxGGmaRNAIqGBJ6ea
	xMi+Q17RDjT4Nt3D+TveqOY79vG9LwIHBIDiPqTBG64Zk5H0gGnAJH2LIpptRPHeUTixKn
	OLy0Q5+KZC/6+HbGesRtDgWzJMVz0Xm+fVHDztKKeY2Rp0p70SDXmy1U//RX0VTXFEg1BF
	fP+m+2H9nJzqnrdggC+HOsEoVngeaCykHQt3Qxh0jmn7dgVGSfo/jVPIA+9xfKwYlKr30e
	LRqb7XEyxfk6xmX1cj+hMTJ0TtttjHTzdSL5irpEcMEm8glzjWvEIvC6XHkpig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706086561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X4FuCdhJchif0ZdIzxnHwtgL8xgXCxtiB3b4x2qtgyw=;
	b=H1QKrWg83OFrQteVHkRykToIvp18kfiD0+X0Q2GEqfCit2/9nkztWKhvauKGhC9QusYHCD
	D09Mw56cp5EqaLCQ==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 iwl-next 0/3] igc: ethtool: Flex filter cleanup
Date: Wed, 24 Jan 2024 09:55:29 +0100
Message-Id: <20240124085532.58841-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series contains some cosmetics for the flex filter code. The fixes have
been merged separately via -net already.

Changes since v1:

 * Add Vinicius Ack
 * Rebase to v6.8-rc1
 * Wrap commit messages at 75 chars

Previous versions:

 * v1: https://lore.kernel.org/netdev/20231128074849.16863-1-kurt@linutronix.de/

Kurt Kanzenbach (3):
  igc: Use reverse xmas tree
  igc: Use netdev printing functions for flex filters
  igc: Unify filtering rule fields

 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 21 ++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.39.2


