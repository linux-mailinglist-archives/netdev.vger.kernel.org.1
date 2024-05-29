Return-Path: <netdev+bounces-99151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACD8D3D73
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27A72856D5
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66C15B57E;
	Wed, 29 May 2024 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hc8zsXM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8915B99E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004058; cv=none; b=Ckp3iemJtWThEQtXKi/b0s+xfojiJpNgRpUwOXMWvUKXQZHBeyBfI3Ji38Ch7JFsSYFF6Q1s7elJMWj4moGoxpJCDuupqUg+6tbbLBZDrTVBjPLwy2zadwBxQfECp+gyUXaRc23G0kp92jDLXo0qoOI9h2KGgq+GWOAVDEhm8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004058; c=relaxed/simple;
	bh=f6+DrieOQjjV4/z2nKYkmi0hbOk0KhV/7DRxGHfFF34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwCyxz/9cjUbSr6j/CLEPp9kncFR6jMc+tT5d573VzYd3brqu1N5VGwHbO+dAGc+3ke32kYaVMVTWxKicTKkbY1om5pZqoqpztto8Ss9sk23tc1gGR99Cz4XLgQ0VVVdZFRgr6xdcRE3we9LL8K1AtAp+/cyYjBe2s5sMEjZe7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hc8zsXM0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae0bf069f3so165146d6.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717004055; x=1717608855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1R7euPmAU+paAC3yZ2ktdQagAAoR5FIYRR+4rPfkYE=;
        b=Hc8zsXM0axGk4dZOpcNA3fbQLYfnBxPt5Dnhkop2NfyTclihIJdatrk9gL2rZZd0HW
         okNAwgTdPLoDyiA/p2VJApMRSjBOCQXiZFjre8OH1NEbOkQqXGvfpbeUnixKHWSW7CpI
         4lARnMIWyVYdOWvtYspmMcQTecPNO5gnYRea2RIfpkq9Lif/RzCHh0g5JgAWwayjlxe3
         i84ksiYd0sfRZ+IZJf450Ts57epVALb7wZMC26vVMgwPZFqTeumQ5hxCTNYjHZw8R7tL
         2qxIFHe4qynMYVkL8SnYXyGnK9Lw9hD4//X5t9zDB4pIC9W82GMtBC1kF3/ezPfjnBib
         heEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717004055; x=1717608855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1R7euPmAU+paAC3yZ2ktdQagAAoR5FIYRR+4rPfkYE=;
        b=nTR/IDXHlHElOxIwurweTa+1x6ICkGpvkWKwzagADjQCO5HGJN1+zbzFg/DCXOY9ps
         eNw2XfbmfrHXZyclxbLhkeMops1OOUMSQaLro4Mq5FnK+zx0Is6Hv4cKex852CCmHd2E
         rXNCjzuWEuaJCvg4tZKW5IpzTrCxHXv0oNdeqczK9a/cHBwhUW8TUMdNCh6AYbpddoLK
         izvApBv8OS0h8QxKq5dXmv/CvSmhtohx08pdBdJ16P73UyWvqPyKJP40jJfS+b1oa38R
         pglxChIUtuFyyY/VUQDDaMsZNQdDbPubT9B+xITEkzhFWBP4jF2EJX89zaXT8ly/hMXv
         vGzw==
X-Forwarded-Encrypted: i=1; AJvYcCWqaWr2jCBOVfCdwYy5hB/WLNB7l+0Urs1nK3PUZSTs+nmLtPiLUdVXgUOD8VcthW0A0W2rel1uhCyBOF0Zx91ypKkA6vTI
X-Gm-Message-State: AOJu0Yyy4DkMw8kJqobwCMLTJP8v5B0sggQ+xsZmUCdx6IxdSBybGWFo
	L9H6kL/62ryiu5A1Jtvqq7a0lJ3Qv7I0EXTcdfq8XyELgp6HjtyzKOYIGbokPs5X8BD3mAJrtYy
	D
X-Google-Smtp-Source: AGHT+IHCuIcBoMWCSHLZfqWJ6YZUV6R0fXud8UoxZ/XUCmJ94L1AxZPv7Le5+pYHhC99b+hzE8KZ3A==
X-Received: by 2002:a05:6214:390b:b0:6ad:657a:5892 with SMTP id 6a1803df08f44-6ad657a59camr150025186d6.61.1717004054453;
        Wed, 29 May 2024 10:34:14 -0700 (PDT)
Received: from [10.200.143.111] (ec2-52-9-159-93.us-west-1.compute.amazonaws.com. [52.9.159.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad77430c57sm38533026d6.38.2024.05.29.10.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 10:34:14 -0700 (PDT)
Message-ID: <2c9bffba-d4f9-47a6-9e3c-36aefeb44042@bytedance.com>
Date: Wed, 29 May 2024 10:34:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next v4 0/3] net: A lightweight
 zero-copy notification
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
 <665734cce5a6d_31b26729414@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <665734cce5a6d_31b26729414@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 6:59 AM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> Original title is "net: socket sendmsg MSG_ZEROCOPY_UARG".
>>
>> Original notification mechanism needs poll + recvmmsg which is not
>> easy for applcations to accommodate. And, it also incurs unignorable
>> overhead including extra system calls and usage of socket optmem.
>>
>> While making maximum reuse of the existing MSG_ZEROCOPY related code,
>> this patch set introduces a new zerocopy socket notification mechanism.
>> Users of sendmsg pass a control message as a placeholder for the incoming
>> notifications. Upon returning, kernel embeds notifications directly into
>> user arguments passed in. By doing so, we can significantly reduce the
>> complexity and overhead for managing notifications. In an ideal pattern,
>> the user will keep calling sendmsg with SCM_ZC_NOTIFICATION msg_control,
>> and the notification will be delivered as soon as possible.
>>
>> Users need to pass in a user space address pointing to an array of struct
>> zc_info_elem, and the cmsg_len should be the memory size of the array
>> instead of the size of the pointer itself.
>>
>> As Willem commented,
>>
>>> The main design issue with this series is this indirection, rather
>>> than passing the array of notifications as cmsg.
>>
>>> This trick circumvents having to deal with compat issues and having to
>>> figure out copy_to_user in ____sys_sendmsg (as msg_control is an
>>> in-kernel copy).
>>
>>> This is quite hacky, from an API design PoV.
>>
>>> As is passing a pointer, but expecting msg_controllen to hold the
>>> length not of the pointer, but of the pointed to user buffer.
>>
>>> I had also hoped for more significant savings. Especially with the
>>> higher syscall overhead due to meltdown and spectre mitigations vs
>>> when MSG_ZEROCOPY was introduced and I last tried this optimization.
> 
> Thanks for quoting this.
> 
> This revision does not address either of these concerns, right?
> 

Right, this revision just fixed some code according to your comments.

>>
>> Changelog:
>>    v1 -> v2:
>>      - Reuse errormsg queue in the new notification mechanism,
>>        users can actually use these two mechanisms in hybrid way
>>        if they want to do so.
>>      - Update case SCM_ZC_NOTIFICATION in __sock_cmsg_send
>>        1. Regardless of 32-bit, 64-bit program, we will always handle
>>        u64 type user address.
>>        2. The size of data to copy_to_user is precisely calculated
>>        in case of kernel stack leak.
>>      - fix (kbuild-bot)
>>        1. Add SCM_ZC_NOTIFICATION to arch-specific header files.
>>        2. header file types.h in include/uapi/linux/socket.h
>>
>>    v2 -> v3:
>>      - 1. Users can now pass in the address of the zc_info_elem directly
>>        with appropriate cmsg_len instead of the ugly user interface. Plus,
>>        the handler is now compatible with MSG_CMSG_COMPAT and 32-bit
>>        pointer.
>>      - 2. Suggested by Willem, another strategy of getting zc info is
>>        briefly taking the lock of sk_error_queue and move to a private
>>        list, like net_rx_action. I thought sk_error_queue is protected by
>>        sock_lock, so that it's impossible for the handling of zc info and
>>        users recvmsg from the sk_error_queue at the same time.
>>        However, sk_error_queue is protected by its own lock. I am afraid
>>        that during the time it is handling the private list, users may
>>        fail to get other error messages in the queue via recvmsg. Thus,
>>        I don't implement the splice logic in this version. Any comments?
>>
>>    v3 -> v4:
>>      - 1. Change SOCK_ZC_INFO_MAX to 64 to avoid large stack frame size.
>>      - 2. Fix minor typos.
>>      - 3. Change cfg_zerocopy from int to enum in msg_zerocopy.c
>>
>> * Performance
>>
>> I extend the selftests/msg_zerocopy.c to accommodate the new mechanism,
>> test result is as follows,
>>
>> cfg_notification_limit = 1, in this case the original method approximately
>> aligns with the semantics of new one. In this case, the new flag has
>> around 13% cpu savings in TCP and 18% cpu savings in UDP.
>>
>> +---------------------+---------+---------+---------+---------+
>> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
>> +---------------------+---------+---------+---------+---------+
>> | ZCopy (MB)          | 5147    | 4885    | 7489    | 7854    |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy (MB)      | 5859    | 5505    | 9053    | 9236    |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy / ZCopy   | 113.83% | 112.69% | 120.88% | 117.59% |
>> +---------------------+---------+---------+---------+---------+
>>
>>
>> cfg_notification_limit = 32, the new mechanism performs 8% better in TCP.
>> For UDP, no obvious performance gain is observed and sometimes may lead
>> to degradation. Thus, if users don't need to retrieve the notification
>> ASAP in UDP, the original mechanism is preferred.
>>
>> +---------------------+---------+---------+---------+---------+
>> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
>> +---------------------+---------+---------+---------+---------+
>> | ZCopy (MB)          | 6272    | 6138    | 12138   | 10055   |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy (MB)      | 6774    | 6620    | 11504   | 10355   |
>> +---------------------+---------+---------+---------+---------+
>> | New ZCopy / ZCopy   | 108.00% | 107.85% | 94.78%  | 102.98% |
>> +---------------------+---------+---------+---------+---------+
>>
>> Zijian Zhang (3):
>>    selftests: fix OOM problem in msg_zerocopy selftest
>>    sock: add MSG_ZEROCOPY notification mechanism based on msg_control
>>    selftests: add MSG_ZEROCOPY msg_control notification test
>>
>>   arch/alpha/include/uapi/asm/socket.h        |   2 +
>>   arch/mips/include/uapi/asm/socket.h         |   2 +
>>   arch/parisc/include/uapi/asm/socket.h       |   2 +
>>   arch/sparc/include/uapi/asm/socket.h        |   2 +
>>   include/uapi/asm-generic/socket.h           |   2 +
>>   include/uapi/linux/socket.h                 |  10 ++
>>   net/core/sock.c                             |  68 ++++++++++++
>>   tools/testing/selftests/net/msg_zerocopy.c  | 114 ++++++++++++++++++--
>>   tools/testing/selftests/net/msg_zerocopy.sh |   1 +
>>   9 files changed, 196 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.20.1
>>
> 
> 

