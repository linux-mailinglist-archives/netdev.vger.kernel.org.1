Return-Path: <netdev+bounces-75580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97D86A988
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF821F241A3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A32562E;
	Wed, 28 Feb 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9kQDIuD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017EE25618
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107720; cv=none; b=nmcvHvmlswPCJ5dth4P8fnoKFkjfC7OaZPib7uMv80e+QNF30uzrua/Sgh5hgaNOCKszLeTZC0H28r5nQigtEYknuCAQZ0rJPUBFns9Ks/9fnENiXB9TFDzhYqLbWLoqgkZ5ieHayvo8D4w/RY4UoMKQ3JnXpXbJXv7CTMDb/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107720; c=relaxed/simple;
	bh=EXvPgcPY55ap6cZQMhvjxwMvChK/sEBo1mK1KSyUNCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=My8QIi3jycle7OsUJYHoqJyv2nGqhxrTrS2PH7eWqFcaAFBwN96Y6/wdmJNpVySr2ithGw+VaH9QGCIxt0k71u0Lfip9uAwAReAwbmrb38p+14qjf0tMIDt13iCtIFwqqysa+jlUfIW9iNdCzfi/XK39v/KR4uDu9g7yX9tvDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9kQDIuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709107717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yqCnxgCBb9c5rsbnhXRtQvi0xL+Oz7CF5UQ2WDoaq6Q=;
	b=h9kQDIuDGAJ3qNSr1jLHvydHXb/PNoFUIhRSTFGm8XZgkPsmVTrtJUmMo/18tPw9IgO6V8
	jIq2+YAAMnuS8xFrOddOPiMb1dszmRnUoGV3Q1ymiT4yVnZUoukb0f5b9psWNYopS7Nrmv
	tJVlgAyEIm+Jmzyt8NJAoaOTyEEXrt8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-8O6QV-coNxaun-FWldQ9Zw-1; Wed, 28 Feb 2024 03:08:36 -0500
X-MC-Unique: 8O6QV-coNxaun-FWldQ9Zw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41293adf831so11043745e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 00:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107715; x=1709712515;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqCnxgCBb9c5rsbnhXRtQvi0xL+Oz7CF5UQ2WDoaq6Q=;
        b=FDgsIdQk9Szxgd2TEXMJkssLuDijWasrEjaJUJvy+h0FB4zr/vaNzsQmezaqFV+dlg
         KIWvx2NhwayJXNdRKH+4rJw0TE++/F9Lj6O9waWrgt1EQbd6sL3PUddbkX+O5POUjmBr
         ZeOEfwN3BVy/onz7YSo0jrTFJH61li6mKZTfx1Y9qTnH0gc+VOqsxO8Ls1Hm+P0q4Cvi
         MQHRU07uXinI3YwnS7SeT9zK7BjQQsTRENiuYyyCbN/kE7oR3cKCUhc3hN4r3lyq+k8W
         PW4w8CWP9lz/95u7HYDPz+3Fh0LgVA/oohxXwDNZ+kKffSG7StCF9gAmgOvjtAwKIpEb
         +EAg==
X-Forwarded-Encrypted: i=1; AJvYcCV3s8H6ujom73E2T0KZGRGOIDtYtMsjl+BFYdOSU51hboiBBDYZwqqcPV7sMA6WBQ1yqMMWd6nYB5yhlVc/bkEK3my4ybdt
X-Gm-Message-State: AOJu0Yz7hPZrFh7lRoFVW6f6UpZW5ctwSHivnNrCFwV3eVQC9MTaHXlt
	ecaZxsGluh2gvBKgZEAEwPdPuxFAT6FjaFvLLcuZdORGE8h7DiAoPFLwVlWHi+HSoq/vgZgbCY9
	zho2s2ZdO9knRqR0G+gsFJlbhYbg0WgSuCN8kDToHFcObRhjGFLon3Q==
X-Received: by 2002:a5d:5a1b:0:b0:33d:8d51:726f with SMTP id bq27-20020a5d5a1b000000b0033d8d51726fmr10135310wrb.6.1709107714829;
        Wed, 28 Feb 2024 00:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbHKfsSZWJDZxX9VlvTh2VDubYifH8IvabEScIUsRKu7/131lvjL87bjDLBa98+zwCejZV/A==
X-Received: by 2002:a5d:5a1b:0:b0:33d:8d51:726f with SMTP id bq27-20020a5d5a1b000000b0033d8d51726fmr10135289wrb.6.1709107714489;
        Wed, 28 Feb 2024 00:08:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-156.dyn.eolo.it. [146.241.246.156])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm13608509wrx.28.2024.02.28.00.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:08:34 -0800 (PST)
Message-ID: <26eeffe603d4818c312374cac976ec00c4bff991.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 13/14] af_unix: Replace garbage collection
 algorithm.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org
Date: Wed, 28 Feb 2024 09:08:32 +0100
In-Reply-To: <20240228033241.33471-1-kuniyu@amazon.com>
References: <2e6eb578782dffcc8481992ba39181c74e2a7f80.camel@redhat.com>
	 <20240228033241.33471-1-kuniyu@amazon.com>
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

On Tue, 2024-02-27 at 19:32 -0800, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Tue, 27 Feb 2024 12:36:51 +0100
> > On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > index 060e81be3614..59a87a997a4d 100644
> > > --- a/net/unix/garbage.c
> > > +++ b/net/unix/garbage.c
> > > @@ -314,6 +314,48 @@ static bool unix_vertex_dead(struct unix_vertex =
*vertex)
> > >  	return true;
> > >  }
> > > =20
> > > +static struct sk_buff_head hitlist;
> >=20
> > I *think* hitlist could be replaced with a local variable in
> > __unix_gc(), WDYT?
>=20
> Actually it was a local variable in the first draft.
>=20
> In the current GC impl, hitlist is passed down to functions,
> but only the leaf function uses it, and I thought the global
> variable would be easier to follow.
>=20
> And now __unix_gc() is not called twice at the same time thanks
> to workqueue, and hitlist can be a global variable.

My personal preference would be for a local variable, unless it makes
the code significant more complex: I think it's more clear and avoid
possible false sharing issues in the data segment.

> > > +
> > > +static void unix_collect_skb(struct list_head *scc)
> > > +{
> > > +	struct unix_vertex *vertex;
> > > +
> > > +	list_for_each_entry_reverse(vertex, scc, scc_entry) {
> > > +		struct sk_buff_head *queue;
> > > +		struct unix_edge *edge;
> > > +		struct unix_sock *u;
> > > +
> > > +		edge =3D list_first_entry(&vertex->edges, typeof(*edge), vertex_en=
try);
> > > +		u =3D edge->predecessor;
> > > +		queue =3D &u->sk.sk_receive_queue;
> > > +
> > > +		spin_lock(&queue->lock);
> > > +
> > > +		if (u->sk.sk_state =3D=3D TCP_LISTEN) {
> > > +			struct sk_buff *skb;
> > > +
> > > +			skb_queue_walk(queue, skb) {
> > > +				struct sk_buff_head *embryo_queue =3D &skb->sk->sk_receive_queue=
;
> > > +
> > > +				spin_lock(&embryo_queue->lock);
> >=20
> > I'm wondering if and why lockdep would be happy about the above. I
> > think this deserve at least a comment.
>=20
> Ah, exactly, I guess lockdep is unhappy with it, but it would
> be false positive anyway.  The inversion lock never happens.
>=20
> I'll use spin_lock_nested() with a comment, or do
>=20
>   - splice listener's list to local queue
>   - unlock listener's queue
>   - skb_queue_walk
>     - lock child queue
>     - splice
>     - unlock child queue
>   - lock listener's queue again
>   - splice the child list back (to call unix_release_sock() later)

Either ways LGTM.

> > > +				skb_queue_splice_init(embryo_queue, &hitlist);
> > > +				spin_unlock(&embryo_queue->lock);
> > > +			}
> > > +		} else {
> > > +			skb_queue_splice_init(queue, &hitlist);
> > > +
> > > +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > > +			if (u->oob_skb) {
> > > +				kfree_skb(u->oob_skb);
> >=20
> > Similar question here. This happens under the u receive queue lock,
> > could we his some complex lock dependency? what about moving oob_skb to
> > hitlist instead?
>=20
> oob_skb is just a pointer to skb which is put in the recv queue,
> so it's already in the hitlist here.
>=20
> But oob_skb has an additional refcount, so we need to call
> kfree_skb() to decrement it, so we don't actually free it
> here and later we do in __unix_gc().

Understood, thanks, LGTM.

Cheers,

Paolo


