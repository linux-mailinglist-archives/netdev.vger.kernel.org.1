Return-Path: <netdev+bounces-206719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F47B0431A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA883A37CF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A825BF13;
	Mon, 14 Jul 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laKAG7sw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989925A2C0
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505857; cv=none; b=Eja1VFkf7ZuJ6dZaKSCip2QThbZZG6DDfZ98X9r69ofXT2OD6lCw7Nd73Ev9SPvJVo9kLFRVboY/ig+v/kTGvl8V7kvpvWuf/RPXDeMU0ZylFxPrfOpK+ADFjjKIDTXthsHC5tjqiHw1zgl1jDopKLC0zhUlo/7QDxXtXnq/I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505857; c=relaxed/simple;
	bh=snV1h/fsrCacfsgF5T0Qgop134NGknVucVw8EfRNh94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p09lX6AlVA1XkeGrTF3mK/VOMjXxLrLqHPRuUkG4VEPgFi6+Zf1JD2xPoqwenxXHjdWfvPZ/hDP2flRuh68XMoOl+Hp/OuXVqy5eQYRNenf8WNcl30S6Igr8fDYI2Hc9TKdAB2zSichkiVu2mQbZcrnbzvmmzOUItN05G1amYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laKAG7sw; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6facc3b9559so58568526d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752505855; x=1753110655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fv9SFZzpMCzAW/BPsWGqCjkOKDdV2QO0uyk4yHaHxpE=;
        b=laKAG7swuGC5pD6t8RgREMq5QgyKfZsi/L+dow+pCxN2VpdpNoeAkf4Hf/a4pqFpIc
         ViD0yYG9gI3d1fqu7NrSI9CHQWLlV+i7XGt2yin4wKmRGFs0PQdajfWQm85QQ48N7eLi
         uHlRewCzJTv6/yNpo9pDpkBCkgNmK505bqwVQCAsm0wq2dB3XNnyYlg6l1sClup1E2cR
         sLOn8iqZeg7Yvj/qFDT1BnYEJz0wlD6Yus0jmiI1jxmTIbMm7kXOnUuuFLp79Cnd1cst
         myErBrQg0HNakRCIjCfyqTZwDDdTZBOcjohWKz6Fbw6XX2wQ38R6fUMm77kJtZj7FIDO
         7cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505855; x=1753110655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv9SFZzpMCzAW/BPsWGqCjkOKDdV2QO0uyk4yHaHxpE=;
        b=HlMEbG25ksLCMRVvnhgfCRc25rKdlKI2lmOCy1X1F66NMmboHiM6XZlee5d3Y44Yjg
         vBBAHu3o+Pd4tu+0KEjGnDdZNcRADSsKoP2aq2Bk4dHYkfBMy91Sjn+sxcBykByMGTyO
         hnxZJ8gLnJ+xz3QQPm3JT8Dp4tW7p5nnLhoTWbkI7m2m+5oLIfdF6qcDcqHnf3q8NszJ
         GyUuIgwNf1OalgYN41gxapyX5RuRa1eJr7Ne96MBDsvWNzjKQzxatk6J3IHFRdOeH8LR
         1CoGHVkRHlC4GnlsQ/YaI/q1PU5iXLYM8YhTQ6F9b4BIQtoJGNAQdb16CA4ZyP7lAbym
         ggaw==
X-Forwarded-Encrypted: i=1; AJvYcCXGjwCYFJKQmFSA1T9l7GBuilqEijWLoYDCOxpD/Qt+7jvYEo8JAcSytg6NExREYj6urp8v8h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16tfdVprkHtA/7Cn6/QsS2xjPp1MvEVJSguUv7X6xkPcT7era
	3Qq+AIvSVmFHTapMkVtuCmNDE0YSN8D0kZKBA3Fp1mXwSLWok6Riq2p5
X-Gm-Gg: ASbGncs4bVMaX4UM0VBK+B3xLQPq3lzAroKyB0y6wn9dPj1KV/Ta1cW0v0iKAaV9UYD
	ttJAf+F9QSsAQvGgzexXVuJYtITaJA64tneTEOBrFEAen52Z1yUFmKi6hyml9uvtfCfmMamcRnZ
	9utI/M4u3xMiCSiMK65Tyz2/oo8yawaDnhhRWoyXLRMT+XAZSCMsf+Rep8roOH+J6Agw6rrVvjz
	G02WjGHOD1gijI3hWs8gMrGnbY/K4WLki16FG6aSkFZUf00jxZrDiAUICCqZ4eiaxj/gZSVN/6R
	DfreTS1UriDVU/uiq4cwkJ1k6Pw6uO4EHzFwlyYZrolmWSARZ4ZFuH9aa8/lk3RwtsyKv/CQyqk
	7mtCot58S+yhrB9W8sBZPeGVK8g5JRzMB1Mz9VrtHTjTSFL0q1A+8F55y4IN6mgn3L3h6gFpwCm
	iy
X-Google-Smtp-Source: AGHT+IEWvLNDZv2gQ4nTyTXSwwgFgCpJcIsRZFHQPUVv6xkzmCGHBgn6gHmZu1/8GeBLaHMxUs558w==
X-Received: by 2002:a05:6214:3292:b0:702:be81:c3de with SMTP id 6a1803df08f44-704a39518aemr192285396d6.30.1752505854933;
        Mon, 14 Jul 2025 08:10:54 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d75351sm47983886d6.95.2025.07.14.08.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:10:54 -0700 (PDT)
Message-ID: <47f5b04b-fe78-4e61-8bdd-a50348ea14dd@gmail.com>
Date: Mon, 14 Jul 2025 11:10:52 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/19] net: psp: add socket security association code
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-9-daniel.zahka@gmail.com>
 <686aa894a8b6e_3ad0f32946d@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <686aa894a8b6e_3ad0f32946d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/25 12:47 PM, Willem de Bruijn wrote:
>> +    -
>> +      name: rx-assoc
>> +      doc: Allocate a new Rx key + SPI pair, associate it with a socket.
>> +      attribute-set: assoc
>> +      do:
>> +        request:
>> +          attributes:
>> +            - dev-id
>> +            - version
>> +            - sock-fd
>> +        reply:
>> +          attributes:
>> +            - dev-id
>> +            - version
> Why return the same values as passed in the request?

version provides no information to the caller here because it is echoed 
back from the request. I will eliminate it in the next version. dev-id 
is optional in the request and looked up based on sk_dst_get() if not 
provided, so it does provide information to the caller. This socket to 
device mapping will probably be needed to respond to key rotation 
notifications, so I think keeping it around makes sense.

