Return-Path: <netdev+bounces-234723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9CBC2674F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7611891641
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE46334C2C;
	Fri, 31 Oct 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LjrrgGLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614472472BD
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932622; cv=none; b=XFQD/tB5XSNuWjYV89768XUO0YG9KMmDbpNDh8Gi4ZChqR4N42H4zlmSSlkZ11kX3yKzDfdXLEFv7NzHnPqTe2b1+UFTFzR/ln0t24h51AJW7qhTSLzznVIZBrdI3g2U4HrSD/jZw8VOayB5mRP7BN+SDCSCxfm1txeXwAGceeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932622; c=relaxed/simple;
	bh=CkphD6gFRvRZAfp6x6jplUX5zH6dQ2bOeDIAsAs+6Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtxBH+JGappms7IlesVRV38eEOtOYETcVW/+TBvG1C2WZLQFDygoSB9X5tCFPoaEzTWVvTweJ0ns9vsa3p2NWMY7MzB1Hx9wQX0JJpaGZXe7G/5R3BENjCMdQCdFJs/N5IgFDz1PZVWNgynFcEdC+ia0hoNJVyvB5A2/WcZyADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=LjrrgGLK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2948682b3a.2
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761932618; x=1762537418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJWuuobrxZxfvHL/nQVvExHzpBzmZDJnlbeePXN3G3E=;
        b=LjrrgGLKdtDvx+98l8fZhbzBvk4b0AjgdrsoUvq+bIYWJcrAgRQLatPpiGY6mfd0dM
         U6E6v2ZgMlwucUsuFZzlZW6mCOCBsmUUSJI/GIybJq+9pLnXtOEpEgxfo6n3d0nZ7pX7
         pvHKkF188weFZegwRvhve2il+XIyFBnu+da1pWhg4jd4TZLTqgzW0blF6aGy+yQIjYXX
         mfEiN8RR9BENpftH/PuGw+lyVLBJh0ZhfXC3OLRwiI+dGChvML3B7avqRy9wHC2OB8Pi
         e15xkfWLLTv7cMmOQmqq2234CKO/OEcxj1IJym0uPxChWkscLSLS56GZkbF27JjUaeRK
         SWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932618; x=1762537418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJWuuobrxZxfvHL/nQVvExHzpBzmZDJnlbeePXN3G3E=;
        b=M/FiWs4qEr/PpvMkbfk4LQjDdKYwOkuXGMWNmXmu6WlUcwBVDxFmjzVOlSnHZrSNg3
         a+TRWGLFtj2dfsK/jGHw3h1plOfQcyoeJ51NXy4ZlEfztFgTpdz3kQeVxB5R/tOtNJcs
         Yf0zhji1hS4KG6SSbypO+8gFFyvrnXtZy+msHISPccrLK9t42XgNDggudvYmnuttQuVn
         STjd60HKGWy4TwGNQwrwuzP+5uNWVRSwtNCPER7XHd5Qbu4MHmTJuj4PSCjG+eZAmh5X
         EFD344sIYNVaC6jxCeH4D43Nyw29Ei64mXkuy2oHTiLtlFQVE7V7e9StY4cTFdwwgCae
         RD6g==
X-Forwarded-Encrypted: i=1; AJvYcCV62RPUWhrAU8LKV+nUNTGrvZcBxQGD128jChl2v8mjHvUOchzq615exYeSyM1XDkFn4gFyJ2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVo9ms2iT68cbJNFnJZHfhOiL5rYK1bbA7fKicnyuWqx0Pa/N
	Nqwt/HlaMAHP9Q14JpAXIO6BK1YyCSCYSuAw1D0GEYgKA8dP55RcEao9/gOcVlF992Rb+N3JO+c
	PWMdQnw==
X-Gm-Gg: ASbGnctvz/0WvJIrQpQa7EQpf7PSIFAce6YmX8wRn9MbGH/l+VOPENIdACb/kvcbGIg
	vlwb9CpQ/xvI98NbjKrrEoKXotKmM8YqV45nbdk6xy6re9+AH5Q7Fqef3WcGXRgJhKJ0k1WNRCu
	wt5jeaRHQpQPqkgPIKr3aM52AsnGu7sNJHk1qYPeanqY78x7T2UKuAE8NeJ3cQ+iH3qrPxtWIs+
	pUzDX/URHDgLrYITOiqTMZ9pDlRMa6lGt4mLT5kYgoNjawex9P7BmSsHndQbCSnpxsL4Vri604l
	plMJEfvd3PoR5yrr7HRH8RQhuLoLCuHZUEbnTcbU1gl9q3Zx6T4rKyTdVAsKfukSe+UTUK2t61d
	Vgaz5nahyRxMgOrHKWF789n33BHfBvke0eIbEPYxKhmfht2zAAhDblXcMF1pdhXeON8LYqhxOnL
	hrm6r+DAMwiQxF5TGOVEs1qk2ZcMQ45ue9lJEZog4bjK3Gskrocb8H54mkfel9dQ==
X-Google-Smtp-Source: AGHT+IGmyQv5IcHBsSFjqa6lQAHhfrvQQUZa5MtkXjs+gJtuek1vj+Ohkdx1z5maXdvPe7fUV+k2fQ==
X-Received: by 2002:a05:6a00:3d4e:b0:7a2:7833:8b5d with SMTP id d2e1a72fcca58-7a7788ffd40mr6261272b3a.17.1761932618504;
        Fri, 31 Oct 2025 10:43:38 -0700 (PDT)
Received: from [192.168.2.125] (69-172-167-162.cable.teksavvy.com. [69.172.167.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67cac6sm2798434b3a.51.2025.10.31.10.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 10:43:38 -0700 (PDT)
Message-ID: <a673f379-9b0c-4d02-8884-23c62930513a@arista.com>
Date: Fri, 31 Oct 2025 10:43:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
 <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
 <bcff860e-749b-4911-9eba-41b47c00c305@arista.com>
 <CANn89iKRXpKkCzRw_7+VyG6jD2Tm5VUPQ-0bhQKUwh2sgzJZuA@mail.gmail.com>
 <CANn89iJcLepEin7EtBETrZ36bjoD9LrR=k4cfwWh046GB+4f9A@mail.gmail.com>
 <CANn89i+=rqOAi3SJ0yj47x9X=ScDX5-dD2GmAVRsVGNP9XDBEw@mail.gmail.com>
Content-Language: en-US
From: Christoph Schwarz <cschwarz@arista.com>
In-Reply-To: <CANn89i+=rqOAi3SJ0yj47x9X=ScDX5-dD2GmAVRsVGNP9XDBEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/31/25 02:06, Eric Dumazet wrote:
> On Thu, Oct 23, 2025 at 10:57 PM Eric Dumazet <edumazet@google.com> wrote:
>>
[...]
>> Could you try the following patch ?
>>
>> Thanks again !
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 378c2d010faf251ffd874ebf0cc3dd6968eee447..8efda845611129920a9ae21d5e9dd05ffab36103
>> 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -4796,6 +4796,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
>> net_device *sb_dev)
>>                   * to -1 or to their cpu id, but not to our id.
>>                   */
>>                  if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
>> +                       struct sk_buff *orig;
>> +
>>                          if (dev_xmit_recursion())
>>                                  goto recursion_alert;
>>
>> @@ -4805,6 +4807,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
>> net_device *sb_dev)
>>
>>                          HARD_TX_LOCK(dev, txq, cpu);
>>
>> +                       orig = skb;
>>                          if (!netif_xmit_stopped(txq)) {
>>                                  dev_xmit_recursion_inc();
>>                                  skb = dev_hard_start_xmit(skb, dev, txq, &rc);
>> @@ -4817,6 +4820,11 @@ int __dev_queue_xmit(struct sk_buff *skb,
>> struct net_device *sb_dev)
>>                          HARD_TX_UNLOCK(dev, txq);
>>                          net_crit_ratelimited("Virtual device %s asks
>> to queue packet!\n",
>>                                               dev->name);
>> +                       if (skb != orig) {
>> +                               /* If at least one packet was sent, we
>> must return NETDEV_TX_OK */
>> +                               rc = NETDEV_TX_OK;
>> +                               goto unlock;
>> +                       }
>>                  } else {
>>                          /* Recursion is detected! It is possible,
>>                           * unfortunately
>> @@ -4828,6 +4836,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
>> net_device *sb_dev)
>>          }
>>
>>          rc = -ENETDOWN;
>> +unlock:
>>          rcu_read_unlock_bh();
>>
>>          dev_core_stats_tx_dropped_inc(dev);
> 
> Hi Christoph
> 
> Any progress on your side ?
> 
> Thanks.

Hi Eric,

Thanks for your help. This is much appreciated.

We tried your patch but unfortunately it did not help. We have some 
ideas why that is. Here is what we figured out:

It is very likely that device stacking as described in my previous mail 
is a factor.

49: vlan0@parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP mode DEFAULT group default qlen 1000
      link/ether 02:1c:a7:00:00:01 brd ff:ff:ff:ff:ff:ff
3: parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 10000 qdisc prio state
UNKNOWN mode DEFAULT group default qlen 1000
      link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff

The "parent" device is served by a proprietary device driver for a 
switch ASIC, and implements TX flow control, with the TX queue being 
stopped frequently. It does not have TSO capabilities. We could look 
into adding that, but as of now it is not an option.

The "vlan0" device stacked on top is Linux kernel code 
(net/8021q/vlan_dev.c) and has the IP address to which the HTTP server 
binds. However, its TX queue never stops.

So now it can get into this situation where the TX queue on the 
underlying device is stopped, but on the stacked vlan0 device it is not. 
In this situation, we see return codes of NET_XMIT_DROP (1).

Which means it never reaches the code that you patched in, because 
thanks to rc=1, dev_xmit_complete is always true so it goes to out. And 
because the TX queue on vlan0 is never stopped, it always enters the 
"!netif_xmit_stopped(txq)" block and never skips over it, again 
preventing the new code from ever being executed.

if (!netif_xmit_stopped(txq)) {
	dev_xmit_recursion_inc();
	skb = dev_hard_start_xmit(skb, dev, txq, &rc);
	dev_xmit_recursion_dec();
	if (dev_xmit_complete(rc)) {
		HARD_TX_UNLOCK(dev, txq);
		goto out;
	}
}
HARD_TX_UNLOCK(dev, txq);
net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
		     dev->name);
if (skb != orig) {
	/* If at least one packet was sent, we must return NETDEV_TX_OK */
	rc = NETDEV_TX_OK;
	goto unlock;
}

I think for your patch to work we would need to see a NETDEV_TX_BUSY 
(0x10) rc from dev_hard_start_xmit, but that does not seem to happen, 
maybe due to the device stacking?

best regards,
Chris


