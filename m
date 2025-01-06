Return-Path: <netdev+bounces-155585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6AAA031A7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680317A2A05
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D97F1DF996;
	Mon,  6 Jan 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Av66ioIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45F1D5CF8
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196832; cv=none; b=McZy2cTWY2Vi+JjeYcwsg1JZ6nKgPhCDnEQLUQxkLPRakx/Aiukl3uAgBDdBtQOXVl5VBS/I0i6cUFd/eufRBzW5cuV4uHG/pzWJGQnHpB4VZwq6DMGkDb4hRP8MMwIQovngMU+XV1Sc0N9dvf9/OU4yxp1e0AlB/zyBKMfr0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196832; c=relaxed/simple;
	bh=Ldxeoh6br6mzzsSy0J+MhFXg6YXtI2AQcqmkmyL5aCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aR4p5muflIzUQm5PdzHkPflC4mT3+DCak/z68RmKXQSR1GzGwQY2UEDu8d0OLezUdoCZSwMQqF5MLlEnvKd0lds7761Sdw8beQTk+YYpGZpzgjiAZ0Jl9X5JyIsBlXRA5StpN6tmjFS3IPDzOih+4kY4fBBfVdh316gksK/pxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Av66ioIB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa68b513abcso2747846666b.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1736196829; x=1736801629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCS8xtAGUrfD70TF3aWVl6EWt0v+utB18G6cR6M+7Rs=;
        b=Av66ioIBx+5GK5R9Hceb0O/caMHOm25OImrs2SVinR6r/t0yQyGz9SjHFHySukHAjE
         saeIwtJscZU8HTKGwS7UB+bpqZ3yk7MKUSqrXg+6uQ3kz88R1Ps5ZZqh/zLAfeYuOfDe
         W8hBoFjq/55Ex3aa7i3pcnc8y4FfW+qqxx1geMXwWZHnJznOX4mY/SnLF7FNEs808Lpt
         3RcEYEx4dMJT/NLPCB9z2j+i7JqsN9x39B+d62uTfYMmzwm17TCiJRkO/VXUtJQBxE2M
         vrXh2/MWRQzl0kyiM0UDx5inxG+Wyf00b+aXs9KK5EMuz1rtp+wvNB3Q1KGGBAW9CIMr
         T+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736196829; x=1736801629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCS8xtAGUrfD70TF3aWVl6EWt0v+utB18G6cR6M+7Rs=;
        b=TS2VCTt9CdobgV/GOC2ueSNKZSADosxg19T2WTqYQFhGedWqNmn5bMMsHRgIBXhGRv
         ffelskR1IVVlHx2gxXGiRxiFg0h5IhBfFNNahQgilhHa8PEUXCgp6tldeYELey331GcX
         lb8PzXED4iQsKSNZQy9kru6sMof8MWDXniWFmgzgDqTKsKghoLj7+ljyZK5Hwvg3Tgzr
         sUcfgu4LgxomyBxQV3ys0DXB9qUkrY5HFopA4x6q8G0iDGuMmsW7rKgTNSNqW0g2+ylI
         ZDnVueTZjGRnSJuMvcTJHjMSmdvoq5EvZVraFItmBwZ4xbwN/1nvIVtneDCLcg7/jBPK
         ZOEQ==
X-Gm-Message-State: AOJu0YzwCilFU4GJycMhA8AI96g15ikuG81h+BIVypKClrZWWZGPdm+h
	jqwYxT+rjFPres4fJRNKm9XMOHmEmxlRo4wZMr3BGsTfV1n0joxD2geRA9wpKeg=
X-Gm-Gg: ASbGncuxQYh0zIghr7zs4rkMUQpwT6+ehXsKR2y2FsP6gM9oPvYdCZAEHSuU6DbNxI2
	5b4cNV5i8EpEIbvRB/tOrjMUgAtDfVcdWxsWHeuuUIo4HUc/B7PfnxQkS/V+Zx1bcuyMMbadUgU
	1CTNHOj0fYx5WO+quqyD/1R3rCN97WivCnRm+RlSbLHur9kSEbbjMwIiCBqTR+31wv0/YwY4EU0
	7b/QqS2uBWi2hXlFhAzXcKGCk3fRerZTVKQHqebgAhCR+aU98Z3EpH8WTsrKr0uyq7OA6wRj6u1
	QbEEmlagERlS
X-Google-Smtp-Source: AGHT+IGMBM2ywB94sg1yqowQko17TPcYOKyzusNRrVks+ZXVm/N9YelNoSLoA36OEd/be068ns4VPg==
X-Received: by 2002:a17:907:7d94:b0:aa6:c04e:240 with SMTP id a640c23a62f3a-aac344302abmr5742750466b.60.1736196828598;
        Mon, 06 Jan 2025 12:53:48 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f011f7csm2291591066b.138.2025.01.06.12.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 12:53:48 -0800 (PST)
Message-ID: <2fda5a09-64da-40a4-a986-070fe512345c@blackwall.org>
Date: Mon, 6 Jan 2025 22:53:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] MAINTAINERS: remove Andy Gospodarek from bonding
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, jv@jvosburgh.net, andy@greyhouse.net
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-4-kuba@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250106165404.1832481-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 18:53, Jakub Kicinski wrote:
> Andy does not participate much in bonding reviews.
> 
> gitdm missingmaint says:
> 
> Subsystem BONDING DRIVER
>   Changes 149 / 336 (44%)
>   Last activity: 2024-09-05
>   Jay Vosburgh <jv@jvosburgh.net>:
>     Tags 68db604e16d5 2024-09-05 00:00:00 8
>   Andy Gospodarek <andy@greyhouse.net>:
>   Top reviewers:
>     [65]: jay.vosburgh@canonical.com
>     [23]: liuhangbin@gmail.com
>     [16]: razor@blackwall.org
>   INACTIVE MAINTAINER Andy Gospodarek <andy@greyhouse.net>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jv@jvosburgh.net
> CC: andy@greyhouse.net
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91b72e8d8661..7f22da12284c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4065,7 +4065,6 @@ F:	net/bluetooth/
>  
>  BONDING DRIVER
>  M:	Jay Vosburgh <jv@jvosburgh.net>
> -M:	Andy Gospodarek <andy@greyhouse.net>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/networking/bonding.rst

I think Andy should be moved to CREDITS, he has been a bonding
maintainer for a very long time and has contributed to it a lot.

Cheers,
 Nik


