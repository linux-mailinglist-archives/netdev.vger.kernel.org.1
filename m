Return-Path: <netdev+bounces-94490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B938BFAAD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55B01C227F8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F598173C;
	Wed,  8 May 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua7xg5c/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC777B3FD
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162936; cv=none; b=skuVfh2RZKPythph8huz+ZJHj3O5WcYh0uh81s/0MDKXs3p+MmQHbeBeYAzjXGfR2Lt28aCVG5bXCsx9XgObIe1QjFAtoDMaGAYK50DN5tIdjq116dlglNSwwfmCVo0KB44mVNQw1GOxezsE1CDCLJWckiqsLV0xRMvVXOMB2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162936; c=relaxed/simple;
	bh=wu3VJav4CQshh76dar/lz2wr2yNWMWj7pg6MjIapHQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JE/4lVeBXx53oywVQOoz69cH/lvvOCgGfuAzRjToKAoFEyB9ZHaQUlcvIB4XSUBBUR0f2jLR9ItraexG/rBpBfPRC9ZNTBFbJMVIHLY14kj8AFpP2Dna6DMOsqqRUB0loLHwJUxSw0z/R7XbXv9pP6mAXklbmv51+yb0UKYKBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ua7xg5c/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715162933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9wq14/NLbIgglWgTeZAelIRAETpsd27ZVdjxWeMp84c=;
	b=Ua7xg5c/TFEoELWJXYMF0YXrnXEV+qsk4QS1341pY68inOEv6gHGbyB/PfC96NrOpXaMZM
	uWTT3LzZ3dM7+3bAfpcNS+uR0/D6hvOCJkZpGzOdUoMEMtdgB8sANf9s7QtycjrfR37DkA
	gDk5056tbY70oiAl1hB1QsozOHoKTeI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-gNLeFyx_Nwitg0hqxJIp_g-1; Wed, 08 May 2024 06:08:52 -0400
X-MC-Unique: gNLeFyx_Nwitg0hqxJIp_g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34d9467c5f9so514841f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715162931; x=1715767731;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wq14/NLbIgglWgTeZAelIRAETpsd27ZVdjxWeMp84c=;
        b=nVdfR1EBop6isBMeI5NSvAu0osQFn9ROscJk5SRCGzJN5IYC8Xwd7koc9XjLQbnHAE
         f4cGEah570t5o6hdEBYVLvI3iZ6i4rJU0tsjikNQFb+OqK/vHW8cdWMqlxFPiBpff28g
         A5PXCA8YmrGRGwETAGIIC1eJGRPGbSisPUlgFmCLAlpcKNG0QvfKtjeda0z1BUKUvDtE
         GMKiH4SDpMkqwkpphix9OiAzNmaSykrunFuPYLZzTiBW+v1IPNsme2bTmyaaBRP3YSdm
         IDyAekq6RbbxgcjchCBtZsToQHbXaj0G/WCyHA/hp4WQ7koJjnsWgZBZ3KrVPIFYFyKt
         OlUA==
X-Forwarded-Encrypted: i=1; AJvYcCUultxa6CNcDEkvAUWd9HT1Fm45jFSfPVUZOGEzWLtj8yvbtDfI4A0dD02RSr3DZ4scgUVUnIf4hRRcslvr70zW8D1TSxu6
X-Gm-Message-State: AOJu0YylD7ZoSIMXdnlCafZCQ4ShdqmrVCW8T20Hgd0HlRcR9PlxENLd
	CAv4G7caVtZdnPraNP9rPMPVVbMkGJCbvqkoKDnuR3jwKdKFIt8zikhk6AyN8e4oi8fECu5WvWF
	UYMPtFrJwT1iwWRWCL2WidVSjTmWVNkqsXwm2pg/2S8ZLPlkWeXwypA==
X-Received: by 2002:a05:600c:3b28:b0:41a:3150:cc83 with SMTP id 5b1f17b1804b1-41f719d6299mr16562355e9.2.1715162931217;
        Wed, 08 May 2024 03:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZRRHh1ISx963e7WIuv8AkE7JX+TYSfEhEm+p+S1yyFBdBxaElIoeinQ/hdQFPo93QSF1dpw==
X-Received: by 2002:a05:600c:3b28:b0:41a:3150:cc83 with SMTP id 5b1f17b1804b1-41f719d6299mr16562185e9.2.1715162930656;
        Wed, 08 May 2024 03:08:50 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810:c326:df35:5f81:3c32])
        by smtp.gmail.com with ESMTPSA id be8-20020a05600c1e8800b00418accde252sm1794882wmb.30.2024.05.08.03.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 03:08:50 -0700 (PDT)
Message-ID: <705af521482fdae1fddbd594e003e07fc3c9ec61.camel@redhat.com>
Subject: Re: [PATCH v1 net-next 2/6] af_unix: Save the number of loops in
 inflight graph.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org
Date: Wed, 08 May 2024 12:08:48 +0200
In-Reply-To: <20240507161136.78482-1-kuniyu@amazon.com>
References: <37bb5b56bc27dbacfb48914f049efbb2bb8892f5.camel@redhat.com>
	 <20240507161136.78482-1-kuniyu@amazon.com>
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

On Tue, 2024-05-07 at 09:11 -0700, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Tue, 07 May 2024 15:54:33 +0200
> > On Fri, 2024-05-03 at 15:31 -0700, Kuniyuki Iwashima wrote:
> > > unix_walk_scc_fast() calls unix_scc_cyclic() for every SCC so that we
> > > can make unix_graph_maybe_cyclic false when all SCC are cleaned up.
> > >=20
> > > If we count the number of loops in the graph during Tarjan's algorith=
m,
> > > we need not call unix_scc_cyclic() in unix_walk_scc_fast().
> > >=20
> > > Instead, we can just decrement the number when calling unix_collect_s=
kb()
> > > and update unix_graph_maybe_cyclic based on the count.
> > >=20
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/unix/garbage.c | 19 +++++++++++--------
> > >  1 file changed, 11 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > index 1f8b8cdfcdc8..7ffb80dd422c 100644
> > > --- a/net/unix/garbage.c
> > > +++ b/net/unix/garbage.c
> > > @@ -405,6 +405,7 @@ static bool unix_scc_cyclic(struct list_head *scc=
)
> > > =20
> > >  static LIST_HEAD(unix_visited_vertices);
> > >  static unsigned long unix_vertex_grouped_index =3D UNIX_VERTEX_INDEX=
_MARK2;
> > > +static unsigned long unix_graph_circles;
> > > =20
> > >  static void __unix_walk_scc(struct unix_vertex *vertex, unsigned lon=
g *last_index,
> > >  			    struct sk_buff_head *hitlist)
> > > @@ -494,8 +495,8 @@ static void __unix_walk_scc(struct unix_vertex *v=
ertex, unsigned long *last_inde
> > > =20
> > >  		if (scc_dead)
> > >  			unix_collect_skb(&scc, hitlist);
> > > -		else if (!unix_graph_maybe_cyclic)
> > > -			unix_graph_maybe_cyclic =3D unix_scc_cyclic(&scc);
> > > +		else if (unix_scc_cyclic(&scc))
> > > +			unix_graph_circles++;
> > > =20
> > >  		list_del(&scc);
> > >  	}
> > > @@ -509,7 +510,7 @@ static void unix_walk_scc(struct sk_buff_head *hi=
tlist)
> > >  {
> > >  	unsigned long last_index =3D UNIX_VERTEX_INDEX_START;
> > > =20
> > > -	unix_graph_maybe_cyclic =3D false;
> > > +	unix_graph_circles =3D 0;
> > > =20
> > >  	/* Visit every vertex exactly once.
> > >  	 * __unix_walk_scc() moves visited vertices to unix_visited_vertice=
s.
> > > @@ -524,13 +525,12 @@ static void unix_walk_scc(struct sk_buff_head *=
hitlist)
> > >  	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices)=
;
> > >  	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
> > > =20
> > > +	unix_graph_maybe_cyclic =3D !!unix_graph_circles;
> > >  	unix_graph_grouped =3D true;
> > >  }
> > > =20
> > >  static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
> > >  {
> > > -	unix_graph_maybe_cyclic =3D false;
> > > -
> > >  	while (!list_empty(&unix_unvisited_vertices)) {
> > >  		struct unix_vertex *vertex;
> > >  		struct list_head scc;
> > > @@ -546,15 +546,18 @@ static void unix_walk_scc_fast(struct sk_buff_h=
ead *hitlist)
> > >  				scc_dead =3D unix_vertex_dead(vertex);
> > >  		}
> > > =20
> > > -		if (scc_dead)
> > > +		if (scc_dead) {
> > >  			unix_collect_skb(&scc, hitlist);
> > > -		else if (!unix_graph_maybe_cyclic)
> > > -			unix_graph_maybe_cyclic =3D unix_scc_cyclic(&scc);
> > > +			unix_graph_circles--;
> >=20
> > Possibly WARN_ON_ONCE(unix_graph_circles < 0) ?
>=20
> Will add in v2.
>=20
> >=20
> > I find this patch a little scaring - meaning I can't understand it
> > fully,
> > I'm wondering if it would make any sense to postpone this patch
> > to the next cycle?
>=20
> It's fine by me to postpone patch 2 - 5, but it would be appreciated
> if patch 1 makes it to this cycle.

Yes, patch 1 looks fine and safe to me. Feel free to re-submit that one
individually right now, with my Acked-by tag.

Thanks!

Paolo



