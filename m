Return-Path: <netdev+bounces-179865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E98A7EC81
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E8A16BFC3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA393266585;
	Mon,  7 Apr 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl9VagG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C22571DB;
	Mon,  7 Apr 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051805; cv=none; b=EthEfJz5tBzy9Yg/FAHyIhTQRFmNuHgyjZ1xhAd2tfG18GYbQKsHNB5pIQPB8suSeRF02L3glcgiCBykxQzM2teacJEU2bxAMTYu/AnJJTkX915hULGu4Z+kGdF9E6CakkHD/H8EsaZt6YQyg7RtPdlR4E/5k7PE4o0IhUZnhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051805; c=relaxed/simple;
	bh=0egWkzTgSUyhVRoGXXRc0dvaqLFx4WY4IaGlXhbh6tY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9OnvQP8rGvtVFOTKj585RaDJckCp98MmmGWpF6qw16WEWlqu37zjDYn7aLXI/behIAw7HdfDaUQ2IMzqQ1ETHmXIpQjuTKIO0GvzWtWkvSKlVOOl/0WaFQ2ybAYuPij32/PingVOdXWwpqiuKsbNwIFECcJBFk68KE8OuMa/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl9VagG/; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c53c6c28c4so78415485a.2;
        Mon, 07 Apr 2025 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744051803; x=1744656603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOrfUNYhnWGj2wJCTA4mSbcT6dXcds2rkO9aXll3jIA=;
        b=fl9VagG/bGnUgbV2DWQDQgcJBkJoCOy3UQAkvG0eDQYt//CAV7NJpTUxYVZD97EgZh
         DO2HP1fxzQUQVUIXBeeTnwsv6nPYGS06FpY3/YzBmu4I9InSj0X+3P59PzenSQCK3Qw7
         i5WfE0+zaMVSNMOm/2xs5uJkQw9skbKJNP/YTxl2XaDvs0+UcmwKoVF7XNbrnf37mdeB
         QLyZWMoWmoyo4uVEPLqLRjJCSMM9erPawREAwdYxS6qPXz/Ap3LJLUgyeg05VDyy85A4
         kPITtlpvtEvImF5cXfM1Rrnn5sjmEjmcz/l4hPX0sZjz+WuQl/3YKZv+sNvPb+6B9ejP
         kUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051803; x=1744656603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOrfUNYhnWGj2wJCTA4mSbcT6dXcds2rkO9aXll3jIA=;
        b=jlFtX119elhjcANLpXH23q6aPLHrMf7zFHaiBBdF4n2elsMCT1plu5pxSkg74wh8Sx
         V10loGCQqlyfXkXMMVv0rNrL+JLlJftwye9kjtyjkvQcYALB+2UCsbrj+oECScO//FYY
         ErdAzYRmFjTCqklVM2L0czJt1LG9C17f9P/36RGh1uI5ebQs76NWqbry3DI5gjGOuLy+
         pKeiJ/VMraBngYdLbDl+ZljUaCsTWB90+/1PYk+RmLI299Z9vbLNN8p0qHVZ364xp6u0
         V56eKmS22VYeRHB1EGNmMwK7RT40tHbUGVtnmHCMZaBQzLMQFu76WxPMa7CNhFKEZQOD
         kWWg==
X-Forwarded-Encrypted: i=1; AJvYcCXIc9YVUcBCw8fmhak0eAQWZpuwdyPq9QWymMk2SAgl3Kvlf+aIz6uEmGmnXbzd0M51j0Y46R5G9k42uF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Fv3yD1o9x6yS0zOa6R7KN/H0s1aupAX4JyulQIyRznMn1woC
	KuYLn/V7YmkUMbknF7uVZuG3Ml0AMFA0E1hjNp+HP/9mxcbA1Vc=
X-Gm-Gg: ASbGncui8Sy22RlSE0hT/4NLAtwXJNx0eSMvHwSK3bkEbbNtEf6HfmuaxMonEZbXOx6
	bh1zq9najDkixCKFtQ0ZO90kSm2p8B+i/4RQkKw/VZ7MHB3Yj9BXIc0TqvdzmBoIQA5gidxbvO/
	WZJX6UhbbygZImBL642uIzRnb1l0mgiBHUgdzv5veMhtIDdJ72rqFwiz/i41Mb0Gu6tA7Ifruii
	ndG8u7KcfOF/LI41eev8WdAZDtcDlZQ7XnDatCqGowUbTDslzq6REe8GnHyfKEQfIuT/NrCdDU2
	WAyksiQBRxHby/9i9PXViZiQ0tuE0N6mXyoEzNiCrg==
X-Google-Smtp-Source: AGHT+IG237pug4JywPTP+MwtOE/dFhBqIYCfRWFpKUqbGC4CD2cEXXXpTMVTc/uujxY45g1+tB81sQ==
X-Received: by 2002:a05:620a:2849:b0:7c3:e1ef:e44d with SMTP id af79cd13be357-7c774bedaf6mr688584685a.0.1744051802972;
        Mon, 07 Apr 2025 11:50:02 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea587c2sm634818185a.81.2025.04.07.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:50:02 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	duanqiangwen@net-swift.com,
	dlemoal@kernel.org,
	jdamato@fastly.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH v2] net: libwx: handle page_pool_dev_alloc_pages error
Date: Mon,  7 Apr 2025 13:49:52 -0500
Message-Id: <20250407184952.2111299-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_dev_alloc_pages could return NULL. There was a WARN_ON(!page)
but it would still proceed to use the NULL pointer and then crash.

This is similar to commit 001ba0902046
("net: fec: handle page_pool_dev_alloc_pages error").

This is found by our static analysis tool KNighter.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 00b0b318df27..d567443b1b20 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -310,7 +310,8 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 		return true;
 
 	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
-	WARN_ON(!page);
+	if (unlikely(!page))
+		return false;
 	dma = page_pool_get_dma_addr(page);
 
 	bi->page_dma = dma;
-- 
2.34.1


