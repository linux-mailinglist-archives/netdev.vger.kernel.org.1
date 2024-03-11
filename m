Return-Path: <netdev+bounces-79192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EF38783AE
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46E41C21B16
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ABF446D1;
	Mon, 11 Mar 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWKnN6KR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4375446B3
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170377; cv=none; b=Nn5VCAnO2/fDXKUQ6qM5F3nnOAMIlfEPwmcYQWDE61QmqP1wqi6omNT1YO7X0WS168HKV+84Tmz1yjskT0TFjxTYOSnxEZCmB+Q/gBDC4Wr2tOJ+aco5ujKGgiaCAN3bjLJCaxgRyz/7zHoAEMQaZzpm0EmWbuVxJarqWYRvOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170377; c=relaxed/simple;
	bh=6purTBGXMSzgXgDUt3noQW//iEtgHnYwOwtaTihgO5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ueXJB6KGz1XLKDpng1OXml+lWI8eTFUS5DnFo05XU3CwK202wevMoqku6WsJ6qz82TOvlkoqJHBb40+SMJAZ6WDPHnJjrmTTlRieGdj9oEvhbtNs+RJvr7TNX8J5kCtSX4BKky5RzzhyFvEd3xArZj1JT1zrY8h2IvQ8231og48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWKnN6KR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710170374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WwvIiwXdQYZuIUIWyh9vmS2DWFC4qIuMLUdct0AxWw=;
	b=iWKnN6KR+U7rwT8IR3DfFBiq4WsEbYZOKmguDrctIWhFkM0xiNwjWEy8bd0xhyjQrlMNFV
	HqBOgvMzvRLGv88HQQxskVo02mzKKRiGwdGp0X8c7JGC4RzTiVokhHjx5GAiMaInZqqaiH
	V3V7xvgNzsEMlAeYtldSMd4yQhTIQVw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-nJ0954ixMZKGBcWIQmQ68A-1; Mon, 11 Mar 2024 11:19:33 -0400
X-MC-Unique: nJ0954ixMZKGBcWIQmQ68A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a462e4d8c44so57958166b.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 08:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710170371; x=1710775171;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WwvIiwXdQYZuIUIWyh9vmS2DWFC4qIuMLUdct0AxWw=;
        b=UqHruPVmILB0RbPWOfWbF0KWFxE72YrMDWYjHa05GHsZ1HOaQ+K/kk3cX3nVtG8BpL
         0jH62VNvjZBSBFlQ5RJ+c5mI+ltWZTL/tM0DuVpSf86p4EegJeB5Vh+hIpx1fBx3O6yz
         xzNhpe0WeXXRaz5CW5MVP7GQjH6z6Q67AYEdDrrEa2w5X8THE6Axep/l4VknQbHh4eVc
         CnTZj3U2wVmRpy2TVnW3dp14D15khDbmfomPmgODokXZ1tJyJobRYPwjkknLKrWh/gQg
         gD3qP3Ft9kailPRyFHIPAN4FqjrAwZ860U29IrTt+kU9i+Qd90wOVun9iJOYTVAEBku0
         b7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV2X5QcPHNJXfvo0yIQELAcNrW0cLwTE1knyLVGZlf95doL55uQq78VSsthtRgyNKKHWXfq1zcByDcGagiKtSM4fad4KgRG
X-Gm-Message-State: AOJu0Yxe8YAnQMVYBDfy/BC6gWcRKov12gxgoqTFua+nuW4aTkYjUbxj
	vTxE+BnWXecAFLYcEDk3Hcsj4gKYDnheMBJWyK4Gee5nJSS6WmpPmisb7G5LpZ0kKx+AmEhgksS
	MOVMzgvSnye8cY+ZofDKP9heZhJ7aOaZfsX9IYfOr6+pZ5ThTYjdnP7bGDnFCYQ==
X-Received: by 2002:a17:906:66ce:b0:a3e:d5ac:9995 with SMTP id k14-20020a17090666ce00b00a3ed5ac9995mr4131441ejp.59.1710170371674;
        Mon, 11 Mar 2024 08:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMpEjDw/QZvVMgViaMGK3VHe9J5FVW2b/sdnNQOFRhbckT6T3ow18it/xCh22vxdRPTjXofQ==
X-Received: by 2002:a17:906:66ce:b0:a3e:d5ac:9995 with SMTP id k14-20020a17090666ce00b00a3ed5ac9995mr4131432ejp.59.1710170371345;
        Mon, 11 Mar 2024 08:19:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gc14-20020a170906c8ce00b00a4629cab2b9sm963969ejb.4.2024.03.11.08.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:19:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 98EFF112FA3B; Mon, 11 Mar 2024 16:19:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next v2 08/22] ovpn: implement basic TX path (UDP)
In-Reply-To: <0273cf51-fbca-453d-81da-777b9462ce3c@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-9-antonio@openvpn.net> <87ttlgrb86.fsf@toke.dk>
 <0273cf51-fbca-453d-81da-777b9462ce3c@openvpn.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Mar 2024 16:19:29 +0100
Message-ID: <87edcgre2m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli <antonio@openvpn.net> writes:

> Hi Toke,
>
> On 08/03/2024 16:31, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Antonio Quartulli <antonio@openvpn.net> writes:
>>=20
>>> +/* send skb to connected peer, if any */
>>> +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *s=
kb, struct ovpn_peer *peer)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (likely(!peer))
>>> +		/* retrieve peer serving the destination IP of this packet */
>>> +		peer =3D ovpn_peer_lookup_by_dst(ovpn, skb);
>>> +	if (unlikely(!peer)) {
>>> +		net_dbg_ratelimited("%s: no peer to send data to\n", ovpn->dev->name=
);
>>> +		goto drop;
>>> +	}
>>> +
>>> +	ret =3D ptr_ring_produce_bh(&peer->tx_ring, skb);
>>> +	if (unlikely(ret < 0)) {
>>> +		net_err_ratelimited("%s: cannot queue packet to TX ring\n", peer->ov=
pn->dev->name);
>>> +		goto drop;
>>> +	}
>>> +
>>> +	if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
>>> +		ovpn_peer_put(peer);
>>> +
>>> +	return;
>>> +drop:
>>> +	if (peer)
>>> +		ovpn_peer_put(peer);
>>> +	kfree_skb_list(skb);
>>> +}
>>=20
>> So this puts packets on a per-peer 1024-packet FIFO queue with no
>> backpressure? That sounds like a pretty terrible bufferbloat situation.
>> Did you do any kind of latency-under-load testing of this, such as
>> running the RRUL test[0] through it?
>
> Thanks for pointing this out.
>
> Andrew Lunn just raised a similar point about these rings being=20
> potential bufferbloat pitfalls.
>
> And I totally agree.
>
> I haven't performed any specific test, but I have already seen latency=20
> bumping here and there under heavy load.
>
> Andrew suggested at least reducing rings size to something like 128 and=20
> then looking at BQL.
>
> Do you have any hint as to what may make sense for a first=20
> implementation, balancing complexity and good results?

Hmm, I think BQL may actually be fairly straight forward to implement
for this; if you just call netdev_tx_sent_queue() when the packet has
been encrypted and sent on to the lower layer, the BQL algorithm should
keep the ring buffer occupancy just at the level it needs to be to keep
the encryption worker busy. I am not sure if there is some weird reason
this won't work for something like this, but I can't think of any off
the top of my head. And implementing this should be fairly simple (it's
just a couple of function calls in the right places). As an example, see
this commit adding it to the mvneta driver:

a29b6235560a ("net: mvneta: add BQL support")

Not sure if some additional mechanism is needed to keep a bunch of
encrypted packets from piling up in the physical device qdisc (after
encryption), but that will be in addition, in that case.

-Toke


