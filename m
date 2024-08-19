Return-Path: <netdev+bounces-119773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7A956EA6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C463EB21C6C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3053B1A2;
	Mon, 19 Aug 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvgfsMB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84978381B1
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080981; cv=none; b=K6uzXJcDCeYaBxNGpXu8FcJGJ/nNviMTkka9BtscEW4SYCy8PbIgpGCq/dn1nz4f5p8bU3OSe6l6B2q8xsIVj6ZfPzBUywjDKDHoSQ5YnN1YO7cHV3z4celfBnT4m3D3UzBSN65vV6pllO4nlEUA/o6tUHsKUszKp0lJOPg3acA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080981; c=relaxed/simple;
	bh=22ADzuTtcnEbARJQbcVfoD04jW8YJxhjZxUpRJqfQAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdqB1e0gUA7Rw1w1/+BOSxTttdzb3pHWnQ1/WmGW+Bj2bq6QEJVhWk0wF1U16HjtyEHntGao8TrNIM8LPp8OlMJ8rdmeixuDNPej74aqG1VFTv3B+1hWJ3cKsXYuA2MIcFFuYo4jDlxi4AlgEsS9OjuDDjPz/pavS0fT3u2L9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvgfsMB2; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39b32f258c8so17683175ab.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080979; x=1724685779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP1XUSV1gK4tZ9FH6V1dgBiltpAEHpqhcuJKnpELQcA=;
        b=kvgfsMB2xFP9M0iEWFyvH1tlAgMH1DVi9ZUUQtgiNa7i7UwysSbpl+ofzQOyylZw4I
         UxfBXRDwlsRqBZXrr72UuRAQh5meQ34KDUeYzc7z3NrbFhR5p2RYo472+BqhSND4xWu9
         PP26uJb4vgkSYxk+c4jufz7r4vKUKcF0I4ru6Nb1ouER9p7pnchpjawaL0nVul4kNs+/
         D5O7XQpB23irUdJD3qMjNkYQYtEnrfBQQLl0DOrXWdmsxDzx3bYH1DLDM8jg98AREITv
         rMafL6ElVIIBBM3Wxdv1lAMV0Mm7J/fdUT9yUH+myKZrBRQCqefBkDeW7JAy/efAAkpt
         gXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080979; x=1724685779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP1XUSV1gK4tZ9FH6V1dgBiltpAEHpqhcuJKnpELQcA=;
        b=NRwVrRVO+tJP7nPPpF1cOM17djfZMcEic/VmCFRcUv97LdRTa/f7tuoGHKjqXJzAJE
         wFuSbBgznY6j8YTjdQ4jCSx/l54+S5B8IWVi1W9+ut1jJ4vXkPA0XrU/HcPto/6R+r6Y
         9i8qyuh64OMYr68Ke0m969pnGbaOzw46SSj4XfuLIIUB//ToL2r8LZEEHLy8XpEr0wop
         jh4QL9UID8w9td6d4VNagdIoaLZz6/Jv261ulExXa1XSQ/cpnj0G4Pr866YYGocTnIjJ
         X6VCxN5ROEo47dHGfomzuL2o1SfIZLcg6e+7mE09KBQEDdObAuGDj3zMgpOyGd0KDw45
         VcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjUELgq/nvXwcPwNJ2+xpKVVdVsmrrI5oeWbJNygoVRYYZ5+6JdD+MV3qxYQNTds3A3IBdigA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkjeNOrzqgR2NHAfxfGWG1/ocS4YVBmBdaIuslKOfAwWquGw6
	OI9OMzLPbwFq+sWbRgASxRw6oMBRsZdyGpazhcQ6czm18JHVPG7hfIFSH5f1mNPEnq6QPeuj63a
	/fs8woeGnXBr6qveEW+yT4lGjoA6ejQkTXsY9
X-Google-Smtp-Source: AGHT+IG7oJh7ksWbNdtJTPSLNWZFp9jZO4FfXzYGrDaEGSI0ELZc5IrlVGnsVMArH2+tHdRfCwtUA/J1lfV3meLu4/g=
X-Received: by 2002:a05:6e02:168e:b0:39d:4d2d:d0de with SMTP id
 e9e14a558f8ab-39d4d2dd35dmr26430395ab.3.1724080979311; Mon, 19 Aug 2024
 08:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819134827.2989452-1-edumazet@google.com> <20240819134827.2989452-4-edumazet@google.com>
 <bda78aa1-d4bd-4f9a-9b54-d7b5444177e2@kernel.org>
In-Reply-To: <bda78aa1-d4bd-4f9a-9b54-d7b5444177e2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 17:22:45 +0200
Message-ID: <CANn89iL6z0kfsAONLyt7r0_xNbj1xsjdzaB60XTSr1aW7vW+Mw@mail.gmail.com>
Subject: Re: [PATCH net 3/3] ipv6: prevent possible UAF in ip6_xmit()
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Vasily Averin <vvs@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:21=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/19/24 7:48 AM, Eric Dumazet wrote:
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index 1b9ebee7308f02a626c766de1794e6b114ae8554..519690514b2d1520a311adb=
cfaa8c6a69b1e85d3 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -287,11 +287,15 @@ int ip6_xmit(const struct sock *sk, struct sk_buf=
f *skb, struct flowi6 *fl6,
> >               head_room +=3D opt->opt_nflen + opt->opt_flen;
> >
> >       if (unlikely(head_room > skb_headroom(skb))) {
> > +             /* Make sure idev stays alive */
> > +             rcu_read_lock();
> >               skb =3D skb_expand_head(skb, head_room);
> >               if (!skb) {
> > +                     rcu_read_unlock();
> >                       IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS)=
;
>
> rcu_read_unlock after INC_STATS

Indeed, thanks for noticing.

