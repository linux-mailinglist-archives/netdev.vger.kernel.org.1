Return-Path: <netdev+bounces-176813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202DA6C444
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5497616BB0C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF3230BC5;
	Fri, 21 Mar 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SVtixoBt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825D230985
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589201; cv=none; b=ToO+CoL4Q3wkvfCeW+x60pZLbBxtYqViWngwFHVp1f2l3YQnhv+RhVT+CMUL0EkXTRluOzJdq7N8QGTSTbSmxpFV34leAJShS6KEJQTMfe3Wg24C9RFyy3cC1Ft6ZzNZiQSD1J5dgABRXiZOMJEkOefBK+3KVI6uFEMueGilge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589201; c=relaxed/simple;
	bh=7lhaM0CG+9tuZnrS9lZcJSlVArtevf4SVBCaDSzqoIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QBdaGbBDC//ar6vt7ZuuajBiYHg2bRcJhONelOPEqr5a7NPh1fFMPESvIdxt3JB1T5/HhS1nqEGWWk9NtRBDi8xZAFyidpoLUFT5psJ1oFd96PiizMC+T4wh9dS+QgIpmFEXfyYO5H0HbXEkiv5y0A7Y6aAoYMJZX/KZlmknq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SVtixoBt; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d46aaf36a2so20480335ab.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742589198; x=1743193998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuLZuFCKSKg3PxWQwRd8ETXjNuULumylP5s/6/Th/nI=;
        b=SVtixoBtotTxS6U4OZnzvnwk8oHnpE5tf1GYD3KBq3Cc0Z3z2DvJCO+isPNrKorK8a
         gjVxI8la7UKqZ74wjvpo88bH6DalQR63upAndrbxyIbIqKlVQWT9inb5LoekVITnO13M
         YXHxU9qVg1kRPZTG5B0GK1yg10GH1dhKVqrBdkYHPSfyTjnw/aiC5D1NMqYgewsIDmv7
         YZ21gTmmw4QWdO3nayryvKBK6P7rRCB9orRDJumCpp+Od3acMeBIdn2peLX8yki/z4mZ
         0BAvCrd+xVGCsC1GxXfOxWch8XxR0YwsZgw0hHYPqiJPNWGaCaIjDK6NsYOgAmrki/Xu
         tFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589198; x=1743193998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLZuFCKSKg3PxWQwRd8ETXjNuULumylP5s/6/Th/nI=;
        b=XkYLbJ4w+06fQBjTcnqOwahGtg83stkQglHswf1SVdsXai+8qauGnJ1TOA7Bpce4+4
         5iwRJr7ycqyCteIXXMOt8g2K3jBk3FjIErtLdlIL2C067HgF9c7V/JErXRp9lGhYxCHT
         k3WE6i7GKBa0ctYd2RNBrZM+KOOAUtzhiHxte3eSl/9rBIz+yu2oI7OSmtWWtvMZqimH
         d38OHmo4Ue0iALU9JuxSDJaqx1CDmFrSOxW4shCQIaauJSkfaI15vKEMCsCtt1E9O5bU
         H6ncIjV+HeC5qOTtI55TALhP4lSnNcBFul7Vnk3D26rwqv9Q9yUByGf7DcoVaT2xbSW0
         vsiA==
X-Forwarded-Encrypted: i=1; AJvYcCVvGFlaJ3ap6jBevBXKWl7d4QSA53SNxFjWDE7UdlPhwc2a6DPFhKrBK58t1GiqViadHtQzqwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgnmy2rn/E7Wfxt0wqSKoRAd0DSVDL1RQM8iy+W09N3pZllX+A
	Uas+S+amNGDKfZJ2xeAeqX9GQPfSvcY66jJnFygWmWthWnZ/QpAJWNqOwcJmT4I=
X-Gm-Gg: ASbGnct+Ulakpt4siUETnuBmtEj0gDzeeP4lTVtOePKB2wIU36D4NwFQdsjd27sbZ2t
	8DXvd/mP8lEskVmHO5tws7vbay2Pq6ZnbwN42FCdWGVQJ/kyGZpwPCcNQBvsrCkAEKZlyUcXq2z
	z1NENXXTH4I9W56ppTEpWakTMicL6jPcL1lWAQFf6iXFOZ4hB8NxRI4CL9M8hxBvbdGrcjVfQfA
	k6EFSbOLdNQ14hwJgRXN3UtobPYKdMsjusasmAg2lXq/nMhGU4cIK43YMJt5WDyCK9doYjyGR6+
	b0Wkla8H/QPXZz79lwCTQFgC17MxzhPq1Oim3d4lsw==
X-Google-Smtp-Source: AGHT+IFI91THLm3qVJtECcXxa5n7V2R1Cftu+sQP4tmofv//BmWK9VIunVWN3AluV2sQCeMt2KYACw==
X-Received: by 2002:a05:6e02:170d:b0:3d5:8908:92d0 with SMTP id e9e14a558f8ab-3d5960d22fbmr49781055ab.3.1742589198084;
        Fri, 21 Mar 2025 13:33:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdea05dsm582166173.63.2025.03.21.13.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:33:17 -0700 (PDT)
Message-ID: <67a82595-0e2a-4218-92d4-a704ccb57125@kernel.dk>
Date: Fri, 21 Mar 2025 14:33:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2> <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2> <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2> <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 2:30 PM, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
>> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
>>> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
>>>>> I don't know the entire historical context, but I presume sendmsg
>>>>> did that because there was no other mechanism at the time.
>>>>
>>>> At least aio had been around for about 15 years at the point, but
>>>> networking folks tend to be pretty insular and reinvent things.
>>>
>>> Yep...
>>>
>>>>> It seems like Jens suggested that plumbing this through for splice
>>>>> was a possibility, but sounds like you disagree.
>>>>
>>>> Yes, very strongly.
>>>
>>> And that is very much not what I suggested, fwiw.
>>
>> Your earlier message said:
>>
>>   If the answer is "because splice", then it would seem saner to
>>   plumb up those bits only. Would be much simpler too...
>>
>> wherein I interpreted "plumb those bits" to mean plumbing the error
>> queue notifications on TX completions.
>>
>> My sincere apologies that I misunderstood your prior message and/or
>> misconstrued what you said -- it was not clear to me what you meant.
> 
> I think what added to my confusion here was this bit, Jens:
> 
>   > > As far as the bit about plumbing only the splice bits, sorry if I'm
>   > > being dense here, do you mean plumbing the error queue through to
>   > > splice only and dropping sendfile2?
>   > >
>   > > That is an option. Then the apps currently using sendfile could use
>   > > splice instead and get completion notifications on the error queue.
>   > > That would probably work and be less work than rewriting to use
>   > > iouring, but probably a bit more work than using a new syscall.
>   > 
>   > Yep
> 
> I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
> through the error queue notifications was OK and your response here
> ("Yep") suggested to me that it would be a suitable path to
> consider.
> 
> I take it from your other responses, though, that I was mistaken.

I guess I missed your error queue thing here, I was definitely pretty
clear in other ones that I consider that part a hack and something that
only exists because networking never looked into doing a proper async
API for anything.

-- 
Jens Axboe

