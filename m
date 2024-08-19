Return-Path: <netdev+bounces-119616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B295658E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FBB1C2137E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C615B0F1;
	Mon, 19 Aug 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="1FKRh0wM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00A1547E6
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055959; cv=none; b=VI+DhlgG1i8DWrtBUcN9AUfVX1gmkPHwWz2o4hYYXnDzB7zE+7Ax6iyas6axLNaD5Q/pUjPwldPdDgubfeTUHlxcgcnWTvC4Tubjzj9x0Hrfd60Aw8AKjVmQYJNR44CQwnEfuZxIECbBSmiR4aUMxYGmPMLf3mq1+d9rIF3fAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055959; c=relaxed/simple;
	bh=/6A+R/LzpojphgmooShzrE2f/ZWIw04lNp2olRlHDwk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K8dL6rueuEDWr+allwzHyfC0ZLoDQVIVWS3cMRRe9BbIRWG2LsWGw6yyjgCMXQLBeEvl89dciwGNrtE4nzcXiG/3Nzmk0RLGY3m4Ec8wOskf7zYsyTJIOLh3wmJN2av5K/e8sIEDVmfIymPHriQ6X9ZAuUrqXI94k7u4QJO701U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=1FKRh0wM; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3cd4ebf84so18853731fa.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724055956; x=1724660756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3dZ9JNVKrIczIdQOUwTD/kNeLo14OlmsykllRpGGtI=;
        b=1FKRh0wMlU8XKXbtOGjK+u1trY9OKDarG94JwYUtEqbDCDIPoaijSm8ifthDbQlWTC
         AAy3YFmeZMDxxq/MLwYH1x8hmnEkLD9ZUEK3Gp29VV7TwFQ8UiTOtlBv7JOzGRp99GmG
         LdJgMNNTGuP1cOuBk5tYaJxKDMDdrDuGGp8Co60gV3omjQcQe/Bfg8EWDkyDa3AKXW2R
         DDWxPJodOuNmfqkmsZDR3EpaWrXNQtOdBV/k33+w0b0yYMXH1XDqkOE9G2tkZXEiPJ3Y
         HGNFO3XyOTVv4IysS9XF9+y3IcJWxWOWt9yn4qz7iBijt5PDYDNNhhGbIglE+cJJ9NqQ
         mcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055956; x=1724660756;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3dZ9JNVKrIczIdQOUwTD/kNeLo14OlmsykllRpGGtI=;
        b=c81Gl/S1HedLIxaCMef/fLlCbZ0I5w01nAyZHHX7desU2skPtKscTEXU39Nxf4QDAV
         4VrivPrOEFRw2+F0NRJEuwo5qKg2Rx18jENjRdPoOZW5yxK9aQVjNkHMtafG7CxD449S
         TcRkREJsd0UYdE5rc6wuzi3aePwLech/wR3EfCMat0+vK3X9vVkEwRJswE4tNLy1rRSd
         Mph4SUdkJmL0RV5LUbphrZXBVhBFc8AGJG7SRpjUy+diBk1UljZG58Ecr7dDOahbJvzW
         n80RniZi0AUl05y7veyBUPuCo/dSOMdnTPR0WIO8J2AdevMAzgm+jqRZN2uvD3Mwcs8s
         mehA==
X-Gm-Message-State: AOJu0YzP7tF2XGxUqRWKFvn0HuHlQ1xS9g7Wygm9OOG2NWrX7tIO3Fdl
	zInve+2AUZkQ9etQthj1Vo9bqA90vtmidfZMFcJLYHjAYih+UGdSDyxRmiRJYPI=
X-Google-Smtp-Source: AGHT+IHJB/lDaH4z5vGU3HcbhOhRS1RAyOmgLeYu/I/Kz5MpzocPl+5g2S2uYuxYBIoQevZvp4KNPA==
X-Received: by 2002:a05:651c:544:b0:2ef:2c62:f058 with SMTP id 38308e7fff4ca-2f3be5fb46cmr77237171fa.39.1724055954938;
        Mon, 19 Aug 2024 01:25:54 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f191sm5278362a12.61.2024.08.19.01.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:25:54 -0700 (PDT)
Message-ID: <5ed217de-16b1-4993-8d5d-4079025c53b8@blackwall.org>
Date: Mon, 19 Aug 2024 11:25:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] bonding: fix xfrm real_dev null pointer
 dereference
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jarod@redhat.com
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-4-razor@blackwall.org> <ZsK0AJXxNtJqr9AR@Laptop-X1>
 <c6c965c3-dc69-4be9-8817-2146992f9359@blackwall.org>
Content-Language: en-US
In-Reply-To: <c6c965c3-dc69-4be9-8817-2146992f9359@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 10:34, Nikolay Aleksandrov wrote:
> On 19/08/2024 05:54, Hangbin Liu wrote:
>> On Fri, Aug 16, 2024 at 02:48:12PM +0300, Nikolay Aleksandrov wrote:
>>> We shouldn't set real_dev to NULL because packets can be in transit and
>>> xfrm might call xdo_dev_offload_ok() in parallel. All callbacks assume
>>> real_dev is set.
>>>
>>>  Example trace:
>>>  kernel: BUG: unable to handle page fault for address: 0000000000001030
>>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>>  kernel: #PF: supervisor write access in kernel mode
>>>  kernel: #PF: error_code(0x0002) - not-present page
>>>  kernel: PGD 0 P4D 0
>>>  kernel: Oops: 0002 [#1] PREEMPT SMP
>>>  kernel: CPU: 4 PID: 2237 Comm: ping Not tainted 6.7.7+ #12
>>>  kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
>>>  kernel: RIP: 0010:nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
>>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>
>> I saw the errors are during bond_ipsec_add_sa_all, which also
>> set ipsec->xs->xso.real_dev = NULL. Should we fix it there?
>>
>> Thanks
>> Hangbin
> 
> Correct, I saw it too but I didn't remove it on purpose. I know it can lead to a
> similar error, but the fix is more complicated. I don't believe it's correct to
> set real_dev if the SA add failed, so we need to think about a different way
> to sync it. To be fair in real life it would be more difficult to hit it because
> the device must be in a state where the SA add fails, although it supports
> xfrm offload. The problem is that real_dev must be set before attempting the SA
> add in the first place.
> 

Just fyi I do have an idea about an additional bit that is set on successful ops
in combination with a call_rcu to wait for a grace period on error, I'll test it
this week and send a patch if it's good.

>>>  kernel: Code: e0 0f 0b 48 83 7f 38 00 74 de 0f 0b 48 8b 47 08 48 8b 37 48 8b 78 40 e9 b2 e5 9a d7 66 90 0f 1f 44 00 00 48 8b 86 80 02 00 00 <83> 80 30 10 00 00 01 b8 01 00 00 00 c3 0f 1f 80 00 00 00 00 0f 1f
>>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>>  kernel: RSP: 0018:ffffabde81553b98 EFLAGS: 00010246
>>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>>  kernel:
>>>  kernel: RAX: 0000000000000000 RBX: ffff9eb404e74900 RCX: ffff9eb403d97c60
>>>  kernel: RDX: ffffffffc090de10 RSI: ffff9eb404e74900 RDI: ffff9eb3c5de9e00
>>>  kernel: RBP: ffff9eb3c0a42000 R08: 0000000000000010 R09: 0000000000000014
>>>  kernel: R10: 7974203030303030 R11: 3030303030303030 R12: 0000000000000000
>>>  kernel: R13: ffff9eb3c5de9e00 R14: ffffabde81553cc8 R15: ffff9eb404c53000
>>>  kernel: FS:  00007f2a77a3ad00(0000) GS:ffff9eb43bd00000(0000) knlGS:0000000000000000
>>>  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>  kernel: CR2: 0000000000001030 CR3: 00000001122ab000 CR4: 0000000000350ef0
>>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>>  kernel: Call Trace:
>>>  kernel:  <TASK>
>>>  kernel:  ? __die+0x1f/0x60
>>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>>  kernel:  ? page_fault_oops+0x142/0x4c0
>>>  kernel:  ? do_user_addr_fault+0x65/0x670
>>>  kernel:  ? kvm_read_and_reset_apf_flags+0x3b/0x50
>>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>>  kernel:  ? exc_page_fault+0x7b/0x180
>>>  kernel:  ? asm_exc_page_fault+0x22/0x30
>>>  kernel:  ? nsim_bpf_uninit+0x50/0x50 [netdevsim]
>>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>>  kernel:  ? nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
>>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>>  kernel:  bond_ipsec_offload_ok+0x7b/0x90 [bonding]
>>>  kernel:  xfrm_output+0x61/0x3b0
>>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>>  kernel:  ip_push_pending_frames+0x56/0x80
>>>
>>> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
>>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>>> ---
>>>  drivers/net/bonding/bond_main.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index 65ddb71eebcd..f74bacf071fc 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -582,7 +582,6 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>>>  		} else {
>>>  			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
>>>  		}
>>> -		ipsec->xs->xso.real_dev = NULL;
>>>  	}
>>>  	spin_unlock_bh(&bond->ipsec_lock);
>>>  	rcu_read_unlock();
>>> -- 
>>> 2.44.0
>>>
> 


