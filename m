Return-Path: <netdev+bounces-245205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDEDCC898C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BDC730DEA3C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E43563E9;
	Wed, 17 Dec 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsRlPpOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14366354AD4
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986260; cv=none; b=C9Ay6z7Q0ByAdXTdVTogN7Htk9T4XQiuz5Too2lghtT2OrPRQuyx5VEgCCa3ZsXRperg4Oz87UiM++tyaxOSNTUteWLdFPoFGzip38TCKIIK4Z+aIcljcSdAWAA8wyIvuIkv4udOqtuRkv10P1ODgN+ujMPXFhnsBq+csFs3YOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986260; c=relaxed/simple;
	bh=ppU3j2lZksoglhDW0EJVi4k7Xru09KCe+n/nfrWzViY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFJsqTYx0E/CzdK8IeRFhLxIIwH0LimDRzqg8WaOAiujl6dO5ShIpHGwLi8MWwjfffVJJ/weJcCHvZjx6AK5jIIsDNfNAQxSQYC94tlOm5BxfRo6TqNAMmTD1gqUl8mE29Gm78gCGfZATDIeimZj9oQ9MUxksDeD/asYftt1z1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsRlPpOi; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78c33f74b72so55069097b3.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 07:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765986257; x=1766591057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iopfrv3MnPwwQ2rY2e5oa1mDYysahBYSwhvZmps0EBA=;
        b=jsRlPpOiZaxJ304WaOY9lGdjistYSS7se6oWOY1qDeRx/MwL+agS6ybTYRRbycZCEl
         s3rQqqeqLFIYfRAC3oDiwhJzNPLMKLHN1IfPNaEEm098rUw6xnEl+Lc+TUow/bdisMiF
         lwo5D8eye86xBYxBRVaMdpIVsZkceWy03FxDo7gMI/RDPrZTYBL+Q9nlCCj50pcz1OG2
         IDKl7Dya7ZMiqYNFSi0T+M52sEjr4wjDcY4V7rolOkFMG498U9+pPM5x434e3lf/TZVx
         SuIXtCIvyc4pr0ISLdoqSiNmE4XP9OxqjpXnTlicUSqI99IONHIAsM+d+Gs+Fc0P5Gag
         CKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765986257; x=1766591057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iopfrv3MnPwwQ2rY2e5oa1mDYysahBYSwhvZmps0EBA=;
        b=XhruwicP27MilSh9MXh5JwV4M8Yz/1/ETaIzc4w8augYlJ8S8sZylfbrSjpjPdkUCz
         h0lrzSFatBzRKJwyufXzib3X2ZQy0RdNV82oEXf6t1WMMjoJXnyFQbXHonynxpgrGPdL
         FKk7pV0bPyjsx3VaCwcmEGrNASk9/LNHXVh2GCjcO0uTp6I/tkAbNImYIz7lx926CIJ+
         XImpVsa2UlLWp1+2Uk0016zarQVBLHD8hTPK6s2nhLN3/91L/UZ4Hlx+6cEpb0cjXVj8
         6Y/EtbmxLRj2T3qvdU/P5LxVOwZ/daNNb/6k6JSP8KRKBWimRrkfVxdR5H8pZ1IsWFTc
         hjGg==
X-Forwarded-Encrypted: i=1; AJvYcCWVlo5tl7AXHeB/ZQGAQhyJ2I8ZCNvj8bQ4uNazicN7GwU0Qol236JxupBOFXbiPrNeMHIbapY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSg18vvKSgHZk+L4jN/pB1bbAyWpfsdzyanpagK/F88+zxSic
	2QC52n7JeumPIaelZbET7PXb5DGRGd4VpUZ03p+kMHn6G7Pjmm1AIQ6VOuVDtRQZAmt1I5g50Tt
	twGcHyt+tBgSGPoAIbjYs7H/IV7vNdG4jDVK/Thbr
X-Gm-Gg: AY/fxX6c72teHwBCf4nKh9b0IuFwrJI0VyZIzVzZY/B2qGUO90WJ7c4Uv+bk9zoc8DW
	JNFH1j/wOWAil8k/MlXPX3v1RG3/36Fpjq6mxRVvDkIRftMLrfd9i9EuPawHmifO0oA7ghGulzH
	NvSQcxBuhYOMLEHzTaCEcC5GkfMbztLAJzqSk8WtTTT/QdWQTSjJUn/DPIXE4JIUHlYfbUElpMd
	P63SSOhYoGQgmekeXmgvndzTvJ0p0Z7rVUDqVWOojYyFowEJtq2smsP7zrW5GZ9WDi9PkkA
X-Google-Smtp-Source: AGHT+IG4rtpahx6R9bomNsuM4kVxoxSOy3f0EszD5++oV6H5itfwOXE3I7lS9RF9ET+eJ6HkwchSeL0/9Xrm5EERo0I=
X-Received: by 2002:a05:690e:1888:b0:646:60c5:8c46 with SMTP id
 956f58d0204a3-64660c5918dmr995581d50.51.1765986256414; Wed, 17 Dec 2025
 07:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q3j7p3zkhipxleesykpfrfhznasqnn6mnfqlcphponzvsyavxf@a6ko6obdpso3>
 <CANn89i+8hX9SjbhR2GOe+RfEkeksKCtPbkz-6pQhCA=pjnr5zg@mail.gmail.com>
 <CANn89iKUQXmR6uaxVJDi=c3iTgtHbVaTQfRZ_w-YsPywS-fHaw@mail.gmail.com>
 <CANn89iJj_Vyt2g6QewwaNAXAZ+0iso=4yj0t3U11V_nuUk4ThQ@mail.gmail.com>
 <6d508d6a-6d4f-4b78-96e0-65e5dfe4e8f0@oracle.com> <CANn89iKjJ-P0YR-oGzEd+EvrFAQA=0LsjsYHUDpFNRHCDwXeWA@mail.gmail.com>
 <5da37621-279f-46ea-94e7-b766a6e601f3@oracle.com>
In-Reply-To: <5da37621-279f-46ea-94e7-b766a6e601f3@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Dec 2025 16:44:04 +0100
X-Gm-Features: AQt7F2o6glrXpebovDO_hJ-ngJUpq4WKZnmHIf3JWf6frZd0DoXCg8mM5nvxvEg
Message-ID: <CANn89iK_HyO_9Ek0VRcvjsM-mY-_kUvDsVPkh2iUvi-qcAhDCA@mail.gmail.com>
Subject: Re: [External] : Re: [REPORT] Null pointer deref in net/core/dev.c on PowerPC
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 4:38=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 12/17/2025 8:52 PM, Eric Dumazet wrote:
> >>> I will send the following fix, thanks.
> >>>
> >>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>> index 9094c0fb8c68..36dc5199037e 100644
> >>> --- a/net/core/dev.c
> >>> +++ b/net/core/dev.c
> >>> @@ -4241,9 +4241,11 @@ static inline int __dev_xmit_skb(struct sk_buf=
f
> >>> *skb, struct Qdisc *q,
> >>>                   int count =3D 0;
> >>>
> >>>                   llist_for_each_entry_safe(skb, next, ll_list, ll_no=
de) {
> >>> -                       prefetch(next);
> >>> -                       prefetch(&next->priority);
> >>> -                       skb_mark_not_on_list(skb);
> >>> +                       if (next) {
> >>> +                               prefetch(next);
> >>> +                               prefetch(&next->priority);
> >>> +                               skb_mark_not_on_list(skb);
> >>> +                       }
> >>>                           rc =3D dev_qdisc_enqueue(skb, q, &to_free, =
txq);
> >>>                           count++;
> >>>                   }
> >>>
> >> why not only ?
> >> if (likely(next)) {
> >>       prefetch(next);
> >>       prefetch(&next->priority);
> >> }
> > Because we also can avoid clearing skb->next, we know it is already NUL=
L.
> >
> > Since we pay the price of a conditional, let's amortize its cost :/
>
> Thanks a lot for the explanation, I understand the goal of amortizing
> the cost and avoiding unnecessary writes to skb->next.
> Would it make sense to add if (likely(next)) around the prefetch?

I do not think this is unlikely(), otherwise my recent optimizations should=
 not
have been needed in the first place.

Just leave that to cpu branch prediction.

