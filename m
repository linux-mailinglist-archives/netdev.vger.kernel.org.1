Return-Path: <netdev+bounces-148702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49279E2E93
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4109B161F29
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B91DF968;
	Tue,  3 Dec 2024 22:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B021DF27F
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263286; cv=none; b=onuy6bfBnFKljSiuj8O59NxAttTv33KjthZHSbDcAtAyvQFEKE3Qk+UYwENFvvn2Br/Pbd2gjWyKs5QfHJukopI0ftfqPlKZhAiacjUxzpPItsZEP8zuAXUG0FYsyOGUShEW/FyBoAYLveRgytkV9Jx8sjoww5rmNtXt3Cne1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263286; c=relaxed/simple;
	bh=s9nWFuWBK4E3img9eLtm6rNQeqimwmaXwkN0h87WVVk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ijAcJyubY/b4sIR7sotySW//CzCmGVywY3V9xfzizbq661hc2OlhjqlCYGKaJEidTnXuNgc6x0Ef5tkvPNWOkYep1Fp8GgimN/F7oo+Tom3vywcuzLmbLXbgdwSoObUmu8AEBVheQfJfA7rBekouKNV2jzyW5ci66aV6b+rtw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-aa5366d3b47so971098066b.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 14:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263282; x=1733868082;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVtjrq2CdufPQ1T7cyHHPXuETxGFClK04jWGB9vBAM0=;
        b=XIBAaDCmqFNaoUzTMN6Wm6uGeN6Wdb63rOQ+P5KkHPO+2sacnDj0a/hePxmfrmOhXW
         raI9HFGLcVw+9rMZiruPrca42u9ZuWiA3y0u9sGGrDDLqzK6YYvpszr7l5MGH0VN9z1I
         ECFG5NoWkOZwHbWCZrEv9ovJbbEzdCyuAzJb+lzFrcQvzLBUTEFurxh8IzbbrWJiGhjc
         Ws4wzuw63+n4XvcWiicymxdvyvO/IPxCHWp9YFivKrKBJ0iQ0vpRz+yWYzcqIyiRkFkp
         /5xKHgwNvdf5kVqGIKaWTF5NRSK8ruDeXMRiKEPytMbzOi4GmDMEz76Y8D+sAFnzyRJn
         1kfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+9OvM30ua0Zvf2dk7KSxQvjhBM57IXnWOZC0q4vbXPuBkjycH6ToABU3UVGT77vRJj02Kw+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYksiiAIxEL5tKCQpG5wbjLwOX+FS6B7a3Ow/bU03t60bOmTFQ
	7akAPl/fwiHftYiB/1U5SITWw+dYVJzX1M1Z153MTp9if56+flSWD8+xskLD
X-Gm-Gg: ASbGncvJ68ioCbuSXVQ9l+7H/B6xm34SixMQVWVENOq4+RhbF/0lK/83/sHQaRDSq3R
	Ta9mWOeuMmYcG08suvrCJ4GMamS9c8MLNszVHmYNyXStc6bhUSzeUOA1VEEF55Evo05jI3Sv2vO
	rfJOG3wEk5DW8CnsJfnFm6Uk9hJyhEJLM21yq0vXld+fb+95HsA/585lAAWU6EwKtMmiXkLEm4b
	it7caHeTWWS7sRJSfABIEjj9mqTC/x1rsK5vC+tsCW5wLy0n1F5w4x06cZ2XPKd6FDvAC7+AD/b
	GnflzA==
X-Google-Smtp-Source: AGHT+IGi2zuPp7bzJ9GjUzdmnIR+yzuiMpKoGB+g5znzbWwDygz/yuzhl3skvb0Ii5tvyiWTdwhsjw==
X-Received: by 2002:a17:906:1baa:b0:aa5:1d0f:7295 with SMTP id a640c23a62f3a-aa5f7d1cea4mr353819566b.14.1733263282164;
        Tue, 03 Dec 2024 14:01:22 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e69besm668004066b.124.2024.12.03.14.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 14:01:21 -0800 (PST)
Message-ID: <aa2a710f-d481-4d96-b3fe-358596bbd6f2@ovn.org>
Date: Tue, 3 Dec 2024 23:01:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Dan Streetman <dan.streetman@canonical.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] net: defer final 'struct net' free in netns dismantle
To: Eric Dumazet <edumazet@google.com>
References: <20241203165045.2428360-1-edumazet@google.com>
 <53482ace-71a3-4fa3-a7d3-592311fc3c1b@ovn.org>
 <CANn89iLT6oAA-x+KX=sCAANBZKi1K52gOy-VW0hmofbO3GEhtw@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CANn89iLT6oAA-x+KX=sCAANBZKi1K52gOy-VW0hmofbO3GEhtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/3/24 19:33, Eric Dumazet wrote:
> On Tue, Dec 3, 2024 at 7:23 PM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 12/3/24 17:50, Eric Dumazet wrote:
>>> Ilya reported a slab-use-after-free in dst_destroy [1]
>>>
>>> Issue is in xfrm6_net_init() and xfrm4_net_init() :
>>>
>>> They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
>>>
>>> But net structure might be freed before all the dst callbacks are
>>> called. So when dst_destroy() calls later :
>>>
>>> if (dst->ops->destroy)
>>>     dst->ops->destroy(dst);
>>>
>>> dst->ops points to the old net->xfrm.xfrm[46]_dst_ops, which has been freed.
>>>
>>> See a relevant issue fixed in :
>>>
>>> ac888d58869b ("net: do not delay dst_entries_add() in dst_release()")
>>>
>>> A fix is to queue the 'struct net' to be freed after one
>>> another cleanup_net() round (and existing rcu_barrier())
>>>
>>> [1]
>>
>> <snip>
>>
>> Hi, Eric.  Thanks for the patch!
>>
>> Though I tried to test it by applying directly on top of v6.12 tag, but I got
>> the following UAF shortly after booting the kernel.  Seems like podman service
>> was initializing something and creating namespaces for that.
>>
>> I can try applying the change on top of net tree, if that helps.
>>
>> Best regards, Ilya Maximets.
> 
> Oh right, a llist_for_each_entry_safe() should be better I think.
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 2d98539f378ee4f1a9c0074381a155cff8024da3..70fea7c1a4b0a4fdbd0dd5d5acb7c6d786553996
> 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -448,12 +448,12 @@ static LLIST_HEAD(defer_free_list);
>  static void net_complete_free(void)
>  {
>         struct llist_node *kill_list;
> -       struct net *net;
> +       struct net *net, *next;
> 
>         /* Get the list of namespaces to free from last round. */
>         kill_list = llist_del_all(&defer_free_list);
> 
> -       llist_for_each_entry(net, kill_list, defer_free_list)
> +       llist_for_each_entry_safe(net, next, kill_list, defer_free_list)
>                 kmem_cache_free(net_cachep, net);
> 
>  }

Tried with the above change applied.  With it I see neither of the
use-after-free issues.  So, it seems to be working fine.

So, for the patch + the diff above:

Tested-by: Ilya Maximets <i.maximets@ovn.org>

Note: For some reason I can't boot the 'net/main' kernel (something
about being unable to verify modules, didn't have much time to debug),
so I tested on top of v6.12 tag.

Best regards, Ilya Maximets.

