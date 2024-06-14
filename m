Return-Path: <netdev+bounces-103569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DC4908A9F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897AB1C22A33
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2919147E;
	Fri, 14 Jun 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/gefT1F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13B12EBCC
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718363053; cv=none; b=SKilfSpgox2ChFv7GpEwPHkkE7XE6LkyxopHunXa9FMId7BglOWArtV15KJmuPaedloyeLzFuloMe+nGT6yWwYPMfh08ZxZQILevpDEhulLjlntRZPZ5gNesoBCzRP4ZSTyI9qu4+L7vomKBSBYDSpTsAjNxiIh6DHJjRXhzUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718363053; c=relaxed/simple;
	bh=/xx5SQ/fsoe6VS26imoOvJ7hvHA8KB0HovewGOFoVOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZeLkcmbzxS3l663BiLeqczBrrGk6Bodg07ZhB1lgT3JNamMlQRhcCTCQmEXGboTYiJoP0Faw07d0lq3MPtPnZRE1Y5Ysgq4dsGizHShr3t6z2XAPrn6Gpszwm8HsvEl5SUTgs133I0kmoy8FbX1JXtARpfZL/ZkwmTK9PF+9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/gefT1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718363051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2XzgxrCZ3tAVaoPL4rAAtL1hRw9y/2A0vDtyg+qNndY=;
	b=J/gefT1FqjwH2o3zKJQwsLJWAVLZpG+nHQF+ogwfP1wWX90XpPFjk0HhErQpTIATNB1NrY
	YJEmxTv+jSqtbL7qcv2Ckcu5uLRHsJboQDzqhtQjUdltbkv0GJm6fJR3P9ya239NwIngCK
	1Ymqio76nnfzdKLI2coT4YTBBbNayOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-O4Q-umNWPPWqWBa49NBGEQ-1; Fri, 14 Jun 2024 07:04:09 -0400
X-MC-Unique: O4Q-umNWPPWqWBa49NBGEQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-354f30004c8so280180f8f.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 04:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718363048; x=1718967848;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XzgxrCZ3tAVaoPL4rAAtL1hRw9y/2A0vDtyg+qNndY=;
        b=vociAUoPJTX9z4FGCWEiwDZVFLSVtmtzPCGK4GHEmZpVLABBqgSM8ies+7wanLbLHU
         dCu/jPZ/OQGCKpEC7EMwsFOaRUMQB+V8WkdTw2I9WeMMzBUg9REEVUdDU7BOqQlTVtVJ
         QPiZO/uXRtOGKY+k3IUEo+XHKn7UUDbLLia2bLaVsbrmPZvH8SywIbZsf8NhZpxWz9n4
         EaBWjLp+W7/U/W6+b5JLVUzENtCcQoXLkNHsndkeA1DMq9109iY74k7Wkr8boSO9n/jO
         0arPPcjtp8zXw4zeDjWsXto0AmAgkCzSK/TH+HEUlOPD3i0gbTvzZcnf34ykyniNQt5n
         HuxA==
X-Forwarded-Encrypted: i=1; AJvYcCX4+9TzT9g9oEEsJgEXsUzNmtwSVC907eEN62AvAAH0LEM3/fOjNU6l8cv2kE2x1X2ho7Uj2xbAeBFiBiRA1Vfi/WAjieWw
X-Gm-Message-State: AOJu0YxnwJFFzzH7HXyIiMJxIcpnWgb17hGBlffsSOc2d6iqH9wsTOcI
	j3F94FgtzMZw26wRO6BcYjWnH5EPg4Qo3LXvZKoOK3GXMl/O7ZfWDycJxPJwNJah15NfNn3bLGX
	MX+ZDYdiRcs07A3GjWyODPvK4rxD5S6hyavMIZsWdz2nKL+7Hxwz1nQ==
X-Received: by 2002:a5d:584a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-3607a76aae3mr1666655f8f.1.1718363048698;
        Fri, 14 Jun 2024 04:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6BByTAjrUC4/Wa15Qq0tfht6entPJgW2ockgqHHNgDsDPnmfp/M1nx4KJS9yKqFu74wHrzQ==
X-Received: by 2002:a5d:584a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-3607a76aae3mr1666636f8f.1.1718363048350;
        Fri, 14 Jun 2024 04:04:08 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210:de1e:fd05:fa25:40db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8b7sm4046414f8f.26.2024.06.14.04.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 04:04:07 -0700 (PDT)
Message-ID: <fe71aefbd50babf1af7c4719f5581e46fce2b4fc.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 08/11] af_unix: Define locking order for
 U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, kent.overstreet@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org
Date: Fri, 14 Jun 2024 13:04:06 +0200
In-Reply-To: <20240611232320.39523-1-kuniyu@amazon.com>
References: 
	<vqp2bzsg2sr6iol4sfbay27trj2gss663yroygrhb6lolmsbqn@sqw732yecjsn>
	 <20240611232320.39523-1-kuniyu@amazon.com>
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

On Tue, 2024-06-11 at 16:23 -0700, Kuniyuki Iwashima wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Tue, 11 Jun 2024 19:17:53 -0400
> > On Tue, Jun 11, 2024 at 03:29:02PM GMT, Kuniyuki Iwashima wrote:
> > > While GC is cleaning up cyclic references by SCM_RIGHTS,
> > > unix_collect_skb() collects skb in the socket's recvq.
> > >=20
> > > If the socket is TCP_LISTEN, we need to collect skb in the
> > > embryo's queue.  Then, both the listener's recvq lock and
> > > the embroy's one are held.
> > >=20
> > > The locking is always done in the listener -> embryo order.
> > >=20
> > > Let's define it as unix_recvq_lock_cmp_fn() instead of using
> > > spin_lock_nested().
> > >=20
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/unix/af_unix.c | 17 +++++++++++++++++
> > >  net/unix/garbage.c |  8 +-------
> > >  2 files changed, 18 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 8d03c5ef61df..8959ee8753d1 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -170,6 +170,21 @@ static int unix_state_lock_cmp_fn(const struct l=
ockdep_map *_a,
> > >  	/* unix_state_double_lock(): ascending address order. */
> > >  	return cmp_ptr(a, b);
> > >  }
> > > +
> > > +static int unix_recvq_lock_cmp_fn(const struct lockdep_map *_a,
> > > +				  const struct lockdep_map *_b)
> > > +{
> > > +	const struct sock *a, *b;
> > > +
> > > +	a =3D container_of(_a, struct sock, sk_receive_queue.lock.dep_map);
> > > +	b =3D container_of(_b, struct sock, sk_receive_queue.lock.dep_map);
> > > +
> > > +	/* unix_collect_skb(): listener -> embryo order. */
> > > +	if (a->sk_state =3D=3D TCP_LISTEN && unix_sk(b)->listener =3D=3D a)
> > > +		return -1;
> > > +
> > > +	return 0;
> > > +}
> > >  #endif
> >=20
> > That's not symmetric.
>=20
> I think we agreed this is allowed, no ?
>=20
> https://lore.kernel.org/netdev/thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziir=
uabvh46f@uwdkpcfxgloo/

My understanding of such thread is that you should return 1 for the
embryo -> listener order (for consistency). You can keep returning 0
for all the other 'undefined' cases.

Thanks!

Paolo



