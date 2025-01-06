Return-Path: <netdev+bounces-155628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0064A03345
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559603A46A6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144B1E0B99;
	Mon,  6 Jan 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Bk+9aD0R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CC1DFDB3
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205673; cv=none; b=sJxUFbPINst4AezL7+Eu47zja0yuDi9vRlHPu5+vhMLXRWBYlFmHAbdAE3DRAqnSkAeFg+JoCHOzov2C+fv/OImdZggZTfy1u488IwwpEo5DQ+wZtgv2fpcIKbKEV1REjBOveR9Vnf5wQKdzcAmN2IeYXGeiW0HQPExOGDWDwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205673; c=relaxed/simple;
	bh=JQKjqxT/n7Qy/CQq8Z0WY0oy0m5g7hw10SZWyTECRm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGBp/9MMG3C99kbf4tokBeQpfiH74nirnnLqvibxEy79qs+IEpXUt4spQ5GNq7hnMX9YKbjg0IauxRQLWzQfkyf31WZ1FvKAiPwrK2q+qZo/s0RP2LfHf2Rxh2I8QlT0A5vm+zu7NVZrHUCEma8Iv7B2esyaI+iwMYUDZRhhdJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Bk+9aD0R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216401de828so203876215ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 15:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736205671; x=1736810471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK+KGRiXC69ScV4d92KuoSjC2TWRqIuwrLibztHnLfI=;
        b=Bk+9aD0R9xhsuCO8A0TXnb4gGb7/nta8ziPGYB/6Xt1N7Usss0tkVie/6wSIXJ2pQn
         8ZQiTrFGrhGum1CtGurF/6DjK0EWJvZknStFyS+ExiWnrvr+3zPPrw+TVhs61obvgZpr
         6qo2oqTi5f1OuzeP9sLNuPHtwAXdLW+C4eYGvaWGvjzCb1beAOa7yV8ZFXItapba1LJM
         oaeyJhsYAL4aCpuuRN32e/dqAIj+7mZWDtx8UrOaTTp2CpY1wH/AMC5J1uepy+VTm0Wt
         IZxYhdeHR2ZmyjcP4wzvm8PkLzQwzFtToJpZVFJVCXiXhyCsDPhkuwyUg2dLTALIUt4p
         6vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205671; x=1736810471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CK+KGRiXC69ScV4d92KuoSjC2TWRqIuwrLibztHnLfI=;
        b=uPeFirkXXqxfBXphn2Wgbnh7yVkhRUbOmljhH9vcArFWZ9KcEuJX++xPJ5GJi+rpyq
         fWzmfS8ulYbKFbBedg7YjNiGVgspTqUmqGz5JXD45uRqtyTOmTv3EJEj++XpHjBTTm6w
         d9uSJHf2tTJkKUTl4N7SstUSV6KyhmRIlXdKoHDiRfJ1To58LrKFcbiu10JOQBE2CPfQ
         UjfxI83s79PmhdnioCyZeDWYb3Tdoyojx+WpVFvuNmqDqFmd7VJ95C/07kFiFvlqvYrx
         6Z73MHTkR3duzHBoN017rOQsyQYbP4FN5fXuDv0xqIpbwPor+WFDjxXBhpNKSnIlZypV
         X+1A==
X-Forwarded-Encrypted: i=1; AJvYcCXwj+/gtgQNa66cCxwtfSh9yfR18Z/T9/RRI+1PWSfD6GBtGEHFRdvcdHGh0g/F7A5qzzKbEAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2J/rgOeocfIGxVj0L44MOWByY+dXjeVc0HkQGQm93jL2bzkw2
	n0y52G3QdxZLzuf5PjuMIUzylhL162TAXWhbI87LV4h8rRbGxzBNzo7Bu7CxNWLRa7oweUUlmm4
	SO28=
X-Gm-Gg: ASbGncv6Ov9kdWK8SXtiPalNBYooHR4/wsGx7cE3eGJRipdIgTUgO4vbeclQ1/QkBQH
	GYCwCK5Ryk/HhzIs/0IBWAsNCLEfeiCiV2cdCDBT9CnKta2Bl0Agp3Ndy0+yxcst3gWmRci6TEf
	ixbcIR0fV0M/6B90/nhSe3e1v0MH9Dgt+uIpb7MupU6ak2KCFbHD8tja/PsNjYtnjj+satRR4fj
	YGfBE27UALCMntRx6DQ6o+Q1psEjJ1HEJKZES4+mJGajRCO4VnMftQGZmBTXf0BLrKWnufk3CBq
	joN2QfJb57Q6ZsO9/g==
X-Google-Smtp-Source: AGHT+IFFwFLny6E41cgiMDZVQtQCQ5x0znx47KcvxCwnBUWN3yMzHn1UKFP6zpH1wXzzVtR2QAzkzQ==
X-Received: by 2002:a05:6a00:2181:b0:729:49a:2db0 with SMTP id d2e1a72fcca58-72abdebf27cmr81858887b3a.25.1736205671089;
        Mon, 06 Jan 2025 15:21:11 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::5:7895])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbae4sm32018985b3a.96.2025.01.06.15.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:21:10 -0800 (PST)
Message-ID: <66aa384c-9413-4c7a-a148-7b46d7d73414@davidwei.uk>
Date: Mon, 6 Jan 2025 15:21:08 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/20] net: page_pool: add mp op for netlink
 reporting
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241218003748.796939-1-dw@davidwei.uk>
 <20241218003748.796939-6-dw@davidwei.uk> <20241220141611.6d95a37c@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241220141611.6d95a37c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-20 14:16, Jakub Kicinski wrote:
> On Tue, 17 Dec 2024 16:37:31 -0800 David Wei wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Add a mandatory memory provider callback that prints information about
>> the provider.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
>> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
>> index 8d31c71bea1a..61212f388bc8 100644
>> --- a/net/core/page_pool_user.c
>> +++ b/net/core/page_pool_user.c
> 
> net/core/page_pool_user.c doesn't have to include devmem.h any more

Will remove the include in the next version.

