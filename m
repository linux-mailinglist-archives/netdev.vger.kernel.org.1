Return-Path: <netdev+bounces-113692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A144A93F955
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564FA1F2304C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22F7156C70;
	Mon, 29 Jul 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oT92Bkad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65147156883
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266828; cv=none; b=hPccAOgOD9iqYoiE45T2U8QKUWQgy7KDAHwY+HETF86VPMabXkRxFLeXca8iH+05VHcqINKBaRjmBAPRST2QM+CYgWJCN7jRmrKt/6vgGI3n9i1yMfXSytRP0k729IY2Bmx9h5NX9yDww8MFLWyPWtRaqT6XJbllXdlSIY5KBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266828; c=relaxed/simple;
	bh=EUzQAcMeIXbUvWPp/TFgPYPoqnzPkFmvgt8VJ9w9N6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TeUZQ6eHF3bAnkwxCwdPd5ulVATt1sD1xf1Xa7LYx9M2bd+oLcx9xVdpHeqVWHzHOf/v+YmPalWPMQPSZt/MR2gCAc0Ya/O353789fOkgdlQ9ORIV2HMaiJZHIShDd4D6/rXtv3o5Vj/LphoJe8Y84percx15upcVC8NOQzGhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oT92Bkad; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d2b921c48so2497020b3a.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722266826; x=1722871626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdJePI/ro3lzopvsSRF6ibNI3e6YZR3IDZVsnQc1RAc=;
        b=oT92BkadAWfS/EXIi3gw0X9wPjnv4xtI/5olo1fVJl31ZZJ4gemPg5wFGidMkzu29S
         zQFgaOQ/3Vj6P2QjsNutflhIAQCMsc4dN0Oj77LSqOQQj3XBZ8loijfVBz0mfkshZf9u
         yjpvIbn/Rz6fdIjbdvtebIi7BzCk7atD64Emg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266826; x=1722871626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdJePI/ro3lzopvsSRF6ibNI3e6YZR3IDZVsnQc1RAc=;
        b=wEVF/BrzVowVntFLwWeeo/ORyZx2KhSl9eayJcV/LoYfyrcjKVaZoUVSJk2rnGp8uD
         3/RIHu6pfshhAFn+FG7taLNhHP5Xb5xkbq0pdEtfVRXAfN4UZo/H7FULkif+rMAl6jmg
         AbPPkTlWIdKHt3RThlsNbiYh7DZT2UORMjxf1dBQgxvkNy7HYv7jSUOlaY/mnz6XLHeG
         G2reJYxZIza4CQScl5C+3onpfMWzbfJVAmKfY57c2+xiFwcCNfl55NnvZbi75ARKCyrB
         jQAOhO6ltbIFG6qSZgh0MLpVt1eJu3+Jh8DL2Looyk3gi9eShKH+/Bw7RK/OduJj5Jt2
         bcWw==
X-Forwarded-Encrypted: i=1; AJvYcCWVVcB/tWNAo5IXBS2F3BqvqiYG4MpxZbnXHCrs857JtYxKFvQZULT6OFZ+Ldpgkp8HdT2/NjFIUaAjkjRMAD1x1CtQ+Y8C
X-Gm-Message-State: AOJu0YwLc0rBDCXKGG0m37yEJ5opfNpVQepFZstnUNq0jYL2ttczWWCI
	qHttWD43T82gz7MAgArneGE2Uz94KQy4+77OmFoOiCbCFToJWSHlujZPZR/0Pgw=
X-Google-Smtp-Source: AGHT+IG0a1j3+SwbSmvGiaJIJjPIa0q+99nCgL0bnnDAjSn1qKIpbm+DTpKgqIsAoP+zXIujRWMPqQ==
X-Received: by 2002:a05:6a21:3948:b0:1c4:9e5f:c645 with SMTP id adf61e73a8af0-1c4a13a36eamr5586175637.40.1722266826625;
        Mon, 29 Jul 2024 08:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7115a1sm6947079b3a.46.2024.07.29.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:27:06 -0700 (PDT)
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
Subject: [PATCH net-next] net: wangxun: use net_prefetch to simplify logic
Date: Mon, 29 Jul 2024 15:26:47 +0000
Message-Id: <20240729152651.258713-1-jdamato@fastly.com>
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


