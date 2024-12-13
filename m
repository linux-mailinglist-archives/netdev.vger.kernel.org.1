Return-Path: <netdev+bounces-151833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F039F131A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D707C2859EF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04C1E32A3;
	Fri, 13 Dec 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ttg4DXlk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E81684AE
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109199; cv=none; b=WXihMUWE21oh8u3idCJiX9MZpUM7gA4xks8nYEyyAuwZxmE6uSJoAt1+zf4EyqIf1kjYuzhQKlIAG+EYBEiP2ij0+95MZt+zZfvvaAY3QdRjGQtIQ+KkM0cM1N2D2tZfhMlH5Ju+lnHSf3q+C7Z0VHsMSFwbK1RRvcdbpdAa+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109199; c=relaxed/simple;
	bh=D5q+6FCLqWLLJ85MFitx+lnu7jPp6UpZjx2q/w7iV7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxgaeoaXu9u8VW15wjI1KgW6saiJvVidrwhlhlf+QZN9emi6mSiPkp5ef+gRcx6y8bDbqq6pE87iIFnay4CO1NMp6v5aSxUuzYcNQ8yqW0jLvMDRNF+e3fs82SeutbZORwVBi9mBa1CBB3LbPwO+44XkInjNmz5xOyufbh+4k3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ttg4DXlk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa67333f7d2so298029766b.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734109196; x=1734713996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eT6uCDU7W6zklXVj2xFWni1AXdhVUk0J9QH8VWWf8YA=;
        b=Ttg4DXlkELRqjFiBYTm56ples4ibIVg62VpRx8zc4vH2j59lCbrVsOK3dU184swlyM
         O/x/jE5IK4CITMX8pPAHMoDsYSFn9+qPWZKF2arhcW0R5phqw5geXxdspXLJVN9qfS3m
         KBwABhzs8HNwGxr2BPlGryy88eh8g0d2oVwsmPqRC6n0kiPLDgSTzDsGzLW3L5FbtZ0r
         vZCQ+aWEhzkt8uj9F5KMzsVS4WqnVDcKdGrg2mbrcdAk1y0pOxFnCL6/qwDxXXw5Yhj0
         ggD0pAJADWdQ5GpCek7rOxazqzl47iTCWRGxTizRI+8bRq7RHG5KNGvygyF8GT1PSYrL
         mbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109196; x=1734713996;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT6uCDU7W6zklXVj2xFWni1AXdhVUk0J9QH8VWWf8YA=;
        b=nFmHvLIkn/F9cbrS4cJcoC9BHrMq5JyGNKYKHJpx5X8sGukjJhadVjhPVvBySjBhFH
         bqPAOv/fSyC/F4EhkDmDiqKbl6QItygiCUOwfHpK0JecisassyP+bqyuAzrrxEZor81W
         xU/wMa4bGGIlgPKqPDCfN1DnbnzzfEPxjsgX3lXZXUnYIBoOyoZF9coZRXr6NtiFajMV
         w4MO1/LAPTIZ+jx8IPdUuDLaYf4t7bIQJ5wiyhtGp8fboGdsu43v3Xzqck2w5nImGpdH
         MY/GpCGQ8FgeKI/fDjigS8PMf51aNSpq6HcLCy7RowMP4XKUiMKuRSYxBCWrHNpirluO
         AyHQ==
X-Gm-Message-State: AOJu0Yy06cnAXD8ssBzByedyk2NyDYIysEM9HQDPcpFfOklW4e+bl5Wx
	ZC8kIBWslP3vhnUvQ1SbVOkFM+aLioGt9gcnKzfugUclypBLWp6D/izWNGBrX78=
X-Gm-Gg: ASbGnctC+k7bb7LO0mPFT5Vj334Ai9M6JbGz9dM7oEa/0ISBKZW8FAT4ODSP9514eXx
	hhSWWMYzWEW5gq3KV+6rzlTHS2kRq11+JWPyoVX6MfGb0RxyO1KGwCsU6lDs4GbJIySz5vywP2h
	m18G3qXmx6p6Nm8m2AdBVjr7KOJitbFDwgllGdYn3DBZePbog2dZEp3CceFdIpwo8T9cyD93XqP
	a3BqG3BL6y60/Uc9b9YrZXVVD9OHU6zNs6XskGZejHO6Du0vcoon3WNW0+SVQm/t2EeqymtXu3y
	MyiKWpakGY0Bfb0/m5Q=
X-Google-Smtp-Source: AGHT+IGvq5gARCsDTDwvtydXjxgAKnMTa84qgXrjvGYS5bvrWzXzgM5Vma1iXTGDL0ZEw4mt5EB9rQ==
X-Received: by 2002:a17:907:7f8a:b0:aa6:7ec4:8bac with SMTP id a640c23a62f3a-aab7795ff10mr429979266b.17.1734109196098;
        Fri, 13 Dec 2024 08:59:56 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b5f9:333c:ae7e:f75e? ([2001:67c:2fbc:1:b5f9:333c:ae7e:f75e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa685669acesm746832466b.189.2024.12.13.08.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 08:59:55 -0800 (PST)
Message-ID: <786716e9-17b9-41bb-80ca-b65def682f5a@openvpn.net>
Date: Fri, 13 Dec 2024 18:00:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 02/22] ovpn: add basic netlink support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-2-314e2cad0618@openvpn.net>
 <CAD4GDZwT=V5-3aAb7eHah5fjLC3R1CrBCVA5kUFywb+ajOvzDg@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CAD4GDZwT=V5-3aAb7eHah5fjLC3R1CrBCVA5kUFywb+ajOvzDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 17:45, Donald Hunter wrote:
> On Wed, 11 Dec 2024 at 21:32, Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> +        name: peer
>> +        type: nest
>> +        doc: |
>> +          The peer object containing the attributed of interest for the specific
> 
> typo: attributes
> 
>> +          operation
>> +        nested-attributes: peer
> 
> I also spotted that the doc: | construct results in extack messages
> with embedded \n chars in the ynl cli:
> 
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/ovpn.yaml
> --do peer-new --json '{"ifindex": 2 }'
> Netlink error: Invalid argument
> nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> error: -22
> extack: {'miss-type': 'peer', 'miss-type-doc': 'The peer object
> containing the attributed of interest for the specific\noperation\n'}
> 
> We should probably sanitize the strings in the ynl cli, but you can
> specify a flattened block comment in yaml by using the doc: >-
> construct instead.

I believe I have used | because I saw it in other spec files.
We may want to have a look at those too.

> 
>        -
>          name: peer
>          type: nest
>          doc: >-
>            The peer object containing the attributes of interest for the specific
>            operation
> 
> extack: {'miss-type': 'peer', 'miss-type-doc': 'The peer object
> containing the attributes of interest for the specific operation'}

This seems to be what I actually wanted.
I will change all |'s to >- then.

Thanks a lot!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


