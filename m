Return-Path: <netdev+bounces-246024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94612CDCE1D
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19447301F25A
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4C32827F;
	Wed, 24 Dec 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz/La5V0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9B28D8FD
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595010; cv=none; b=OqU8QZA+CfZaeaAHBV+JLVsdw8xYP4ImueRJFrgHyPXNnMCKUw2H4wzWq48EOQlXssuUvHC3IHxQkeWaTLc+bBIE1Irt5OtPcKVTzj6Js7tey8oFz1Pn8v77yGWNPg+jDWE5L2iAggbeuPi4EdngekYPPZKCEIBo9fb38ryZPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595010; c=relaxed/simple;
	bh=pD8YfDZ8KDvIJ2txTMDBnlCOh6vlZTyz6vhh+e8d2W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lES0oURgro+xaUwq8TlaRmiPu2/+DphuWZbBjrRSMcr7Zv5RDW4FxvsCWxSQv8UttwOacOOFoYYGiHy3/5mBTNpCLHn9F3v2fiIXng3iLo44ZQgWhUkAgqDSHRSV5sry2DG9zMTnDM5ip02scY1zB7LrCSKJOLMp2rX128DVXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz/La5V0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so5156046a91.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 08:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766595007; x=1767199807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnHqqpgJDbRv/a/D7gH1Mi4jXPMVJ5IBYITwv6FaifY=;
        b=Cz/La5V0IS2jWtSCTwPYxgGBPlIImyTU9hHDxzRUyWE1/AJ/Pk6VX4L4ax9ougmTOR
         +p8VEFCGM7DOpz87af4RVWlfK1yGgk5gYvV8PwH6QiIsNkHMrzz9DKWrBhrN+CAUCOpA
         GlZo4OWn/VooTBqxdjgnvdDngpOtQz5B0cFu5roID5Bv6kryrpdz8+lFHoMm0WNtwv7m
         4BGRgmneL04o967UkndgtTxfR42ft38hqPptGy1iK5D1CrxOzjbnxsoyumGG7wfuqgRA
         3JGMADqeb5k0pvl5PYG/FZDoPTI4fhbB9xyjvi15kkli/21w9Bph6F3LZmm44KDgqlV1
         QbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766595007; x=1767199807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnHqqpgJDbRv/a/D7gH1Mi4jXPMVJ5IBYITwv6FaifY=;
        b=O+VaXqNCcmJ9E8MX8pqqHMCReyVafE7ALABnrQDJapPZUM8E3ItFODn8Mm4nbA+WXx
         09Saz6PhvqxQLXi2xUAG3fI5SKENHe+ijCpeURMnxYCOpd0r3xT7SjoZ3AqkHYO0gAHp
         UZpy0HnRbsQi11ZSMXLTVzvTIVCxENRDtDHXyToNfsSgCkCtwZ9aB8A1ISVxYkvaY619
         xdQfFYiCxOgwTKSO/Fm8iNdnkH9pL282c9PRLrfrwSWHvl2f/MjnCIFU82KvtTBkLInu
         X8W4aeNUyqv9VjT20VCMou4XwAlriQwIlm4khvXCvsu4km/2vTfybdVP1ZaaQGgtu2pz
         aU5w==
X-Forwarded-Encrypted: i=1; AJvYcCVTQyk+UQa6xBq/qDetfr9kFst4ukHNH03tS1tTvgD+P4+YMPwzHlOKqvGzt/nFpejezrVQxmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBB4NluS+6xipq2SxMf2yl5quRR2heKJk3fjIrYno3Ah4wyyG4
	FIE7WsFKB1GyBLmD0E2m6r8Q4lHGnRLiLq0Wn8N1RUI/WayV8dybJAZz
X-Gm-Gg: AY/fxX6DNYRt70bS8Ecei7xf/eJ5UNXa6ab9fpxQhikkp6w7ICjV8FmlgoAI5Rzuhip
	gP/TG114csQyeM4fBfBd3n+qaZS+WDyb7XzE2Dt31shi3yNl30GIOV4x34xWEqhxB7xdWqmyKhi
	ng9rzDxCtbUkD6slsXwp+9o1BJj/bNG6dlNRD30tCV9q0+k7UvH3h6izYgiMOS+90PjmlOxiQqG
	OzhsXXdO6ZxzNO+K747lV527ZwKxo8L39lnxqe8ZnwtC/7QT9OLohGxCZaTlWHo/mV+jShMZ1ew
	a+z6IFRfRPJW/vplzkh4i8w6ARixLNfRhrRMRA0rEcXCz8zrI7yljet3+89z0DwUFUe4yt0XJuQ
	iWXJe/g4O6aZPoS8+JmYwtakEqAoBFQrVh+DXU2KihJmB8SE1o1oRX0dxByg6b07/MfZsKPbO8v
	xld81Jyi/xDXMY6te6BDcE6yiuuSoHbHrEiUnK8XRXR9hjQt4YVK4EOQzW053rJOmJ8EEwiw==
X-Google-Smtp-Source: AGHT+IFbzQ7yMQch0JLVgEhdJ9FTN364+UnyPdio+VpjXb21RfQOByyL0xWkrHKOy6iC60/tY4/H+A==
X-Received: by 2002:a17:90b:580e:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-34e921ae4camr14319741a91.19.1766595007324;
        Wed, 24 Dec 2025 08:50:07 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f26asm17027776b3a.52.2025.12.24.08.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 08:50:05 -0800 (PST)
Message-ID: <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Date: Wed, 24 Dec 2025 23:49:59 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251223204555-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 08:47, Michael S. Tsirkin wrote:
> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>> Hi Jason,
>>
>> I'm wondering why we even need this refill work. Why not simply let NAPI retry
>> the refill on its next run if the refill fails? That would seem much simpler.
>> This refill work complicates maintenance and often introduces a lot of
>> concurrency issues and races.
>>
>> Thanks.
> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>
> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
>
> Not saying refill work is a great hack, but that is the reason for it.

In case no allocated received buffer and NAPI refill fails, the host 
will not send any packets. If there is no busy polling loop either, the 
RX will be stuck. That's also the reason why we need refill work. Is it 
correct?

Thanks,
Quang Minh.



