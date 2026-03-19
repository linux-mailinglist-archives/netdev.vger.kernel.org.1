Return-Path: <netdev+bounces-269391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFErGInLu2leoQIAu9opvQ
	(envelope-from <netdev+bounces-269391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:10:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E982C945F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B44930107C6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C55A374E69;
	Thu, 19 Mar 2026 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQmu/DMG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgoX3oZU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE24366DDA
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914650; cv=none; b=AdOYgJEWjClzVrUxkMc6pwp+aE2HwzLfwlKDJbL4xgnF8jfepwFFBqtDkEU15NapnH0QKdLO0N8sx7IKlkYlY0t3fqZdOi6i+KIJ9ypoXUBRmK3uUUMjL3BJyos1+cnmTqnYMx2KJAfs/DEeR6cgAcTn+y5BSWimd36/bWZm9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914650; c=relaxed/simple;
	bh=EoTZPubaOw78yUjAPouKCn9akhrYqbdnX3O6MB3/jFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpwJ8RJg4/luhynwhzpjX6Vp1FzPOn2E428uZh6IyVWntfpc165ISSnGiXPkZufGarXiGL9qiOZjEyNljPv+XjED3sb5f++Wx2XS1N6hFEiNtPvig4avMA0z7DT8+0+zF/qxYAIUEU1BIV7VAT5iP0KZZp4yiKVesKENa5dziJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQmu/DMG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgoX3oZU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773914647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuL6cGxv8hO26vrrFZgV4HgLSGxYGB371+xstAsQUlA=;
	b=PQmu/DMG4Pv3JSOBDTyalplwwhB/9EaCSyGkU2jW64rNeKSsk4HU/nQTn3/lldrc5UJj3K
	1r+UjnsZEumlyZOkGNapeUrAp9CviGt6DQQEFUQmNFeTyh5rQo3YrcuELsok2CYKUl3CBh
	o9mEYUBxsHnrLBKWzfZHUT4UEdUYBj8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-cXVJZUlUMEyUa6f-H37yWw-1; Thu, 19 Mar 2026 06:04:06 -0400
X-MC-Unique: cXVJZUlUMEyUa6f-H37yWw-1
X-Mimecast-MFC-AGG-ID: cXVJZUlUMEyUa6f-H37yWw_1773914645
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485350666bfso4029815e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773914645; x=1774519445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuL6cGxv8hO26vrrFZgV4HgLSGxYGB371+xstAsQUlA=;
        b=dgoX3oZUMUfOGz3/J0u8TikuxBlRzUOvOivXO+0ZGENMYyKMdOZNtgdAUnP6DV0B61
         aR2JjtR6tnFT+93FdhSqfnGwLOVxXH9Vk4Cu3vs7UY4vE29SNRjq+63ZNj1Bfc/a3kRq
         vD0u53L5CfxZj0pNtuZpZr82mUQSnU/+rnaHG0MAjy9e6MRUpjSR8h+xBF7fTB0byof/
         CnaO31kOFJVRFPqonmJYrzDUqwGVosz8R2m86N66DJc5eAtPocE0SkpHBE9CFxYvhccz
         clKQZGbeyRTjNSMZnzMBMBmy7UJt38jGv6otm4mdQcK7WJRNm3vdZGLGN2poRUlSzziZ
         O/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773914645; x=1774519445;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AuL6cGxv8hO26vrrFZgV4HgLSGxYGB371+xstAsQUlA=;
        b=ob3KdpHZvbGt6NJT2N0fdYHmdpprZ0MF245mbkFAEFMQCBw4lVr4siNfPg2lFJgX9c
         UWoRGFEG7/nz5xrHBaINutEXW7sHdCBp8NgMFbxy3mMbBUdTsq6jQpAqYexgXbVRYS5L
         nnsh36AIXV2lHekmVOxE0hrtMiiK2KbKIvFabPDbdUCnuqh4a7IOhdphYsF2Bi9Ogq5D
         j0NKX2ROjXHDGe8WP7tIgFT2+FN5umVQz8W4E9E+MTBXU9AU8ayU9IJPhKpDfG14nVzh
         Ky5riGBdKyFkINazcxgKcDmXAnlnBofHdbDEWCtZ4KRcPmaCqMxRpBXLwp6hRF6vlE/m
         rwDg==
X-Forwarded-Encrypted: i=1; AJvYcCUT0vb3jz0hyF+1kVGbJr4ZNxijauz4rt9aKB6NPAtBIiZDz8Z25mSacGs4T3ts8D2zoU5ad98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzdwig2ZUXb1V7Vw7U+WAcY4ywmqZRkWBIsXNS00oNyydBlTVq
	U+2AE8CHz7YDFfDDE4J/KbSV0Qj6EA9FwsUnFx5U7a/gDN6+GtLzYll0wDZEBL0b8rI0vRGP1Ei
	FaX412ChRSzJJc+GUqN0Mp5uylzxy76MuK+KM/1Wo264Wye15nxibfT5Y3A==
X-Gm-Gg: ATEYQzwOoU0G4TNdoHq4GsAq5rXAhIUodnUM8XATPBqiiPNTAuifiZNgAjtE/36xFne
	ppX1EdqRb4txCoEaKPNe1KijLwvMShsVvqxRe0m0V4YRVUgdVm46zUqzv6dxlpXffZKBbg/ajpJ
	NCGnmGc2geWvwrNuPrsxDxrjGYP27OJCsab8UQeBdOczxC+Hq/2uQOpToToKW/AFTD1j7rAW/pY
	xJRGD4hcNE4jtKjx77cyz1Kyg4CPTSH1GSiPUJvTtvu5j13HHpanr9fSRPbEHl8FVLhboiG0BL3
	p2b/KMjCEHrhUsWbMboA99rCYQQXVHLitPmtE1psqCcZ1SwObghCvl2mjQ0dCclMVrw4RSYNHZJ
	7hNHv0HQuSx9vdkqhykin8LXrGMVqMOuzzcdeKPgqIZKDJD3w
X-Received: by 2002:a05:600c:3516:b0:485:3fe6:2209 with SMTP id 5b1f17b1804b1-486f4427146mr104986025e9.11.1773914645113;
        Thu, 19 Mar 2026 03:04:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:485:3fe6:2209 with SMTP id 5b1f17b1804b1-486f4427146mr104985395e9.11.1773914644542;
        Thu, 19 Mar 2026 03:04:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c351f8sm52909605e9.6.2026.03.19.03.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 03:04:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D72C55A3493; Thu, 19 Mar 2026 11:04:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@fomichev.me,
 j.koeppeler@tu-berlin.de, mfreemon@cloudflare.com, carges@cloudflare.com,
 kernel-team <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH net-next 2/6] veth: implement Byte Queue Limits
 (BQL) for latency reduction
In-Reply-To: <cbfc927d-0b96-4788-8bf6-8a2ffa4dd9f4@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
 <20260318134826.1281205-3-hawk@kernel.org> <87ms05nrdw.fsf@toke.dk>
 <cbfc927d-0b96-4788-8bf6-8a2ffa4dd9f4@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 19 Mar 2026 11:04:02 +0100
Message-ID: <87h5qcnnjh.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269391-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,toke.dk:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7E982C945F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 18/03/2026 15.28, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> hawk@kernel.org writes:
>>=20
>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> Add BQL support to the veth driver to dynamically limit the number of
>>> bytes queued in the ptr_ring, giving the qdisc earlier feedback to shape
>>> traffic and reduce latency.
>>>
>>> The BQL charge (netdev_tx_sent_queue) is placed in veth_xmit() BEFORE
>>> veth_forward_skb() produces the SKB into the ptr_ring. This ordering is
>>> critical: with threaded NAPI the consumer runs on a separate CPU and can
>>> complete the SKB (calling dql_completed) before veth_xmit() returns. If
>>> the charge happened after the produce, the completion could race ahead
>>> of the charge, violating dql_completed()'s invariant that completed
>>> bytes never exceed queued bytes (BUG_ON).
>>>
>>> Whether an SKB was BQL-charged is tracked per-SKB using a VETH_BQL_FLAG
>>> bit in the ptr_ring pointer (BIT(1), alongside the existing VETH_XDP_FL=
AG
>>> BIT(0)). The do_bql flag from veth_xmit() propagates through
>>> veth_forward_skb() and veth_xdp_rx() into the ptr_ring entry. On the
>>> completion side in veth_xdp_rcv(), veth_ptr_is_bql() reads the flag to
>>> decide whether to call netdev_tx_completed_queue(). Per-SKB tracking is
>>> necessary because the qdisc can be replaced live (e.g. noqueue->sfq or
>>> vice versa via 'tc qdisc replace') while SKBs are already in-flight in
>>> the ptr_ring. SKBs charged under the old qdisc must complete correctly
>>> regardless of what qdisc is attached when the consumer runs, so each
>>> SKB carries its own BQL-charged state rather than re-checking the peer's
>>> qdisc at completion time.
>>=20
>> It's not completely obvious to me why BQL can't be active regardless of
>> whether there's a qdisc installed or not? If there's no qdisc, shouldn't
>> BQL auto-tune to a higher value because the queue runs empty more?
>>=20
>
> When net_device don't have qdisc we hit this code path:
>   - [0]=20
> https://elixir.bootlin.com/linux/v7.0-rc4/source/net/core/dev.c#L4806-L48=
52
>   - Notice the check if(!netif_xmit_stopped(txq))
>   - resulting in "Virtual device %s asks to queue packet!"
>
> We cannot unconditionally track BQL as calling netdev_tx_sent_queue()
> can result in setting STACK_XOFF.  Resulting in above code dropping
> packets and complaining.  (It have no qdisc to requeue store back-
> pressured packet).

Ah, right. I realised the packet would be dropped, of course, but I did
not realise the stack would complain. That seems... odd? Why not just
get rid of the complaint instead of having this kludge to work around
it?

-Toke


