Return-Path: <netdev+bounces-52236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E87FDF28
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F432B20DEB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C144F5F2;
	Wed, 29 Nov 2023 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eNe2jYbi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D89A
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:14:19 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso67179f8f.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701281658; x=1701886458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wY9WeKtXlEdT6ZB9TX0PBdHOlwsuJkt60GHvQlNmDZk=;
        b=eNe2jYbiHpkwa/ZNkwOKT14qO98/sNJ5OK0f5gcf2tcDDzf6G05TeflGiDnlPn0b/F
         0jxSCryWYJh/61ZODteUoF8r6sudle8sNM1yGrTdsJjOjjXDkql/4VHQIXo3boRe6szq
         LSMOp+vWjXRrseRTWyFWY8Jaes+wBc2bm/EJc4fK10Kb1VYQQe8Y2yP6BLIcvkouJfcj
         VC+dT8srvnfX+I6dAg3oLRuvC2vjnEOBnCt5OTGXG74Qy2aj93cKs31RpOYW0ap1OlHL
         KN7Pmo9ak++sDXbQQwhOI13g+tXtu6+FZZMky8pD3e6W1rJGuI1c6bap6T2v5ce6L/M/
         vS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281658; x=1701886458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY9WeKtXlEdT6ZB9TX0PBdHOlwsuJkt60GHvQlNmDZk=;
        b=YraTnTDgEMAeP8X6Cl0wg0h5wImU49fNVQTnpp5O9+XCW6y05r3dNYtixH5eU452nY
         JFzm9hAWVaZIAX+YDAdZ+FZnyf9eRX4E6ow66RYzVyczxis7rSMnDnGDQYbCYMWgC82h
         SFTzWLG6gYJEhbgXoXOvoEm216i6mPsVdLIS+4fQ1Ce39R9rq7a71LOnDKP/JZ4KZtxa
         jE2x/LMWRWJA5a3oQ9k9rpg2ZZL6kODKv+NfKFiqBzNyYLzQJX7WFSP3DoUsX0IdD8TC
         UyMGmo081Yo7CWiWCl5Oslbbm2S1/mPl4Usmq8P5lIHLec57Mr9r9TcgR0+AX5Bqij8L
         aJHw==
X-Gm-Message-State: AOJu0Yz5XO5HbF6VS+Glxrp9WFSqiw2mBOZhUMMt5/2m996KmLER2nIe
	JiDtV5LISyrNoUSJrEAxXL/g0Q==
X-Google-Smtp-Source: AGHT+IHofg/hK+69psa2zHUNArxjJYgRtbYj/y3G4jlgWw7XUJhrw71mnLqzsxXOXWGxw3ObhmdCgQ==
X-Received: by 2002:a05:6000:88:b0:331:6b82:a3ad with SMTP id m8-20020a056000008800b003316b82a3admr13548656wrx.60.1701281658390;
        Wed, 29 Nov 2023 10:14:18 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d4602000000b0032da4c98ab2sm18812649wrq.35.2023.11.29.10.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 10:14:17 -0800 (PST)
Message-ID: <df55eb1d-b63a-4652-8103-d2bd7b5d7eda@arista.com>
Date: Wed, 29 Nov 2023 18:14:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-7-dima@arista.com>
 <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/29/23 18:09, Eric Dumazet wrote:
> On Wed, Nov 29, 2023 at 5:57 PM Dmitry Safonov <dima@arista.com> wrote:
>>
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
> 
> This will not work on 32bit kernels ?

Yeah, unsure if there's someone who wants to run BGP on 32bit box, so at
this moment it's already limited:

config TCP_AO
	bool "TCP: Authentication Option (RFC5925)"
	select CRYPTO
	select TCP_SIGPOOL
	depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)

Probably, if there will be a person who is interested in this, it can
get a spinlock for !CONFIG_64BIT.

> Unless ao->snd_sne and ao->rcv_sneare only read/written under the
> socket lock (and in this case no READ_ONCE()/WRITE_ONCE() should be
> necessary)

Thanks,
            Dmitry


