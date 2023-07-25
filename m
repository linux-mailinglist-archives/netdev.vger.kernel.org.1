Return-Path: <netdev+bounces-21060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD2B76243D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A222817B8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64526B88;
	Tue, 25 Jul 2023 21:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D11F188
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:20:08 +0000 (UTC)
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1B19BF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:20:05 -0700 (PDT)
Message-ID: <2d5a9ca4-5e76-86a9-7db9-b4bbec764706@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690320003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6jM50hKkcdJby+t+KWx1dmfn2ZdkVdrhh2vQPsY52w=;
	b=u0wbIU6Am1sxDyT8m9Uf+jjvt+20tpFOq48YEG07LOykSz7woDn4fGx6DTEFRyrO3tw4bO
	P2nX2Vw4pCHi7JW+sujaXbXs/NC03C/JOJPoCEEm9nD2JrNwQqPHgjIH1kvxw+GPPAewZ1
	MGTgwB4nNzUcf+I19rUnNSntH7FQe0g=
Date: Tue, 25 Jul 2023 14:19:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 4/8] net: remove duplicate reuseport_lookup
 functions
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
 <20230720-so-reuseport-v6-4-7021b683cdae@isovalent.com>
 <6e4f2a64-ed6d-297d-9d6e-6056c1903363@linux.dev>
In-Reply-To: <6e4f2a64-ed6d-297d-9d6e-6056c1903363@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/24/23 5:53 PM, Martin KaFai Lau wrote:
> On 7/20/23 8:30 AM, Lorenz Bauer wrote:
>> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
>> index 032ddab48f8f..f89320b6fee3 100644
>> --- a/include/net/inet6_hashtables.h
>> +++ b/include/net/inet6_hashtables.h
>> @@ -48,12 +48,21 @@ struct sock *__inet6_lookup_established(struct net *net,
>>                       const u16 hnum, const int dif,
>>                       const int sdif);
>> +typedef u32 (inet6_ehashfn_t)(const struct net *net,
>> +                   const struct in6_addr *laddr, const u16 lport,
>> +                   const struct in6_addr *faddr, const __be16 fport);
>> +
>> +inet6_ehashfn_t inet6_ehashfn;
>> +
>> +INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
>> +
> 
> [ ... ]
> 
>> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
>> index b7c56867314e..3616225c89ef 100644
>> --- a/net/ipv6/inet6_hashtables.c
>> +++ b/net/ipv6/inet6_hashtables.c
>> @@ -39,6 +39,7 @@ u32 inet6_ehashfn(const struct net *net,
>>       return __inet6_ehashfn(lhash, lport, fhash, fport,
>>                      inet6_ehash_secret + net_hash_mix(net));
>>   }
>> +EXPORT_SYMBOL_GPL(inet6_ehashfn);
>>   /*
>>    * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
>> @@ -111,18 +112,22 @@ static inline int compute_score(struct sock *sk, struct 
>> net *net,
>>       return score;
>>   }
>> +INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
> 
> The same INDIRECT_CALLABLE_DECLARE is also added to inet6_hashtables.h. Is this 
> one still needed here?
> 
> The same goes for the inet_hashtables.c.

Please follow up if one of the INDIRECT_CALLABLE_DECLARE makes sense to remove.

I have applied the set after fixing up patch 7 and 8.


