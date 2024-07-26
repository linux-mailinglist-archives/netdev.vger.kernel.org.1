Return-Path: <netdev+bounces-113132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1BA93CBCA
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 02:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6ADB21464
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284B816;
	Fri, 26 Jul 2024 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j2ARMZQs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0219A
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952356; cv=none; b=XWBI77aLHIvr9PibUXgFouv0eQno4YPsyFQ3z0+G+tg5FbQ8nJcfi+TB6azmRmulsXQMtLKdm/pmOMbuGakOsvnrdfhMN2C0u04TrJSz05V1jCCX+/LsqPqDBAeK4z/zpbCAiSeKUsKp44cv6ln6DiakpADNGM17LcsYTIuNoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952356; c=relaxed/simple;
	bh=G+tK5LJ9MxvpsWXTauo8dSY+BpUIBbQm4mmnumvMLGs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ORDg3Pm/ezCI7HLtiH6L0WsKxz4J+OpNLcNumV/D/XgymGGi/Bb77gHKZcJRQLZR9tIDAERHdPu9OWHxDQoW+uugjEk15bQNWX7n8ydpz7EH26htvlTxeEHdDusGRdJ1coy0geRiEUqX3HQvoYygl433KALFtIKd5GCLz7aU34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j2ARMZQs; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d1578cbeso7372985a.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721952353; x=1722557153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NqB/Umg+x0bHrL33JrlAJwFQQd1HhbucjxA2SIunNo=;
        b=j2ARMZQsF6kr9SZe+1FajALruR0AKkVdq/MZPr7LOQcIOEwegk4OrR3MXIhHsIuaYp
         KJEHzaPFswXOyJdatslZDtZzgTbKPRiYQD9sNyHmHCZveVvFRQywdDSjkRg8Rs/ASWyI
         aANgncCgdgHKEIxqG8nflZVI9LQkugCQnOP3S97WMYQ9bR0LufaeQzOzNGa7xTVaci5a
         +6DN7HADoF+u1TsCIGJMh5uY7ys0fRV3pa+B64fA58M3rVUukMpKNIHxj0yf3Y/UkkwQ
         CL5TyIuXde4pKmchOTmqzhOA0GRxOE6EsTMcaNry13qHBSH3e2i0jP+E2k1hrQwflj0e
         EhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721952353; x=1722557153;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NqB/Umg+x0bHrL33JrlAJwFQQd1HhbucjxA2SIunNo=;
        b=uzwoBA3NCRo8GNw0VSRya7q4aWM3x8zW7kiZz/r8lQTHmVDUdG2UMpO91yhtGC8RK3
         V/oMpGSXM+YnRiArJAZx64J+hR1yYQuk5YHMke3AzDjgFaUJ3INV45LvMEXv3TRJ54zo
         fk/XFcan6Kt3QuYRyA2BVunaq275I/OVMIu4bYkZV6+VdwxhFtSPFq/gVD0f2rg890C/
         FN+LjjmjyZSf8214/OqzcaB3Rw2IeK/0dpflphhGBkVrD0jrr8zrfHs8ojVzGxXt9hQZ
         5Us1dA2X43DNmomB++Ttx7MTmSHVxHlDIf5zEasM7MtqIlKLX7mF3zKtinBHQ+tShqtm
         kdhg==
X-Gm-Message-State: AOJu0YxC0r7rlh3pdEDmlD+/CMEhMn9PG5GbHzHYBOge96ep4OyuPxMi
	kAqFgI3WfIc8avlv8mt/ZibASnGFFHEy2maGBUq9kn11h+5QfB8rmvFzXPKThz0TwOA0XVjlCQA
	B
X-Google-Smtp-Source: AGHT+IE8xGS9xBzx5MEhT3l0OOPsOb1SbDpmSf5NvDUxjoaXxpPXWCh1uELhy2aXl0mmhWCAZAC8uw==
X-Received: by 2002:a05:620a:390d:b0:79f:17e6:fe8a with SMTP id af79cd13be357-7a1d7e49262mr384454285a.20.1721952353612;
        Thu, 25 Jul 2024 17:05:53 -0700 (PDT)
Received: from [10.5.119.35] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73e53desm126377485a.54.2024.07.25.17.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 17:05:53 -0700 (PDT)
Message-ID: <231e099e-ce57-442b-901f-2a9d11149a2f@bytedance.com>
Date: Thu, 25 Jul 2024 17:05:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
From: Zijian Zhang <zijianzhang@bytedance.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <ZqLE-vmo_L1JgUrn@google.com>
 <6b977a8c-d984-4d1a-b33d-15e2e875602c@bytedance.com>
Content-Language: en-US
In-Reply-To: <6b977a8c-d984-4d1a-b33d-15e2e875602c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/25/24 4:50 PM, Zijian Zhang wrote:
>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 9abc4fe25953..efb30668dac3 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -2826,7 +2826,7 @@ struct sk_buff *sock_alloc_send_pskb(struct 
>>> sock *sk, unsigned long header_len,
>>>   }
>>>   EXPORT_SYMBOL(sock_alloc_send_pskb);
>>>
>>> -int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>> +int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct 
>>> cmsghdr *cmsg,
>>>                struct sockcm_cookie *sockc)
>>>   {
>>>       u32 tsflags;
>>> @@ -2866,6 +2866,8 @@ int __sock_cmsg_send(struct sock *sk, struct 
>>> cmsghdr *cmsg,
>>>       default:
>>>           return -EINVAL;
>>>       }
>>> +    if (cmsg_copy_to_user(cmsg))
>>> +        msg->msg_control_copy_to_user = true;
>>>       return 0;
>>>   }

msg_control_copy_to_user is set to true here.

>>
>>
>> This may be a lack of knowledge on my part, but i'm very confused that
>> msg_control_copy_to_user is set to false here, and then checked below, 
>> and it's
>> not touched in between. How could it evaluate to true below? Is it 
>> because something
>> overwrites the value in msg_sys between this set and the check?
>>
>> If something is overwriting it, is the initialization to false necessary?
>> I don't see other fields of msg_sys initialized this way.
>>
> 
> ```
> msg_sys->msg_control_copy_to_user = false;
> ...
> err = __sock_sendmsg(sock, msg_sys); -> __sock_cmsg_send
> ...
> if (msg && msg_sys->msg_control_copy_to_user && err >= 0)
> ```
> 
> The msg_control_copy_to_user maybe updated by the cmsg handler in
> the function __sock_cmsg_send. In patch 2/3, we have
> msg_control_copy_to_user updated to true in SCM_ZC_NOTIFICATION
> handler.

Not in patch 2/3 In this patchset msg_control_copy_to_user is set in
this patch, in __sock_cmsg_send.

> 
> As for the initialization,
> 
> msg_sys is allocated from the kernel stack, if we don't initialize
> it to false, it might be randomly true, even though there is no
> cmsg wants to be copied back.
> 
> Why is there only one initialization here? The existing bit 
> msg_control_is_user only get initialized where the following code
> path will use it. msg_control_is_user is initialized in multiple
> locations in net/socket.c. However, In function hidp_send_frame,
> msg_control_is_user is not initialized, because the following path will
> not use this bit.
> 
> We only initialize msg_control_copy_to_user in function
> ____sys_sendmsg, because only in this function will we check this bit.
> 
> If the initialization here makes people confused, I will add some docs.
> 

