Return-Path: <netdev+bounces-161191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B143EA1DD3B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE57A1886114
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04664194094;
	Mon, 27 Jan 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyM+y+i1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688519343B
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008874; cv=none; b=A4mOiSvVR4i8a1yLTXvbZS5FG6s+nHEI0VcXtv1DUYXSUr+nCaV4FGNHA48UlnLFaPKG4rnx5Vqw3h1N8JGUeicocnt4UQVphl34MKv7fwtWRHRmGmNdtiy0vXSTGyyr/lxRvHV1NRRWbcZRYURoMKZ0izxOYaTVdAIVolezQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008874; c=relaxed/simple;
	bh=w+SqDRrRZyCxFoov4GbIq3hUU9UtjnMRMOunQ1eYWjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkoJkfU9opUnRBJ6YP+SyNObmSKHR5fOCHyqNHvgMjo/IgaKv0KpYDYGLeh02snp+hPj9isxS8uLbwbFU4kWc2VVplvWnTjkyDPXQPpQOXKRK1dtidzzWccw7TodnHBcdxrDVjvXlk3EKwnrS5niibYC0Xeg10agJWUT25ixFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyM+y+i1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436a03197b2so32647415e9.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 12:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738008871; x=1738613671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WajaT6WtU1ZggTmFqWfF6WcUuIeALU8K0AkiarUcnC8=;
        b=IyM+y+i1CVfhBcG/Cs7HzgdnCQz04O7q9vmIsYmuSkWxyeoAWq5nygQj54c8SUibRQ
         HULSRVyZegHYX1B+f6w60PwVzRn+n4niUYpuGtxHr9bS8v2ug+CBVuEBuR/WVR9pviqz
         3BmzWW/gUbIT2iBCUAzfRlJo9pkaz3JAt2AqW0Ggj1FeH4D6mXr0AzINLEjnvOK6hmZH
         ZAlaYSoM+qOn+W7WLZ5H0zuh7ba3vFtmGe5iyX+cVMuw6A8JCnvV4Qrc+di53ZDdo83O
         jyf2qkS4ANJkr7W6lLu86VLefwIIMwy2RCXqifHLD+PZil1A5HZfl0UOkYb4ZKxIWB6h
         pOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738008871; x=1738613671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WajaT6WtU1ZggTmFqWfF6WcUuIeALU8K0AkiarUcnC8=;
        b=NYjXOAtlUfk43Yf7sIW/gpWGAJtHF0IbYJ7EKKKvNipNdzcYDQa5GbHuuxRQ7cu13F
         nIeyC07Zb39jwt3WyTiL+qUjt8RPCwB+59PgnNHJ4oIkZva9zprXuqaGdfPNQgNhZbSH
         QI5H2yu1A0kuUYClGIPg2DKUBcLAevAfx2LU7fnH79FeQiIVKoVJ2wD8yAd6nbofpVw7
         QQycdaEr9dnZTPKkcH6UImyRiJjwKsAn+WKRP0mhxfjNJD2Jp67OsdhJg1qFhu8kVISN
         1H9ke1BlFlSylsXqL/BMfDIkpPmShH/gtqfzm9a/8v5Pa6vwRk+lhB3UDfuMld2uomoC
         h1lA==
X-Gm-Message-State: AOJu0YwKv1eDw1IUfDkq3YqDrf93RiKy7AOzrx02Iz7IqXAml3bxvdfJ
	GJLnIwlg+b4MB6puCExtWrqpL9Tr+He53iijD6qBXx2C1KMzuWVboRM6OW2QYsA=
X-Gm-Gg: ASbGncsLNVbpvSXbEVHSIKXZrHAdOKwVZ595KkB+B2GpSv6TM459EB1lrYcDQ/fTOGZ
	an/ViEVUw4nTkMYkQpzvy2QPnR+Nd26+ptB7PD3nP/uO71KSudRNrjzuCQ9BS+enDKDLUIaNMDt
	ScZWOjmJ2OM6+EWga9wdPghk84M9ZzVm3O0GsJnM+hFhd4mI9X7EDgI2Jf+BwO+uRRg6aS5lKn4
	5t9P25gxbY7TRr+VI8Wzs+NNFXhv5R1OKVGO25ngvXfOEF9Opcsv0JO8dfM7TdBcECvoxWEdvcK
	NTH9Xw1L+u3uFAkz
X-Google-Smtp-Source: AGHT+IEOx1y/V6lmijy/rMxJd1d7hhNEMN/d18v9ZW8NjDop199Bc5il268J3BEHXBdZvZJzE+Lntw==
X-Received: by 2002:a05:600c:310a:b0:434:e9ee:c1e with SMTP id 5b1f17b1804b1-4389144ee14mr419263325e9.31.1738008871102;
        Mon, 27 Jan 2025 12:14:31 -0800 (PST)
Received: from localhost.localdomain ([37.41.34.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b179315fsm110402135e9.2.2025.01.27.12.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 12:14:30 -0800 (PST)
From: Abdullah <asharji1828@gmail.com>
To: syzkaller-bugs@googlegroups.com
Cc: netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	Abdullah <asharji1828@gmail.com>
Subject: [PATCH] net/smc: Fix traversal in __pnet_find_base_ndev
Date: Tue, 28 Jan 2025 00:14:08 +0400
Message-ID: <20250127201408.14869-1-asharji1828@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67973cd8.050a0220.2eae65.0043.GAE@google.com>
References: <67973cd8.050a0220.2eae65.0043.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch improves the robustness of the function __pnet_find_base_ndev
by:
1. Adding input validation for a NULL `ndev` pointer.
2. Ensuring the function exits gracefully if `netdev_lower_get_next`
   returns NULL during traversal.
3. Clarifying the function’s purpose with proper documentation.
4. Removing the redundant `lower = lower->next` statement, which caused
   traversal to skip levels or go beyond the logic intended, potentially
   leading to invalid memory access.

The function now safely traverses the adjacency list of a network
device to find the lowest-level (base) device in the hierarchy.

Signed-off-by: Abdullah AlSharji <asharji1828@gmail.com>
---
 net/smc/smc_pnet.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 716808f374a8..8adcf6a97d30 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -920,6 +920,18 @@ void smc_pnet_exit(void)
 
 static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
 {
+	/**
+	 *  __pnet_find_base_ndev - Find the base network device in a hierarchy.
+	 * ndev: Pointer to the starting network device.
+	 * 
+	 * This function traverses the adjacency list of a network device,
+	 * to find the lowest-level (base) network device in the hierarchy.
+	 * 
+	 */
+
+	if (!ndev) 
+        return NULL;
+
 	int i, nest_lvl;
 
 	ASSERT_RTNL();
@@ -929,9 +941,9 @@ static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
 
 		if (list_empty(lower))
 			break;
-		lower = lower->next;
 		ndev = netdev_lower_get_next(ndev, &lower);
 	}
+	
 	return ndev;
 }
 
-- 
2.43.0


