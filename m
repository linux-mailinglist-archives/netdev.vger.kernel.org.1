Return-Path: <netdev+bounces-130072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87867987FC9
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7702856BC
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8818892A;
	Fri, 27 Sep 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Xfrb8Wzz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2218787B
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423529; cv=none; b=tjC1ZnaFq8p8pIEt5TC5mViqpY5rPXI0OKWRdXhasOO9ZHDccsKfkodl0/0bIYNsz+5pfv3Es64V+DnLAJ5oViTtbtHF0s3pOg5jGUene0tWgarep69Z5yRcb5r2lx+/ryWUEZfMWWPvJruvFRuNci6qcsoFRR4PxtX7NkLhXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423529; c=relaxed/simple;
	bh=CPsrNNrQz3zK+UzSt77ecs0uGHI8xZyeyT5Grl2+hfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTT2LSh9/6BINto7wEdx17jVes/Ptp7t8dr8u/qVc6X5ZoVLbYzxMCozvWTA/wSFFpddO0SKx64N5l6Q6xHVS8BfY4y3WiIHAzsXZ18GVuzjeH4xC0ZX0eL698FP8cqV5xee9umZixVjEngIgMgk2NePnu7ey36ZdrfRfvXSOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Xfrb8Wzz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so14722965e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727423526; x=1728028326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=olyxueoJqNdIlZOzswEBChTL62y6VMpWFHc8QTezoGQ=;
        b=Xfrb8Wzzod6uxsWS8216unZyIrdMAivmMI1OAHyXjljBh82TDH1Hwir65NOAkibnA0
         ygrM5cPAzW4dhaEz92ptSZobAQcDK2S9VeKR8PBMucOXRhx9WxBXiydgqdg27YgVS2m4
         1l4WFRWGQLqkF5l5Of5NqRKMT/yKWHkQuCMaiUdCllkuEg6p1A+h7gAoW+LlmHQpiSIX
         +s/LWjyp2KKXWTfJIMFMUJhz4uWjuVest8XQ7U+XWAhR6Ru+JoSQ9fXCp65Ie0rROVia
         RECmYZKcH17JFn9Qek30eYuuDYsBz5jhmWtBUtsaH0dIhDhypRjy84NyNxj9nAJAvQ+7
         LN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727423526; x=1728028326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olyxueoJqNdIlZOzswEBChTL62y6VMpWFHc8QTezoGQ=;
        b=ZgyeAYEYV1MiqVTBEn2w+/EMxKAiXbTnB6T0bvXkhc6Wz0kVYRmIseHDAD/HVfzhhZ
         IA3LIDQq+1Z1xwT/pu7np5eSsnoBMs3EBIQQ8EHOdZcbbYehsg5+RF/dqkteds8aYKvv
         FVq7onD01AgSf16MqAbSVsidchi2MGElE5SdI9ns9SVLUkejFhQaPjwk6PorC6zAxtJT
         kU5bmgrDOvlyWM7tvXlIi6WQnFenvEBkI4LQH8rcMaRaU/SFOrqHFQwOvKj0T19NL2Cc
         96QYJR9l7R0IMoKxOSuzzS+L3hyxToNVltDkroQdfCTVs49yZuySmZIJ2/2HPAaawnM8
         4Rug==
X-Gm-Message-State: AOJu0YymKF85LDHMl5Ecg1CrCILWZuTsyW8KAOaitlaJBOKBHVsyuZhh
	44ifjYx4esTWu5tyXUzYo8zSXDU9OJCOVEv6zDna54jRK+2XLx53U3TPtqGkMJA=
X-Google-Smtp-Source: AGHT+IHo4eEWnfQbdM4MFwL2jWevzW52GPqBAwohoeyyipeFRtkx1X/yxYImz56yhE/dXzGZa97vMQ==
X-Received: by 2002:a05:600c:1d1f:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-42f58412c63mr15127815e9.8.1727423525637;
        Fri, 27 Sep 2024 00:52:05 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:97c9:42e:8ba6:e6a4? ([2001:67c:2fbc:1:97c9:42e:8ba6:e6a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e3008bsm18401525e9.43.2024.09.27.00.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:52:03 -0700 (PDT)
Message-ID: <80eee015-49a1-4f89-a688-e035b518409d@openvpn.net>
Date: Fri, 27 Sep 2024 09:52:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 sd@queasysnail.net
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net> <m2wmjabehc.fsf@gmail.com>
 <99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net> <m2o74lb7hu.fsf@gmail.com>
 <1f5f60cb-c4a5-44b9-896f-1c1b8ec6a382@openvpn.net>
 <CAD4GDZxShO4pRaYvzeo+wrCKW-VX7Ov2XDBz8990qv24v+TUwA@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CAD4GDZxShO4pRaYvzeo+wrCKW-VX7Ov2XDBz8990qv24v+TUwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2024 17:06, Donald Hunter wrote:
> On Wed, 25 Sept 2024 at 12:36, Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> Donald,
>>
>> I see most (if not all) modules have named ops dev-del/add/get, while in
>> ovpn I am going with new/del-dev (action and object are inverted).
>>
>> Do you think it'd make sense to change all the op names to follow the
>> convention used by the other modules?
> 
> It's a good question. I'm not sure there's much consistency for either format:
> 
> Total ops: 231
> Starts with (new|get|del): 51
> Ends with (new|get|del): 63
> Exactly (new|get|del): 11
> 
> For the legacy and raw specs that I have written, I followed whatever
> convention was used for the enums in the UAPI, e.g. getroute from
> RTM_GETROUTE. The newer genetlink specs like netdev.yaml mostly favour
> the dev-get form so maybe that's the convention we should try to
> establish going forward?

If netdev went with that format, I presume that's where the preference 
is, therefore I'll follow that one.

I'll modify the op names then.

Thanks a lot.

Cheers,

> 
> Cheers,
> Donald.

-- 
Antonio Quartulli
OpenVPN Inc.

