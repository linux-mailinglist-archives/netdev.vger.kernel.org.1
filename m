Return-Path: <netdev+bounces-210891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B04B15508
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43C218A086B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5F15533F;
	Tue, 29 Jul 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyi6URWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424418BEC
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826509; cv=none; b=CjQxctDxflggjJeToHNMGSVM3D5IBS+smSERhZXsxQcGvfMzVcMY+SYXap9UBFhtBo2x/B1/DdOVVgTDLMcsGJYE9l7MBSR2RHj6CP0E1OTNkmLNVQVB60i3ARLlkB0hvKZCofNo5F0G3pNZB7n+v7efY8S9eTRPDRnFPuGMDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826509; c=relaxed/simple;
	bh=LrpNNRsqiQ70bdA45zmRy0JcOCnzSxsFQSYIliCW08o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcUCC6LALgdwoUgZYx5LJLb+fiqSVNuQiQtnZ1HuxUakR5R8u9Auxi3LUA/vBIyO/uwbhfbRlhldPO7QHtmmILBB8wIvBER1xhZ+Ddwst8aLoDweBuCUDebK7E9BeqGjZQd4/VhduBJ2UTFTTS8LENZJHME6DHBoMVJKSMmclrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyi6URWx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab5953f5dcso58283931cf.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753826507; x=1754431307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MWallFmHDs9ZWDkZSi+x55d0KJtII8ohAMcXEHud3xg=;
        b=Eyi6URWxhvelCfHs7bcOwgEn5CwUtPTH+XHiFNmgjRloMtb6ezYqg0Z8LaqadTHO5i
         yS9UJCkkGuMjRDBdpza5jFRCbCkU9/+wGYeAXsCf5k/lGPnTiSXw4m6o1nKZbaiHmDvQ
         pzJAjfDvTT9Gtz9BE6NnGlQcyS4dU90DhCv4+8yEiLWA7WGw6SjA1zm0bdYoN9s93Zq2
         nErF5JaMzR5YVMtkh6TFL+p0o3qcnboTN8MbzaKSHOoUfCFPoUKg21F1jF55O9EIdjZR
         xm0maIQhWY+KmBk+/f2iMcIut/bwBfm0pJDQnpwOdwv3koQ1LrJRu5Bn/jN9qRnAahN6
         HLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753826507; x=1754431307;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWallFmHDs9ZWDkZSi+x55d0KJtII8ohAMcXEHud3xg=;
        b=Coxb0LEvxQXJmZXD0m9neza/fu5EfdJzphO5w3MuOewHlgxvCx0b+O/ShZZmb0DVJp
         uschg0LhmiDAeH6JbiUTFde7LIgPGgKkVe94RCCbH5d0JAEJ1bfQgbp2XdqQX5hMXVPK
         7ExM7GGYUthiKB/7RmSjJ0/3u6NOCJXxjJ8xAmCKzNK8xyNZVHU2LdISTUuuN4FNPKPk
         JkqWA3h1zSaejnyIqNv6vwPZrGOPn7obRL32qeWjT0ZGquxvAbl5qJXtCop11TkehyI5
         staFe9uLuSBgvqKPyFYaH0paNxDJQDQmkfxPAQbs+6HbRYelHvTcVuEUZFSljKLahBvM
         +xyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlQh4q4vw0nmPvd38WFH/3PuHVqidz5BAXe+gFtvBb/NDS3kvuwFU09E6C5M3hvvzO/GHhYAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QlEzaYel94LUPIugVzH5agm8ew9H3TthZ9kToWB49IF+ZLwy
	K+3kcfbVBuB8Ucvz242nnrRsf2aDOc8PDntdeTUliUsFZVvgoo8jFHFS
X-Gm-Gg: ASbGncsep58fLFCkd77gvoUPM4hLi+axoIytj1T7gzd7TZhIvITSJnn06hNJ8M99h3r
	Vx1TpedsS6NGNug71WO9CTBxT8GWOdLVWKqEPUter2MLuVhPY1uwu8wXOeN7jggCVsxIhcnOsgs
	wpoWjPt0y3cVLvXeU4z9iwV0ukDwJnyh8Rey++6mLDriLzrF7LEF7NZOQxZSKVdNnW+mSXty/K/
	SCwUW3OHVX3cM3hx4Y18e9odCLpU8fy+8DFJAkKos5bs4tet/Em7buGvNVnZEDw+OG+m1gh0sLn
	/i7mFN6ePD1zO3Xv0mCyZbABwy7JpfX+YPWHpLCZ26moS1bp4gqt0JtBaviFSO6WjQ3IgHipm+I
	kKNVNQdWpwn35f8p976QQXSwU/GjX5gFHGteZEpqmjVFZX73cUHxT9lavwmmd0twRf0ZWkwY=
X-Google-Smtp-Source: AGHT+IEvdcCG0w/+CuXlf8z4cdBDzm/VOuFAHwLTBB4uMWUEHDzTj5mE8m3z3Zn7Qfciq2gbGNvUqA==
X-Received: by 2002:a05:622a:15d1:b0:4ab:5888:38fb with SMTP id d75a77b69052e-4aedbc3afb2mr21371981cf.32.1753826506905;
        Tue, 29 Jul 2025 15:01:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9966e30csm55570921cf.55.2025.07.29.15.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:01:45 -0700 (PDT)
Message-ID: <5f68f153-c633-45da-96cc-113482e0b6d1@gmail.com>
Date: Tue, 29 Jul 2025 15:01:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
References: <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
 <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
 <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
 <aIjePMWG6pEBvna6@shell.armlinux.org.uk>
 <186a2265-8ca8-4b75-b4a2-a81d21ca42eb@foss.st.com>
 <aIj4Q6WzEQkcGYVQ@shell.armlinux.org.uk>
 <b88160a5-a0b8-4a1a-a489-867b8495a88e@lunn.ch>
 <aIkQxlqmg9_EFqsI@shell.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <aIkQxlqmg9_EFqsI@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 11:19, Russell King (Oracle) wrote:
> On Tue, Jul 29, 2025 at 07:27:11PM +0200, Andrew Lunn wrote:
>> And i did notice that the Broadcom code is the only one doing anything
>> with enable_irq_wake()/disable_irq_wake(). We need to scatter these
>> into the drivers.
> 
> It's better to use devm_pm_set_wake_irq() in the probe function, and
> then let the core code (drivers/base/power/wakeup.c and
> drivers/base/power/wakeirq.c) handle it. This is what I'm doing for
> the rtl8211f.
> 
> IRQ wake gets enabled/disabled at suspend/resume time, rather than
> when the device wakeup state changes, which I believe is what is
> preferred.
> 

Sounds reasonable, I will go test that instead of doing the 
enable_irq_wake()/disable_irq_wake() dance. Thanks!
-- 
Florian

