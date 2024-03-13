Return-Path: <netdev+bounces-79607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C674D87A2DB
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 07:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8013428324D
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7FE1170A;
	Wed, 13 Mar 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhfxvCcw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5513AD8;
	Wed, 13 Mar 2024 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710310064; cv=none; b=HJpyXwj93LpwByDKwAZ3I8luQe5dJbJ5QgizHaluFk7zvoGab9n9TdT5ksQpE5qm2WCAirdi76Jgg7lYyTPezMwaH01T5oLW/CD7nqkzjiWhLQjPC4T72+CuEQcDUkP+vCivzgkb51TV3TCEAsFk76u9cerau23xpmIRU7XMMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710310064; c=relaxed/simple;
	bh=JAbRJULUtYT2FEB8ljTZpY/ho/ffWxibZ2qZnzPZNhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNuDqEoTRsFfhmQIPmd6pS6hoynqcIS2hEGzGrQjd4gJZdZeyxH6ZuvUItSYpoFFxDEkygrPdu40+iQHC8AIuiCRWmtzNr8tB2Dy6uzsFJRkKJv1GaIPsROIsLn2/4Dw3mPvubNl3IV7e+pNVSnOX+7wI+TUkaJNkMNe8Ym5+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhfxvCcw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4132e548343so14829645e9.1;
        Tue, 12 Mar 2024 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710310061; x=1710914861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zt1/IkK5JgRgujlk5e4o+Oqepqb7MAzE8ZFCroiaUF4=;
        b=hhfxvCcwT+BJPQvaoX1GEbTm2Ibwm7TvAf8RhV16XnrUVxGsRHIU3SwBHwYU9OQ5N6
         7/KUOU7oHyqdV7J7vFef+U50a9KY4SCaMvGzydBaX+ATJSqkWgWWgGmMfYYfzCIiefvx
         c+Ko765WJUveJsrCTNuJFUnkHKtzruSnmSMezdTHRAUtsqYixJ1++p8pkfNZpQfjTOhI
         lQPnGxCzxpMWVA+wGW0/dQsMsfOqc/cxxvUHfXhT7rlbwPV6REuVh8S6n9mth9d72wZ4
         1vED5QAuakkYH7HMjA8xFAr1POo7/N6GroqspMfacBZiz1Do3988bQTE9cuLZTR8MFyd
         7kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710310061; x=1710914861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt1/IkK5JgRgujlk5e4o+Oqepqb7MAzE8ZFCroiaUF4=;
        b=QoVtfL3xNcxGsaOyPnQt32KkqQ8T9JDKDfyUJNqcYTuPNxMIpWjTXEMH5ufU/nODIx
         m+gWd9Yk/QekUXl0gMZqgkmh7h2jLSYCKvMWvbRU4tKSN/OLMPiHdtpKmJohHt2bBd8Q
         WdzR35YbyEuO1D6vtTySisjIChrft71cbe7eWxhXopPFemDaM7ogQomUxskplssbo8OH
         MKh3nsfVv7rqXWNZ33CZxiNVVG2sKeuSZBYN8afIVfK/6nlDZzIcvpO5SUUGf52S2oD4
         uyVhUhT4CkpoctCBlZltcMkOiAWFdZqyB0uGJ/kqlDPgFVaDZJbuPa9Mao8gYRI+LuSb
         z/bA==
X-Forwarded-Encrypted: i=1; AJvYcCUYlBKuNl75jWMFZC+Td5wZ+DQXyEfb3UzNU7qKZWMqWXEg9VrN5M7uibsRkaL5Y/oyIySGrqfsFsiFSj2NcmSEnibNPFD7sVo6
X-Gm-Message-State: AOJu0Yx+9i3qVJEZ5/IKfo0/go6Oul9D4jD11XerW6+xA4EeIIl6PkmS
	NyqLwrxeL2P8hi1k3xhoah8KRhZkLF6RWkUSxWqVnuborAZ0yyXe
X-Google-Smtp-Source: AGHT+IHTwYUgtaPx0ePNCfE2/mWwH/M9hKKNgiW1BIhs8sN4Cj0EpZpNrEllxwEJHPrEm0uOenpiKw==
X-Received: by 2002:a05:600c:5120:b0:413:2852:2835 with SMTP id o32-20020a05600c512000b0041328522835mr1511986wms.17.1710310060923;
        Tue, 12 Mar 2024 23:07:40 -0700 (PDT)
Received: from [172.27.52.25] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bn16-20020a056000061000b0033ea59bc00bsm3598809wrb.73.2024.03.12.23.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 23:07:40 -0700 (PDT)
Message-ID: <2ab5b453-494c-409b-82c4-f2c62adb43ca@gmail.com>
Date: Wed, 13 Mar 2024 08:07:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] docs: networking: fix indentation errors in
 multi-pf-netdev
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, corbet@lwn.net,
 przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
 linux-doc@vger.kernel.org
References: <20240313032329.3919036-1-kuba@kernel.org>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240313032329.3919036-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2024 5:23, Jakub Kicinski wrote:
> Stephen reports new warnings in the docs:
> 
> Documentation/networking/multi-pf-netdev.rst:94: ERROR: Unexpected indentation.
> Documentation/networking/multi-pf-netdev.rst:106: ERROR: Unexpected indentation.
> 
> Fixes: 77d9ec3f6c8c ("Documentation: networking: Add description for multi-pf netdev")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/all/20240312153304.0ef1b78e@canb.auug.org.au/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Turns out our build test for docs was broken.
> ---
> CC: corbet@lwn.net
> CC: przemyslaw.kitszel@intel.com
> CC: tariqt@nvidia.com
> CC: saeedm@nvidia.com
> CC: linux-doc@vger.kernel.org

Thanks for taking care of this.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


