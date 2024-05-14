Return-Path: <netdev+bounces-96335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE38C52E0
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E91BB21DB7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB01135418;
	Tue, 14 May 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9MAXs1R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C759135415
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686176; cv=none; b=frytyriVbDvIxVp5sVLEK2CfWcJpR0/hFojSRBI+WgleOwlyICXBnC7RfT9U7ZpQgDG/vOhpp3oJcYeUDB8aTOkYWINJ1w/99I3/Omx5UR46AjyGSRYfGZndsWv07bKDD3qoqLN8FUh466C6t7pECNmmZ8W7uKu2StryF3F8Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686176; c=relaxed/simple;
	bh=JGFdqHMyHHyVGH57vG+Ye8L9X2SHFst6BTedWvhxenk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTn9ShN6EHqtgmf0WLD2dNa0NHBP4Bt1o0ZWBlvj5Bc2YNsGXZNb2bdEzOwU+QH9Bm+EaRfjYXcb+d5pi2wp4Mu9QCaX7SR3m9KIsGeb3W0D+SFwvfspYhNrUUUeOnPUuteOeIylgm+xaWIJ/y53o/1BhrLpx5e02wGIdffXI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9MAXs1R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715686173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flEeY/O4N7D833PMe3UfECXddI8vom6pJRIV+piLbs4=;
	b=J9MAXs1RIY4u4Shs00865KauGCvGgjcEDKm5y8VEOgIrhVrhHqj5rT+xu6ZuHXqDtEZmFI
	tmdAPcw6z3dX05zYggrDCV4wGfx+83XJRDdylCIWb4PsZcdNlqx/uBTRtoR7rPLw2mPuI6
	3PyiI2qNBDu+tP4PTJiHe8sCqPCCBO8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-dgvQGJ8rPMKAT2eZXM3Mrw-1; Tue, 14 May 2024 07:29:31 -0400
X-MC-Unique: dgvQGJ8rPMKAT2eZXM3Mrw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b2d29dce36so4528793a91.2
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715686171; x=1716290971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flEeY/O4N7D833PMe3UfECXddI8vom6pJRIV+piLbs4=;
        b=KHg2M08ejjKL4RWHo8uk48o0NjttNeaXOGkKU3TchrD8PR6ab5tOCbJsvPjSELbnBJ
         c9gVg0AKzMa2A+T4su3uD9umzj/Lk1fhI4uf+uqhkrJqz8SNaHM6REVsyajOJDcgP1N2
         t0EDCIzvUIODyJiE0RjQ38TXz5lwz//BMtvDUcH0uddBGT03x7P/nQkJeKNv6QP15UQ7
         oWmj8H9Ba6rVojQFuKXwTA1iCe/BcNmIfBYP5RjboabR+3OwAlsXmulCsIo6kHfppfr0
         PdBV1SqDDd6IKgsBtA3PFos0Vix6PKaGEbJwo5CLvmLq55Vb8Y52D5F302uaOOmLNyPd
         y61Q==
X-Gm-Message-State: AOJu0YxuQJt02fBVpiJOwGwuJJb7gvp1x1ljxpyvthdwmibxXxs7s7p3
	+RlDXJq/wUT5crByoWvRG313m/ziEJA7U8mZp7lNnkh5P+yOCj6lY0bKrur4LQbX6Z91JG8GrIq
	83l0uK4Ey7Xme89WHl3pyGua5f5JlGAb54c6sXCRb/C0AeLyIN4fF+B8xQmdffy8Nemfr7rgetF
	CISgunkSgLeNwwthPElpWnCHjBviTH
X-Received: by 2002:a17:90a:9503:b0:2b5:af07:1cde with SMTP id 98e67ed59e1d1-2b6ccb7e603mr11029335a91.34.1715686170700;
        Tue, 14 May 2024 04:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhUoxRR4iODAYilnLI2gCexkikpzt+ccYtOSxmTpFNXLI9vev/QOk0wWP++Y9vwQjKT6xkBbPIIR1QeyRRUJY=
X-Received: by 2002:a17:90a:9503:b0:2b5:af07:1cde with SMTP id
 98e67ed59e1d1-2b6ccb7e603mr11029312a91.34.1715686170267; Tue, 14 May 2024
 04:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-3-omosnace@redhat.com> <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
 <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com> <CAHC9VhTxhcSDfYCK95UsuZixMSRNFtTGkDvBWjpagHw6328PMQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTxhcSDfYCK95UsuZixMSRNFtTGkDvBWjpagHw6328PMQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 14 May 2024 13:29:18 +0200
Message-ID: <CAFqZXNurJZ-q64gxh54YhoO_GZeFzxXE0Yta_X-DqF_CcRSvRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 11:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Apr 17, 2024 at 9:03=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Tue, Apr 16, 2024 at 8:39=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > As the comment in this function says, the code currently just clear=
s the
> > > > CIPSO part with IPOPT_NOP, rather than removing it completely and
> > > > trimming the packet. This is inconsistent with the other
> > > > cipso_v4_*_delattr() functions and with CALIPSO (IPv6).
> > >
> > > This sentence above implies an equality in handling between those thr=
ee
> > > cases that doesn't exist.  IPv6 has a radically different approach to
> > > IP options, comparisions between the two aren't really valid.
> >
> > I don't think it's that radically different.
>
> They are very different in my mind.  The IPv4 vs IPv6 option format
> and handling should be fairly obvious and I'm sure there are plenty of
> things written that describe the differences and motivations in
> excruciating detail so I'm not going to bother trying to do that here;
> as usual, Google is your friend.  I will admit that the skbuff vs
> socket-based labeling differences are a bit more subtle, but I believe
> if you look at how the packets are labeled in the two approaches as
> well as how they are managed and hooked into the LSMs you will start
> to get a better idea.  If that doesn't convince you that these three
> cases are significantly different, I'm not sure what else I can say
> other than we have a difference of opinion.  Regardless, I stand by my
> original comment that I don't like the text you chose and would like
> you to remove or change it.

Ok, I amended this part for v2 to hopefully better express what I'm
alluding to. I also added a paragraph about the routers dropping
packets with IP options, which explains the motivation better, anyway.

> > > > Implement the proper option removal to make it consistent and produ=
cing
> > > > more optimal IP packets when there are CIPSO options set.
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  net/ipv4/cipso_ipv4.c | 89 ++++++++++++++++++++++++++++-----------=
----
> > > >  1 file changed, 59 insertions(+), 30 deletions(-)
> > >
> > > Outside of the SELinux test suite, what testing have you done when yo=
u
> > > have a Linux box forwarding between a CIPSO network segment and an
> > > unlabeled segment?  I'm specifically interested in stream based proto=
cols
> > > such as TCP.  Also, do the rest of the netfilter callbacks handle it =
okay
> > > if the skb changes size in one of the callbacks?  Granted it has been
> > > *years* since this code was written (decades?), but if I recall
> > > correctly, at the time it was a big no-no to change the skb size in a
> > > netfilter callback.
> >
> > I didn't test that, TBH. But all of cipso_v4_skbuff_setattr(),
> > calipso_skbuff_setattr(), and calipso_skbuff_delattr() already do
> > skb_push()/skb_pull(), so they would all be broken if that is (still?)
> > true. And this new cipso_v4_skbuff_delattr() doesn't do anything
> > w.r.t. the skb and the IP header that those wouldn't do already.
>
> Fair point on skbuff size changes in netfilter and
> cipso_v4_skbuff_setattr(), that wasn't part of the original
> NetLabel/CIPSO support and I forgot about that aspect.  On the other
> hand, I believe cipso_v4_skbuff_delattr() was part of the original
> work and used the NOOP hack both to preserve the packet length in the
> netfilter chain and to help ensure a consistent IP header overhead on
> both sides of a forwarding CIPSO<->unlabeled labeling/access control
> system.  Which brings me around to the reason why I asked about
> testing; I think we need to confirm that nothing bad happens to
> bidirectional stream-based connections, e.g. TCP, when crossing over a
> CIPSO/unlabeled network boundary and the IP overhead changes.  It's
> probably okay, but I would like to see that you've tested it with a
> couple different client OSes and everything works as expected.

I tried to test what you describe - hopefully I got close enough:

My test setup has 3 VMs (running Fedora 39 from the stock qcow2 image)
A, B, and R, connected via separate links as A <--> R <--> B, where R
acts as a router between A and B (net.ipv4.ip_forward is set to 1 on
R, and the appropriate routes are set on A, B, R).

The A <--> R link has subnet 10.123.123.0/24, A having address
10.123.123.2 and R having 10.123.123.1.
The B <--> R link has subnet 10.123.124.0/24, B having address
10.123.124.2 and R having 10.123.124.1.

The links are implemented as GRE tunnels over the main network that is
shared between the VMs.

Netlabel configuration on A:
netlabelctl cipsov4 add pass doi:16 tags:5
netlabelctl map del default
netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
netlabelctl map add default address:::/0 protocol:unlbl
netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16
netlabelctl map add default address:10.123.124.0/24 protocol:cipsov4,16

Netlabel configuration on R:
netlabelctl cipsov4 add pass doi:16 tags:5
netlabelctl map del default
netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
netlabelctl map add default address:::/0 protocol:unlbl
netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,16

B has no netlabel configured.

(I.e. A tries to send CIPSO-labeled packets to B, but R treats the
10.123.124.0/24 network as unlabeled, so should strip/add the CIPSO
label when forwarding between A and B.)

A basic TCP connection worked just fine in both directions with and
without these patches applied (I installed the patched kernel on all
machines, though it should only matter on machine R). I ignored the
actual labels/CIPSO content - i.e. I didn't change the default SELinux
policy and put SELinux into permissive mode on machines A and R.

Capturing the packets on R showed the following IP option content
without the patches:
A -> R: CIPSO
R -> B: NOPs
B -> R: (empty)
R -> A: CIPSO

With the patches this changed to:
A -> R: CIPSO
R -> B: (empty)
B -> R: (empty)
R -> A: CIPSO

Is this convincing enough or do you have different scenarios in mind?

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


