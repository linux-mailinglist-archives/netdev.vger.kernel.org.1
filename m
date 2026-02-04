Return-Path: <netdev+bounces-256592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGjzOCTlgmnXeAMAu9opvQ
	(envelope-from <netdev+bounces-256592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 07:20:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C9E246B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 07:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE040300F120
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 06:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4337C113;
	Wed,  4 Feb 2026 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+T6z1Fx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D620DD51
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186017; cv=none; b=f0Gn6snuNS5JbqjermPA0cUqRNAo3QTdInnHC7XOyEUHe8soNvCLRddPHsFSnvWkkMkKQGIN/lKBdYSjDLVD4X/T4fA4IafVUG/4vNkbGfY/Sv3kghzhRvdRw0SluKefxDGMk7jz9qkzfrW01gnoFSIXNYuD7zXiGBwrg/mz2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186017; c=relaxed/simple;
	bh=rOWpNiQG4UmcSP34ZAePYE+b4Jm0ZqxupPtjhUQQn0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc3i1PUAO5kQbm6HOgTHKHGop0AlE33YlKsR6m6K/apNUc/64owmN+mgvKPgxXhFH237ZGdBdCoPTPxFm/2n7Up0T/ox1TIHX45e9dlvPGtNupxOTGRKVJC/73qfeqok0oD/bLN8Hjs73NgWS7z7CkdrC7Gie1Zt2PsO8DXn9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+T6z1Fx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359108fd24so184195f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 22:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770186015; x=1770790815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf4hdFEzmH13IzCRYQqo8LgcKjYgw5KgSvvD+W/m134=;
        b=S+T6z1FxjmHAIPqR2HJGMiCJRG0S4IZ26P03bBcz489yj9X0+KxjlBizX50YIiD11S
         sSiLM635vmcVuVuaQIuk+e4f2Imse9YnWpc4aE3CNe5viDWZkqImGkBXBPMFtfdGXzdp
         ifmYIREuHhGcAQLi7mGNiU//k7yBoIJ96XO6tidKUso5TLNRYDO90fqWE9KCCEdqkfPi
         YBUfRSa36xo3Q0rdbOQ6J1gHr3Ceza1qvC3N+jJBYS/bdp3FMDxMQkbwnS3LJlRXpvZK
         +RG8TDYiUdp1rPXqCW749xOcLc8P81sVsxQhVoIE31VVDQ+yud9YaczkMrtZta+EIe4R
         FVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770186015; x=1770790815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bf4hdFEzmH13IzCRYQqo8LgcKjYgw5KgSvvD+W/m134=;
        b=dEbtWmTAIIuB8e1oAio+QSFijS4jldpAKbbhg2Fzt4sxtkOLrRTSOuNY/j8sDRrUid
         u+A35LcZ2CFVAN2C8/Qa8kR7NHR4g92LrHbueh3DHaVe71gSuzrcArOhRnie87NioDnG
         CE8yQuuQDbA5hfH2q0LXqoaOSCSIqhNR96ssJOYlxJ16cK/dXgnaNe9FM5HMvLAVoMaF
         cGRgkaniguzNRb8eD+3bCk1+FP67pfdyfgmIViEpCJuI9yPuf6nD3JyeCIhTM6+ZCN6t
         vKG6O5UZeTFhFKJmXGRChGP4rwPbiCpTUzGr46ziBmvByQN80WzS8WMWFjwg70QMH1iD
         WqDA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Oxq5ZAln83tbRWeVEmFDxb+G1VrQyuHA+7eJQXbzQ75GkkUX3ef0RoOsUUCYnV+Ikw4FeKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Svn4vBH6ng6dTd9eC1vsRmRXqdsmPVYT49N8fAkeeImfJ8Oq
	oDukDnOqtT6ah1rzUmnCmWI7Z3rKjb3KGde1dZXNMveQ63k+mlMnMjQ2JYXDtA==
X-Gm-Gg: AZuq6aJ8vpP0oyY/lWIeA0RtZw+tx0RDlkw/+0hzpGcaF4kPHPlFZAfNL2VOKgy6q1r
	OKY+ZCCgZ7Q5Zy9MKMyLXXO71oTERVKlNyEOURX0WcFB8XBtFK1tcQBGIDBwPULL6qkpRtrfKfy
	xLJMnjzsPq3z9+uIuxWe/RlRytLDRL7Y6KIXPYc1POgaE6pipTW+f7Vts+1l3/M2r54zIAaupAk
	aR+1Rd4c3SoSWgmSxuHFYhyZ2VvX7fugm2BA2hrq2xfeZc2URjSKVwoYHjasbslrvvdQJpRofJd
	vMkxtOJ3Dsqz282y8faIDn5r59XgVXjgAbDj3PexrNVJBaosHZjuLux4MOgbgG5d7vXvYDw+azd
	18PkR884ARGBGVxZvzDVszo0V1HNPsmhZYJ8gPixY0kL4RCoOHNXnJ1w1a2/jWxe4EFrYpgQamF
	5LzBrSFijd5R+5btmpXuI55bV1WPXk
X-Received: by 2002:a05:6000:40d9:b0:435:a370:2d7a with SMTP id ffacd0b85a97d-43618053444mr2378362f8f.36.1770186014618;
        Tue, 03 Feb 2026 22:20:14 -0800 (PST)
Received: from [10.80.1.200] ([72.25.96.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618064844sm3770597f8f.42.2026.02.03.22.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 22:20:14 -0800 (PST)
Message-ID: <8a3a3ff4-16c7-4d99-8854-38d741cc6b82@gmail.com>
Date: Wed, 4 Feb 2026 08:20:14 +0200
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
 <aa78345a-bdb6-4dd9-9db2-3599585f1553@gmail.com>
 <cb1fc819-f761-4d25-8c49-674d72462f95@app.fastmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <cb1fc819-f761-4d25-8c49-674d72462f95@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256592-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 908C9E246B
X-Rspamd-Action: no action



On 03/02/2026 19:54, Alice Mikityanska wrote:
> On Tue, Feb 3, 2026, at 16:58, Tariq Toukan wrote:
>> On 03/02/2026 11:20, Alice Mikityanska wrote:
>>> On Mon, Feb 2, 2026, at 18:13, Daniel Borkmann wrote:
>>>> Hi Tariq,
>>>>
>>>> On 2/1/26 1:50 PM, Tariq Toukan wrote:
>>>>> On 26/01/2026 11:23, Daniel Borkmann wrote:
>>>>>> On 1/25/26 9:33 AM, Tariq Toukan wrote:
>>>>>>> On 24/01/2026 0:39, Daniel Borkmann wrote:
>>>>>>>> This reverts the following commits:
>>>>>>>>
>>>>>>>>      - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock into ICOSQ struct")
>>>>>>>>      - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
>>>>>>>>      - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dynamic allocation")
>>>>>>>>      - abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
>>>>>>>>
>>>>>>>> There are a couple of regressions on the xsk side I ran into:
>>>>>>>>
>>>>>>>> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an RCU read-
>>>>>>>> side critical section via mlx5e_xsk_wakeup() -> mlx5e_trigger_napi_icosq()
>>>>>>>> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll().
>>>>>>>>
>>>>>>>> Additionally, this also hits a NULL pointer dereference in mlx5e_xsk_wakeup():
>>>>>>>>
>>>>>>>>      [  103.963735] BUG: kernel NULL pointer dereference, address: 0000000000000240
>>>>>>>>      [  103.963743] #PF: supervisor read access in kernel mode
>>>>>>>>      [  103.963746] #PF: error_code(0x0000) - not-present page
>>>>>>>>      [  103.963749] PGD 0 P4D 0
>>>>>>>>      [  103.963752] Oops: Oops: 0000 [#1] SMP
>>>>>>>>      [  103.963756] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not tainted 6.19.0-rc5+ #229 PREEMPT(none)
>>>>>>>>      [  103.963761] Hardware name: [...]
>>>>>>>>      [  103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]
>>>>>>>>
>>>>>>>> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wakeup()
>>>>>>>> and therefore access to c->async_icosq->state triggers it. (On the NIC
>>>>>>>> there is an XDP program installed by the control plane where traffic
>>>>>>>> gets redirected into an xsk map - there was no xsk pool set up yet.
>>>>>>>> At some later time a xsk pool is set up and the related xsk socket is
>>>>>>>> added to the xsk map of the XDP program.)
>>>>>>>
>>>>>>> Thanks for your report.
>>>>>>>
>>>>>>>> Reverting the series fixes the problems again.
>>>>>>>
>>>>>>> Revert is too aggressive here. A fix is preferable.
>>>>>>> We're investigating the issue in order to fix it.
>>>>>>> We'll update.
>>>>>> Ok, sounds good. Certainly the kTLS fixes seem independent, from the cause
>>>>>> of the issues I've hit it just seemed to me that they were quite fundamental
>>>>>> and that perhaps a different approach would be needed (or alternatively only
>>>>>> kTLS would need fixing, and the xsk optimization left as it was originally).
>>>>>> Anyway, I'll keep the revert locally for now, and happy to test patches.
>>>>>
>>>>> Please check attached patch.
>>>
>>> Hi Tariq,
>>>
>>> I also took a glance at the patch: that seems to be correct in XSK parts, and mlx5e_trigger_napi_icosq now makes sense to me after your explanation.
>>
>> Great.
>>
>>> Two small comments though:
>>>
>>> 1. I'd prefer DEBUG_NET_WARN_ON_ONCE instead of WARN_ON. At least XSK wakeup is a hot path, called frequently, so we don't want to flood dmesg with the same error, and it would be better to compile out the check in non-debug builds, hence DEBUG_NET_WARN_ON_ONCE.
>>>
>>
>> I tend to totally drop this check.
>>
>>> 2. I see you changed the condition of creating async_icosq to be created when any xdp_prog is attached, even when there are no XSK pools. Is there a case where async_icosq is useful with plain XDP without XSK? If not, I believe this condition should be XDP && XSK.
>>>
>>
>> You're right.
>> As you know, the channels are not re-opened on XSK pool events.
>> They are re-opened on XDP program attach/detach.
> 
> Ah, that's right, I see. I didn't pay attention to where the check is
> located. If you reorganize the code a little bit, it's possible to
> implement the perfect check (XDP && XSK) || kTLS_RX, to avoid creating
> the unneeded async_icosq with plain XDP.
> 

Right, but I won't do it here as a fix.

> (BTW, I see that ktls_rx_was_enabled is never reset to false: is it
> because we can't reliably fence the moment when the driver stops using
> it?)
> 

Offload feature can be disabled but offloaded connections can stay alive 
until they're closed.
It is possible to track them and reset ktls_rx_was_enabled to false, but 
it's currently not implemented.

> Anyway, it's up to you if you'd like to do it or not, but here is my
> suggestion. We don't have to create async_icosq in mlx5e_open_queues.
> Similar to how we separated mlx5e_open_xsk, we can separate
> mlx5e_open_async_icosq, which is where we can check (XDP && XSK) ||
> kTLS_RX.
> 
> Then mlx5e_open_channel will look like:
> 
> mlx5e_open_queues();
> mlx5e_open_async_icosq(); // Checks the condition internally
> if (xsk_pool)
>          mlx5e_open_xsk();
> 
> mlx5e_xsk_enable_locked will also call mlx5e_open_async_icosq just
> before mlx5e_open_xsk.
> 
> mlx5e_close_async_icosq will close it if it exists.
> 
> With this design, all cases are covered: every mlx5e_open_xsk is paired
> with mlx5e_open_async_icosq; and kTLS RX enable flow reopens channels,
> which also triggers mlx5e_open_async_icosq. The conditional is DRYed in
> mlx5e_open_async_icosq itself, so no code repetition either.
> 

Right, it would work, and save the async icosq creation for the case 
(XDP && !XSK).
I prefer to implement this change as a followup, and keep this fix simple.

>> Hence, as a simple and quick fix, we will check for XDP program and
>> create the async ICOSQ accordingly.
>> Currently we won't have create/destroy async ICOSQ when XSK pool is
>> activated/deactivated. I will mention this in the commit message.
>>
>> This still prevents the async ICOSQ creation in default.
>>
>>> Thanks,
>>> Alice
>>>
>>
>>
>>>>> We were able to repro the issues internally and verify the fix.
>>>>> We're finalizing it before submission.
>>>>>
>>>>> I'd be glad if you can confirm it solves the issues for you.
>>>> That seems to work for me, yes. Feel free to add my Tested-by.
>>>>
>>>> Thanks,
>>>> Daniel


