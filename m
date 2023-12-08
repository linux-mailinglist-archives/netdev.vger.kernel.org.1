Return-Path: <netdev+bounces-55136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC5580984E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0EAB20CF0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00985382;
	Fri,  8 Dec 2023 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvRLGoSL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7448653
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 01:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB937C433C7;
	Fri,  8 Dec 2023 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701997356;
	bh=yLXnzAFW3DWBaY9Z0Q9R+MIctjS9VNn5a+x/xfz7Vsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gvRLGoSLdv3UdVU/eNzILowUn2JTMoDnDJOJeebHjaLJ8XWEMjiLrkt/xl86Zm8zw
	 lO9pZm+PsnJ+wmw6A79W/Ng7O4so8+sQcJ3Zup6P7gezYvKUao89bmi0w5iLLJiOWo
	 cbkP+p/MUGRUeXEsHT6zU+OeiSkKrau1iwXU6Ga+chW4ZTzUJn3t5pJqwPECLCNTLW
	 906lBdRMC9UA5Fj2Qzq6+r8FBjPdrWF+LpBmCDu6szeWnBY857CHzc60J7vwnOMSww
	 57oUDeBFGZAYk3VD8sN5BtBm0k4FWYaP2gWLw8JqRCK/3e7uyJH5N1o+WPI1DAc/SD
	 08RJPLtqyl+vQ==
Message-ID: <b6fccc0d-c60b-4f11-9ef7-25b01c25425d@kernel.org>
Date: Thu, 7 Dec 2023 18:02:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: insert the fib6 gc_link of a fib6_info
 only if in fib6.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231207221627.746324-1-thinker.li@gmail.com>
 <8f44514b-f5b4-4fd1-b361-32bb10ed14ad@kernel.org>
 <4eebd408-ee47-4ef0-bb72-0c7abad3eecf@kernel.org>
 <dbccbd5d-8968-43cb-9eca-d19cc12f6515@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <dbccbd5d-8968-43cb-9eca-d19cc12f6515@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 4:33 PM, Kui-Feng Lee wrote:
> 
> 
> On 12/7/23 15:20, David Ahern wrote:
>> On 12/7/23 4:17 PM, David Ahern wrote:
>>> On 12/7/23 3:16 PM, thinker.li@gmail.com wrote:
>>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>>
>>>> Check f6i->fib6_node before inserting a f6i (fib6_info) to
>>>> tb6_gc_hlist.
>>>
>>> any place setting expires should know if the entry is in a table or not.
>>>
>>> And the syzbot report contains a reproducer, a kernel config and other
>>> means to test a patch.
>>>
>>
>> Fundamentally, the set and clear helpers are doing 2 things; they need
>> to be split into separate helpers.
> 
> Sorry, I don't follow you.
> 
> There are fib6_set_expires_locked()) and fib6_clean_expires_locked(),
> two separate helpers. Is this what you are saying?
> 
> Doing checks of f6i->fib6_node in fib6_set_expires_locked() should
> already apply everywhere setting expires, right?
> 
> Do I miss anything?

static inline void fib6_set_expires_locked(struct fib6_info *f6i,
                                           unsigned long expires)
{
        struct fib6_table *tb6;

        tb6 = f6i->fib6_table;
        f6i->expires = expires;
        if (tb6 && !fib6_has_expires(f6i))
                hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
        f6i->fib6_flags |= RTF_EXPIRES;
}

1. You are abusing this helper in create_info to set the value of
expires knowing (expecting) tb6 to NOT be set and hence not setting
gc_link so no cleanup is needed on errors.

2. You then open code gc_link when adding to the tree.

I had my reservations when you sent this patch months ago, but I did not
have time to suggest a cleaner approach and now this is where we are --
trying to find some race corrupting the list.



