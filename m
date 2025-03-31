Return-Path: <netdev+bounces-178261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9721A760EF
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 10:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B553A8663
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B81D6DB5;
	Mon, 31 Mar 2025 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiHfU8zC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24881D5147
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408462; cv=none; b=lburgDlYCmhP6RRCp0SHufU2vFiyNNdlYN9qwwgVTflSKdNygd3xltszEjktRP0GyjwLpbYrT6RX2Fq9Horr5iGkcz1y4YcKYetZ2WG7IjsIY40wyES6lrBJcyJINEueBLvNF5i3J0dc60oy5GiH1GMamo5goXlECxs4giD1GY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408462; c=relaxed/simple;
	bh=tK0Nf+/j4sX/azCF0BZOjpnoPy7MtYBQTn/ET7rMTmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W+kHtyX0LhMMD/ai5igAajlwwej34NGelF3Ajen16Td6keXGi9opvbJxnKafo3j9VjKwn6MzVDJJCQWQauqwDsfD7w4YZ66ZdHydWQXnZezSU5P3LShS0Ls7Eb0d/ltiIw6hlEPdm1OqBsSSTEXUnj1I4uCSZK3s0Q40POtcKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiHfU8zC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743408459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeMg7uSOXE8clYR81AEgLtw/7BbQwXhU7PExYJZ2pRw=;
	b=ZiHfU8zC+N+JZkSscdpCLRZhcpzACQEGxibMQ/CTseuWFanY9WzzkGlf4jlQmqdsc0XPkz
	J85wVkLuB6UiwLYTuDH7ieWA303aO427tzEsa7F6/gb8xpLytm/z5ZS4wZWP3aBUdHUJHe
	VOuhGSP7YriYcdi8buhFAfX7bqAWkFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-IrnzHWSCO8W47ckzfU1qLw-1; Mon, 31 Mar 2025 04:07:36 -0400
X-MC-Unique: IrnzHWSCO8W47ckzfU1qLw-1
X-Mimecast-MFC-AGG-ID: IrnzHWSCO8W47ckzfU1qLw_1743408455
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912d5f6689so2481839f8f.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 01:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408455; x=1744013255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeMg7uSOXE8clYR81AEgLtw/7BbQwXhU7PExYJZ2pRw=;
        b=vFig83/9bV3P9uQiOe0vdjKhVlOOExUvi51TIsR/Uv2Slr/kxJmSJNMJhA7j1rCGND
         jM/fR3voUYQLOnvelouvxt4rqDwH6zyOQVnQ81RC/4s1FKm823B9riiQekM8KJ06mCsY
         1xxu6a/8o43UfUMaIWi9pysHEkBLNJTl+lw8Qa14jT/tOhva7ZhFemdJM1GBbVLYv3wG
         MtekUPJmTgR271qg5YdV6S0H6lqT2U4+3EtaEJcZf60X/v5M/8speQVJjIpKLE8a7njB
         Z6pg7YqdxYoBweaxhSNucllTH0mYEITj4g+WsXddpYXPE/UjvUMajeE5iqwqGNWcv1kE
         2ABQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAWFWoh5ojeXriFdlXnqWrN6qNpL/f73GT6rC9bJc7ehEY6EudfQvrom1JQHuLbaT25gZVwKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWfXQolmjvWAcoskU4XZVr8qkVFeVls7oR/43f8ujt7NG+qig
	sP9EJlnaL2wO0vf+9RbxG+2qD9se3+O578zuyQxy5hElrJbBmjb2LFpeWUAYXrTUSvBub3IPYkx
	4v67yrPiC6umB0OSuBUwYN9GWcQ+24iVitsoe40hqydGhBtcoxyz6JA==
X-Gm-Gg: ASbGncvoycJXH/M8wLsxZ384akB2JsfiKnadCi2j48gAgYZVg4JdvXSRv9KnPnIu+8Y
	R+xvGTpwO0XfjmCxf7lmqvVuSNMR1GXFHChpFTGgDmp7/wqcQvnJT/S9sCCQsqSs3rs8OUyx1r1
	hGUvDWVMs+npNE/hhS+LCVm7nfdUWqAAk0v2Vaw+DijbL9lygBhFR+yi951R4+TZco/hDLTJ0jp
	dVdjBiGoLwv/NMtHQhVPqhq8EonPqkl8ToWAgwy0pp4bMgwuatmxeKyoSYkr+EAp3VoYMFdTPkS
	HMpE0ZlU/SkKfHQXX8Yabtf1jofFSxsF+LKL4fplMrWghg==
X-Received: by 2002:a05:6000:381:b0:39c:1ef5:ff8b with SMTP id ffacd0b85a97d-39c1ef5ffa2mr697668f8f.48.1743408454739;
        Mon, 31 Mar 2025 01:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjfkooZdZCSF/EGrMLJ2JOyUMzq7CJPT42yrIBpk7KVfpc9QrFJRgYND6PboReL52CFj3zJg==
X-Received: by 2002:a05:6000:381:b0:39c:1ef5:ff8b with SMTP id ffacd0b85a97d-39c1ef5ffa2mr697638f8f.48.1743408454366;
        Mon, 31 Mar 2025 01:07:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d84632ffcsm154028585e9.31.2025.03.31.01.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 01:07:33 -0700 (PDT)
Message-ID: <647c3886-72fd-4e49-bdd0-4512f0319e8c@redhat.com>
Date: Mon, 31 Mar 2025 10:07:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new splat
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Justin Iurman <justin.iurman@uliege.be>
References: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Justin.

On 3/31/25 1:28 AM, Alexei Starovoitov wrote:
> After bpf fast forward we see this new failure:
> 
> [  138.359852] BUG: using __this_cpu_read() in preemptible [00000000]
> code: test_progs/9368
> [  138.362686] caller is lwtunnel_xmit+0x1c/0x2e0
> [  138.364363] CPU: 9 UID: 0 PID: 9368 Comm: test_progs Tainted: G
>       O        6.14.0-10767-g8be3a12f9f26 #1092 PREEMPT
> [  138.364366] Tainted: [O]=OOT_MODULE
> [  138.364366] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  138.364368] Call Trace:
> [  138.364370]  <TASK>
> [  138.364375]  dump_stack_lvl+0x80/0x90
> [  138.364381]  check_preemption_disabled+0xc6/0xe0
> [  138.364385]  lwtunnel_xmit+0x1c/0x2e0
> [  138.364387]  ip_finish_output2+0x2f9/0x850
> [  138.364391]  ? __ip_finish_output+0xa0/0x320
> [  138.364394]  ip_send_skb+0x3f/0x90
> [  138.364397]  udp_send_skb+0x1a6/0x3d0
> [  138.364402]  udp_sendmsg+0x87b/0x1000
> [  138.364404]  ? ip_frag_init+0x60/0x60
> [  138.364406]  ? reacquire_held_locks+0xcd/0x1f0
> [  138.364414]  ? copy_process+0x2ae0/0x2fa0
> [  138.364418]  ? inet_autobind+0x41/0x60
> [  138.364420]  ? __local_bh_enable_ip+0x79/0xe0
> [  138.364422]  ? inet_autobind+0x41/0x60
> [  138.364424]  ? inet_send_prepare+0xe7/0x1e0
> [  138.364428]  __sock_sendmsg+0x38/0x70
> [  138.364432]  ____sys_sendmsg+0x1c9/0x200
> [  138.364437]  ___sys_sendmsg+0x73/0xa0
> [  138.364444]  ? __fget_files+0xb9/0x180
> [  138.364447]  ? lock_release+0x131/0x280
> [  138.364450]  ? __fget_files+0xc3/0x180
> [  138.364453]  __sys_sendmsg+0x5a/0xa0

Possibly a decoded stack trace could help.

I think a possible suspect is:

commit 986ffb3a57c5650fb8bf6d59a8f0f07046abfeb6
Author: Justin Iurman <justin.iurman@uliege.be>
Date:   Fri Mar 14 13:00:46 2025 +0100

    net: lwtunnel: fix recursion loops

with dev_xmit_recursion() in lwtunnel_xmit() being called in preemptible
scope.

@Justin, could you please have a look?

Thanks,

Paolo


