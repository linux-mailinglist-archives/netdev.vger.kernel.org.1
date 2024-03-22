Return-Path: <netdev+bounces-81191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F18867F8
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECD51F24A2B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859E168C4;
	Fri, 22 Mar 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F5rugNfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771815AD0
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095139; cv=none; b=o2uCeRalx/5P5TZLDzxEXdjQqK6Kp4+D/2A4gIBgTVB1ArmfXOaRNPGQNYm3WyRwoNTocVj8gpZe93pU+JNs+JwvYbNTZQ4Y9akMhXZsVWkrtfKZ0YvfjM0feGa7BPpkxB2KRvJteD7g+8SsngLj2oNma7gQIk8j5XlLVt1qqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095139; c=relaxed/simple;
	bh=ivrKR3c2yrx+TAFw2cfDxTCtqgTJZscBsq54XinDahU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7cF+CS+W4TyFgkN6jM2gEDmKnjwQl6Q78pHqB+grNIueGOZr1aKUFgNoRse0E00Gn+QjzgqMIZkB88wQ1lze/Qg7CWJYL43XWtJko/ZzWoTOY6VPWUNnVkAVvu7ejO4AZ1luITMUDiL71WjRMIDAkEQS3fh/PQVT32KTCz3CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F5rugNfB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46dec5d00cso243570366b.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711095130; x=1711699930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=orQ+kTTgYXFq7/84FuSFNVkBg+D5zotcWuI9vXxShX4=;
        b=F5rugNfB/Be1oDxO9IS6vcVoIKn+pvxvTJqm+1Auox6LzuqCGFkDqu4dnR6n3vtq3n
         cGVn7+3gL46KX1pmMrbSzYwhpFADA5sy3n8hzLZF+Z1ZGZ7AHt2a42bE93ef2bt5Mei3
         6X0bOI/iDanzX0SERPSr/EFI+DZimhCuzyHcX2Xut6FAtkQfcLSAGIogIyRZL92hrqEu
         X3rbvDDL5+sUn1BnunncXrrsjJqw0wlnwsBb/n124nmgtEMC9pVKalO2oH8USToRyHyU
         y0J15gHMJ4WgPHRoRzei2Koj0EsmJeTh8tdDmMlVAB+oDYPm0FlXvG0NNGJssoxGhTRP
         wrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095130; x=1711699930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orQ+kTTgYXFq7/84FuSFNVkBg+D5zotcWuI9vXxShX4=;
        b=PD+OA2NauiI7FwfkMS9dPBF0O1zXDk4SEgpGYAgKuqfEOR0NBV8BJEIZyV0ZxmcW6G
         rStkSBdHDbhKSd5KfdOxpG1Z2YBzF7uZ73pLIf5bd8PtGZRQy5UZLDO50D9HF0ltpeYK
         +y+At71wp/YvQogia9wO+jRnsjZ1QKNlLqwQh2nTSJFRdrbXsuTkomwVv5r6RG1zDrDR
         MtE5PbeKuOLoCttcQHGskJjiWG9aKUJ504XRgkrpYVlK97TXDjFA7AJ19aetSb7yfeWB
         vbTO+Gr0VMVA1nYXQpjMBZiG457dT4q254Tr4xND9rZc/ThO9ym5jvklJIW/vJ5VMHrG
         fqNA==
X-Gm-Message-State: AOJu0YwFL5JQp/88S7VDJTCk/nsSoFuSBbRVyeROOkrt6nl4lRRu6+0j
	JbyCm4dQXxTPoJdu0PHuKrYxZig5R4FQ8YflICECb1IAuy3K6nHMP2ifTmJCVtY=
X-Google-Smtp-Source: AGHT+IGQfJru2fl3m+mcsV20FmlKDoy3tTnSnJppqCJjxRQ8PQ8D+Bb7DBo/VOC3IX9WWVoXYI20pQ==
X-Received: by 2002:a17:906:b54:b0:a47:3336:faaf with SMTP id v20-20020a1709060b5400b00a473336faafmr404598ejg.2.1711095129963;
        Fri, 22 Mar 2024 01:12:09 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906b29000b00a4503a78dd5sm769485ejz.17.2024.03.22.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:12:09 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:12:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
	andrew@lunn.ch, wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org, michal.kubiak@intel.com
Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <Zf09VnR2YI_WOchd@nanopsycho>
References: <20240322080416.470517-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322080416.470517-1-duanqiangwen@net-swift.com>

Fri, Mar 22, 2024 at 09:04:16AM CET, duanqiangwen@net-swift.com wrote:
>txgbe clkdev shortened clk_name, so i2c_dev info_name
>also need to shorten. Otherwise, i2c_dev cannot initialize
>clock.
>
>Change log:
>v4-v5: address comments:
>	Jiri Pirko:
>	Well, since it is used in txgbe_phy.c, it should be probably
>	rather defined locally in txgbe_phy.c.

Did you read Florian's comment? Please do.

pw-bot: cr


>v3->v4: address comments:
>	Jakub Kicinski:
>	No empty lines between Fixes and Signed-off... please.
>v2->v3: address comments:
>	Jiawen Wu:
>	Please add the define in txgbe_type.h
>
>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
>---
> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>index 5b5d5e4310d1..2fa511227eac 100644
>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>@@ -20,6 +20,8 @@
> #include "txgbe_phy.h"
> #include "txgbe_hw.h"
> 
>+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
>+
> static int txgbe_swnodes_register(struct txgbe *txgbe)
> {
> 	struct txgbe_nodes *nodes = &txgbe->nodes;
>@@ -571,8 +573,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
> 	char clk_name[32];
> 	struct clk *clk;
> 
>-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
>-		 pci_dev_id(pdev));
>+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
>+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
> 
> 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
> 	if (IS_ERR(clk))
>@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
> 
> 	info.parent = &pdev->dev;
> 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
>-	info.name = "i2c_designware";
>+	info.name = TXGBE_I2C_CLK_DEV_NAME;
> 	info.id = pci_dev_id(pdev);
> 
> 	info.res = &DEFINE_RES_IRQ(pdev->irq);
>-- 
>2.27.0
>
>

