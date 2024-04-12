Return-Path: <netdev+bounces-87400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F418A2FC4
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AC3285D9D
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46384DEA;
	Fri, 12 Apr 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VjacxecF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6584A37
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929482; cv=none; b=fA+DgkKoYUZAtJR514sas30wzHGJcv+Z8dJGiKkVU5VcZG2fYowu8BSibFnRInx8nizf7VRY+XT+9OB09MyE1LMws+RlTw2DiT8M+SZDj2lEkkQDr/Lx0+MmWeS6TjFzDrBelXn1wQ0gM+VVyNhKpc8C8OJ7F45jRSlNVZdGnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929482; c=relaxed/simple;
	bh=1LUx/azHzFOG4muj/vmnH8nNBtVdcDizJ6g0tuZU4/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWg4m3hg/ITIfQuj/IEJQ+wrSRK+SmzTqz+1scJcDEPuBNmJtrYXjPKFdK7DNiC/qO5XdnXj91zy+h5bJs/rQ7SKcVf5PY6QvlT5Sp3ahlpNlRHSyvNFHbtpld2/WEIpWBPvsY4QMzD+eeWt1ywB1gRnoxK4g9vPjc9pa9Sz2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VjacxecF; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso8126239f.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712929478; x=1713534278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGTUKEajo/JXZcQ4wWkVN49TZZOOxP3U54xUOzC4Yls=;
        b=VjacxecFXT2RAC2xxPa0NrXT6IdNmdS3/yYEGPm+HfNKxtKyjlG5wz/EQf6eB1GIZh
         TXpzOYo//si+D0gV0qlRQkmvKe85FiZJOdJU/XEPU6VUwTKQD+XIpvTV7wObXy1jHSjd
         Y1lbJ7YvTj7w8PFzCHdNuf92yCtUejtzJV+cwwt2+dp36y6zsyOFmbD4tO2sFRAWWreF
         yystZbzzmL3mTG/8sUwePt1vEed9M+MQM2xELjhntM1sh90K8yBsYqN9rIUT4MEOZBLy
         HIW5rM9ZRwePavPn/bxEepyQbs1acbw6drtO3PrKiE8pgO9jG3c99rC3oBkG7HfywnXl
         RIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929478; x=1713534278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGTUKEajo/JXZcQ4wWkVN49TZZOOxP3U54xUOzC4Yls=;
        b=w3iCq17EES+Sa5zBBalBgniKjRRMLqrvCdOsIPTJqXLilfOskmVNgNdMA6alExQ27q
         ZFY+qnuL5LvcbHrl2J0dw5wY4wAlDW82r9Md0cr1Tm0NXNvmfweQxuP0JS3gpoDX8QG7
         ke9IjQ6sB9Y2seOoWttQpWC4X4YpnEqMp5DBnp295jaLUP24fP4RkkolMTpa2BunOgPI
         +GKVChnXnLejjK5d/nVZT3d2vhvlZFL1dtZmqcHIj0lMsuzKa/nIUAVcQneGL5tx68gd
         zRKkxJIijFRKiShTBxbwYCO4GtReoyXNGoMbpgzETSNghRAhRy2FyukbYFttOY0uBnVP
         npeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3COFNtkeuXIW+Ct0FFEOd9uam0JvCYzZL6DWcSxDbs3p+e9U1nB8yoqg9UmKKGK5/w6HdW9YtDC0fUvkQb/FebNVwJ9oV
X-Gm-Message-State: AOJu0Yzepwj+nm8uIjyhjTMSjJ15mIWPJoO3sZhG6stHDBR24LIn8jLv
	WIooOagvBlA2+OTP1wbqy1pK7en2UZO+yyFbIxGaLJ/Qqal8VIzrE6xR2swm2VYraSOX6EKgFcQ
	r
X-Google-Smtp-Source: AGHT+IGtB/XbOjaJElIO7Wqif4uZvwoP3VdlD+z/5Oau/GkvWAEt8SJS5v3PtiuVciUCgy5QWhYBcg==
X-Received: by 2002:a05:6e02:194f:b0:369:e37d:541f with SMTP id x15-20020a056e02194f00b00369e37d541fmr3496119ilu.1.1712929478241;
        Fri, 12 Apr 2024 06:44:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j6-20020a056e020ee600b00369ebb0ac45sm998369ilk.17.2024.04.12.06.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:44:37 -0700 (PDT)
Message-ID: <b44684a5-13b4-4717-a653-cfd0c920bb49@kernel.dk>
Date: Fri, 12 Apr 2024 07:44:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/6] implement io_uring notification (ubuf_info) stacking
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <cover.1712923998.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1712923998.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 6:55 AM, Pavel Begunkov wrote:
> io_uring allocates a ubuf_info per zerocopy send request, it's convenient
> for the userspace but with how things are it means that every time the 
> TCP stack has to allocate a new skb instead of amending into a previous
> one. Unless sends are big enough, there will be lots of small skbs
> straining the stack and dipping performance.
> 
> The patchset implements notification, i.e. an io_uring's ubuf_info
> extension, stacking. It tries to link ubuf_info's into a list, and
> the entire link will be put down together once all references are
> gone.

Excellent! I'll take a closer look, but I ran a quick test with my test
tool just to see the difference. This is on a 100G link.

Packet size	Before (Mbit)    After (Mbit)   Diff
====================================================
100		290		  1250		4.3x
200		560		  2460		4.4x
400		1190		  4900		4.1x
800		2300		  9700		4.2x
1600		4500		 19100		4.2x
3200		8900		 35000		3.9x

which are just rough numbers and the tool isn't that great, but
definitely encouraging. And it does have parity with sync MSG_ZEROPCY,
which is what I was really bugged about before.

-- 
Jens Axboe


