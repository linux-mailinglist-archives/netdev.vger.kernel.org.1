Return-Path: <netdev+bounces-125793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D496E9A5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE2B1C23450
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE0674BF5;
	Fri,  6 Sep 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8/biv6i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104354E1B3;
	Fri,  6 Sep 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602417; cv=none; b=RBEevg3LzSold4hgQImEIKbzDfvc8wdib6aOPb37H0usr5p69PpjBBncbNykYpXSjt3rvCLbK61xH9v3C5rYi51ZqwAgXALWc5Xy1Iw19kQfE1wFocpl31wvq9hEsBhOZ7cy3VG/sVnBD032V3k2yRlHOPlW3LFxPn6pS9/igNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602417; c=relaxed/simple;
	bh=EnRN4nX4lupNbivR88Ar1U9N7NRH5bDlZaYIoAnfVS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4vTBuDhPbwkV4fmVMlNpPHxeYPpVvTGta3AL8pGpUAwxeYGYK6Oc9sZQPhUmZZIdBVDedl4EwoTRrQJTZ3wVrWbWzdnnCLsKNjS7Zcx+jAJZkwL/67D8aJBqpgDEZZ/qUl216+A/NrsWTFhxCiFdEos+rVARSyScNtmU5CpN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8/biv6i; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d5119d6fedso701351a12.0;
        Thu, 05 Sep 2024 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725602415; x=1726207215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpcpbxoJTaOMVxxiS+ey5NZ2Ihy9N2jS9ng2J6eDOcU=;
        b=X8/biv6imIuCDrrNb5m1SeT+xX8fOOy0iE+pasu2hkt38fvAblJT/VXuaxvUSD9LGA
         m6ycaUWMM4gQo8SIQ3g/p9b1E1Z2b65wXrLAX9eoAvMpVVimlAut+20ybDPBzxd6XTUB
         gzUN0FXLe6FOKuCJHlGcD41r9LxdknA9KcLqLvS9ONvS1OLRJVPp8tPS8Y0XkGwCmnr7
         BnX+t7Ejq4LfhtVtsQXHIEICl9vAgxZ1Zckob0/kGhaqav+6boe8QRIQVd50GDIwlaqo
         YM+BbM9+oHMuUNWU/Xh/TBRgGR+8V8o6KrIp3JE31eEHYBBPCd5230vjGYWTxqjhOifK
         0QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725602415; x=1726207215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpcpbxoJTaOMVxxiS+ey5NZ2Ihy9N2jS9ng2J6eDOcU=;
        b=TdwNu+p2xOxKJe2x6P1AtisU+wExPHdHOnMklhetAfmDAtbYLlxSJDGObAXGpRjydR
         kizBetG5LK5Vf1WKXf9tlkKxylb6P5fk3ZuXYGpCSxo69lg23/dvNm9vOLQm0vxwlX5D
         Nu1NkFAXwq6Y+7H/Ozy3w2hBWpGobrlYEPsmCRdxbWKNuqUXRit9z8sXD+fmkwVtj7al
         e9g5X211JNJnBm7N8QnL4FVIDhKGNdOQi9lsAc1oYicDYxtsOFE8VFjWnsQHfa+Nmaaj
         ahlW9Bpw6y0ZXf2b6FUdqWLM4lp9jDOTWVWOGBv4W5ARZRAkHAYvZQXo0l7fbTirqGUW
         BSdg==
X-Forwarded-Encrypted: i=1; AJvYcCUTb0TufcOw+wZFKwxqUg9t7imvCV1t4igXbpyoQ0aqXO+LKRtiRSEud5lj6zZvtPosGoIBGS/NIqb07v8=@vger.kernel.org, AJvYcCWMk2nz9cVautZ74lGevqU4M8XzMv3+xwA4j4vwptf/91Ulb5aDWS7WjwkIWvnq4KUuz5UHpk8P@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlgH6+adf0gh5HbxNahAG3i6e0XT4QhaxsRQYDCYwy/BtN9j8
	NVkR7JWOEZojHns1jaAS8/v8B76AYyoNTD48uw/EUhk7GGG9O9sI
X-Google-Smtp-Source: AGHT+IEVlQ5pIIO2DTJ7spAd1xntv1DbKAmpeQJtRu6HvAQoNVxIS1MCSu9N53xu4LM055J6Lf5ppg==
X-Received: by 2002:a17:90a:c702:b0:2da:8b9f:5b74 with SMTP id 98e67ed59e1d1-2dad511c4b3mr2772269a91.13.1725602414675;
        Thu, 05 Sep 2024 23:00:14 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc083e85sm624823a91.40.2024.09.05.23.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:00:14 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] sfc: It's a small cleanup to use ERR_CAST() here.
Date: Fri,  6 Sep 2024 11:29:50 +0530
Message-Id: <20240906055950.729327-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/net/ethernet/sfc/tc_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index c44088424323..76d32641202b 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -249,7 +249,7 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
 					       &ctr->linkage,
 					       efx_tc_counter_id_ht_params);
 			kfree(ctr);
-			return (void *)cnt; /* it's an ERR_PTR */
+			return ERR_CAST(cnt); /* it's an ERR_PTR */
 		}
 		ctr->cnt = cnt;
 		refcount_set(&ctr->ref, 1);
-- 
2.34.1


