Return-Path: <netdev+bounces-112036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588AF934AAD
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90CFB21CD8
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497F80045;
	Thu, 18 Jul 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDTUs81X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4A2E419
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293619; cv=none; b=Ba+2ZK3RtGIDEMvgjYpPWciLUOncWGUoY9SBhK3+kh6CzVoP0aL/+IibuIiuSAMuTbCL1qRu4bNnWqXAP5JYXox6yJvHkvxAlB8kJTllQe4W8XJusVh1QzQzh8p8P85r+V22PxPlPN2KwWQ8brCrM/+hvoxYv4YGrquzo93rT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293619; c=relaxed/simple;
	bh=fyyWx8U8VVx1dX3aVlq0lEv6E7jxlmpHFgOb/0d128E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3k9CZPdxMthlF7tfFTpVagBrG1X5AKU4V+5o1FhSVMBAWHgou8l6zrx/X5unvd9cR98Iqz8JSWClNCkBJYdyEBtrFmfoSmuwV4ylrens2lVd0UUI8O9QPuqtCugxoSYTouk71wJA+YM0Gg1lCTlcFDnwxKkHJ8inAtXa1l2loU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDTUs81X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RCvekDuVMGClEb5Zcx5cpKXF2G/MkF3FsUT2L2fQJc=;
	b=IDTUs81X/Kte1vFqq3KcQoFrdw9qPWwNjVA2Tz8qwkxHa50TX3phiLqE5VkejXI62arjZh
	3TnPxaA6/8wUey2DqZEDtQSCIZx43D1731VDdeuIPt4tPixRS4/rHsJJBYkTDsRyftQxCq
	tO7PRBdVEQea83B2MuFQIVmyaXmX1oI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-LoPKyWPMON-A1KqoE4nmMg-1; Thu, 18 Jul 2024 05:06:47 -0400
X-MC-Unique: LoPKyWPMON-A1KqoE4nmMg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4279f241ae6so157075e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 02:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721293606; x=1721898406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RCvekDuVMGClEb5Zcx5cpKXF2G/MkF3FsUT2L2fQJc=;
        b=j7j8m60EZGJjOUDmvU5qLSD/0CIreX4z7BR+iZ0QKsF9MGu4EckG8ISVvLWicUEEwZ
         y4RNg7ikvDirkKwHrx9DgatvMTCMQjcjt07RMSiHrDB1jR3MgP8XEqeHhnEo8LpK3+Vh
         WYHsRFM5h4Dh3ncIyn2IK7rsLPy8ic8eeOwzXhQhHzbpz2LiCq0JH5FyjSQwHPmrEnPB
         eOS7xhqycVkdkGDyYISPDeixbOTb6O/FRGDBsqMzNAMfVF7S3oWnzQJoCQyUo6rdBKHg
         KWy8bSOl/RB6U0wyYZoT/EDaqM9StgOptKOp7bLQI9EESt5BWB6Ygx4aWRdStTc//3La
         SyFg==
X-Gm-Message-State: AOJu0YylTGfUbygepSWj4vykO1t1xeLBxcI306Sh2DNZchT19GT7TUSU
	cKG/PtCtd3XXGum/TxDHY5ahT37UadUcszKzdyDpBcoghpN4NOf+aXRDVtMQlRHWGvURemokfn0
	v+JFQrCymUL6/VNzOtoo+MEqEoq8tFw4vxpK+Ih0ZfOJ0mR8WhGsf8Q==
X-Received: by 2002:a05:600c:4743:b0:427:9f6f:4914 with SMTP id 5b1f17b1804b1-427d2aac236mr1057675e9.6.1721293606351;
        Thu, 18 Jul 2024 02:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsT3v4FMriXfs1n3xUxl+Nav2GTdTv3Ty+wMHYrugLpRBpptpKSiqdz3BT6uF6IHT2hyVbHA==
X-Received: by 2002:a05:600c:4743:b0:427:9f6f:4914 with SMTP id 5b1f17b1804b1-427d2aac236mr1057585e9.6.1721293605964;
        Thu, 18 Jul 2024 02:06:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3b7aasm3663905e9.6.2024.07.18.02.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:06:45 -0700 (PDT)
Message-ID: <eff0af6e-ad83-4935-bf69-8acb42e37380@redhat.com>
Date: Thu, 18 Jul 2024 11:06:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: axienet: Fix coding style issues
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, michal.simek@amd.com, andrew@lunn.ch
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com,
 Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
References: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/24 20:54, Radhey Shyam Pandey wrote:
> From: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
> 
> Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
> "CHECK" output "Prefer using the BIT macro".
> 
> It also removes unnecessary ftrace-like logging, add missing blank line
> after declaration and remove unnecessary parentheses around 'ndev->mtu
> <= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'.
> 
> Signed-off-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


