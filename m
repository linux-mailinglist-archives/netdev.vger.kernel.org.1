Return-Path: <netdev+bounces-164780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C480A2F12E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E6316427C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD52236E8;
	Mon, 10 Feb 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vq6/nQN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519F22DFA8
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200429; cv=none; b=sT5j0tUaFCKwhER88DC6tSBLFZnrRPzqKbYzZ9vuNqcd6tGFc/0g1EU9Blk/0kdbDIDe03a/+N4Cc+H2UFXBna7QnhQ5JuKlw4L6SVJU6nWDyOcl5t7EybOMw4oqToeOHbA9UszCEQXBTv4GozOelqaFE5qtPisZcL6dIOoK1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200429; c=relaxed/simple;
	bh=7M0k9hblYmeyxSPrkTnPaSgP3A2SnOYlMNRC3JPlPOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duCKmw08iGSiJ3YzpoeZVXfbE5pbZW0PBo3d514JI7UM9uIi6J9sGVaGYmhqcL4YtFgdn4lXp/0Jd67S73kt1D0l4XYewGqZ79jJgWX4A9bdHbi0MftRc1Yj6/5kInmMgyvlWu7um45eE3I+iqFnkPK7OsPqqKLVFYU0We0jWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vq6/nQN9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de7531434fso2404200a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739200426; x=1739805226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7d62r/N8/nAroP9UUx8iCS/sl1pAx4hGM9/ax9iQoc=;
        b=Vq6/nQN9BiiMDxnEC4yzoLtbx2sWAbeqXgzb43V21scn+iFEcVglpWgKR7OYPCh7fw
         VUZOXjMZuJGXt+fOJO9wacdUhFRz33oSoZr74PJsXfl2zP2snBiGm+woYQiA5Q1ijhTG
         m9Ms6UIQVT5QTxufQLMAf8qcdjJ6X+O/p+nDQAHRzOOE6qbChXsXzw0rgABFrlgAgtRD
         C7nlQ0bXFjteMQbyteikhGwmdoLaLbjy3pA2Glm+0ikxWG2+g3axMaFK8nefiVWJE8ze
         8gzPTZ0dnDezjSncm/X49vB5KFhNRYsdYbeYbkSGfPh3yMAdtCE+eYzM3VpEGcfEh9kO
         vq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200426; x=1739805226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7d62r/N8/nAroP9UUx8iCS/sl1pAx4hGM9/ax9iQoc=;
        b=WeX3QyfbHj1QT6DUn87JKGS6fyfrIj0MwrIBE1GHdqiznxU/5One7WSM++cMq+wsfH
         p17HI//NHorvOekaqJeWW7tM7EIemJagcPVyaQbQGw/YBfTigqQ3g2FBCemEbW856hKw
         YwgxQ12nXWDADwzr8qbAsMYptbjXqMPBN16SOhYE+2Vm6N0P5+WSqTj1GTEn8KOe5i8h
         p9JCc3uskUYLk1Js4LAAC+3B3oKNW43XepEk6r1d0TulK2f2mvb0f/7H5dRXS37oxzuB
         sAcXCfMGYXeCrOBazb4WQiyN1Q1t8XA1Tg+2lK4yzczg+pZBTU+QZBawO13RcsyY01Nd
         AQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCV9ieMemZG6CDwhRbYfmFkCCdwcsQOquw/Cfe1ETYruL1M/KpB/Ssupf2xfg54dGKLr99SKo2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQmJGDOJzjcuXhYlPdfBFe1sYbcwIGwuYdLAUcNoEZsWAMlP7
	hfOBCbhEutLkZYrmOgLUlUw1sgP8GhGZsQ21QVsc61j0H8y0exjLZJGs0feyc7mJvwZF/4iZz74
	6FOj7I1R4SABNeWvtSWSpcnMKR2Le0gjB6kWj
X-Gm-Gg: ASbGncvqil09Gr/Lkw/wFkQW7SRCD6fASsmeLIT9PxkIKTMugDJ2isRIvLVgrZtkmM3
	P9r47qFx5lyAIBRk9eD8VkMMLcNP8D6/UxlwjabA9CtXWU7mr2HhU04hZLhEXh5mvxFpxwww8
X-Google-Smtp-Source: AGHT+IG2zcWhjGdyg38fhZW7b5iJ/s2k+Fiqjh/rKYx46navlKcSoOVZbDtAU2cyC/vNVJmgt7t2XIDpE46uiDKCzGM=
X-Received: by 2002:a05:6402:354b:b0:5dc:d0be:c348 with SMTP id
 4fb4d7f45d1cf-5de45107542mr13820277a12.20.1739200425947; Mon, 10 Feb 2025
 07:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738940816.git.pabeni@redhat.com> <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 16:13:35 +0100
X-Gm-Features: AWEUYZlMGktKNJ4PDISu4bAVczN0Hl9ajhxQXCL33aj4SvcU4LiiYsSv_H5k_gc
Message-ID: <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:00=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Paolo Abeni wrote:
> > While benchmarking the recently shared page frag revert, I observed a
> > lot of cache misses in the UDP RX path due to false sharing between the
> > sk_tsflags and the sk_forward_alloc sk fields.
> >
> > Here comes a solution attempt for such a problem, inspired by commit
> > f796feabb9f5 ("udp: add local "peek offset enabled" flag").
> >
> > The first patch adds a new proto op allowing protocol specific operatio=
n
> > on tsflags updates, and the 2nd one leverages such operation to cache
> > the problematic field in a cache friendly manner.
> >
> > The need for a new operation is possibly suboptimal, hence the RFC tag,
> > but I could not find other good solutions. I considered:
> > - moving the sk_tsflags just before 'sk_policy', in the 'sock_read_rxtx=
'
> >   group. It arguably belongs to such group, but the change would create
> >   a couple of holes, increasing the 'struct sock' size and would have
> >   side effects on other protocols
> > - moving the sk_tsflags just before 'sk_stamp'; similar to the above,
> >   would possibly reduce the side effects, as most of 'struct sock'
> >   layout will be unchanged. Could increase the number of cacheline
> >   accessed in the TX path.
> >
> > I opted for the present solution as it should minimize the side effects
> > to other protocols.
>
> The code looks solid at a high level to me.
>
> But if the issue can be adddressed by just moving a field, that is
> quite appealing. So have no reviewed closely yet.
>

sk_tsflags has not been put in an optimal group, I would indeed move it,
even if this creates one hole.

Holes tend to be used quite fast anyway with new fields.

Perhaps sock_read_tx group would be the best location,
because tcp_recv_timestamp() is not called in the fast path.

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8be64550dcfd6ce213039460acb1f..b54fbf2d9e72c3d3300e1f7638e=
cfbb99fdf409d
100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -444,7 +444,6 @@ struct sock {
        socket_lock_t           sk_lock;
        u32                     sk_reserved_mem;
        int                     sk_forward_alloc;
-       u32                     sk_tsflags;
        __cacheline_group_end(sock_write_rxtx);

        __cacheline_group_begin(sock_write_tx);
@@ -474,6 +473,7 @@ struct sock {
        unsigned long           sk_max_pacing_rate;
        long                    sk_sndtimeo;
        u32                     sk_priority;
+       u32                     sk_tsflags;
        u32                     sk_mark;
        struct dst_entry __rcu  *sk_dst_cache;
        netdev_features_t       sk_route_caps;
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e03df370d8ef7750a7bb13cc3b8d8f..4f855361b6c7fa74c449bf5ea3a=
0e88b7c0f33fb
100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4371,7 +4371,6 @@ static int __init sock_struct_check(void)
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock=
);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx,
sk_reserved_mem);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx,
sk_forward_alloc);
-       CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_tsfl=
ags);

        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx,
sk_omem_alloc);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_tx,
sk_omem_alloc);
@@ -4394,6 +4393,7 @@ static int __init sock_struct_check(void)
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_sndtime=
o);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_priorit=
y);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_mark);
+       CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_tsflags=
);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_dst_cac=
he);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_route_c=
aps);
        CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_tx, sk_gso_typ=
e);

