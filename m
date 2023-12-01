Return-Path: <netdev+bounces-52952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A03800E2B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847A51C208BC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A73E497;
	Fri,  1 Dec 2023 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCsckeLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E86EAD
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:12:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3333487fefbso61721f8f.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701443533; x=1702048333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ogPN0fsaHMjSk4bQ/WcT76AeUw55Y7gBlP7VeeJR3c=;
        b=HCsckeLhNUAY9tYuIDeE7/13zzWd+i2aeiKpFHs8QtD5a/56RBaHItVqOy5V+OwJpW
         ku8/pggtszUMNe1kzuNIuBMO4Z2dB85P/zDz1zcsT5UnCkhUoAEpUfUJe+QNH5vYafxs
         +vHw9ORoKnGnOP2gAMHKMb7HyOZBn0Xx3fxBQ90soGBmLoBkD+3RnhR/ICjCUDeqKuwY
         YFo8/aqrMCdXZMG5emHwxadawEuUIT+NIfPbzYEqgNrxTCawcBz7WUmJh0LH3vk0Y0hP
         H7gH8gR80cHUV9/JoEOIFAqAs0oBsqljBZHM3uMY9ZvjvxbGHkHEfz1kh/5Rp7NyeSFY
         qDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443533; x=1702048333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ogPN0fsaHMjSk4bQ/WcT76AeUw55Y7gBlP7VeeJR3c=;
        b=gsZjzNENxWeQXS6fD7K0tdJsUs/0bvqIPLmj8t15LYi8hkVV/1KCLmpeYyAMYJsBCC
         gpvSz1bNFZgHMSkwrN+js6Uv1k3PB7Qp9hpJUIjq/GvMYEAbh6QzfYmEw+GvYdogkQd8
         H1ULojACzJVuP1LrsbEkjM9c+zIqXAZwX+6ueJA/vcLs7pvNNtdRrOjKXsJJGagv+h1s
         KuzZu3JWc3wYIZRvKeJzvpJ+0Bjap3wAzYgy4Y1fel1s40CoAW/4B9lTA5UwoyYJWb56
         gR9gG8ppRF1LGWb1EZc3t7wM0ud0HgXbZeHtdXpenCvmYqEcPZwv3l4Ybr/3b0IQsbzZ
         ytbQ==
X-Gm-Message-State: AOJu0Ywsny5ej1toik3aXuBCagLbMd5asUm3+njA73AZJI7Y167f8qLO
	oX2VzX5NI38jUka/NorjO6dMz+B2BoU=
X-Google-Smtp-Source: AGHT+IHqsCg2F0MmmEsbIsa8JRPAL95wGvZvFTVp8bKMP/FjwdhDNsbfJX3sH/N8bt6OqV+hCHn9Xg==
X-Received: by 2002:a5d:64a6:0:b0:333:3383:fbc with SMTP id m6-20020a5d64a6000000b0033333830fbcmr1459050wrp.7.1701443532617;
        Fri, 01 Dec 2023 07:12:12 -0800 (PST)
Received: from [10.0.0.4] ([37.170.89.160])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d584f000000b003331c7b409asm4481933wrf.78.2023.12.01.07.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:12:12 -0800 (PST)
Message-ID: <93e09c53-0621-4cdf-9e5f-84e8d20585a3@gmail.com>
Date: Fri, 1 Dec 2023 16:12:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] packet: Move reference count in packet_sock to
 atomic_long_t
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
References: <20231201131021.19999-1-daniel@iogearbox.net>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20231201131021.19999-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/1/23 14:10, Daniel Borkmann wrote:
> In some potential instances the reference count on struct packet_sock
> could be saturated and cause overflows which gets the kernel a bit
> confused. To prevent this, move to a 64-bit atomic reference count on
> 64-bit architectures to prevent the possibility of this type to overflow.
>
> Because we can not handle saturation, using refcount_t is not possible
> in this place. Maybe someday in the future if it changes it could be
> used. Also, instead of using plain atomic64_t, use atomic_long_t instead.
> 32-bit machines tend to be memory-limited (i.e. anything that increases
> a reference uses so much memory that you can't actually get to 2**32
> references). 32-bit architectures also tend to have serious problems
> with 64-bit atomics. Hence, atomic_long_t is the more natural solution.
>
> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@kernel.org
> ---
>   

Reviewed-by: Eric Dumazet <edumazet@google.com>



