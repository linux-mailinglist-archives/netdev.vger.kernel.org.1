Return-Path: <netdev+bounces-90931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D58B0B6C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF062823B0
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FDD15B97E;
	Wed, 24 Apr 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmAIRmS7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715514A0B3
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966384; cv=none; b=eGpQTOuC8E/VG3VNnjMHo2J5vl4wAsgzujfGSYOHKOPMne77jG+SIqQ0Cy0svGw9XP0b5Oi87T3nvT75n7va2NcVojFAH6bISBlaqDYVOmHcrcNUxy9YryiMz1fDxqB7AfMOLHEuVolnlyS/Y5PPw5dt9vuk72uTNP9mfat71D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966384; c=relaxed/simple;
	bh=s5smDmGlrOUrUIs3ZUfLRW7r5ZxF9jNevWI46HKF8fQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2USC4IF63eCRtH2UA4wYUfRteMqr710Zrkg8S40b3/ivds0QpV77OXO8BrR9n6hLjUkpQZq1X6rwJBpeliojUyf1oapJql2vFa/Z/aynq/Su9DmFaCU4E2rkYDgJ3WG0e6yjWO01zkFj5Yb7qNx56h2eE8iFdUObz0mwZ9+6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmAIRmS7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E7gDgcmG9i/YBiLpCKkd1xNuy2OnX/XDkF+naXSQ0sA=;
	b=fmAIRmS7vz69UPeFlqUzuvtx3KHQFlu8yPQaQ1UWIiNmbIxMJOK4qmUw/gssdl/1vbsyc1
	A4hKBymRCpr66DXP28brdf0NoVWyip3BmHs9WG/3k00saJ6UslIAyStBEXtKQ4ArMs9Wal
	Ce1gP4/c8BV3zfleRIyyQ2tj8IET7dA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-O8vV7G7DPsGYAy__GpubSg-1; Wed, 24 Apr 2024 09:46:20 -0400
X-MC-Unique: O8vV7G7DPsGYAy__GpubSg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-349a31b3232so908121f8f.2
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 06:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966379; x=1714571179;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7gDgcmG9i/YBiLpCKkd1xNuy2OnX/XDkF+naXSQ0sA=;
        b=t8zmY5J4VmX2eqafG3dwsRxFKCTlAb6RQ2kx7b0yx/8kmJiDAhOqVyuoBw/j84cgH+
         lZ1bxD4w31XenwMy2NxohpBcbJT4RTEkj2tnviS7NrKcSicS9CyvkKMLznYOa9NiEv6S
         DMINCEC5dRgcNFHGJ+0gVVCHggutLoWrLynkZZxYZftXilxbp+naBZaGMmN8yo56QKlJ
         VtQt5SxJCE6nHK04rnlI8g2poFBCg8lFtBbOScgqqA9o2XGZCqm6G0uCIUiI8ifbuJm1
         ArlyYzLyOalZlwaZPNruBsQKqTnVq26+TUJcDN4UwSjdbtOHKjNr/pY1CG1haG7sjYSm
         tP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqNJPbkPKGzS5WEQ7IPkARaCyaRblyzK2n3h7T/FuprQrB6fQr+S743RJDtELjfdBjfplDr8oFpPL5KXwY1xI6bZrDqQTT
X-Gm-Message-State: AOJu0YzbB337v0qigngKxUfoWnVt9xJlkWw5ylcWKX6UCYBCqOv51HN7
	5wQ96ccPoC2jbLzoW4QgthSD2LfglFMm2qnQZVOZ+vi0PFxt5DxeVgmah/HtJt691k8UIjMAYdU
	nH/11Yc2V2hMV02exsX1rARQGSs+ODzhqCX7iAgDf9tVIdAQeNLhaJADrs9ypkg==
X-Received: by 2002:a05:600c:3547:b0:41a:3150:cc83 with SMTP id i7-20020a05600c354700b0041a3150cc83mr1738205wmq.2.1713966379370;
        Wed, 24 Apr 2024 06:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3E268H5dREiOJEtmq9U9phTUFGH+UxiTY9gkDQGms0KfJKVyBZYnRYJh3zq6Yz725PvORaw==
X-Received: by 2002:a05:600c:3547:b0:41a:3150:cc83 with SMTP id i7-20020a05600c354700b0041a3150cc83mr1738187wmq.2.1713966378917;
        Wed, 24 Apr 2024 06:46:18 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id z26-20020a05600c221a00b0041a63354889sm932463wml.1.2024.04.24.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:46:18 -0700 (PDT)
Message-ID: <caaf8d102fc520116d66121b7285c191802199c0.camel@redhat.com>
Subject: Re: [PATCH net-next] net: add two more call_rcu_hurry()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Joel Fernandes
 <joel@joelfernandes.org>, "Paul E . McKenney" <paulmck@kernel.org>
Date: Wed, 24 Apr 2024 15:46:17 +0200
In-Reply-To: <CANn89iJJEp9MiRrxzwkd7w-nHK7iQ42qGco3e3QhrOZmOaa7RA@mail.gmail.com>
References: <20240423205408.39632-1-edumazet@google.com>
	 <77b16b5ffdc932a924ef8e6759e615658cdbc11b.camel@redhat.com>
	 <CANn89iJJEp9MiRrxzwkd7w-nHK7iQ42qGco3e3QhrOZmOaa7RA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 15:01 +0200, Eric Dumazet wrote:
>  Hi Paolo
>=20
> On Wed, Apr 24, 2024 at 10:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> > On Tue, 2024-04-23 at 20:54 +0000, Eric Dumazet wrote:
> > > I had failures with pmtu.sh selftests lately,
> > > with netns dismantles firing ref_tracking alerts [1].
> > >=20
> > > After much debugging, I found that some queued
> > > rcu callbacks were delayed by minutes, because
> > > of CONFIG_RCU_LAZY=3Dy option.
> > >=20
> > > Joel Fernandes had a similar issue in the past,
> > > fixed with commit 483c26ff63f4 ("net: Use call_rcu_hurry()
> > > for dst_release()")
> > >=20
> > > In this commit, I make sure nexthop_free_rcu()
> > > and free_fib_info_rcu() are not delayed too much
> > > because they both can release device references.
> >=20
> > Great debugging!
> >=20
> > I'm wondering how many other similar situations we have out there???
>=20
> I think there is another candidate for inet_free_ifa()
>=20
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 7592f242336b7fdf67e79dbd75407cf03e841cfc..cd2f0af7240899795abff0087=
730db2bb755c36e
> 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -231,7 +231,7 @@ static void inet_rcu_free_ifa(struct rcu_head *head)
>=20
>  static void inet_free_ifa(struct in_ifaddr *ifa)
>  {
> -       call_rcu(&ifa->rcu_head, inet_rcu_free_ifa);
> +       call_rcu_hurry(&ifa->rcu_head, inet_rcu_free_ifa);
>  }
>=20
>=20
> >=20
> > Have you considered instead adding a synchronize_rcu() alongside the
> > rcu_barrier() in netdev_wait_allrefs_any()? If I read correctly commit
> > 483c26ff63f4, That should kick all the possibly pending lazy rcu
> > operation.
>=20
> synchronize_rcu() could return very fast, even if queued rcu items are
> still lingering.
>=20
> I tried the following patch, this does not help.
>=20
> Were you thinking of something else ?

I'm not sure if the _expedited() variant implies the call_rcu_hurry()
needed to flush the pending lazy callbacks. My expectation was "yes",
but quickly skimming over the code hints otherwise.

Additionally, re-reading the 483c26ff63f4 changelog, I now think
synchornize_rcu() will kick the pending lazy callback only on the
current CPU, which should not be enough here.

I guess your original patch is the only option.

Thanks for the additional investigation,=20

Paolo


