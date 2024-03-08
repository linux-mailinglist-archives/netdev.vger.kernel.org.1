Return-Path: <netdev+bounces-78561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C8C875B81
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3379B209DA
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96997A34;
	Fri,  8 Mar 2024 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eG9rl+ym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2B363
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857260; cv=none; b=O6TxjjPlHoGcvNq/zZK94QlQZCpPgboW96yFK8FAu4kQ+LAf7iqo5sx3lHJ/WC7E1BC277Pk+qDcGQSwezNvlsvb7vavaK0i+/CsnJcBLYF3+qrBh9D8IyAnU299yufyWXYpd5XBfdJb4NEHDfanlhynha2OegaEXli2boRSryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857260; c=relaxed/simple;
	bh=O5Mm0fFszEHLnZyMrj73+AhT/VRQ77tWAOvrmhIfgGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPluZFcYBCtPBW8k8jlSZg1umSMUWhQLx6L6Uv7OtXZrPr8RCrVPilNWkhdPR4U8zUZoyJD+e/NHq/qLTJLGChNKwa4dtna5pWf++/vO9vRYZ0at1Itw+gT7Jdcy7cLvUfVg8LtrtWME1hky6mYoQ6nReJHDByJsKsFpFkDRbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eG9rl+ym; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so1764722a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 16:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709857256; x=1710462056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e3WAYJkEfpureQlpdROdyh0TrqzFFGsk4AOPmQ5+vPg=;
        b=eG9rl+ymWTd36sHQiHVkB3gY+pt10AQYkthh/KwYQlOLLx1R+kBGhjR37rKvEsh2ol
         NxE/FR+D4JlgCKzAYiSjU21OBTIWKZRwtst5C74KyBsD7pENofKfiajK44nYpCsAoxwu
         bSGSTRCyvslYx0Oyz6RUjERFEM7VsnboYSy7lnpwjSbQ3Vvo2UnWLxxngLM8QDfuthtV
         XGEpg6CVVI05qn7FBDzwaMVwJuKdl/opFDL9eQ4elvGbmwQHeNIZnfMWN6rOFHDU9zdO
         8dIoqYmEtRspNxb48hJNjNIest0cctkRh6gwb1hSR6TWTssAJ8ZJ1piF8pC8d5lTbG5j
         ov5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857256; x=1710462056;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3WAYJkEfpureQlpdROdyh0TrqzFFGsk4AOPmQ5+vPg=;
        b=tiFqLxSpurotqg7+0KgkkL+LAjasH+va1KrcwgJjkohQBVdOOSJqyv/wrGDlTuNE08
         SynkL867Kzgf0OUwyssVXNo+3WdPve8G6ZjzG3hgvdoyTFZPhhiCHmOMEjI7YwjaWRCS
         LekfN+HCLUXDO151cWnSuWpOS9CkZyuv5NCvqveAjg2VVAwQ29PBNprKfz6pZ6JHpzis
         WntgMVmxBB6al0qeIoQ9JkWtN9K7FAUPdSgij/bUUqCeOl7fJs9URZta3//FszmHkXVy
         ABVNHaY52OBMBMAnhs9o84KppR9nlEFNyJ+D6BazhwCT5TCkwtY9FAOg1CVZW4WpMMQ/
         7TBQ==
X-Gm-Message-State: AOJu0YxlvNfvCBul+NUGhehd4/f44YYjYpWsywfCOHlQqoSlBgXJQxZ/
	el1EOyusIOtjGKxoBvvm5U9ZYh7obqQmprGrkFfDf9JMnJ2bem5Mc4FOYWcVHO0=
X-Google-Smtp-Source: AGHT+IFS8PLhN+V4ymM/rMu2Pba5F5/TOfxZ+PAXp18O2CBq+vA9Yak1il+UQKT+Z1LJgMTcnSYvYg==
X-Received: by 2002:a50:8d1a:0:b0:566:6e4e:cb8c with SMTP id s26-20020a508d1a000000b005666e4ecb8cmr706521eds.38.1709857256600;
        Thu, 07 Mar 2024 16:20:56 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:460d:9497:9f21:53e7? ([2001:67c:2fbc:0:460d:9497:9f21:53e7])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402321000b00567e27c72c4sm2453744eda.62.2024.03.07.16.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 16:20:56 -0800 (PST)
Message-ID: <41b3f150-f4a5-47bd-aaf5-ceb2498a647f@openvpn.net>
Date: Fri, 8 Mar 2024 01:21:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/22] Introducing OpenVPN Data Channel
 Offload
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240305113032.55de3d28@kernel.org>
 <31c1d654-c5b4-45a1-a8e3-48e631f915ab@openvpn.net>
 <20240306081322.6f230dc5@kernel.org>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240306081322.6f230dc5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2024 17:13, Jakub Kicinski wrote:
> On Wed, 6 Mar 2024 16:44:41 +0100 Antonio Quartulli wrote:
>>>    - some basic set of tests (or mention that you'll run your own CI
>>>      and report results to us: https://netdev.bots.linux.dev/status.html)
>>
>> I currently have a small userspace tool (that implements the netlink
>> APIs) and a script that by means of netns and this tool runs a bunch of
>> tests.
>>
>> Is there any requirement about how the test should work so that I can
>> make it compatible with your harness? I will then push it to
>> /tools/testing/selftests/ovpn so that you can pick it up.
> 
> Standard kernel selftest rules apply, we try to keep it pretty vanilla.
> Test should exit with 0 on success, 1 on fail, and 4 on skip.
> Skip if there are any missing dependencies in the test environment.

Perfect

> 
> This has more deets on how we execute the tests:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Thanks a lot for this!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

