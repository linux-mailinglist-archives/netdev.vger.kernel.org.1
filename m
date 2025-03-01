Return-Path: <netdev+bounces-170928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA87A4AB89
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9317918966E1
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3715C1D514E;
	Sat,  1 Mar 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftNtdIkF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058363A9
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838381; cv=none; b=S/DAGYytyiZ06DafyL2zOcKtaMEMWf9rCNbufEOYDekz/pq/bajZKTWF5TuyN9mZFZ+wUPuJzrAwPRcTIe7Gyed9Q1pEbjzNpRWIVsnJLGQdf+U0IWuxfu9RkJwoqwuYocu0orxl5Ahy0qOM+T45iz+4TnW4PAvB7tjvrySElMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838381; c=relaxed/simple;
	bh=hNZM/86VRMRaZFdHCyL0YFuctBrro4aMGBgAKTtpiHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myZNhWJNBUOxI7jUUTWrAXChPjIU86ijOkMJGggluCJxn12Bywi5rEnqfnmYIMVp/yXafNosVqJknJ1JAAbPdSOmfwtq9dirkk8OGe5ApaBJACIRKH8eaYeOqP1SE5NxGPven5upvgYLQBBKj0mA3RYxBOqcN6VmoJPPs2oRWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftNtdIkF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so25479205e9.0
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740838377; x=1741443177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ilGyenfrxjRoUmMAqf5xFvTsYyPZP55TzdgIqj8KAhc=;
        b=ftNtdIkFEc2OI/ky5QpxGg3yc0CWFem49lhCgi0cECIurcLuEwYb+YTMvEBn2sDF8o
         XB21gXi3U/A2OJHG4XwzyxmEQ3FOelpPNOoE08OHX5l7Hw1TDMB1fVmVXo0zamayIC7H
         6LQdE4qo0AQMBE0WY5WOdZTKL9DTa0RBeYUeRiaz4c+7m4kYDxf32tJ+m6qg5O7hC0Ry
         Ped5QD8m4HVnvm5h8HlZ6LCg5N6qX2dDm1hrloRmNT3IZD1EIbcPsKQw2ZGtw+1Usgzs
         EWdRmKMhPbyS/eXsGfjCSUABA3bXd05A/SV0PaB7pJT0nPF6Vvfofz5WMrtvu6GzBFXl
         ni3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838377; x=1741443177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilGyenfrxjRoUmMAqf5xFvTsYyPZP55TzdgIqj8KAhc=;
        b=rn79ARRNPIyh/P7bWKGzWtz8bbJ4K1UFEFDMRKRkcOVeZglPf3Fs2gYMh3pszYH1sh
         odM5etpcT46IRQq6N/+Fu2ZFoHmzzv2O80Q1wJTLnbGneSm2EU0QY0fQNYGHFwQ+yKja
         CJq8iWzNwxXkPhlO25+QOTR9h9swEJT0BMcZrt1yuk4gA5yJTCMJrcTwuGgej3yquTFD
         0EqmW7vr4kaAKjf54Ft9T4PsoDEDVksKOvvqeS9C6UI4+nz/G9BwciulF41ODrWkllp7
         g19eM7CWIlGAGpzwH9tf+0WnVEvL0nUKufyyNDNB7L7rsyy5q4i+NUj6oeFsIMxyby8a
         ajzg==
X-Forwarded-Encrypted: i=1; AJvYcCWTc3j63nxF0XjmRNNbnUVU052OoD0uhrfjPNWTSq6wvvtGoG7C8LGI2Md+3grIt6HliWkAWqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPSiD5PuXX2xYTFPTz0L5PmD0ePu2eqHgLr+FsocjlgA4De2d
	cOvXY/hV7TspQcNinVKmY2yXNOWwNvUeWJxmmIKcRbYwY9B/OdNMEJlrBBEK
X-Gm-Gg: ASbGncvlXygaLw/EHfJuIer5pSf4+zwpR/8U+7gYDw62g/DE0RCjUKzhGjT4RBHssng
	2D/KsNSBBsKNCmd2HsFdxSi7YUVy+yFw/0ODios6n65xixSUmr4aUHFFaqbIp7eh7HM+wP+90XL
	k1kA0c5/L8iIYdWZxEQXjD0+jnLBxGkkaOU7+y4WXIarUB6ZICU6sSm1Z6hTAEKgV85Xap655lM
	PwM40LsDfew15zwk4qz1Fn7lmZFXJTB6zVbxUk2QI/O4c+mUnqngXudxMPJ8z7M5d42/ikrIKzc
	CtzXWGSyJXzitG07PdkLrsRTJAcgiHQVL2REC6lSnebbKqhm18XZ6W2e6N4s+ZAM2d3NFk3Qdc6
	H3XHP1OLaDVpS28KQofEe96HoLDipm8JtJhZAl5VwATcI1IRyjLnDluCvVLC36UcTB+h4E4cqJm
	shgcdLVaZE6pg1jIJtU//3VRa04+yiEL8=
X-Google-Smtp-Source: AGHT+IGagMAi4DErH0P9+pnVNl9c27n3ogTsJrxbyPBsQv9pFAn9GlxuwcH5qsCArBEu9lJAnngcBw==
X-Received: by 2002:a05:600c:1e12:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43b04dc34d4mr102220615e9.13.1740838377210;
        Sat, 01 Mar 2025 06:12:57 -0800 (PST)
Received: from ?IPV6:2a02:3100:a9db:600:159b:603:111e:5ffd? (dynamic-2a02-3100-a9db-0600-159b-0603-111e-5ffd.310.pool.telefonica.de. [2a02:3100:a9db:600:159b:603:111e:5ffd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47b6ccdsm8443466f8f.46.2025.03.01.06.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 06:12:56 -0800 (PST)
Message-ID: <4c9c1833-0f5e-4978-8204-9195009edb33@gmail.com>
Date: Sat, 1 Mar 2025 15:14:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: add support for 16K jumbo frames on RTL8125B
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: nic_swsd@realtek.com, netdev@vger.kernel.org
References: <20250228173505.3636-1-rsalvaterra@gmail.com>
 <ebe829ef-342a-4986-975a-62194a793697@gmail.com>
 <CALjTZva9+ufCR5+QhJXL+7CHDRJVLQqb4uPwumEO5BqssGKPMw@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CALjTZva9+ufCR5+QhJXL+7CHDRJVLQqb4uPwumEO5BqssGKPMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01.03.2025 12:45, Rui Salvaterra wrote:
> Hi, Heiner,
> 
> On Fri, 28 Feb 2025 at 20:22, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> This has been proposed and discussed before. Decision was to not increase
>> the max jumbo packet size, as vendor drivers r8125/r8126 also support max 9k.
> 
> I did a cursory search around the mailing list, but didn't find
> anything specific. Maybe I didn't look hard enough. However…
> 
>> And in general it's not clear whether you would gain anything from jumbo packets,
>> because hw TSO and c'summing aren't supported for jumbo packets.
> 
> … I actually have numbers to justify it. For my use case, jumbo frames
> make a *huge* difference. I have an Atom 330-based file server, this
> CPU is too slow to saturate the link with a MTU of 1500 bytes. The
> situation, however, changes dramatically when I use jumbo frames. Case
> in point…
> 
> 
> MTU = 1500 bytes:
> 
> Accepted connection from 192.168.17.20, port 55514
> [  5] local 192.168.17.16 port 5201 connected to 192.168.17.20 port 55524
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec   241 MBytes  2.02 Gbits/sec
> [  5]   1.00-2.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   2.00-3.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   3.00-4.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   4.00-5.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   5.00-6.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   6.00-7.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   7.00-8.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   8.00-9.00   sec   242 MBytes  2.03 Gbits/sec
> [  5]   9.00-10.00  sec   242 MBytes  2.03 Gbits/sec
> [  5]  10.00-10.00  sec   128 KBytes  1.27 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.00  sec  2.36 GBytes  2.03 Gbits/sec                  receiver
> 
Depending on the kernel version HW TSO may be be off per default.
Use ethtool to check/enable HW TSO, and see whether speed improves.

> 
> MTU = 9000 bytes:
> 
> Accepted connection from 192.168.17.20, port 53474
> [  5] local 192.168.17.16 port 5201 connected to 192.168.17.20 port 53490
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec   295 MBytes  2.47 Gbits/sec
> [  5]   1.00-2.00   sec   295 MBytes  2.47 Gbits/sec
> [  5]   2.00-3.00   sec   294 MBytes  2.47 Gbits/sec
> [  5]   3.00-4.00   sec   295 MBytes  2.47 Gbits/sec
> [  5]   4.00-5.00   sec   294 MBytes  2.47 Gbits/sec
> [  5]   5.00-6.00   sec   295 MBytes  2.47 Gbits/sec
> [  5]   6.00-7.00   sec   295 MBytes  2.47 Gbits/sec
> [  5]   7.00-8.00   sec   295 MBytes  2.47 Gbits/sec
> [  5]   8.00-9.00   sec   295 MBytes  2.47 Gbits/sec
> [  5]   9.00-10.00  sec   295 MBytes  2.47 Gbits/sec
> [  5]  10.00-10.00  sec   384 KBytes  2.38 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.00  sec  2.88 GBytes  2.47 Gbits/sec                  receiver
> 
> 
> MTU = 12000 bytes (with my patch):
> 
> Accepted connection from 192.168.17.20, port 59378
> [  5] local 192.168.17.16 port 5201 connected to 192.168.17.20 port 59388
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec   296 MBytes  2.48 Gbits/sec
> [  5]   1.00-2.00   sec   296 MBytes  2.48 Gbits/sec
> [  5]   2.00-3.00   sec   295 MBytes  2.48 Gbits/sec
> [  5]   3.00-4.00   sec   296 MBytes  2.48 Gbits/sec
> [  5]   4.00-5.00   sec   295 MBytes  2.48 Gbits/sec
> [  5]   5.00-6.00   sec   296 MBytes  2.48 Gbits/sec
> [  5]   6.00-7.00   sec   295 MBytes  2.48 Gbits/sec
> [  5]   7.00-8.00   sec   296 MBytes  2.48 Gbits/sec
> [  5]   8.00-9.00   sec   296 MBytes  2.48 Gbits/sec
> [  5]   9.00-10.00  sec   294 MBytes  2.47 Gbits/sec
> [  5]  10.00-10.00  sec   512 KBytes  2.49 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.00  sec  2.89 GBytes  2.48 Gbits/sec                  receiver
> 
> 
> This demonstrates that the bottleneck is in the frame processing. With
> a larger frame size, the number of checksum calculations is also
> lower, for the same amount of payload data, and the CPU is able to
> handle them.
> 
> 
> Kind regards,
> 
> Rui Salvaterra


