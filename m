Return-Path: <netdev+bounces-74879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4E8672BF
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7888B2AF4A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D31D52B;
	Mon, 26 Feb 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXHeBuy+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306091D54B
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942777; cv=none; b=IUj7Ch+3n6SHMktsxlaO4njBaE5FdVWXZF+1wJkblJH43FeDj5QXihuc3Tb2W14jlHdKgk2soUEBFr8mdkNRJYlUZjoa7D+bSbMCxJDhfXTUqEIInWKLtm5SNh9lVsmug+m9sxNa3d2oX2B7pme9vVFfIL7OxIvRuRupJlcpfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942777; c=relaxed/simple;
	bh=LiSkPDsK0YRKQ2b62s4C2k2tHtSyGqvlAWpIA/tkZq8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UkLWFc2Rt5TeJ6FiunW1no4r3s/7WqPMv8lr1Z3iCN40WJPAG7XiAzTttPdbMzBEzBKdZy1RAjTHapVFGfkxNK+4gTfDxQRfLAtOW2rAICaiHX1o8l6t8BIDSIZAoacJh9/6DmvfBrNcKl/EpQxwax0MEUEq3mJtSMMOEt0W3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXHeBuy+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso362961666b.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 02:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708942773; x=1709547573; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl30HSs8opuKoFzq4M/y4nKYc0opbCv/ypBIuWYZOgc=;
        b=fXHeBuy+bdrfd7r3pZO/+gOUQdU87jbwno2VSiCQNC9hnjiA0fqmiU2sHIdnw+duSs
         P2AFx4OfuvRiRVgNEfNRKSoUEJJHJTf9h5ra8xsbQbjJ4JiNrt0Qvxr9UEGwV0cysxid
         qyIqDi0nMWPnDlytLJoPkYP/LzZtXtpFflA31LWB2it1LKT3Ja/SkpoLauL0izrNFyEB
         mMGapA+JSlB7qzFjiU4CzH0tL9LDIaXPL0Kx4GT6FkQWZLuTBKCBsXrUuRqURcb4rgwy
         oeXrvjMFUcMGhCgdp+RdexGUVLa14ilHKsqtGQDnPmsVYdcXkUlvH/bHtVc3c5KsfF+V
         yjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708942773; x=1709547573;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl30HSs8opuKoFzq4M/y4nKYc0opbCv/ypBIuWYZOgc=;
        b=IS1UL6OL1lbfMJQ8+9OIR/eBGYcmMeGUWjzh5B4Q1mIUjyW17RgmWw24DGJsRbkkhw
         6JJcp6vHPVuBkPeXGTu9G2cUBP4Z7ZY8yR0Gso1DQZGa3C16Y1eypJDJ3IvtqKf6ZOYQ
         4RPASmBTqKt2fQFzYdMZgnLhB1+cDQZtLy8fkO1QAmBP36BQSy9Beg4ImoI74tyk6wHW
         c1gL1XMklFlTKTLKkeZsP3qmfstnAg/46kFJkFY/x+EnvMBEWrNehSyVxVbdyl4vguP8
         Ly0GJj7KwVB0uT8Kop5mYcGv9ZyV0e3Angx1xEY3LWceeMT2jmr/osm0HKEDYJAvxDl1
         gGoA==
X-Forwarded-Encrypted: i=1; AJvYcCV0SQoWdY/sQx7tzakrCuLVsLDUs+FQQizlMujgv9m6cSSfjy4gT3Up9ob9nyL2p0ADvn3jIpRnM8bYrkgyCenCmoPRsdh4
X-Gm-Message-State: AOJu0Yx1hKfqiryjMJWcTOvPHVvkjb1n3Gftz0K9uJQjZv6yQoTFRj/H
	7/YnRWd7KeNRWswU/VdqF5meCWcsa7IXMNrFg1ll6tVdgJkCxLed
X-Google-Smtp-Source: AGHT+IGsSFDGhAzE9sBukMit+zs1dWO5zlIZfEAGDZWGX0g3ueTV/AlZsfphxTPZgvP9LWSFJry81w==
X-Received: by 2002:a17:906:6d8c:b0:a3d:9ed3:dd1f with SMTP id h12-20020a1709066d8c00b00a3d9ed3dd1fmr4339226ejt.18.1708942773132;
        Mon, 26 Feb 2024 02:19:33 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:ac76:79a7:ef5d:d314])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906280500b00a3e0b7e7217sm2264888ejc.48.2024.02.26.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:19:32 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 01/14] rtnetlink: prepare nla_put_iflink()
 to run under RCU
In-Reply-To: <CANn89i+PPT7QDQKs9c-fUeshr_+Heh_mCLfFxwCEtbnUM5fjxA@mail.gmail.com>
	(Eric Dumazet's message of "Sat, 24 Feb 2024 12:08:56 +0100")
Date: Mon, 26 Feb 2024 08:59:47 +0000
Message-ID: <m2bk83ob24.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-2-edumazet@google.com>
	<m2wmqvqpex.fsf@gmail.com>
	<CANn89i+UXeRoG4yMF+xYVDDNv-j2iZYTwUogQWsHk_OiDwoukA@mail.gmail.com>
	<CAD4GDZyV5H4RK_8H2CiUfEj_DSu=w12HqeCzy+2mmu3cMivGww@mail.gmail.com>
	<CANn89i+PPT7QDQKs9c-fUeshr_+Heh_mCLfFxwCEtbnUM5fjxA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:
>>
>> And use of them here:
>>
>> > diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
>> > index 98c669ad5141479b509ee924ddba3da6bca554cd..f7fabba707ea640cab8863e63bb19294e333ba2c 100644
>> > --- a/drivers/net/can/vxcan.c
>> > +++ b/drivers/net/can/vxcan.c
>> > @@ -119,7 +119,7 @@ static int vxcan_get_iflink(const struct net_device *dev)
>> >
>> >       rcu_read_lock();
>> >       peer = rcu_dereference(priv->peer);
>> > -     iflink = peer ? peer->ifindex : 0;
>> > +     iflink = peer ? READ_ONCE(peer->ifindex) : 0;
>> >       rcu_read_unlock();
>> >
>> >       return iflink;
>>
>>
>> > We do not need an rcu_read_lock() only to fetch dev->ifindex, if this
>> > is what concerns you.
>>
>> In which case, it seems that no .ndo_get_iflink implementations should
>> need the rcu_read_* calls?
>
> rcu_read_lock() is needed in all cases a dereference is performed,
> expecting RCU protection of the pointer.
>
> In vxcan_get_iflink(), we access priv->peer, then peer->ifindex.
>
> rcu_read_lock() is needed because of the second dereference, peer->ifindex.
>
> Without rcu_read_lock(), peer could be freed before we get a chance to
> read peer->ifindex.

Thanks for the detailed explanation.

