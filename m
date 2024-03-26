Return-Path: <netdev+bounces-82268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D488D031
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D4E320386
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC30413D880;
	Tue, 26 Mar 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BK6+qdhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F43FD4
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489155; cv=none; b=aNJRAjvy8n+Tkv0pG9sGI0GREMgCVpUe0y5Li9KTh8ZjWrDZLJBCkNNZk7c/vl1FPIVr7S40uXpICzHjOanNXhy3MkyzFdlvpX9y/8Ux0Xuon52RT15+TiQaNzlv5JUOVErBcCteAcfEGOeOk7omI5ppm0anpZk8DUU+zMD2Mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489155; c=relaxed/simple;
	bh=x7403aRLzAU0/OhMohqegZJduDKCwn657jm3tTNQeUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQr6rp12xs/vuW/+1rRINoJgBqGMnMOqLlrZ4y0pT+26marn9sBk/+BdPA4bpOA7YNs7gwqVJWYsQLouE1hTFscydgvbr9JkJSbocE7EkaGMmPMeJtq76kju5E7NNiuLW/Gr7JSI5GwStc57MBdvRQquj9GthqLT/NnR8DejwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BK6+qdhe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-414925779c2so2838755e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1711489151; x=1712093951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uyFh7UhDl5phmnWhGVpZOzhC9d/Ah5RaSLF6zMdSzyw=;
        b=BK6+qdheDMx4paFq6pNJKE9XOdn/4STQ3l6yJgYw7OzTKxQPFhQZmu3Cifxc1Hnuka
         ei/dS/5ANWT+aAkRx33YbD5ecLH+CrAeSQ3egexfi+sUQ23v/gIn86o1M6U1BIZ4eJQL
         ZRWsBgCclnLdPNBQNRo2uhHeRAM7jKwffITytFy3ipuhN3KowX5jmcRaL/bQwHNNXTJr
         uFwdaOMZdumIOajwrard+U8H2+c1KBI8LwAf5OY4lAdOrpyNhHRLt/dtOMKZvcMGA2X3
         Pf4xaovnMvjthuZy+QD1YGG8Dws/kSj34kK8oucwCqBGKLTM40H0TDZhLZZi2WDyMnr+
         2lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711489151; x=1712093951;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyFh7UhDl5phmnWhGVpZOzhC9d/Ah5RaSLF6zMdSzyw=;
        b=oVm5dOyaXvISQe1IHUcMlTPhQq7PniwW/n1Vs+SEGg8iFusd83ww+CsEgCROnojn5W
         Nl5dsZwR9CgZBzQqZf5y421k0181FQb740BqAdnGT0CcCXUE+8eRPAWWzOkN7exBnrTE
         9tmwIgslaGMn2QyDE1E4f+605K9TGt6leKXh3GgBnrYbH1rXzUPtJulMMJgTonZXYMGb
         BohKt/mI6X+yQGN0bweZ/D4zB35oMmM1vfzsJASYEdEIpDpv9Vm2kkyH/VRJU93sObd0
         Atig2bCRai8X7EK8m+HzzL5vOn5Ylzmrj+Q7YLAMieq5h+cUXrO/ArcxOiO3IIFv9bpo
         7dQw==
X-Gm-Message-State: AOJu0YwcSSMzClh7W/io3tMVjUkL+figrlnmlinZAnfDDAydVTobok9S
	O/D7IHZMRjHc0+NHeAr724geHbakjOqQdDXeijGz3eTizwgS1qGkl1TpXPne4/M=
X-Google-Smtp-Source: AGHT+IEJ2w66ikcB+AJsdLsTplhU6+cfGDATqXp/Z5KChk4VrKWsIPUz6XsV+eL4e0r7SrDIUNMdVg==
X-Received: by 2002:a05:600c:4f8d:b0:413:e63b:b244 with SMTP id n13-20020a05600c4f8d00b00413e63bb244mr601055wmq.7.1711489151187;
        Tue, 26 Mar 2024 14:39:11 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:2da8:e89c:e33f:a4e3? ([2001:67c:2fbc:0:2da8:e89c:e33f:a4e3])
        by smtp.gmail.com with ESMTPSA id jg5-20020a05600ca00500b00414850d567fsm157891wmb.1.2024.03.26.14.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:39:10 -0700 (PDT)
Message-ID: <1e2df22d-ffaf-4457-8d6f-079c1dcf9bec@openvpn.net>
Date: Tue, 26 Mar 2024 22:39:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Content-Language: en-US
To: Esben Haabendal <esben@geanix.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-4-antonio@openvpn.net> <87ttktcj6x.fsf@geanix.com>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <87ttktcj6x.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2024 12:43, Esben Haabendal wrote:
> Antonio Quartulli <antonio@openvpn.net> writes:
> 
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 25964eb89aac..3769f99cfe6f 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -101,12 +104,23 @@ static int __init ovpn_init(void)
>>   		return err;
>>   	}
>>   
>> +	err = ovpn_nl_register();
>> +	if (err) {
>> +		pr_err("ovpn: can't register netlink family: %d\n", err);
>> +		goto unreg_netdev;
>> +	}
>> +
>>   	return 0;
>> +
>> +unreg_netdev:
>> +	unregister_netdevice_notifier(&ovpn_netdev_notifier);
>> +	return err;
>>   }
>>   
>>   static __exit void ovpn_cleanup(void)
>>   {
>>   	unregister_netdevice_notifier(&ovpn_netdev_notifier);
>> +	ovpn_nl_unregister();
> 
> Any good reason for not using reverse order from ovpn_init() here?

not really.
Actually I also prefer uninit in reverse order compared to init.

Will fix this, thanks!

> 
>>   }
> 
> /Esben

-- 
Antonio Quartulli
OpenVPN Inc.

