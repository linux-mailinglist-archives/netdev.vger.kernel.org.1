Return-Path: <netdev+bounces-85204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1211899C0A
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4A1F238B2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA416C68D;
	Fri,  5 Apr 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6QpzC9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDE2032D
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317550; cv=none; b=gIqN3Hw5sJB7ZKZrFNc7c+ik7WxHNEiL1t0P7QEWJxB3BtXShmo3fW+NqzMMICtw9mL1FWyQrpWVkKE1d7L/HHwdu3LPLj9qHX3EjiJPDLe+fUrIiVXRL3+5LpU06KvjhJAmhYG0KTbtrvCW+DZMuRlAxL9pIcwOiTjv6ADThNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317550; c=relaxed/simple;
	bh=gGHCMUiakKSNc8B8cOXjwSL4GqSlNA49uJy2oj4yEGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLKythXrHd62bfiuvbgAMGZLxFwFvhYudEEI4nTqge0yWLzZRX+NkAkSZcI5YtUWPvkdwGXSVHsdXNHhzdGSJAXLavSnN1JrrwHjM7zIFAKaYjfxiIM0yaUrElDSFioiRnpEqL/LSLttwxFvLvMuLyuz/DWMPFOtlRHwLLsjOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6QpzC9L; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so3087370a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 04:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712317547; x=1712922347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHXEJWkwhcknMX4NaaWAKodU53vBMWqal7mTz5l/30M=;
        b=T6QpzC9LrYQrxNoJrlttGrogLzTJTJdAazobi8VZDhT4Ue5ssUraBIbIwG3sVAn+A+
         aGNA6q4pT8UslD0jsmgzVn0tmUF/Fs8tdQv8MfjXWQ44tskqv0MQwLcFUCcDDyEBMmSd
         PHUFMSeEZpxSLAZtcPYXIR7o+RHApxDrJmJSiANpXAK45BgryXM34JIV0MW6vm6jJkFn
         0pkK6n1uAb9iEay6xpc9rpCmi0kwB8cNsorvN/704OfUyg4OidQMqEiQXOLVgKLNCi4c
         K1uXUrA1WnGakQThbQfbtACH3kCMBUBiIqm1k9007HHEdQTsQ4WfVQGpeUjY9LJoYplw
         ao/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712317547; x=1712922347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHXEJWkwhcknMX4NaaWAKodU53vBMWqal7mTz5l/30M=;
        b=uSb1dWJ0OmAaqyzsd55OcSNOKB1SCfHGatLhmSg4a7PtNMWBi2iSP442pikWa7NI1d
         Znr1A9RyHaf99aIC6UEY5P9xAmXotfJRGcapNwmt+Z0rEHF+yyowD1lN7a5Qol3ptKip
         VAhm1HHVM9a+vozwiVLKCYUZXLGDmQNNXtGvik4k+udAsVXSQUXN7MfquTU9Ta3FdEKi
         6+1DRXssXJzsLp+2CRpUoaQC2LzJUOhNajou4G+6/4/jiI+3XYlUHQ7HyqE2u3eKqEVC
         YDUqEgZWLQ0+4h1Cyu6ten5ZAW6KZreag7Qgq0dAEQqcp59e5S8FmPqrYenRuBtYbK1D
         bQRw==
X-Gm-Message-State: AOJu0YyCVCTyhagVg8MgO8YaT+uD5Y2EtU7VCWlbRYzGenW2JIjzk4SC
	SvwVxqGXj1VuriE+PfwmnWe1iL5SIaYLsh+HX9iM3TazJlGWzogQDW9x0/5m
X-Google-Smtp-Source: AGHT+IEhgQfiq4CRr4G47rBtvkf4jln5UyOqX1O6lVytpkNeS081N7q5RTflDYR36qVQ88sYKLpWfA==
X-Received: by 2002:a17:906:ac7:b0:a51:982e:b3f7 with SMTP id z7-20020a1709060ac700b00a51982eb3f7mr927945ejf.37.1712317546913;
        Fri, 05 Apr 2024 04:45:46 -0700 (PDT)
Received: from [192.168.42.78] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id hg21-20020a1709072cd500b00a4e0df9e793sm747367ejc.136.2024.04.05.04.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 04:45:46 -0700 (PDT)
Message-ID: <455a75bb-f3ea-4cbf-830f-a443a7e0d71a@gmail.com>
Date: Fri, 5 Apr 2024 12:45:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: enable SOCK_NOSPACE for UDP
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <1da265997eb754925e30260eb4c5b15f3bff3b43.1712273351.git.asml.silence@gmail.com>
 <CANn89iKzwxgzX7-TAqjN5np8fksVM=qq1A0rFRdNKWjYJYWLaA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iKzwxgzX7-TAqjN5np8fksVM=qq1A0rFRdNKWjYJYWLaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/24 10:11, Eric Dumazet wrote:
> On Fri, Apr 5, 2024 at 1:37 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> wake_up_poll() and variants can be expensive even if they don't actually
>> wake anything up as it involves disabling irqs, taking a spinlock and
>> walking through the poll list, which is fraught with cache bounces.
>> That might happen when someone waits for POLLOUT or even POLLIN as the
>> waitqueue is shared, even though we should be able to skip these
>> false positive calls when the tx queue is not full.
>>
>> Add support for SOCK_NOSPACE for UDP sockets. The udp_poll() change is
>> straightforward and repeats after tcp_poll() and others. However, for
>> sock_wfree() it's done as an optional feature flagged by
>> SOCK_SUPPORT_NOSPACE, because the feature requires support from the
>> corresponding poll handler but there are many users of sock_wfree()
>> that might be not prepared.
>>
>> Note, it optimises the sock_wfree() path but not sock_def_write_space().
>> That's fine because it leads to more false positive wake ups, which is
>> tolerable and not performance critical.
>>
>> It wins +5% to throughput testing with a CPU bound tx only io_uring
>> based benchmark and showed 0.5-3% in more realistic workloads.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   include/net/sock.h |  1 +
>>   net/core/sock.c    |  5 +++++
>>   net/ipv4/udp.c     | 15 ++++++++++++++-
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 2253eefe2848..027a398471c4 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -944,6 +944,7 @@ enum sock_flags {
>>          SOCK_XDP, /* XDP is attached */
>>          SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>>          SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>> +       SOCK_NOSPACE_SUPPORTED, /* socket supports the SOCK_NOSPACE flag */
>>   };
>>
>>   #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 5ed411231fc7..e4f486e9296a 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3393,6 +3393,11 @@ static void sock_def_write_space_wfree(struct sock *sk)
>>
>>                  /* rely on refcount_sub from sock_wfree() */
>>                  smp_mb__after_atomic();
>> +
>> +               if (sock_flag(sk, SOCK_NOSPACE_SUPPORTED) &&
>> +                   !test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
>> +                       return;
>> +
>>                  if (wq && waitqueue_active(&wq->wait))
>>                          wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
>>                                                  EPOLLWRNORM | EPOLLWRBAND);
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 11460d751e73..309fa96e9020 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -342,6 +342,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
>>                  hslot2->count++;
>>                  spin_unlock(&hslot2->lock);
>>          }
>> +       sock_set_flag(sk, SOCK_NOSPACE_SUPPORTED);
>>          sock_set_flag(sk, SOCK_RCU_FREE);
>>          error = 0;
>>   fail_unlock:
>> @@ -2885,8 +2886,20 @@ __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait)
>>          /* psock ingress_msg queue should not contain any bad checksum frames */
>>          if (sk_is_readable(sk))
>>                  mask |= EPOLLIN | EPOLLRDNORM;
>> -       return mask;
>>
>> +       if (!sock_writeable(sk)) {
> 
> I think there is a race that you could avoid here by using
> 
> if  (!(mask & (EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND))) {

Seems like it, I'll add the change, thanks

> (We called datagram_poll() at the beginning of udp_poll())

-- 
Pavel Begunkov

