Return-Path: <netdev+bounces-56782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8C3810D86
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB32A1F2118C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3F200A6;
	Wed, 13 Dec 2023 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GqnpU/Q+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EB9DB
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 01:40:52 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD890E4022491;
	Wed, 13 Dec 2023 01:40:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=3VUczU3I
	URqTdQDmSHPuPawXedgJ2zeBgDTVT+OqdOo=; b=GqnpU/Q+8XaCl5q28ivu6vSg
	BdbJy2MJN1/etY+Dyr4jK3UvuNWCwuwm76vpgC0f4Ssh0t2NgR0cVz0ZPCFiYKa7
	7sO++ArzWMPYd2cAdw8+MxAHpCBzznPqChTWgYDhmHwlcYgdIo4C+aIkgGaAR7UP
	OZdoLMj3CbwpRpbWGFqrlWjEdsXmgJ5xDfHS/MGEsSUUAbvgCeUVBxwUbPGFkv/G
	ieHW4grD0R48j7XOg6qbQ1jADnOJFQ0ExAKfhHh0FZVOiumWRRP1Gc3c2SWCpikA
	3n0hOpMbybH1tpjLEixa+CMcQZCxPMdnMkbbxlBKghaFOp14k6SNzHE+krnm3w==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uvrmjw7ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 01:40:47 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Dec
 2023 01:40:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 13 Dec 2023 01:40:45 -0800
Received: from EL-LT0043.marvell.com (unknown [10.193.38.189])
	by maili.marvell.com (Postfix) with ESMTP id 7EDCE3F70A6;
	Wed, 13 Dec 2023 01:40:44 -0800 (PST)
From: Igor Russkikh <irusskikh@marvell.com>
To: <netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: [PATCH] net: atlantic: fix double free in ring reinit logic
Date: Wed, 13 Dec 2023 10:40:44 +0100
Message-ID: <20231213094044.22988-1-irusskikh@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7PHwqBVfAN04p36QOcB0qunobAhdzt5N
X-Proofpoint-ORIG-GUID: 7PHwqBVfAN04p36QOcB0qunobAhdzt5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Driver has a logic leak in ring data allocation/free,
where double free may happen in aq_ring_free if system is under
stress and driver init/deinit is happening.

The probability is higher to get this during suspend/resume cycle.

Verification was done simulating same conditions with

    stress -m 2000 --vm-bytes 20M --vm-hang 10 --backoff 1000
    while true; do sudo ifconfig enp1s0 down; sudo ifconfig enp1s0 up; done

Fixed by explicitly clearing pointers to NULL on deallocation

Fixes: 018423e90bee ("net: ethernet: aquantia: Add ring support code")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/netdev/CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com/
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 4de22eed099a..472c7c08bfed 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -932,11 +932,14 @@ void aq_ring_free(struct aq_ring_s *self)
 		return;
 
 	kfree(self->buff_ring);
+	self->buff_ring = NULL;
 
-	if (self->dx_ring)
+	if (self->dx_ring) {
 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
 				  self->size * self->dx_size, self->dx_ring,
 				  self->dx_ring_pa);
+		self->dx_ring = NULL;
+	}
 }
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
-- 
2.25.1


