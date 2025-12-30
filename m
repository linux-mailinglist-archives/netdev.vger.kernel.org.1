Return-Path: <netdev+bounces-246344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A542CE97C7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36A173014DA4
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB32D8799;
	Tue, 30 Dec 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXnG9A/M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYQXiRmG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E5298987
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092264; cv=none; b=tzLl+kE+pKMLtyht/Di8aZsg+GBrzWIrO6beTfObYb1zfVhtTWACUgh0g4l6y3Dlcx2YvcFt/SHywtjkMYDCZ1IHHfoWGNbGrvl22GUujHcqx6y74XoRWygobultolZtPEuaaBbV21cA5dJzXeXRWsn3ea9AnEJnR1ajGbHhGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092264; c=relaxed/simple;
	bh=V/1/3ZlIPwte4lIhzEYggEnfe104oTnwUbKnv2XPTRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gepMV75epZckt3Tb6kxFTvTkzhvgXIdcY5JbHwS/GnGwdm+7Xby0ijtJEooBZOln1P1wdo0Sc2WiI+jS1HtwvRrXdTNsF4intmrRuLHZOY7uP8Gh0iDjPrUdvMyJHGGpFMSKsirZWbfjkvw5TGU3NZR+yndtKtnGLhoofrzpIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXnG9A/M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYQXiRmG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767092262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbEAfyPD6GCZDZ+bI+W3v5Lu/3tiRYBKvGdYKMFM7oU=;
	b=AXnG9A/M6T8mGvu782o9we9tEMMvIXEAVj2z8APOUZpmSZNv/bB/jMQFnuKsToUAYBEmXJ
	zYA99BUlFzB04+VnDJCucMezsgFrfGwD+npfcRwcjppvp6wEhw+gI+yiWLtAsnFzbUQNx1
	c7uRI1yZjwAa82sfhACPj4/ToxZAC6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ZZG25QUkNKiJ92qWiuMAFg-1; Tue, 30 Dec 2025 05:57:40 -0500
X-MC-Unique: ZZG25QUkNKiJ92qWiuMAFg-1
X-Mimecast-MFC-AGG-ID: ZZG25QUkNKiJ92qWiuMAFg_1767092259
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fc153d50so7742857f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767092259; x=1767697059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbEAfyPD6GCZDZ+bI+W3v5Lu/3tiRYBKvGdYKMFM7oU=;
        b=WYQXiRmGgeNV/mBFvL3oud+sWsQct7wNu6HBj8rTIa9VnZzExUObXJnZiuZZ+Yw0Hb
         LTO7QtHQhtT0p+Ge1ECC9I0REgw1+Jn+0NectcAnplCsQFx2hLi/c+7onqRZ0/tltxvL
         cJ0GWynAtIv640zRkNCnF6Yj/aXWegIWgN5/52JdJOWpqzSzgBQK4PMIGJ0zxtlrlEKz
         ezGOYug/OkujuejKvB3/PokX1QtlKDxhKtk5KhBrTRAWeX06mi51APKDhQzbJosOifdS
         3K8D8NQSIJ3yhEedxIsWIqw0l3BoneElJI12SwaDxRqYW7iKjH4iJNy5HX+YOOpt+l8l
         kCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767092259; x=1767697059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbEAfyPD6GCZDZ+bI+W3v5Lu/3tiRYBKvGdYKMFM7oU=;
        b=Iw/byejyMjLYsDEhIeEWuoVLGAfC0EK40n1VoZ3CP/tQqWN2BnhOl749Wh/8S1v4sK
         0eMTLVaoEABgXzLXZ6FFngaBaq2zLsZHhZdOxfqEIyhrj0g8xvxJ8MS+/jbf+C6owJLX
         s6nXev0TFfkYWghgKkWcE0BoMiSXla6+YaLyy3tlLyBALwN3xYtyNtjpGcjMtQruOWBN
         s7H2XPYcrPApGeDnV8P1dfHnFby0pwNIDupAtp2k9Kmk4LSCuxsgGwYWW4+FeUsB9cFM
         uExSsdoeToAa5LeU98uzHlF+OOVqhJ7cKarbZ+T4SBowvIS5Fk+V14BHymigNCjzQABr
         npMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmfcsNu8pJdNqxJv0OxKh4M81xOo9z1VOsNHtOP1VPXIOz7YqaCaBauGuHAiJtB4sPvosI1TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfZpwSu+25LOOk4mN3BxKGRDc6w8kdX+wbfiRptY7jo5t9shX
	rVkusTSi8PPkBQ5CV3E9xA/G8MVSSKAyc8Rz40BtrsFYSHCEpka8hYwgycCI6/uR4uKhJ+QVuLM
	ul1MwTRfr7uMVUvAs8eSufkBItO1ks3+4qIPxEdQKUUK6wbg1nbmC9EvYcw==
X-Gm-Gg: AY/fxX6YcgeJBkBwHbj3yQfEfO4T970qQOg6FNumRfoCFHkutYAc0RrlvBbeKwWNOgE
	xmOxB7PVmBPeI0cttvPT0JiDo4lC0UqTbLUqpuxiF1mdJU6HyaH0iBSfMVhQGVuNx35+ZbdFJZI
	oSj7fEqNDTHwt/0s5Mi9iSQt8eMf2uR+bA00Ve563B+e82VF6GzpM/29Er9y054xY4alw7zw3qk
	xwA1wuJxnNTM2yRgThtmZPC4UhaqfBV2OHxqGac8Mfg6gASqG4ls2vhmd7URoyc94QJw4l56Q6B
	lKNdFk7vF/C0Al6zOUvzUdHM0VUUJD3aGUZI4DJL976qkpDjJEG2CbMm5lAfeUENCcHKc7O2p7+
	QiyBw5BBCzUyC
X-Received: by 2002:a05:6000:438a:b0:431:855:c798 with SMTP id ffacd0b85a97d-4324e4cba0amr41136378f8f.19.1767092259015;
        Tue, 30 Dec 2025 02:57:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyWTDYRsoqaRyoSq3kQyHFXwT5p+KaAxn3o9Tg9+oQYc1CXL+kmEb71sSuppneZdpNLjuCfQ==
X-Received: by 2002:a05:6000:438a:b0:431:855:c798 with SMTP id ffacd0b85a97d-4324e4cba0amr41136355f8f.19.1767092258622;
        Tue, 30 Dec 2025 02:57:38 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432613f7e6esm57485963f8f.21.2025.12.30.02.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 02:57:38 -0800 (PST)
Message-ID: <73f3d573-c093-469b-ac7e-36fdb7832933@redhat.com>
Date: Tue, 30 Dec 2025 11:57:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dlink: mask rx_coalesce/rx_timeout before
 writing RxDMAIntCtrl
To: Andrew Lunn <andrew@lunn.ch>, Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223001006.17285-1-yyyynoom@gmail.com>
 <ca3335ea-b9cd-4158-91a3-758cba9df804@lunn.ch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ca3335ea-b9cd-4158-91a3-758cba9df804@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 10:43 AM, Andrew Lunn wrote:
> On Tue, Dec 23, 2025 at 09:10:06AM +0900, Yeounsu Moon wrote:
>> RxDMAIntCtrl encodes rx_coalesce in the low 16 bits
>> and rx_timeout in the high 16 bits. If either value exceeds
>> the field width, the current code may truncate the value and/or
>> corrupt adjacent bits when programming the register.
>>
>> Mask both values to 16 bits and cast to u32 before shifting
>> so only the intended fields are written.
> 
> It would be better to do range checks in rio_probe1() and call
> netdev_err() and return -EINVAL?
> 
> Anybody trying to use very large values then gets an error message
> rather than it working, but not as expected.

I'm not sure we can do such change: any eventual user with bad setting
will get a broken setup after kernel update. I think we should avoid
such regression, and use something similar to this patch.

@Yeounsu: the type cast in the current patch is not needed, please drop
it, thanks!

Paolo




