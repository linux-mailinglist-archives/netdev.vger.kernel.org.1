Return-Path: <netdev+bounces-54636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 681B6807AD4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE6A1F215B6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E854654B;
	Wed,  6 Dec 2023 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs8JIsig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6301D5B;
	Wed,  6 Dec 2023 13:53:11 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67adea83ea6so1971716d6.0;
        Wed, 06 Dec 2023 13:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701899590; x=1702504390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRsmCfZPRNHAmp69hbxA4nNZpGMatj3IE3IFRot8VPk=;
        b=Zs8JIsigjf0aghaaFTbbW2vZmB0WxAUBZVsOKJ6ZwzFvjWhVeakpf8Ngce7sdKg8Ic
         76zn+tdvlwxMQEVdrDtQSz9pSU1jGMntBAQWv1uoQTCMdaTHQRUwZTmWoV+mklJekQrV
         i/d7eZqsnF8acFXNPFIOi7Vf3Dzx8MxSe6k5xlUo2mC6DUkK6Gx4tZTV42nFfsaOs2ZA
         Egzp9V9uy+i21y0S3X0OYO0XgZnTAalkw2L5VG7pucsqEy3n3EsUTYN4AlrQnjaIL3Ib
         VO435BluLvnnXY8cLNsTHTwCYp3YGEZA5c3NX0oBvzjulGgVAQSSY5CDRGXAKLNDt3e/
         Dq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899590; x=1702504390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRsmCfZPRNHAmp69hbxA4nNZpGMatj3IE3IFRot8VPk=;
        b=hyY4D7rPk7Vjypsh3pATc9W9Jc1e4xc1djA4B+oCRsUUhIU/+/rgwPQ6pq9cZSakO7
         GQ0A1Mt5SxHMVYjWlAWqksQCkBdcsa556/Dq3hFoMSOEiYbMI6yJhNmfggQaTTIrRcBR
         9ZSa8NVmVHHae1xNF7ubaHDLZYo6X4Af8/zVvaoP2YXPWZ+ySejHWXrO0bg47vi/ARzR
         Ld/uVp7jrmKbsTOc6qM4E7fyVp6HqMCtXd9wOLlJbNVljWOawurXg+x2qtPpIrTsU2Ao
         V7X061YxGUHjQrZbNNyesjwQDJdDzJ6l8ivsdSODHxd6HbSMzmsYZMwXStEHM2/4VzB4
         VQ3A==
X-Gm-Message-State: AOJu0YzVdP4pE0hqvc/hM2AIIZlG5J/N9JdLxo/sfNbkk8S8Q8thzvuB
	0H4+GAtqOELGx9ywv0nCFCY=
X-Google-Smtp-Source: AGHT+IF2waxUW5G+Z+mwHnaUnX93Wr+Oe8l8z8LxWECLAhTi18WRGaDOYh4fdtXC/TpAUPCWHHj0ng==
X-Received: by 2002:ad4:51c7:0:b0:67a:db17:c736 with SMTP id p7-20020ad451c7000000b0067adb17c736mr1656907qvq.62.1701899590481;
        Wed, 06 Dec 2023 13:53:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k1-20020a056214102100b0067abfe5709dsm292192qvr.139.2023.12.06.13.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 13:53:09 -0800 (PST)
Message-ID: <d071fdad-79cb-4b8b-ab18-132b6c77e2ed@gmail.com>
Date: Wed, 6 Dec 2023 13:53:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Content-Language: en-US
To: Sean Nyekjaer <sean@geanix.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Christian Eggers <ceggers@arri.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231206071655.1626479-1-sean@geanix.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231206071655.1626479-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 23:16, Sean Nyekjaer wrote:
> Provide a list of valid protocols for which the driver will provide
> it's deferred xmit handler.
> 
> When using DSA_TAG_PROTO_KSZ8795 protocol, it does not provide a
> "connect" method, therefor ksz_connect() is not allocating ksz_tagger_data.
> 
> This avoids the following null pointer dereference:
>   ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
>   dsa_register_switch from ksz_switch_register+0x65c/0x828
>   ksz_switch_register from ksz_spi_probe+0x11c/0x168
>   ksz_spi_probe from spi_probe+0x84/0xa8
>   spi_probe from really_probe+0xc8/0x2d8
> 
> Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission timestamping")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


