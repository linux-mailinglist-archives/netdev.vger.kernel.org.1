Return-Path: <netdev+bounces-49853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54F67F3B2A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D8AB209E9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59B15C3;
	Wed, 22 Nov 2023 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KumbRlB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E67D40
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:20:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332cc1f176bso1301492f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700615999; x=1701220799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvyPJLsHa1UpzCT3gFYRcmMF12jLhkR+Wt3mbotrxRk=;
        b=KumbRlB90XYBW8j7cdiG7lfmPdHCFrPGxonREYx92n57uObv+dpSrFN1MWPyH6P9bT
         GV0T8MvT/dkPtWPBTJuV8phr6tHR83v7aZ6+49oGVX4ZLizdIgoEGyjXX5LQsHsJSNHR
         WJ3zxWrhw4VR+gCeFRWSDo7l1hEu607aNeAVy3zITzef5OQEflMuBo1Mra4GJoIZpI2R
         zJvvogcwIVeLgtvyqO5uZ7zGsK8IegQPL46qXpwCvqJ++ECxgckBzx8Wru6ejWNDaUdj
         uMSxwZXTD6NG9nNsol/fb8myYhOzEj+OqW+HV704QcL/HBsP5oYpelvtZ70SGhE9f6Gm
         LLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615999; x=1701220799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvyPJLsHa1UpzCT3gFYRcmMF12jLhkR+Wt3mbotrxRk=;
        b=mfppr9VwfN6MjH0/dHIdQtHcu3sn2azS30pG/4liGKH0ovwxr7R28X1OcGMD1bO+wz
         DH5u1obute8MznaHrMs6oB7CVh7530hUzvw58TaI2PfkNcNA61d04lSQpuiVWn/pt+Qu
         kKWuNOx9PDlWT/mfFVlejclVDBNiYLiQnuA94mxRaxXPYyoy/sAxcmerroYzmrH+Itjr
         JfgN/drdnwkWNV7j6kXcP99Fn4G2vrE6IfNg2xiytZ58Sknie98B6AEGOrY9LfpsQQJ5
         jJwO6+32oj0zVgMuyQXQvU7Iv5cTWExQ5aaa4aIVPy1ntEdrTiFqB/kcqMLz92Jrr8OM
         7UwQ==
X-Gm-Message-State: AOJu0YzHFHxnDINOAObE5ZHQgyuOUAd99Ynk9IzJ+zXajWMpgxquhNyj
	+8o3gZZ57LcAcJegIL3FvGqCdg==
X-Google-Smtp-Source: AGHT+IHJ3uIIPfIuSkwAwBuVvZkulHL9TorT06BnqC1fY1KxSN0gT//3TraVnbvp+C8HbHOFbqTPtg==
X-Received: by 2002:a5d:4b8b:0:b0:331:69a2:cad2 with SMTP id b11-20020a5d4b8b000000b0033169a2cad2mr441587wrt.62.1700615999272;
        Tue, 21 Nov 2023 17:19:59 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d8-20020adffbc8000000b003316aeb280esm14956932wrs.104.2023.11.21.17.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 17:19:58 -0800 (PST)
Message-ID: <a838b389-4c0b-484d-98bd-33f8ef4c88f2@arista.com>
Date: Wed, 22 Nov 2023 01:19:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20231121020111.1143180-1-dima@arista.com>
 <20231121020111.1143180-8-dima@arista.com>
 <CANn89iK-=G7p5CMuJDjioa7+ynZRrOOpd7bK3kPzxCXzygfFCQ@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iK-=G7p5CMuJDjioa7+ynZRrOOpd7bK3kPzxCXzygfFCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/23 08:13, Eric Dumazet wrote:
> On Tue, Nov 21, 2023 at 3:01 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> This extra check doesn't work for a handshake when SYN segment has
>> (current_key.maclen != rnext_key.maclen). It could be amended to
>> preserve rnext_key.maclen instead of current_key.maclen, but that
>> requires a lookup on listen socket.
>>
>> Originally, this extra maclen check was introduced just because it was
>> cheap. Drop it and convert tcp_request_sock::maclen into boolean
>> tcp_request_sock::used_tcp_ao.
>>
>> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  include/linux/tcp.h   | 10 ++++------
>>  net/ipv4/tcp_ao.c     |  4 ++--
>>  net/ipv4/tcp_input.c  |  5 +++--
>>  net/ipv4/tcp_output.c |  9 +++------
>>  4 files changed, 12 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>> index 68f3d315d2e1..3af897b00920 100644
>> --- a/include/linux/tcp.h
>> +++ b/include/linux/tcp.h
>> @@ -155,6 +155,9 @@ struct tcp_request_sock {
>>         bool                            req_usec_ts;
>>  #if IS_ENABLED(CONFIG_MPTCP)
>>         bool                            drop_req;
>> +#endif
>> +#ifdef CONFIG_TCP_AO
>> +       bool                            used_tcp_ao;
> 
> Why adding another 8bit field here and creating a hole ?

Sorry about it, it seems that I

(1) checked with CONFIG_MPTCP=n and it seemed like a hole
(2) was planning to unify it with other booleans under bitfileds
(3) found that some bitfileds require protection as set not only
    on initialization, so in the end it either should be flags+set_bit()
    or something well-thought on (that separate bitfileds won't be
    able to change at the same time)
(4) decided to focus on fixing the issue, rather than doing 2 things
    with the same patch

Will fix it up for v2, thanks!

> 
>>  #endif
>>         u32                             txhash;
>>         u32                             rcv_isn;
>> @@ -169,7 +172,6 @@ struct tcp_request_sock {
>>  #ifdef CONFIG_TCP_AO
>>         u8                              ao_keyid;
>>         u8                              ao_rcv_next;
>> -       u8                              maclen;
> 
> Just rename maclen here to  used_tcp_ao ?
> 
>>  #endif
>>  };
>>

Thanks,
             Dmitry


