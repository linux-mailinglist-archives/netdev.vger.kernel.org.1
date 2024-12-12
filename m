Return-Path: <netdev+bounces-151549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B639EFF6B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E835528741D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BB1DE4CA;
	Thu, 12 Dec 2024 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iSEPkRqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80E189B9C
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042838; cv=none; b=KwRVJiKUESTvPQs0TMRZql/fuafDF00n7W469FnCvjVsvQcmlUPB7u6AX9V+MqiVzu00HoM0PDOzoI0gqicjhuNs4n6TE7yn3Xg4M2gxXY+PQs9Fyo7XjCFfScKXer+rbqSzV4g4qgVnrrEn4cnSTKcef1NCCEyQYK98Qz1o58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042838; c=relaxed/simple;
	bh=36YAogMX7x24g0pQeoCE/qs8dnhjjhL1b9vSyDJOakM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrx5yuAESdZ2iU18HKcm3fB51kUP1h/cwVUJF1MONUFK+0olDqOykFCtkd5DjFr9lfqpSXL+5CySsj36Lv7E+o9Yni2oPzk0itmzNJ6pKrnmv1vr3iWidCUtmJfencPjx9uMWBXC51O/u7wMTgKp+ivBo9tmi3bIbs9XdQ/9e7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iSEPkRqj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21670dce0a7so13187645ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734042835; x=1734647635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeEPiUp6GO1fUUGBf6fhGJf1W+84fzvf845Jfc1nnYg=;
        b=iSEPkRqjkCjai7NuVAqqJPg1VMfqOO0fmtp1UL0F5/2e7fSXeRuypWuxh98G6VVHQM
         /mTkgsmnem29MtbP666a7GmhYWEI7ITnvhgRnw9PEpHBEcvvAjVAxSbB8AQxgkd6AvDO
         km5IfdxrBoItWCliWkE3Sk57pYAU0FmLjLmxZoNJBVeCUtqmnXFbcKZ2UCx/5OWLJPdK
         t1PodOEgx9+Ycijv5xHXhOF9zyYdIMd1YtBgI+p8eZNtHohhpkAZgUD0THs/n5fxUhPK
         H8Zb7jv2Ff7QskPsVxONT0HE5u0aYRK3O2byulOkLjpjSBBve/Gxe/qzTb8+bZEimjo2
         3sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042835; x=1734647635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeEPiUp6GO1fUUGBf6fhGJf1W+84fzvf845Jfc1nnYg=;
        b=oZtVHZl0D1LiRxEL8z6CvCiwRwvwAbGsD1U7rGGPPC7fwi3VVk1t6sgIMay+j9WEXg
         6GzbiQAjMa+nQXNolpZ5in4CYmDm3vaxm+P+ghqeA/RaKE77Hv6RTYScHlHPWsBCJQbq
         GhAg7h5/bpk/3hC9V8D60l68DMVCFBU37zh7fKr1G2GmygKxTlSGIw/sCmpDTyed8Oio
         NCgurFfJ+EFuzBpnqS0l/zRWxX9crlgevTW5Z3/fahWjFpUASN3piIu32SDScMCJFlzv
         rjZ5ZrUJRe3XBrzBlYEVnBuE+4A0WN5Nwc1f2/wzX7lie/V5EgFlMreQJMoOyYuwsDXe
         OPig==
X-Gm-Message-State: AOJu0YwO+CuzsARXRfMmDTaw4GSrlpgeCMU6gJO71uXu5k1K8BIs06bl
	PgOyVCZyDPV0SZuhwc1JscDxLXX4b4hUqR9W9tobUC5QnuGC4oEUhfZnTydTxA4=
X-Gm-Gg: ASbGncvzCSTvtErxacofiZLiK3ZI9HS8zl7eECjqNZM98rjMU8jDSMVni4KxT5YAp1R
	Fsq23nyVwu5HrSrDlowYWALZQpAophDa5x4YBBRyuyYL6SJRmLLToC0wFIsQ2/7a9taoJi7NFtJ
	5cR7f0YlmdPh9n2E0bbGQT0jzdzeIhYjGEAHOuJH/XVaL+Hl+v/+uSpMH+CuAe4M5W0hFjSqqkQ
	e705r4jsljbKuFsBiGTM41rVpGCxboWoXiRMG0EWuQvZv4mcraxIg==
X-Google-Smtp-Source: AGHT+IHwq3TLu85j2IlaR2hxhwcRoLJzeDaudP3TQFjjBJdBHRIPPc4zxOXIXe6BnPJWLZY0mqqqkg==
X-Received: by 2002:a17:902:e752:b0:215:b01a:627f with SMTP id d9443c01a7336-2189298169cmr6022455ad.4.1734042835065;
        Thu, 12 Dec 2024 14:33:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21661c08b6esm66164195ad.80.2024.12.12.14.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 14:33:54 -0800 (PST)
Message-ID: <e2502307-6302-46f5-afd2-0cc5aa503b11@kernel.dk>
Date: Thu, 12 Dec 2024 15:33:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: tun: fix tun_napi_alloc_frags()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com,
 syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20241212222247.724674-1-edumazet@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241212222247.724674-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Oops, thanks for the fix:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

