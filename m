Return-Path: <netdev+bounces-29860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73B784FBE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D30281293
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 04:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7AA7E1;
	Wed, 23 Aug 2023 04:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62717C6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 04:51:53 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA7E57
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 21:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1692766306;
	bh=jM+6MIsdNqfnZhAbj6Wj7rZO1gKq3DSIAtdYhWjXIFs=;
	h=From:To:Cc:Subject:Date:From;
	b=id3CS+ZVgXF3s/gz5eYyUVC3AsumCWN3EObyerjdgFcGwOGZuFHfBTVg24hQ7xdQ4
	 0OXlM4vY1YyqMiUxSX6dNsx5sH+dzfesycmJ7vYMa+VmiNyoAQJ/kGBdG6I7Zf2xQl
	 rMp+IhHAch9z+i6fj1mLhvTn6NyWQ4W9Aujl9b4EpLHQ7ZtC8DEbb6k5XL/nM8i5Jh
	 k/ktil21HrhLKgIb1FFbmIUlPJymqmzexftRQdMFLiwLnCRjWkW0wA1S53luoh/JK5
	 yGDN7sGS6+mfpU7sUHGCLVbuk9PA4Yb5oXmlGktUbqBu8sjWvWeJuv1eNUJwF9Sj1B
	 YI4TVSHCWvVkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVv2B2P2Pz4wy3;
	Wed, 23 Aug 2023 14:51:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <netdev@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>,
	nnac123@linux.ibm.com
Subject: [PATCH] ibmveth: Use dcbf rather than dcbfl
Date: Wed, 23 Aug 2023 14:51:39 +1000
Message-ID: <20230823045139.738816-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When building for power4, newer binutils don't recognise the "dcbfl"
extended mnemonic.

dcbfl RA, RB is equivalent to dcbf RA, RB, 1.

Switch to "dcbf" to avoid the build error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 113fcb3e353e..832a2ae01950 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -203,7 +203,7 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 	unsigned long offset;
 
 	for (offset = 0; offset < length; offset += SMP_CACHE_BYTES)
-		asm("dcbfl %0,%1" :: "b" (addr), "r" (offset));
+		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
 /* replenish the buffers for a pool.  note that we don't need to
-- 
2.40.1


