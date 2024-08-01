Return-Path: <netdev+bounces-114882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E859448AD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377A4284399
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62716C86D;
	Thu,  1 Aug 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Au0CzadT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315BEEB3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505442; cv=none; b=qTZy8EsloqHbSBJlXeiDgou++ogNjPXsyi2Kq+JQOEaFUK1sE8xJiqEJt+v+SKEkHlAmmo9A7mBt0I+/rtd/L2au4XU59hNQ190tK4upEjU4vqS3OJw2Luf2XJpU/anDSozh6X6+teS9YiSgAjnNrD6zbiu3fGKRI4clANYmdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505442; c=relaxed/simple;
	bh=djKqE/M1RN5qXVJoQWjFSHpRkHEDOw4S5R40c/AVwXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5mgnGxUfSvoYGYRyXHb/WUd8ELmYXkmWGIJtVhMB0rNM0kNp80TXWMQwEL1j2VZpwF/E39ua0QCPS7joeE+TvEefHY/wYjBJ/qQSngR5+WcQeijfJPirEUCROebe5N/hpT8i4yd4pvFYU9W5SHiit+vmdnR+bk/vU1kaJv7Iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Au0CzadT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722505439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWzUqxxwhDDn/6U1dxDjzzLz4eim9nBwkrCU8Cns+lE=;
	b=Au0CzadT8sNA/Tc0VvtSPWOS6bssQ8f/GDWSSKK9pmzaRq3JauLf2LHb6z0Og1OBJ7gqnt
	+3pfoNdaH6LAhq97MmGzFG7fvBYZEvT3fhzEJvN0IDHInBTSpY4ZuKCGVmDtTpCtNYg+PC
	Sl93S4T/iRA+za7XMaPlrx2uzbmNwAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-9UnT-EX2N1SWhNNV5_23ag-1; Thu, 01 Aug 2024 05:43:58 -0400
X-MC-Unique: 9UnT-EX2N1SWhNNV5_23ag-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280f31c668so10376785e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 02:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505437; x=1723110237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWzUqxxwhDDn/6U1dxDjzzLz4eim9nBwkrCU8Cns+lE=;
        b=euN491WVrZMSgmJ6Gg75v2FYPmW5R0SWLS8Bzb+JLjrqKAJG0osSe+bppE5yVskKnB
         os5EUgGtARSlDTNCnleO+jaxFiLlr7j/6pCczZWuyZz5fSTnihkJUhjuqi6hm5ZikwR4
         YEJIpoBAXPlEBwVxjwTdW6MvXw1eJdwsQ/v9QTpxRk8TbHa3RTyb85nbHs2+HKpQqkqp
         Hk5/2WJK3mNmfnS5LLjwk7X6w+ct12OqhZfqkoYwsR7wULRUh69ZLOsOH/ppB6cgaX42
         KwiRZtO5Rb3NDL+R0K/F8wA3aN99xSupohtYscpmDofX3NYA3z9B5Pbwakkru2V48hgb
         KjxA==
X-Gm-Message-State: AOJu0YySLadNIZRupgKWD/OUcHF6MzuZmDF/xQMbaSX7S/q3t5y8gVmB
	pahnrmgT57IYeofErfFon293xwPRs1lHp3kX2CTys+po5SiYeB9RwYWXYMB5VokOuFTCd7UOu1Y
	t4e2N5X7xHczjmt/RAwsNmx4OUQWwVNprWci5PpHfkghBWqQIfGqDAg==
X-Received: by 2002:a05:600c:1d05:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-428a57972d2mr10385855e9.0.1722505436925;
        Thu, 01 Aug 2024 02:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8o2+7kEVQLrW/vz4+KkS9u95ydLQgoUGlNHfqQtE18gfaXGlXT9RPL8WpdbWisbX2R7S5Ww==
X-Received: by 2002:a05:600c:1d05:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-428a57972d2mr10385765e9.0.1722505436354;
        Thu, 01 Aug 2024 02:43:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e08012d7sm20072255e9.22.2024.08.01.02.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:43:55 -0700 (PDT)
Message-ID: <41cd3168-c63e-4b6b-9085-07dfe95e48da@redhat.com>
Date: Thu, 1 Aug 2024 11:43:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: fix ndisc_is_useropt() handling for PIO
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jen Linkova <furry@google.com>, Lorenzo Colitti <lorenzo@google.com>,
 Patrick Rohr <prohr@google.com>, David Ahern <dsahern@kernel.org>,
 =?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kgLyDlkInol6Toi7HmmI4=?=
 <yoshfuji@linux-ipv6.org>
References: <20240730001748.147636-1-maze@google.com>
 <CANP3RGdKuZUxGe6o0yYpFoJi+KsVPbLUoEwpUFHTgrQHA6BzcQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANP3RGdKuZUxGe6o0yYpFoJi+KsVPbLUoEwpUFHTgrQHA6BzcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/24 02:27, Maciej Żenczykowski wrote:
> On Mon, Jul 29, 2024 at 5:17 PM Maciej Żenczykowski <maze@google.com> wrote:
>>
>> The current logic only works if the PIO is between two
>> other ND user options.  This fixes it so that the PIO
>> can also be either before or after other ND user options
>> (for example the first or last option in the RA).
>>
>> side note: there's actually Android tests verifying
>> a portion of the old broken behaviour, so:
>>    https://android-review.googlesource.com/c/kernel/tests/+/3196704
>> fixes those up.
>>
>> Cc: Jen Linkova <furry@google.com>
>> Cc: Lorenzo Colitti <lorenzo@google.com>
>> Cc: Patrick Rohr <prohr@google.com>
>> Cc: David Ahern <dsahern@kernel.org>
>> Cc: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Maciej Żenczykowski <maze@google.com>
>> Fixes: 048c796beb6e ("ipv6: adjust ndisc_is_useropt() to also return true for PIO")
>> ---
>>   net/ipv6/ndisc.c | 34 ++++++++++++++++++----------------
>>   1 file changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
>> index 70a0b2ad6bd7..b8eec1b6cc2c 100644
>> --- a/net/ipv6/ndisc.c
>> +++ b/net/ipv6/ndisc.c
>> @@ -227,6 +227,7 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
>>                  return NULL;
>>          memset(ndopts, 0, sizeof(*ndopts));
>>          while (opt_len) {
>> +               bool unknown = false;
>>                  int l;
>>                  if (opt_len < sizeof(struct nd_opt_hdr))
>>                          return NULL;
>> @@ -262,22 +263,23 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
>>                          break;
>>   #endif
>>                  default:
>> -                       if (ndisc_is_useropt(dev, nd_opt)) {
>> -                               ndopts->nd_useropts_end = nd_opt;
>> -                               if (!ndopts->nd_useropts)
>> -                                       ndopts->nd_useropts = nd_opt;
>> -                       } else {
>> -                               /*
>> -                                * Unknown options must be silently ignored,
>> -                                * to accommodate future extension to the
>> -                                * protocol.
>> -                                */
>> -                               ND_PRINTK(2, notice,
>> -                                         "%s: ignored unsupported option; type=%d, len=%d\n",
>> -                                         __func__,
>> -                                         nd_opt->nd_opt_type,
>> -                                         nd_opt->nd_opt_len);
>> -                       }
>> +                       unknown = true;
>> +               }
>> +               if (ndisc_is_useropt(dev, nd_opt)) {
>> +                       ndopts->nd_useropts_end = nd_opt;
>> +                       if (!ndopts->nd_useropts)
>> +                               ndopts->nd_useropts = nd_opt;
>> +               } else if (unknown) {
>> +                       /*
>> +                        * Unknown options must be silently ignored,
>> +                        * to accommodate future extension to the
>> +                        * protocol.
>> +                        */
>> +                       ND_PRINTK(2, notice,
>> +                                 "%s: ignored unsupported option; type=%d, len=%d\n",
>> +                                 __func__,
>> +                                 nd_opt->nd_opt_type,
>> +                                 nd_opt->nd_opt_len);
>>                  }
>>   next_opt:
>>                  opt_len -= l;
>> --
>> 2.46.0.rc1.232.g9752f9e123-goog
>>
> 
> The diff on this second version is significantly bigger (although it's
> just unindenting a block), but perhaps this is better as it is much
> harder to screw things up.

Makes sense to me.

It would be great if you could follow-up with a self-test covering this.

Thanks,

Paolo


