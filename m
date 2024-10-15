Return-Path: <netdev+bounces-135580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83D99E40D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887741C2275C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910931F9A96;
	Tue, 15 Oct 2024 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGyEAI8/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FE1F8F04
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988245; cv=none; b=mKbFBL2uv6AijzoUk26p7ZnZMsZOZTdV6h9Jh1Tke7sg+apa3Oa5VsuI0pEzbtvkJWwldgIjGKuepxdk29liRenle5pkjSvjq5SSjLhNHFxlgPH1YLsFfzx+C8GNr2VX2mCBS2P7e3/XTXgf8TKU15Erb9Rkwv0Hc3Ho31/RzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988245; c=relaxed/simple;
	bh=zlX9IF6L6uFRuAeMs99rcSZv8S3tAxccHbjKjKLs2PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVEfztGsXwvL1G1UJR0Ata/2OmWgt9yEge/CYAdeVfUV3YK37tp8gx5nrwJbsBtA35Ph96aOL50wQQYeR9HNl3wNObnx//44BMIstRQhASkQ9P8Lt9wqhicraejYNpk0XW8NinxC8jtgKHj68DVizU3EK4bGKeNXSA+c2Oxit+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGyEAI8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728988241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNlwq45QHItRtmcpJA7GMv4hEQyNZyml809eS3mqYWU=;
	b=AGyEAI8/pcSqi8Vp4Jvo8JysGJsEOeVLivaPaB5x7LJKvshT0KK6jGVURJX0UYq9rqh9XT
	n3lT4ba5fNaQ+2YM7tQ2nStjvHhKX07WIXPzKxX5WmwITUHbTTdafd7QVejOHPV9asfXWV
	rvRh5I21mzVXRDfnFZybAlzZdZsOfZ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-sssNlwhYPNyM_L9w6NU2OQ-1; Tue, 15 Oct 2024 06:30:38 -0400
X-MC-Unique: sssNlwhYPNyM_L9w6NU2OQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so2432541f8f.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 03:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988237; x=1729593037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNlwq45QHItRtmcpJA7GMv4hEQyNZyml809eS3mqYWU=;
        b=J7WbjAJsqV9ecFQnKVsQs3RrVps4uNMnYcPUylxp/43Qp4ZCTIi82raWXNVpWOEYtm
         4O2aAndWau6VzgcnHHzwHzaCUbv+c++9QliK/5CIeAUYoJMym88GfTg/BkGsNUAt8Rfq
         43dwu1+t73ICveow2goGNy3TeusGpRW6tH+yK6I1luQ+IugRcy1EBPoWsgGljQ6smh3o
         RzoKoSLdndHCLZ657nt+wXdsXhR1x/8CVSOu8VCBU4JPRYLOB9daHtcVCYZ1f3ceA3vK
         WH8P/1J3n0MCC9TFZEXY4/6UGtVLwo0oB3udV46eDKq+bwagH8DAO7FZZ8fAYnTe4SIM
         /2TA==
X-Forwarded-Encrypted: i=1; AJvYcCUPFxinDEy/Fmi5+RSzfLmh6agQA5Lrwf4MiNUJcRyv4x5/gqedAAn2z59ZvCTUB6C+F0rtQr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7LxO+y7gxhL44eL+WoKLQhldCeMDLkqJEmN+5uFhuS2XdyMF
	IeBXJ6Z4n1u6DVlHBM0YEbI40pUGU1LI2/aUAbv4vxBSGv57TCFNt39Lgf91mGJFNhWcNMGs9hT
	r3m3PiWU5E35Tr7opadiF/0QbGJEr0jFTuhMRnmQAF4bWQcnDmgtAsQ==
X-Received: by 2002:a5d:4244:0:b0:37d:30e7:3865 with SMTP id ffacd0b85a97d-37d5521ac3fmr9786750f8f.34.1728988236821;
        Tue, 15 Oct 2024 03:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1NYcYcwJtR7C3+O7QSeW8T1HfZYIUv3EZPiHq8phl1R9SlWw8hdyuGmoJKNXwPyUa5+ozFg==
X-Received: by 2002:a5d:4244:0:b0:37d:30e7:3865 with SMTP id ffacd0b85a97d-37d5521ac3fmr9786724f8f.34.1728988236420;
        Tue, 15 Oct 2024 03:30:36 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431487c194asm2704135e9.21.2024.10.15.03.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:30:35 -0700 (PDT)
Message-ID: <d1ead515-8ecb-4b43-8077-92229618aa43@redhat.com>
Date: Tue, 15 Oct 2024 12:30:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 net-next 10/10] net: hibmcge: Add maintainer for
 hibmcge
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-11-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241010142139.3805375-11-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 16:21, Jijie Shao wrote:
> Add myself as the maintainer for the hibmcge ethernet driver.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v11 -> v12:
>    - remove the W entry of hibmcge driver from MAINTAINERS, suggested by Jakub.
>    v11: https://lore.kernel.org/all/20241008022358.863393-1-shaojijie@huawei.com/
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1389704c7d8d..371d4dc4aafb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10275,6 +10275,12 @@ S:	Maintained
>   W:	http://www.hisilicon.com
>   F:	drivers/net/ethernet/hisilicon/hns3/
>   
> +HISILICON NETWORK HIBMCGE DRIVER
> +M:	Jijie Shao <shaojijie@huawei.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ethernet/hisilicon/hibmcge/
> +
>   HISILICON NETWORK SUBSYSTEM DRIVER
>   M:	Yisen Zhuang <yisen.zhuang@huawei.com>
>   M:	Salil Mehta <salil.mehta@huawei.com>

Unfortunately does not apply anymore. Please rebase, thanks.

Paolo


