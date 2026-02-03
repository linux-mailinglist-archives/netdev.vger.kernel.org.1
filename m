Return-Path: <netdev+bounces-256333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHoFDhgOgmkKOwMAu9opvQ
	(envelope-from <netdev+bounces-256333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:02:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B5DAFD9
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCEE3307F68F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FB38E5C6;
	Tue,  3 Feb 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJQVC2wr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1733A784F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130724; cv=none; b=qB4EvLYA4T/MYlkHKafyA3mwsU0nAwydL52hnt5f5DL9IPRlnNGSp8YiXAePfJDOAKoGLgBYAI18WJ3yIwg391FqeaU5geO7mupFXsjfKX7qHuwwD2PaeNkljqFTtNyp/LibPat/ZPC89fp+HSCfbQNeP7d5qc3v1U84F/+48oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130724; c=relaxed/simple;
	bh=G6sa+2YZ597NFSVHiw6WzB4kVFZwKiuRWrshyaYjAfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnAkfRE4rVU0oQpMFyrY0PyPvxcTnEhK//iWqIHfu8fIyF1SW3H3ukCfvoY1G0F6lldhnoJ6/fe7qauB1dlPxLZusIK9F0Gcsp6q0IebzI5DQ8m8/gtwrvqUVhWFFkSCqujIYMlx0LGiPK62PLKAFpJkoc7PGiNcgqJyseyvCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJQVC2wr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so76748095e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770130721; x=1770735521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGcHt2rnUGP7s9STaZffTmGOdK/vvExcYLLKEndwU9M=;
        b=ZJQVC2wrBkNm+qHXBwe4rBtmETPU5ZhPA3j0zLt6oHQekvx0kZL9RmEJK4E5WuA2pl
         K/2Bw2KKeuiKaW8foc91Aij2ThG4qHuRffU6PeAFHRArnMZlFeG0XeyDRTpk2K7Ftf9E
         7S/t4nAbljLkEibDMB/oZLnsN3kPZNJYv4CcR0iAnGkl40eSO4An++vMz5xh4F74ZgUw
         RkFvZQLPd+B1rCzB2/Kk7HcSG/gL9g92dwmWUJ/y0jNy3WT7eiXgG/Upv0LF6Xg4iwad
         +oWDT21lU9uRMZyUB+4ZPKocSaBFvnjfp3dV+SvAYcSKnpUSS4kTNmORG+DRNUExOAYZ
         Q+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130721; x=1770735521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGcHt2rnUGP7s9STaZffTmGOdK/vvExcYLLKEndwU9M=;
        b=NkGXL1KIKscdmvzrtmHLHE6F3nwAJP7X5z9k3kXepBxD/DPVmmJtMQ1BTjGyZHEdnk
         vQm4z9pVZnC3uJdB0623TS0zE7EJZNRSpPoe4c0BoQ8yLNnfSBQ8wdRl6QJbEsvtSiqs
         Uhm+5S/wyL+uT9XPZK0Z/uEvMz+lLUKI6DU8tzTZ97TAj7t4il8w/IPG1UEKmZShyCtO
         9q43Cz1Stn7PmGZNk+b/ytuFBpip6f22pHlWsTvLBTdx06BmNr4Q88q7gYcLdaa2845G
         lihw0+3QZYu+ioGRtlnhhxYAiMxd4AFL6S+dwXp3DQ098EVo3YGcbTjbdUsoyFN7gnvL
         2RvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6GpX6j22YBbfjhsEXNf/y+xcRpwL7IAHHBodY+Xpe/hqg8Bu3YP0draVKqrtvlM26ogH7eFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIK0JaC9OM6k8GtuN641Hj70iqARSqnAipwoXxoRt70hLn1Pi
	B2UMDJg5s8e/eA+edflI3YpR9CJP/w9JQAn1la7Mp0TVatgbWNXeQmIz
X-Gm-Gg: AZuq6aKl6DtjYhglADziCzbJVwyrLjRWkSV05qh0vM9RXerPpNArulAUsZwcG+Sf44/
	Gz39uUGjf9QSy8ufZsvcDpCMwKa/ti4wAR+5Knvx2OKV390yaC5tO5NZB5bruvADKgxNOSkI8gl
	lc+901qJEbcbMVKLuoR7zWOxIKGTEHt/10piNSmfF/93aNZn/DiZIZJwF8Ib4LOdRJiaAFTt7Je
	KxWBpEm4VdrjC6Ph2hTwUhi5RKN5XjiRyvTnDpd4yoeTIG8hvA3f/AWqgtUD1i6gaz059xpLCmz
	p04HtGeQtPvQVq81RYwVZ+PTMiHevrlC09YKJG509Yz5hvhoCXBsBOo0YEo+Y2fPB+v1tXGafDz
	jMjSK7VARoy4la+jaEejoPL9tA9OqeZaWxVBIqffCPBSY3is7BoEHjODPc9oIZN8cgwlrE6FObQ
	p9c8adyUImMYIp+zjTbKJYqNq5AovLjx7Q53w=
X-Received: by 2002:a05:6000:2c01:b0:435:e460:235b with SMTP id ffacd0b85a97d-435f3ab32acmr21161898f8f.59.1770130720657;
        Tue, 03 Feb 2026 06:58:40 -0800 (PST)
Received: from [10.221.207.115] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm50721584f8f.34.2026.02.03.06.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:58:40 -0800 (PST)
Message-ID: <aa78345a-bdb6-4dd9-9db2-3599585f1553@gmail.com>
Date: Tue, 3 Feb 2026 16:58:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Undo saving per-channel async ICOSQ
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: William Tu <witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Gal Pressman <gal@nvidia.com>
References: <20260123223916.361295-1-daniel@iogearbox.net>
 <85776531-d5fa-4762-90aa-74c8397dc09b@gmail.com>
 <6188b9f5-ce38-4de9-80b7-c7b1cab48595@iogearbox.net>
 <421d9b09-a157-4f95-8775-7883ea097038@gmail.com>
 <2a3bd098-0d88-4c11-8ac3-7b13f8bbbd9f@iogearbox.net>
 <ae18245c-e4f6-414a-b8d2-de18824c3861@app.fastmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ae18245c-e4f6-414a-b8d2-de18824c3861@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C32B5DAFD9
X-Rspamd-Action: no action



On 03/02/2026 11:20, Alice Mikityanska wrote:
> On Mon, Feb 2, 2026, at 18:13, Daniel Borkmann wrote:
>> Hi Tariq,
>>
>> On 2/1/26 1:50 PM, Tariq Toukan wrote:
>>> On 26/01/2026 11:23, Daniel Borkmann wrote:
>>>> On 1/25/26 9:33 AM, Tariq Toukan wrote:
>>>>> On 24/01/2026 0:39, Daniel Borkmann wrote:
>>>>>> This reverts the following commits:
>>>>>>
>>>>>>     - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock into ICOSQ struct")
>>>>>>     - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
>>>>>>     - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dynamic allocation")
>>>>>>     - abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
>>>>>>
>>>>>> There are a couple of regressions on the xsk side I ran into:
>>>>>>
>>>>>> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an RCU read-
>>>>>> side critical section via mlx5e_xsk_wakeup() -> mlx5e_trigger_napi_icosq()
>>>>>> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll().
>>>>>>
>>>>>> Additionally, this also hits a NULL pointer dereference in mlx5e_xsk_wakeup():
>>>>>>
>>>>>>     [  103.963735] BUG: kernel NULL pointer dereference, address: 0000000000000240
>>>>>>     [  103.963743] #PF: supervisor read access in kernel mode
>>>>>>     [  103.963746] #PF: error_code(0x0000) - not-present page
>>>>>>     [  103.963749] PGD 0 P4D 0
>>>>>>     [  103.963752] Oops: Oops: 0000 [#1] SMP
>>>>>>     [  103.963756] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not tainted 6.19.0-rc5+ #229 PREEMPT(none)
>>>>>>     [  103.963761] Hardware name: [...]
>>>>>>     [  103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]
>>>>>>
>>>>>> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wakeup()
>>>>>> and therefore access to c->async_icosq->state triggers it. (On the NIC
>>>>>> there is an XDP program installed by the control plane where traffic
>>>>>> gets redirected into an xsk map - there was no xsk pool set up yet.
>>>>>> At some later time a xsk pool is set up and the related xsk socket is
>>>>>> added to the xsk map of the XDP program.)
>>>>>
>>>>> Thanks for your report.
>>>>>
>>>>>> Reverting the series fixes the problems again.
>>>>>
>>>>> Revert is too aggressive here. A fix is preferable.
>>>>> We're investigating the issue in order to fix it.
>>>>> We'll update.
>>>> Ok, sounds good. Certainly the kTLS fixes seem independent, from the cause
>>>> of the issues I've hit it just seemed to me that they were quite fundamental
>>>> and that perhaps a different approach would be needed (or alternatively only
>>>> kTLS would need fixing, and the xsk optimization left as it was originally).
>>>> Anyway, I'll keep the revert locally for now, and happy to test patches.
>>>
>>> Please check attached patch.
> 
> Hi Tariq,
> 
> I also took a glance at the patch: that seems to be correct in XSK parts, and mlx5e_trigger_napi_icosq now makes sense to me after your explanation. 

Great.

> Two small comments though:
> 
> 1. I'd prefer DEBUG_NET_WARN_ON_ONCE instead of WARN_ON. At least XSK wakeup is a hot path, called frequently, so we don't want to flood dmesg with the same error, and it would be better to compile out the check in non-debug builds, hence DEBUG_NET_WARN_ON_ONCE.
> 

I tend to totally drop this check.

> 2. I see you changed the condition of creating async_icosq to be created when any xdp_prog is attached, even when there are no XSK pools. Is there a case where async_icosq is useful with plain XDP without XSK? If not, I believe this condition should be XDP && XSK.
> 

You're right.
As you know, the channels are not re-opened on XSK pool events.
They are re-opened on XDP program attach/detach.

Hence, as a simple and quick fix, we will check for XDP program and 
create the async ICOSQ accordingly.
Currently we won't have create/destroy async ICOSQ when XSK pool is 
activated/deactivated. I will mention this in the commit message.

This still prevents the async ICOSQ creation in default.

> Thanks,
> Alice
> 


>>> We were able to repro the issues internally and verify the fix.
>>> We're finalizing it before submission.
>>>
>>> I'd be glad if you can confirm it solves the issues for you.
>> That seems to work for me, yes. Feel free to add my Tested-by.
>>
>> Thanks,
>> Daniel


