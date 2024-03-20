Return-Path: <netdev+bounces-80807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658CA881226
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AED1F241D7
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD34086C;
	Wed, 20 Mar 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dwQc1A09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1055405CE
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940477; cv=none; b=fcpxzZIWh0B1MlnRqcE64IncR+7H3KlIN7lNorgPpt2Zw5bqanl1kYjDquaAvxuMMwV/9E5F0HxkFNzbYr9RlYk8wLBXVeWopX4osV+tnWYkO1LtGAksJVzc291BjOaCsGHFQiXLUfJkrKtLJxfVROMkD0ak/VxgGQshIjFs2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940477; c=relaxed/simple;
	bh=k36oIKP39CpsxgiQ/eTHltpqwgY6REUtN5R0EZzsBVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dytWvoaX+3FQQNxfJ+NjisrxBMuUujrAISU6MZsXYFdQ6Z1OUW/69fci7Y17Nfg711Y0Vo3y4fZltPH+11b6gfkx1x6Js9BkatRjvpEaWOD3g1t2BX+2dh2srX3E4Hnj6ZukFrycmphLbX65kPr4fb2JLDLDDQnWryZ2vVY48bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dwQc1A09; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so3992547f8f.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710940470; x=1711545270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nNuDU5nlSrtLB5LPk3Tj0tFJx5XQ3QLP4luheTQLJI=;
        b=dwQc1A09Q5PoM3K9VlUwXrlILTz6p81hco1/XLgAaptKSQ4vDDpFAfD+M3UOLgu7LG
         mzx7rdbOd0vevNN9uWbkyrWnLHQpugottAIz7ACCKZrz2uVlluRs4VBF2Hv7TXpCLUau
         grYSDZ9X5diiMHzsuRObFCFAnzUrdS4z2BSVDfSXcb1BgitNQiprCk1dEzNELoQyrYHe
         TUjFNOVtb/YOr3QIXrgP/WVqyokjGIMTBz0abg+eI/5LF5fM6OwbWwZpt1PFYZh2HslQ
         1D/1b/5P7L3AOCuxULP70ovdQ/bBzohNAKq8ENZ9IK01tPL1Yb1pRmKE7HBAi2LJa+OC
         ojjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940470; x=1711545270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nNuDU5nlSrtLB5LPk3Tj0tFJx5XQ3QLP4luheTQLJI=;
        b=fsb80rH0FX06BPyA9wF9J2a+CVuOm+AFh8Wl34UVRNk5UYGwaqb/JfiXYAJ4v2x/ff
         DZEBzJm12V8KNvdTeD4vA46vuzEvS13zExIHrpXUztP3BtclaLybMCP/TZKDRuloWv04
         0UpvuXMNrNOQuwqaGP/WKtYBXq4p068/ECduxFsm+xI7dpVhupvX9JEi0UpkCLPpgn7Q
         lucxr3UbR3iK/u2V2jxu+NxAP4YlFaG3ZWQvjIAtIvrQUq4gwZiJJLM/2iy85s+6xKSl
         F7Wa+lHriiZzeZ8fyvFLm149gmMb6U//gGf+S/jZkLVna3a6FzNsTD22v4qAt3LN48UU
         AQZg==
X-Gm-Message-State: AOJu0YzL9gLYqqMnEekLftYxiszuFVeEs0sg9V7SVtkLXGt2Ka6++yTB
	+7MMhxHTaSOyc0ReGnhj2j2Trpl1p/g9HE31sjX7CJZDCk84Lql1S/+oDSK+O38=
X-Google-Smtp-Source: AGHT+IF2UpSlY6hiU94UBCh0qhZy2K4075VDHeDZPiOACOxnLzNaLMvr+SbPxVKcrC9cR3lUrd5ADw==
X-Received: by 2002:a5d:51c3:0:b0:33e:c03e:62 with SMTP id n3-20020a5d51c3000000b0033ec03e0062mr12123762wrv.40.1710940469761;
        Wed, 20 Mar 2024 06:14:29 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4002000000b0033e93e00f68sm14673926wrp.61.2024.03.20.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:14:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:14:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
	andrew@lunn.ch, wangxiongfeng2@huawei.com
Subject: Re: [PATCH net] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <ZfrhNFPYjBsMrbbl@nanopsycho>
References: <20240320032224.326541-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320032224.326541-1-duanqiangwen@net-swift.com>

Wed, Mar 20, 2024 at 04:22:24AM CET, duanqiangwen@net-swift.com wrote:
>txgbe clkdev shortened clk_name, so i2c_dev info_name
>also need to shorten. Otherwise, i2c_dev cannot initialize
>clock.
>
>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
>
>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
>---
> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>index 5b5d5e4310d1..84d04e231b88 100644
>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>@@ -634,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
> 
> 	info.parent = &pdev->dev;
> 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
>-	info.name = "i2c_designware";
>+	info.name = "i2c_dw";

Perhaps this is very good reason to have this string in a define?


> 	info.id = pci_dev_id(pdev);
> 
> 	info.res = &DEFINE_RES_IRQ(pdev->irq);
>-- 
>2.27.0
>
>

