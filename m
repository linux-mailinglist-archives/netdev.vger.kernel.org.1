Return-Path: <netdev+bounces-256276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAP/AlrqgWkFMAMAu9opvQ
	(envelope-from <netdev+bounces-256276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:30:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D78ED9069
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0160430576A3
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415A342144;
	Tue,  3 Feb 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7jB5I46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19677342CAE
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121814; cv=none; b=ftSRzI1ym+wPhUMgYmqoix0F3kBnZ0s2mRl0Cf4QQ2bGoHoFxLdCvFNV3jA/PlCvZ33AgGzDkK01SxRf2uQPXQqQD+WOwwq0BOINESamKRmuxUKIlTKk2Uq1KabdM2QKfIyyBVu0TvIEzSIkU1dOIeSs+1FFFCy4N/VqYcahxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121814; c=relaxed/simple;
	bh=DvNpsvDjHOGousMp4DkIQZtEWldoexLDjSNwjBGuBPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLWq+ROU6of47tZtv/+iV+DcGrVR/O5enGATIOHxmsOmlmLT0c8tuTtD8caXZUWcZMexQxPC8I5+yeP64JohMShwPteXzqqpOB3lUBjZ5y1PDbV+nCSuI0M5qAKeYSM+N67okNO3IpkKiU61np7Zp9ntkIki3qXPATJF+nhpmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7jB5I46; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so56014715e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 04:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770121811; x=1770726611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mb3hrAjNF4z6/67h17AzLKBdGCEa9ohJ4atwIZ6Fh3w=;
        b=P7jB5I46SPhwJw3ayHFqkfT4Zo74Sz2P4B5gbWbXfZQKz3ROARom6wnjR1lPP3Sdbu
         a9G8THKtNDRoJ3k3yvnIPhN3w88ByII85qIok6a0bQi9aLz2f3KQI+uAwLpIAFRBoM+X
         5Tm6B/QyDEEn5viV/Gxryb+LHnmcAjBOORSykT45LE8NPVTHHyOnbNaT8+rmz/4arp3i
         gMbIZmQCTrPuOvtF/jE9ztPSBgwU7hlVZAUdt/6RLrqGpHiT6MYaZeXAXaJuaulB6HP7
         Rtex8kx8z/YvM/m0dbxM03sY5yV3asO+HvTJsUv1bJHj3uTbEzcDBBtnmMD7DXfOYgz/
         MxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121811; x=1770726611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mb3hrAjNF4z6/67h17AzLKBdGCEa9ohJ4atwIZ6Fh3w=;
        b=WP2YGn+HfTGDK4pciIUSUq2gx8lFhLE2qRWFfu91g0nPUX7jz5kll9SwzSx1m4msFD
         HhXRquNeu8bSdV7h0D3lg8T0CrIHAfMsrPhA5JT+x7lkvJ0JNnif6oFUqXzxl6gssLNQ
         5LSj9kz2lsT8snxdnZK1AfCIq5g1r56oqgnVBj8HEsW8hm1mkBk2KVSVOINJP3Y0a+Hx
         A9hHYCYaVlY9wDNPO8vr7PlY04wemMYY5CMe2mc2Kvx+7XnSh+xkq9RIei9ZNJP+vpsN
         1UXNdV6y71kEqieGL5YYwlQ6z8HKHLXnJEkyQ68WaTq64CJK+gnTy7Asa5S2QKX0gYdP
         kSlg==
X-Forwarded-Encrypted: i=1; AJvYcCUP/7B30uQURiDcOg4XmTLqXlw3+7gM0A/VzddMiioFFTlMKVCzz526YQfn0LSYlJaJAO42xX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISQ4mSTZjn1bTSZMVAZGmOJPS2CwvYU+U8oVdOFQ9oVVpLI+c
	gi2dmkdhlsMcso+9ewqBm/nsWG/geI7JncBFdlapouieRHKAEUHfvZFa
X-Gm-Gg: AZuq6aLBKjFypoUR3P0bg7uLLB1Lj/dz4uYz0jbeD9kR4XnAImYr2voI2/h1052nebG
	gLUf+OFfmg7Uc7OzgtNBUI06D0lUhPE+Z6Ln5Of/63A94gQfa5/+bEb2hxOkLzQQ6zRZKY0ARqB
	1bCe8zzoIo1NS2pBKFhPryGrgtyk11d0ZgEJGjQcGDnNh7nhASCpZSuz1KnZWxrLDh2BJq+LpRA
	k7F8V+NDz2SEVTuZhIWO+I9vKmcUmlRi2xEj+Bdugre+Qef+At0+RQevLUtM60TQSuB8S4q4DDj
	zIc01JqZxdBdB3jXuzLCC5q76M3ieqoiBMSg6gMD6nDUgJYet27MwxpO+RKbaR0RT+ImcCmv/3r
	39u9WlzBYtM+mODLpLFuUXBKwbF1KzJeFcfy3C+kC2XLl+Mi6fcDAUqn/WBml0KilKwtrmB5vbr
	SUfXbHGSEtN5ptFKlEOmq/Be81REGnWbumeK0=
X-Received: by 2002:a05:600c:4f48:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-482db013b90mr233949785e9.0.1770121811137;
        Tue, 03 Feb 2026 04:30:11 -0800 (PST)
Received: from [10.221.207.115] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511cc93sm70917185e9.2.2026.02.03.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:30:10 -0800 (PST)
Message-ID: <b7d310da-a993-4274-bd16-673a58a9625c@gmail.com>
Date: Tue, 3 Feb 2026 14:30:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Undo saving per-channel async ICOSQ
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: William Tu <witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Gal Pressman <gal@nvidia.com>, alice.kernel@fastmail.im
References: <20260123223916.361295-1-daniel@iogearbox.net>
 <85776531-d5fa-4762-90aa-74c8397dc09b@gmail.com>
 <6188b9f5-ce38-4de9-80b7-c7b1cab48595@iogearbox.net>
 <421d9b09-a157-4f95-8775-7883ea097038@gmail.com>
 <2a3bd098-0d88-4c11-8ac3-7b13f8bbbd9f@iogearbox.net>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <2a3bd098-0d88-4c11-8ac3-7b13f8bbbd9f@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,davidwei.uk,kernel.org,fastmail.im];
	TAGGED_FROM(0.00)[bounces-256276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D78ED9069
X-Rspamd-Action: no action



On 02/02/2026 18:13, Daniel Borkmann wrote:
> Hi Tariq,
> 
> On 2/1/26 1:50 PM, Tariq Toukan wrote:
>> On 26/01/2026 11:23, Daniel Borkmann wrote:
>>> On 1/25/26 9:33 AM, Tariq Toukan wrote:
>>>> On 24/01/2026 0:39, Daniel Borkmann wrote:
>>>>> This reverts the following commits:
>>>>>
>>>>>    - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock into ICOSQ 
>>>>> struct")
>>>>>    - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
>>>>>    - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dynamic 
>>>>> allocation")
>>>>>    - abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
>>>>>
>>>>> There are a couple of regressions on the xsk side I ran into:
>>>>>
>>>>> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an RCU 
>>>>> read-
>>>>> side critical section via mlx5e_xsk_wakeup() -> 
>>>>> mlx5e_trigger_napi_icosq()
>>>>> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll().
>>>>>
>>>>> Additionally, this also hits a NULL pointer dereference in 
>>>>> mlx5e_xsk_wakeup():
>>>>>
>>>>>    [  103.963735] BUG: kernel NULL pointer dereference, address: 
>>>>> 0000000000000240
>>>>>    [  103.963743] #PF: supervisor read access in kernel mode
>>>>>    [  103.963746] #PF: error_code(0x0000) - not-present page
>>>>>    [  103.963749] PGD 0 P4D 0
>>>>>    [  103.963752] Oops: Oops: 0000 [#1] SMP
>>>>>    [  103.963756] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not 
>>>>> tainted 6.19.0-rc5+ #229 PREEMPT(none)
>>>>>    [  103.963761] Hardware name: [...]
>>>>>    [  103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]
>>>>>
>>>>> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wakeup()
>>>>> and therefore access to c->async_icosq->state triggers it. (On the NIC
>>>>> there is an XDP program installed by the control plane where traffic
>>>>> gets redirected into an xsk map - there was no xsk pool set up yet.
>>>>> At some later time a xsk pool is set up and the related xsk socket is
>>>>> added to the xsk map of the XDP program.)
>>>>
>>>> Thanks for your report.
>>>>
>>>>> Reverting the series fixes the problems again.
>>>>
>>>> Revert is too aggressive here. A fix is preferable.
>>>> We're investigating the issue in order to fix it.
>>>> We'll update.
>>> Ok, sounds good. Certainly the kTLS fixes seem independent, from the 
>>> cause
>>> of the issues I've hit it just seemed to me that they were quite 
>>> fundamental
>>> and that perhaps a different approach would be needed (or 
>>> alternatively only
>>> kTLS would need fixing, and the xsk optimization left as it was 
>>> originally).
>>> Anyway, I'll keep the revert locally for now, and happy to test patches.
>>
>> Please check attached patch.
>> We were able to repro the issues internally and verify the fix.
>> We're finalizing it before submission.
>>
>> I'd be glad if you can confirm it solves the issues for you.
> That seems to work for me, yes. Feel free to add my Tested-by.
> 
> Thanks,
> Daniel

Great! Thanks for testing it.

