Return-Path: <netdev+bounces-135151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451399C810
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEFD1F253AC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E931A2C06;
	Mon, 14 Oct 2024 11:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F761A0BEE;
	Mon, 14 Oct 2024 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903657; cv=none; b=RmI09HAMMZ6DsPjv/JvX2aQmu+9mHC4vG/L9YQWuwPcgqkJuP+V97ZQQMmzKUSPHgIr4lFhH2suBCM/PzfsFrc9qWYZeiUPJNPIo37b0qsVUraGEH/FA5w5p8cUMhOS+fB9VhCKYL8uwxNaAo4z8aBiRepNZmAQkN98p5cUjAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903657; c=relaxed/simple;
	bh=mxDtmKgypZY1eZM+jBtJAQjb/q41Q6rwU63pXJuO3f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0F/WlCCkrd3dWcMt+HW5+ZkHXcvXUgB2x4k0cc4w7K/mqtDv4aKtjagg5Ea5m1U/cv7rnhH/cNhSkOxoZqh64iv37N5T07s7hwO/79zDs+NKTtOqyBoA9P7gk2wVv1zfEkzhydjicytBaQH0p2XS/+LWw/bGbE2nQX0vs5OqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B102016F2;
	Mon, 14 Oct 2024 04:01:25 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDCA03F51B;
	Mon, 14 Oct 2024 04:00:52 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Paolo Abeni <pabeni@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v1 28/57] net: igbvf: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:35 +0100
Message-ID: <20241014105912.3207374-28-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Convert CPP conditionals to C conditionals. The compiler will dead code
strip when doing a compile-time page size build, for the same end
effect. But this will also work with boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/net/ethernet/intel/igbvf/netdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 925d7286a8ee4..2e11d999168de 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2419,12 +2419,10 @@ static int igbvf_change_mtu(struct net_device *netdev, int new_mtu)
 		adapter->rx_buffer_len = 1024;
 	else if (max_frame <= 2048)
 		adapter->rx_buffer_len = 2048;
-	else
-#if (PAGE_SIZE / 2) > 16384
+	else if ((PAGE_SIZE / 2) > 16384)
 		adapter->rx_buffer_len = 16384;
-#else
+	else
 		adapter->rx_buffer_len = PAGE_SIZE / 2;
-#endif
 
 	/* adjust allocation if LPE protects us, and we aren't using SBP */
 	if ((max_frame == ETH_FRAME_LEN + ETH_FCS_LEN) ||
-- 
2.43.0


