Return-Path: <netdev+bounces-183336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CBA906AC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3DB7AB865
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51318A6AE;
	Wed, 16 Apr 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmILlp/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98968190462
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814412; cv=none; b=m17fO4iCNGnr36jaMGw8EMqrAoZbd9VEDUtjpyEVnh4vU4BV8j5IOgLTIgE7YbbR2+aINrZfjxylJBPcnYUtGBNAyp1Fn0wFLlDsDHRpfSNxBgzIYP3HErsXeUZ5xXfcpxg008shYJMs2RDJk0hTDn43eGYkdt7KgbufnP1kf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814412; c=relaxed/simple;
	bh=QHQYBNkGpm3T0yNp8t5kIJZdEE0gGV6f4ziubCq08zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAgB1XK8aC9SheflaqTQUGeboqkZRRvAdXkaRStbMcU2esZ1qzqexpdiTzQwOnk4UEvx03iFgQbsrMA28UJGgWJxDnDr9KfTjbrZotzj31ghgkApV18CmG09nVf78j0jOHkFgh+zJPkbTMKhzxYacRbobHfce054Z3Q+VnMbnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmILlp/o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33e4fdb8so9949865ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744814410; x=1745419210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3SD9xCxkV+U6Pb4XFud2QiwYS8jxbFTUqYH3APAANQ=;
        b=kmILlp/ooyNedsTqL1u/kX2ltSSaMOlcrxoE6xs6npdengIHQH9UGkTcYBviFSVs3X
         T9YbHH3ZYIgFm8eClhWRnQ61yMoqrqsyE73nFhR+0/84ngXEzcXg9GZSDLcYXccUqiqP
         hym33mbYJP+ifq2fBBd+kMm41VHoCqIQPYElNkv4PgucsO808wCDDg1FH/Y6SVb/l0kp
         gYtPtb6JgKWWj3UNVopAuXnlF+GAg8ZQPPc86g3ls4bAlLv00ciWk/2E76Tf4rQlRrkI
         lcOmIIJMSD4Xu8yR3fzch8SE4BBjaHEWUrSZtwjFIr9p9pwkI+LNhbQ2koQWw9kchIAD
         PKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744814410; x=1745419210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3SD9xCxkV+U6Pb4XFud2QiwYS8jxbFTUqYH3APAANQ=;
        b=fmNy6U45vFb3bJJDtpW+KvCZ27k+5nUqgqwBTEwEz2gvr7uU0lANrA2QcX4qF/00Nw
         2eiAQ7iEeypfLoi85QImAJNGZj9NLz1i9I+evMxReOp2lDTB0yGOMVECtmUweKbNl49p
         Ya3e1dzGuF57SjIZrMFGQBig1Gf3s2Fq1yDWZ990c8U6SrV6iXQ3jjOIHnHe+OceGbqO
         M/jZkgiUnBkjBfRGd2FzA2AGxRZy83iGqgCp4EFfQE8LffDvfH9viIOSwCyjhlCZMV4H
         Hn3agjqv4EI+GKrf2gN0sWF8iQrRW7c/kOX2hF2xmQ4D5Ye/Bx3LHzPXcNefWe5b3FnO
         C7AA==
X-Forwarded-Encrypted: i=1; AJvYcCUvVJuRaK54etgQpKvGOccz1HJVSMLu+V3FYNbQEdtgE1NsWY6hXJYR10LQs1OscUmuqbiYGQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvxbyD5HvGLVY2fZvPPUGz2HQxRg6wD5ycDaiLDeyLkvnh6pZU
	14NJ6fGVigNywRKE6NZnEUJQwBqBPSnHy6F7hzwVVsccZ2O05HX1s0Rp
X-Gm-Gg: ASbGnctLxfk0e0nsZbgYLu4smm1wuLPOPpdhMdVk3qGoX02XNgH4Vgt1VexVTw9i+6s
	NBTRkIjtGK7y22bq3IpISctCANW2ZRphIbcpi2o89TWpi8h1dKX+OgypIS6h3ES2e6uNzgvmJwN
	3HU86rILHA4EJY/rDztDLfOcDQAgLXAm3dZ88SAjv5BgxlXdeaAksZFHq2/kgWp/XdrXpyMy/zY
	ILfi+8b19oSVHwHScXxHOGueqyjvRp7sMkm3UiMh4cn6P776A6gP3grGrf2lGlhnuz4yMgaE2us
	Gthw2vZmu4HrUOEuXOpAhjUHCO8ZdvHHuoNfFdHZ
X-Google-Smtp-Source: AGHT+IHrkfWAMqJts10EjhaR8QZyBf21Vits7CwaS4VPlMaWiZrlR0pE7YFwkICh3Po+Hxp9UuvQRg==
X-Received: by 2002:a17:903:84f:b0:224:122d:d2de with SMTP id d9443c01a7336-22c358ddb96mr26482775ad.16.1744814409265;
        Wed, 16 Apr 2025 07:40:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd230e5ccsm10456965b3a.152.2025.04.16.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:40:08 -0700 (PDT)
Date: Wed, 16 Apr 2025 07:40:07 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, horms@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, sdf@fomichev.me, skhawaja@google.com,
	simona.vetter@ffwll.ch, kaiyuanz@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <Z__BRyblHNHhnui7@mini-arch>
References: <20250415092417.1437488-1-ap420073@gmail.com>
 <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch>
 <20250415195926.1c3f8aff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415195926.1c3f8aff@kernel.org>

On 04/15, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 11:59:40 -0700 Stanislav Fomichev wrote:
> > > commit 42f342387841 ("net: fix use-after-free in the
> > > netdev_nl_sock_priv_destroy()") and rolling back a few fixes, it's
> > > really introduced by commit 1d22d3060b9b ("net: drop rtnl_lock for
> > > queue_mgmt operations").
> > > 
> > > My first question, does this issue still reproduce if you remove the
> > > per netdev locking and go back to relying on rtnl_locking? Or do we
> > > crash somewhere else in net_devmem_unbind_dmabuf? If so, where?
> > > Looking through the rest of the unbinding code, it's not clear to me
> > > any of it actually uses dev, so it may just be the locking...  
> >  
> > A proper fix, most likely, will involve resetting binding->dev to NULL
> > when the device is going away.
> 
> Right, tho a bit of work and tricky handling will be necessary to get
> that right. We're not holding a ref on binding->dev.
> 
> I think we need to invert the socket mutex vs instance lock ordering.
> Make the priv mutex protect the binding->list and binding->dev.
> For that to work the binding needs to also store a pointer to its
> owning socket?
> 
> Then in both uninstall paths (from socket and from netdev unreg) we can
> take the socket mutex, delete from list, clear the ->dev pointer,
> unlock, release the ref on the binding.
> 
> The socket close path would probably need to lock the socket, look at 
> the first entry, if entry has ->dev call netdev_hold(), release the
> socket, lock the netdev, lock the socket again, look at the ->dev, if
> NULL we raced - done. If not NULL release the socket, call unbind.
> netdev_put(). Restart this paragraph.
> 
> I can't think of an easier way.

An alternative might be to have a new extra lock to just protect
the binding->bound_rxq? And we can move the netdev_lock/unlock inside
the xa_for_each loop in net_devmem_unbind_dmabuf. This will make sure
we don't touch the outdated 'dev'. But I think you're right, the same
lock ordering issue is gonna happen in this case as well.

> > Replacing rtnl with dev lock exposes the fact that we can't assume
> > that the binding->dev is still valid by the time we do unbind.
> 
> Note that binding->dev is never accessed by net_devmem_unbind_dmabuf().
> So if the device was unregistered and its queues flushed, the only thing
> we touch the netdev pointer for is the instance lock :(

I was assuming that bound_rxq is also protected by the instance lock.
But as you were saying earlier, xa has its own lock, so I might
be wrong with that assumption..

