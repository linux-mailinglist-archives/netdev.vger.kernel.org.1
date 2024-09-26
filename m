Return-Path: <netdev+bounces-129925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4EC9870AE
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CF1F26978
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97D1ABECE;
	Thu, 26 Sep 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qxd8tN66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A61A76D7
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344253; cv=none; b=aSNzSXwPrvDyexOaWOMJ//O5ljPM9EaqXNEeQLVrlGuu2+0trOSRSy1Fk6Pno4dOhMHTui3KxZbEBn6JYtOEnXiOKd7ruNA+IVe6RyFCw4hhjA3W0u4Cw4Rj5LKOFD+1XG2UEgG8CgeFI/PL3r9LsRyWPxJ4sv0DwDY6o3r3eSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344253; c=relaxed/simple;
	bh=3cvkulumzJ6UdUrBeMHHDpezKdFQ0Akz+kdIuBNYxXw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uUz8lue9SPs8+T38dF3O0+oQZeLIHMB8K4WJt0GDUcn1rLRLUzsaDA9gXByv/bar0DCoK/30+rATDwKRRmEO6nm5GU+X+tHPfJLXii7uCkij6ibxuwPiCcA/4jCm2qZAeUKGQT+YPTrSeibCIxH89IlU23TQhKJFyyfy94q9SpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qxd8tN66; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so7385095e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727344250; x=1727949050; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiyN9NWxSHbtdh7dFvLb4E3Ssa1wgf9JiJ/fTzuLzmA=;
        b=Qxd8tN665nGhssp3zI9X6VQUF3IPVNAevegGHtgXdeuCgnS9J9UfFsIr3JFIGBYAN+
         PMMnGDiiSAGwxELvN8wBSrtSuQVSI10SfpUZuUOScylPLCCC8tEx1KR3QPyRv5Wq0e0E
         XkLaqyCJazOTKyYvyCEz+a/hJT1F7Up9Tdw/6t+l2Q5YCQnYkevyf6wEOVdhSJhvVbZe
         QCcOKGw5hdjRTt+Iiv0kICiFKyQpTMBkqhs2sIMhsJniqOq2w0nPzuHLKfnJhBZR3Jk5
         QC/8XRvST/3vykfmVD2TWp7X4KN8ixehRmFEdnf+kv5qhTqwfnkeLtEmFRDnopk//KHO
         HxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727344250; x=1727949050;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiyN9NWxSHbtdh7dFvLb4E3Ssa1wgf9JiJ/fTzuLzmA=;
        b=u1lKehdh0a0VLS8r5qrpjrq2OC0vLZVul+K55W6F12LxZpxKTy63VvnqQkB856vSDv
         DclcvuE6g5jsg3ONXZhfK/S/3/FkJ9QajONMb6FbDA3HsrUT3bcdPpngQBB1SfviQNfZ
         gXKUzI80uMoTI2AAY3RpbdZEaCxCa6y66mZEyitnnJJkil573lVlmIAH82J2Ix9drO2z
         l/llC9NmSAes/inTjCMzbWtqvhbuk2JaSNXTErCy2HqMJHcvqeOasYg+xC0fhJpryNtK
         Njj0/9z101YhgeT3eTzDKHLAZLMmej/5UNHeS/XiCehXoUxdHmXa3E6mVbGb1WkhPsXJ
         Hbmw==
X-Forwarded-Encrypted: i=1; AJvYcCUlMZsGZQCpehK+mC3fK6P1ndqijtqhwBn6tqVXmfGMUAHCrEax1iPyJNCQJCgp9wHbLQdSVBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/UV5wKXZE4fhVbnf7rdU5R9uMvoojnp66AYUtRKKpuNmhbrT
	nI1SIwTNO2PXUYmJauklcNnMIeGMNq4xQOUlO3jH620uIMT8xRNAtnYHKaj2fHk=
X-Google-Smtp-Source: AGHT+IFCLIBXqKbOosYLGD7dpaW2Fa6+GR8VForuOcP/Zs87zlTaweE53g2UooMLElMqWLL8yLKfjg==
X-Received: by 2002:a05:600c:548e:b0:42c:b95c:65b7 with SMTP id 5b1f17b1804b1-42e9610c908mr41002805e9.8.1727344250067;
        Thu, 26 Sep 2024 02:50:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddb85sm42060725e9.2.2024.09.26.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:50:49 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:50:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Julien Panis <jpanis@baylibre.com>,
	Chintan Vankar <c-vankar@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: ethernet: ti: am65-cpsw: Fix forever loop in
 cleanup code
Message-ID: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error handling has a typo.  It should i++ instead of i--.  In the
original code the error handling will loop until it crashes.

Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index cbe99017cbfa..d253727b160f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -763,7 +763,7 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
 
 fail_rx:
-	for (i = 0; i < common->rx_ch_num_flows; i--)
+	for (i = 0; i < common->rx_ch_num_flows; i++)
 		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
 					  am65_cpsw_nuss_rx_cleanup, 0);
 
-- 
2.45.2


