Return-Path: <netdev+bounces-200517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8FAE5CFA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250417AF784
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816A24502E;
	Tue, 24 Jun 2025 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJDkyk1G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673724A067
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747186; cv=none; b=Lu8efjJbmfi6bMajsRCwVzQJpMDQVBm7LFpQQWQfojmI73uKVxq4+RH+dWDdp9patzDnsLP3XwyOOZfWvZrZT1NEY0wsNN66D55ZIwrzMfIaj/GTDuGv/r8SghtL7uQ/BydP8C8zYkQXiBD16eTuedmJO8aQkHaBZ/nywQp/MDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747186; c=relaxed/simple;
	bh=H3vD1Sbnp47JGxyvSTEQVnImmd+u2eOSUhKKEDWw0QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YJ5gAMyz+MkGRme0qcDw+cDBcZuNmQRFUGyvkQNDhgWaLmNpkxO1spRIS0LntFCirv4qXV5HBSWvBwTHMmtN1LMrSDNwIKzmsk0+BPkndw7BNrgrZOvZgS9oG4sMA50tx8Dt5Y91dJPca+WQPDkNIfiXzuuWCCPVebK/OTJqpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJDkyk1G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750747183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/0vywc+1kvwMJ/9tqmlAocBgqq2MVsmyNnlstdC9NI=;
	b=GJDkyk1GTjZmOWLfHtFu0qvfuRyZqKPKmogVWawFIyFuJ8p+xFGmYsFbjhpMQ9NWro5Zvu
	uQQ2dGN47w7fedZr7T1Yeke8aSO9HbGA1adJ8bpJt3L7TsZxQ4I4yS02Hb/muR80X77OpM
	7oVddJCdoX50DVXXv3knEPDJfO+SjuY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-iFdV1v9uMuq0WsHuH6CcGw-1; Tue, 24 Jun 2025 02:39:42 -0400
X-MC-Unique: iFdV1v9uMuq0WsHuH6CcGw-1
X-Mimecast-MFC-AGG-ID: iFdV1v9uMuq0WsHuH6CcGw_1750747181
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4535f803ec5so34267825e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750747181; x=1751351981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/0vywc+1kvwMJ/9tqmlAocBgqq2MVsmyNnlstdC9NI=;
        b=rPD8wpn4aRSVZxTrdodNaDTOYoPkDaAx2s7iE4WDN69LZdvmbXK879zLzUHKuFfQWr
         i8xAR9zO5InCPc0buPvvT+FV97a/UH5zSrSH6VwXqTtbZl+ptFqM2tEtxKjyas2QG6Dx
         tn4npjjIBj5c2cnvqnF+PoxJa87Kudj7vllI4Ij3omnFI3Krqf6haWWFZXB8ZiQX6ITz
         mlQfbj3KiCp7+uVH+0gsV6CZgotqFdsb5Ohr+XEtLzjNRFaIo9gvP0uj6wUZSlZltD90
         t5g7S//fsaXvQVSjbdxpPkrBHTV1vknK+JeIOtilts6ElrwVJTyFQ2DFqVqYmPiAfGE5
         wq1A==
X-Forwarded-Encrypted: i=1; AJvYcCVSoZeNrjIOElR8rKQ4hI8lY9l915MxU7NxKWTRSrAY2P5Qk08dzkyJtxQxRqvHyJbjwFXyMuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxil6WV7un58zb4vIo8Ea36BKBknummiCwkQXk5AsOu3dYUCy9B
	eCX/Ff1t6Te+P2UIk68lFqXtDMwF6pF701jK3WopzewAqVvhL9AoHjJoyFO5FQlaiTSSMESdewW
	A2MNkn5eclFY/np1qr14ZhVcReX8WGe21JAQZxjMpd647jQ1wenpAv/KYvA==
X-Gm-Gg: ASbGncuiWsUHCTORNlPwrVC+0i7secvqgrsriPEA6wQ96cIYV3BrfwB/9dY7FxxSsgg
	GMEQWdLvHP0E3v2/vPZWr0Ru7ZoIqS9cVBf4df0/FgZPyT2jlDyUWcBLE4oAjVU4aVXtNDh1IBh
	+Q/PqU7s5JCxCkOvVte1oVhQjIpoTXj5l35CppSeDi4PrF5Ea76oRcB5vTg3c5X19lFlf6NFWiJ
	y0gGw6Cm4ScaKiBRko+2ICuGQ7eUHLqI92MzqDvFfht5gSppR/s7Bm55BygY6xVfuYIuX3OF56E
	mDHUfirDuYqGjQsJAlP9Q7Aj6VX1iw==
X-Received: by 2002:a05:600c:474b:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-453659b87a8mr127411765e9.1.1750747180787;
        Mon, 23 Jun 2025 23:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVNxkrcd1Ty7G+K9PjLk2XfFqnUfZzzJS5GBTHEgoGX0ZqSTbQ4aCxdDlvkl26+NOQkuwHAw==
X-Received: by 2002:a05:600c:474b:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-453659b87a8mr127411485e9.1.1750747180263;
        Mon, 23 Jun 2025 23:39:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80516desm1114668f8f.11.2025.06.23.23.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 23:39:39 -0700 (PDT)
Message-ID: <ed5283a7-674b-4c5a-aade-c4f220485ce8@redhat.com>
Date: Tue, 24 Jun 2025 08:39:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 09/15] tcp: accecn: AccECN option
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
 <20250610125314.18557-10-chia-yu.chang@nokia-bell-labs.com>
 <d652445f-3637-44bf-ac92-483e9a323a49@redhat.com>
 <PAXPR07MB7984375C1887F1507F4E4726A37CA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984375C1887F1507F4E4726A37CA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm sorry for the late reply.

On 6/21/25 1:22 AM, Chia-Yu Chang (Nokia) wrote:
> From: Paolo Abeni <pabeni@redhat.com Sent: Tuesday, June 17, 2025 11:27 AM
>> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
>> On 6/10/25 2:53 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> @@ -294,6 +295,9 @@ struct tcp_sock {
>>>               rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
>>>       u8      received_ce_pending:4, /* Not yet transmit cnt of received_ce */
>>>               unused2:4;
>>> +     u8      accecn_minlen:2,/* Minimum length of AccECN option sent */
>>> +             est_ecnfield:2,/* ECN field for AccECN delivered 
>>> + estimates */
>>
>> It's unclear to me why you didn't use the 4 bits avail in 'unused2', instead of adding more fragmented bitfields.
>>
> Hi Paolo,
> 	
> 	This is becuase some bits of unused2 will be used in latter patches.

I see. Still it would be more clear to use the avail unused space first.
The final effect/layout would be the same. Or add an explicit note in
the commit message.

>>> @@ -4236,6 +4375,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>>>       if (tcp_ecn_mode_accecn(tp))
>>>               ecn_count = tcp_accecn_process(sk, skb,
>>>                                              tp->delivered - 
>>> delivered,
>>> +                                            
>>> + sack_state.delivered_bytes,
>>>                                              &flag);
>>>
>>>       tcp_in_ack_event(sk, flag);
>>> @@ -4275,6 +4415,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>>>       if (tcp_ecn_mode_accecn(tp))
>>>               ecn_count = tcp_accecn_process(sk, skb,
>>>                                              tp->delivered - 
>>> delivered,
>>> +                                            
>>> + sack_state.delivered_bytes,
>>>                                              &flag);
>>
>> The two above chunks suggest you could move more code into
>> tcp_accecn_process()
> 
> I do not get your point here.
> 
> These two chunks reflect a new argument is added to tcp_accecn_process().
> 
> But the value of this argument is computed by other fnuctions already, so not sure how to move code into tcp_accecn_process().

My point is that the 2 above chunks are identical, so you could possibly
move more (idenical) code into the helper and reduce the code duplication.

>>> static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>>>                       tp->duplicate_sack : tp->selective_acks;
>>>               int this_sack;
>>>
>>> -             *ptr++ = htonl((TCPOPT_NOP  << 24) |
>>> -                            (TCPOPT_NOP  << 16) |
>>> +             *ptr++ = htonl((leftover_bytes << 16) |
>>>                              (TCPOPT_SACK <<  8) |
>>>                              (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
>>>                                                    
>>> TCPOLEN_SACK_PERBLOCK)));
>>
>> Here leftover_size/bytes are consumed and not updated, which should be safe as they will not be used later in this function, but looks inconsistent.
>>
>> The whole options handling looks very fragile to me. I really would prefer something simpler (i.e. just use the avail space if any) if that would work.
> 
> I would still use leftover_size/bytes, but make it more consistent.
> 
> As this part of code already pass AccECN packetdrill tests.
> 
>>
>>> @@ -957,6 +1068,17 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
>>>               }
>>>       }
>>>
>>> +     /* Simultaneous open SYN/ACK needs AccECN option but not SYN */
>>> +     if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
>>> +                  tcp_ecn_mode_accecn(tp) &&
>>> +                  sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
>>> +                  remaining >= TCPOLEN_ACCECN_BASE)) {
>>> +             u32 saving = tcp_synack_options_combine_saving(opts);
>>> +
>>> +             opts->ecn_bytes = synack_ecn_bytes;
>>> +             remaining -= tcp_options_fit_accecn(opts, 0, remaining, saving);
>>> +     }
>>> +
>>>       bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
>>>
>>>       return MAX_TCP_OPTION_SPACE - remaining;
>>
>> [...]
>>> @@ -1036,6 +1159,14 @@ static unsigned int tcp_synack_options(const 
>>> struct sock *sk,
>>>
>>>       smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
>>>
>>> +     if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
>>> +         remaining >= TCPOLEN_ACCECN_BASE) {
>>> +             u32 saving = tcp_synack_options_combine_saving(opts);
>>> +
>>> +             opts->ecn_bytes = synack_ecn_bytes;
>>> +             remaining -= tcp_options_fit_accecn(opts, 0, remaining, saving);
>>> +     }
>>> +
>>>       bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
>>>                             synack_type, opts, &remaining);
>>>
>>
>> The similarities of the above 2 chuncks hints you could move more code into tcp_options_fit_accecn().
>>
>> /P
> 
> I also do not get it, because tcp_options_fit_accecn() will be called with different argument values.
> 
> So, I would prefer to keep as it is.

AFAICS the 3 lines inside the if branch are identical. You could create
an helper for that.

Side note: I'm spending quite a bit of time trimming the irrelevant part
of the reply to make it as straightforward as possible. Please do the
same: having to navigate hundred of lines of unrelated quoted text to
find a single line of contents maximize the chances of missing it.

Thanks,

Paolo

/P


