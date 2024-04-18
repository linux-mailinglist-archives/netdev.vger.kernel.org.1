Return-Path: <netdev+bounces-89011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDCA8A93A4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AE1C2098F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1A92561F;
	Thu, 18 Apr 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+E95euU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6337719
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423650; cv=none; b=PYDxqFOBE/qMx6tiNPe/p+t7fE3rMAGiXptPyLZO6a5VxzJ1xWeEspH9KgDuoEr4+tOhLemDBvqETWlTsCBRflVNeWlBr4EuRTqD9w0VtMDPYbxjdeIeibhoKECfzWVQV0wgMxqJ60o0ZzNr72HEVmP2SQiTZqtaMJgBR5QxncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423650; c=relaxed/simple;
	bh=NKqAT5TzZBN30337fEPF7COqcWV9sZ0qWW6wTdq4jho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHJHDef+Ts9eJIiVBruh3U+ZOi617OMc81JPwekoNQCvLWIE/y1YnA3dzILqm8lC9aOBQXEregAw0hoGgsO3ijetwtZs+Tml1detfw+RcsxNwqrXyQgcHfTLr63PKBMynn0RPtskNblFBWJ+tEWDlZWbfuxo3nQlB+H+h0zJ5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+E95euU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so5085a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713423647; x=1714028447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKqAT5TzZBN30337fEPF7COqcWV9sZ0qWW6wTdq4jho=;
        b=u+E95euU9WSdlAtcQ3rAdmXt7H/+c/TLa00tvehz63CqtNTbfT6SspVulA8iNBiSDa
         0+goODN8fIamfznGqcktYC0KpprTARCTCQX8STz+eEoL7owd+0NS84U7z4Wp1MeSAggE
         gdTRJcFTveMd5IhGUej0VygzGEVzGDDbnLRXi6dOO1FG6nYc8ET4iNwtclsAhppDgHQD
         7e+WBBipGVkc6fPEiCdNT7ZRjtr8aTFiR/WrUiBlMb1lpFHY4/0whaNdm2bnxu1TItT1
         iXNOMy5yV1Q/438E/3JuEQcK8ZZx8bT703hQqQBpOD0T/f6ejp8oHnD7cIwYeTOt/3y8
         6bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423647; x=1714028447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKqAT5TzZBN30337fEPF7COqcWV9sZ0qWW6wTdq4jho=;
        b=WwL3x4Nw7Hrfbq35wGhuZVaZnP7XHjri3oc2QVIZZoKG1e+SP3svh5vwYSY/1xcCxB
         /puprdCiTZEYDvxY06v/NJpUghopCLYMEztX6m2dWTiCLYzRcquTE4+yBcYoyUtR2rcu
         aAwSqpjcvQX71tD7n8B71pu3RNVOqZkJSjqJSSGpLgJH088vHVlOu+fLOq+6NLUtWU8K
         xWE9Da50m83vCCFSuom6+I8lk0QnwdsbYVqJOZfYJ4MjHf/gAj+M8bbnS+D1Hnw+7/YF
         R2pis4JYpMbdH8jLVfsnuiz6Dls/WJZTgd3LcwJnYEPd+07U90I/XhejDAgymJmSLSf8
         vGjw==
X-Forwarded-Encrypted: i=1; AJvYcCVDmbSOZ/AHBDeeGK6GD8hgiBQ/deixRFrBlgszk7k3JsU6sEUSJzazYNdW/6U5XzwVzSipVuQfiNvTNhi+Z9RFQhGI80yz
X-Gm-Message-State: AOJu0YwDub6JurwCYI+ChkQLD8q3WWvKy8PifwK4ylvRJCcDZMsYhWR0
	Q+0BgHRGEWKSQUbAYbUAiiPXMLBrhMRthT0ysJ1cuSuearhkBh+NaU2/c28CtGUixqyEYplDamt
	3PohFrBhDfMmrW2BTIDQNIwx3IweVMM1TtYra
X-Google-Smtp-Source: AGHT+IGexO3Hk3JtvDECigJsYhSigpTpVd8Oc5dHfbAMyjzHPHWvBydw5YnNvhvxB8+YWaIJXRR7jMt516DbWKwShQM=
X-Received: by 2002:a50:ff08:0:b0:570:5cb3:b98 with SMTP id
 a8-20020a50ff08000000b005705cb30b98mr114814edu.4.1713423646222; Thu, 18 Apr
 2024 00:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417190432.5d9dc732@kernel.org> <20240418033145.35894-1-kuniyu@amazon.com>
 <CANn89i+y8yqXZ3OHdzo5FxgwNs-j24-4wiNZKr8pSG+tvbYV9g@mail.gmail.com>
In-Reply-To: <CANn89i+y8yqXZ3OHdzo5FxgwNs-j24-4wiNZKr8pSG+tvbYV9g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 09:00:32 +0200
Message-ID: <CANn89i+raqGAERfsvxv9AM_AsgJNdnk3=YgLzf4guduj7G-s7Q@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/5] sit: Pull header after checking skb->protocol
 in sit_tunnel_xmit().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	herbert@gondor.apana.org.au, kuni1840@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, syzkaller@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 18, 2024 at 5:32=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Wed, 17 Apr 2024 19:04:32 -0700
> > > On Mon, 15 Apr 2024 15:20:37 -0700 Kuniyuki Iwashima wrote:
> > > > syzkaller crafted a GSO packet of ETH_P_8021AD + ETH_P_NSH and sent=
 it
> > > > over sit0.
> > > >
> > > > After nsh_gso_segment(), skb->data - skb->head was 138, on the othe=
r
> > > > hand, skb->network_header was 128.
> > >
> > > is data offset > skb->network_header valid at this stage?
> > > Can't we drop these packets instead?
> >
> > I think that needs another fix on the NSH side.
> >
> > But even with that, we can still pass valid L2 skb to sit_tunnel_xmit()
> > and friends, and then we should just drop it there without calling
> > pskb_inet_may_pull() that should not be called for non-IP skb.
>
> I dislike this patch series. I had this NSH bug for a while in my
> queue, the bug is in NSH.
>
> Also I added skb_vlan_inet_prepare() recently for a similar issue.

Kuniyuki I am releasing the syzbot bug with a repro, if you have time to fi=
x NSH
all your patches can go away I think.

