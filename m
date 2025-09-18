Return-Path: <netdev+bounces-224342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA5B83E2B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F57B1C0083E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1A2F362B;
	Thu, 18 Sep 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpIaJive"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0534BA50
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188756; cv=none; b=lVYhrrhjVXXXvNKZzPI9+XgfTbup/49zN5qZ/smWUHiqnRY2odoW8X46LzXGGxp+OLkoWjK9UpPkT5jks1X+Dlhkc3PZpHPtqxBNAY9yMPax15VnwYhYOlXKDenNrDqFjKo3a8pmaaNYJVzoIi9OOGQCYHswTXEvagCN+o0i5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188756; c=relaxed/simple;
	bh=JoL6E2/9aXfXnQcGR6Zu0injdoly1JOaaGDXQAf0txc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mh8CW8KfiBU+xGkB0OMoUjxEGi0DpGGN3qUIrq+a6nSjDdO0bFTNPCbu/pJSorkwyFd3b2sGTknOZNSYGwCynVPFhfReb9gTamt1tkqRk2sjLemHXVZ6i4W47/aQEkS84R3EcfhQRyPS7vrCsO2DB7AOR8nwFh9kd708mZIYTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kpIaJive; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso5430865e9.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758188752; x=1758793552; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7IBogLcogZtqOzPSFPIn7J8AJq9IuoFrHlKGrmKVoeI=;
        b=kpIaJiveFjL9cP8DJTNPybUcDI+i0gd/iQV7B0nJuZKzeeEXOcWjAWcvF7gDXw/NC9
         sQh57aaiAKvjTixO4lTpag/AwR8gh197SE3yyYwH/xRJ5qJ/QVCQ8Q1Y+aEeJP5U2r5M
         yC9vzjdJurmmObp6WmywgFBl8MtHWBieU/D1gd3MfUD4OtQ3i3qDW04YwUNOs7DVAJJv
         hxV/ggOe3c6KVlLrNfFu9UTdR1LkcyL5pAP3XDLbSSE/W7IlUzGNx0IwTI7jBTtXiCI/
         h5ZEOYr5HzFPDHdBhK84H05Cpu+oLR43tYaNwqUonpJhpyOUta5NnlANu5qWyU+Gh03h
         5eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188752; x=1758793552;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IBogLcogZtqOzPSFPIn7J8AJq9IuoFrHlKGrmKVoeI=;
        b=PCNvYLrIkCY4PN4K7hrMgCzvaoMfB+Gw/KMTzyDj7MUFIkRmQh6acvsw9EnHy1GfFS
         gzflO3sGxZTRti33lG88il5xKuPd7HWUY3ohv42FQBuYr/OOWBqsPRQM5FCAZ+rHaaBd
         uZNm/Fi2i3bDHEawk6w49jiWoCtDxMIbaRORKGpBz3YcjZXuNbj+kCNH6uDdMWmEruvY
         eK/7DYhatWf2dXUJ39ExPYaS+Sz+X/aaiA3qahyq+YFCkXUI0tCyUQFYGahZ1R4C2GRM
         1jMATkz4Bdbyq/zLOSbBIMzJtgIFxAiKZhQpRWTcLeI0uJBsaHoK4F4fatwIO2LJyPpE
         9K7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCZxfxtNVznI8+G/ZQ9ZgzaAUCotQnAWTOtPfaQ37Ox2EpZwcgE6KM6sNj3TQ9dXz2BpkgKOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbm9VtlMoIC9xlw8bDvTSjBW72N3ZrBt+wfD5JVsMRPNt3yu7
	ANQb0/P2aJxIjn/ZIa8bKTiQulcU9aIytw3c2HLi3dWBPC8dSnmhDk+0tADVZjSQzMk=
X-Gm-Gg: ASbGncuq6YYL/0C1LjP1FyH2q3L51iQQ0hm2DwnH7zLaTrWh7Y5zWpDoONC2vRv6SCH
	JTJb29/8XR5NFylbwIYQtO0p5cSM5lTWSTk5S2ZbdvPaVLPSwiZfTpOANvpxNws1uQ9k/ScCGGJ
	KiRczLvBxU8Xs+8dVwqzw/tYxRgLmsH/P2sixGZ3ZxrPtUQxTrhcXUfyBnHw9ox9eBaj9pT+UoD
	8owOzUY2xz9ckg5ktHcP4WVAiVm3YbxXabp6KMCveairorzhfhmQ9iIBM7SXdMfUfo5GbGuMuDC
	AZfN939Nn+6Uu/FBKqOEcUPmmh/Ff8PBZ2jbcIO9iOgkIuKWqtJbOQ3+osyeq8Zsju22dMTRN9U
	+1FVZOo/qFEar1+SnbreeWBuPI8G7pGtBx1NMh1EkZcZEEw1OJG2Ze5+w
X-Google-Smtp-Source: AGHT+IHq3gu7gXUOtzXhMpgJNwrndnSsGHz+f4WtVJeNQ1ESDCp+aiPn30y5ccNPJPYcrqJVmUrWTg==
X-Received: by 2002:a05:600c:1d08:b0:45b:9a7b:66ba with SMTP id 5b1f17b1804b1-46202a0ee42mr49387965e9.14.1758188751408;
        Thu, 18 Sep 2025 02:45:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4613186e5c7sm83783115e9.0.2025.09.18.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:45:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:45:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] hinic3: Fix NULL vs IS_ERR() check in
 hinic3_alloc_rxqs_res()
Message-ID: <aMvUywhgbmO1kH3Z@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The page_pool_create() function never returns NULL, it returns
error pointers.  Update the check to match.

Fixes: 73f37a7e1993 ("hinic3: Queue pair resource initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 6cfe3bdd8ee5..16c00c3bb1ed 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -414,7 +414,7 @@ int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
 		pp_params.dma_dir = DMA_FROM_DEVICE;
 		pp_params.max_len = PAGE_SIZE;
 		rqres->page_pool = page_pool_create(&pp_params);
-		if (!rqres->page_pool) {
+		if (IS_ERR(rqres->page_pool)) {
 			netdev_err(netdev, "Failed to create rxq%d page pool\n",
 				   idx);
 			goto err_free_cqe;
-- 
2.51.0


