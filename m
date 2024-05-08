Return-Path: <netdev+bounces-94484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A528D8BF9CE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282CF1F23EAD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB64757E5;
	Wed,  8 May 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gtxCcGLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6D74C09
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161834; cv=none; b=VX6/cCGDGlV62b4kpVG3TU4eRa1qwyQTFvsu/yAN72hEFf1bFl6N1B7vjNkqAroX68zM34sHPEgAvfddMXIwlDVADiiSx6Zm5gsKwEqSJ5FtkuZ7sV51+Jd1AqZoCJT+sFIn/4Gd2GoskA50HldtWm7l9ocY/PoSlMntk9xsgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161834; c=relaxed/simple;
	bh=cRjRS/cMKeoLTJgG33gVEgzCpEjnvRck1fwtfaDHr7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO5KwJrfynhOkzn08J8sufC9NrjWoIaCHcODJYlTtsrusdfdqOayApYFU+zOLRAnf19Vgtg3rjYYlmnCJW/d+HmzN1chj7bEkeTfoJ3Tmko4n+Ff/c0i41wuw8je6CrSxjQYy7xW+ei550groUm76Wr6HNi6Q94scddAlk4+Pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gtxCcGLH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b782405d5so42929615e9.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715161831; x=1715766631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+rk8ggYpHNs4UpHmlZDxsel9dfisZ0fPmpK7vgAVBBk=;
        b=gtxCcGLHZ+lUPwLCUdglL4iF/K7ddnMxlDRrL+zKRur4tVorbtPuX62eEQsa0Hmlxw
         ixWUzomnU5p9580zRjA+koWiIZuvOEcQIvZm8Khf0D4w6DRe361VxdzAza8KTjZLmR12
         IjKO1Bw2UBlxLHLtCjl0EAhl+ivcfKd+ejIxOekzBE/bX/VYf13M9cW4rkX5HlJwQLqc
         6sE7pX+82I5/P0EWLhCAvun+9gn7Qe5zPhyprftQlHgiNIuCViVlMAGGzoR03z5JeJIv
         nQvNVGmOZqIn4rnLeeZuPkwn9lazvrTqDbmrFB1MBjPbIQoNc5KGqNnsBKX89i8Xx7il
         f5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715161831; x=1715766631;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rk8ggYpHNs4UpHmlZDxsel9dfisZ0fPmpK7vgAVBBk=;
        b=qmWxTor+bP6+Oct7/Xg3FOLMcESKA+Ap7eBbnvVmMgpXULojCqPA7CGdmoRVfJlF6/
         t/RJLS7yQMmGpfQsVm2ShojYjD+yrILlmFVVVsBTQRBr6XKFTbDNvAy7hRN8+g82ueZn
         uOeoaDy0RXJqe3zB3B/Af9GY1C+gwOfFnqxqPh3Tq6OpbJWgh2K1/si4JyC9raBKNlgh
         94cJSULwJVyKWytOBCfZllCW2mIgKYcYyrM0bMJYgIaXCkkDa3kVCAd75YmCjOM9ZoZR
         xPYMeYYgetdr2VH8WZKOX5rSLaC8+xCLbPevVNHRNANOEDFlGIXZdxMWCyqxYGunnZAK
         1olA==
X-Gm-Message-State: AOJu0YyoJdqoI4SVOz4z4YYQvw7l0G5rBJxmVbZ3r1oTQ+G0hPUwQc7e
	w/l+tXVIgMMt7JLCc4Upyi32v7WkZ0bdw78hEBAeWEenYeA4pwl68Zj9M/Itxb2cMSqlCAlhbyx
	1
X-Google-Smtp-Source: AGHT+IEE/gGU04xhZcaRHUS+qjsVVjSK+ZpYp1Oqto4gZ2rh2tglLrhBYXY9GSrL5mM0qtYTQOIukQ==
X-Received: by 2002:a05:600c:c09:b0:41a:e5f5:99f8 with SMTP id 5b1f17b1804b1-41f714f6dffmr19657335e9.18.1715161831084;
        Wed, 08 May 2024 02:50:31 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:9ca5:af56:50eb:bcf3? ([2001:67c:2fbc:0:9ca5:af56:50eb:bcf3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c235e2sm16883015e9.12.2024.05.08.02.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 02:50:30 -0700 (PDT)
Message-ID: <d32b5a97-df69-4486-98ae-f73d9f3fb954@openvpn.net>
Date: Wed, 8 May 2024 11:51:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 24/24] testing/selftest: add test tool and
 scripts for ovpn module
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-25-antonio@openvpn.net>
 <20240507165539.5c1f6ee5@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240507165539.5c1f6ee5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 01:55, Jakub Kicinski wrote:
> On Mon,  6 May 2024 03:16:37 +0200 Antonio Quartulli wrote:
>> +CFLAGS = -Wall -idirafter ../../../../include/uapi
> 
> This may end badly once the headers you're after also exist in system
> paths. The guards in uapi/ are modified when header is installed.
> It's better to -I../../../../usr/include/ and do "make headers"
> before building tests.

ok!

> 
>> +CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
>> +
>> +LDFLAGS = -lmbedtls -lmbedcrypto
>> +LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
>> +
>> +ovpn-cli: ovpn-cli.c
>> +
>> +TEST_PROGS = run.sh
>> +TEST_GEN_PROGS_EXTENDED = ovpn-cli
> 
> TEST_GEN_FILES - it's not a test at all, AFAICT.

This binary is just a helper and it is used by the scripts below.

I only need it to be built before executing the run.sh script.

Isn't this the right VARIABLE to use for the purpose?

> 
>> +./netns-test.sh
>> +./netns-test.sh -t
>> +./float-test.sh
>> +
> 
> nit: extra new line at the end

ACK


-- 
Antonio Quartulli
OpenVPN Inc.

