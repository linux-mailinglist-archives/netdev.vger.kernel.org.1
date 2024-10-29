Return-Path: <netdev+bounces-139744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B071B9B3F60
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37951C2148D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15733168B1;
	Tue, 29 Oct 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRpuvfgu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1914A85;
	Tue, 29 Oct 2024 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163478; cv=none; b=vACngdcfaz4UcojM0jyx41IHsepbdpgs8gfHmWMQjgGLvyHrPupktLynPUcDzWKl1SxyP+ly1el6u2V1u/gNJr7m6JTo3cisNl1URiGvGS1oe6r6CYLpfT1THL/ZY9KWXNrV6S3p0FqI73NW6olsGjK7c0ruLNkjq55k+GuQ5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163478; c=relaxed/simple;
	bh=E5eZ8GLRzUOqWvDS4SrIOdlwia2y8ODJSH2JKNjpFvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NV64cJo7NX8LVzkJ1zo33Car/p/7a8R1gdNtcsUARLM/ka8KLeRgPBi3ONts3Kuk4q/vpUJLryADUXl36f7o/GXYBLZvI6xPL1eTGCp2MI8eD1VzhPDskTNpH51RQdqSnU5cF4I/VR9OJcvDj8T2kg/mIbwHR3EoLEBVCJ1mxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRpuvfgu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431ac30d379so12706285e9.1;
        Mon, 28 Oct 2024 17:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730163473; x=1730768273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18M5G6gmC2uJZssfsnK5gMVxO3whYHwKOs0IPtJ1EAc=;
        b=dRpuvfguvVyZwqnjOAQuBHCLFxexYBghB6bjv+UXy3atQM42lEo2Jjf1dF+tsH99Ra
         9+66dDGhhgq6YURnDrc0HijoOa+ipjCNfWUgR7XnbmmgeO7HPeS+JiQsW+Ky0KPS4xU6
         pNMZt3MqUalZGPEKNLh9l5ptO9m12CljETnZfnJGLuu13+29k56y+ERvXszsdSq4B5YM
         1VYZn/f4rZBwzoR2zSx4vC1ZK0R0q4Ks/j92xsa672TiinkQAfqFkUYPfkbBr3vdD/w4
         CstYpPbWu4US7LVz779EL9QaEB0zthkK5DazZcq2HpJiN1rExoJ4XWXux7gieUmevZbF
         /kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163473; x=1730768273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18M5G6gmC2uJZssfsnK5gMVxO3whYHwKOs0IPtJ1EAc=;
        b=ItO/NimdfMPTFwLJ4hnO3ciuNgnKFgmUr2kCM8ePK4BiNLBFCNKg1ksMo+fTKFRWdo
         OCnlGrpzJLHCsT/4/DUu2rr1L079zeO+K1Immop2MeD9K1aC5eAENX7xxJ7sfmfWJ6M+
         NM68IOl+DzJD0DyMVoT9xgT6IenrMtzvATQKIbIXgRYpgYbh2ztBF5VDqbsDVBQl9L+i
         FS/InVLOgFwfdBVW6ciosUci7UycYTBjt8wklN90in+znUorM+SPO/IvRdLB9P8f0x8c
         8iQOvWc67JnSrNYVP5xUFuJgTIlSEs9exAZYCnk5ih+Mm80j4Uq06L5o3X2x+QLJ+/r0
         bNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVATlLMpEOTnkDUqgzwKME57rrgaCxsEwoT8/nTc4rXMWZQapgJp5GMKUM3unUEvQ4XCC8sPAXPO6k=@vger.kernel.org, AJvYcCXZpAEVAqkcXkSrLjjD/8cmaG1VofgITWTp0jxPPig1lZbhlZABPUI/F55R7o7nVSrA/mGjP+OO@vger.kernel.org
X-Gm-Message-State: AOJu0YygPQ2JqmIU7Ji6J3Rx2lvL8HzqZUczybtveDr/Jok3640QkKZo
	fIIVf5O8Xl7JKsETNlDArKdx+EXD30rLMPSang6IsUAZ0w26iQ4a
X-Google-Smtp-Source: AGHT+IEDznCPCf6wq2CmGJYXSoKXPyBjdKEg5qpjuhcayRcrcniC1z1J2mBHun/cnOqlR0goHC+pPw==
X-Received: by 2002:a5d:5cce:0:b0:37d:446a:9e60 with SMTP id ffacd0b85a97d-38060ffe8cbmr7494789f8f.0.1730163473057;
        Mon, 28 Oct 2024 17:57:53 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d50sm10974443f8f.76.2024.10.28.17.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 17:57:51 -0700 (PDT)
Message-ID: <11e25027-6987-4c88-ac06-c1ba60c0d113@gmail.com>
Date: Tue, 29 Oct 2024 02:58:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2] net: wwan: t7xx: reset device if suspend fails
To: Jinjian Song <jinjian.song@fibocom.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 corbet@lwn.net, linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com
References: <20241022084348.4571-1-jinjian.song@fibocom.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241022084348.4571-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjian,

On 22.10.2024 11:43, Jinjian Song wrote:
> If driver fails to set the device to suspend, it means that the
> device is abnormal. In this case, reset the device to recover
> when PCIe device is offline.

Is it a reproducible or a speculative issue? Does the fix recover modem 
from a problematic state?

Anyway we need someone more familiar with this hardware (Intel or 
MediaTek engineer) to Ack the change to make sure we are not going to 
put a system in a more complicated state.

> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
> V2:
>   * Add judgment, reset when device is offline
> ---
>   drivers/net/wwan/t7xx/t7xx_pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index e556e5bd49ab..4f89a353588b 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -427,6 +427,10 @@ static int __t7xx_pci_pm_suspend(struct pci_dev *pdev)
>   	iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + ENABLE_ASPM_LOWPWR);
>   	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
>   	t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
> +	if (pci_channel_offline(pdev)) {
> +		dev_err(&pdev->dev, "Device offline, reset to recover\n");
> +		t7xx_reset_device(t7xx_dev, PLDR);
> +	}
>   	return ret;
>   }

--
Sergey

