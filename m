Return-Path: <netdev+bounces-196995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE4AD73E1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEB1168F11
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E822E3E3;
	Thu, 12 Jun 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SL3L0XT/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDF17C220
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738700; cv=none; b=szFXYive4MowBjx1uEUSpRu6rx9pS7dpGdCOwh5wsKe79El/53iEV7acQj8Qp3YjGqB/y2wjcxyj3UnXotRZDD9p6r4vAAFdpqekA+DOKS4PhUAhVFTBK6/us9MW9L4IoTso2YJKbRQ7jauEpMMzS+Oj0janJfphRFntWrXemQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738700; c=relaxed/simple;
	bh=xVQNfAzfyKMp81kDC1+SFX3ss6PcvfYUjeRMfUAOPhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9212B9U2BAZkkKo0/DLXVz9sHrMTMHreRU1CjTiyKakYBzTW8wZbeZ5ulY/DyArb9JITfcPrKpxOCXTlkNCwL2pB6HCg7n1nsOvv44fKifHIbrW5CrvRe4HLrW6ZFPjB3EIUEzWK6BLQ67eOvEkr535KejxLTl0uAxtIHBs5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SL3L0XT/; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ddff24fdc4so1922745ab.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749738695; x=1750343495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+f+FoEmVo5kuhnAsLmdeC/TVsbpdV05VQHm8fdPyww=;
        b=SL3L0XT/DzkJ4caXLxjVOd2ihgYwueut2G+A/+HyjJXV/NsXfKlVTPbMQ5ActtdDV9
         bnhWrMUUPpwnbisyEiaypcqJM1vOuCTV/rSFSIgtqboMs7Czx22OOMq5NbUUAv3UZEAb
         9vVGgm+ERBAsd7N++HgS7swdz3aeQm53td/I+zg+pwaMv9JBqi5i0W88PaF5BGjRKt//
         1kJYcWV3wGLZaUi21RgN1VgOoxJF6L6NwCC8faaMBzZhKMhpN2keNpF1+y0M/TQzo1R7
         DZK5kI7Ifa3MT8ofGJUgINWfa29yqxDS5r0QxJOCzXNnJbgfSd/QT1NTKrwjahl7y+iY
         jwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749738695; x=1750343495;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+f+FoEmVo5kuhnAsLmdeC/TVsbpdV05VQHm8fdPyww=;
        b=J1ZPWz0rt11VXrLP6IzRKkBVMSmJagivHIFKTxIW/LzqpV8tJCG3D0gNZii0Otm7r+
         7l4yW04roDnznNIcCJqORvHdoBng1jcMx95OQ4vWvQt5+NtPEp2UuASxYSRfoIxc4qod
         wKIiAXMywrgzd7WpzJXjh/XSJn4omHzok+luxKL0WE/oyqWAN0xF5EcCV+EKBDtHnv6B
         kCCyq4V4/uzVd5Lil+ICs6oaZKe8rXxzCqqPcswp1nNF9YYtdV/HqO2gjfwXZn1zuksP
         NRsuVeb0Z6hHbFVORLNLUZsJA7HUdNo93qtUNhWqM3/aHzYlRERdpKhk5umm0GaZ7Vu8
         VQAA==
X-Gm-Message-State: AOJu0YysXyTkc5bC82Mkl8bcOhbQ3WcPfmRYAWuc0qeXbMYVoHfJbbkk
	CN+cE8mgkOPzeJiePQKIEVjdJ0sTxvLFEuwBenuKML8zcw5pzYMfSaOuGq0R+aAYA2E=
X-Gm-Gg: ASbGncteGj4AMJRss6DVdzZwnkxKr5X12aEeaA62/R/WDAVYxXLNDEkvlt8aaQuehu6
	vXymUrHvJUAlPekVFiZlPibPjNG7giuXGDlPoIurzaAbcGJOhmDScPXHe+PmXpxhhtBeILDjpWs
	+XblcsQiDitnHGBG7P+xfQyqxYeKjtwF+pt//UEe25kRvFacbpxdwHy7Q+GRjhjgEaKNwn6Y+nS
	tuQrKYFCQUkVmqAp+kR8N+i8GYyoFJ8KXNJAYU9uk0y1RW5Mow+jGOaTNCCYtXMG72xVJs0GnOz
	PVP2U3ng3BvQZOf7aWqxZMgiZC2CSwYA7zIuYkRfgPTiYworJ00pk9Pzcpm7BOCT4BRUDg==
X-Google-Smtp-Source: AGHT+IHE7sJXer1HpQCj1UMq+87fYyAikoZwTZvic4Eo7ZcHmkv96xFqS8BlRyX8QS+W/nVyC9AfHQ==
X-Received: by 2002:a05:6e02:3b0a:b0:3dd:b808:be68 with SMTP id e9e14a558f8ab-3ddf42e33d2mr88585425ab.16.1749738694929;
        Thu, 12 Jun 2025 07:31:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5013b8d6cbcsm305439173.111.2025.06.12.07.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:31:34 -0700 (PDT)
Message-ID: <ae60dd48-9e21-4a9d-a8d8-d98a2e8e6c8f@kernel.dk>
Date: Thu, 12 Jun 2025 08:31:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] io_uring/netcmd: add tx timestamping cmd support
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jason Xing <kerneljasonxing@gmail.com>
References: <cover.1749657325.git.asml.silence@gmail.com>
 <1e9c0e393d6d207ba438da3ad5bf7e4125b28cb7.1749657325.git.asml.silence@gmail.com>
 <2106a3b7-8536-47af-8c55-b95d30cc8739@kernel.dk>
 <7bfe8094-17d7-47d0-bb13-eec0621d813d@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <7bfe8094-17d7-47d0-bb13-eec0621d813d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 8:26 AM, Pavel Begunkov wrote:
>>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>>> index cfd17e382082..5c89e6f6d624 100644
>>> --- a/include/uapi/linux/io_uring.h
>>> +++ b/include/uapi/linux/io_uring.h
>>> @@ -968,6 +968,15 @@ enum io_uring_socket_op {
>>>       SOCKET_URING_OP_SIOCOUTQ,
>>>       SOCKET_URING_OP_GETSOCKOPT,
>>>       SOCKET_URING_OP_SETSOCKOPT,
>>> +    SOCKET_URING_OP_TX_TIMESTAMP,
>>> +};
>>> +
>>> +#define IORING_CQE_F_TIMESTAMP_HW    ((__u32)1 << IORING_CQE_BUFFER_SHIFT)
>>> +#define IORING_TIMESTAMP_TSTYPE_SHIFT    (IORING_CQE_BUFFER_SHIFT + 1)
>>
>> Don't completely follow this, would at the very least need a comment.
>> Whether it's a HW or SW timestamp is flagged in the upper 16 bits, just
>> like a provided buffer ID. But since we don't use buffer IDs here, then
>> it's up for grabs. Do we have other commands that use the upper flags
>> space for command private flags?
> 
> Probably not, but the place is better than the lower half, which
> has common flags like F_MORE, especially since the patch is already
> using it to store the type.

Just pondering whether it should be formalized, but probably no point as
each opcode should be free to use the space as it wants.

>> The above makes sense, but then what is IORING_TIMESTAMP_TSTYPE_SHIFT?
> 
> It's a shift for where the timestamp type is stored, HW vs SW is
> not a timestamp type. I don't get the question.

Please add a spec like comment on top of it explaining the usage of the
upper bits in the flags field, then. I try to keep the io_uring.h uapi
header pretty well commented and documented.

-- 
Jens Axboe

