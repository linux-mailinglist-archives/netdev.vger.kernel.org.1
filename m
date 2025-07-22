Return-Path: <netdev+bounces-209082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0F7B0E399
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF75645F8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999D2820B7;
	Tue, 22 Jul 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXaqL0Z5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FD23B60F
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209705; cv=none; b=HvQ/RLl6uKB1mj7FXRJLKRykCQf/l9wXA7pFZYjbxIpPFfLjktMr9T3O0iGIr/L+0fuqrsvKQ7y2hWSXPwzy+Z7GIKVfJA33Ui1NEOGbqVD35VRRq5rZ1xjAqbU8Axcc4yMPfdgQGxCkVInmMpiEAjS5tmM0r7r6aZa8NK3BYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209705; c=relaxed/simple;
	bh=GAfTY07nnT0nC4gUqJZvFB1zPpcapPBmn65tbriKSuQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kwUowIZ+Tb6UpUN2YYHZgYX6X6Y16Pel2kEqs2FhE+csPR8dpcAJI+Vb30qqyjzxApU2se0rJ0s3V/221/gXqrC8q2G+SKfK7DYKLaLvC3guKbGTBxK2z5cRcPGXPRAN6nFfKypFLVeQqjgTYFARExXh49y+zWKn1PF0RtJT+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXaqL0Z5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753209702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yE2tHddyKrIJYsdGOME7S0MXHkPfwwNA1+RUdibZkzI=;
	b=XXaqL0Z5XsWhH3xGzQTolJJ67PF75fsbfJFNOPCIINHQ3BA5aPzah3meMQ9q7OQ6OPJkR+
	yuX/CeXHjiVYXXtlO6Dz1xpDgTOg/pYAVU2psVpXi3u3xT35t80yhEosnYYJW+nLFmWQi5
	CltGpbRykXq+ZLo6SdLhY9mGE5/svfs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Oa3nJzTIOj-_PktRmn1UXQ-1; Tue, 22 Jul 2025 14:41:41 -0400
X-MC-Unique: Oa3nJzTIOj-_PktRmn1UXQ-1
X-Mimecast-MFC-AGG-ID: Oa3nJzTIOj-_PktRmn1UXQ_1753209701
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb5f70b93bso99147496d6.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209701; x=1753814501;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE2tHddyKrIJYsdGOME7S0MXHkPfwwNA1+RUdibZkzI=;
        b=L9VfwVInjvLi88Fit3vBJ7v+twV3N2ia5JbX/JLqrzqLiJglJnVEuvh7cGzc5qUCc5
         06PfQj2I2CfM+xyv08R3jQFBthkL1J+opDakMb9zF8WbOOWXvbUQPEAuSSvWn7qmIf+9
         9ehx9i2kHB5aKRspEzY0yfX6s6nvB0oqhx/zsaHrw8GEKOL9Y1UoM2Z+go2PM2ejlD5B
         xHo9Ow6BbmGykMgPMhwn/7z3tXti2J0cg9TDQb7/SUznc+gOkGzaoDrYlRADhzCaQM9w
         x2Z2A8MFZye4bjU2FxbMlsfJZ8IyTzHd/+W5AcL0+3uTuMohFhXlm/IRFuK9VqKM5EZo
         cZyw==
X-Forwarded-Encrypted: i=1; AJvYcCXulsnwNxh8a+vWuiVJTfy6fIMOi18BtTClD1QRS8rMa+8QFMKhBpu4evt0cFAangpNmj8Lp1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUfP2GZ2WFeGqkpwi6ZWxMJDawOXIjqzDO3+0G595KkCttY0U
	0PuDdwmnrLEHQuCdQzQijUD17ovM/2LofvTeWWvqE5Kz2b3GTaEAP7pLDxGNmxsR1TQ1W2mmj7c
	7owCcKSXnYlxVmo1kI+sYeLAfW9ow0UKEEaE1CTW2qrbTDU58J3+r824n0w==
X-Gm-Gg: ASbGncsvOGKMGEBTqnv+qxCgYvCfPi7FlD5NzABRGU7li8nEaMZv8IpwaN7/WzU41uI
	/8vNqTlivRAr9Ssie+XSBnQ5eYDBCTluSXhKYKbQTmuYOms3HGrSoO7buYaEzc2dcziU+Yyf51v
	Zfczan/xfEplXzdGlZ0cUdN3qc8k+HM4hMyVNFXku+PoH9zmSv7AZHkSBuaMSWnrzApAMFi5dxx
	5X0FwZ2qC2IplyHV+WFrfU5vlTmqEYb5SFXymO3AlPNL5wvcJiewDijsK9fECr2i+qCTUDYyxCt
	VpiJ/GEv81k583vForTx78HorRTe+wgf1abvnp649/5dVZ5bnUvCdiUEUhAxR7KJ9JTi8feWzJ1
	lBc7Ny7tNHw==
X-Received: by 2002:a05:6214:528e:b0:6fa:8c15:75c1 with SMTP id 6a1803df08f44-7070058d077mr2887036d6.2.1753209700816;
        Tue, 22 Jul 2025 11:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyxyagFJsSlRVWyR3oQBKxo8hm4VSSyBCBCDh68tTOQPIpBZKEnj0FI7ZeFaiDUe2jYRvO1g==
X-Received: by 2002:a05:6214:528e:b0:6fa:8c15:75c1 with SMTP id 6a1803df08f44-7070058d077mr2886596d6.2.1753209700301;
        Tue, 22 Jul 2025 11:41:40 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90616asm54508526d6.35.2025.07.22.11.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 11:41:39 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3db01bc9-f6ea-41f7-8cbf-fb33e522694a@redhat.com>
Date: Tue, 22 Jul 2025 14:41:38 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Daniel Sedlak <daniel.sedlak@cdn77.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/22/25 2:27 PM, Kuniyuki Iwashima wrote:
> On Tue, Jul 22, 2025 at 10:50 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutný wrote:
>>> Hello Daniel.
>>>
>>> On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
>>>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
>>>>
>>>> The output value is an integer matching the internal semantics of the
>>>> struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
>>>> representing the end of the said socket memory pressure, and once the
>>>> clock is re-armed it is set to jiffies + HZ.
>>> I don't find it ideal to expose this value in its raw form that is
>>> rather an implementation detail.
>>>
>>> IIUC, the information is possibly valid only during one jiffy interval.
>>> How would be the userspace consuming this?
>>>
>>> I'd consider exposing this as a cummulative counter in memory.stat for
>>> simplicity (or possibly cummulative time spent in the pressure
>>> condition).
>>>
>>> Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? I
>>> thought it's kind of legacy.
>>
>> Yes vmpressure is legacy and we should not expose raw underlying number
>> to the userspace. How about just 0 or 1 and use
>> mem_cgroup_under_socket_pressure() underlying? In future if we change
>> the underlying implementation, the output of this interface should be
>> consistent.
> But this is available only for 1 second, and it will not be useful
> except for live debugging ?

If the new interface is used mainly for debugging purpose, I will 
suggest adding the CFTYPE_DEBUG flag so that it will only show up when 
"cgroup_debug" is specified in the kernel command line.

Cheers,
Longman


