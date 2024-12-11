Return-Path: <netdev+bounces-151057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C0A9EC9C0
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696EA167E9F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E861DF755;
	Wed, 11 Dec 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V31TCMuv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3B236FBE
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910910; cv=none; b=Pt5z2O1ElXmmMmHDAxXLlBt98Zm935Vy+ZDarwA7gRSpEtDU4tnYKYnGaEWM5TjdXgvNB8uchGZ09YgVgTsjLQLW2Qgj8lGG4xeeTqej3X1DcnR7R3o8P8es9uNrTDuLb+recHaMZRvA7lJWv7SjfMGUl2JcLCR0HZofoJwbEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910910; c=relaxed/simple;
	bh=hGxEwZFcgw+OIxs4XY/stYiI3kdgLhPXYpx3ZnemYyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfq1kNWifxvvUyBPElQOAAyl6oxO0YDrqbuF0SMvuYlOlGkNJFTX5ry/gLNv9Y91Xu0lqLzyD4lW1L0Y+BczFIA2vPa2tiLatPGxuh4teGC3Zt0FNjTwkckcK45Im8pH8u9R0Kgz/Ated1XBmHBiLGfs5thgZeOnKfOe219jWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V31TCMuv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733910907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGxEwZFcgw+OIxs4XY/stYiI3kdgLhPXYpx3ZnemYyk=;
	b=V31TCMuvEmNV3+aZfpttM76NjSBlih0jiqVJvZcDEs6n8D0QJazN+eTYwDGUpnFpn3/1yi
	YPbe+jK/61srwa8HpxYHHuRgId1bL2z8NHJORSLsEPKOZtGfwMlkHXo0EPZGYcDAvKgJ2J
	kO7vRueS2pIL85Xu62pHJW4xwmLYAdc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-SYm0ayfIPYy0NR0xzXlb_w-1; Wed, 11 Dec 2024 04:55:06 -0500
X-MC-Unique: SYm0ayfIPYy0NR0xzXlb_w-1
X-Mimecast-MFC-AGG-ID: SYm0ayfIPYy0NR0xzXlb_w
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361efc9d23so3389435e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 01:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733910905; x=1734515705;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGxEwZFcgw+OIxs4XY/stYiI3kdgLhPXYpx3ZnemYyk=;
        b=FpvJKkL3hFpRCnXytHphuMMTxZChfpJFoXFkJux+LzyyKTGr3KNDAblZQ8FtK1bXYk
         PI0psRXLqLzDjup9N04yjK1AUqkgAi6fDpr5t31B5ucmVVdqyfofdmcGg80gAkEoQnKl
         UAaObQujN97+qV2j1A05KjiZ3Yr7Ub5g/OgvdgC8V+GmhFdvRPH0WExhRO/kUAzGN7cJ
         ZB7tn5+rkdIMFKl1gfUFj2Q+SxyqTxwC2AlAYnvbnqLdiAm09W4iomY37rCs+4aO2YQJ
         +72UUppwxzWT62C5WyXqYFY3J0Ud37YqS9b5hbu1zHIE14YzDCZ8SJQ2r0tpy/hLehMj
         zlBg==
X-Forwarded-Encrypted: i=1; AJvYcCW8/cUVZBasbLrSf4xo+zgExMvU+w6fw1Camqmp481/rcv52LfPLM0nJqo+ZsoFjUmSy5gUp/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbA84OP9EsJjeM9Lj41KmnPE2I/8VOTokxMivQKsN4ssfNd0Eg
	aFuOHrcZhvfkzRqmDcWwieerWEKVGykt17KlD9dw2UJGtl+Ez5npDfdW8s43v/AI7vPa71qQLiO
	8o7729A0Dnhc3NY1P2RGgAYkZ3pikOVkTzwyVnEzkAOgmGCK5GGA5Ag==
X-Gm-Gg: ASbGncvFhbQ5t1jxoqRIUIei2ojTAoOM/QQpQvOhhLO97qgYZvPuh2zvhjNq1RuTIu+
	YnzSHK75SfLz0wmmRT8hkyqI70RY+ptQa8j5IGriuqn3GuQxZLegpP4nVPf/cEOn22TUtqptTSn
	riJWqby2JThFI7X23AsjNEaO/etR9uXuE0Vksmw3vvF9u83BioZV6Dv0QHKw8Gs2wA9GzKHGSss
	DsIC42fMmi8FHm56bWgv0Tcl16h+xfmXWxqvr/vIQ9VIYZzZ7V0IhKxgvWh1ryv6/TOENJxcP+J
	1F4=
X-Received: by 2002:a5d:6da4:0:b0:386:1ab5:f0e1 with SMTP id ffacd0b85a97d-3864ce968c0mr1757263f8f.14.1733910905413;
        Wed, 11 Dec 2024 01:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWcbbdKQFeVBc5klJwqbHNmJKc5NGnuoW0xJ3gO9Ldk9/d5zthhScXLmcTcJPA97zDpXrgmQ==
X-Received: by 2002:a5d:6da4:0:b0:386:1ab5:f0e1 with SMTP id ffacd0b85a97d-3864ce968c0mr1757234f8f.14.1733910904981;
        Wed, 11 Dec 2024 01:55:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c384esm897022f8f.56.2024.12.11.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:55:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 52C3B16BDC45; Wed, 11 Dec 2024 10:55:03 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dave Taht <dave.taht@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 cake@lists.bufferbloat.net, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [Cake] [PATCH net-next] net_sched: sch_cake: Add drop reasons
In-Reply-To: <20241210172802.410c76a6@kernel.org>
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
 <20241209155157.6a817bc5@kernel.org>
 <CAA93jw4chUsQ40LQStvJBeOEENydbv58gOWz8y7fFPJkATa9tA@mail.gmail.com>
 <87a5d46i9c.fsf@toke.dk> <20241210172802.410c76a6@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 11 Dec 2024 10:55:03 +0100
Message-ID: <87sequ5ytk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 10 Dec 2024 09:42:55 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > While I initially agreed with making this generic, preserving the qdis=
c from
>> > where the drop came lets you safely inspect the cb block (timestamp, e=
tc),
>> > format of which varies by qdisc. You also get insight as to which
>> > qdisc was dropping.
>> >
>> > Downside is we'll end up with SKB_DROP_REASON_XXX_OVERLIMIT for
>> > each of the qdiscs. Etc.=20=20
>>=20
>> Yeah, I agree that a generic "dropped by AQM" reason will be too generic
>> without knowing which qdisc dropped it.
>
> Why does type of the qdisc matter if the qdisc was overlimit?

Well, I was thinking you'd want to figure out which device it was
dropped from, but I guess you have skb->dev for that (and counters).

>> I guess any calls directly to kfree_skb_reason() from the qdisc will
>> provide the calling function, but for qdisc_drop_reason() the drop
>> will be deferred to __dev_queue_xmit(), so no way of knowing where
>> the drop came from, AFAICT?
>
> Can you tell me why I'd need to inspect the skb->cb[] in cake if packet
> is overlimit? Actually, none of the fields of the cb are initialized
> when the packet is dropped for overlimit, AFAIU.
>
> If someone is doing serious / advanced debug they mostly care about
> access to the qdisc and can trivially check if its ops match the
> expected symbol. (Speaking from experience, I've been debugging FQ
> packet loss on Nov 23rd.)
>
> If someone is just doing high level drop attribution having to list all
> possible qdiscs under "qdisc discard" is purely pain.
>
> Can we start with OVERLIMIT and CONGESTION as generic values and we can
> specialize if anyone has a clear need?

OK, I'll respin and drop CAKE from the names of those two...

-Toke


