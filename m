Return-Path: <netdev+bounces-90172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2298ACF2C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECFF1F214FC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACEA1509B5;
	Mon, 22 Apr 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vYgUh1sN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E322625
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795543; cv=none; b=X+elU1yvS2ESaJEbH9FglpUJsLNYqO2c/6IbNwBKs3IdVtMiyLmWFDj1A7hqCvEOnPM+Kf/CmJKi+A5XrBvWwldgWfPeHmHzWM17NP0NYNBR+BLvSWNfRd3zv7rBqviBbVcYjp6Ub/y63dmXFY80EQ4bngF3R/k5jOcyL/LogH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795543; c=relaxed/simple;
	bh=AiuxBPh2cWOttXetfkOvjTeTNBefriCBNsLwGKfRSOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3m8KcQXhhtxNyGeIzd79yk3xCB/ArpyZYdlD3VrKuWZUqbYZS8PF8ndqNeNWpyyrhdQ0IPykhgfuMB1aHIrkvbpZUsK8vtrC0cJaxMA2+edB+JIihSpIuK2zrM6z1/PLyONyCyIk0i3ECm8X+Sk0ARoD/ZHNO3KUJ4HVHXsA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vYgUh1sN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a524ecaf215so454886166b.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713795540; x=1714400340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6x0t+W0EiSlEO0rKZIWSrQC6VoY+Vp+8NR6a2w/aIo=;
        b=vYgUh1sNPLm8Fu+aWEYgm85WK+PhCik4VXUucxqinDlheCGZYV3uX0xK6HqkIGUqoK
         5x2hqrhigSCSCaNsX/87Biy9RHfohMq0dygJpOTJUh0ZTae7G5HhJQ0YQtblIa/Qc5dG
         OVYoTb5KmJkyO+ytyAd3PI3V2lnv9+8IFZloNu5GGHPo3dCdwzyHWvxMocgfDG2ruM3E
         CNiXLVansQIiA6puQjRqCN0zis6xfiAmjnMh3FL8tFBfPs+18m/HF2p/hmx2Il/SfHeA
         E2+bKMPpx/8r/M0TLyQsMPB4oB4BIS817hNfD2gMez3otCkvucpqODbT8ewiaOvhrzUe
         C3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795540; x=1714400340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6x0t+W0EiSlEO0rKZIWSrQC6VoY+Vp+8NR6a2w/aIo=;
        b=kztaXpJsV0qXpF1XHAB+aQZ7veP3C/LeeeSoPzqcJGxRw5qpXbjkfTa8JextE62Ngu
         TNYi3T8RWtIUXqmtgZSlc8/kroE+B4RrHZZvkmo991w3SdVnnqP9KYn0wWz8nNyf9v41
         sXckB1uS8NTtZnf9qJ+2bSXOwbs/1T/gZP+uERkM/Dhn8GPumRb0pqvhycJVL8aNywYd
         DGEcNr9jWoMmK9nfIPkBa3b0YhZyDdECUkskIQGd577uAh8x3qTpswgXohRZEU8wGXt+
         bxlKX/1HPSewJJybyQPCPZRQQJ3S6X5FZ5Ln8Z1vGZmdcsAGr/nzntyN86j8oij8xt6k
         54Uw==
X-Forwarded-Encrypted: i=1; AJvYcCX3K2LSdHukep3Rt1qmsTbFl04Isz45Pnsqx7U6J5E1jdaG8ADmyNk0aY2L9rzKbpj3LWPFlu5qsbuP4mUD7mDV5PnwVzYg
X-Gm-Message-State: AOJu0Yzw+bv+X+vfNAjSqY9wluemIh3Y+T9dIHbkWNGbzt2HQDm7Dkye
	K+abupwBrjWH1nhMQv6c/7zXLHFGM2un3O0yEliukCFXi63w+1j7fiA1qzcjJzY=
X-Google-Smtp-Source: AGHT+IFb2r1Ao8A/J8LHWX/DDwptGf8gqwhSEuKkDRF+57W2nyzvfzT5B1bEOJm6YhGh1x6d/HEynw==
X-Received: by 2002:a17:906:c242:b0:a55:61cf:f859 with SMTP id bl2-20020a170906c24200b00a5561cff859mr5683751ejb.1.1713795539487;
        Mon, 22 Apr 2024 07:18:59 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id rn2-20020a170906d92200b00a55a67a81c8sm2278910ejb.126.2024.04.22.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:18:58 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:18:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 7/7] net: hns3: fix kernel crash when devlink reload
 during vf initialization
Message-ID: <ZiZx0E5NlSL7nuLE@nanopsycho>
References: <20240422134327.3160587-1-shaojijie@huawei.com>
 <20240422134327.3160587-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134327.3160587-8-shaojijie@huawei.com>

Mon, Apr 22, 2024 at 03:43:27PM CEST, shaojijie@huawei.com wrote:
>From: Yonglong Liu <liuyonglong@huawei.com>
>
>The devlink reload process will access the hardware resources,
>but the register operation is done before the hardware is initialized.
>So, processing the devlink reload during initialization may lead to kernel
>crash. This patch fixes this by taking devl_lock during initialization.
>
>Fixes: cd6242991d2e ("net: hns3: add support for registering devlink for VF")
>Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>---
> drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>index 08db8e84be4e..3ee41943d15f 100644
>--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>@@ -2849,6 +2849,8 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
> 	if (ret)
> 		goto err_devlink_init;
> 

Hmm, what if reload happens here? I think that you don't fix the issue,
rather just narrowing the race window.

Why don't you rather calle devlink_register at the end of this function?


Also, parallel to this patch, why don't you register devlink port of
flavour "virtual" for this VF?


>+	devl_lock(hdev->devlink);
>+
> 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
> 	if (ret)
> 		goto err_cmd_queue_init;
>@@ -2950,6 +2952,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
> 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
> 	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
> 
>+	devl_unlock(hdev->devlink);
> 	return 0;
> 
> err_config:
>@@ -2960,6 +2963,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
> err_cmd_init:
> 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
> err_cmd_queue_init:
>+	devl_unlock(hdev->devlink);
> 	hclgevf_devlink_uninit(hdev);
> err_devlink_init:
> 	hclgevf_pci_uninit(hdev);
>-- 
>2.30.0
>
>

