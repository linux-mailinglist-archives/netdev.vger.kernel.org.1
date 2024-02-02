Return-Path: <netdev+bounces-68720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64789847AB4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF15A283CC4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFA6310E;
	Fri,  2 Feb 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceeZyWGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638E48788
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906979; cv=none; b=SmMiN4+de9uAuIjjnj2fAJ9bekAdlhVTwjtVsxHtHSRRRmnSTOl9NPP4kFBptgJdhF1q5refvMOkkU10Njwx8jF9kpnoFj0heCztEeTTZTOtMiMAeMdGwrdjsOASIUOMf6X3c1RjBRIK42Nsyh7aVVB3cEpCop7xeTsnGnVlcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906979; c=relaxed/simple;
	bh=8N4wOk90N8CXaqanetl5Ad0rHah/DO5pYKu/p2+7dn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx+AP5VgPHEI25m/A32DP1QGfp8B9uMIGEOxZlYy8kK/v0DcKrE7lKvZmsnIX0wyYNRlGsLYSZmB9rk2kqz1s3NSixMgz++fIZ/swbwkDG0n8TfJxY4rR+FYd7CI4B34ENfKoWsIWeCYF2i3J2kej0rlhQYyV79ZZ8+dvbQPg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceeZyWGV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so848083a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 12:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706906978; x=1707511778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sN7xemauWmjtqPIUP0z093eagdZIcXA/UYJxW0nyEsQ=;
        b=ceeZyWGVs+AIuT9xga2aJNtKd+mlZz2L47D4yVrorf1gOg2QjZOLKlGACpOi1PlFT8
         jln/IX7OfWzc/2kOaGhp47VomPLIBHC5XG4QJkKFoyyuk3c1B7TNKus5qwFA50IHozHV
         UmnwMkD+1IzrlPrth3YQOTP0VuOEhudoMAbdWAO3Rr6Td2JMmV/34bSrOMkhNLFjOo6z
         fIMBdezrsWdBcW2B48Ko1Elrpve3GKYTwDBzy2fFWbLJimcV5vGV8VoHUSxvpfcr7qro
         oypgBbXpTIaq1Cyuebsuh2oc7wmU6xygOpak0turgmt8/p+hDcz4W/LMx8m8K5GorfEK
         Owsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906978; x=1707511778;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sN7xemauWmjtqPIUP0z093eagdZIcXA/UYJxW0nyEsQ=;
        b=RouWC1dvUI+GJt2/cKbVVpCke1keWG9eI3/NAPVfZDIUB3P63NFA9AMYQHDO5pNlIb
         13DvcP7TrXHZv31nPwZXLB0dEOtvqMjRzgyRelMVLtI/uTeq8lZJTLhL8fSDs2wljPnC
         vpVNfMpumQ5HsVH76wppTPhAuvTZ04O0gSPQQ4nrBP3tHxb3ZFUI/jJAaoIBOPYLT0uO
         VsRVN3Vfk2B4ljry4c7682H+pMXU6mxARXd1x7lrAWpa80io6By9VeKHHtmZOIJSfmfh
         h4Kk6BFc63gQ3d5riS/79RBVJlLtkeQ+5ZNXL3uVubEvwitlpTdFc5MYZUnJbACfW/JN
         PIPw==
X-Gm-Message-State: AOJu0YxNg4MmrDsp9fQf5tJLiUyvOhPTx7noSKWZKTIVACgqkARtu53d
	EyqU5+nLrk9GstiYQeUgDpybmKnw1cGkwRl2+LY+gow2Z3I+2D0q
X-Google-Smtp-Source: AGHT+IE9VPHbKbcNocPJv88d/v1ipENvERiBVGXbylG4wps5dD4sUz8Nio0WB5MmB9jV4FHy+qfZdw==
X-Received: by 2002:a05:6a20:c78d:b0:19e:3af0:af33 with SMTP id hk13-20020a056a20c78d00b0019e3af0af33mr8856025pzb.60.1706906977627;
        Fri, 02 Feb 2024 12:49:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWnsXeWOo7q8jXWxIRVJsB5/SJhLMBhHMtD4TKqT8Kw/m05KJ7M12dmGkrZnSxQbAKTS+d9qVS91r1bQxNmsbfnhRpX9/0dk1EZa8lWliPOe2mcy6F/yVDv1lY9UMDJ+UB5NmuD0ztIPSikgCE=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3-20020a62d143000000b006e001635563sm999382pfl.118.2024.02.02.12.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:49:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f76d66dd-5920-4bf1-95f5-dd64f19826d4@roeck-us.net>
Date: Fri, 2 Feb 2024 12:49:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Persistent problem with handshake unit tests
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <20240202112248.7df97993@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240202112248.7df97993@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 11:22, Jakub Kicinski wrote:
> On Fri, 2 Feb 2024 09:21:22 -0800 Guenter Roeck wrote:
>> when running handshake kunit tests in qemu, I always get the following
>> failure.
> 
> Sorry for sidetracking - how do you run kunit to get all the tests?
> We run:
> 
> 	./tools/testing/kunit/kunit.py run --alltests
> 
> but more and more I feel like the --alltests is a cruel joke.

I have CONFIG_NET_HANDSHAKE_KUNIT_TEST=y enabled in my configuration.
The tests run during boot, so no additional work is needed. I don't run all
tests because many take too long to execute in qemu.

Guenter


