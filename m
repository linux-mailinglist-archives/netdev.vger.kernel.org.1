Return-Path: <netdev+bounces-81206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454EA8868C2
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0964288E95
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360B1CAA9;
	Fri, 22 Mar 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="umNMY7hg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028C1A291
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098141; cv=none; b=QC2LDCWUevH/Jo896yetrUf5PgWV5zxA/gC0tyUvMQhAEGYwypJNR65h4Q/AVzexOtPmQz1z23gMNfyaiO6p46ol/QhHwQ2Uio7lQDp8WpcBM5CoSQ/3vWnyT+zfNwV2Ef1va4W3VEmIzSXJnPeT956J1r7A74vMnynGNlaiNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098141; c=relaxed/simple;
	bh=5JeoQNR9VZ2cbl3FB3+5GV9iRalRWo99LgPPmVy+/vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL/GxyBfyN96vGPIFJbnOqUQzJU4FDivUKqQax5LfE691KSlJOW888tAsGIuNxGyOZEXaZ0IADSjeHyooTupCz47kCFGAnsGAW+hBPyAxlFZmo8IqUTWlshHK78VzS5RJ/FELwExLj1m+ruwcMiOZdbPNi3B/LUKt1KQ37b8pz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=umNMY7hg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513a08f2263so2025543e87.3
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711098134; x=1711702934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hUzf5nKXJcZoLD8MvnpqaQA7qM/nqL7Uk1I6CtEEXOg=;
        b=umNMY7hgrMYFIy22wbe09P2bxA5vMPHUMd/AiPPm1ZfwpRNGP1nLOFswsZHy602dW2
         INjkJeln1nWw7/qggkpUX6/2KVyGYv7zltHaC3K3aWsQ3Tv2s45O3EoklrYTu3wWqs1S
         HdiBGNz2vtApGZRdAS8HkvNd/fOr8Pnru0cPsluw8oVNRLoafFtwI2raGOOc0ryKYLae
         RTUAMKj0Zc/3Br/auZQNboHc7arzNxsjPszAyL/RFDINl3dO3TCYdIr2Ppa9keYamyPv
         gtaWlOwucmZFN/i7QMxS/LogGxfSqoeYpngc6crfK4H/ik1U/Uw4t9DHgEGW8rtTwiud
         LLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711098134; x=1711702934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUzf5nKXJcZoLD8MvnpqaQA7qM/nqL7Uk1I6CtEEXOg=;
        b=pf0k0BAxS/1ODTnJiBLJS4iYodo38ghlCj7MRUIOV9ovXPagPJ/BTU3CB7+nlzqKfX
         CwmryD9ZQN5vvKCTnnRs1pyK+z3H9sWJU5i64yP7okrgUGuG8XtpNstOXreY9TOq/sF8
         o6Dp8khh3GOH588zgIB3/DumZFP/laDv2VeROsgYjoyzbUqLQh2OTtN3JEVjs2Z25YNq
         o8mSp18OmgBS2Rvsw9MBW69qvRfCchBsjttdZa5EryBRU0eRzWVs16YqBhq2QcI5DHDx
         xB4gtebTGVFeyPkMU2F11HRVZznu/Ga3I5qZqKPjLuFnfqpYEsUToOXLWHtEvRkQyD0a
         2duA==
X-Gm-Message-State: AOJu0Ywt2DcgHoji0qn5Z6xeAYHB74+NePAeXpCL6u8KYG9t2ESxpnwQ
	2WmTb/IDTD1rTbYC7vGYi0Y4q0cPk105g7zKjuzgR4KvrM60atRZ2/MqiQqCIo4=
X-Google-Smtp-Source: AGHT+IHniU7CPbKzwOEhGuzwE8AwGzYsZ0G6mV+KCvG60Tzz4js77hfZDu3VTJ7rMBK/KS1DZSeZdQ==
X-Received: by 2002:a05:6512:44e:b0:515:92f5:e38c with SMTP id y14-20020a056512044e00b0051592f5e38cmr1165531lfk.50.1711098133310;
        Fri, 22 Mar 2024 02:02:13 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033e756ed840sm1581249wrb.47.2024.03.22.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:02:12 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:02:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: duanqiangwen@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
	andrew@lunn.ch, wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org, michal.kubiak@intel.com
Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <Zf1JEfIq1E1SHiBD@nanopsycho>
References: <20240322080416.470517-1-duanqiangwen@net-swift.com>
 <Zf09VnR2YI_WOchd@nanopsycho>
 <000001da7c31$be2330f0$3a6992d0$@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001da7c31$be2330f0$3a6992d0$@net-swift.com>

Fri, Mar 22, 2024 at 09:20:04AM CET, duanqiangwen@net-swift.com wrote:
>
>-----Original Message-----
>From: Jiri Pirko <jiri@resnulli.us> 
>Sent: 2024年3月22日 16:12
>To: Duanqiang Wen <duanqiangwen@net-swift.com>
>Cc: netdev@vger.kernel.org; jiawenwu@trustnetic.com;
>mengyuanlou@net-swift.com; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; maciej.fijalkowski@intel.com;
>andrew@lunn.ch; wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org;
>michal.kubiak@intel.com
>Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
>
>Fri, Mar 22, 2024 at 09:04:16AM CET, duanqiangwen@net-swift.com wrote:
>>txgbe clkdev shortened clk_name, so i2c_dev info_name also need to 
>>shorten. Otherwise, i2c_dev cannot initialize clock.
>>
>>Change log:
>>v4-v5: address comments:
>>	Jiri Pirko:
>>	Well, since it is used in txgbe_phy.c, it should be probably
>>	rather defined locally in txgbe_phy.c.
>
>Did you read Florian's comment? Please do.
>
>pw-bot: cr
>--------
>I replied to Florian: 
>" I want to shorten "i2c_desginware" to "i2c_dw" in txgbe driver, so other
>drivers
>which use "i2c_designware" need another patch to use a define. "
>
>Sorry, this email forgot to cc the mailing list.

Could you please use some sane email client that properly prefixes the
original text by ">"?


>
>>v3->v4: address comments:
>>	Jakub Kicinski:
>>	No empty lines between Fixes and Signed-off... please.
>>v2->v3: address comments:
>>	Jiawen Wu:
>>	Please add the define in txgbe_type.h
>>
>>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID 
>>limits")
>>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
>>---
>> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>
>>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c 
>>b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>>index 5b5d5e4310d1..2fa511227eac 100644
>>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>>@@ -20,6 +20,8 @@
>> #include "txgbe_phy.h"
>> #include "txgbe_hw.h"
>> 
>>+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
>>+
>> static int txgbe_swnodes_register(struct txgbe *txgbe)  {
>> 	struct txgbe_nodes *nodes = &txgbe->nodes; @@ -571,8 +573,8 @@
>static 
>>int txgbe_clock_register(struct txgbe *txgbe)
>> 	char clk_name[32];
>> 	struct clk *clk;
>> 
>>-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
>>-		 pci_dev_id(pdev));
>>+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
>>+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
>> 
>> 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
>> 	if (IS_ERR(clk))
>>@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
>> 
>> 	info.parent = &pdev->dev;
>> 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
>>-	info.name = "i2c_designware";
>>+	info.name = TXGBE_I2C_CLK_DEV_NAME;
>> 	info.id = pci_dev_id(pdev);
>> 
>> 	info.res = &DEFINE_RES_IRQ(pdev->irq);
>>--
>>2.27.0
>>
>>
> 
>

