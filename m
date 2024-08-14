Return-Path: <netdev+bounces-118503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C32951CF4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EB6288A67
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0401B29DC;
	Wed, 14 Aug 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AekZT8Gs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812B1DA23
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645322; cv=none; b=gCCucXu66Ff1HUNod3S9xBBcs3ZPCVA+b2cSmeF2hMCtbXwXHOP5YJ+xHMMLouXin3ga645Qvj76Auc/Q/RHQ/sEW31Lxq/4UhE65kaVLvMKFoDFjg7A+Oee5A9GLY7BZ1oNYFp0dvSyhOFzCg7AsnLMK3LQH1HZ88oxs2aWNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645322; c=relaxed/simple;
	bh=GTv6JfaY0nVMUurKJDDI3ZfNVR3fQ2oPEi7uPgCxj3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXzUvQqe96kOkkzK+oUwiilXS5rGA7CghOdZOHRQGEDOL74FX71XWwcvtIABLVpyQdkKyNihXi1tNH81sU/dxarB/hjHTTOvcYUknMCxiWr0AY/pkfdLDH0f6klq1pNbRkMRxDIMAsvObB1VMwSagU0egBYzjkyXCK4co3tYdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AekZT8Gs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723645319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC7Vr+L/e9CfU4gv28umDGzY9Su8MakEg7iNCWBa5dw=;
	b=AekZT8Gscq423Umv4kQzvwPFQecC7mp15cRFpelYAX9ekz3Xcsswns1WgTvHPAQw6PqZnl
	xmMhiqadAktqIfRgLceqq2ltSVT8rtiRy8pP4mY9PpYx+lXZ3poer4KMUveUDixyGClqtR
	9SnwKOCgD5kfEmPz892ji5q8n6p3TYc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-I7ezKNuoOGOGl2VOOxK_UQ-1; Wed, 14 Aug 2024 10:21:57 -0400
X-MC-Unique: I7ezKNuoOGOGl2VOOxK_UQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428e4f08510so12615105e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645316; x=1724250116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC7Vr+L/e9CfU4gv28umDGzY9Su8MakEg7iNCWBa5dw=;
        b=uRqithEtC6TvTAAPBvUK15aqA/d2uyuMvJMZApl90B8irR84rabMsRV5M+POGwjSOU
         Upe62CQlt8I1WhbDN6crtIuapbKo0oSMpklJga/88RUrfMzYwMPe2R09Cbq5cwQXTLDh
         r/UlxJBkRYP18Oc0vpXapLpuPj6YiautO+KUPther5Jkl1cFVZnuRYO6C++sOgosHql+
         AmuNDSe926yMmXvDcYGWPhP5P8wIY+Iwogf/fHKdEZYiAOO/JG3t2GkMncDK7mo1TWyX
         PFfKNVMKxYfQnsLyCid/uf2Vg8thpJdD0uK1mkuLXa+yGAearz+TjqF+aVbBBJdaenkt
         EUUw==
X-Forwarded-Encrypted: i=1; AJvYcCUX5Ts2is8K45nBfWq+wt89zConY5jH4vQqkSdDKQIaSyXlZln/AYvfaT0Q++xuhixc2QBfOLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBrIpbbeX2REvPokNCoYa37B4/j25A3ud6dfs6WfLJh6St+CT
	ChuPABEjnxjmKgHAqlJ2rt82brtapy5hDJ43aE1oG5ZsyBFjBbk6zbpMn16/sokDur6Q9VDzIb3
	e4pEHXNCodP0qbKGEzZJ4nI6Y5InYyKqvEvKdpIbyIFHDuOv1lAxllQ==
X-Received: by 2002:a5d:5f88:0:b0:371:730c:b0 with SMTP id ffacd0b85a97d-3717782fcf2mr1441293f8f.5.1723645316232;
        Wed, 14 Aug 2024 07:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiqLhT0sQeDcsyOL0RfcWh50rf0pzOYt0KnCkIw6M5UkF5EC8kKPW3Jc4Ic2MxNcm9bbyhcA==
X-Received: by 2002:a5d:5f88:0:b0:371:730c:b0 with SMTP id ffacd0b85a97d-3717782fcf2mr1441276f8f.5.1723645315787;
        Wed, 14 Aug 2024 07:21:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010::f71? ([2a0d:3344:1711:4010::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7c93esm20925095e9.41.2024.08.14.07.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:21:55 -0700 (PDT)
Message-ID: <638cd906-e3b4-4236-9c33-79413f030a4c@redhat.com>
Date: Wed, 14 Aug 2024 16:21:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
 <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
 <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
 <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
 <f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
 <20240812082544.277b594d@kernel.org> <m2ed6sl52j.fsf@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <m2ed6sl52j.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 19:12, Donald Hunter wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
>> On Mon, 12 Aug 2024 16:58:33 +0200 Paolo Abeni wrote:
>>>> It's a tree, so perhaps just stick with tree terminology, everyone is
>>>> used to that. Makes sense? One way or another, this needs to be
>>>> properly described in docs, all terminology. That would make things more
>>>> clear, I believe.
>>>
>>> @Jakub, would you be ok with:
>>>
>>> 'inputs' ->  'leaves'
>>> 'output' -> 'node'
>>> ?
>>
>> I think the confusion is primarily about th parent / child.
>> input and output should be very clear, IMO.
> 
> input / output seems the most intuitive of the different terms that have
> been suggested.

Since a sort of agreement was reached about using root / leaf instead, 
and (quoting someone smarter then me) a good compromise makes every 
party equally unhappy, would you consider such other option?

Thanks,

Paolo


