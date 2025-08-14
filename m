Return-Path: <netdev+bounces-213801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E8B26BB4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAEFAA56F5
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A44204096;
	Thu, 14 Aug 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKAhOxpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7C199924
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186806; cv=none; b=XJRhBRb3Fo0MLbPNNVduQF5Bssr3XPqdkr/yyEY7A+VnQTr0EnOxkuuC1LtDhHyhmozri94lD3VjlUEV3wscEfPEWiFJeAukODXAZjqMvo0s0X63ck2XdfhnRtjY/GszGlvM+GMditxWPK/5kk3z9vbZIJ+MN7rfJeVjldSVFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186806; c=relaxed/simple;
	bh=chNbYMXqIf5sbUwTNQRed47YL3+n/DL74eP1uksvpZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5ZRdqV/qaHJCvO6hwU+cA+oA0Zx/xxED2YnWYDOrYXEAY8nYMicA8iBB5QOuddknHE4cexLMGufeP37Rj91RoNYLrqllHfTz4CiQCTk8mATnj4PrRxZ3da+g/Y9fttEvh2jLu1FKwxPrqx4To0TMq3yS+eOqF7Jiviv+T4/ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKAhOxpm; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a88db0bd8so10768536d6.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186804; x=1755791604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jU0FKL9k+yo0fLGUfr+yjxIwwRipTVVmHHTwNHnqUb8=;
        b=HKAhOxpmJNR2GIPHuTHTAX3/7cLjU4f2mpOzlTEWYtOG7RbKOh6EdB+CfeFsHJwQr+
         OydVtFDGNSUdgAeE16VS/a9IdDbf5mGEHFe01UsHqv548PI3ohALzTCkjgI35gzJMjoF
         ME5iavcYSh6pkQS2dLRnWBi6XR+fqpchA9TfH1rT4rafshCbZHF6IW8UkTFIYAcYDKj2
         diYq1ye80QenGhlfyhjoH84FI+A/dZtWynZ95FA9SrGyt+HYMGU57FZ18WNz7JG5aYdU
         caiQ/L20MqKcsUfy1kS6YOPiylGnRf5wtT6eV5L7V73CWnnV3oBhNF3FlKFqL7xpqHy1
         yMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186804; x=1755791604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU0FKL9k+yo0fLGUfr+yjxIwwRipTVVmHHTwNHnqUb8=;
        b=nNJ5aGQoxfbtdhxEG4iUB6Kzx5l0aX5CB0OLaF+lQXBygviMaFZ3bti7pqgHP8kPdk
         Gd62oo4eJ5PbT8g/0QIeslQ5pXFNpBxVXu+Z4Z4AsDW3N1mQlyDLXR7oGr5JrWRI5YPI
         8qofR7Mzc5+NQKxiuMwoM+NiihG38FuiyRs6idIc86vSAlVt67KE7pwiraqn5GMPfq7E
         /km+DeO0EYD7EERD6omBJt+Ia/FMDLbFRRD32lxjIJxxTiI94g6Zm2RS6Yttf0vg6e1/
         kTZjBks8woGc+hYnHylNAr5gBTPc5RTHRFvGYhbTQkWBjOx/8w7Z5FKIPQlljaZ5G+tE
         pjPg==
X-Forwarded-Encrypted: i=1; AJvYcCVdKQjtLiFDykyTZl62tC2nEcsnpuaYcHZ/iTmtMdMi/f0uelqfpmzjhzzl9iE2jAeTBx7hnVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxqiNWkZAXdkbTziVFQkzWireIdXa1m2jcL03FxBhNlUKV942
	DIe5ywsoxM4uU1gSnxibIDOiUKF46Uaz1n6RBnndvwtJr0M4riPIBXCt
X-Gm-Gg: ASbGncvQ5GqhHdhczVJLlsjtjWTuj2OBHRm4VuqttsnfCp6W274mCepLe4dR+rJqOh+
	WqbqEAntQ0d/c/lro/AyFyYgAzdraI3dPfOzlNObfHhg4xP5jQvOYYSMmqmmzAAeM4SYdbk6oXz
	ZQl9HJ7Ua/StR4xxEq2JRaF0KsrlXONLklZQjWj5JvjGZIYXLM9cj1coqxdeq8oApdMWS/fEzsG
	QTmOSRAxxIJbgVUNWX+W4peVOopToFZcnNgJMP4MQ5MWq3QkHF/8X4qdQn/q1Qc9Zkifjr+qghh
	TqirUA+W95rmBd1WI4ljyHZM3hN3yWOrXmBldqhifpZbcMA22vHKFg0GQw6QwjODETp29m4b/sC
	w0bE7+1FOBMH9aEy0Cqg+FXk+HTSj1qNYvAF7SdENeVKbOS26TUpGojcfgInfN2UR8FupIxXS2m
	n/
X-Google-Smtp-Source: AGHT+IGA0rSBML2rLnKnQ0Dn0LLB44udsvkK/ncc0LXhRz3ABHANdxXtVb/N5E8P5T0a/3IPqCIttA==
X-Received: by 2002:a05:6214:1bcc:b0:707:4c29:c53b with SMTP id 6a1803df08f44-70af5f4106bmr52082396d6.51.1755186803781;
        Thu, 14 Aug 2025 08:53:23 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ae6cc98e4sm14820476d6.21.2025.08.14.08.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:53:23 -0700 (PDT)
Message-ID: <32b6cce4-6751-486a-b853-5604a48572e3@gmail.com>
Date: Thu, 14 Aug 2025 11:53:21 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/19] psp: track generations of device key
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
 <20250812003009.2455540-11-daniel.zahka@gmail.com>
 <324f1785-80a8-4178-937a-c3d6a47e6d79@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <324f1785-80a8-4178-937a-c3d6a47e6d79@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/25 10:07 AM, Paolo Abeni wrote:
> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>> +void psp_assocs_key_rotated(struct psp_dev *psd)
>> +{
>> +	struct psp_assoc *pas, *next;
>> +
>> +	/* Mark the stale associations as invalid, they will no longer
>> +	 * be able to Rx any traffic.
>> +	 */
>> +	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
>> +		pas->generation |= ~PSP_GEN_VALID_MASK;
>> +	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
>> +	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
> AFAICS the prev_assocs size is unbounded, and keep increasing at each
> key rotation, am I correct?

psp_assoc objects are added to the active list during psp_assoc_create() 
in the rx-assoc netlink op, and then removed from whichever of the three 
lists it happens to be on during psp_assoc_free(), which is called when 
its refcount goes to 0. So basically, a key rotation will shift the 
psp_assoc's associated with the device around in terms of bookkeeping, 
but the total length of these three lists combined is determined only by 
the number of sockets in the system that have entered the rx-assoc 
state, and have yet to be closed. For now, there can only ever be one 
assoc per socket.

> In case of extreme long uptime (sometime
> happens :) or if the user-space goes wild, that could potentially
> consume unbound amount of memory. Could memory accounting or some hard
> limit make sense here?

I suppose a hard limit could make sense if adding one assoc per socket 
could be abused, but that is a different issue than if there is some way 
to use the uapi to create a psp_assoc leak.

