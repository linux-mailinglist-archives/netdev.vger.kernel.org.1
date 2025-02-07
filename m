Return-Path: <netdev+bounces-163780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC8DA2B8B0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3E1643B6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172D537E9;
	Fri,  7 Feb 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2VLRcei"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE85364D6
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894067; cv=none; b=skBvh9vqmfwWoFQH+jPxC1r658DXOGa9laoDisVB9olxkczPkdEX725VwTYeX7kM7b3GhV80asglv+GUIpxNSGaF6gmkQLlczhek9ctC0GfRB78d51vR9CytOgSNo5/tr0XSE0cR87W61Y37jbTetkrJtGrBbRVzN7DHZ8Jeg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894067; c=relaxed/simple;
	bh=cbxvBGUq6GAVSZjhCem/zJILOlVlSekStoMnTngw4yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB01Zo7KIPQhPeQg9YQcNOi3IFhJqWTLC2BNFfn45Uh6hf2uq2/4jsGWjRoKbJCQ0vfTFQfHR53he9rMGfK7FaibU0q6bsGJklEqVUdJvGVLuEhVsei426Z2Zwzww17wcIVDRIgEE1AfamhAh3VkG8z1pdPicz/6FQAOsBQP7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2VLRcei; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738894052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14LZ9ni0ciYY043ozljCMttvg3c9+WpsIO9+G/2+Bus=;
	b=L2VLRceidmxdp6+gZc4lhtgfGFDQbvzdw40H1NMumb/PPBJIF5nGE03uDEdCle0BVjOe1Q
	8MyHxJAa9uxwrhpSuq2R16hkXKvscIyt05rds95cctns1OKDzzrrInqZJnasqFXHOihmdF
	hrEH4l2IZw6ZAQFLqFifPWrnk7MhlMU=
Date: Thu, 6 Feb 2025 18:07:25 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
 <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev>
 <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
 <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
 <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev>
 <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/5/25 10:56 PM, Jason Xing wrote:
>>> I have to rephrase a bit in case Martin visits here soon: I will
>>> compare two approaches 1) reply value, 2) bpf kfunc and then see which
>>> way is better.
>>
>> I have already explained in details why the 1) reply value from the bpf prog
>> won't work. Please go back to that reply which has the context.
> 
> Yes, of course I saw this, but I said I need to implement and dig more
> into this on my own. One of my replies includes a little code snippet
> regarding reply value approach. I didn't expect you to misunderstand
> that I would choose reply value, so I rephrase it like above :)

I did see the code snippet which is incomplete, so I have to guess. afaik, it is 
not going to work. I was hoping to save some time without detouring to the 
reply-value path in case my earlier message was missed. I will stay quiet and 
wait for v9 first then to avoid extending this long thread further.

