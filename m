Return-Path: <netdev+bounces-133001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B234E99437F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6AB1F267E1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696C1D095C;
	Tue,  8 Oct 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLoeG1BD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A31667DA
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378072; cv=none; b=GMBorqCzE3PqgaartomjFlEvUSrIe5irQbbqeCXd7I+6EnI+nRQtfnphbt+rvlVtOGUVxBMFqCGqRgJYxvHV26kKnx7d41Ftu7kuDfaRTIASk5gfDx4qS0IQleGxhD2UimwP/TsK3CJ/Rv2+jiGp1Z1yVLBdKP/uPp9bGQxK+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378072; c=relaxed/simple;
	bh=CWk6qOrLNWMBar35EmC3B/ynBzAUfUHitiAJSmo+FG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzS4UW4ybOCZnz6diH1/G1epVI9QKwv0hfuD1cQbh+Ifqc8bVOOPAty0rdHPXevQdNjehgvxD6rIIZASA9dSLvmapghbC2qcE2jg1IULERj6Jds/reuGt3OCt2KeaRZccPTmm0VpCL1FsAoF4c3M7aYf1JrGMwbGuAJn7xs1dKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLoeG1BD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728378069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Az/KMPreXaGl91pZI4523wJ5r8ejn+YnIG+Mof+90Ek=;
	b=gLoeG1BDrEOHTotR44qJAmZbKTO2bzCpM5rUzg7R65gpk1wAmEbwohWUVgvpFY8ZLXUFd7
	aMmzeNyHn3sWTm6bFUyksUkLBB7MP2lu7dx54nL80UugGcvf95iFFlpC62YkdspDUTa94U
	jApWD39bOgW2NZL1EPAJd1MzKzw/wC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-K5Sb0p3vNhW4WlEUquJZYA-1; Tue, 08 Oct 2024 05:01:08 -0400
X-MC-Unique: K5Sb0p3vNhW4WlEUquJZYA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37ccc21ceb1so2530100f8f.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 02:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378067; x=1728982867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Az/KMPreXaGl91pZI4523wJ5r8ejn+YnIG+Mof+90Ek=;
        b=ssr53Ov7Koapq7YjNoVhhHXuONpvoOmtK6OKpWP/9OAfJU3M10rV/KsX1UYa8RsHhW
         wYLLk9A52sHMnHXy69t5BqHLdmVb7NotUXw4bvlA7E/C8s2uaA1nGwOWnidEY/Sc0vBN
         zouADkT7rReLPFL2MISk0C4NSgUI6kdmHn/sJmrpy8PpncGyYB4MUruMOrW09v8UaVV8
         aOA6GCG0mUZiSGHxkeCsQus5wyt5KgcbhDWNetQCz/zYGTomPBRWjeu8w3aketbDbsl5
         7IyT9ABArj/Dvbchxw1oLexq3O9RMJr1Y0YO1+0nVmWLoGgTMVpwyNnS/705pWbFrBwA
         DdeA==
X-Forwarded-Encrypted: i=1; AJvYcCXyYNrfKR38vqF3wMQvjiWGx7D8EbVjK4jIWO8+N8PkHHWhrYQAc+8aNQH5eSrDA7Z1Qproz5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDO7w/4JzpPaMcFI3dDJItM7jh1L2E/fbaPrp6WWPzekaDRSs1
	2nfNgRq4Tv39iVqDyHAybAq0t6D6adddX+QIPSklj2cJeZJGrC6HlkrFnoBYVNmTYyF4j19uLSa
	uNvk/QwD7yM+oAKyjiw9HSB8bdWz9f62XUmL1LPQjiX/FW8Vn0N3EDA==
X-Received: by 2002:a5d:64e7:0:b0:374:c040:b00e with SMTP id ffacd0b85a97d-37d0e7d43c8mr10304850f8f.39.1728378067027;
        Tue, 08 Oct 2024 02:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIFwLBzdlSN+s2luoQEVwbNKJu+jYd1X+INDAyIvF4Y/gn2XGZgzsLbGQxoIp6iqg9MixO4A==
X-Received: by 2002:a5d:64e7:0:b0:374:c040:b00e with SMTP id ffacd0b85a97d-37d0e7d43c8mr10304829f8f.39.1728378066670;
        Tue, 08 Oct 2024 02:01:06 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4d8sm7587775f8f.36.2024.10.08.02.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:01:06 -0700 (PDT)
Message-ID: <24e50bd4-05e7-48be-b943-b361f4e73fdf@redhat.com>
Date: Tue, 8 Oct 2024 11:01:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/13] net: pcs: xpcs: use FIELD_PREP() and
 FIELD_GET()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
 <E1swfQz-006Dfg-5U@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <E1swfQz-006Dfg-5U@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/4/24 12:21, Russell King (Oracle) wrote:
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 805856cabba1..f55bc180c624 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -592,7 +592,8 @@ int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns, int enable)
>   		ret = DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
>   		      DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |
>   		      DW_VR_MII_EEE_TX_EN_CTRL | DW_VR_MII_EEE_RX_EN_CTRL |
> -		      mult_fact_100ns << DW_VR_MII_EEE_MULT_FACT_100NS_SHIFT;
> +		      FIELD_PREP(DW_VR_MII_EEE_MULT_FACT_100NS,
> +				 mult_fact_100ns);
>   	} else {
>   		ret &= ~(DW_VR_MII_EEE_LTX_EN | DW_VR_MII_EEE_LRX_EN |
>   		       DW_VR_MII_EEE_TX_QUIET_EN | DW_VR_MII_EEE_RX_QUIET_EN |

Very minor and non blocking thing: perhaps consider renaming 
DW_VR_MII_EEE_MULT_FACT_100NS to DW_VR_MII_EEE_MULT_FACT_100NS_MASK - 
possibly in a later work?

Cheers,

Paolo


