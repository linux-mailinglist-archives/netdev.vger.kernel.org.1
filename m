Return-Path: <netdev+bounces-172812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E086A56298
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFF018887EB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A731B4224;
	Fri,  7 Mar 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="HUcJE0gl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD91A841E
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336442; cv=none; b=Wq94O8f0SaRENPe1XyqW69PI5sKal6bv3vASA2lO2wVDW47pLpkDnlQMWe6O1YtgISdIaIM98rJUJkSXGo1mwEkI6QRFhhI7HXqDk4Yca+5+UG69lXohA2cCA+qUADDBOrFbx4nIvi1u6J8UbsJHO74Nq86rWxt4nm8QkWWB8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336442; c=relaxed/simple;
	bh=Sh+rfGzLOB1b2a9HdUZm3hMkw4gRexqTGwuwkToRcCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUKVW0E3QBGTFDpf1mqa6D9u+zO5ZicibNzz0oeTw9HndKh54UNdghtFcuODL/HVWa99h9g4CuMTqZwQsNc9esWH5ahDEIqeg5RR0nfYyU5J0dPiykHurVLqAWGtoeqPiFstZj5PHNo903pmR7OpRWQFKCDMVj2KB1IiMEE8qrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=HUcJE0gl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso227720866b.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741336439; x=1741941239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omvOTZNwfWYDk44NVBjyy3sj3JkUlQjIuVhlR5xVZsk=;
        b=HUcJE0glopRm2s2EVRLmgyiXPnj7czeCa6DesDG07VeU9PKz0I30Q2DKSwft8j53hG
         O4EXvXXdJYOKOtOzmHWPx6Y9MS/9OLC5JsIhoHSwboKYIhcavptDy+vcxDOUargYb2gp
         o0zaKIEq4aF8+XmRDqnHkSoKnMHwlUD1kF0sq8XqzoTzylI7GmpYTc8QIpXsuR/80qB9
         oEL4l8rKV/H+2TgHkefftRKfW6WWUjjSe1kOrYgsWjkSwcAeICCdRQAVAp8imT11XUGy
         pvmKtcnAeHBl41BtDXrVpXRGOR7iY/H6VnF2eGX0+VAra/nHRZMO6oet14JJmQ3xF+fr
         /B9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336439; x=1741941239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omvOTZNwfWYDk44NVBjyy3sj3JkUlQjIuVhlR5xVZsk=;
        b=ek/b8yrlRaAnbKUz2XzMJ/fPh2ZRt3xLQDBknQXIeMFlLBeQ/coZKgy7siZSzlT3XP
         fYJu7p8x2+hgqcfZnyqituG/xkv55zw22cZXGREMOB8YLMjPW0mWq2z009ijtGKRbEvL
         mZaIH03T1BB31VyM2WgdamMxQcPE3VbyyaM3hQmMT+ZW1fx3x5gWoLSJcjzAHf9yLcUZ
         03np+hwy643EdyBYM5i0L6UvjxTMBcfnY1Yv1+BXSHDEsGfHfu19AgVdJPOebvlTZfWF
         HyivGVwXCIK/7ayJTjOTnXRf5UuuPUF/gkbYHroc/WcHcCS3jFY6yRjAcINhqPKPxAcT
         mDFA==
X-Gm-Message-State: AOJu0Yxv00/6tMW2PQyrzfqDU3XeaTm48B+ES+UNyfotcK63ffwjkFLZ
	rTFMl7KChC9mGdmvpH6JO0EwRjfD1EuugiQjJXewOi1dBhhEwuf58wWp4wdgsKo=
X-Gm-Gg: ASbGncuyQfmfXaXmj5E0aa2ODo5oxLU3gGwyX2OsYJEFWgqdggr6L6IcB/xjtzLPV8v
	Q81shCohfjywaOILhyAd2+8tc/uJqrnD4Hg/aAiJfiBeWLPTrR8iW9ceMUSgI7UBVwDE7ValKe5
	5YdGDd3MmDYP/3KE6mcW5vgOkIA/gdGaw3a3CAT/AwmVobhJfHtXsxDAEk8IiDUiu7bhjv2aAPc
	+sAGzKCMoJHO/S+3iTjtP3bqzQyVltu3FbUDkp/3abGv/ri/r3M20N4JW4HnBnbpmJRXneSyWKF
	v5QazdALhCqfdvFPrBGP7+7t06b9OFQ4+IlmGGTLf4RL3vF4i3DjmoFoHzXS0WiUz1cWs5DsgTe
	G
X-Google-Smtp-Source: AGHT+IFYSQRuaqRplHXA2kM66xT02LPg8//qgKuUDazDg3f9slGb176+oPKyRdb+pVUCcWIuBeQN8A==
X-Received: by 2002:a17:907:94ce:b0:ac2:344:a15e with SMTP id a640c23a62f3a-ac252658e60mr239230766b.22.1741336438714;
        Fri, 07 Mar 2025 00:33:58 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973b09asm234762766b.119.2025.03.07.00.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 00:33:58 -0800 (PST)
Message-ID: <9b0312c8-dc96-494e-86f9-69ee45369029@blackwall.org>
Date: Fri, 7 Mar 2025 10:33:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
 <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
 <Z8qqS9IlRAMYIqXb@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z8qqS9IlRAMYIqXb@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/25 10:11, Hangbin Liu wrote:
> Hi Nikolay,
> On Fri, Mar 07, 2025 at 09:42:49AM +0200, Nikolay Aleksandrov wrote:
>> On 3/7/25 05:19, Hangbin Liu wrote:
>>> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
>>> a warning:
>>>
>>>   BUG: sleeping function called from invalid context at...
>>>
>>> Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
>>> which is not held by spin_lock_bh().
>>>
>>> Additionally, there are also some race conditions as bond_ipsec_del_sa_all()
>>> and __xfrm_state_delete could running in parallel without any lock.
>>> e.g.
>>>
>>>   bond_ipsec_del_sa_all()            __xfrm_state_delete()
>>>     - .xdo_dev_state_delete            - bond_ipsec_del_sa()
>>>     - .xdo_dev_state_free                - .xdo_dev_state_delete()
>>>                                        - bond_ipsec_free_sa()
>>>   bond active_slave changes              - .xdo_dev_state_free()
>>>
>>>   bond_ipsec_add_sa_all()
>>>     - ipsec->xs->xso.real_dev = real_dev;
>>>     - xdo_dev_state_add
>>>
>>> To fix this, let's add xs->lock during bond_ipsec_del_sa_all(), and delete
>>> the IPsec list when the XFRM state is DEAD, which could prevent
>>> xdo_dev_state_free() from being triggered again in bond_ipsec_free_sa().
>>>
>>> In bond_ipsec_add_sa(), if .xdo_dev_state_add() failed, the xso.real_dev
>>> is set without clean. Which will cause trouble if __xfrm_state_delete is
>>> called at the same time. Reset the xso.real_dev to NULL if state add failed.
>>>
>>> Despite the above fixes, there are still races in bond_ipsec_add_sa()
>>> and bond_ipsec_add_sa_all(). If __xfrm_state_delete() is called immediately
>>> after we set the xso.real_dev and before .xdo_dev_state_add() is finished,
>>> like
>>>
>>>   ipsec->xs->xso.real_dev = real_dev;
>>>                                        __xfrm_state_delete
>>>                                          - bond_ipsec_del_sa()
>>>                                            - .xdo_dev_state_delete()
>>>                                          - bond_ipsec_free_sa()
>>>                                            - .xdo_dev_state_free()
>>>   .xdo_dev_state_add()
>>>
>>> But there is no good solution yet. So I just added a FIXME note in here
>>> and hope we can fix it in future.
>>>
>>> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
>>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>>> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
>>> Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>>  drivers/net/bonding/bond_main.c | 69 ++++++++++++++++++++++++---------
>>>  1 file changed, 51 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index e45bba240cbc..dd3d0d41d98f 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -506,6 +506,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>>>  		list_add(&ipsec->list, &bond->ipsec_list);
>>>  		mutex_unlock(&bond->ipsec_lock);
>>>  	} else {
>>> +		xs->xso.real_dev = NULL;
>>>  		kfree(ipsec);
>>>  	}
>>>  out:
>>> @@ -541,7 +542,15 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>>>  		if (ipsec->xs->xso.real_dev == real_dev)
>>>  			continue;
>>>  
>>> +		/* Skip dead xfrm states, they'll be freed later. */
>>> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
>>> +			continue;
>>
>> As we commented earlier, reading this state without x->lock is wrong.
> 
> But even we add the lock, like
> 
> 		spin_lock_bh(&ipsec->xs->lock);
> 		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> 			spin_unlock_bh(&ipsec->xs->lock);
> 			continue;
> 		}
> 
> We still may got the race condition. Like the following note said.
> So I just leave it as the current status. But I can add the spin lock
> if you insist.
> 

I don't insist at all, I just pointed out that this is buggy and the value doesn't
make sense used like that. Adding more bugs to the existing code wouldn't make it better.

>>> +
>>>  		ipsec->xs->xso.real_dev = real_dev;
>>> +		/* FIXME: there is a race that before .xdo_dev_state_add()
>>> +		 * is called, the __xfrm_state_delete() is called in parallel,
>>> +		 * which will call .xdo_dev_state_delete() and xdo_dev_state_free()
>>> +		 */
>>>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
>>>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>>>  			ipsec->xs->xso.real_dev = NULL;
>> [snip]
>>
>> TBH, keeping buggy code with a comment doesn't sound good to me. I'd rather remove this
>> support than tell people "good luck, it might crash". It's better to be safe until a
>> correct design is in place which takes care of these issues.
> 
> I agree it's not a good experience to let users using an unstable feature.
> But this is a race condition, although we don't have a good fix yet.
> 
> On the other hand, I think we can't remove a feature people is using, can we?
> What I can do is try fix the issues as my best.
> 

I do appreciate the hard work you've been doing on this, don't get me wrong, but this is
not really uapi, it's an optimization. The path will become slower as it won't be offloaded,
but it will still work and will be stable until a proper fix or new design comes in.

Are you suggesting to knowingly leave a race condition that might lead to a number
of problems in place with a comment?
IMO that is not ok, but ultimately it's up to the maintainers to decide if they can live
with it. :)

> By the way, I started this patch because my patch 2/3 is blocked by the
> selftest results from patch 3/3...
> 
> Thanks
> Hangbin



