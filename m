Return-Path: <netdev+bounces-137566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842B9A6F0E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79B81F2158C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732B1D0174;
	Mon, 21 Oct 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KAPBa9Lc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C51E5703
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526730; cv=none; b=A/KOQ7JiSWc91qxCH58yXxJh2m+k68uJ66v9AjpXzw7A2r4FGCMpKJb1ccd1+53bZwnyewHRPDzFaVKuBmnqsziI8g57k0Ty0g6TnjM28mZkgd80gdkoRHEFIX+bHgO4gjXqNiu8Uo+N9sIh7G00ysB0GOd9UjXK+4pOslqznHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526730; c=relaxed/simple;
	bh=82EnS5fxs4HAEKp3RYPaUrmzu5xS+BPxemHrEA4kBsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzlpRogYZ4f6ZH4xGVPIvhL40tpGHcIFKuQcCYRsRfOLxO310Bzrw48wlJaVro1UEXnwwFwKz5YsoqqZw6D57svoJq2HQ/FIiAkoqDvOf+09GBRi9uAaF2LhXwfLxsCEf9D+NuiVZwpOeD4lSa0NnOmNYemOHEZod8/QyUROKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KAPBa9Lc; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so196950339f.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729526725; x=1730131525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O20YdsRWSCZeo0YE58LeV4jhBG07ObRjvq/lCHiTEP0=;
        b=KAPBa9LciU2+u9r0tWWrGMJ4p6kmQBLo4a1Hc/N7PoYQZ8iOw+A3TgpzVL3hsnQHSM
         2iB8QT5jwPs21uRDzQEDKYDwCfMchmNiajuW69AOKS+mp8DNyoNl58srmWLKsPMYaqRz
         tJz7qfQBzgx0pvTdqwpnO5qyAswVoerhk+n5rbp23709FiImjndPy/N/NOCwlalGdMi2
         FL8c3oKDAv8GFIxLqqvmqdLTcyYY2veCSKx2GL+EYCivkbWJoRweNxtI9MUF3K4uPvXA
         P4wm3/jWgsvk9RdY8NuKCStQkBQeW+qcxas0YSaMAWbdzo0rD8jYLuWMc14znf1FdiAQ
         2iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526725; x=1730131525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O20YdsRWSCZeo0YE58LeV4jhBG07ObRjvq/lCHiTEP0=;
        b=iQBiutthwgw+xNG6t4aKPioQ7vQjNlNpI3BmgqdNWIn4Dx76FKViPWVLrhNJ2BP5kD
         mu5BvmwvIjsKXZUBDURt3/tC/RIi+cwKuEBolkbRfF7iA2UkTmG07EQV8WB7SKoicmM5
         M+k3Q7hQszH0K1YYf2umLvzZYDTqrn34S+vyOCKwMz5gDsUyWwUUi0p/I+pkU2rZPq5m
         nuV8wufKEYwThvC01MYqd7Ezy6XR5GTxLSTMhcQwK9YySFsLkDYFyJ8f5fwcWPFQi6/Y
         Qhn0rfyB948WZEm7e/Jl/wiktfuQKgtSK6JiAJJ3IFtcxcAhjyeSP8CEqnioUl9sXRM6
         C6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmTVH5DkjQ8xtxaJzwutqomBcfYl4qPU95M443BywrQNKVRmRsGOIr+7Ste3Oe16A4w+nz+NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYCcx3VHymoGyKWhGm73KqEqluzgDJRWe15qjluMMoFj0jHos
	M3gFwNc91iNWj15HQ2C0wFwnBka4aKe6ItdMss1beBsWbedvqCvznWjjc7CLV9E=
X-Google-Smtp-Source: AGHT+IHeta4vSc/mgvTqOlST6hmybeznoapVXDluV7Xo5064TrWo2byZXUX7KY2Rh4ywEgacKobZNw==
X-Received: by 2002:a92:c54f:0:b0:3a3:4391:24e9 with SMTP id e9e14a558f8ab-3a3f409e805mr108651205ab.20.1729526725084;
        Mon, 21 Oct 2024 09:05:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a400b6339csm12264525ab.69.2024.10.21.09.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:05:24 -0700 (PDT)
Message-ID: <29147d52-f606-4831-bf4b-90feda7d58ec@kernel.dk>
Date: Mon, 21 Oct 2024 10:05:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/15] io_uring/zcrx: add io_recvzc request
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-13-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241016185252.3746190-13-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

