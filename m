Return-Path: <netdev+bounces-35438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0F7A9841
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F1B21186
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAD18AF1;
	Thu, 21 Sep 2023 17:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4003182DF
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:10:32 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392257285
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:10:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98377c5d53eso145960766b.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695316203; x=1695921003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLeTejN+krtXCBUoQ8c2GsyBFaUAnJ4kR1g83a7uWA8=;
        b=H2MAiM+WmmfXLf1Ty0AmqrufVX38e5Myg6JSykg+uu9MP/OHBP7++6mfUgtid0r8us
         RCEK5g4rYQrwascHCXD2FQ+Sex8TUCSFbJqQy0zXxNGjJtwPVosLywLu33LbAf/JlRNo
         JFNniIvDfCOQMmk9HmLh23BkHuXo8N2izmmFkDtWCpZpjzb6XneP8Maz0oQKUDmb7jJb
         MlHbBnuvWVfXytHG1OprmP1Jqwwcz9hf0MRvbPV30lYhnRPXQSMlTBuB4SN6JrT3Q4BN
         zmP8c11Pg6RZeWVVJyyfdrefCDADjVVnIY+RLwY8yFFoGCfV99KBBtKCxqFhakFIByxu
         W7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316203; x=1695921003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLeTejN+krtXCBUoQ8c2GsyBFaUAnJ4kR1g83a7uWA8=;
        b=rJRiy8zs2kZIMNVANd9mpmN08mENcNZpaX8pYlSHglgQnJ5hnP/g08/932U3GsMbQV
         QVul5Pg2Y2emNm+ftwrvBnRb8rT2RYbEaBpLWLstisg+xfBYU8MUkV/miFTp/dAIGo9+
         QCI9Yyd/PfMZyV4EJIb1wfBjYwsB8HqlKHMSTqivyUmgxLj+h01AUx3CujKFKat8zMpI
         IrRYZyiznRC73Ih7goVK+zNB9UkNX4b3azAZt9R4wFUtxmuuhmuoYl8qzTgrskqhQhLJ
         SV4EGXGiS420TBf+zMnnsE/WEjXeDWkdWl7/Tb2ZltUmNTYz+5x0ieuPcChYd+vbVKqH
         sa0Q==
X-Gm-Message-State: AOJu0YxLvxfXv7G3prOOtsCXDJ5XUoSLDlMxAp84bOuxYw0JinYkGUl0
	GVcEGCW6WgEYn8+HlgDbgGwuBcsXLdzvJpZ8NlI=
X-Google-Smtp-Source: AGHT+IHqkoyAs8j3cuxFWRtoTCw47NxHsOSGjMKRiLPU0zR/pPum9yeXdhIngEZ+J2VrxNeRK//JMw==
X-Received: by 2002:a05:600c:478a:b0:405:3955:5872 with SMTP id k10-20020a05600c478a00b0040539555872mr945316wmo.18.1695312190050;
        Thu, 21 Sep 2023 09:03:10 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y2-20020a7bcd82000000b00403bbe69629sm2279793wmj.31.2023.09.21.09.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 09:03:09 -0700 (PDT)
Message-ID: <24f4b6aa-3be3-8fd1-7f98-503c1d7fea56@arista.com>
Date: Thu, 21 Sep 2023 17:03:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Ard Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>,
 Dan Carpenter <error27@gmail.com>, David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 "Nassiri, Mohammad" <mnassiri@ciena.com>,
 Salam Noureddine <noureddine@arista.com>,
 Simon Horman <simon.horman@corigine.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230918190027.613430-1-dima@arista.com>
 <20230918190027.613430-7-dima@arista.com>
 <c2c0b0684b9c2a930ae6001bcc0044dd7a0862d5.camel@redhat.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <c2c0b0684b9c2a930ae6001bcc0044dd7a0862d5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 12:23, Paolo Abeni wrote:
> On Mon, 2023-09-18 at 20:00 +0100, Dmitry Safonov wrote:
>> @@ -1361,16 +1385,48 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>>  		th->window	= htons(min(tp->rcv_wnd, 65535U));
>>  	}
>>  
>> -	tcp_options_write(th, tp, &opts);
>> +	tcp_options_write(th, tp, &opts, &key);
>>  
>> +	if (tcp_key_is_md5(&key)) {
>>  #ifdef CONFIG_TCP_MD5SIG
>> -	/* Calculate the MD5 hash, as we have all we need now */
>> -	if (md5) {
>> +		/* Calculate the MD5 hash, as we have all we need now */
>>  		sk_gso_disable(sk);
>>  		tp->af_specific->calc_md5_hash(opts.hash_location,
>> -					       md5, sk, skb);
>> -	}
>> +					       key.md5_key, sk, skb);
>>  #endif
>> +	} else if (tcp_key_is_ao(&key)) {
>> +#ifdef CONFIG_TCP_AO
>> +		struct tcp_ao_info *ao;
>> +		void *tkey_buf = NULL;
>> +		u8 *traffic_key;
>> +		__be32 disn;
>> +
>> +		ao = rcu_dereference_protected(tcp_sk(sk)->ao_info,
>> +					       lockdep_sock_is_held(sk));
>> +		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
>> +			if (tcb->tcp_flags & TCPHDR_ACK)
>> +				disn = ao->risn;
>> +			else
>> +				disn = 0;
>> +
>> +			tkey_buf = kmalloc(tcp_ao_digest_size(key.ao_key),
>> +					   GFP_ATOMIC);
>> +			if (!tkey_buf) {
>> +				kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
>> +				return -ENOMEM;
>> +			}
>> +			traffic_key = tkey_buf;
>> +			tp->af_specific->ao_calc_key_sk(key.ao_key, traffic_key,
>> +							sk, ao->lisn, disn, true);
>> +		} else {
>> +			traffic_key = snd_other_key(key.ao_key);
>> +		}
>> +		tp->af_specific->calc_ao_hash(opts.hash_location, key.ao_key,
>> +					      sk, skb, traffic_key,
>> +					      opts.hash_location - (u8 *)th, 0);
>> +		kfree(tkey_buf);
>> +#endif
> 
> I'm sorry for the incremental feedback.
> 
> The above could possibly deserve being moved to a specific helper, for
> both readability and code locality when TCP_AO is enabled at compile
> time but not used.

Sure, will do for the v13.

Thanks,
           Dmitry


