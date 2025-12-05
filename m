Return-Path: <netdev+bounces-243829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72790CA8562
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89393538618
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3A732ED46;
	Fri,  5 Dec 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOM9Y5Ax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061B31960F
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764949008; cv=none; b=QbQo/nzRNIbROrfCybXY/hcyv5HgdIOkIbY44C4kq4LQAy5IFgftIPWAKvYLaGyAcgcleTz/mrCtl4ZtWJq+2xDlSQXCkSGG/3u7mNks7RpH4doyf6PvrWAAEoEzB1L4iaTjEKpvOeIOweTqCOmd4gkQ0yuPBtaOC1ZkXX4QXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764949008; c=relaxed/simple;
	bh=BwXEFoAlYxF87pVD7xEx8rHEYkiQrz/ynA3s2PdWKiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYlaQbkwf8zZYzguvshx/VgZPeKq89x1r2FAwMOfiC4OVlolObTT6CvUlJeff1iXDsEbH3OScAJ78800GeHPbOYQGn2IZJDNCrUHrJ6Ih+uIkO15W3dVjYQhTS9KOCVR3gvBmUHLxfZ674DoAC7SUGRCtzY1M+PNQOO4hCECIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOM9Y5Ax; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so17454881cf.2
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764948999; x=1765553799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DqhA6mqGz2I6eGX4oQ87ohYxtQ2z7fL8+qKtkzyG6o=;
        b=cOM9Y5Ax3crnYYydcl9EUo0HQEvdUgHqR5UyeqJWbspKk5kjPeBE1SI1a/j3J2LCM5
         TEp1jasgQ0qyhocZNYAgSu6i0v0zyOQVXMbErClmbflHW2Q4no6r7rif6snYFysrjmnZ
         9+tYwx33uigR8V7NpPyL33Dcc0MZXHMUqRlJlpP1I4XAgWd32NzkDvMQ8Fb/eqNvxwPN
         71rSvCoihdhu99QhVAuIPSH1jLlUEO04PbPgbVoMgu3IsM5rG0xk5hwA0g+/Lozj2GuF
         TeSAcyNzEyXomooKFEky00qwIAFqsD8XcH36LTyj6+lyiVFgIut2pgaQtX4IY+XTAuuQ
         vFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764948999; x=1765553799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DqhA6mqGz2I6eGX4oQ87ohYxtQ2z7fL8+qKtkzyG6o=;
        b=M9VcqDMbEnija0J/lEkNn9xcbuUPCcG15dt70O8qXKh+Jw/bONxQl4dS6k5fQ1RmzN
         PqIHCjpbW6262tIF8PC2Sb5cRc+JMZOYApuWotwNg3LxM+T07kP3c0bkweLuzSFTnerJ
         Go5PUo/dP3Q+pmpKTT2dRcZ/5ZuuqJgX2cPhdIRhbk1uWb7tfk4ddpXGcCnua09E/1me
         CsERUkbeztCo6sUzBhsx4SZwoQVMiMko4zU4YdEwvw2j5kyS40v1n6Cb/ofokGrG5dpP
         0Jocm0jqLX118LTo8O4qieILpW8Iq+Bcb3Xkjw9rWkYACN4GFmxMONeiB2VDNgXXtw9q
         B62Q==
X-Gm-Message-State: AOJu0YytXQwjyACDmObtaty1Vm9pz0l7uUPvtqqjbvejqQf181gXnwfy
	QfERnNFrEaXUMYoixOkrx0uj8C8lg2Xv6Ovw6g9PbHo8dMBxh1Kl0QNxiTBurlZD2FJh3NSNZen
	cUkE/9HfJCRdkOxN5e13Y81XP3P97XAjFNC75vYUQ
X-Gm-Gg: ASbGnct1g8b88VJoKxwXA75NxmquEy0R3HqdOCHRKtITY7NdBfQ4fUWzLiEgmUIEeja
	hJOzjh//nHS+dHZ+Aissu7v8Ydn6TwHR7DqtihkDK/34QMPLhgOyYm9Quwm0oH/h1/t8jutJRvs
	rAqu8js4+Mlug+IbTbCRZ9ZbCDpqN5rRv2ZfOrQmy67aZSCF3re7WLgCeRJx5f5FbV2yJ9ytlYA
	M/S7t8URZ13pJUB8hIeC8jciue88xkLsTLR431YhQ+G9X0Xl7016ZC4l0xCB5JsRBbzCpg=
X-Google-Smtp-Source: AGHT+IFyTVoru3d3UtZ+V1Mk7fj7vS2dQL1UqAkH7gjGI0wnYFsxuOXYOEI0j8ZanjpYOXLucXrn04EL7kwSv6e3LRY=
X-Received: by 2002:ac8:5fcb:0:b0:4ed:3d24:9581 with SMTP id
 d75a77b69052e-4f023b1b9aamr105377061cf.83.1764948999110; Fri, 05 Dec 2025
 07:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764943231.git.pabeni@redhat.com> <98a7e20010265e3ebf9d7e6d6dfb7339d5db7b99.1764943231.git.pabeni@redhat.com>
 <CANn89iL3hp4Of_U+Yc34OrwVnTwn5j4j=WTq-yckGVcpptxcUg@mail.gmail.com> <bb866d37-6e89-460f-a411-e9f26b0fa4e4@redhat.com>
In-Reply-To: <bb866d37-6e89-460f-a411-e9f26b0fa4e4@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Dec 2025 07:36:27 -0800
X-Gm-Features: AWmQ_bnywJlx73jOENUhyxFXUsSYZW4PU8QQDSQMLAP5weV6z3AB6MRtg3hvH8Q
Message-ID: <CANn89i+tRF0QerD44j=QRx34_n39jNJu+SkDP+owUw2=+4q=8w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] net: gro: avoid relaying on skb->transport_header
 at receive time
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 12/5/25 3:37 PM, Eric Dumazet wrote:
> > On Fri, Dec 5, 2025 at 6:04=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >>
> >> Currently {tcp,udp}_gro_receive relay on the gro network stage setting
> >
> > rely :)
> >
> >> the correct transport header offset for all the skbs held by the GRO
> >> engine.
> >>
> >> Such assumption is not necessary, as the code can instead leverage the
> >> offset already available for the currently processed skb. Add a couple
> >> of helpers to for readabilty' sake.
> >>
> >> As skb->transport_header lays on a different cacheline wrt skb->data,
> >> this should save a cacheline access for each packet aggregation.
> >> Additionally this will make the next patch possible.
> >>
> >> Note that the compiler (gcc 15.2.1) does inline the tcp_gro_lookup()
> >> call in tcp_gro_receive(), so the additional argument is only relevant
> >> for the fraglist case.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >>  include/net/gro.h        | 26 ++++++++++++++++++++++++++
> >>  include/net/tcp.h        |  3 ++-
> >>  net/ipv4/tcp_offload.c   | 15 ++++++++-------
> >>  net/ipv4/udp_offload.c   |  4 ++--
> >>  net/ipv6/tcpv6_offload.c |  2 +-
> >>  5 files changed, 39 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/include/net/gro.h b/include/net/gro.h
> >> index b65f631c521d..fdb9285ab117 100644
> >> --- a/include/net/gro.h
> >> +++ b/include/net/gro.h
> >> @@ -420,6 +420,18 @@ struct sk_buff *udp_gro_receive(struct list_head =
*head, struct sk_buff *skb,
> >>                                 struct udphdr *uh, struct sock *sk);
> >>  int udp_gro_complete(struct sk_buff *skb, int nhoff, udp_lookup_t loo=
kup);
> >>
> >> +/* Return the skb hdr corresponding to the specified skb2 hdr.
> >> + * skb2 is held in the gro engine, i.e. its headers are in the linear=
 part.
> >> + */
> >> +static inline const void *
> >> +skb_gro_header_from(const struct sk_buff *skb, const struct sk_buff *=
skb2,
> >> +                   const void *hdr2)
> >> +{
> >> +       size_t offset =3D (unsigned char *)hdr2 - skb2->data;
> >> +
> >> +       return skb->data + offset;
> >> +}
> >
> > I would rather switch gro to pass an @offset instead of a header pointe=
r ?
> >
> > Rebuilding one header pointer from offset is fast : skb->data + offset
> > ( offset : network header, transport header, ...)
>
> I considered such option and opted for the above for a very small
> reason: it produces a little more compact (C) code in the caller.
>
> I'll switch to offset in next revisions.

I am

> > As a matter of fact, some GRO state variables could be onstack, instead
> > of being stored in NAPI_GRO_CB()
> Do you mean the network offsets? In any case, I hope we can keep such
> work separate from this one?

Sure, just some general observation.

BTW the offending memset() can be optimized a bit to not let the
compiler call an external function.
I do not know how to upstream this properly ;)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a..7df63dc79cf3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -424,7 +424,13 @@ struct sk_buff *slab_build_skb(void *data)
        if (unlikely(!skb))
                return NULL;

-       memset(skb, 0, offsetof(struct sk_buff, tail));
+       /* Implement memset(skb, 0, offsetof(struct sk_buff, tail)
+        * so that compiler inlines it ;)
+        */
+       memset(skb, 0, 128);
+       barrier();
+       memset((void *)skb + 128, 0, offsetof(struct sk_buff, tail) - 128);
+
        data =3D __slab_build_skb(data, &size);
        __finalize_skb_around(skb, data, size);

