Return-Path: <netdev+bounces-193348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF93AC395A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079A37A612A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8811C3BE0;
	Mon, 26 May 2025 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsy0iSxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F0136349;
	Mon, 26 May 2025 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237964; cv=none; b=oTvo9l4JSYfGI1ejtjyv/bIWETdxUi/tlL5MwE2aUg+XpA72c1hH9BvrT4r+rJwLE6IFpA9BDW54g4FfYOoQ0CB+P1Vw0wR4aqkOzGR2XpuDl+f36imfIAB19phSBrasOQHtBwTyBNIJ5NbtuIrHfKqPC8UEPzL4rKi/9wTgW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237964; c=relaxed/simple;
	bh=rB6DtSGBYvQRTpJ/h23/TPejO2Pzgd4zo6EBey4hcas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XktznBnxdYJpueEgQTtNrnKa9H9Djmu76tLn37lQaCtFKH2FWWUHW72iAUF8rck5L+cychXAf5go3VogZIcUFaBCJhb0pssiGWFGYoEbJdFNjxNmH0ioxB/3a7PcPhjX1WsEph1cUQaG47mlAatxJ6L2QyK4SX1Yi+CvDjN+of4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qsy0iSxE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2346846ee0eso3663885ad.3;
        Sun, 25 May 2025 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748237962; x=1748842762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dLp6cnqyCbjFDWsg2nybeJcpM5tSNUhvPi8JJGmzqF0=;
        b=Qsy0iSxE85qWONzM3q1TXBzBFRit0OrFgHVdbG9gdGQeO6l+1sunRSyyYXklHYN9XT
         MsHV+CH86Dots8bP3swyFaBxkJvU5H23U6/+Le+VH1UaADYDkMHxIph7S4vRR9iIgMR1
         iOBCJLUFAiNQ0detzyuxAoQX+0eDW5w+TlfKSjOzEiXuKB6C+hi6TWeYkZX5O6Z/3vyX
         yV1DrNX+US1w41Cxj6BnHNLtwb4fnqCpZo0yn56KWbvUX81d6DNQqSRwbl2B8QxKjLAK
         QSnSmj/q3PWXdi5kKO2uNFmZJQWkVz24Pvit7v727T9QuHZKPvWgpKHETu3R1rDvbegx
         awBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748237962; x=1748842762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLp6cnqyCbjFDWsg2nybeJcpM5tSNUhvPi8JJGmzqF0=;
        b=FVdtDOKI4R28D1cTVvdr+J00ygWDjUvbVSjOgoDJ39WYjTy1OCttwYBP5IWKO759oB
         +sGcxBVqSyv8WeMZ0axl5wq0cHP5vQVPxxnAi6dAsq6k+5JWdPiOHudbWL86JRuKWQCk
         FkPafe8+ARvCS0VJoJYP2IE6btB4yPz+j+y+UeMu+zjU0ZUO5WWJZsvbaJBiMr6Kewc7
         3WHuafSfsxJ0mcT8AcUBeqH8xwe3tTj2stw88LVZPpGvytSCU1FgPA6MvD8xTze9cZn1
         k7qbHR9jvyRrmpGjVdEEY7lImQOkkZSycWVviwGpruaxC6dXtjdr0x0JFH9eTBDTFmaT
         jbRw==
X-Forwarded-Encrypted: i=1; AJvYcCUsiNo1DAeV4IguNFN/FlmPY8eeyt6rf0Qe/wTiUTp4DYYWXFuFB5+DJx7oo1YxR4iN89VzpniPRY+2DkDx@vger.kernel.org, AJvYcCVhklqkhGnUCVSsVg1YGBHM11/Pq6X5Y3t3I36q4gtkUwnJHpE2f+FcThiATWjz4w2WGSJGnk9Xev9F@vger.kernel.org, AJvYcCWW9GqfQDeMMKjPWx0tsxtUHyqxI/3asavO7342sIuQUMIvRM5OkvAfw+NoLHGlG0dkFxVdBmlO@vger.kernel.org
X-Gm-Message-State: AOJu0YyorftQg3PhdpnpEFc5RHh5HNmwpBf643ex2tRUvBK6JEGV1khA
	Z0nyg/OxF1SERn/c/m+NjUrJi1Zz0l0GZviq5rY9p4O+319ZqSG7TjFBpEJcpAKP
X-Gm-Gg: ASbGncukWv3D5/lOmHYEG/NWraQGIviQsHpBQb4MB6/v2ACQ6sLtEIf7QYHGUO9uq7z
	BtB7BuGGplwk1hc6UlQHjXUhPCwZ7vEYujQYe8XGwQlrxXIjkmqS+jR/Phv525q4mX+aANqNhEq
	AdRxnw3CkJ+RrrASqAx0bryK1UHHIkhS+C6N/myoyJjksrm8nYREuEwDvcPuXbG3h4eHqKBCwMZ
	rIa51kpka3DeEKYWSmEMckYi3KSZrSJHXlSR+RGft6J9cfH0vi/Q+BkjhXykxNTN25e84MNcD4l
	n5m4h+ymTe0YYmFfGBgBmRcQx+9v5zzaLHRkihTnTsAHnjVqWLLN8iz2Cb8ShcSc6Xb8UGXKbKJ
	Quh4oILVMkvH6d/iQQik3jcD7a2ps
X-Google-Smtp-Source: AGHT+IG7xgzxnz1Grj9UzPDie6FzHib+saLpOZH8onxhz75DWnCGce9JBep2Vj0Bc2x5YD1GmylXew==
X-Received: by 2002:a17:902:eccb:b0:22e:3f1e:b8c8 with SMTP id d9443c01a7336-23414f5cceamr132744715ad.15.1748237962243;
        Sun, 25 May 2025 22:39:22 -0700 (PDT)
Received: from [0.0.0.0] (ec2-54-193-105-225.us-west-1.compute.amazonaws.com. [54.193.105.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2343635891bsm22297405ad.130.2025.05.25.22.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 22:39:21 -0700 (PDT)
Message-ID: <705d99b3-9803-4f5f-a807-607b49349b68@gmail.com>
Date: Sun, 25 May 2025 22:41:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ethernet: eswin: Document for eic7700 SoC
To: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 p.zabel@pengutronix.de, yong.liang.choong@linux.intel.com,
 rmk+kernel@armlinux.org.uk, jszhang@kernel.org, inochiama@gmail.com,
 jan.petrous@oss.nxp.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 lizhi2@eswincomputing.com
References: <20250516010849.784-1-weishangjuan@eswincomputing.com>
 <20250516011040.801-1-weishangjuan@eswincomputing.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20250516011040.801-1-weishangjuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 18:10, weishangjuan@eswincomputing.com wrote:> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add ESWIN EIC7700 Ethernet controller, supporting
> multi-rate (10M/100M/1G) auto-negotiation, PHY LED configuration,
> clock/reset control, and AXI bus parameter optimization.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
> ---...> +  # Custom properties
> +  eswin,hsp_sp_csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: HSP SP control register> +...> +additionalProperties: false
> +
> +  eswin,syscrg_csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: System clock registers
> +
> +  eswin,dly_hsp_reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: HSP delay control registers
...
> +examples:
> +  - |
> +    gmac0: ethernet@50400000 {...> +        dma-noncoherent;
> +        eswin,hsp_sp_csr = <&hsp_sp_csr 0x1030 0x100 0x108>;
> +        eswin,syscrg_csr = <&sys_crg 0x148 0x14c>;
> +        eswin,dly_hsp_reg = <0x114 0x118 0x11c>;

Please help explain the meaning of eswin,<reg> array, and also the expected
number of elements in it, like what starfive did to their JH71x0 device-
tree bindings. E.g., this is what net/starfive,jh7110-dwmac.yaml looks like:

...
   starfive,syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: phandle to syscon that configures phy mode
           - description: Offset of phy mode selection
           - description: Shift of phy mode selection
     description:
       A phandle to syscon with two arguments that configure phy mode.
       The argument one is the offset of phy mode selection, the
       argument two is the shift of phy mode selection.
...

Otherwise, there's no way for people to reason about the driver code.
The same should apply for your sdhci/usb/pcie/... patchsets as well.
Also there's no reference to the first element of the hsp_sp_csr array.
 From the vendor code, I'm reading that you are using the first element
as the register to set the stream ID of the device to tag the memory
transactions for SMMU, but in the patch, there's no mentioning of it.
I'm guessing you are planning to upstream that part later. If so, I
think it's better to put that register index at the end of the array,
and make it optional. It should then be properly documented as well.

Bo

