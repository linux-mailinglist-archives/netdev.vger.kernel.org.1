Return-Path: <netdev+bounces-94636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052898C0072
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726D01F242FB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA10E8529C;
	Wed,  8 May 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RDB9WXtR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8D8287A
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179801; cv=none; b=laqs5hXVPQSoM43mFp7w+2J1zuz8FbCLG7WGgTEEms56qUpAQMN0/gMIZiOFwW+r2WiYh8pCKhnZCSJS8eLsrESlSCHD0xpie3osuFQavwX4JJj+U8Fg1Df/Ed1o3TylE1KSaKdooJSzQiNkVzvaQ81pGjtxmZnb9lMpz8bnXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179801; c=relaxed/simple;
	bh=7s/Fzhpxmj5p+eHO3dUfRvv7SDUR9XU2G1k6LK3U7SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thLrthTiWyJ9A+7+opJPgrwtTQArDm3s9ppOgQfxxvxqmQXpzRFrllqEVwP70PWJI4JhHGVfogCwKLOuLNTi0aXX23acfBr7PJ1SINXP5Faf2Df+rHWKG+Yq7l3Tc1P5Y1xs6tVbQJjrVYN27KQ8yXxewJB3YlhtToIS+kekfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RDB9WXtR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ebcf01013so5673205e9.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715179798; x=1715784598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zU4sVs3bD6njtdJxXKdtXzlr8SyfUTQgU9dfFsWRgRs=;
        b=RDB9WXtRoaA9VyWJkVrqfyUtQCPeq+15Dganu08TcV7jCprQFNFFabNH6Zh/JctxvU
         PodoMAGMzJLPq5lJsEUQl1YES+fqU5Kn+7nqnOnzPaRoE6+qxrLC8kdJzOder7ObkUnS
         rIYAn2oSiGEwz0leIBkbVuq+DEquKBb5kbngGfpwwjj7nQQSWwb9YrtZsSmYVAk2A0yK
         rfBfDM/nHX6hBHxS+EcLh9H6FU3UHOqLRdqdpZjzpCtKcBPp0u/ifW3vcr0yPWqJRB5k
         x4lXZjMFw17//1mAHPbbRIbLge7c+I9dMhtw9ZpvpkfcMSvd5SeOgL9ndl+FScwraU+/
         Gaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715179798; x=1715784598;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU4sVs3bD6njtdJxXKdtXzlr8SyfUTQgU9dfFsWRgRs=;
        b=qEjfYhLNoH98ACEvBklkGHIqQ2GCHERbyScbbK/tawAmfK6ZkNEBhZgQTG8Ry4bY1z
         jQii534oDUssLz9kXCRYFsjKWJo4+eZkkYN0h/G/uHqhRMDx3drYzDDadCaaq7eL4Enr
         Fwgb3JFZVB2uP1nlP07hylmsDyUUwzeOSrN8Rz+cZ5BUVKKZxiHxmbQOdlOobdOgXgYo
         BO5zwoLy7UoROc/R0mmcqHSek0Ll9xPoINwHP5ngNhG4R7XQkajYKUJ/w8UwDlACTmL/
         rg0a+qKKmwnj9GV+PHwevzOdQe+WMow2JkNOb1V2grhBa/5EJhoWwdR7XusBuaBQeWZb
         LpqA==
X-Gm-Message-State: AOJu0YwAqhlG5UsixCxfqLbhrqdzp1KHDdK99lVuxu9NZGqFx+26Wpmx
	usHdz7KSiu0FnIlOsdTUZw6ea0MORTxA6w6VgrXhCNKsdIwaAmfxrCayQEA9Kxo=
X-Google-Smtp-Source: AGHT+IHUPmwb8/cUn8rR4kS61zezRg/h+3Zqc2+5SMtHNfpJ529W1vhrPdGvD3XWB2cdxCnkfZhAlQ==
X-Received: by 2002:a05:600c:1c13:b0:418:7ec1:7bdb with SMTP id 5b1f17b1804b1-41f2d53acaamr55851965e9.5.1715179797368;
        Wed, 08 May 2024 07:49:57 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:9ca5:af56:50eb:bcf3? ([2001:67c:2fbc:0:9ca5:af56:50eb:bcf3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b264absm25769965e9.10.2024.05.08.07.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 07:49:56 -0700 (PDT)
Message-ID: <e6bb4ab6-6ad4-425c-880c-eabb38fc45d8@openvpn.net>
Date: Wed, 8 May 2024 16:51:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/24] ovpn: add basic netlink support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-4-antonio@openvpn.net> <ZjuPWwPIByGFkxHJ@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZjuPWwPIByGFkxHJ@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 16:42, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:16 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> new file mode 100644
>> index 000000000000..c0a9f58e0e87
>> --- /dev/null
>> +++ b/drivers/net/ovpn/netlink.c
>> +int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	return -ENOTSUPP;
> 
> nit: All thhese should probably be EOPNOTSUPP if those return values
> can be passed back to userspace, but since you're removing all of them
> as you implement the functions, it doesn't really matter.

Yeah, I just saw the warnings about these errors.
I'll still change them in v4.

> 
> [...]
>> +/**
>> + * ovpn_nl_init - perform any ovpn specific netlink initialization
>> + * @ovpn: the openvpn instance object
>> + */
>> +int ovpn_nl_init(struct ovpn_struct *ovpn)
>> +{
>> +	return 0;
>> +}
> 
> Is this also part of the auto-generated code? Or maybe a leftover from
> previous iterations? This function doesn't do anything even after all
> other patches are applied.

Ouch, I missed this. Definitely a left over.
Will remove it.

Thanks a lot

> 

-- 
Antonio Quartulli
OpenVPN Inc.

