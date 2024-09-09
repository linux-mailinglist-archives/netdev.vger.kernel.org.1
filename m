Return-Path: <netdev+bounces-126424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62886971228
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80ACC1C2273F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE3915B995;
	Mon,  9 Sep 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JpktX+Ql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66876175D25
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870815; cv=none; b=PZtKaORm38bV+oexyru6ReKRxXGlGl2xSXoMrKskEff4YFYPm5aa6cHIx7BXZLYG8eiY68AvwfmiaXvX5A2X9Y/TcI/rMy3WQ+rpOennZ0GwKefY28gJ5cM7p2squjHvg6PBgoyNyv2KfJMGYxoH5OjUf7lAOYoJ/UW6N+EXRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870815; c=relaxed/simple;
	bh=lMULub7fvl5hvejWbbg3UsfCpXmQeCRYlJbmZj1fryE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRv5L8mykIN+CmFV8wqQ2ykXpzMoAd+XUgMZscMmOTUowidbOjv9JhF7RprtNTjtGy7CYXlsKhI2RczJnHwvN51bwWzD9mzgZuEFXaoWXqSoUjFJsTKfP1BUjzR3eprJtcwCvwdLhKjfY5Md1wnsUAtYtaYXvd0fa0zgmgKl1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JpktX+Ql; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so4210321a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725870811; x=1726475611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ahA/cLlJnK7xMozIJl3mE78cloNeYgnz3C8599NVJ4=;
        b=JpktX+QlIoiXFqsczmR2CudLqvNtU2aJbkJ7bm0Gb6kFgKlY6JHbNb/9Y+jDAdEZVg
         SVgxyPpM3xCcRbmnfzmHxAr+ZjCd1IhzsiozB+bRpwfm9Cmav+KxtluFqrbTTQTuzJgI
         EAjsxi4CCJIVjJZK8ZsAmT+EX4JLfz4nWlbH2ukvfRaLa2eRFQaEipcQ1wQ5aCkGP8PM
         CuG8L9LfeZZ5TAgEpfmfIy3L5zMjI+LEq2O3lAQ+nik8uyRMq/1vxXXi4wEYgvBYZH1e
         16XsPL2lx8qgircPH18MEBNaSTk6p/MNu8LXdJawoQGUoq9d+qvpt0mMfn+0J5HdhUEv
         FzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870811; x=1726475611;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ahA/cLlJnK7xMozIJl3mE78cloNeYgnz3C8599NVJ4=;
        b=gquykoBL8hvZPD7+65NRc8Qh9I9OaUEYEcQIA6bHjNoBh/OSOTKukHZJM8Kv9r73rG
         UYBiiQpSq+4Rl+HV2TvqTTuWbA3XC+JmbCx4QTPf6Ryn0M3hB4blm12kn6mVDrJFUCLk
         DuEsM3qrNT3JEBdeNABpLzuKoaTRRDhuL7vUeNDzTT35XTI1uc5+sQzb29QebL8pvutg
         04dniyZrWiCRWposJyDB/IC6kX1JOC9UOVLswqmK/p90HSHulvwD3vzLgjQcHJ+grz3J
         7onCRic6U2P1Tv8e+aOyoMxAVBfZf1cY72iuVAu6wknlh0rd89FgXwfVv6bk5i83SQBE
         wVtw==
X-Gm-Message-State: AOJu0YyNySJZvvOczSAqLkBQ32G9XFeqH1wWAXmn1h9ptIuw4ysN+VX0
	/MulzLrLCPy322OLiBfJ5B0BFDmm60WKuW6Ey3X6TY66O5DIixM1/bLf2r1xh+A=
X-Google-Smtp-Source: AGHT+IEK9WVOJkwdvgRnwFUDDlokQA4+0zu6z0O3Jyeqe5pNTBK1M3TVVMBzQ0ubKNDySp7WcseRCQ==
X-Received: by 2002:a17:907:6d24:b0:a8d:11c2:2b4 with SMTP id a640c23a62f3a-a8d11c206b0mr651346266b.56.1725870809300;
        Mon, 09 Sep 2024 01:33:29 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:105f:6dd9:35c9:a9e8? ([2001:67c:2fbc:1:105f:6dd9:35c9:a9e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72861sm307251366b.105.2024.09.09.01.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:33:28 -0700 (PDT)
Message-ID: <5f8054be-87ad-485a-9cb1-179eedcce2ae@openvpn.net>
Date: Mon, 9 Sep 2024 10:35:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/25] ovpn: add basic netlink support
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 sd@queasysnail.net, donald.hunter@gmail.com
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-5-antonio@openvpn.net>
 <20240906192654.GN2097826@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240906192654.GN2097826@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 06/09/2024 21:26, Simon Horman wrote:
> 
>> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
> 
> ...
> 
>> +  -
>> +    name: keyconf
>> +    attributes:
>> +      -
>> +        name: slot
>> +        type: u32
>> +        doc: The slot where the key should be stored
>> +        enum: key-slot
>> +      -
>> +        name: key-id
>> +        doc: |
>> +          The unique ID for the key. Used to fetch the correct key upon
>> +          decryption
>> +        type: u32
>> +        checks:
>> +          max: 7
> 
> Hi Antonio,
> 
> Here max for keyconf key-id is 7.
> 
> ...
> 
>> diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
> 
> ...
> 
>> +/* Common nested types */
>> +const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1] = {
>> +	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
>> +	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 2),
> 
> But here it is 2.
> 
> Probably the patch should be refreshed after running:
> tools/net/ynl/ynl-regen.sh -f

You are correct.
Thanks for pointing this out.

Will get it fixed.

Cheers,

> 
>> +	[OVPN_A_KEYCONF_CIPHER_ALG] = NLA_POLICY_MAX(NLA_U32, 2),
>> +	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
>> +	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
>> +};
> 
> ...

-- 
Antonio Quartulli
OpenVPN Inc.

