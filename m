Return-Path: <netdev+bounces-191887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD949ABD9A2
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512AF1BA396B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2C242D8E;
	Tue, 20 May 2025 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddktNoAq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43E242D9F
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748271; cv=none; b=nnHqFtjaKLSS3kX2ry7gvHY/ST5uCkIELlf9oEcRy3vLLeBIMDry3zK+yL1bHvHvaVIflZfes8xB2SEgCIfLh7Ptg5a+39fzk6HXDk6Krxlt7G+/3GgaccbX9bq+ibkC49Dv+z8q+c67HOh5coK7W59NwqEw0B4eHGfTNn5iqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748271; c=relaxed/simple;
	bh=U5YZUOHnFba3YEEPRb4B8MFish1XcE6mlQd58Sc0Ulo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Knb4TA5PaVVLJB2zrO0Q6ulTRoWwkOzBnXGoy4VwnW0XY0GKm3emrK3MA1lc7u5JszydHFcSB4lXvqaeqWmvweTzLJ0Gxgey19AifIRlUlj1X9bBq7WjglKQAx/n1BJQW9wPyRDp0q4MnWZYo2HUPXN/PF6yHFcLGvM7mJjso9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddktNoAq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747748268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMsyQ7VNnN2qO1o186LSTMN+Ccv8Zs0ud4b/iPJ/c0Y=;
	b=ddktNoAqoxnCA7ZVQCm+NgnfJHx9H82vcdyAbyij9F4XxE9ok7IHRnJB6aBfrucca0ak6e
	9DZ0rRan/pfirb9CiyTvsgiOJdrm9j1QxpiA38G0r6pI+oBvlZvUzI4L5A1t7C5crRbycW
	3T+2tTClPHLu7A4tsfzOjmKwU6TV+X4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-uBwLxOiiMd6QY6Qu7Q5wSg-1; Tue, 20 May 2025 09:37:45 -0400
X-MC-Unique: uBwLxOiiMd6QY6Qu7Q5wSg-1
X-Mimecast-MFC-AGG-ID: uBwLxOiiMd6QY6Qu7Q5wSg_1747748264
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf446681cso34542215e9.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 06:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747748264; x=1748353064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMsyQ7VNnN2qO1o186LSTMN+Ccv8Zs0ud4b/iPJ/c0Y=;
        b=SA6Wg/PfmNcQRIohLFtTzeEfxzHF/MdnIq6dKn78zuW0HGVlBCnMGCX5xaW1jdug+A
         eIFEdEiqgpSHCcn8oItObbu1wYyAtKqCn+aV9hqLjmvRYGB6sdwO2yXwgiGAz+teHNFi
         DKKij2Cej5fnqJ2PWohLFa8MVqmb+WhIROCRUifc5jipcGePe0R8mydq7xPkxdtFKbL2
         UOSjkUiZcVve/ZB5z3/pxc+R75IppjxNj2QSZpnxuWfFau1nNWYKVzwjG0tSDCZx5A7z
         8a1lRutBVWF2aGAptNb2UP9ZQkqI1MYDYEp9dswZr22yFkne4zcRD5NSGuZ77kNybGbu
         GsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0fDdXJBdHlE9IBfRqJ9Ib0xmtWXIU8jCWLIcRfq+cIce/j3FlEYfFNq1plL4YbTISl/vL4Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynkcw72goN8dXnUgwzthUK6Uy2Hj9rQZWtIGha4+xp3Ho8egQc
	+Rugx2y1x47QlhQOxU6uPcq8BC+unWjMzfHB9hQuLzjRIN145TDQsVeEpbBujHjcC5tkX0bZZP1
	nXoCe1Hy7mrAG4B4QEhrmdPGS9EEVvf1e2goR0sbKQKJfjmeU2NG1dD94lg==
X-Gm-Gg: ASbGncslPqWhIdrwqb6VvW1uPBz3NPnlMfUjjplUJKKznw8I7TvYWmYUY0HqNwk97ye
	eunhJ3bwedKnzc1zOyVDhWtCapOhlKfTJl+Y4tp6Hx4PE5xlQ/lGGdIZ1rGwcMqSmycQS9YMZ9b
	q8sRei+P/3/LD4DEvAYQ1AfoDfY5Eti/f3gt8IWm+Hg33AK2dhmdUfN1hI8ij2PQ3+Hcig+Y4Zu
	xVBVPWW1V6ezefGRgbQPP0oXtLdrt7zINpFdGedIj2CtAeVFD3tEweOxRIyGBMdWVBEk+DjXye7
	5Ws+Yk+1c16Md7dSzho=
X-Received: by 2002:a5d:5f8d:0:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a35c834f91mr16985993f8f.6.1747748264370;
        Tue, 20 May 2025 06:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2IgQR6pfl4f9JZX+mTcQQJIcZJQqSQkpv9zrll3ynmvnMB9+rl/8mcTBCpK5VIAeoxVyW1Q==
X-Received: by 2002:a5d:5f8d:0:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a35c834f91mr16985962f8f.6.1747748264000;
        Tue, 20 May 2025 06:37:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23bfdd9sm31041385e9.18.2025.05.20.06.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 06:37:43 -0700 (PDT)
Message-ID: <c9465324-b2df-4507-8d17-7cdda55a60f0@redhat.com>
Date: Tue, 20 May 2025 15:37:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
To: Eric Dumazet <edumazet@google.com>, chia-yu.chang@nokia-bell-labs.com
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com>
 <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
 <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/25 12:32 PM, Eric Dumazet wrote:
> On Tue, May 20, 2025 at 2:31 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
>>> group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
>>> group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
>>> group size of tcp_sock_write_rx is increased from 96 to 112.
>>
>> Note that I'm still concerned by the relevant increase of the cacheline
>> groups size. My fear is that this change could defeat some/most of the
>> benefist from the cacheline reorg for all tcp users.
>>
>> Some additional feedback from Eric and/or Neal more than welcome!
> 
> I have been trapped lately with production issues, sorry for the delay.
> 
> I am still working on an idpf bug, hopefully done today.
> 
> Then, I am OOO tomorrow, and can have a look at the whole series on Thursday.

Thanks Eric!

@Chia-Yu: please consider the above timeline before posting a new
revision. i.e. it would be likely wise to wait for the additional review.

/P


