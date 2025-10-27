Return-Path: <netdev+bounces-233201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F9C0E5F7
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA742684B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3423074BB;
	Mon, 27 Oct 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zy55zd0r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C73074B3
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574203; cv=none; b=oK7FW9lUC+UeVUS7dC94Wgw/wQmQj/LSWKXzDxW5m3huelR4tpZpzl5VSGFi25UWgx/YkSJfIAh1ELnQhbr7NaSglCAKnCYLENiS5bARgAc9LIWp8jFVu/n5Zef/IjS8CMCEuk8lhAhqo3AlDHRk90GnlZMuOqAOFVuedEh6JyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574203; c=relaxed/simple;
	bh=c/b2hszdNWSGGPiPsuah9rJlkGjrnvDUJKdwp/b90Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kgBilUau/8mUbxIOGoMfX9up0Ohdw7PxAEFib9IgYvguXeun/+z+So9yL1V9tjm1s9naucUV7DDkSMwi+WLz6Yzzd/8zA+B0iN6coTpW/Leh8EsARc8caa0fVIKoEC256DCmUuNNhDTlADuU8Z1E5h685UPjwLYX5SkBCyxNVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zy55zd0r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761574201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tg2geA8p0sRFySSG2RXc6meVS/0ic9dT0/zE/JSRh8I=;
	b=Zy55zd0rtdwQ1hiNfZr65SBxqiWPI+h4682gGyGW3deELznEhQO2zt/orJfsjJiBDdCxzR
	BbR4yczmFX/5MqVigP+UFtlI+mZJC0jLnjfP8VERdnhBFCCS4w3nWI6yGwxekFTlCYIMwW
	q9WtUgJRnWnDizdoBce/7dX36QEyrmE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-CyLX0G-TN5ajTrE2lsW6gg-1; Mon, 27 Oct 2025 10:09:59 -0400
X-MC-Unique: CyLX0G-TN5ajTrE2lsW6gg-1
X-Mimecast-MFC-AGG-ID: CyLX0G-TN5ajTrE2lsW6gg_1761574198
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d4025a85dso640590766b.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574198; x=1762178998;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg2geA8p0sRFySSG2RXc6meVS/0ic9dT0/zE/JSRh8I=;
        b=k1sSb5eaBsaFw2RahNWFUxT/Pykb8bKmSdlFVqgmvRlKWLZrHGZ9Ijjy6TYwWV95A3
         XHxqWdVkh1Omc8rQxApteKYgExLaQZARWESnFDHoI6F9n1E0mZaC/iT8MGEj/Y574ejx
         pfFUNd1076omuDoNa2mGo1x7DiyZHIrcjhsEZCXLfRlJ3oYQSfsTFIJAZ4mdaR6dDhP/
         O76wjRRgfdL1Dya70Q3sWh5uJdc/forCq77hlayxwDwYmgsUZvwTPykJ7PoKecBqTrha
         fGW3pa9XfdHkVzfkq/2m3LP2+Oj6jZSsYftyEc9liSVl62k5hydRfsKSX6kHpvnDe4bS
         BHdw==
X-Forwarded-Encrypted: i=1; AJvYcCXBWuRFMGk47Ff1gd9rUPNNzJPSzkfq1fkoSvBq0SuttsD2P4DLAU4p6Zk4rZsrbBGXaelBDwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzG0NoL7yDo3dIzb/owI4alfhRlcLheyE6kmnHTet7otISG+l
	I2I3ZZBA1zsRTF51L1szp/jS4hMTNii4doi0FU/o/HhWP2kaRd09iuIaIFQAwiKEybW0LFuknrf
	5gK719swGhX/fa8RuQVSexypU84TL4w/M0HTxkNelGAd/uXZI7VKmO9G+/Q==
X-Gm-Gg: ASbGncu6TRb5jGPiS7r6C15JiOpAYhPHh4EA6jlBPiTseQ0bhPAe+wUWuw3gU1ZPgxX
	2lGo0nBhimnXcajY48pafl1Ed4RvIOnpwJXyezCENJHmmDhXw2PUEHXUPAWiaVZowUDWpohAB6M
	nteDseIiJGlJXbxTjPvHaZDALyuSHuYGKmotrnt26KHec9a1ToX9rbNawyrM8MzMXS2SKzkgxhE
	Osvirha1J792eSBuzOCieIx2QhQzjqjoXwUiY94GmA4zvMDJGHhEqXNGjlyuNPclEWYxf+gz5S0
	ePHhjwYoAh7WFcAKUufSS8E6WIaeI39RDqwr2Tf+OhY3hvRSlgzJKt082M8Nv61GZic/XLKO2ao
	yGs3Y/249Blg4yGxRUKIJRSJqUg==
X-Received: by 2002:a17:907:3f1a:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b6db9bb910dmr24256766b.5.1761574198275;
        Mon, 27 Oct 2025 07:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/8knjSLXa1SdW98PmeawgWUwZqKG1Ot41zd6Wf0XrBei7Us98gOZPV8rEuLQW16NT4hMD4g==
X-Received: by 2002:a17:907:3f1a:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b6db9bb910dmr24253566b.5.1761574197854;
        Mon, 27 Oct 2025 07:09:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8536cd11sm770722766b.31.2025.10.27.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:09:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1F6EE2EAA54; Mon, 27 Oct 2025 15:09:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 makita.toshiaki@lab.ntt.co.jp
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 1/3] veth: enable dev_watchdog for detecting
 stalled TXQs
In-Reply-To: <b6d13746-7921-4825-97cc-7136cdccafde@kernel.org>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123157173.2281302.7040578942230212638.stgit@firesoul>
 <877bwkfmgr.fsf@toke.dk> <b6d13746-7921-4825-97cc-7136cdccafde@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:09:56 +0100
Message-ID: <87v7k0e8qz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 24/10/2025 15.39, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
>>> backpressure on full ptr_ring to reduce TX drops") have been found to c=
ause
>>> a race condition in production environments.
>>>
>>> Under specific circumstances, observed exclusively on ARM64 (aarch64)
>>> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
>>> permanently stalled. This happens when the race condition leads to the =
TXQ
>>> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue w=
ake-up,
>>> preventing the attached qdisc from dequeueing packets and causing the
>>> network link to halt.
>>>
>>> As a first step towards resolving this issue, this patch introduces a
>>> failsafe mechanism. It enables the net device watchdog by setting a tim=
eout
>>> value and implements the .ndo_tx_timeout callback.
>>>
>>> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() functi=
on,
>>> which logs a warning and calls netif_tx_wake_queue() to unstall the que=
ue
>>> and allow traffic to resume.
>>>
>>> The log message will look like this:
>>>
>>>   veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>>>   veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>>>
>>> This provides a necessary recovery mechanism while the underlying race
>>> condition is investigated further. Subsequent patches will address the =
root
>>> cause and add more robust state handling in ndo_open/ndo_stop.
>>>
>>> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring t=
o reduce TX drops")
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> ---
>>>   drivers/net/veth.c |   16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index a3046142cb8e..7b1a9805b270 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>> @@ -959,8 +959,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int bu=
dget,
>>>   	rq->stats.vs.xdp_packets +=3D done;
>>>   	u64_stats_update_end(&rq->stats.syncp);
>>>=20=20=20
>>> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq)))
>>> +	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
>>> +		txq_trans_cond_update(peer_txq);
>>>   		netif_tx_wake_queue(peer_txq);
>>> +	}
>>=20
>> Hmm, seems a bit weird that this call to txq_trans_cond_update() is only
>> in veth_xdp_recv(). Shouldn't there (also?) be one in veth_xmit()?
>>=20
>
> The veth_xmit() call (indirectly) *do* update the txq_trans start
> timestamp, but only for return code NET_RX_SUCCESS / NETDEV_TX_OK.
> As .ndo_start_xmit =3D veth_xmit and netdev_start_xmit[1] will call
> txq_trans_update on NETDEV_TX_OK.

Ah, right; didn't think of checking the caller, thanks for the pointer :)

> This call to txq_trans_cond_update() isn't strictly necessary, as
> veth_xmit() call will update it later, and the netif_tx_stop_queue()
> call also updates trans_start.
>
> I primarily added it because other drivers that use BQL have their
> helper functions update txq_trans.  As I see the veth implementation as
> a simplified BQL, that we hopefully can extend to become more dynamic
> like BQL.
>
> Do you prefer that I remove this?  (call to txq_trans_cond_update)

Hmm, don't we need it for the XDP path? I.e., if there's no traffic
other than XDP_REDIRECT traffic, ndo_start_xmit() will not get called,
so we need some way other to keep the watchdog from firing, I think?

-Toke


