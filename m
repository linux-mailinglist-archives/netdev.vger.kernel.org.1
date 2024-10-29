Return-Path: <netdev+bounces-139957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2F9B4CA4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE451F24504
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4FD18E756;
	Tue, 29 Oct 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMJet8QL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F61CD2B;
	Tue, 29 Oct 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213611; cv=none; b=cxXalxrW3qRA8pZep6WJrhlAzcibuUa6TLGUmnw3dsgrjM3591vt9dH9WVDTRx5KaK6P/U+/gkEmo+kC5USzLi/u/iRpZL4ESvNze106/m7j3dYcrf62tIABjctOnsrC298oVBYYcE/s/ZKYge5inw69NNX1WghW84gq+V60PmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213611; c=relaxed/simple;
	bh=u5Rh47LFt/E7P8TNJq1mJkqj4x6Z8qfXXpSotbiRgF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slZn4J7F1A7uvnxQyMqpSuNaHTuugYKKLlWimn+F0kYPltPGhYwpY+ZZGSzeIonbkgHjAnE80VVCbK6CkV1URSkBPUnpzeqaoX9698ZefnE7kV/tafAaJUKSWE6m60cyWeH29ndY4aHu/f8v90TQMdkyPv+G5nn90d/62Kp0m9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMJet8QL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a139be16dso93581466b.3;
        Tue, 29 Oct 2024 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730213607; x=1730818407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7H64C/J9e8GCD1HkGwsMKQrPcurnGJ6w4i8btUxmUo=;
        b=kMJet8QLCaziUNtKxuUN8LQaTz21kmgnjqy+8msdNysXeMsmrr1KZVFhxaJofM5kNX
         da1S7r0TiKbGg+mLguwLequnido0HbGLAMJaC9f+hk532ItEMCCvAJhIB+5k/N3MIDzt
         tNeEulUnfLg55klP83AAI/8T8tUQ5G+40y5LKk6n/31B1x9uWSkkfHTvA3KqMDAA76WF
         qRXx4MQkheyRdTdM8dLrXN7WYaET6NZGofbVX9uYT0p909PwOvQ1l0OkiYzPs37RrdeP
         tOFkE9DHhXRF8c9y+NLifu/SbFU1avCy733KFIzXpJ2EcGDn4hLIoiscaS00Wk10PrxG
         Fobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730213607; x=1730818407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7H64C/J9e8GCD1HkGwsMKQrPcurnGJ6w4i8btUxmUo=;
        b=kXFzzFKcc+8/XR2bwVCvDLvYwPj4E5zJHC3z+uoqsp0VsvYY0w0ENTRhOXonkGXui+
         ym4HEuaf7bXJysY5B4/u9tOxhONnXifDvyzn5P78cOQR5TlaGZBWfO91mtPeIqbAsDPQ
         m/t/JVvoWBgPoQvHmiaXmOeIivfOrTRMmmvjppkaySvERifNaLjggKwz3zvi70HkxjKf
         WFnZoainHjUBgoPGdfgXIvmi+VpCp97F3YdV13jp/aetclnG/KhQ96atsO0VXg+TlRCA
         lyMNlFF3j6c8n9o6hW0/G/c9cHPJGvHT99deOFN/zBA7Pd9JY1Ru7XIJiQRIOTGhppq+
         sXlg==
X-Forwarded-Encrypted: i=1; AJvYcCVnRJMEk1njApwneCgaoAElGoZMvpEzxzWeSkWhiE7gHfXBugX5rXVn0i84s06HdZpImqbL861h@vger.kernel.org, AJvYcCW95GPhPOI4IW+QokHV19jbrlUGbmaXCBemHwoLWrowu597USGhVA+TVF0sfKcHg+moAOfodHvtF9rZHZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZjkEaHb7UrY3GtQBUMe45ZnCLvs4U3H6QYY/ZciFCPqCHGfE
	IFRnSQMLZhuu961iEQ9Y2NojUen62oRsQpHCjwPug1OASF84C1+lRvbdxA==
X-Google-Smtp-Source: AGHT+IGHyWendIeeMVLYSDpNkQYgJQ01EFCXgFqz8SyS42c5j0kvV8cl2qOVXH9XZ7KSxvHFYFf3eQ==
X-Received: by 2002:a17:907:6d24:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a9de5fa6a7bmr550235466b.8.1730213607266;
        Tue, 29 Oct 2024 07:53:27 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a0834a6sm479602166b.191.2024.10.29.07.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 07:53:26 -0700 (PDT)
Message-ID: <f147c6c4-30e8-40cc-8a01-dc8df3913421@gmail.com>
Date: Tue, 29 Oct 2024 15:53:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ethernet: arc: fix the device for
 dma_map_single/dma_unmap_single
To: Andrew Lunn <andrew@lunn.ch>, andy.yan@rock-chips.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, david.wu@rock-chips.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
 <86192630-e09f-4392-9aca-9cc7e577107f@lunn.ch>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <86192630-e09f-4392-9aca-9cc7e577107f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/24 14:03, Andrew Lunn wrote:
> On Sun, Oct 27, 2024 at 10:41:48AM +0100, Johan Jonker wrote:
>> The ndev->dev and pdev->dev aren't the same device, use ndev->dev.parent
>> which has dma_mask, ndev->dev.parent is just pdev->dev.
>> Or it would cause the following issue:
>>
>> [   39.933526] ------------[ cut here ]------------
>> [   39.938414] WARNING: CPU: 1 PID: 501 at kernel/dma/mapping.c:149 dma_map_page_attrs+0x90/0x1f8
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> A few process issues:
> 
> For a patch set please add a patch 0/X which explains the big picture
> of what the patchset does. For a single patch, you don't need one.
> 
> Please read:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 

> It is not clear which tree you intend these patches to be applied
> to. This one looks like it should be to net, but needs a Fixes:
> tag. The MDIO patch might be for net-next? 

Hi Andrew, Andy,

My desktop setup has a problem compiling older kernels for rk3066 MK808 to verify.

Are you able to bisect/compile for rk3036 before this one:

====
commit bc0e610a6eb0d46e4123fafdbe5e6141d9fff3be (HEAD -> test1)
Author: Jianglei Nie <niejianglei2021@163.com>
Date:   Wed Mar 9 20:18:24 2022 +0800

    net: arc_emac: Fix use after free in arc_mdio_probe()

====
This is the oldest EMAC related checkout I can compile.
At that patch it still gives this warnings in the kernel log.

[   16.678988] ------------[ cut here ]------------
[   16.684189] WARNING: CPU: 0 PID: 809 at kernel/dma/mapping.c:151 dma_map_page_attrs+0x2b4/0x358

The driver was maintained on auto pilot recent years without a check by Rockchip users somehow.
Currently I don't know where and when this was introduced.
Please advise how to move forward. Should we just mark it net-next?

Johan

> 
>     Andrew
> 
> ---
> pw-bot: cr
> 
> 

