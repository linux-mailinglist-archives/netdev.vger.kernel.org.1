Return-Path: <netdev+bounces-113302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0F93D982
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA78B1F2539B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455956B7C;
	Fri, 26 Jul 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bmMLPxu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDE383B2
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024057; cv=none; b=C63Cl+nB72CDUcqhWy891ENrueRf8Lu640xY1Cv8R7ZyKY9yMbmrZWvkyoq3HP5qWFIXbXcXpO8jWcxbt8CCcVqBF9UfTlgDy6NXm5XuvWRuPU02pwB2PmvfY01iUhlDNBJhYlkN6f5JKQr/25zmJoub4nL/TAOlo/xOEA0tTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024057; c=relaxed/simple;
	bh=OlN6ouISjF6lClgAJYIlu6HP09VoPy8WtnFAH0Pe9Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/7KnV95cuMWisdjASbAz/ieW7v2ZBHnqO73crdwvH/tCVt4fkla+7/mEFxWWr5fpijjK0V9LiaCVJONXRrwuEHpUYP24lPJ5vrcg6I1e2TBmMLKd6dQ9ZUkeBH72BCBv61FGSA36A05DhAFtAFWXubD7JdsV32YBJ8Mvgv0NOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bmMLPxu5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44ff99fcd42so4915711cf.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722024054; x=1722628854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABafeF0O4eEf4TX4ROAjUmDWE7RpT+HmPbPe0BBTPVg=;
        b=bmMLPxu5xPdv/lFakD8DWDSSZ3IsDY6fGn44+qqOl/rNMXiJyarOPK8I+K9pT759Q1
         F3fs6jaLxb1oI89aRQxEjUMiggdeGZGo/wG5T5id+TvuCZ6IsJfNZACjGNgcFvxq08eb
         vCh41a3YM4oK91yunefJNUBxLJA0vayKBWdX05m88+63Bo1Qo/pcF8BA2epmfylUbl8R
         Ar6kq3aR9cEk1bCWiP307txo4zn7zC/lsOR0iAcqiB1iiKyjuxBnP3OvNOhEa2wxiocm
         GAqXEECJKFm81zYxFEA/rhHZpAD3ZGReXGk/nSCtD/xZ+BG+yG9c4ZXavoalEtZgml5Q
         7EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024054; x=1722628854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABafeF0O4eEf4TX4ROAjUmDWE7RpT+HmPbPe0BBTPVg=;
        b=WvMVs9QY1BZUDtNvq3toUvZowC5jze1yDhLFuvTaoHvvvCM7k6LQp2HnsFv16/7XeR
         MXVIerQQ1yYew2qJLHOlDCQvCtxPNY+7lIkKdq98Tm5tZ/E55bXI4hDsrbxFmRRdp19a
         o2ivFe6a4nY3goMdxhJpxIa46rJHu6gOwB2A0mLU4xKZyF9/JROhe9mwEDCdydDeN20m
         +jfXyQrT/lOso0KnhHxe1pqseVR7y94/4+whMR4BlQyPd8DjSUAUu5t7wlK+v69unp3H
         0rlJkjBQTfnzmN581cmfvrk4Gnhi8tjjiQkZyDRbaD5Mc0ho4BoYYmVgQaDzLdcBH0iI
         UCRA==
X-Gm-Message-State: AOJu0YyCIlCoE6lfuoWaIJ16jFBMAWkOuPIncQopOvJxE+PTC+6AJPv6
	smMKZ9CHjgVOzdXSDjtiMMYPV1vVjD7oNGSazaZmTYLA9d9PbJCTkW6/EAKZFao=
X-Google-Smtp-Source: AGHT+IG8yYNM8PAP7iSDIrGoS2fMdZtDWZ0sWJRIhW/1b4oLvCVbnEZv+NKte88Tk/bt3nWL5Bsd0A==
X-Received: by 2002:a05:622a:1a13:b0:440:5f14:1647 with SMTP id d75a77b69052e-45004d6ccddmr8370611cf.8.1722024053603;
        Fri, 26 Jul 2024 13:00:53 -0700 (PDT)
Received: from [10.5.119.35] (ec2-54-92-141-197.compute-1.amazonaws.com. [54.92.141.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8172319sm16095461cf.44.2024.07.26.13.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 13:00:53 -0700 (PDT)
Message-ID: <ae6f2bec-2b1a-461d-8248-4ecbd88245fa@bytedance.com>
Date: Fri, 26 Jul 2024 13:00:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <ZqLE-vmo_L1JgUrn@google.com>
 <6b977a8c-d984-4d1a-b33d-15e2e875602c@bytedance.com>
 <CAHS8izPsK_+WffSBiaEEc7cb44dapure=L=1zhLWkjxAy9cpwA@mail.gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <CAHS8izPsK_+WffSBiaEEc7cb44dapure=L=1zhLWkjxAy9cpwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/26/24 10:00 AM, Mina Almasry wrote:
> On Thu, Jul 25, 2024 at 4:51 PM Zijian Zhang <zijianzhang@bytedance.com> wrote:
> ...
>>>> -static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>>>> -                       unsigned int flags, struct used_address *used_address,
>>>> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
>>>> +                                 struct user_msghdr __user *umsg)
>>>> +{
>>>> +    struct compat_msghdr __user *umsg_compat =
>>>> +                            (struct compat_msghdr __user *)umsg;
>>>> +    unsigned int flags = msg_sys->msg_flags;
>>>> +    struct msghdr msg_user = *msg_sys;
>>>> +    unsigned long cmsg_ptr;
>>>> +    struct cmsghdr *cmsg;
>>>> +    int err;
>>>> +
>>>> +    msg_user.msg_control_is_user = true;
>>>> +    msg_user.msg_control_user = umsg->msg_control;
>>>> +    cmsg_ptr = (unsigned long)msg_user.msg_control;
>>>> +    for_each_cmsghdr(cmsg, msg_sys) {
>>>> +            if (!CMSG_OK(msg_sys, cmsg))
>>>> +                    break;
>>>> +            if (cmsg_copy_to_user(cmsg))
>>>> +                    put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
>>>> +                             cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
>>>
>>> put_cmsg() can fail as far as I can tell. Any reason we don't have to check for
>>> failure here?
>>>
>>> What happens when these failures happen. Do we end up putting the ZC
>>> notification later, or is the zc notification lost forever because we did not
>>> detect the failure to put_cmsg() it?
>>>
>>
>> That's a good question,
>>
>> The reason why I don't have check here is that I refered to net/socket.c
>> and sock.c. It turns out there is no failure check for put_cmsgs in
>> these files.
>>
>> For example, in sock_recv_errqueue, it invokes put_cmsg without check,
>> and kfree_skb anyway. In this case, if put_cmsg fails, we will lose the
>> information forever. I find cases where sock_recv_errqueue is used for
>> TX_TIMESTAMP. Maybe loss for timestamp is okay?
>>
>> However, I find that sock_recv_errqueue is also used in rds_recvmsg to
>> receive the zc notifications for rds socket. The zc notification could
>> also be lost forever in this case?
>>
>> Not sure if anyone knows the reason why there is no failure check for
>> put_cmsg in net/socket.c and sock.c?
>>
> 
> I don't know to be honest. I think it's fine for the put_cmsg() to
> fail and the notification to be delivered later. However I'm not sure
> it's OK for the notification to be lost permanently because of an
> error?
> 
> For timestamp I can see it not being a big deal if the notification is
> lost. For ZC notifications, I think the normal flow is that the
> application holds onto the TX buffer until it receives the
> notification. If the notification is lost because of an error,
> wouldn't that cause a permanent memory leak in the application?
> 
> My humble opinion is try as much as possible to either fully deliver
> the notification or to save the notification for a future syscall, but
> not to lose it. But, I see that no other reviewers are calling this
> out, so maybe it's not a big deal and you shouldn't change anything.
> 

Agree, in ZC notification case, saving the notification for a future 
syscall is better than losing it forever. The difficulties I am aware of
are as follows,

If we find put_cmsg fails in
sendmsg_copy_cmsg_to_user, we have reached the end of ____sys_sendmsg,

1. Since the skb which carries the zc information has been freed from 
the errqueue. To roll back the effect, we need to sock_omalloc an skb
and insert it back. Or, we can store the information somewhere, but I
assume we need to allocate some memory, if the allocation fails, we may
still lose the info? Shall we make sure the allocation succeeds?

2. Currently, we free the skb in the hanlder of SCM_ZC_NOTIF, can we
free it after we are sure that put_cmsg succeed? One blocking I can
think of is that because of notification coalescing, the
information in the skb might be updated, since we snapshot the 
information earlier, so the information we copy to user might be
outdated. And, we also need a post handler for this cmsg_type, in
sendmsg_copy_cmsg_to_user.

3. The above is the specific unrolling/post handling logic for 
SCM_ZC_NOTIF. Each cmsg_type, which needs to be copied back could have
their own logic, we may add a function to handle it according to
cmsg_type. And call this function in sendmsg_copy_cmsg_to_user, to make
the code generic.

So besides ABI change, this is another problem we have for this
mechanism. These two concerns make our alternative usr_addr method(v4)
shine. In v4, users pass in a user address which points to a
zc_info_elem array. In the handler of SCM_ZC_NOTIF, we do copy to user
to that usr_addr. If it fails, in the context of the handler, the
unrolling is very clean and easy. The problem with this method is that
it makes the API of msg_control hacky.

Thanks for pointing this out, more comments are welcome!

>>> This may be a lack of knowledge on my part, but i'm very confused that
>>> msg_control_copy_to_user is set to false here, and then checked below, and it's
>>> not touched in between. How could it evaluate to true below? Is it because something
>>> overwrites the value in msg_sys between this set and the check?
>>>
>>> If something is overwriting it, is the initialization to false necessary?
>>> I don't see other fields of msg_sys initialized this way.
>>>
>>
>> ```
>> msg_sys->msg_control_copy_to_user = false;
>> ...
>> err = __sock_sendmsg(sock, msg_sys); -> __sock_cmsg_send
>> ...
>> if (msg && msg_sys->msg_control_copy_to_user && err >= 0)
>> ```
>>
>> The msg_control_copy_to_user maybe updated by the cmsg handler in
>> the function __sock_cmsg_send. In patch 2/3, we have
>> msg_control_copy_to_user updated to true in SCM_ZC_NOTIFICATION
>> handler.
>>
>> As for the initialization,
>>
>> msg_sys is allocated from the kernel stack, if we don't initialize
>> it to false, it might be randomly true, even though there is no
>> cmsg wants to be copied back.
>>
>> Why is there only one initialization here? The existing bit
>> msg_control_is_user only get initialized where the following code
>> path will use it. msg_control_is_user is initialized in multiple
>> locations in net/socket.c. However, In function hidp_send_frame,
>> msg_control_is_user is not initialized, because the following path will
>> not use this bit.
>>
>> We only initialize msg_control_copy_to_user in function
>> ____sys_sendmsg, because only in this function will we check this bit.
>>
>> If the initialization here makes people confused, I will add some docs.
>>
> 
> Thanks for the explanation. This looks correct to me now, no need to
> add docs. I just missed the intention.
> 

No problem, my pleasure.

>>>>
>>>>       if (msg_sys->msg_controllen > INT_MAX)
>>>>               goto out;
>>>> @@ -2594,6 +2630,14 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>>>>                              used_address->name_len);
>>>>       }
>>>>
>>>> +    if (msg && msg_sys->msg_control_copy_to_user && err >= 0) {
>>>> +            ssize_t len = err;
>>>> +
>>>> +            err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
>>>> +            if (!err)
>>>> +                    err = len;
>>>
>>> I'm a bit surprised there isn't any cleanup here if copying the cmsg to user
>>> fails. It seems that that __sock_sendmsg() is executed, then if we fail here,
>>> we just return an error without unrolling what __sock_sendmsg() did. Why is
>>> this ok?
>>>
>>> Should sendmsg_copy_cmsg_to_user() be done before __sock_sendms() with a goto
>>> out if it fails?
>>>
>>
>> I did this refering to ____sys_recvmsg, in this function, if __put_user
>> fails, we do not unroll what sock_recvmsg did, and return the error code
>> of __put_user.
>>
>> Before __sock_sendmsg, the content of msg_control is not updated by the
>> function __sock_cmsg_send, so sendmsg_copy_cmsg_to_user at this time
>> might be not expected.
>>
> 
> I see. I don't think sendmsg_copy_cmsg_to_user() should unroll
> __sock_sendmsg(), but if possible for the notification not to be lost,
> I think that would be an improvement.
> 

