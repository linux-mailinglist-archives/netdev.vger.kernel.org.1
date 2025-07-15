Return-Path: <netdev+bounces-207285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E412B069A9
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5594E3A99
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B572D3EDD;
	Tue, 15 Jul 2025 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTcHzCPh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67F286D75
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620476; cv=none; b=t6bTREwZMxOruyJXYMGDpVaa9mP32mdOq0TGvoyIL7fdxyaNLQ3sD5Uy/V2oHX2j2S21XjwndzIL0uN/4CZhOJqVvw8Fmv759/p3UZNGAD3yGPhK4WAC6H41Uv3MwPP2Xqx26gId/MbtwTMsgVd9GF07sEsZLBx1Oi9eWuokVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620476; c=relaxed/simple;
	bh=u3Mpdz2pmtyGUWJnzrCAlKzTsLeej4d/Sc2BmFxp/a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i4kxtpRaaiG0JdcyG9DkxJxZmQXn9ibMvQls9qiJcV0GTdgBIcgVnHpytbbl7rP0f9gJdt46jYtwBPDVmrKDVN9WcEgUPfAha4g45FmnJlpP4czklpxocLTx4qsN2JvykTJ91xWntvb3bqCCuSw9/g56zbbJpoPJ2+/SRKEdnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NTcHzCPh; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2eacb421554so2283588fac.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620473; x=1753225273; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMxhWC+6DIUyTBowpY7tH1U7/VAQSY6aI1DyTbhk/6w=;
        b=NTcHzCPh/zGWicsn0r5425ojf/BhrwXqmJXOTQC5BA6rcF+l1iCtyLhHpYBM78IQGJ
         6Lndy/90f54PSSGAR17B+0sUcqtN8eiwTmUGEleJkVXGQv0Q/qDEiqcwyp1bziAhU4SD
         icTLRbKr3SoouFIFb9lXpE7xnB1ADBv5IlgbJfYcQrCZLlrsfOGnJrYl9pudfGJJZwXV
         6VP/POt7aClBHDBOaoQREtc9dVYqtyP7gTUzDGAdisl6ymeOkZo9raj0FRbTqZ9Nxdl4
         ugN2FHzUOYX9zdo2YeeePFbHI2Uh31JDRjSc5nHgHOnsg77+TbSggJxXFnJH+4HG1Y5u
         wq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620473; x=1753225273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMxhWC+6DIUyTBowpY7tH1U7/VAQSY6aI1DyTbhk/6w=;
        b=bozDC8S2eszTz77GbHpWQUmxlqt9Ixd4GGfcp1XhlgcjUmmXwx48/Fefc6/v99kkLi
         lqRq9XeyLD+7pwNXvkKcqYpi3VoDKDk0QvoRXmn4P3SMKlTBVdtD4yRCI1RZMDq+2G1P
         +3np3Iwx0W9r73KEE5B8knVZL4xrcu9mXDouQ2uYikqjHEFysSVZ5XTDVzjunAC3bsjx
         HAcixnnWMEKl37Yo2wT55tGxbmTp0NcbbQND3bqd51HfOUBdpzuHI8mw09RP131jjFu5
         Gn0YNalG0fhZbbf8nOo3tM83xCxZGjHyclxIcdVBtRqRzcDQ5O1H2lapk3UewXmgSSWX
         hoJA==
X-Forwarded-Encrypted: i=1; AJvYcCXYZThuP0j0KrgZ/IEhtztPxVqadihZb35MSat5TmLFGzuXq+9R1D948oMAZKtJIOAUJt0f+CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrggv82Rga/SKegpPRWM0dfgnw2CvWsn3293sa+tomfuml0uC9
	IB/lp+y0n1QNTCFcTF9LMuvPjVyuBF001tLb8kD3JQKfjy3IKZOtGjrpKgCp4ySq3FM=
X-Gm-Gg: ASbGncspfLcTSrPL1Lpai1V9IGNLTd4Zb0PxrDvggDqmLtkwPzRvsHVgWWPYnAz+ptw
	6BpvOeBplwoctefnJHgUUjZwuyx93u+gk7BTEYseXYkNRFd8nuiSEvCWzJfZSGZZo9e7CYWTfUj
	VYVISxO9mOYN2Z0OjzyTIR9Ltpn9f5PQ0f2UXVjkkUWCOhLKVb8DY9aytJDxGB8nTp++vq47Hqe
	DX+ckgVXBgynu3pSn5XPGx/HV7jozmOCN+EylFrpABvoiR8ShqqRwuoXHM7TE0AdQHP3xxdwgcc
	hghlU1HdKO+lUxWERulSjR5QsY0qEY2TaNWIH9t+z76p2YsxUTpsb0WMGKS8d1t7x4V+JRXSPCM
	HlEcbjxM4TGOYUbbnl5yWAKF6nH6Z
X-Google-Smtp-Source: AGHT+IEls5whNRzvN01o90WxbCX3ovBdPRxqs7+TUz1Rw8UbE0E1ggiOCz+d99TGSZRB8SxM8NuTEg==
X-Received: by 2002:a05:6870:d0c2:b0:2e8:eccb:fe1c with SMTP id 586e51a60fabf-2ffb24ae8c1mr586050fac.31.1752620472817;
        Tue, 15 Jul 2025 16:01:12 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff11686cc3sm2964968fac.27.2025.07.15.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:11 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:10 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: airoha: Fix a NULL vs IS_ERR() bug in
 airoha_npu_run_firmware()
Message-ID: <fc6d194e-6bf5-49ca-bc77-3fdfda62c434@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap_resource() function returns error pointers.  It never
returns NULL.  Update the check to match.

Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 4e8deb87f751..5b0f66e9cdae 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -179,8 +179,8 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 	}
 
 	addr = devm_ioremap_resource(dev, res);
-	if (!addr) {
-		ret = -ENOMEM;
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
 		goto out;
 	}
 
-- 
2.47.2


