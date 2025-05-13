Return-Path: <netdev+bounces-189975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD02AB4AAF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6AA7A9FF0
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F143191F92;
	Tue, 13 May 2025 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp8AkG64"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AFA189BB5
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112569; cv=none; b=t2P69yTER0IIBnyKpW/JtzAp/aS43/eRot+VmUmizo3IErTUbXQyztnvboh+iXHvuwE6uYLEosfwYiHyvBAh1kj5mcKYNfj9Stbp0pdncJ7tZj0slFAH7DuwMxsIcWjjA9POyiv383FrVBNGn3Uo6wTNaabZyMFsW42ZKHpTS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112569; c=relaxed/simple;
	bh=QhfdHglahO7Ldn9Bfy+sJlCgnMlTEKh9gtHdFV3Pmgs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CSTKBznRdlQUY6PTze7w5GmtR93pV5LsmhKKaA7K17mdPkpF3bcHuZA+pHJz/Ei5aMJvbKjOd4mHxia39LquPTxDSybfsgE3XtPYXYsltLR6/WMMaHeYJs7Kip5J0FoXh5Uj2p8bxisxoh/q2O9lXkxsUMDeIJFkNwxw3PRHX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp8AkG64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A24C4CEE4
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 05:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747112568;
	bh=QhfdHglahO7Ldn9Bfy+sJlCgnMlTEKh9gtHdFV3Pmgs=;
	h=From:To:Subject:Date:From;
	b=fp8AkG64BMGsuqfthFHv5C6fptp5pwbiLkrzr0XED4WeiZn5K73xVlHPacaSSk5xk
	 7JjnWIoub2izxXImIlouTq8moyU5KivYKFymSJ+ZSPg94S02Pqa8YRr1pC+g4vrAYe
	 aHuJyFOYu0j9vB6UME0eXS9eEYD8T4XBAFhZ/9eA2oI0XyHYTq2yJ1rU6V6K1+0DzK
	 w8Bu8EmS1yN1m0kgM8nStJcxdBJSN0sYaITbriziZiJwvMA4YTHx1UXOm9QgqRajgK
	 9qOT5aKlVINAy7NFiEmJTKuvA8PnuC3gECyE05UQBPIGyvmCcQS1DuRQjk5sY4BWf7
	 liw+5Ii7zH1Tw==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next] net: apple: bmac: use crc32() instead of hand-rolled equivalent
Date: Mon, 12 May 2025 22:01:42 -0700
Message-ID: <20250513050142.635391-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The calculation done by bmac_crc(addr) followed by taking the low 6 bits
and reversing them is equivalent to taking the high 6 bits from
crc32(~0, addr, ETH_ALEN).  Just do that instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/net/ethernet/apple/bmac.c | 60 ++-----------------------------
 1 file changed, 2 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index b9fdd61f1fdb..b50052c25a91 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -18,11 +18,10 @@
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/crc32.h>
-#include <linux/crc32poly.h>
 #include <linux/bitrev.h>
 #include <linux/ethtool.h>
 #include <linux/slab.h>
 #include <linux/pgtable.h>
 #include <asm/dbdma.h>
@@ -794,63 +793,10 @@ static irqreturn_t bmac_txdma_intr(int irq, void *dev_id)
 	bmac_start(dev);
 	return IRQ_HANDLED;
 }
 
 #ifndef SUNHME_MULTICAST
-/* Real fast bit-reversal algorithm, 6-bit values */
-static int reverse6[64] = {
-	0x0,0x20,0x10,0x30,0x8,0x28,0x18,0x38,
-	0x4,0x24,0x14,0x34,0xc,0x2c,0x1c,0x3c,
-	0x2,0x22,0x12,0x32,0xa,0x2a,0x1a,0x3a,
-	0x6,0x26,0x16,0x36,0xe,0x2e,0x1e,0x3e,
-	0x1,0x21,0x11,0x31,0x9,0x29,0x19,0x39,
-	0x5,0x25,0x15,0x35,0xd,0x2d,0x1d,0x3d,
-	0x3,0x23,0x13,0x33,0xb,0x2b,0x1b,0x3b,
-	0x7,0x27,0x17,0x37,0xf,0x2f,0x1f,0x3f
-};
-
-static unsigned int
-crc416(unsigned int curval, unsigned short nxtval)
-{
-	unsigned int counter, cur = curval, next = nxtval;
-	int high_crc_set, low_data_set;
-
-	/* Swap bytes */
-	next = ((next & 0x00FF) << 8) | (next >> 8);
-
-	/* Compute bit-by-bit */
-	for (counter = 0; counter < 16; ++counter) {
-		/* is high CRC bit set? */
-		if ((cur & 0x80000000) == 0) high_crc_set = 0;
-		else high_crc_set = 1;
-
-		cur = cur << 1;
-
-		if ((next & 0x0001) == 0) low_data_set = 0;
-		else low_data_set = 1;
-
-		next = next >> 1;
-
-		/* do the XOR */
-		if (high_crc_set ^ low_data_set) cur = cur ^ CRC32_POLY_BE;
-	}
-	return cur;
-}
-
-static unsigned int
-bmac_crc(unsigned short *address)
-{
-	unsigned int newcrc;
-
-	XXDEBUG(("bmac_crc: addr=%#04x, %#04x, %#04x\n", *address, address[1], address[2]));
-	newcrc = crc416(0xffffffff, *address);	/* address bits 47 - 32 */
-	newcrc = crc416(newcrc, address[1]);	/* address bits 31 - 16 */
-	newcrc = crc416(newcrc, address[2]);	/* address bits 15 - 0  */
-
-	return(newcrc);
-}
-
 /*
  * Add requested mcast addr to BMac's hash table filter.
  *
  */
 
@@ -859,12 +805,11 @@ bmac_addhash(struct bmac_data *bp, unsigned char *addr)
 {
 	unsigned int	 crc;
 	unsigned short	 mask;
 
 	if (!(*addr)) return;
-	crc = bmac_crc((unsigned short *)addr) & 0x3f; /* Big-endian alert! */
-	crc = reverse6[crc];	/* Hyperfast bit-reversing algorithm */
+	crc = crc32(~0, addr, ETH_ALEN) >> 26;
 	if (bp->hash_use_count[crc]++) return; /* This bit is already set */
 	mask = crc % 16;
 	mask = (unsigned char)1 << mask;
 	bp->hash_use_count[crc/16] |= mask;
 }
@@ -874,12 +819,11 @@ bmac_removehash(struct bmac_data *bp, unsigned char *addr)
 {
 	unsigned int crc;
 	unsigned char mask;
 
 	/* Now, delete the address from the filter copy, as indicated */
-	crc = bmac_crc((unsigned short *)addr) & 0x3f; /* Big-endian alert! */
-	crc = reverse6[crc];	/* Hyperfast bit-reversing algorithm */
+	crc = crc32(~0, addr, ETH_ALEN) >> 26;
 	if (bp->hash_use_count[crc] == 0) return; /* That bit wasn't in use! */
 	if (--bp->hash_use_count[crc]) return; /* That bit is still in use */
 	mask = crc % 16;
 	mask = ((unsigned char)1 << mask) ^ 0xffff; /* To turn off bit */
 	bp->hash_table_mask[crc/16] &= mask;

base-commit: e39d14a760c039af0653e3df967e7525413924a0
-- 
2.49.0


