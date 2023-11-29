Return-Path: <netdev+bounces-52295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D817FE2C6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C8CB20EAB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A04CB5B;
	Wed, 29 Nov 2023 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Vbu2ZQ+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327E3A8
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:12:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso182049f8f.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701295940; x=1701900740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsfiiCh2t+d8frhzsf+fjDEcC/TtScnOnSIQNlDuEFI=;
        b=Vbu2ZQ+CUo4c4tHkKXzCJC6yiiKbQe3fCMgf1Ek0Ah8FR74C3lqzi8/USu+zgVII+w
         8hzbQYnjeKxnJxcBUz6nWafs/hMF3i2TbP2sIXq1xgHZ8X1iudRbWtsP7HtmVlZyoUpI
         Xcd8/HNqSby/Xg75SQGFpplcgry/kH8XPAASV4Z0CvOuUFG8hV5uPTjAtSURKcxJvcKg
         Xscm14PI2oHUf2iA2cN1IeW2iuy0DUTC/PtF1iWzxDzVHvrFOcoK0b8Y0sXJQuDOQ08n
         X1O1Cem9bTQAokPxfcXYje0fGnkX20BO+DjJg39hLYep75agark500uG2ZAjvjELhaNz
         CjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295940; x=1701900740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsfiiCh2t+d8frhzsf+fjDEcC/TtScnOnSIQNlDuEFI=;
        b=tRemMKr6qOYJdQOWayTsUoNv+1KmJMVKyWT3tLOScKsmMNbVkd6S7Ix7A08CqmfdfL
         Aem9XwLVnpXPixP96n7oAvglHu5wCFUXxie5L9Ojpd8mHQ0eCK5VSe0Olo7Rl8GkMAN9
         3fnR17tqUv3Gl3Agt81xyG8zly1zh9CVmPLf3wegevRHRE5cqqqyAje/yDAp4lmAFmxy
         WtsGzZFfv+nKrtzrekQMceWE4aDriWT71fRlpdTe+2K9VNRnZ6i5bjGZEpp+BEjhVmRh
         tFBtir9Ph6ei84fGduDslOAoFB2gc+nvAzLSghpsYgziTkryYDFFfDqLR0JBH6Uo0PwN
         4NqA==
X-Gm-Message-State: AOJu0Yw85WihZT2M4yAYXASa/vh4inxh/kxb+oSASmSaqm9lxZKOEf4T
	1UyZwKYRICm7M87EOO6ZGjnxoQ==
X-Google-Smtp-Source: AGHT+IGQLX3W0cIOgoVCWLck+JywOx3atXXdqIfcrELeP5HlGMpHrXHv5v+/8U8U1rtlPI3vV9qceg==
X-Received: by 2002:a5d:4d42:0:b0:333:1cc8:4182 with SMTP id a2-20020a5d4d42000000b003331cc84182mr1224453wru.64.1701295940589;
        Wed, 29 Nov 2023 14:12:20 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t10-20020adff60a000000b003316db2d48dsm5614477wrp.34.2023.11.29.14.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 14:12:20 -0800 (PST)
Message-ID: <d0ee7676-6665-4e47-8e06-1d4d168c3421@arista.com>
Date: Wed, 29 Nov 2023 22:12:13 +0000
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
 <df55eb1d-b63a-4652-8103-d2bd7b5d7eda@arista.com>
 <CANn89iLZx-SiV0BqHkEt9vS4LZzDxW2omvfOvNX6XWSRPFs7sw@mail.gmail.com>
 <137ab4f7-80af-4e00-a5bb-b1d4f4c75a67@arista.com>
 <CANn89iLfvOp+xpoFzsKojQs2SuCy+qL6PANj8Z04MwYaH31moA@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iLfvOp+xpoFzsKojQs2SuCy+qL6PANj8Z04MwYaH31moA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/29/23 21:01, Eric Dumazet wrote:
> On Wed, Nov 29, 2023 at 8:58 PM Dmitry Safonov <dima@arista.com> wrote:
>> On 11/29/23 18:34, Eric Dumazet wrote:
[..]
>>> You have not commented on where these are read without the socket lock held ?
>>
>> Sorry for missing this, the SNEs are used with this helper
>> tcp_ao_compute_sne(), so these places are (in square brackets AFAICS,
>> there is a chance that I miss something obvious from your message):
>>
>> - tcp_v4_send_reset() => tcp_ao_prepare_reset() [rcu_read_lock()]
>> - __tcp_transmit_skb() => tcp_ao_transmit_skb() [TX softirq]
>> - tcp_v4_rcv() => tcp_inbound_ao_hash() [RX softirq]
> 
> All these should/must have the socket lock held !
> 
> Or reading tcp_sk(sk)->rcv_nxt would be racy anyway (note the lack of
> READ_ONCE() on it)

For fairness, post this patch rcv_next is not read anymore (SNEs are
updated in parallel).


> I think you need more work to make sure this is done correctly.

Sure.

> ie tcp_inbound_hash() should be called from tcp_v4_do_rcv() after the
> bh_lock_sock_nested() and sock_owned_by_user() checks.

But than my concern would be that any incoming segment will cause
contention for the time of signature verification. That potentially may
create DoS.

If this patch is ugly enough to be not acceptable, would
bh_lock_sock_nested() around reading SNEs + rcv_nxt/snd_una sound better?

Let me add some information, that is lacking in patch message, but may
be critical to avoid misunderstanding:

Note that the code doesn't need precise SEQ numbers, but it needs a
consistent SNE+SEQ pair to detect the moment of SEQ number rolling over.
So, that tcp_ao_compute_sne() will be able to use decremented SNE for a
delayed/retransmitted segment and to use incremented SNE for a new
segment post-rollover. So, technically, it just needs a correct SNE.
Which is computed based on what was "cached" SEQ for that "cached" SNE
and what is the SEQ from the skb.

As tcp window size is smaller than 2 GB, the valid segment to be
verified or signed won't be far away from this consistent number, that
is to be used by tcp_ao_compute_sne().

Technically, if the SNE+SEQ "cached" pair is inconsistent (which
unlikely but may happen _prior_ to this patch): i.e. SNE from
pre-rollover and SEQ is post-rollover, tcp_ao_compute_sne() will
incorrectly increment/decrement the SNE that is used for
signing/verification of the TCP segment. In result the segment will fail
verification and will be retransmitted again.
As it's unlikely race that may happen on SEQ rollover (once in 4GB) and
TCP-AO connection won't break, but survives after the retransmission, I
don't think it was noticed on testing.

Thanks,
             Dmitry


