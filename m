Return-Path: <netdev+bounces-55140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE880988E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630FF1F210D4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F16E110A;
	Fri,  8 Dec 2023 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQA1vPec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149981102
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 01:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4A0C433C8;
	Fri,  8 Dec 2023 01:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701998620;
	bh=DRoQgWVhITeKBmmdIVUFBoNfGOIPLUltIyJCH5nctoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQA1vPecIseO96rxDxDK9zdRxQZbdKTaO6l9XezncGCOWgOgh3d6k/JoUKUFBN/Nb
	 mxaYO/ElKAd0UadoRiV+ojgVYAk+BrdsdfY6cUYpkC/OCs93vcdD4+agPkDw3fkj/4
	 a3gF/K7Q+CzQiCXZJVzGtrCzeo6oKXPCKikHmJOb3w2oQaLEz7YCCIFav+tVp0ygZ4
	 e3vp0M/DafDY8X/bJtfyGtpE1lkt/LZHENfTplWc5MY1hJGv9HrlnihUSkGUBOZtNp
	 G8eLFxQyeCxx2+TWSf9f0cPokPkMtVNDcm6XTptP2cMliiyvjH1DBqu4S2vVRFuUI4
	 IVNxNgw9YWdPg==
Message-ID: <3d9f78ff-15b4-4c66-a007-a82e4be6d510@kernel.org>
Date: Thu, 7 Dec 2023 18:23:39 -0700
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
 <b6fccc0d-c60b-4f11-9ef7-25b01c25425d@kernel.org>
 <b0fe3183-4df9-42bc-84e4-ba8e807318f4@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b0fe3183-4df9-42bc-84e4-ba8e807318f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/7/23 6:16 PM, Kui-Feng Lee wrote:
> 
> 
> On 12/7/23 17:02, David Ahern wrote:
>> On 12/7/23 4:33 PM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 12/7/23 15:20, David Ahern wrote:
>>>> On 12/7/23 4:17 PM, David Ahern wrote:
>>>>> On 12/7/23 3:16 PM, thinker.li@gmail.com wrote:
>>>>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>>>>
>>>>>> Check f6i->fib6_node before inserting a f6i (fib6_info) to
>>>>>> tb6_gc_hlist.
>>>>>
>>>>> any place setting expires should know if the entry is in a table or
>>>>> not.
>>>>>
>>>>> And the syzbot report contains a reproducer, a kernel config and other
>>>>> means to test a patch.
>>>>>
>>>>
>>>> Fundamentally, the set and clear helpers are doing 2 things; they need
>>>> to be split into separate helpers.
>>>
>>> Sorry, I don't follow you.
>>>
>>> There are fib6_set_expires_locked()) and fib6_clean_expires_locked(),
>>> two separate helpers. Is this what you are saying?
>>>
>>> Doing checks of f6i->fib6_node in fib6_set_expires_locked() should
>>> already apply everywhere setting expires, right?
>>>
>>> Do I miss anything?
>>
>> static inline void fib6_set_expires_locked(struct fib6_info *f6i,
>>                                             unsigned long expires)
>> {
>>          struct fib6_table *tb6;
>>
>>          tb6 = f6i->fib6_table;
>>          f6i->expires = expires;
>>          if (tb6 && !fib6_has_expires(f6i))
>>                  hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);

--> no check that f6i is already in the list yet fib6_set_expires and
fib6_set_expires_locked are called on existing entries - entries already
in the tree and so *maybe* already linked. See fib6_add_rt2node and most
of fib6_set_expires callers.

Your selftests only check that entries are removed; it does not check
updating the expires time on an existing entry. It does not check a
route replace that toggles between no expires value or to an expires
(fib6_add_rt2node use of fib6_set_expires_locked) and then replacing
that route -- various permutations here.


>>          f6i->fib6_flags |= RTF_EXPIRES;
>> }
>>
>> 1. You are abusing this helper in create_info to set the value of
>> expires knowing (expecting) tb6 to NOT be set and hence not setting
>> gc_link so no cleanup is needed on errors.
>>
>> 2. You then open code gc_link when adding to the tree.
>>
>> I had my reservations when you sent this patch months ago, but I did not
>> have time to suggest a cleaner approach and now this is where we are --
>> trying to find some race corrupting the list.
> 
> So, what you said is to split fib6_set_expires_locked() into two
> functions. One is setting expires, and the other is adding a f6i to
> tb6_gc_hlist. fib6_clean_expires_locked() should be split in the same
> way.
> 
> Is it correct?
> 

one helper sets expires value and one helper that adds/removes from the
gc_link. If it is already linked, then no need to do it again.

