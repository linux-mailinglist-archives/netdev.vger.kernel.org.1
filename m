Return-Path: <netdev+bounces-121283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1795C8C6
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25511C2148C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFC143880;
	Fri, 23 Aug 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8XcB9fs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9A4C62B
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403872; cv=none; b=gUY54vItqlAB4dsVCMDg25zcvYB4HMHJW4k/jIE0HF9xxTna0DQYchwZWeJLp9xRA+Z+CLWBReZQkZ/YE48qyLDs6PvFg9GvhEQ2LVOMnNrRAxP6ZlcedEfSJtF1+G15pAWX1VHpJMdExft4NM0/6ZZdAqKZ7NZFBFv2ucWcTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403872; c=relaxed/simple;
	bh=RkIJ/E9QGJTROEj98LkdMcZolAX/l5rVOw4rz6mmL5w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YdLlTe2nsAG/0fHZ5A/Ab4c0mSKldAeAFXubDUJBnQkzrJrltJhG/uDyeCEuUwO0yXVCTCSazJLMCK0hr/8awgdoo3QPCODL94hzJpS02EOqGB7YVKiERa3dnk5xtWQQYbxwjk0n5idM431myvFwiVKl0mYjkJaOxpeRpzf9Oho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8XcB9fs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724403868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynTEdmfticGZ/m8N5XuffetH4d14Sd8C5DRc3+iynN0=;
	b=a8XcB9fs8bZGAJS0A3RoMk5kLv8DANaOML+NbAHAuQCisnnna46GHeRwCYEdvMb3wI9htU
	7iywEfD9k6XIMxmrXCVAm01GCkSIOYHb23BRhTVbIIUifGKVs/MTRayKUiv+JH80QAkoA3
	UwKNh3ec14uUtXbiwi0JXURmqt74Gtg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-XD6ypbPOO_-1RUGM045hbA-1; Fri, 23 Aug 2024 05:04:27 -0400
X-MC-Unique: XD6ypbPOO_-1RUGM045hbA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3730b54347cso800386f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 02:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403866; x=1725008666;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynTEdmfticGZ/m8N5XuffetH4d14Sd8C5DRc3+iynN0=;
        b=uU9e5QfE9hqVoO5FA3SGtLEWmxVnDhSYMXXS9Im5AYC/wdAB63CnjbT+K1zDmXBqkE
         Zq00EP+sPmEV1N3aZhmq4SNRJxX53Ba9V4KuywgpTvqVP3ORHnyT9GbW8TivVBjY9t+O
         HfpnvRFV68YLhBCbTa1quowuRKEPORlDa8FSMk53S7X7wOvheFKmXtkyZGsd/yxrltlk
         AD4d/Zu0KhXdufXn36lhDICFwhK4KIrg0gUPuuzc6+mzsGQ4nyUuoWpZ3WQt58Wexz9O
         DrRQDdXi1Gbvpb8Tjss0BQOe37lJSC5LYxiPOkX+rZ9lLZNpLJthJHHc0nUBUMOSJAZO
         iHEQ==
X-Gm-Message-State: AOJu0YxGNidqHl3gfY67jsmvBsOuOIT6WqFVzWuvmRUA9apLxDXd5HoM
	xmAtjEL30VAJvBVmn3aCGxlo2tYOUSgAsBUdOaKGt/iJf0Tt5eyeHmOhec8OkPTOZHlQ1x/J6GK
	cAeFiispGLEHdq+/xMFz5xEiHtNN506SbmW4E6PBQ/gpC1QFVhmApEA==
X-Received: by 2002:a05:6000:c47:b0:36b:555a:e966 with SMTP id ffacd0b85a97d-373118ba01fmr1078841f8f.35.1724403866062;
        Fri, 23 Aug 2024 02:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKABLCOZsdLJ7r30wQpsKQ4+VNi/BvAKwRBRpvwWPJqjHKv5nQSr7cKvMEdISDqicZf/HU5w==
X-Received: by 2002:a05:6000:c47:b0:36b:555a:e966 with SMTP id ffacd0b85a97d-373118ba01fmr1078815f8f.35.1724403865557;
        Fri, 23 Aug 2024 02:04:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefd9cd1sm90171765e9.38.2024.08.23.02.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 02:04:25 -0700 (PDT)
Message-ID: <8259922e-7a97-4b71-9127-0a403c3d4c9c@redhat.com>
Date: Fri, 23 Aug 2024 11:04:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/12] netlink: spec: add shaper YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1724165948.git.pabeni@redhat.com>
 <dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
 <20240822184824.3f0c5a28@kernel.org>
 <ad5be943-2aa6-4f60-be90-929f889e6057@redhat.com>
Content-Language: en-US
In-Reply-To: <ad5be943-2aa6-4f60-be90-929f889e6057@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 10:35, Paolo Abeni wrote:
> On 8/23/24 03:48, Jakub Kicinski wrote:
>> On Tue, 20 Aug 2024 17:12:23 +0200 Paolo Abeni wrote:
>>> +    render-max: true
>>> +    entries:
>>> +      - name: unspec
>>> +        doc: The scope is not specified.
>>> +      -
>>> +        name: netdev
>>> +        doc: The main shaper for the given network device.
>>> +      -
>>> +        name: queue
>>> +        doc: The shaper is attached to the given device queue.
>>> +      -
>>> +        name: node
>>> +        doc: |
>>> +             The shaper allows grouping of queues or others
>>> +             node shapers, is not attached to any user-visible
>>
>> Saying it's not attached is confusing. Makes it sound like it exists
>> outside of the scope of a struct net_device.
> 
> What about:
> 
>     Can be placed in any arbitrary location of
>     the scheduling tree, except leaves and root.

To rephrase the whole doc:

	     The shaper allows grouping of queues or others
              node shapers; can be nested to either @netdev
              shapers or other @node shapers, allowing placement
              in any arbitrary location of the scheduling tree,
              except leaves and root.

/P


