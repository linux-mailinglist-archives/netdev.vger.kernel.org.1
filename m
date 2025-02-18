Return-Path: <netdev+bounces-167538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5A6A3AB76
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B393AD9B5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EED1D47B4;
	Tue, 18 Feb 2025 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="zqrVF1Iy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4B1CEE90
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739916415; cv=none; b=FcBnDamaGTVHzsmcUkel5er/PkcyhTPFlo6N2dcQgavf0FyExiiDrr2NpZLmo0o1KOIppXJ7QCxDKp7+Agn6S5b07lgO4O5YD+ngkdT6wUeiO40TfjooJMS6v+dRMp0ILpUDu6IpS4hVnp8B7bC0e+dSWm4mgBbrDIq2O/UpZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739916415; c=relaxed/simple;
	bh=AJbD0VhEqktAJuSbrw8sGimzHBizOzGrTkKzm+Z1J4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYeX3Wk0pkPuqPrgSrcFYCB1mtLadnZ+81bbQnDZjfKxkkEV7YjV/NCtZMEVLb2cL4NW7WkfjVBv8Ji25xkdCdO6ri+pa7fm5mThbl36XcNwHWoA/48skT3/U+ur3NP5oDnmP2d5+3wq0XZHQPzROmfzq3ejRYyl/qJMIcSbbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=zqrVF1Iy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22128b7d587so50511415ad.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1739916413; x=1740521213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtN7DCDXT4P0ZtMj21KzNqzVT5mPv1hMJBMgdgryY0s=;
        b=zqrVF1IySSBpyOhu/0aSPsfuiveXWPCbp9G5ROC/M3SefVPTfYT/+tv+JwAnM79zrm
         SMlqZoTYC6+zxVfLC2ISPsKCXGyoLw4nGHqjKg28eaPAcggu7ZssduFck99rbkw7iN4+
         zEqf82TRLzk+dQZRYh/0tqKo4Y+/V6UWMWC0aXLe9u3m4Cfb8dH9EeArtTOBY0VsP+ob
         iuQlchvBghOQWYzzrpqbkDpV2e9XuqDovxO8qyc1J8M1ln/neonmLkmCU54tOl+Vr5dG
         DllySkkDVYXsUNjdhpSpj8XUrmjnUf4/SCyK0aRrzuY9Dj3NvOo5G5YB8g9nHnDQzE85
         1isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739916413; x=1740521213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtN7DCDXT4P0ZtMj21KzNqzVT5mPv1hMJBMgdgryY0s=;
        b=frieh19ueWtff9hSDeshfwhUPQzdIcj/y1QYs4cT47dSnnnIL8dX3no5gIbOeR5/Of
         wz0mKZh+uzLl1eLHUHD7Ypuj+3CoT3Z/au4/o5429ryfjNJx3/MSwD2m380cbCBMZf6T
         m/qJoDeT2J3o0mn4082MJYO9iWcjssmo2a5E7DrnFVukfWiwXzplwWR9pakTcKjR+KmP
         dGf307YJm6PdZVW2cO8XCZfpaasgi+NYztlR8gVaOEGlbnMA+BuOsQcZmYmG63hw8ELV
         F5mi0dkaDQBjKB/DYIiGKPzfkXtj4OGs1gQzvIhy9FNUc17bY04bg7p1c6dL4sPqPI+D
         QwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV55oYmjVHLbA9UrJ9M5wT0FTl6FIUxnMSZ/gQaIU8w8eM6hb8lUSzhvs1Ykiy5ytE7uEzZKQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwLnk+EO16JSwqi6i3VylcKWqQPg1FtWj3UFWWQ3ZUblJj4Dn
	BmhfC+U7SmAVIYSQtOWLGoIhhM/iL5bIP8MiZomsfMryKp4/NqcfbMS26aasDuY=
X-Gm-Gg: ASbGncus1NU9BH83ubFNSK6ov6xTbOjv72qh55SsVaNgUzdGRcOHBhtK43+V9X77fmI
	EMThZ6fC9Ux81iYq5RaqOuTG7zpSH3EyffTFriXkg9o//IAzp3JQdFdEC3qdcEuczQvj9nVnEGc
	ispVrKwAjLQTZty2OkMLUmYkINzAQJ1PlM2EW9obcwjlQFFhQSGLQww170bDQ9d3LYcodBijEGS
	ThN3WjInEWn53yd4y18UPPHB6mbitcdRJ4uSUh1RgkJo9lciI3amoFPagXgKoUpxHOQtCiJFZYD
	60MvJ67ddFxgXwffYNEDIzpnpqLInzkL4IIAYHY8VTi47XMlwae8Yg==
X-Google-Smtp-Source: AGHT+IG/A/bMTekzmDbdpz3xMBmnVuelBTlzZd10/URTHLkaDPvfz+k5BsAxJxaQjCKm2JetrQ5V7g==
X-Received: by 2002:a05:6a00:10c3:b0:730:9567:c3d4 with SMTP id d2e1a72fcca58-7329de4f102mr1773986b3a.3.1739916413194;
        Tue, 18 Feb 2025 14:06:53 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::7:d699])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546177sm10599035b3a.5.2025.02.18.14.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 14:06:52 -0800 (PST)
Message-ID: <5eac0173-c75e-40b3-a1bd-7cedf86237df@davidwei.uk>
Date: Tue, 18 Feb 2025 14:06:50 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/11] io_uring/zcrx: set pp memory provider for an rx
 queue
Content-Language: en-GB
To: Kees Bakker <kees@ijzerbout.nl>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>, lizetao <lizetao1@huawei.com>
References: <20250215000947.789731-1-dw@davidwei.uk>
 <20250215000947.789731-8-dw@davidwei.uk>
 <cc1b81b3-f02c-46d0-b4be-34bba23d20c7@ijzerbout.nl>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <cc1b81b3-f02c-46d0-b4be-34bba23d20c7@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-02-18 11:40, Kees Bakker wrote:
> Op 15-02-2025 om 01:09 schreef David Wei:
>> Set the page pool memory provider for the rx queue configured for zero
>> copy to io_uring. Then the rx queue is reset using
>> netdev_rx_queue_restart() and netdev core + page pool will take care of
>> filling the rx queue from the io_uring zero copy memory provider.
>>
>> For now, there is only one ifq so its destruction happens implicitly
>> during io_uring cleanup.
>>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>   io_uring/zcrx.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 41 insertions(+), 8 deletions(-)
>>
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index 8833879d94ba..7d24fc98b306 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> [...]
>> @@ -444,6 +475,8 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
>>         if (ctx->ifq)
>>           io_zcrx_scrub(ctx->ifq);
>> +
>> +    io_close_queue(ctx->ifq);
> If ctx->ifq is NULL (which seems to be not unlikely given the if statement above)
> then you'll get a NULL pointer dereference in io_close_queue().

The only caller of io_shutdown_zcrx_ifqs() is io_ring_exit_work() which
checks for ctx->ifq first. That does mean the ctx->ifq check is
redundant in this function though.

>>   }
>>     static inline u32 io_zcrx_rqring_entries(struct io_zcrx_ifq *ifq)
> 

