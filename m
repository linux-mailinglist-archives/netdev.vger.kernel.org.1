Return-Path: <netdev+bounces-168062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E29A3D3DC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F413AF992
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877F1EB1A6;
	Thu, 20 Feb 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPLqnOPQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC41E102E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041956; cv=none; b=FxRixfZLWDajtIo/npIaw/E5Jz1rmLyTxae46iNCEiE1j7HjLxW1GHDAVcLPyPperaSV+y07HaN4SveAD+Sld7AshFuZTpWHYyI1yRrlYPH7gSQOvoqsAPLC+ZHWXiJJ0Fu0etg0nizPPHuYi4Kud4GiwYffSCfCglGPo1XwoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041956; c=relaxed/simple;
	bh=qYR9nKryzm0N+g2oxBJ3pi4x+xx+vSkIm7pClZgHSOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHc1bavXAQtLl+fcgvzh/FHtdxSFWNUBgtohtNWm92WYZdmg49jr3R43N1aiEulmfyAElwANALP553wqhjxrauQrfwpDDKv0wmyqZY9TeW2Vkn1qtzYGeO1qsEtv8vYBUY2r47blFn2v3EvDZoT/mgNdzkC5A9gd3Ci1g4T1Qlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPLqnOPQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740041953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vi69fi8DpFTd/RNozd1wgX4NhzxErJ/nkr6IYJg5tZI=;
	b=YPLqnOPQxjtbUmrqHf6OIWH4m+Cli+6n5WeOu3RiHgDxuAf2ZR4Mqf/KvqBcMr37sbrcxW
	o+EywCwnVGi3qMQbXQTwnWrSB2zMtvGtae+RFymeM3qk2tE6H9kMuzVDHaOJNIYyWi3oCa
	Zbl12CLTAVxg6wYQv9UV7iRjJlYr7AQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-28Y_9L6SNuq4Q9_2AqfHGw-1; Thu, 20 Feb 2025 03:59:12 -0500
X-MC-Unique: 28Y_9L6SNuq4Q9_2AqfHGw-1
X-Mimecast-MFC-AGG-ID: 28Y_9L6SNuq4Q9_2AqfHGw_1740041951
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f20b530dfso569510f8f.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 00:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041951; x=1740646751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi69fi8DpFTd/RNozd1wgX4NhzxErJ/nkr6IYJg5tZI=;
        b=jUcaqj3/6/vO8PI9FnJ8IVsLPXWFsdlcxC0H7GollDQpXJFPaheaPK8XwcLWx5VAxj
         nCRTCS9F9NLS7zhe58DEZ9oJQIe2B9SNCDyEgZxCVoY8CgiY8KHhQyiZe7mNoLQpBPn6
         Ygh//UW9OR5FF34QQqmXj3je8/vcVZC3dNVler5VAZjysWIaN3eSJeggg4YArV9aJOHh
         stu/0hWf4hni5+RhYE7hQ0GHfsq86aX+vQlpLyeyH5uaseLf5TO2d38hpt/Q6HfTerQ8
         dm7bwCUhQDto6CaHpGUc9nX1+3o0mq9mT/eQLhqP1tNQLbdMMxjcSdCRPg//yCNO5EcJ
         +YKA==
X-Gm-Message-State: AOJu0YweGVyEnLfAgRUAe5tdKKtm8+7Ps2Swg6A37L19CdYvTyzFQbEn
	mROObkdxQc4Ubhhfk5zqi6zzx0QlUD5u9mT8gYyhdeb3R5XUOcZ5ghwQN3L9XnieznGajyxYWx9
	hrzv1zu+oVmT0K9ycB/NKflMMGGaUwqQXbNUH7SAC/RKmorK5i873hA==
X-Gm-Gg: ASbGncudhzUJFE8cFzScfTyR1JSjwd/rWYaehXPZx7T7F48mGXo9AJHceLZUqq1v76d
	A1O1xrHO4gYskVFlrKB6pVweBGHs/bdFgrfmI40A556fT1+jwRKAcgIrVKkdWA3hoA3RrFlWy6k
	Tm+nrcUoPdkMHXqrcd4OkT7nw8sCr/GzVnSxUGlgGdeRfc3z70ilkVxKoCuJV5/U9ttw1ic3w5K
	9CvCMx747d3luzHjVHZ3K2G/nSygqPE3KUe/p4wyyPQ+x1egLIrxjDsMtaD/AlUlYuA04ecRzx7
	Bx+d6Wy1InMGBvxIvpiLQed1RcMrwxPongw=
X-Received: by 2002:a05:6000:8c:b0:38f:2cec:f3df with SMTP id ffacd0b85a97d-38f33f44f80mr15027990f8f.24.1740041950843;
        Thu, 20 Feb 2025 00:59:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI9cLg9zTTlh2PcmYGIgTxMmZCopbpnVJC7SeH7bbA6kcEpvNnjuVI80LLj0zkozJx/pc/eQ==
X-Received: by 2002:a05:6000:8c:b0:38f:2cec:f3df with SMTP id ffacd0b85a97d-38f33f44f80mr15027962f8f.24.1740041950468;
        Thu, 20 Feb 2025 00:59:10 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915719sm20217153f8f.60.2025.02.20.00.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 00:59:10 -0800 (PST)
Message-ID: <2dba7bb6-23bb-4e05-b126-b147769ad1be@redhat.com>
Date: Thu, 20 Feb 2025 09:59:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] stmmac: Replace deprecated PCI functions
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Yanteng Si <si.yanteng@linux.dev>,
 Huacai Chen <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <pstanner@redhat.com>
References: <20250218132120.124038-2-phasta@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250218132120.124038-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 2:21 PM, Philipp Stanner wrote:
> @@ -520,9 +522,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  {
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_pci_info *info;
> -	struct stmmac_resources res;
> +	struct stmmac_resources res = {};

I'm sorry for nit picking, but please respect the reverse christmas
tree above - what is relevant is the full line lenght.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index 352b01678c22..9d45af70d8a2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -155,7 +155,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  {
>  	struct stmmac_pci_info *info = (struct stmmac_pci_info *)id->driver_data;
>  	struct plat_stmmacenet_data *plat;
> -	struct stmmac_resources res;
> +	struct stmmac_resources res = {};
>  	int i;
>  	int ret;

Even more nit-picking: since you are touching this code chunck, could
you please fix the variables declaration order above?

Also, please add the target tree in the subj prefix, in this case
'net-next'.

Thanks!

Paolo


