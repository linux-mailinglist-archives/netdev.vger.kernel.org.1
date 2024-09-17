Return-Path: <netdev+bounces-128708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C097B1FF
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40AEB28C34
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B8F1CBEB4;
	Tue, 17 Sep 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="aJgxCIXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2A1CBEAA
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586228; cv=none; b=IkjernV35t0SAQG8Wbn74uH/bYMYbub/loEK+29VW+0HkunjPiwvmdkgYk8VvYFykRlrhCE/DeIyzfAF2mghjz+kSOSQKHsjo4vDbkGUkFuEfX6t31kqUn6gzRYGOMxnqpgITkVF647iMiSZqKkWK3YJHqLNsQis35kRRdUv94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586228; c=relaxed/simple;
	bh=dYmqHmwE4TIIkBHQnaRqcSNmOEUM/pkEGoGGv/jZlds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvGipGl1/qsMzm6nuW8i44jxMoO1MjfHxL/96nXghp2YeQHAKvsx1jgEkxVNWBea86kE6CLeSq8A3fMat0+oWV583tk1zwUhah8VtV0JC34lGpTKjb/gSqAeI/xHiGi+FjBxemwWlzPXiO1YnxLJdtmjOwYGR14/BnPlFAJQ86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=aJgxCIXC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cddc969daso7950855e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1726586225; x=1727191025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=koqrbipiW2As1Od+mnmKMEvu8Pek+QoAGHQpIrnCp8w=;
        b=aJgxCIXCXd3ocjuVB3TmtZdzqcW1JeN7e+u3XtP8rq0PGkt3l7YUau4Uab43Ec7Xrx
         IrR4csTt+xBMFeZ53nDx3hPdMk0E+06SgbEwQ0m1YKJKMKlhg5pTRrVty82nIJwF2+H4
         HE42f9v9uH2Dt+C+WEN/7x/ldhCgmhzkqadCPyRZUKjy/3q+FUruMrVMvxbRQATJoOkR
         JCPkMffZEQom9dzFJ5v4lzAddwKaclQ8Cd58xsJVtvu0mv2WI4KkUgaan6sQZBU0uQvh
         Z0F700Y2757L5Q4pJlu9IN7DUOTlw786a69NDUiWB9Lg5yLuUasRsFOR0h63cS1aoCkh
         /RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726586225; x=1727191025;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koqrbipiW2As1Od+mnmKMEvu8Pek+QoAGHQpIrnCp8w=;
        b=Qn8nOMsviegRhV/GB/YXP5nju0PhwDFEFeXpiAvpMPr0A/mUnOUS/DWtwJJ/vHTCZp
         dYSVkAKec4QMdmzrNch7apX+3hUTN954Y5l8fKg+9AkWxRkGm8Vg+s5Mdm3pksNQO7RQ
         pIobYYK4AkB3WeJ/dwDnHa8VR0rBwJZAJuJPXGK2/2wVqsYCJ4m0yXhTbUBqcPg10McC
         ePkVaauZSuKebqDEHhkQKK2Ulf81nd1Ej151BMzR0iD3L0pfzcKRE+SAWX6gxJvoH2h8
         zHi9ySo/se4D3/GJqq8lSr0w0MgQzDfep7C6bKWoI4C8+SXH43gMCErAG/zOOxkITt2M
         p/gg==
X-Forwarded-Encrypted: i=1; AJvYcCX4VrrMRfYQ5FhNoHMUz2FLW2Bui+buSNVymBibVySEOPyGbIPAZs4RtSxgHTG/KK8dB8gy5I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgUfrP9iWrfL1jOT96R4PgdcUIpKNGHJlR6GvkH3ZKqMhseGv
	8MOksKONRYR9SQ8CV8JNZZdtQ1hLbExWoeedE2/AGnS2nGAQYmF/AYXZmYjMDqw=
X-Google-Smtp-Source: AGHT+IG2ZjilPl6Nj06rQss4TnVAeQOAZh8HOejB0df7Y5ziYJG13m1nzSj6veopVkV5xeCRkYCBHA==
X-Received: by 2002:a05:600c:4f8a:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-42cdb5776camr67382105e9.6.1726586224846;
        Tue, 17 Sep 2024 08:17:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:fd1c:1247:3d37:68c? ([2a01:e0a:b41:c160:fd1c:1247:3d37:68c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da24218f4sm105401565e9.36.2024.09.17.08.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 08:17:03 -0700 (PDT)
Message-ID: <bfe6f4f8-b7a3-4ea1-886b-9929c7bf366f@6wind.com>
Date: Tue, 17 Sep 2024 17:17:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2] iplink: fix fd leak when playing with netns
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
 Alexandre Ferrieux <alexandre.ferrieux@orange.com>
References: <20240917065158.2828026-1-nicolas.dichtel@6wind.com>
 <20240917081102.4c00792f@hermes.local>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240917081102.4c00792f@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/09/2024 à 17:11, Stephen Hemminger a écrit :
> On Tue, 17 Sep 2024 08:51:58 +0200
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> 
>> The command 'ip link set foo netns mynetns' opens a file descriptor to fill
>> the netlink attribute IFLA_NET_NS_FD. This file descriptor is never closed.
>> When batch mode is used, the number of file descriptor may grow greatly and
>> reach the maximum file descriptor number that can be opened.
>>
>> This fd can be closed only after the netlink answer. Let's pass a new
>> argument to iplink_parse() to remember this fd and close it.
>>
>> Fixes: 0dc34c7713bb ("iproute2: Add processless network namespace support")
>> Reported-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> Tested-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>> ---
> 
> Maybe netns_fd should be a global variable rather than having to pass
> to change all the unrelated function calls.
I hesitated with this option. I don't have any strong opinion on this.

Note that two variables are needed, because the link_util->parse_opt may call
again iplink_parse().

Another note that I forgot to mention: I didn't fix devlink which has the same
problem. I was waiting for the conclusion of this fix first.

