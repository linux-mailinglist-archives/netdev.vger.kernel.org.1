Return-Path: <netdev+bounces-112462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B09393FC
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 21:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6E81C214F5
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01D170859;
	Mon, 22 Jul 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="a5iY12aK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F516EC19
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675308; cv=none; b=eQcVIdqhYsEemd6C73niNZMkaGerZOtbDLDx/7NWRQfPXXJl/71YQhhhjtm44XCG7Y4UmuBhuTGjD2XmoxLj+pewYKDnqNJlAhyqeGdcIhJsB+MRX42iLd1ey/+kVwGaCKJg1QjEGpXYxXSmWXRFHpP9ET2bG52fAor4WDUAcm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675308; c=relaxed/simple;
	bh=21T+7guqWFCcfmKQsaPQWLJG0mdfUYR6tiduUYWJzCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lzpC+bxuydurF+iG9AS1DCGLYO8eYroWNhyfWora/pdd5HjZt7ujJ5CXX7qeLChke1WP5lFSacC0Ls17cTZydwUBdmpwBg6RLpSFYxxpAzaDkFCj4sH0ug7f9YraGaVZs8bYOab9ieOTZweXOfNcIM4+Ur7foCKu292pk1IfaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=a5iY12aK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd66cddd4dso28242325ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721675305; x=1722280105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njVaMbDcMaiQerRZ4wsTI9OpiF5HxfQBcNMiBdohBpc=;
        b=a5iY12aKKrQLX1yN5xgNlzmOlBMkt0DeiNeHH21gVGOZkMm9vg4Xq/Pw+UIQlCFRUs
         I0aJFmXwTR7+LVLtQ71bvj/oz0SisYDPBK+J4VkfpY17JaVob2MRlQzLY+YSc7D4OF7E
         zsi2ZVQCaTRsVKLe98+4AelHMQjC7AfPIyC4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675305; x=1722280105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njVaMbDcMaiQerRZ4wsTI9OpiF5HxfQBcNMiBdohBpc=;
        b=Trwi0LZYsALGO6mBNO7MWg0A3rwcMMSuSqzYWS1vFGfUHIuzVPs5FYyjdBl/F5BwRT
         yp/3fQDem3L8NJGr8u0L0/tBE1i2M5aLSodzFGkqhim7dOMuujQdAY4j1ODwaCGo57jW
         YjbEfwrJRbsAK5mNU2T1e5sDeGcx9gR5Bt3Fio4XYE4InSxG7sI2tpMg4eh7zGbz/xw5
         0f4EloD9v1eQrEfyHzPzyh5PVJDLfqeB8gYJkVDbH0UFUe6VMZK8tLWIBfI1uxQABdwv
         ANEi6+T22A+fuQAFrGq2iaGK0yA/FcoRkCRwlbGtt1aBZxr2EkwI/CD3ZOu3tH6Ar42J
         kA5g==
X-Forwarded-Encrypted: i=1; AJvYcCWBiXk+QFdBqz03vALmkq4nKDT9mwF4Nsb5luEA/WR+jdSn4vuqNWyme0eNqGgqRpZJD7BkHOM86guL0Q76GCsbeEGesWi/
X-Gm-Message-State: AOJu0YwvBhiKrt7xiOBrwW5RjaGqeAAYqICBuVB0/gv27KJaUw/2txHk
	0/HwFmxhMlziVklqIMcMPUVXaWiMM/jVpSFSXVFGcVaZ1pmcnLSnbb44XcFKRcs=
X-Google-Smtp-Source: AGHT+IEqkTQAT1FPq412tRLy/kyTwhtLiCNeKUuL42bstXUpr01mSeEs0TrxDjRg1iZSGF1MUfAxOw==
X-Received: by 2002:a17:903:41cc:b0:1fb:7c7f:6447 with SMTP id d9443c01a7336-1fdb5f6b353mr6705625ad.25.1721675304659;
        Mon, 22 Jul 2024 12:08:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25a841sm58350335ad.32.2024.07.22.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:08:24 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH net] net: wangxun: use net_prefetch to simplify logic
Date: Mon, 22 Jul 2024 19:08:13 +0000
Message-Id: <20240722190815.402355-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use net_prefetch to remove #ifdef and simplify prefetch logic. This
follows the pattern introduced in a previous commit f468f21b7af0 ("net:
Take common prefetch code structure into a function"), which replaced
the same logic in all existing drivers at that time.

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 1eecba984f3b..2b3d6586f44a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -251,10 +251,7 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
 				  rx_buffer->page_offset;
 
 		/* prefetch first cache line of first page */
-		prefetch(page_addr);
-#if L1_CACHE_BYTES < 128
-		prefetch(page_addr + L1_CACHE_BYTES);
-#endif
+		net_prefetch(page_addr);
 
 		/* allocate a skb to store the frags */
 		skb = napi_alloc_skb(&rx_ring->q_vector->napi, WX_RXBUFFER_256);
-- 
2.25.1


