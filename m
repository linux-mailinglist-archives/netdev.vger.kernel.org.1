Return-Path: <netdev+bounces-53565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C4803B24
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D390C1F20FED
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205652E635;
	Mon,  4 Dec 2023 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="W1Hp4fyV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984B9C1
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 09:08:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so49443295e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701709702; x=1702314502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eM2Bf2WoC1yvqXGfr4khi6TDVXFpyxPzOUHleHrubpg=;
        b=W1Hp4fyVhOpqZS8p3cF5mIFuDz6mEbLDXeLzHaub3VV6UMDKtTVKyro0BgOH0+NuRe
         uadbFzvxY5hDvwX13GifbmGiqGSSk9D/vQ6DWpzoNdY3MqUXdkwjYoAQUt8Mh/V1G5TX
         3x2aj10HT1RUfMoPYnBrtgh6gfbPG4rV0M+29molgPq5GwezjOm710S8WWvLgfj/eC/8
         gxLUenkjAlSn3q1I3thxZ7YoFuS7XVgBXkszOAG4j3dGizbd+fXTHR5cMpaMFDIlWf5X
         t8FzN0DgtERGHyjrmvmkU1aZSmptLB5pYRT8UZxAFky8hR7Ythf8U/5/BrrQQ7dpIccK
         BiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701709702; x=1702314502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eM2Bf2WoC1yvqXGfr4khi6TDVXFpyxPzOUHleHrubpg=;
        b=QGIX1KGukq1SnytfLobVY+VXA1xcbLTglASybUVDtn5gxwN5iGPbBLNcfhsa4/Fk14
         +a9XgPA6121f/apz7MiSV+MbWpxP8RqJB+0ITdZgEum32MNUsmOvroU5XUxRXv+h5lvI
         Ny2mYihsHhqpk2iKdQzj3+pMxMDtz8nGkDt19mxxrXxlaOQCCoOFa0l65xPqUC/kow9q
         nHHePsQf3+QTPiS6K/nWjbSvZIu7O42Qz+9ik/Ga5263NWRCPYBQ78qo+SwCA2VfjErc
         SCuS5fLMCidqKHjaUojsVzB2Neluga8Iq0oNi9k6Xf0K/QR5ZI9Zxt9e5mA6qyDi0Xg4
         5wlg==
X-Gm-Message-State: AOJu0Yyvb0qBf4yuTnbfQ/efI8+dgDs5x/0uEsCXdrwm1pjO5wUWlTcK
	d5IpottMjaxJhNmNGO1dwpwoYQ==
X-Google-Smtp-Source: AGHT+IHsbfqa9QPkIow4yLzsiSHbNp9DKxut6KL9bOx2g6HB59PsiIezFgw/f5llkoaX6xiR1Zr9/A==
X-Received: by 2002:a05:600c:5247:b0:40b:5e59:99a8 with SMTP id fc7-20020a05600c524700b0040b5e5999a8mr1862808wmb.200.1701709701454;
        Mon, 04 Dec 2023 09:08:21 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0040c0902dc22sm6127004wmo.31.2023.12.04.09.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:08:20 -0800 (PST)
Message-ID: <45d63402-bd0f-4593-8e57-042c0753f3e3@arista.com>
Date: Mon, 4 Dec 2023 17:08:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-7-dima@arista.com> <20231202171612.GC50400@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231202171612.GC50400@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 12/2/23 17:16, Simon Horman wrote:
> On Wed, Nov 29, 2023 at 04:57:20PM +0000, Dmitry Safonov wrote:
>> RFC 5925 (6.2):
>>> TCP-AO emulates a 64-bit sequence number space by inferring when to
>>> increment the high-order 32-bit portion (the SNE) based on
>>> transitions in the low-order portion (the TCP sequence number).
>>
>> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
>> Unfortunately, reading two 4-bytes pointers can't be performed
>> atomically (without synchronization).
>>
>> In order to avoid locks on TCP fastpath, let's just double-account for
>> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
>>
>> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> ...
> 
>> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
>> index 647781080613..b8ef25d4b632 100644
>> --- a/include/net/tcp_ao.h
>> +++ b/include/net/tcp_ao.h
>> @@ -121,8 +121,8 @@ struct tcp_ao_info {
>>  	 * - for time-wait sockets the basis is tw_rcv_nxt/tw_snd_nxt.
>>  	 *   tw_snd_nxt is not expected to change, while tw_rcv_nxt may.
>>  	 */
>> -	u32			snd_sne;
>> -	u32			rcv_sne;
>> +	u64			snd_sne;
>> +	u64			rcv_sne;
>>  	refcount_t		refcnt;		/* Protects twsk destruction */
>>  	struct rcu_head		rcu;
>>  };
> 
> Hi Dmitry,
> 
> In tcp_ao.c:tcp_ao_connect_init() there is a local
> variable:
> 
>         struct tcp_ao_info *ao_info;
> 
> And the following assignment occurs:
> 
>                 ao_info->snd_sne = htonl(tp->write_seq);
> 
> Is this still correct in light of the change of the type of snd_sne?

Thanks for the report.
Yes, it's correct as lower 4-bytes are initialized as initial SEQ.
I'll add a cast for it if I'll go with v5 for this patch.

> 
> Flagged by Sparse.
> 

Thanks,
             Dmitry


