Return-Path: <netdev+bounces-128876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D297C409
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 07:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C32B2835D6
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB873440;
	Thu, 19 Sep 2024 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZnwbvzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73F6A039
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725450; cv=none; b=ulVb0M6w0SH7KSm6LgU/ZloWRmzE0a9M7seOPOBXJz+55qtMPHiITZOcWBlo65gMRCARu0D5uIOjl5GEnPIzY4rtxzKg2tB85svbO8zAH8BhnA7lLi0UoEAm6woRbwRUlXGahbbOgI9tx5+qDxTrRV/uWKurnwD2Lp2XbgbDjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725450; c=relaxed/simple;
	bh=mPJbhdlz2m8+oq9WAEi0x23aerIpANKncOAcIQeYPXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a1KbxVMuSngj5fMsEkxIpI9780ajaVsBTBGiItvzftaV54/sxkhmWTi+3M/pBjrdX7VKp/QiO9XkAbKNNg1VKWz7fsJbRicdKoWjF52NPkYtD1EXsWMtuBp1SvS6p+bS6VzUVbvZUbOsDakqymCKcXJfe6MC/bCrVbftxba3UQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZnwbvzZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c84dcc90so201611f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726725447; x=1727330247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wMpFqXWp6bRUuk6qdZ0xyyKQqRUAsx+iTidH2iEUUYA=;
        b=aZnwbvzZ1j4pPxYOda0tsnGdBfd5wSA2BOGmQ5X9IsbgGDwWlM3qzVWQ6EUL1yLEcq
         EMVP37jODDXN4RZz6ybZIQZGF04OT4hlS/O7ZlBF4aack/glGZgnmcK95iIEjfAi8VX5
         xNDl6H0yfRe/7jBo45b+HjLg+OARiVtzqHDHIFiAg213xCOcyXA0KQjgnOnzvsGEtH4K
         8uZlfW55lZv9vAtTszjIo7h5gugTzoxiAO9KJXzwDsoKAHGrATMHmqI1A4DiGTHefmyM
         G7lFZz3h9Ft4cqffLjYx3AESdiG9kZ3DYePAH8hAvXMBvPx8vK0nkmdlSfKAtXNi/2Ft
         Uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726725447; x=1727330247;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMpFqXWp6bRUuk6qdZ0xyyKQqRUAsx+iTidH2iEUUYA=;
        b=qE63FtmXCCJSRGSrTZp+ZVVuFchSrz7GqJDL54CuKvG5Mk48UNg738EIipcDO86dFw
         bp4f7lCV9ZTaEbLW/mqP941X0IyTFOuBVR+Aa98uqdqjMLBQKlkgI6u32dATGrMV1GQS
         PhNKR6LLDzWuMAjNe+Df3TZvhcGgU/Ob9003TTUlyI7A+AtZgVPZ5VwioQ9YIJpOn736
         gQqu3Mi0s0zpzuT9QunJmtKa5OH0b5C16aaS7Ghd3RkLDkn7wZWraHh5Qa019O8UYbCS
         +DaTaRaCwPd0H/gBGrD+lxCatPWdXpXbyXmPj1Cp8eGzhSC7JKAeo3Cv+SJtFSxLZFRX
         9WfA==
X-Forwarded-Encrypted: i=1; AJvYcCXuX8pdoiDPTkTme14+Gfuyt0ReK+mn65dfaZkUzWE7ZEzru/tP4weDUAwqgwTH9Ybl1J+9FtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYtGAAURBJWPgwXbNVk8Iax4RpNB8xlZnFe6V2FBrRHxiwpsnf
	cvuuwy+3Y8aXtqNKSKHbs48M9YR15G1jUDCY9PRarxUGBwomCwTj
X-Google-Smtp-Source: AGHT+IG7BO4+2S2xSjuEmYO283hjhDguydNBO7x+hmBpJHDkBMSmFfexwgcFrSxR79wSe72uw0dlKA==
X-Received: by 2002:a5d:5e12:0:b0:378:e8a9:98c5 with SMTP id ffacd0b85a97d-378e8a99a7amr7763200f8f.34.1726725446371;
        Wed, 18 Sep 2024 22:57:26 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:2e00:3903:1375:316:3ef8? (dynamic-2a02-3100-a14c-2e00-3903-1375-0316-3ef8.310.pool.telefonica.de. [2a02:3100:a14c:2e00:3903:1375:316:3ef8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e73e8204sm14179202f8f.47.2024.09.18.22.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 22:57:25 -0700 (PDT)
Message-ID: <2a39433c-3448-4375-9d69-6067e833d988@gmail.com>
Date: Thu, 19 Sep 2024 07:57:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Submitted a patch, got error "Patch does not apply to net-next-0"
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.09.2024 04:23, Muggeridge, Matt wrote:
> Hi,
> 
> First time submitter and it seems I did something wrong, as I got the error "Patch does not apply to net-next-0". I suspected it was complaining about a missing end-of-line, so I resubmitted and get the error "Patch does not apply to net-next-1". So now I'm unsure how to correct this.
> 
> My patch is: Netlink flag for creating IPv6 Default Routes (https://patchwork.kernel.org/project/netdevbpf/patch/SJ0PR84MB2088B1B93C75A4AAC5B90490D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM/).
> 
> I followed the instructions at https://www.kernel.org/doc/html/v5.12/networking/netdev-FAQ.html.
> 
> Here's my local repo:
> 
> $ git remote -v
> origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (fetch)
> origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (push)
> 
> After committing my changes, I ran:
> 
> $ git format-patch --subject-prefix='PATCH net-next' -1 95c6e5c898d3
> 
> It produced the file "0001-Netlink-flag-for-creating-IPv6-Default-Routes.patch".  I emailed the contents of that file to this list.
> 
> How do I correct this?
> 
> Thanks,
> Matt.
> 
> 
There's few issues with your submission:
- net-next is closed currently. There's a section in the FAQ explaining when and why it's closed.
- Please only one version of a patch per day
- Your commit message states that the patch fixes something. So you should add a Fixes tag.
  If applicable also cc the patch to stable.
  https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst
- If the fixed change isn't in net-next only, your patch should be based on and tagged "net".
- Patch title should be prefixed ipv6 or net/ipv6. Not sure which is preferred, both are common.
  See change history of net/ipv6/route.c


