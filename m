Return-Path: <netdev+bounces-204663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD9AFBA6D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522531AA7C24
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C1D263F40;
	Mon,  7 Jul 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZEknnY8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D21D9A54
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911967; cv=none; b=EIGOsQST8cusumRIdsiluPUvKXMLI5tmOJQIVhIjSBjvQdkZJ3wv6IEJIIXv+MvpQaZgGDhsrC/i2QtvzweRqC2L5DgIZk2OJKwZPHe8h+O7Dy7HplzTZAa44LMXluBo6fdh6tRUgQ7fJd/q2Wx0s3nKAfBH4qQCOJHhYdFtuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911967; c=relaxed/simple;
	bh=NIGVaSTZ6BstFfnIgpfLIrXukGjEmodLvkG1+UqcmiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ing8fYE7lSqa7lfKy07gEWuyZQP6dKa3YGyxHW/XHnL3ePulYa66dFcKqY6z9qAlGstcl2nWGjTPOFbB4v9YkTedRh5zaWtO8hjY4vszMIgtUQELaW70ieOF0jzEOYq1SZQhXbAwZ5GXsgX3ZIVkbN8jM0UvQpWaU3MiwyzwFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZEknnY8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a9b09ba106so21348411cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751911964; x=1752516764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fvj+I/ao1uFh3uvvfUG0y15ai5hjDttJDBUv5VQamo=;
        b=RZEknnY8LlG8l5PZgkQq8UPa7wuUZMHy76/DmZvGG/6O41taPOBkkEpP0e/K3LgzRk
         l2GIHthkWGUKDA4k8BQtM1uzoUfMqnOU3l/jbWXYcNlzHZYhUZ/UL5ZCnrCxcjciMw3n
         E0l1Dtvdq1h0lyvRzpVBiXyA6FdLWNxhptuPUcODqMB0nM8zJ0G8gAuiuZ45YZsVw3V1
         gbooLUh4D6Wg9VI9seim/KEHNBMwHvxQV02I3dS6kyTiLcYfb/9dOnWaEzlLlWtBxViY
         CEmUOL47hQK46kefapeU7J0fo2dwHRLjkczNkcCjiGSFu7WqWkC3puYj/Jo89/ishQvB
         FcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911964; x=1752516764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fvj+I/ao1uFh3uvvfUG0y15ai5hjDttJDBUv5VQamo=;
        b=l72AmdxpRnC1XNCvGXt7nJ1J8yTl3j1D/3x41VedUDbjg7HfygslcG2Hy8WTWJG15n
         26LvHeZ+EuTzca9FZV8Y/+oCG9JOULiEmTOZTOhrzxrdSRpMjiCJ0gTHmmWxxYiMVa7t
         hDsEPBuZDqRNr3DD90e0MNi/4/K7ZZvI3R8yI746bHHkm09DWaJ0yXBAFt96c28PDrIN
         AMuz3IwTQEqgbwbkT+0Y7eTfVrHyugx4j6Cz0frUaKCEund8E8GJlPqi9NH2UYDpgBxC
         Fze8+uEteNaS/x+ppziDQiGZkx9KzzUK43JRV9u0FNTH/PMCoNpVAhYTrHPs1X4L4rff
         xylA==
X-Forwarded-Encrypted: i=1; AJvYcCUEw0wbMaav9mwYq+EPbaVt1rNEU8g0eW5838lA343ozpxadaYQv+oFZ/HFTXXbNzGY895GJPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybeMK3e2Zhryg1w1ft42y4CeS4GfIPIrNnVuMnLKMxJ3NUUisP
	RiRE6rOOgikPq0MM4QXE/d4x5uM1pqwPy9SlAXtAE5Hwf7DFmeO3zpH7
X-Gm-Gg: ASbGncv92qp/5CCXtywwQMnXV7sV5gg/I3hlQev+RRkSLBcXF9spFs6cX0/Xm89O6i0
	lRSclh1b+362dK6bTdcsDVKDE/JIm9IHDY3t3QsoQ72oORFfy734W5aKuJTdSmeZHoqAJlf15PD
	oExoWuYrNTWiRzB/EZ/dp84Wot45AudvTlsuRUFSpV3/8ErYwfn4C1e0HmtkNFT1XSYWdjB2+cX
	NzKqsnwf3jeeZS+LUw3trrxZvN4A1+nfxEcJ7HT47NwbhHUBNBhVBYoXjoC0KjjaWp4KlcD2PR0
	qreYzwv7Veandkx24qcCNcNuqxfV0OL42Xid5zrKv4aWBuUVVzh1CDyOKFGTg+IRx3QCqKBRoeX
	/JF9VYCywmeYeF8Y6ShkVYWFtm17Nd0iVJ50XbUHN8nblOEXIWTs=
X-Google-Smtp-Source: AGHT+IGXuZvTMP8ijtB3VWpp/Gv/Ikb2+J2tuSZcRr5kY8QLf/Vrpeok5K25puryoKw014FAuLtr0A==
X-Received: by 2002:a05:622a:2cd:b0:4a6:f8aa:3a15 with SMTP id d75a77b69052e-4a9ca1a12ddmr27322341cf.30.1751911964117;
        Mon, 07 Jul 2025 11:12:44 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9a629a2a8sm48857981cf.12.2025.07.07.11.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 11:12:43 -0700 (PDT)
Message-ID: <9cdbda0a-721e-40ac-8696-4fe4222d8b24@gmail.com>
Date: Mon, 7 Jul 2025 14:12:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/19] tcp: add datapath logic for PSP with inline key
 exchange
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
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
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-5-daniel.zahka@gmail.com>
 <686aa16a9e5a7_3ad0f329432@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <686aa16a9e5a7_3ad0f329432@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/25 12:16 PM, Willem de Bruijn wrote:
>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>> index d0f49e6e3e35..79337028f3a5 100644
>> --- a/net/ipv4/tcp_minisocks.c
>> +++ b/net/ipv4/tcp_minisocks.c
>> @@ -104,9 +104,12 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
>>   	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
>>   	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
>>   	struct tcp_options_received tmp_opt;
>> +	enum skb_drop_reason psp_drop;
>>   	bool paws_reject = false;
>>   	int ts_recent_stamp;
>>   
>> +	psp_drop = psp_twsk_rx_policy_check(tw, skb);
>> +
> Why not return immediately here if the policy check fails, similar to
> the non-timewait path?

The placement is so that we can accept a non psp encapsulated syn in the 
case where TCP_TW_SYN is returned from tcp_timewait_state_process().


