Return-Path: <netdev+bounces-135150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D511399C80E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D10EB286A2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD7B1A2574;
	Mon, 14 Oct 2024 11:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F5A1A0BEE;
	Mon, 14 Oct 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903654; cv=none; b=ZmBUszPnxUx0PSu2gnvoi3ofKTw8ctp9X1KiHQ2vqGoi+V3ZHqrdGl+4DBfGxWtBzfXmaYrII04j56MxoFCNLZhi4yZOD3xM6YUpZjzhVPKDw9Os7D/HUv9I2sDMfApuANi6muJ9GvncGWp40usq2dHXv2T+oDruYitM2O0Ffsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903654; c=relaxed/simple;
	bh=v8EcrC0QG9BC5D3EnF8QmcSNAhlI095FheELVdWAuF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szv/ji6kUU3I1cHh6QrmR91SGGVgzrFnsB0PumBW2NK17H/6iFVC+puH0crmXN8o9djFsVXZtn1D4AfD7CW0IJZ+Gha4cJd9hRUZ1pPUUVv7BmjXhN0F2nUhFjpv4l8VfKz90en1PjmbgUYT/h9qT2BNppz0+UIEt/s1dPyf8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47DC9169E;
	Mon, 14 Oct 2024 04:01:22 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84C1A3F51B;
	Mon, 14 Oct 2024 04:00:49 -0700 (PDT)
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
Subject: [RFC PATCH v1 27/57] net: e1000: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:34 +0100
Message-ID: <20241014105912.3207374-27-ryan.roberts@arm.com>
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

 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index ab7ae418d2948..cc14788f5bb04 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3553,12 +3553,10 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 
 	if (max_frame <= E1000_RXBUFFER_2048)
 		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
-	else
-#if (PAGE_SIZE >= E1000_RXBUFFER_16384)
+	else if (PAGE_SIZE >= E1000_RXBUFFER_16384)
 		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
-#elif (PAGE_SIZE >= E1000_RXBUFFER_4096)
+	else if (PAGE_SIZE >= E1000_RXBUFFER_4096)
 		adapter->rx_buffer_len = PAGE_SIZE;
-#endif
 
 	/* adjust allocation if LPE protects us, and we aren't using SBP */
 	if (!hw->tbi_compatibility_on &&
-- 
2.43.0


