Return-Path: <netdev+bounces-167380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF32A3A07A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0909F188BCD9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB67269B09;
	Tue, 18 Feb 2025 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKc+d2YA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C065269CF4
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890264; cv=none; b=Pqgeb4C0SWQcZaKFqUqQTSO/tiZbyTUUObYmOdWZgTf69iWvVde11dunLKpg3vqYK3a95cAONBzuwtjc+NfyQa7F9M6qp3cwjkjGHPGJvPXwpHe2L4KRXL4FQUztcSZJN+RhByMbZQEoZBSvjimTpN7t+xzYnTboCLx7Igd1vXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890264; c=relaxed/simple;
	bh=ECuy+wVUQRJBRELmkB0KsYyLfmMBxu+FkJ/lQS1E3vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+hM2KxVqyjCaniGh2HycvU3aDPTHH2QfMFaY7tPXJLXrjXFdnY28lJZW7fmScfpwR6cFj5q67jnC6H8kbeT2vlKl9jwr7nqQDwiKCciDiVq1mbaySk5+USADSaPOYVMK3m05Ipz6CW/gwfjG26g3BL8vAz0F2vSWliDC6D2ybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKc+d2YA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbZWrVUwzysvayn3KskC0vB8M9LlwZn25J9VipO9l7g=;
	b=GKc+d2YAAWZzC+T2vifMflNwQoGUgQH7EviMALiMzLKtFDnITMBJMYijW3pKx8mv/KIk0f
	TsVrlIcSCjE/I3KY1M5wo9++FqDuM76roKT8bbVw3avn+dwZxEXGpRl/aIbJq9EDshEgNl
	gMvbVvnjLvSHEqmRhqqIY3JzPjIkWag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-_FvQ9FS4NI6UrlGL69VxFA-1; Tue, 18 Feb 2025 09:50:56 -0500
X-MC-Unique: _FvQ9FS4NI6UrlGL69VxFA-1
X-Mimecast-MFC-AGG-ID: _FvQ9FS4NI6UrlGL69VxFA_1739890256
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438da39bb69so48907105e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 06:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739890256; x=1740495056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbZWrVUwzysvayn3KskC0vB8M9LlwZn25J9VipO9l7g=;
        b=Yx3d56GwZj+MaK1snjugUGuT/1rpp/RknBrZhI0aQXb8IkqEXwMjZVuV87WJ53Ejaq
         PplBgeyl5NxPQpVivy17tKMC6bWkeY/bj4kjPj6InjLrYLkHQHK0fe475f3ahJsL14PI
         SZJHm80OmKW791wWp4KS7ShqLU8Yg6IoF6Ixeb/cq20iEtGC3m4fFsyofvbN7vQCNsg0
         gq9d5eRnkMZSmnNwaxwwyuO9CZE2cYd1QYvWMFr7Dh/LYB1NHT9LbQi0J8Flxrg5dsgj
         6uV4oc8YJCtR5qThPhUOlrPVVU3gXf9YRpC8TJWA3jjj0SuS88rOYmEB55pAdRyyAJRJ
         kcug==
X-Gm-Message-State: AOJu0YwilfJPVA9J9ii3fFVEGegDVTQ9I3QF9XcBNIjML+HoePh6jS7k
	lPmAJlrENqZs6oQO7dW70+oeNSZ7chxHMweRUU75B+FGGb1vIqems8uSZHaUl8ergITQmSg+a/B
	GzGFV1a4FTD5mUemhoq7/ZG5KznuATJFwdXipRSz4GQxL2Df9HUhywA==
X-Gm-Gg: ASbGncu3yXq+kv/7fJ0ZKGaDZbsHDHtlRGSpEKRiS10c72A1JDgt+UC0W9/noP/MAIn
	50dzhz3sYgieXO9Jv6lFPudmfA79LNUR9HcH+zLZAiVRhLBUl9S2quxSEEfM65KOeeTMHST+DCO
	u5NfLQqw6yjd0JPEl84qZdMuPDkLluzYUPmMBSIRAal+isiUB412e2kU0QMTgbTDVxOfcDBzXxI
	gaNnJhIY+I0qmvftzeSIsiBucTdBAh8UoF2+CFXpMpBiotXTw9ki7BccQK4E0L7du017ae0FSd3
	ultr7pAl8yaTSt/rdj8UQbxIPGQ5vHcopfY=
X-Received: by 2002:a05:600c:3ca3:b0:439:60ef:ce94 with SMTP id 5b1f17b1804b1-4396e70c723mr113295545e9.21.1739890255667;
        Tue, 18 Feb 2025 06:50:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGREziIY53spCD5n6BSA148wgJrR+ryFo5ClVNl5DyF7ClaE88mt/kO984s/ACDDOzuTxDC/w==
X-Received: by 2002:a05:600c:3ca3:b0:439:60ef:ce94 with SMTP id 5b1f17b1804b1-4396e70c723mr113295335e9.21.1739890255261;
        Tue, 18 Feb 2025 06:50:55 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7d2sm186206075e9.25.2025.02.18.06.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:50:54 -0800 (PST)
Message-ID: <389ee8e5-8c25-414c-ae19-7dfeebecf1d3@redhat.com>
Date: Tue, 18 Feb 2025 15:50:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
 <41482213-e600-4024-9ca7-a085ac50f2db@redhat.com>
 <CANn89iLbe2fpLUvMJk-0Keaz1yvWb7WUe9X-3Gd5wmNQn7DN9w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLbe2fpLUvMJk-0Keaz1yvWb7WUe9X-3Gd5wmNQn7DN9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 2:43 PM, Eric Dumazet wrote:
> On Mon, Feb 17, 2025 at 3:48 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 2/12/25 9:47 PM, Eric Dumazet wrote:
>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>>> index 5b2b04835688f65daa25ca208e29775326520e1e..a14ab14c14f1bd6275ab2d1d93bf230b6be14f49
>>> 100644
>>> --- a/include/net/tcp.h
>>> +++ b/include/net/tcp.h
>>> @@ -56,7 +56,11 @@ DECLARE_PER_CPU(u32, tcp_tw_isn);
>>>
>>>  void tcp_time_wait(struct sock *sk, int state, int timeo);
>>>
>>> -#define MAX_TCP_HEADER L1_CACHE_ALIGN(128 + MAX_HEADER)
>>> +#define MAX_TCP_HEADER L1_CACHE_ALIGN(64 + MAX_HEADER)
>>
>> I'm sorry for the latency following-up here, I really want to avoid
>> another fiasco.
>>
>> If I read correctly, you see the warning on top of my patch because you
>> have the above chunk in your local tree, am I correct?
> 
> Not at all, simply using upstream trees, perhaps a different .config
> than yours ?

Could you please share the conf, if you have that still handy?

> I think I suggested to change MAX_TCP_HEADER like this because max TCP
> header is 60 bytes.
> 
> Add to this MAX_HEADER, and round to a cache line, this comes to :
> 
> #define MAX_TCP_HEADER L1_CACHE_ALIGN(64 + MAX_HEADER)
> 
> This standalone change certainly can be done much later in net-next

Great, I'll opt for that option then.

>> If so, would you be ok to split the change in a 'net' patch doing the
>> minimal fix (basically the initially posted patch) and following-up on
>> net-next to adjust MAX_TCP_HEADER and SKB_SMALL_HEAD_SIZE as you suggest?
>>
>> I have a vague fear some encap scenario may suffer from the reduced TCP
>> headroom, I would refrain from pushing such change on stable, if possible.
> 
> Then MAX_HEADER might be too small ?

Indeed, and a "too large" MAX_TCP_HEADER would be hiding the problem.
Putting the change on net-next should help catching such a case.

Thanks,

Paolo


