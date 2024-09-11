Return-Path: <netdev+bounces-127257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58CB974C5C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A1D28245C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFED15380B;
	Wed, 11 Sep 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFP0pnT4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7414D6EE;
	Wed, 11 Sep 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042646; cv=none; b=n4h50ZbxSdLsclOR600/2TWC1z7xt1I+JZhr4CB285Fa/y7WQtybH3LRWTBMTWAU4XW2MwkNyCunHA8SAvA87POyokCLFhAWDTWhSqQSg2m/LmDEHZwy6572aZfYS3URut/xY7nP4NzW2ThxnR4TSfpAXuR1zYmoxDsUZoALu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042646; c=relaxed/simple;
	bh=LAnhnqSJorMXdmlXOE4uW9NRjVDEJin07Zgq4Qrj4/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9cB2NxT1Ky8J7csLdnW/rtSt8BozHNuIwZ4m74oT9O5ayBM2EEah8wCrFV3nAaKAC+ihd/iBGeSdnd6yPOVldV13iIWH9g4esQ+Fi6Q8MXNTWUKwRhrYr85WBI9sYLIYLy/UoVYKELYolWfmux9UkjFVLTeYDmnNQQTHu+Tpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFP0pnT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9861DC4CECC;
	Wed, 11 Sep 2024 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726042646;
	bh=LAnhnqSJorMXdmlXOE4uW9NRjVDEJin07Zgq4Qrj4/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XFP0pnT4VJeRIX3mVVC4UHG1EUeNQYTrWLuYWnG+6G+gs49WhmbZI2ejx93VeXE+R
	 ynqkpxcgIak6oGU5MsT8tpxb6ACnUM2+FKWTSr1nRKdTbiUHoUVmZTy/ZpvS3yCeFQ
	 qcEg2IxbPOAC1eAk0Rj3daz2Pkgi7yyFeHsYhlYeiE/q0va9WJaoQhO73t2da+HDWL
	 Z9CC52ixz/K2N2fBvCSwOhqq0TauPMjL1DL2NdeQlDknxj19IR60n2p/DNpvo/IZaE
	 ZaV4BgExi47uYX3DTEEAebXHzSM7C/szirJvciKAAXEVO4HdM16RPnMq53CaUHxo2W
	 U8q1REGq0IAZQ==
Message-ID: <fb706667-c907-4d9d-a37d-8ad68b26e2bd@kernel.org>
Date: Wed, 11 Sep 2024 10:17:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [Patch net] mptcp: initialize sock lock with its own lockdep keys
Content-Language: en-GB
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Cong Wang <cong.wang@bytedance.com>,
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
 <c332e3f8-3758-43ce-87a7-f1290d9692bc@kernel.org>
 <ZuEPsZ3yrLqHNRUt@pop-os.localdomain>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZuEPsZ3yrLqHNRUt@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Cong Wang,

On 11/09/2024 05:34, Cong Wang wrote:
> On Mon, Sep 09, 2024 at 05:03:32PM +0200, Matthieu Baerts wrote:
>> Hi Cong Wang,
>>
>> On 08/09/2024 20:06, Cong Wang wrote:
>>> From: Cong Wang <cong.wang@bytedance.com>
>>>
>>> In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
>>> lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
>>> at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.
>>>
>>> As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
>>> sk_clone_lock() immediately locks the new sock after preliminary
>>> initialization. To fix that, introduce ->init_clone() for struct proto
>>> and call it right after the sock_lock_init(), so now mptcp sock could
>>> initialize the sock lock again with its own lockdep keys.
>>
>> Thank you for this patch!
>>
>> The fix looks good to me, but I need to double-check if we can avoid
>> modifying the proto structure. Here is a first review.
>>
>>
>> From what I understand, it looks like syzbot reported a lockdep false
>> positive issue, right? In this case, can you clearly mention that in the
>> commit message, to avoid misinterpretations?
>>
>>> Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
>>
>> checkpatch.pl reports that "Reported-by: should be immediately followed
>> by Closes: with a URL to the report".
> 
> Sure, didn't know this is helpful.

It is useful for the reviewers/devs to find more info about the issue,
and for other bots to mark a bug report as closed.

>> Also, even if it is a false positive, it sounds better to consider this
>> as a fix, to avoid having new bug reports about that. In this case, can
>> you please add a "Fixes: <commit>" tag and a "Cc: stable" tag here please?
> 
> I intended not to provide one because I don't think this needs to go to
> -stable, it only fixes a lockdep warning instead of a real deadlock.
> Please let me know if you prefer to target -stable.

Yes, it is useful. Because if it is not backported, it is likely we will
get this bug report again with stable versions. And such bug reports are
always taking time to analyse.

(...)

>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 9abc4fe25953..747d7e479d69 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
>>>  	}
>>>  	sk_node_init(&newsk->sk_node);
>>>  	sock_lock_init(newsk);
>>> +	if (prot->init_clone)
>>> +		prot->init_clone(newsk);
>>
>> If the idea is to introduce a new ->init_clone(), should it not be
>> called ->lock_init() (or ->init_lock()) and replace the call to
>> sock_lock_init() when defined?
> 
> 'lock_init' or 'init_lock' reads like we are initalizing a lock. :)

If it is replacing sock_lock_init() call when ->init_lock is defined, it
will be about initializing a lock ;)

Thank you for the v2 (in MPTCP ML), I will continue the reviews there.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


