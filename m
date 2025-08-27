Return-Path: <netdev+bounces-217514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A7B38F3B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043AE9813B1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62530FC1F;
	Wed, 27 Aug 2025 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Ix2gxUlC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B72F83D7
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756337270; cv=none; b=eaSoqFTAt0/hlsIn6O9I15eligYmX+VnEhJKPevKCCUGmzQH9HJcnZIxAPtdV9n6+v4rn/SBWF3Q8eEmhbZr3de6qrvshvDC1iA5/NJPKTHbUbMBnqH3jusCllOviRSReugQT5T0wrKdBgpG2NxwjqTvyW/Q2w4YOhhYJpXC73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756337270; c=relaxed/simple;
	bh=qwaY/YKNhNVZhmL92UdtQhhaprQVFsX6chYKP8AsryA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0rFCFxNKZ4xSL30mdk0XP/R0AIJVp6uxES9xVnT8xOJz2p+1SkGxyOfHQvVLY0iP7zTZD67C0198UFvH7AtVqK5Zs9AV5s1haWQZiUGYaBR8rsfSe8+ydV5IxIM3ha9mtnNgPuYAIv5pzVW4RNePKRcH873himJaBVGxWVKyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Ix2gxUlC; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oor2GGqFzCWEplpNJopMqugkdYHuIxpEZp4/S+DOO0w=; t=1756337269; x=1757201269; 
	b=Ix2gxUlCsaNfjw52OxyXNSQgM24TFfEwvmuJGbpzpzt5LbvEqhFRPEf48q1mjnLZLHpgn9OwGZz
	OAWBwEcBWmcApSkAeRyOLjWrlVkwyjvBJktNSYUn6NlGfwYUtSPr8STBnDa/ka0x3xBzHEG8hExQK
	+abJDbzc55yFKCE60EHrO2j9RRzlrMUHeye+zkH1z9jljZtBBS0XEAJPkY7jpMF5IySYTtGMZuRVA
	hNv3X1ZYjY1KUqybOVT6NP1DyTkbQ0lCaMJJfJUTPelM+lrMrOEpSkAXNLCFzKElG/T6F4EFJaSdj
	IjK7aQ3utgqOnnF3zlR0TKPcNf0/mqLIGzXw==;
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46455)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1urPYR-0003C4-Ss
	for netdev@vger.kernel.org; Wed, 27 Aug 2025 16:27:48 -0700
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7454cf6abf9so15379a34.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:27:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrRPAVcSEG7lMW/F0ZXTvYV6ksKYBnEcwAj3KKcHpRweibo3VD
	7GwVVmUh8zE5rGI+ouFZkvE6FGDNl+qftmuZwORI8cm5OCGZ94dWOTlwg3kChx+XqTVUvewqKZz
	4/dithVeQeeaGwfuLEJJZB4DF40mNlx8=
X-Google-Smtp-Source: AGHT+IGr+SXSxGt5dTFDaDqVOJq6Fl52nTOmcTQpK5OqqNfIf1gZdm2u4+SqpiHqqWBMPm+E41FfxFx1f4LlAMp5hW0=
X-Received: by 2002:a05:6808:250f:b0:404:764:f7b6 with SMTP id
 5614622812f47-4378526c8a5mr9891647b6e.9.1756337267308; Wed, 27 Aug 2025
 16:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-6-ouster@cs.stanford.edu>
 <66dff631-3f6d-4a7c-b0f2-627c25c49967@redhat.com>
In-Reply-To: <66dff631-3f6d-4a7c-b0f2-627c25c49967@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 27 Aug 2025 16:27:11 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyLusSP8Q8SvuMUKT9W5_nk0XoSW_TJY1kxzABWtxuMHg@mail.gmail.com>
X-Gm-Features: Ac12FXzCr7QYTJVig7AsQOu6AWmDtjuo2DPrDuO1lyRDtXuv8xDAaVxjFciPAzs
Message-ID: <CAGXJAmyLusSP8Q8SvuMUKT9W5_nk0XoSW_TJY1kxzABWtxuMHg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 05/15] net: homa: create homa_peer.h and homa_peer.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 47150f6aa31409442f7db1cf5c00e98a

On Tue, Aug 26, 2025 at 2:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/18/25 10:55 PM, John Ousterhout wrote:
> > +/**
> > + * homa_peer_rcu_callback() - This function is invoked as the callback
> > + * for an invocation of call_rcu. It just marks a peertab to indicate =
that
> > + * it was invoked.
> > + * @head:    Contains information used to locate the peertab.
> > + */
> > +void homa_peer_rcu_callback(struct rcu_head *head)
> > +{
> > +     struct homa_peertab *peertab;
> > +
> > +     peertab =3D container_of(head, struct homa_peertab, rcu_head);
> > +     atomic_set(&peertab->call_rcu_pending, 0);
> > +}
>
> The free schema is quite convoluted and different from the usual RCU
> handling. Why don't you simply call_rcu() on the given peer once that
> the refcount reaches zero?

I have no idea why I implemented such a complicated mechanism. I've
switched to your (obvious, in retrospect) approach.

> > +/**
> > + * homa_dst_refresh() - This method is called when the dst for a peer =
is
> > + * obsolete; it releases that dst and creates a new one.
> > + * @peertab:  Table containing the peer.
> > + * @peer:     Peer whose dst is obsolete.
> > + * @hsk:      Socket that will be used to transmit data to the peer.
> > + */
> > +void homa_dst_refresh(struct homa_peertab *peertab, struct homa_peer *=
peer,
> > +                   struct homa_sock *hsk)
> > +{
> > +     struct dst_entry *dst;
> > +
> > +     dst =3D homa_peer_get_dst(peer, hsk);
> > +     if (IS_ERR(dst))
> > +             return;
> > +     dst_release(peer->dst);
> > +     peer->dst =3D dst;
>
> Why the above does not need any lock? Can multiple RPC race on the same
> peer concurrently?

Yep, that's a bug. I have refactored to use RCU appropriately.

For all of your comments not discussed explicitly above I have
implemented the changes you requested.

And sorry for my first attempt sending this message, which
accidentally used HTML mode.

-John-

