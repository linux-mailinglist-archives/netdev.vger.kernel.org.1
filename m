Return-Path: <netdev+bounces-158543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E2A126FB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F9B188627F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8E13A257;
	Wed, 15 Jan 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9fJEHQy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B324A7D3
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953988; cv=none; b=KX6yICtBzP5pjDOsvAffHg6HyoGfgiQlm43d7Hbu9erkC+gxOO0wI05HSmpZvdBTk2TFbztXzi3EChkp4QIDa0gmy2xzyQBK5640CQDTBT2fVDm6+USsK4YK1EsZP43hnpuHI9sJ395Md3n9olzUKv8KOV+IBYP+pbMAAozpBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953988; c=relaxed/simple;
	bh=ikkCONyZXlBdcJUw3MedMriXJgyQP1dzgvb87yX++yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVEmUSqWc207TitHqUMcG/yqkyrT+3Py4w+bO9C2lQNzc+xKQ7Bz4Hnrc8D4RioAwH72OsVPSRzYkqZop1nzE81ycn3fu5JCw639D1DIt2QIaep1jpB5xteFzOm06usc+s1vUUxkbTQt03V7wjfuue2gFd/6EZQaYw3d6KZbGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9fJEHQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736953985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLdU8RkgSeQ0Ab6g/eU0VlbWu1fMgAfz2w454NRUIM4=;
	b=C9fJEHQyPoNfdJtXQFenle1NOatR2S0ZagTZu5eoVAdY9y2rUpgtn6gZP8Cq8TF3a8PqPO
	uEvQPw5B2FUArW2XqoKghGw0LVoft/dbk9hlJTOVdxDQzMiCvTPHJCSQYE3ekQ4VEgf9FB
	FoAUV5RrvJ5ym1DXf6LNXmilGnWY+sI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-fQqJhkjdPuGdEmxBZ9rMrg-1; Wed, 15 Jan 2025 10:13:02 -0500
X-MC-Unique: fQqJhkjdPuGdEmxBZ9rMrg-1
X-Mimecast-MFC-AGG-ID: fQqJhkjdPuGdEmxBZ9rMrg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436289a570eso30886015e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 07:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736953981; x=1737558781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLdU8RkgSeQ0Ab6g/eU0VlbWu1fMgAfz2w454NRUIM4=;
        b=AsxXbA7Wq/zuFAVg26bTEF7xv3UAwSPUTUZGgF0aG+emQyy2r2iXxBEwykqdMlO/IF
         BNPrCG6oq5lWlpTXYW378qiDEZNwczmjwPMYgQaLip9SmkKoU5LbsQEll07n3O0khxGR
         FlfWiaNIwoqlM/84I1ngRZN6ulsgCTTsScu5INVjFIUP8/CAdPPLBqzZxJL7eLDktS7V
         Ct1efnwgwC5yl1Q42rjdrxovICAF0fJV35O1U/aaRzHfNx8xta9lmMUabQv9GlBhoVQn
         dhVmB/ymsMV3BkswejsglJJLCY5tvsJoRO9gJFUvy/7Wb2v+MUNGkGBTeaAs/nQm/BIg
         UmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP/g0SrPWedhzNj5Ebupq6HbENaRnT3vFQeq0UxqFMCUU/Ze7dDpBwHGmE64yAvIcA0VgAUNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhcpmEe9Bw5Etxfp6eLF6omgiCyRA3ePZco7CshCJRNST8XXu
	MIFQcNHOviGbFJgdwrrKzOxETBYCF2vNSz1JPg8eKwDtvYSwht2sDSMXtB+0cpwyMK01qAPDqn7
	OjATje94rFYousm4Mz7wYRPLWCpRFH6LFCcR2b9zJStRYDdUFGqU6Sw==
X-Gm-Gg: ASbGncs/4006p+Wh2CNIpHF6GYklRIt+Aq1ISoLXq5rMxHBGC45xQlR0vyQxL/dbLn9
	tjCrnL/CHQ2MIlMx1NtTldVWEScoeWfOTNUW+B/+M+smbSn512tJn4RRvZQTwzj3SQEgMA3E7Mq
	tJapzgQUCZ6p1OWfYm28Cgl76+uR4dI5yAVdCnEAE7wltjmt17PnAWKCdRx4OhB/7wDQp5u3nb7
	hi755VQjEabSx3fOX1mydnVrxGnXoXRdUZZzmF1q4yMvj9sCPTwC8kLWibWF//+3hy+3Qz7YeCo
	llwrdjYe95I=
X-Received: by 2002:a05:600c:3c85:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-436e2679a7cmr316714495e9.5.1736953981337;
        Wed, 15 Jan 2025 07:13:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTMHKNjVPDlDgcim9qsAEueVqCzcKyVc8UZRKYRGgDLyXFC3PbDg++48ILlva9ypVyqYTwnA==
X-Received: by 2002:a05:600c:3c85:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-436e2679a7cmr316714105e9.5.1736953980953;
        Wed, 15 Jan 2025 07:13:00 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c5b2esm26230435e9.23.2025.01.15.07.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:13:00 -0800 (PST)
Message-ID: <eb30b164-7f86-46bf-a5d3-0f8bda5e9398@redhat.com>
Date: Wed, 15 Jan 2025 16:12:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/11] af_unix: Set drop reason in
 unix_stream_sendmsg().
To: Donald Hunter <donald.hunter@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250112040810.14145-1-kuniyu@amazon.com>
 <20250112040810.14145-7-kuniyu@amazon.com>
 <20250114170516.2a923a87@kernel.org>
 <CAAf2ycmV2T_QUn2Y6rSUjwiwTLQqfW1TFk_3SfeTiO03jz8vXg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAAf2ycmV2T_QUn2Y6rSUjwiwTLQqfW1TFk_3SfeTiO03jz8vXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 2:52 PM, Donald Hunter wrote:
> On Tue, 14 Jan 2025 at 20:05, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Sun, 12 Jan 2025 13:08:05 +0900 Kuniyuki Iwashima wrote:
>>> @@ -2249,14 +2265,13 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
>>>  static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>>>                              size_t len)
>>>  {
>>> +     enum skb_drop_reason reason;
>>
>> I feel like we should draw the line somewhere for the reason codes.
>> We started with annotating packet drops in the stack, which are
>> otherwise hard to notice, we don't even have counters for all of them.
>> But at this point we're annotating sendmsg() errors? The fact we free
>> an skb on the error path seems rather coincidental for a sendmsg error.
>> IOW aren't we moving from packet loss annotation into general tracing
>> territory here?
>>
>> If there is no ambiguity and application will get an error from a system
>> call I'd just use consume_skb().
>>
>> I'm probably the most resistant to the drop reason codes, so I defer
>> to Paolo / Eric for the real judgment...
> 
> For what it's worth, I agree that there's no need to annotate a drop
> reason for sendmsg failures that return error codes to the caller.
> That's why my original patch proposal just changed them to use
> consume_skb(). I did misrepresent the cases as "happy path" but I
> really meant that from the perspective of "no send initiated, so no
> drop reason".
> 
> https://lore.kernel.org/netdev/20241116094236.28786-1-donald.hunter@gmail.com/

I also agree with Jakub with a slightly different reasoning. IMHO drop
reason goal is to let user-space easily understand where/why skbs are
dropped. If the drop reason reflects a syscall error code, the
user-space already has all the info.

IIRC the general guidance agreed upon in the last Netconf was to add
drop reasons when we can't distinguish multiple kind of drops within the
same function. IMHO such guidance fits with not using drop reason in
this specific case: as said we can discriminate the errors via the
syscall error code.

Cheers,

Paolo


