Return-Path: <netdev+bounces-214706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D0B2AF84
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352B73B3B73
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BC32773E2;
	Mon, 18 Aug 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqyNAwnM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF532773E1
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538570; cv=none; b=e1oP0vgdg8ufSwW2Sai6BfV6K/c5YXEWApJRyRuuIzZkuoP60mb3ueBSe2a/Y5ZCyK1aTEkk03YwS7MWffluk5II00Q0mt2d24aS99YsMoDyOOIZYmZ+UGS4w41de8/RuwHHgf4dIDgla6cYIoanTitM4s4X2e81krjveZ6AmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538570; c=relaxed/simple;
	bh=NGifScNdzdntechbyJkKVRR4rpW9r6lwYwtb3UNLQt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SW/FydTENN3vWLgdWFpgl/875uq1OSyBrVhVM3l3U2LKbWoQWj4IWHPqTpWD2GqVZQeCpasRJIz/IV6PrJcHAeDJgaih4R7Pd9iZSBhCvwLI27brGZB7hstRzWfsU5xYutYxbr4pWs/x3w2IVJhD2xe8bYHR87EEQ4mvs3weuaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqyNAwnM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a9f56b1f2so26826226d6.3
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755538567; x=1756143367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqn7WTROEkAR1Wahihf9f3CAGQFZlfC1LwEKl0guq3M=;
        b=OqyNAwnMW2NmA9oQsg9ndszT3m4juLd4wDu5SUGcWh62GwJMjbKPsptF6q4v/oZNwG
         IBq11voBzd27dxEnC7KEK2QQC3L4PYoGwyhJhvaHea1JcN9lpaXNplkQsDOTduhzTe46
         9I5asUmEceFlT8sTb24igLduq86RUz2OXWaC2ePtWKHZFhQmQROn4VavLZhv63jltSmA
         W4ygiviuEZU3POJxhZZ4X5ubLkDA8RC8RgJ+7lNge8lN9O/NZ1dxDwwpWxIV5ylbQrGX
         Ok43dxMBsTwuQW7z5nX82EPR/uO8LJhFYm6HVUq/v6OMTivDgSrfHYruCPG3xf/WmFwe
         /8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755538567; x=1756143367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqn7WTROEkAR1Wahihf9f3CAGQFZlfC1LwEKl0guq3M=;
        b=hnYKSPmLCD5i5lRj4Wwbo4pEmi72DzkQJHtPu8XaccUex+5FnyMaIHtEvOEFQh7GhZ
         695g+QLSTuqSwH4VRZIfRKbgUGk+rJavNJfFRXi6H7hU2IIGZiyLxodWYATAmWj2LTl+
         Fc0mMsXkDi4VqULuqTeg7V27ushvCREWs6e7SYBemccattth1qkEAEHAgI58bmpY9e9x
         YAFUJHBBbXxY+WQ0tkxCx+pvjnlF+nmD9LQ57jKiCMiB2CCDBGXBXAFCYlNKVCrQPM6N
         OXpCl78jOuUFumTlMpXd0WX2AG/yuN2NwwkQcGpx6dZpx0ASxeAjxs+X9BoiUedD2H4n
         I/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXz51WEb0tWTSXoQxHhSiY77NsE8x+MXxbmwr9qaVZVzKaGPGCR8OyhAlTbxmABusANzQF4HLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAzqz/5goq9Zhx1/RzUvTOxdtxf5/1Oq/IenY3hsKTV2Al8T4
	LWRJGb/kKKb2WrM3xwcy7r3lIgrQ9PG3s6cHOfMUOhxnDNJ+MAaWBS83
X-Gm-Gg: ASbGncuLCSq8ukgaYn/Wrz3O6gpz5Fihmz/t64wJTyFByJsEaMRMn/+GCRNJUeW/n/0
	5rW5XI7OHoawnuKIF4fQfTMSg4COXZj1hrKOLfBhtCszhXj87E5les+8FSu115etDSw/025Qb7r
	Dsaat8XZxpFeCXm0gh456APPd2nzeNyobqZrlyN85k7sdaAfag8BMQO64IyFSfJ68n0Sf0Zqpcw
	L5rlweiyij9cvjPj/Ms4vlIk0snGVKG/PZRi2b7Fj6F9YlMTtMxb4TjWo6py2oR9kj6UEGE13fq
	F6sPqHlZtg4bPT+z0mvXrbz7JqjzW+gNCi+W7y09aRdKalD0fHtXoqbsYdyx/q+Vahd1egLqaZT
	y477UqdjwRbQDq7MsA2t7qNe5vVlCw/lHLBD2MxBabsfU
X-Google-Smtp-Source: AGHT+IHlyqCMBxGyUFk3bLnmK6EpRLImTIRUOc9zCXbhTl5rVNM8Ka2VhW+WNOb0gb4URiV2GE7gWQ==
X-Received: by 2002:a05:6214:1250:b0:70b:be19:67b6 with SMTP id 6a1803df08f44-70bcc242de9mr1675976d6.34.1755538567204;
        Mon, 18 Aug 2025 10:36:07 -0700 (PDT)
Received: from ?IPV6:2601:80:4a81:8340::cf68? ([2601:80:4a81:8340::cf68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba95d3449sm56446916d6.77.2025.08.18.10.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 10:36:06 -0700 (PDT)
Message-ID: <0580f8a4-c73d-48bb-bf84-abfa63938130@gmail.com>
Date: Mon, 18 Aug 2025 13:36:05 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/19] net: modify core data structures for
 PSP datapath support
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-4-daniel.zahka@gmail.com>
 <bdd670a7-6447-40f0-a727-37832a8ccc5b@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <bdd670a7-6447-40f0-a727-37832a8ccc5b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/25 9:09 AM, Paolo Abeni wrote:
> On 8/12/25 2:29 AM, Daniel Zahka wrote:
> @@ -446,6 +447,9 @@ struct sock {
>>   	struct mem_cgroup	*sk_memcg;
>>   #ifdef CONFIG_XFRM
>>   	struct xfrm_policy __rcu *sk_policy[2];
>> +#endif
>> +#if IS_ENABLED(CONFIG_INET_PSP)
>> +	struct psp_assoc __rcu	*psp_assoc;
>>   #endif
>>   	__cacheline_group_end(sock_read_rxtx);
> This cacheline group is apparently undocumented in
> net_cachelines/inet_sock.rst, but perhaps it's worthy to start adding
> the info for the newly added fields?

I took a look at net_cachelines/inet_sock.rst and the other files in 
that directory. I don't see a table for the fields of struct sock where 
I could add an entry for psp_assoc. What kind of documentation are you 
looking for here?

