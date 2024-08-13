Return-Path: <netdev+bounces-118095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F99507B5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2105A1F21875
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285142AB9;
	Tue, 13 Aug 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df4jM4Yr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F736125AC
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559586; cv=none; b=sUwDv7mGAVFYzaV27k4m2uRxb3EkTL2nreuUNgSz7H+eFvDLQpPJzohshKQQVS9PUk29UiwE7alAI5o4LIExPzeVWFKSN7dPhlZmfhgMcW19qQC2fk81kO+ld5XDg2Boo2/AXuhBk/yOGQL/dITbNjTT1LNK1GCvgj6cJSbDsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559586; c=relaxed/simple;
	bh=Sf7ZfeU8qW8sdKGSALwGOdHZsOt9zxm8T1Ht7GlBukA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAI2wrjzty87/KAptXLg3xWczWHmoojhBUV5U869f7RlyRV4Rt6bmF+0I6Y5DfdgLTt9Aq7QTE9Ea/WGjjIWQbRwV0K+/ycdRyjsKAv4cnKhn2xbyZN396DEMvEflnne4tUKyArc0VICw6+fn2dh4KPIIb9/fQiIWVihX3d5sIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df4jM4Yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50990C4AF09;
	Tue, 13 Aug 2024 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559586;
	bh=Sf7ZfeU8qW8sdKGSALwGOdHZsOt9zxm8T1Ht7GlBukA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=df4jM4YroUpsGnoY6/Ohz4ptvk2Ryu3kQDFOm+UJHEP/FjZjXRsgZ5LxxX4AcKOv1
	 6WxaU6A/PgtnLXvfxT9KJ391gepUA6MLSDSVMxPrQOuAdEXfPnz0vp9e2hoxuLiQ6+
	 BVZ0+9sL/RzB3KFBFqJoCkftGFQNPt1u3hsCgc06vFJ4fn8BJEEfsC/R245w5K3Fen
	 wNCRS1rEqQdQ2aObUKlfcda45rJTzEifm4BK0eukQ/m/zGhs1EBxOpUswnBahND1oo
	 INx4GCPc4BzJjUu56dqhvgsyKEdtKw6UE7Na6daaSA7GgEZziJW7SsYO6HO47Zgpd2
	 SxhLYoeDQq3Lg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 13 Aug 2024 15:32:56 +0100
Subject: [PATCH net-next v2 2/2] bnxt_en: avoid truncation of per rx run
 debugfs filename
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-bnxt-str-v2-2-872050a157e7@kernel.org>
References: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org>
In-Reply-To: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Although it seems unlikely in practice - there would need to be
rx ring indexes greater than 10^10 - it is theoretically possible
for the filename of per rx ring debugfs files to be truncated.

This is because although a 16 byte buffer is provided, the length
of the filename is restricted to 10 bytes. Remove this restriction
and allow the entire buffer to be used.

Also reduce the buffer to 12 bytes, which is sufficient.

Given that the range of rx ring indexes likely much smaller than the
maximum range of a 32-bit signed integer, a smaller buffer could be
used, with some further changes.  But this change seems simple, robust,
and has minimal stack overhead.

Flagged by gcc-14:

  .../bnxt_debugfs.c: In function 'bnxt_debug_dev_init':
  drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c:69:30: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 10 [-Wformat-truncation=]
     69 |         snprintf(qname, 10, "%d", ring_idx);
        |                              ^~
  In function 'debugfs_dim_ring_init',
      inlined from 'bnxt_debug_dev_init' at .../bnxt_debugfs.c:87:4:
  .../bnxt_debugfs.c:69:29: note: directive argument in the range [-2147483643, 2147483646]
     69 |         snprintf(qname, 10, "%d", ring_idx);
        |                             ^~~~
  .../bnxt_debugfs.c:69:9: note: 'snprintf' output between 2 and 12 bytes into a destination of size 10
     69 |         snprintf(qname, 10, "%d", ring_idx);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Compile tested only

Signed-off-by: Simon Horman <horms@kernel.org>
---
v2: No change
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
index 156c2404854f..127b7015f676 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
@@ -64,9 +64,9 @@ static const struct file_operations debugfs_dim_fops = {
 static void debugfs_dim_ring_init(struct dim *dim, int ring_idx,
 				  struct dentry *dd)
 {
-	static char qname[16];
+	static char qname[12];
 
-	snprintf(qname, 10, "%d", ring_idx);
+	snprintf(qname, sizeof(qname), "%d", ring_idx);
 	debugfs_create_file(qname, 0600, dd, dim, &debugfs_dim_fops);
 }
 

-- 
2.43.0


