Return-Path: <netdev+bounces-160543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E1A1A207
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E13C166B72
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F320DD41;
	Thu, 23 Jan 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7AVaTW/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BC20CCF2
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628952; cv=none; b=MxSJtsi5QlIlyRSkMZE2pFBGeHWctb21KwaTZ+1KFqNncrzi2zIfrolOWML4iIq7SxHfn+kaCUwe20UV1JU6yBZBxc3efNy+JEaW38edrPhp76CG83zcCWYH1AWQXqG24FbJBx1iZfUaR1vfD2tzD2FtYNC72hNw0WMYeiwa+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628952; c=relaxed/simple;
	bh=15iSjJE65OwBsEi1SIs5NbBHsemaoOfS2Y93BrkL/sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUi8vFih1pkySeHZreIaHfPGV67RpA1qxOLQN+ykaFIhfN8ldV+kWjsFkIJsz4UU4r/x4OzKLANjGNdlNS95RZCIbmBSlhyFmzjpB3qsGfxvJqON8VOhAhJePVVM7uK0IIt2ceFlk1ttztlCPkVXqdlkKv6Nv1v9cnr+yHycBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7AVaTW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737628949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbj+rAmB07IPAxH1pYioM15q/vNMJdmd6bCtqTPsexc=;
	b=P7AVaTW/gd/sIuD1KclGwTAghDgbGWV4bZGa//bvt5jA0/g2Qgz7vsCn78ZNYan8DX+7BZ
	oQICRv5ss2SLf6mwOe+h7bmR5yXEpJgWanm1ZjNG6PBsgBNChu6PMOEy1f1PlMEf5+8mVJ
	ZSRfM0ez1ObA8tdLS99G3yMHN5HIvvY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-CQT5_3R8OMOykU6glJQSxg-1; Thu, 23 Jan 2025 05:42:28 -0500
X-MC-Unique: CQT5_3R8OMOykU6glJQSxg-1
X-Mimecast-MFC-AGG-ID: CQT5_3R8OMOykU6glJQSxg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d52591d6so335607f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 02:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737628947; x=1738233747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbj+rAmB07IPAxH1pYioM15q/vNMJdmd6bCtqTPsexc=;
        b=PwABEwQBWBz5QdkB8qXGb5r81/24WY3S8rx5/7AsV9276lncZNeX8MIjfWGZt2ASHs
         925mVzlJsIeSQl2T3TWxz+bOTl87s3jsU2SDqAx98KU+qHmZflXU+HCaMN864p+8YESc
         BKza1a6I1JauOXlZVmxRn5jND43uyLYRN0tHR/aVXiL0jdTk+X97RMkoYioAEDcyogOC
         sCA4JoWxIRqSDIvL3f8o+bKvQd8WRJTldAbR2fk1TuKwF27rX7uuX039dvFk/NsLQl6T
         t+hfJHNrKprDJl5aij0/+hLnXyPg27FnWKOIT4HaCDm3bPZDURhMkC/r990r7UA4ZHPo
         tNrg==
X-Forwarded-Encrypted: i=1; AJvYcCVbbrM02UbwPlAt1l5ZFD90zZRD62rGgzhMYiB8KSHZKrh3MCfKk2orDHfmyoF25/AT+gKbe9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4WcCzZpNQzDYXKUYQB8yoqNGQhYauxcHbDrbuse5n5bDtUwjF
	sEJkxWE5bv2S4S54GB+yRoy/QJFnwKy+nPN5UZ9lLOmHVe0cVayrMphu6n9gJmSzMMaQXRcquxl
	mayN5xN2/pUCv5R4Q8WnkL9qjX6lBPlrrVZ6mefkSEaAl55YoQbZB/g==
X-Gm-Gg: ASbGncuGwJxgI1UedP6XgoN7WbPo2C037xRFJqJ97hCiPBZiJDLIReRt6E74c/cnvQ+
	fg0PPr8pDET2WBj3tx6jR72OxQyg0VKRsHg2Hl3fGvnrqNLYiJGlBq74btcgDd9yBz1fIeU5IHo
	VCZKPicIm12gtxtjLnU9j0x5fFgqeVZv/GeHG0DFmYHRjoF99QNRslJqHJCEQjnNqtbxlIsEPwC
	yuFhZdB85jMuVIHgJNflihz5QqM5lah3mYYhwlt7KpzMPldnOzhoqNGhlPaZiy9gzRhCWqj4JnE
	nszBCtWr1IPhyLHU5CDa/tMG
X-Received: by 2002:a5d:6d09:0:b0:38a:87cd:6d67 with SMTP id ffacd0b85a97d-38c2212a683mr2791139f8f.0.1737628946697;
        Thu, 23 Jan 2025 02:42:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeNBfiwkcxSVGyBkrWrqvExUU2X2pkRqCmXArdg0L2ug8l94XVqypZA8fuP9/G+ovIaZkGVw==
X-Received: by 2002:a5d:6d09:0:b0:38a:87cd:6d67 with SMTP id ffacd0b85a97d-38c2212a683mr2791107f8f.0.1737628946325;
        Thu, 23 Jan 2025 02:42:26 -0800 (PST)
Received: from [192.168.88.253] (146-241-27-215.dyn.eolo.it. [146.241.27.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31ae97dsm59140655e9.22.2025.01.23.02.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 02:42:25 -0800 (PST)
Message-ID: <de2d5f6e-9913-44c1-9f4e-3e274b215ebf@redhat.com>
Date: Thu, 23 Jan 2025 11:42:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned
 skbs
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
 <3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com>
 <CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/23/25 11:07 AM, Eric Dumazet wrote:
> On Thu, Jan 23, 2025 at 9:43 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 1/21/25 12:50 PM, Thomas Bogendoerfer wrote:
>>> gro_cells_receive() passes a cloned skb directly up the stack and
>>> could cause re-ordering against segments still in GRO. To avoid
>>> this queue cloned skbs and use gro_normal_one() to pass it during
>>> normal NAPI work.
>>>
>>> Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
>>> Suggested-by: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>>> --
>>> v2: don't use skb_copy(), but make decision how to pass cloned skbs in
>>>     napi poll function (suggested by Eric)
>>> v1: https://lore.kernel.org/lkml/20250109142724.29228-1-tbogendoerfer@suse.de/
>>>
>>>  net/core/gro_cells.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
>>> index ff8e5b64bf6b..762746d18486 100644
>>> --- a/net/core/gro_cells.c
>>> +++ b/net/core/gro_cells.c
>>> @@ -2,6 +2,7 @@
>>>  #include <linux/skbuff.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/netdevice.h>
>>> +#include <net/gro.h>
>>>  #include <net/gro_cells.h>
>>>  #include <net/hotdata.h>
>>>
>>> @@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>>>       if (unlikely(!(dev->flags & IFF_UP)))
>>>               goto drop;
>>>
>>> -     if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
>>> +     if (!gcells->cells || netif_elide_gro(dev)) {
>>>               res = netif_rx(skb);
>>>               goto unlock;
>>>       }
>>> @@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *napi, int budget)
>>>               skb = __skb_dequeue(&cell->napi_skbs);
>>>               if (!skb)
>>>                       break;
>>> -             napi_gro_receive(napi, skb);
>>> +             /* Core GRO stack does not play well with clones. */
>>> +             if (skb_cloned(skb))
>>> +                     gro_normal_one(napi, skb, 1);
>>> +             else
>>> +                     napi_gro_receive(napi, skb);
>>
>> I must admit it's not clear to me how/why the above will avoid OoO. I
>> assume OoO happens when we observe both cloned and uncloned packets
>> belonging to the same connection/flow.
>>
>> What if we have a (uncloned) packet for the relevant flow in the GRO,
>> 'rx_count - 1' packets already sitting in 'rx_list' and a cloned packet
>> for the critical flow reaches gro_cells_receive()?
>>
>> Don't we need to unconditionally flush any packets belonging to the same
>> flow?
> 
> It would only matter if we had 2 or more segments that would belong
> to the same flow and packet train (potential 'GRO super packet'), with
> the 'cloned'
> status being of mixed value on various segments.
> 
> In practice, the cloned status will be the same for all segments.

I agree with the above, but my doubt is: does the above also mean that
in practice there are no OoO to deal with, even without this patch?

To rephrase my doubt: which scenario is addressed by this patch that
would lead to OoO without it?

Thanks,

Paolo


