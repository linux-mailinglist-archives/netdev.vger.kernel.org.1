Return-Path: <netdev+bounces-212561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D630B21351
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581403E361E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E67C2C21F5;
	Mon, 11 Aug 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fneugd2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3683F9D2
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933757; cv=none; b=jWL0uS2EqJO1qkQ768+gUK2F0oednqltBvlQzUSp7N6ceOQ7cNsZRJ5FFg8R1YsrhEFjxro0hv1aDCUermYwkzYuTj7GDrKi/K9npaIxFV4wj1l5NeKXvTwAuwTPBpw01bYxPtwe2rYgqVJwQzFDb3PpR8EcY50DfhA+uqb3YoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933757; c=relaxed/simple;
	bh=rARiH1bzKpms++UgJqy0ZCYjRcLfjrYqWgzQ3FLZNhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfLzxfr5Fh1MueyWK9pqFlSOZc1lRLeAObOkPxf5l3PlRr7ZfG2KBsZcgCOyGzXk4sB/4g7iIx6W5QeDayyiZWrI0hw1S5s7nlHQ6r8PjUOHvUEs65OkP7lMpyDZnmHOrqV4GK9U/p+kReeGnp1vAzDoBcY0qIoNbMEq2SSXTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=fneugd2x; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5831320b3a.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1754933755; x=1755538555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJpayKgTaMUiEcWyIlsEkL9c+tCWVH1rXXK0z4fqGHo=;
        b=fneugd2xyflHBy2Lbb3RKWoOTliOzZ7rQnhOKP9Qdlb3sH9XIMcHK9kDhuLcsoDiKj
         rJWe0wTmncBoz0LnZwcQgqylok+DrHrbYlNYufF73dZ2WpZWj2qcAWpjaVIkbIYlZ9pp
         a8ehQIhLpREpmVvgbPiFrPU3DjxkmhT22j0qmoOEZ66QHpnfIHCML8/DatBWA2E2SYZS
         cHYpuZvn8ObP0EXjgVdZrwGk55dvxg8wiwAyIrHCjIP/jt9vx8RgEXYt/3IeJaMgZMkp
         2msrGDktvzwtvPym998Eut+gJ/cOQsHOIguiXYPyNqm32JXWULVHFrvFBtrTTmxTJazN
         zOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933755; x=1755538555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJpayKgTaMUiEcWyIlsEkL9c+tCWVH1rXXK0z4fqGHo=;
        b=lD4LP/tsV6SSb279KYNif3D+SMBMOyJZ8fUoQIS+O8qNKZ8oOHrzm7Ver7wtGd31xc
         FV+VpA2agx6xoLg8CX8YAv4ObFlmwSyNBveX/HVuenvNigie4ASxdu8J4EhISSXMGtFe
         nHegNR2mreBP5JNbmJ7m/964ysxoTBAgcm7E8/nZehZ0bkBanv/cQhZrUCuaZ4qHBIL1
         dMwCPXFrJ2CcIlPX3ifdbvSuabHY7ADa9gnjGbGvmFIH25PDH+TQ5qBJSlQbN9SNCtRT
         elhe/swkfd9kUp0j0NP0JSQnoIVPZpBoAlwnj3hW7qbFxGJy1cppUJmB5giM39zi7BTq
         AJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmjFjjPp8CLl2emmd7e6yqiP+VsVs8NO8eq5GzsSxLvVRc8mB1V7ItDL6NPxaUzNtCJnaljU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQb1TGWMGKRzZGq7ueJWcqHnATOgjGfNqJQ1aEXd0ZeBuj61K
	hp63L8O4J4yfOLbwPUq2S3vP62cz50jFSZ87znWDvNavM2xJPBa09KuPUKwsVtIFzw==
X-Gm-Gg: ASbGncv3oA7uZpCD6slnAehRNzAZ/pisDaxvBmR2x77BU66QU0qAKAmVzpOJD0TeUA1
	9ZAxBjm2aTtx9QSWJxTFZM1qXzN047JXt7HY70veTl+NjKiAM6qVARkrCeeNSXFKBJU1l8kS0yy
	kPVn/6YihtMBJAWd5pka/x7F39RPxXhzP9nx/1fqCIWj6X1qhbAZuW+hIDgoZEvc8XNnfIYIgIr
	R0PCMhk9g3aJr8/uqaNdcHeRBz4x4T0vnGYeTrLJE+KimItP0qI90jbCFZSad6HjZz89US4p+f3
	NSCTI47//aDpSeP8RHIBJhvYcZSsUNJDtRt3lE1LijtFTHEN+p1PqnC998in/oZH1IYxxsU0sFN
	59dqB2x0qgrO7CeH/TZ9QLcy7cPk4st0vYl0UArqoOtQZjnazE8neeWU2MehcQMGCdFjP
X-Google-Smtp-Source: AGHT+IFmHat5bgdThEKBSnSlxzhujMfdZ3w91cLmdcbHXKJrL9nV/fQlAUThTSy91TwSqT6aDkTkKg==
X-Received: by 2002:a05:6a00:991:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-76c4618dd8fmr19172016b3a.18.1754933755077;
        Mon, 11 Aug 2025 10:35:55 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea? ([2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm27390870b3a.42.2025.08.11.10.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 10:35:54 -0700 (PDT)
Message-ID: <2ac9d393-a87b-4b55-87d6-0b76542e63c9@mojatatu.com>
Date: Mon, 11 Aug 2025 14:35:50 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging unused
 classes
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Lion Ackermann <nnamrec@gmail.com>,
 Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
 Ivan Vecera <ivecera@redhat.com>, Li Shuang <shuali@redhat.com>
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
 <8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>
 <aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
 <81bd4809-b268-42a2-af34-03087f7ff329@mojatatu.com>
 <c3ffa213-ba09-47ce-9b9b-5d8a4bac9d71@mojatatu.com>
 <aJoV1RPmh4UdNe3w@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <aJoV1RPmh4UdNe3w@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 13:09, Davide Caratti wrote:
> On Mon, Aug 11, 2025 at 10:52:08AM -0300, Victor Nogueira wrote:
>> On 8/11/25 06:53, Victor Nogueira wrote:
>>> On 8/11/25 04:49, Davide Caratti wrote:
>>>> Maybe it's better to extend sch_ets.sh from net/forwarding instead?
>>>> If so, I can follow-up on net-next with a patch that adds a new
>>>> test-case that includes the 3-lines in [1] - while this patch can go
>>>> as-is in 'net' (and eventually in stable). In alternative, I can
>>>> investigate on TDC adding "sch_plug" to the qdisc tree in a way
>>>> that DWRR never deplete, and the crash would then happen with
>>>> "verifyCmd".
>>>>
>>>> WDYT?
>>>
>>> That works for me as well.
>>
>> Sorry, should've been more specific.
>> I meant that the net/forwarding approach you suggested
>> seems ok. The tdc approach would be a lot of work and
>> I don't believe it's worth it.
> 
> I was more of the idea of avoiding a non-deterministic kselftest, because
> with mausezahn running in the background we have to be "lucky" enough to
> see the tc qdisc change command executed while the packet socket is
> still emitting packets. And the sch_plug approach I mentioned this morning
> looks doable: I just reproduced the NULL dereference on unpatched kernel
> using something like:
> 
>   # ip link add name ddd0 type dummy
>   # tc qdisc add dev ddd0 root handle 1: ets bands 4 strict 2 priomap 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
>   # tc qdisc add dev ddd0 handle 10: parent 1:4 plug
>   # ip link set dev ddd0 up
>   # tc qdisc change dev ddd0 handle 10: plug limit 5
>   # mausezahn ddd0 -A 10.10.10.1 -B 10.10.10.2 -c 0 -a own -c 5 00:c1:a0:c1:a0:00 -t udp
>   # printf "press enter to crash..."
>   # read -r _
>   # tc qdisc change dev ddd0 handle 1: ets bands 2 strict 0
> 
> so, including "plug" children in the tree should make kselftest feasible either with 'net/forwarding'
> or with TDC + scapy plugin superpowers.

I see, so I think it would be better to use the 'net/forwarding' 
approach with
"plug" children mainly because it looks simpler.

> @Victor + @Jakub, can we apply this patch to 'net', so that regression is fixed ASAP, and then I post
> the kselftest in a separate submission for net-next?

 From my side, that's ok.

cheers,
Victor

