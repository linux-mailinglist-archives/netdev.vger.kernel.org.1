Return-Path: <netdev+bounces-72200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDAA856F23
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 22:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44611F23BD4
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C654E13B78F;
	Thu, 15 Feb 2024 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX92Y5Ef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331A13B78A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031635; cv=none; b=O8hv7c6fI41+HaSjBvNobrTdUE8O7iMYSlMuearqumH7I+ubPXqf4l2X8SyO8CAsoH1oAUiJHv9iGNhIYis8LAyV4HOz8jD+5P+qq4iz+xYpRY18mt8yqmHOZKr27HQcQO3AIItqpIq7v1PiqhLE53KNhMFAnqNrAxftlqdhqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031635; c=relaxed/simple;
	bh=Wh3BNJRjTHMtWzLusdVVnGzAP/chdECKtwzx+XcoQUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpwhSY8HAsTxpr7aezyWx6xxdXvfRPm55/g+JM+gY63nERGCbeFTlU6vNgiftt1x2oN7AMGX41R5PopXYxijrN9q/IKrsqmLWUXjfp9a87Aqk/c7E6msblrd2A1SmyN6jzNS8VTZ6N+M9Mz45kV5hkiq+uessp2oKSCJt9tMQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX92Y5Ef; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so93423a12.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708031632; x=1708636432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWkrxhcbg0TKDy0erQPvP/YBdgnPp48IgxslhXdC5IE=;
        b=KX92Y5EfZ6xOlHjfe8V1I/8u1HOabuDvHaxorvlUAeNkcaG0fxYUHR35/MQ6u4rsMG
         YQBFtvVjgAuk9EsSbgiqTraokkdOhkrQDEBGcXBzPJ5WaZ88L3comJxCvqAZVSsOAulJ
         UJPXa9N5dK/PnYlsF7QqK7zJ/1dZiufd7Bq++e9cgh/YJIT4egfdr34mMANHtqYpD/w9
         7CYL97PF76zYxg3Wj2f+tkJs7tYef1U7HYS8bbJHWxOyr5ZDtiBg4gaY5GYMAW96+H5L
         hKBs2R+yUMXu7YIjQtDWnUACmMKWJUGwWiMU6ooe/hEu2aF/49MRIKVSKqG5LXz6LZ0K
         DD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708031632; x=1708636432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWkrxhcbg0TKDy0erQPvP/YBdgnPp48IgxslhXdC5IE=;
        b=EuYc1g9E2yO1IjbO+vrL5G4d6NasuQdlbbI/ZjeSBsJZLo4Fb6NJRSKW8DSM71fEVe
         q+ljfFcwN7nDG8nDE7e1fjJ7ligIw7YXqQlR2sSrs9TN9SCw40BL7kFn4h8GEwo0JufX
         YxhxB4hOkm+cWkxVnJFGX1zqQ+D1eaAiA1BhgkAPrhxfALfWHZzp2NFEQ5H361MNQgKa
         qLjmnXMyoaUa9jObSB6cmlZdoxDfv1zbGdGdwRRfNRC4cxZTPuVEOZbRiJvG8Rem7UU0
         DXfdQySASNSSkV1V8DsMwhPm0AEH09LWYsYiea9KyeYKv0p1kQWT3rcYi0CR2CikU+Bq
         0FtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFwmaJTL64eTmHIlOOAqnwiWD7CW1FCzIzShQsdu+4cghQl4ZM2cZc+7yAwK8l9OGbHx/iZ6ekHWIyauSE7HXBDAbRt6m5
X-Gm-Message-State: AOJu0Yzow1/vZcDN2XHSmP4+kqWb50kVSR3CwAj4H5VCDdgM/fHsAdLp
	GA+PogHzbopPv1Nqq2CnYff30oiLm9sUi5ELKjOBN8mhfFsRj/6f
X-Google-Smtp-Source: AGHT+IFAMxCncz5jQiypXiBhCl0nkJDeAkGFOXvhDdm9a/o/WeJQ8Z1UEYGDGY+MCQgOnD+xTdy6Ug==
X-Received: by 2002:a17:906:7c16:b0:a3c:943e:a00a with SMTP id t22-20020a1709067c1600b00a3c943ea00amr2277778ejo.62.1708031632053;
        Thu, 15 Feb 2024 13:13:52 -0800 (PST)
Received: from ?IPV6:2a01:c23:c544:200:b8db:381c:cff6:c7bf? (dynamic-2a01-0c23-c544-0200-b8db-381c-cff6-c7bf.c23.pool.telefonica.de. [2a01:c23:c544:200:b8db:381c:cff6:c7bf])
        by smtp.googlemail.com with ESMTPSA id md8-20020a170906ae8800b00a3d581658bfsm922350ejb.24.2024.02.15.13.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 13:13:51 -0800 (PST)
Message-ID: <0e68d17f-02ce-4ed6-8f81-49819a91a214@gmail.com>
Date: Thu, 15 Feb 2024 22:13:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: check for unsupported modes in EEE
 advertisement
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>
 <e7b6082c-6c41-43c3-85e3-a2d75a44c967@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e7b6082c-6c41-43c3-85e3-a2d75a44c967@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 15:44, Andrew Lunn wrote:
>> +
>> +	if (ethtool_eee_use_linkmodes(&eee)) {
>> +		if (linkmode_andnot(tmp, eee.advertised, eee.supported))
>> +			return -EINVAL;
>> +	} else {
>> +		if (eee.advertised_u32 & ~eee.supported_u32)
>> +			return -EINVAL;
>> +	}
> 
> Do we have the necessary parameters to be able to use an extack and
> give user space a useful error message, more than EINVAL?
> 
We could at least print the same error message that we have in
genphy_c45_ethtool_set_eee():
GENL_SET_ERR_MSG("At least some EEE link modes are not supported.")

>      Andrew
Heiner

