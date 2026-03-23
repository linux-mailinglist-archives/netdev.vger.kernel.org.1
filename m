Return-Path: <netdev+bounces-270454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA5mDN4RwWnHQQQAu9opvQ
	(envelope-from <netdev+bounces-270454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:11:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDFE2EFC4E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E1A8301253D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B138AC8A;
	Mon, 23 Mar 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+lJu6gJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps0/hYDS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913738B121
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260617; cv=none; b=hKG8Jfs+ei9DXJMvxdCFStz7p6hWXE826kxH5fV9mx0ST6NgT2vbTMm9GNd+EkLAzCCXUlC6lqPrnLmPPw+BUOl7Z0LbNWuUqL9mwUKnSR8UWjMsXqIamb6HXT9Jj0vDgpCDTnwXr2tUS9WKWuwegJelC/nZqLsw1NMVKso+ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260617; c=relaxed/simple;
	bh=pE4CJDScZfW3YkLmHCc+J4zS+5kZYIiwPAn9gHrNW2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fpU7rk4Uhmph2d1ePslqGqU51mNcUaH/YNuGhbPug2hxrNad92C1mJ6d7rE0bbAxSEgJWtItii+NqDAmkA1Zfl5rCtUQHkJY7E6rZP7tKnsWNB9aBqlXIip8z9yxxOuwMj9LC0i9RzCDz0fNKx6E0nzCSx4o1woeCoraKxlLbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+lJu6gJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ps0/hYDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774260615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKr36IcxflXsZzgElrYG+m4yauG+zPHZtQJSaroYlAw=;
	b=d+lJu6gJr+bk0x5XJSisWMFNTRb1kd7EgcDO1W38ExSLsOg33gj0DhTx7bQa1hqWTjA7RH
	qXUJGn5MyI8pb/tESdz4AHsRatLMvIdOgDOV8IE0bYcKmA+UAZVCNo8WN7yAMwoIP4ZFLx
	1ePk0JqbGaBNc6Oiq/JkOdTMtjxiaWY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ZYSDdy8MOsWWywyXWOhF1Q-1; Mon, 23 Mar 2026 06:10:13 -0400
X-MC-Unique: ZYSDdy8MOsWWywyXWOhF1Q-1
X-Mimecast-MFC-AGG-ID: ZYSDdy8MOsWWywyXWOhF1Q_1774260612
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439ca4b3d0bso4008268f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774260612; x=1774865412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKr36IcxflXsZzgElrYG+m4yauG+zPHZtQJSaroYlAw=;
        b=Ps0/hYDSUp7OTpuQlv392eFPExjludAfUx2krM+6KA6EsYNL96fQGbV6e2X4YlzDa/
         GCJ8H+cVTXGFJ5io3O9RkrRkXLQvQ+luxz0H/bKmApmyeqOnW3xJgcMwVEkNTy0cZzld
         b32CziI/fdK25oh+92hzZ/9Jzy+lkZqSmygoUTTNbD/QDYQv9OjWL80APRXVoA4qwoHJ
         1Mqpbj4CpXBxBd0KdMNoLox7CpOBzZC7JrLgCAK+sToAw2s0TYf+4sVJPkZo8Yjy+VV1
         mgUXYTuW++o20dzcN0Q7mA39zzjn7OXvFbpqT5HRl+zTN500YvSw6jONHRzk52k43npC
         O71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774260612; x=1774865412;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JKr36IcxflXsZzgElrYG+m4yauG+zPHZtQJSaroYlAw=;
        b=c6gqOKElUhDCIzqVqZJOZ6foS0E0rtKZIWsHwqJC1KdctQ60Ko3lfaPetFsG2OAP8e
         VLgOUt3WAkSR+L7oAWWfFmdR9Y4/KRsWb4/hVRevIkx96dl5of17EMxc8ioS53ZTzwRj
         hkNSjA4z/R++iCUE7ZDk4kyruOTTn66AzgxiaSH50octutBiG8MS1A9KHJbGQ6jg328y
         IWfNkngr08E/g2K+xgsqVo6WA2Do35QTKYU7HWkt8Z1zgQhfc8g98ehv0sKOG5IRrmHr
         F+n8bBQw8v7l25nnWUtDjqRk5O/bgYP5kfSQjgd3GQ+SQkWaN2wPLT7b46Zbk9u/TKPJ
         KP+g==
X-Forwarded-Encrypted: i=1; AJvYcCXl8ZE1BjOn3ACZaXxwNUXyAIhHdfqHucTfbzC/CSXHG2D4TqNPQ/CdrQ+hwWpXoWT4Vn4VsUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGikLoN7id3Mp5c6DOygoSXqT33aC6Nx7k/3bSHK/u15L/kaHr
	jGnQEbog6BYVTvBAA7V/atfJi2B5NpyEEG3egVaurLPK6G+ZYoFvcFK4AYi7wlOFlqWKhyfacn4
	+YckH/dZ6Aj0zfS/+ljBSTKoA0FRxXNHC5cfUu0/WvF+o2TXWK9b5Se1MFg==
X-Gm-Gg: ATEYQzyaG+04GUXub506gFoLhV+xj170wN8tu3ZiWS1Ym+QYKaKNOh+a/40ejEyhSr4
	MSw6InkXUhlX0dntQszpNZV6Scd0kXUcwI7AWBXaac7SStn4SUx3glFUM22vtJN6pVRzWmKDe7I
	S/4hyCuACauq7WQbKINRv4ALERXiAaUjPA4RQqFYY6lhEhqm7cW+6zVhAla59Ll7INDxqmsNc/X
	XVCPG8IICGW4xxrGeWkj4Tiq97VqqguK5ZrlPxUvK2mwgRy/28/8sHy93uhfixgabDoEXjm/Cqz
	HJxokXnb22lPpkz3iak4BqyKHwklEhX9cI9L2UKhuCHLwQzhrwcc6C2PD6ds5H0Dl3l+wOEuVOt
	Rw9nsB8UdY/finXH7E9fqdZJjQBqunKIlLHqNlM6KEAlm5Q==
X-Received: by 2002:a05:6000:2007:b0:43b:5356:a7f9 with SMTP id ffacd0b85a97d-43b6428b369mr17503106f8f.52.1774260612395;
        Mon, 23 Mar 2026 03:10:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2007:b0:43b:5356:a7f9 with SMTP id ffacd0b85a97d-43b6428b369mr17503040f8f.52.1774260611885;
        Mon, 23 Mar 2026 03:10:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64711f58sm28836178f8f.29.2026.03.23.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:10:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 699215A429C; Mon, 23 Mar 2026 11:10:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@fomichev.me,
 j.koeppeler@tu-berlin.de, mfreemon@cloudflare.com, carges@cloudflare.com,
 kernel-team <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH net-next 2/6] veth: implement Byte Queue Limits
 (BQL) for latency reduction
In-Reply-To: <6d1b8a33-b645-4ab4-b459-36e826052e48@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
 <20260318134826.1281205-3-hawk@kernel.org> <87ms05nrdw.fsf@toke.dk>
 <cbfc927d-0b96-4788-8bf6-8a2ffa4dd9f4@kernel.org> <87h5qcnnjh.fsf@toke.dk>
 <6d1b8a33-b645-4ab4-b459-36e826052e48@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 23 Mar 2026 11:10:10 +0100
Message-ID: <87wlz2n9fh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270454-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,toke.dk:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ACDFE2EFC4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 19/03/2026 11.04, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> On 18/03/2026 15.28, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> hawk@kernel.org writes:
>>>>
>>>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>
>>>>> Add BQL support to the veth driver to dynamically limit the number of
>>>>> bytes queued in the ptr_ring, giving the qdisc earlier feedback to sh=
ape
>>>>> traffic and reduce latency.
>>>>>
>>>>> The BQL charge (netdev_tx_sent_queue) is placed in veth_xmit() BEFORE
>>>>> veth_forward_skb() produces the SKB into the ptr_ring. This ordering =
is
>>>>> critical: with threaded NAPI the consumer runs on a separate CPU and =
can
>>>>> complete the SKB (calling dql_completed) before veth_xmit() returns. =
If
>>>>> the charge happened after the produce, the completion could race ahead
>>>>> of the charge, violating dql_completed()'s invariant that completed
>>>>> bytes never exceed queued bytes (BUG_ON).
>>>>>
>>>>> Whether an SKB was BQL-charged is tracked per-SKB using a VETH_BQL_FL=
AG
>>>>> bit in the ptr_ring pointer (BIT(1), alongside the existing VETH_XDP_=
FLAG
>>>>> BIT(0)). The do_bql flag from veth_xmit() propagates through
>>>>> veth_forward_skb() and veth_xdp_rx() into the ptr_ring entry. On the
>>>>> completion side in veth_xdp_rcv(), veth_ptr_is_bql() reads the flag to
>>>>> decide whether to call netdev_tx_completed_queue(). Per-SKB tracking =
is
>>>>> necessary because the qdisc can be replaced live (e.g. noqueue->sfq or
>>>>> vice versa via 'tc qdisc replace') while SKBs are already in-flight in
>>>>> the ptr_ring. SKBs charged under the old qdisc must complete correctly
>>>>> regardless of what qdisc is attached when the consumer runs, so each
>>>>> SKB carries its own BQL-charged state rather than re-checking the pee=
r's
>>>>> qdisc at completion time.
>>>>
>>>> It's not completely obvious to me why BQL can't be active regardless of
>>>> whether there's a qdisc installed or not? If there's no qdisc, shouldn=
't
>>>> BQL auto-tune to a higher value because the queue runs empty more?
>>>>
>>>
>>> When net_device don't have qdisc we hit this code path:
>>>    - [0]
>>> https://elixir.bootlin.com/linux/v7.0-rc4/source/net/core/dev.c#L4806-L=
4852
>>>    - Notice the check if(!netif_xmit_stopped(txq))
>>>    - resulting in "Virtual device %s asks to queue packet!"
>>>
>>> We cannot unconditionally track BQL as calling netdev_tx_sent_queue()
>>> can result in setting STACK_XOFF.  Resulting in above code dropping
>>> packets and complaining.  (It have no qdisc to requeue store back-
>>> pressured packet).
>>=20
>> Ah, right. I realised the packet would be dropped, of course, but I did
>> not realise the stack would complain. That seems... odd? Why not just
>> get rid of the complaint instead of having this kludge to work around
>> it?
>>=20
>
> The BQL code manipulates txq (struct dql) and this requires correct
> locking. Using noqueue on veth doesn't do the correct locking.
>
> In the linked[0] code you were likely fooled by this code line[1]:
>   HARD_TX_LOCK(dev, txq, cpu);
> It is actually not taking the lock, because veth is a lltx device.
> (Don't be fooled by the annotation it is for WARN_CONTEXT_ANALYSIS)
>
> For fun I actually implemented it to see what happened. And I did manage
> to crash the kernel on the DQL internal BUG_ON.  Analyzing the BUG_ON I
> realized that my scheme of charging BQL and then undo the charge (if
> ptr_ring were full) isn't correct, there is a race.  The BQL call
> netdev_tx_completed_queue() is strictly to be used by the consumer, not
> by the producer (like I did).
>
> I'm now working on different approaches for the undo...

Alright, good to hear that my obtuse questions turned out to be helpful ;)

-Toke


