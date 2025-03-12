Return-Path: <netdev+bounces-174187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF0A5DCC7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E9A3A80E2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDDB23F370;
	Wed, 12 Mar 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV0dr13L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0893242906
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783016; cv=none; b=ilNbhS2t1L7IeEk9WdGG16TgCXQCIT0TLp9eaV4yy9FpFm902pIRtJVHolovCpLfX87CXu3Vvekg08N70MXI2kZqVAWDgf+19N2zH3qduxsMgaSdlgOAA41yPhF4vSH4hn/kqTdbrhivwTaby3B65wg6nP5NXm9s/YXaIH10byU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783016; c=relaxed/simple;
	bh=2hOLQcK0nORBLT363PAs2p4Xe/ayLL4B9TRmlQIE1pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jKgyViWLPZ2jHy2EHCvC6QJP1CRXTkGdwaaQfjDCV6/AVNPhEEmsw4xYeRIt5EIvRJVge2T6pybi3qW54VVi6q5tqMj73k5jw8fkgCFJYkYO5fQqsrIgde9tXe+ABqJ4A9VhrdP5VEFqkZruVeDp356UrOaO9iwbrcW00igXqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cV0dr13L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741783013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Uy0+Us8YWU48aBAfsmF4PevbIv67uqCW1UcuZ1h/BM=;
	b=cV0dr13LWj8wbQCH0ifCGNKIv2/AKaofSPIa6O7QhQQ6eh6sj3Y9XfOqVt0nxxI7ZGanln
	mdUM7b8yNQGXBnXNslyCkoWw6JYwfXRXI5HZRWmlLdxOQqbvI/q16cQls4wKpd4/QxJFCi
	UJo1Cff88v8Z+T1h9zw3JmLegUpBr2s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-f9WzIhMJNDu12YxD2Km3YQ-1; Wed, 12 Mar 2025 08:36:52 -0400
X-MC-Unique: f9WzIhMJNDu12YxD2Km3YQ-1
X-Mimecast-MFC-AGG-ID: f9WzIhMJNDu12YxD2Km3YQ_1741783011
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5498d2a8b88so3681773e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783011; x=1742387811;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Uy0+Us8YWU48aBAfsmF4PevbIv67uqCW1UcuZ1h/BM=;
        b=WSEGxTdCvfj2zHvjYrWfU9NhMva24PUADjtobO7yM9aiKyjFy3/wY3FG0AWe7RVhn7
         uI0WuOQQGDtlgvRg0aWkLcsFpJQzHPR19QGemzrqrTucXcHOWv+OSPTOhw1KLURd6wQ9
         ShEROE3tEsed8iaB6iGpLBqs4BZ8n5GsjMyrg8YKftKbi06w6RXNtHFDYv/29Wv18dm3
         zPBwIYbNSkyigEqWQ0+j9nWS5BP+ld3CTJ+lWMIKOlnUvoxFv26unqPrDtzUju/OSLUu
         z3n1Bx5gTVaGT2LCXrRtlvh6UnyDmgEpMCtqllkqMVfi2VRJK9aHP3ssJdBk4alyBcer
         WzpA==
X-Forwarded-Encrypted: i=1; AJvYcCVebtVApLu/Tum3ZKUne7RTcVKCoTXIJU8W+RvDPIo48Qpaa3nkvj96WUhh2sq4x6ctSkqohz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEi+fu7fd6BvZCnQ5oqGBb4Js7TNa53IU/yFaixexBcxZhsNAv
	5YbnX77XSw7rP5YlaCF+/84nr+sfSRW40wYC2gZEY8zCvcxGgpsRMppS9yI6XHkasdig3WEvnkg
	y2fYf/cj3+E8/V4yHiOycgBNGYnJ5e8F2WjGr30zfRQEthlV1Q6UWKw==
X-Gm-Gg: ASbGnctrszgrqfEAoLHbEXvxCYf/L5hR0q2qrojkc9/3megE7eb1JwIMSdhjAyiyyUX
	qyiWO1cnfxun8b+TNAb21CY2SmVdJpueJdI05f+2Y2xstHD124agNQOcfJIJ/LSjtsK48UECtZ5
	dXRF8PKlUjHkEuL7oK16Vm7oU88DzqquXb15TDZpRIHUp095VYy+QJ6FhGaPSIgECghadWwzTNS
	UTv/PJ9kaBq0+zZva1nxIaAsajf8NQHyTu2YHdiymF2TaK0OTGVVHmiZrc5nJUc5c2fPJ773ay5
	ZTiDCsRKQgAo
X-Received: by 2002:a05:6512:3d0b:b0:545:cc5:be90 with SMTP id 2adb3069b0e04-54990ec1802mr7512959e87.35.1741783010690;
        Wed, 12 Mar 2025 05:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ1IxJs8naWLTxd2uitQT6TG+ErbiwQb5sqC9irI1JpiwO98294wC1+wPlNx042lduxKVYsg==
X-Received: by 2002:a05:6512:3d0b:b0:545:cc5:be90 with SMTP id 2adb3069b0e04-54990ec1802mr7512949e87.35.1741783010149;
        Wed, 12 Mar 2025 05:36:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc424sm2093884e87.182.2025.03.12.05.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:36:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9F25718FA691; Wed, 12 Mar 2025 13:36:47 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>, Stefano Salsano
 <stefano.salsano@uniroma2.it>, Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: lwtunnel: fix recursion loops
In-Reply-To: <1c585bdf-ebcc-40db-bd36-81d008cf6827@uliege.be>
References: <20250312103246.16206-1-justin.iurman@uliege.be>
 <fb9aec0e-0d95-4ca3-8174-32174551ece3@uliege.be> <87y0xah1ol.fsf@toke.dk>
 <1c585bdf-ebcc-40db-bd36-81d008cf6827@uliege.be>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Mar 2025 13:36:47 +0100
Message-ID: <87v7seh1cw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Justin Iurman <justin.iurman@uliege.be> writes:

> On 3/12/25 13:29, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Justin Iurman <justin.iurman@uliege.be> writes:
>>=20
>>>> --- /dev/null
>>>> +++ b/net/core/lwtunnel.h
>>>> @@ -0,0 +1,42 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>> +#ifndef _NET_CORE_LWTUNNEL_H
>>>> +#define _NET_CORE_LWTUNNEL_H
>>>> +
>>>> +#include <linux/netdevice.h>
>>>> +
>>>> +#define LWTUNNEL_RECURSION_LIMIT 8
>>>> +
>>>> +#ifndef CONFIG_PREEMPT_RT
>>>> +static inline bool lwtunnel_recursion(void)
>>>> +{
>>>> +	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
>>>> +			LWTUNNEL_RECURSION_LIMIT);
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_inc(void)
>>>> +{
>>>> +	__this_cpu_inc(softnet_data.xmit.recursion);
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_dec(void)
>>>> +{
>>>> +	__this_cpu_dec(softnet_data.xmit.recursion);
>>>> +}
>>>> +#else
>>>> +static inline bool lwtunnel_recursion(void)
>>>> +{
>>>> +	return unlikely(current->net_xmit.recursion > LWTUNNEL_RECURSION_LIM=
IT);
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_inc(void)
>>>> +{
>>>> +	current->net_xmit.recursion++;
>>>> +}
>>>> +
>>>> +static inline void lwtunnel_recursion_dec(void)
>>>> +{
>>>> +	current->net_xmit.recursion--;
>>>> +}
>>>> +#endif
>>>> +
>>>> +#endif /* _NET_CORE_LWTUNNEL_H */
>>>
>>> Wondering what folks think about the above idea to reuse fields that
>>> dev_xmit_recursion() currently uses. IMO, it seems OK considering the
>>> use case and context. If not, I guess we'd need to add a new field to
>>> both softnet_data and task_struct.
>>=20
>> Why not just reuse the dev_xmit_recursion*() helpers directly?
>>=20
>> -Toke
>>=20
>
> It was my initial idea, but I'm not sure I can. Looks like they're not=20
> exposed (it's a local .h in net/core/).

Well, code can be moved :)

Certainly, if you're going to re-implement the helpers with the same
underlying data structure, it's better to just move the existing ones
and reuse them.

-Toke


