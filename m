Return-Path: <netdev+bounces-186343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E924A9E7FB
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A2C3BBAFD
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8351DF247;
	Mon, 28 Apr 2025 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEQLkMIE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53E1C84AA;
	Mon, 28 Apr 2025 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820233; cv=none; b=aREVpus182FwOsphqYOZ6JKa0cChSZ5UPrzHGh9CCfS6vPdXIZAVqp0r/5cOc6ffEct95DBOJziBT/i2ggYrfAXLgyTEDI+CMV7RYsYDIXHqZ/cTrhdKr6mh5KQv78U05a6LZHmx3Xko8JPWLZDrdS0yk+MYUqWvjwvXGHXpWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820233; c=relaxed/simple;
	bh=Id+TWx5/otkd8lgaTSNghybHj9Zco76B3Ud7RehbGmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dEckXeUXwJgPc4KuVQ8XHEOiMo941Ex9ZrdHp8Lp+aPr5CPrhodlekAv0l/Uy1UkY3UloV0tSTIJXFmwZjm6o3QocfgkL13SZu/Zkn/wp5hfN+/W9VvWtYrDB3cXa6H9BELOoHyw0jSppi1RgkAhvmPC6fMVlQvZcpDKG7XNthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEQLkMIE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745820233; x=1777356233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Id+TWx5/otkd8lgaTSNghybHj9Zco76B3Ud7RehbGmk=;
  b=TEQLkMIEeGDwT2Fn/lIJOPIDrPZ126PiEM14VKNz+hHuqt1IFb0io3dq
   0BV67FFRYhfscrFFaMPd0XtELGFzNpSyGhHvnjhk6kiw6zbmnZVineGE/
   ciM5OBwJWYRG7+PjAtUzbZHXLp5H72iqJhx3h/3fmEoMRqyl8zx4IIA06
   cNwocnaQ+PPwkv5AN001HQeANJJVw2NW2a26kk6cU6UuKzgqAP/bSvFd6
   XKAeog7BxwoTPxrTPD4/Xh9LVLQGDo5v4qR6sDBcktH9dtDE9P2usmeo7
   3uw5Emk+9KmInJdAkO//iDX+fOkcXJQi+Az67wc3jHiWOyiHy2pWgvN20
   A==;
X-CSE-ConnectionGUID: 3cWobGioRUarIkaOxHxjZg==
X-CSE-MsgGUID: B105CMFOQsaW9xxMyeAGhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="51064665"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="51064665"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 23:03:52 -0700
X-CSE-ConnectionGUID: J/lL2KBgTs6w8ezYH0CU9A==
X-CSE-MsgGUID: h/Gmrk5KRauDuJDkVM/2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133340847"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2025 23:03:49 -0700
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v1 8/8] igc: SW pad preemptible frames for correct mCRC calculation
Date: Mon, 28 Apr 2025 02:02:25 -0400
Message-Id: <20250428060225.1306986-9-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
References: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chwee-Lin Choong <chwee.lin.choong@intel.com>

A hardware-padded frame transmitted from the preemptible queue
results in an incorrect mCRC computation by hardware, as the
padding bytes are not included in the mCRC calculation.

To address this, manually pad frames in preemptible queues to a
minimum length of 60 bytes using skb_padto() before transmission.
This ensures that the hardware includes the padding bytes in the
mCRC computation, producing a correct mCRC value.

Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6b14b0d165f0..d495aee58601 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1685,6 +1685,15 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	first->tx_flags = tx_flags;
 	first->protocol = protocol;
 
+	/* For preemptible queue, manually pad the skb so that HW includes
+	 * padding bytes in mCRC calculation
+	 */
+	if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
+		if (skb_padto(skb, ETH_ZLEN))
+			goto out_drop;
+		skb_put(skb, ETH_ZLEN - skb->len);
+	}
+
 	tso = igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
 	if (tso < 0)
 		goto out_drop;
-- 
2.34.1


