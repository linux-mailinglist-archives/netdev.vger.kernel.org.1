Return-Path: <netdev+bounces-135149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E0A99C80C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E66B22E15
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DB1A0BD6;
	Mon, 14 Oct 2024 11:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48581B85D4;
	Mon, 14 Oct 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903651; cv=none; b=UPLOBWONScuszVYti7XP8UX/wu7s1xCgH0Ip1vwruRaOLJRnbV8l2jGx0UK6L/ZN/maN3v5ueVmc3fUNvH3Xfo8DPM9vdTk8F4VblTd49NpLXiC8HWteU8hd1Exd5R6h360AT0zYCh3Vgiy+t7kDmZeDgnVohwASC6DKrjQi7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903651; c=relaxed/simple;
	bh=ZV4tQwLAYfsghWHXbRZH0ioEs/24Pbc5E3YqW06H+Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKGTDThXnOCsd6otPbXE9tmj5XFZI/1jvN0niFPgp4grFuYimCo1lGUNcmh6b2cI5oSkiHVi/5L2rSi87jkL6Aoc1OU40TkJ90wxvevktCPjqM7Frsn8QTdpnnLW7gORPVSeCr4sJMepNC2TKeM6QQIVPqr/cKpdwB9IwymSOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D37AC169C;
	Mon, 14 Oct 2024 04:01:18 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25203F51B;
	Mon, 14 Oct 2024 04:00:45 -0700 (PDT)
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
	Jijie Shao <shaojijie@huawei.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Will Deacon <will@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v1 26/57] net: hns3: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:33 +0100
Message-ID: <20241014105912.3207374-26-ryan.roberts@arm.com>
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

Convert a CPP conditional to a C conditional. The compiler will dead
code strip when doing a compile-time page size build, for the same end
effect. But this will also work with boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index d36c4ed16d8dd..5e675721b7364 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -681,10 +681,8 @@ static inline bool hns3_nic_resetting(struct net_device *netdev)
 
 static inline unsigned int hns3_page_order(struct hns3_enet_ring *ring)
 {
-#if (PAGE_SIZE < 8192)
-	if (ring->buf_size > (PAGE_SIZE / 2))
+	if (PAGE_SIZE < 8192 && ring->buf_size > (PAGE_SIZE / 2))
 		return 1;
-#endif
 	return 0;
 }
 
-- 
2.43.0


