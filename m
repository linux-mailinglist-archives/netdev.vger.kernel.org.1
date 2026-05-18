Return-Path: <netdev+bounces-289015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDK9BFv8CmqA+wQAu9opvQ
	(envelope-from <netdev+bounces-289015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:47:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1E56BEAD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7466300A24B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8533F58F5;
	Mon, 18 May 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROs4Xx6N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERfZhbQo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904523F58CE
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104184; cv=none; b=JP0kXZZKWqG5w4JNcbyD7HS4SyjDDM83Vg3md6QWNJSC1DnnodWaUCATWy5+DUItn44F4FuG1gEEKtgF8QQ9iCAeFCDfpoOuQ/HHS623qJ/NjAr4IhL6bjHbFNf1agb/l5mKv92FUo29Mfq8kGOWMuW0b673l+tkQ3PhZw3IdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104184; c=relaxed/simple;
	bh=uRqgpJQDvSNjyFzu8WpFAXTfCd5Yymnm3C1VNqMUoAc=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=fJKjnadsN94R6BwFwgHuOHV62Ey/fP9l4se2gjyg78zm8Sb3/bHCXP5778xJnzd54lC3uDEKx5Ra/EA2uAVWY289chBHwD/lELc8XA+AK7Og1Vx/jtSYu+B5l9VTqsZxbAJXvltm7RVZJaf1r9npqCANKtRE3Sz4MVesf1liHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROs4Xx6N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERfZhbQo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779104179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7BFsKyRIl+lKDTkw/Af1w2S9ANPorpkXTXQJBZlVUjQ=;
	b=ROs4Xx6N0iD6HnK3cAEyqET+72ndmiT8564LtMfwOAzBKSbCl1GCdOazzJHiUuZ+eOxIN7
	sdaddYes02PksIS9QrSqD5G55FCb6nRkDmDiP1+cbcGC8hs+HidKKHhhWcGPBmsiE+dboJ
	z95XJsHHRxfVV3uV8Sy7kzMGh/is12c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-o_IwEU74Nei4tlZVpJg2YA-1; Mon, 18 May 2026 07:36:18 -0400
X-MC-Unique: o_IwEU74Nei4tlZVpJg2YA-1
X-Mimecast-MFC-AGG-ID: o_IwEU74Nei4tlZVpJg2YA_1779104177
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-389e0db12cbso15849121fa.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779104177; x=1779708977; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BFsKyRIl+lKDTkw/Af1w2S9ANPorpkXTXQJBZlVUjQ=;
        b=ERfZhbQogm1mDeK8p/Wb5hlCgQtGD+J69Xs0cQOIM4xjYCykbA7A7yVXSmP48TU/N7
         oItuC19cyo8rjSRW/aTRY7XQtYJJVEEWnSfdlAKy1hx9kp+nrkL2oznRViEP+yakXXgn
         YWVBSYbBkEp0k1dgEcEmxgA+RqILOVdpA3wRku90fJe+7/heN+SNKosFYfzT1iS/8Skt
         043g1lHGYE6fag1WfmmeGMXSIZIDxdfLWe7+q61lDj0abZJJmQXMZ7SEolP068OppW0F
         hhbs7P1HTjCgmsgljpOsSPSLsHxvzSB8RwABDwL6iGuOPRUTo4oiSrhCG0S6dWlGeTeO
         FYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779104177; x=1779708977;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BFsKyRIl+lKDTkw/Af1w2S9ANPorpkXTXQJBZlVUjQ=;
        b=bfEd7i32ypkz+MjjyrmIwituziluiRdN9jtp4C+4g6zId51HI8KencK/0jFhdZXiwM
         C2zZ6rXkhCTbA10imjgiwWey6WOACbBPLG0xEfSdeAXK+VnMZqIz6ai8JhNOqQ86x/Xd
         FPc9Biz4Uez+hCj3+v7IqfvN7Ehc+7SCBt/NTNb9TtvLjSyRb12B75CSqY7BhyYE1XmW
         wzvQEdu0uq1ec4sCMI/c5mFb3mAKGDou02YQ0jmTb6EUgQdlh13ZC7ODoAUKM1i6KdW4
         b0wzcnOf6TNKG5PlshbU4lCpWUwTV3xKUMlgOReMZx+Q90zG1wM5I7Uv++H8SFbbN96c
         j9pQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cliuhJaGjWmKwVoSnlW0RT9GVwCAzx/b58Or9CzzuuGJPP4teP5PJo28S2J0QDZ+Rm14CwlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFBISTCA1rWqjm+fF8PzSLktR0sauCboHC5NJajH7A3CeiSfF
	jYlxl6kTxQYDKXrHlJdQKGRAsb3/izTTO8b6/9wPh3DTeuLStGzdtxRLiJJt8by7bPu3/OdyDVe
	zvTe6sZ2LlCCuOesR9xLflrc2Scq7cx+cZ1bRJifVdyjnacSdNKikDaq48w==
X-Gm-Gg: Acq92OGBHMW1ZWfDNw0++WJrGgTUgEbJ/3sTktgFwPQq3Cil/ssqnjeqNCtV2jq0VDW
	7SzfwfnFQJ4P2ZcKmymyfY9H6Uu4fYXvkXIG/0JEE8WrLXLOswREGdPsihXVX5bZ8/hU62yIA+h
	Pu+dkySu5M2rQO58//S9pgNPxz6nwjmT0CqLf1IXcfz+YkaESYq55ye2zqTNpXSvIlQNO5qrc6w
	F9sdssGmpDRlH6F/5BWHkKHreMS4vwHIikDAa47jMprBwOt3NK+AAx/0bt5bJcoWxzZB8ytTELS
	frVeb7WNsbyLvS8yx/TwzqY2Zw4Spr6UndX1oCbz4sfEqDktFRuaVAZ9GbQZ9vgkguegq2sWeaH
	1w530rLfaV4FA6ObYLnQKRJQO8np6AixW6Vl9orKwFCfxDYUG6Q==
X-Received: by 2002:a05:600c:821b:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48fe6515831mr212438465e9.25.1779103730886;
        Mon, 18 May 2026 04:28:50 -0700 (PDT)
X-Received: by 2002:a05:600c:821b:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48fe6515831mr212437835e9.25.1779103730317;
        Mon, 18 May 2026 04:28:50 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb029180sm118110505e9.4.2026.05.18.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:28:49 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pavel Emelyanov
 <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, Jon Maloy
 <jmaloy@redhat.com>, Dmitry Safonov <dima@arista.com>, Andrei Vagin
 <avagin@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Neal
 Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, Shuah
 Khan <shuah@kernel.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair
 mode
Message-ID: <20260518132831.5b9eb0a8@elisabeth>
In-Reply-To: <CANn89iKLfBmh3_t4xJz3dDJ8VkMsEtHRifg0mRV1PPAryNY1-g@mail.gmail.com>
References: <20260517184158.2757505-1-sbrivio@redhat.com>
	<20260517184158.2757505-2-sbrivio@redhat.com>
	<CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com>
	<20260517215307.13cda56a@elisabeth>
	<CANn89iKLfBmh3_t4xJz3dDJ8VkMsEtHRifg0mRV1PPAryNY1-g@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 13:28:48 +0200 (CEST)
X-Rspamd-Queue-Id: 14F1E56BEAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289015-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,passt.top:url]
X-Rspamd-Action: no action

On Mon, 18 May 2026 00:57:16 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Sun, May 17, 2026 at 12:53=E2=80=AFPM Stefano Brivio <sbrivio@redhat.c=
om> wrote:
> >
> > On Sun, 17 May 2026 12:05:45 -0700
> > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > =20
> > > On Sun, May 17, 2026 at 11:41=E2=80=AFAM Stefano Brivio <sbrivio@redh=
at.com> wrote: =20
> > > >
> > > > Once a socket enters repair mode (TCP_REPAIR socket option with
> > > > TCP_REPAIR_ON value), it's possible to dump the receive sequence
> > > > number (TCP_QUEUE_SEQ) and the contents of the receive queue itself
> > > > (using TCP_REPAIR_QUEUE to select it).
> > > >
> > > > If we receive data after the application fetched the sequence number
> > > > or saved the contents of the queue, though, the application will now
> > > > have outdated information, which defeats the whole functionality,
> > > > because this leads to gaps in sequence and data once they're restor=
ed
> > > > by the target instance of the application, resulting in a hanging or
> > > > otherwise non-functional TCP connection.
> > > >
> > > > This type of race condition was discovered in the KubeVirt integrat=
ion
> > > > of passt(1), using a remote iperf3 client connected to an iperf3
> > > > server running in the guest which is being migrated. The setup allo=
ws
> > > > traffic to reach the origin node hosting the guest during the
> > > > migration.
> > > >
> > > > If passt dumps sequence number and contents of the queue *before*
> > > > further data is received and acknowledged to the peer by the kernel,
> > > > once the TCP data connection is migrated to the target node, the
> > > > remote client becomes unable to continue sending, because a portion
> > > > of the data it sent *and received an acknowledgement for* is now lo=
st.
> > > >
> > > > Schematically:
> > > >
> > > > 1. client --seq 1:100--> origin host --> passt --> guest --> server
> > > >
> > > > 2. client <--ACK: 100-- origin host
> > > >
> > > > 3. migration starts, =20
> > >
> > > Here, a netfilter rule or bpf prog must be installed to
> > > drop packets temporarily until migration completes. =20
> >
> > Thanks for the review.
> >
> > I have to say it's rather unexpected to have to work around obvious
> > kernel issues in userspace: TCP_REPAIR implies that queues are frozen,
> > and this is handled correctly on the sending side (see
> > tcp_write_xmit()), but was clearly forgotten on the receiving side. =20
>=20
> Have you contacted TCP repair authors for best practices?

I Cc'ed them here, Pavel is the author (but as far as I understand not
active in kernel development anymore), and I know that Andrei did some
substantial work on it in the past, so he's Cc'ed here as well.

But we are following what CRIU (the userspace reference implementation)
does, and CRIU would be affected by this issue as well (depending on
usage).

> Please do not add code to TCP fast path.

My understanding was that we should avoid adding *computational
overhead* to it, which this patch doesn't _seem_ to add. The actual
overhead it adds is in the slow path.

But, regardless of that, I hope I found a solution that would address
your potential concern as well.

There seems to be a common way to disable fast path for a given socket
(and to re-enable it later), courtesy of those tp->pred_flags that are
checked in the existing condition in tcp_rcv_established().

The idea looking at other functions seems to be:

- set pred_flags to 0 to disable the fast path (which I would do once
  TCP_REPAIR_ON is set)

- call __tcp_fast_path_on(), which recalculates it, to re-enable fast
  path (which I would do for TCP_REPAIR_OFF / TCP_REPAIR_OFF_NO_WP)

That's what other implementations dealing with rare / corner cases, such
as tcp_data_queue_ofo(), or tcp_check_urg(), seem to be handling
this. It looks rather idiomatic. I wasn't aware of that.

I plan to post a v2 doing this instead, in a bit.

> Instead make sure TCP repair inserts in ehash table sockets ready to be u=
sed.

I guess you're referring to the other issue / hack Kuniyuki linked,
where the kernel is sending RST segments for sockets that have been
closed and (not yet) reopened?

For the specific race condition I'm dealing with here I don't think
that would help. Here it's about incoming data being queued when it
shouldn't. The sockets are already in the ehash table ready to be used
(...that's actually the problem, in some sense).

> Yes, it is more complex, but I am sure it can be done properly.
>=20
> > TCP_REPAIR also allows to dump queues, not just sequence numbers, so
> > this really is a bad race condition making the whole functionality
> > unreliable.
> >
> > But anyway, even looking for a practical workaround of the kind you
> > suggested, I see two issues with it:
> >
> > 1. we would still have a race condition, because userspace doesn't have
> >    a way to synchronise application of nftables rules (or even a BPF
> >    program) with the effects of TCP_REPAIR. We could apply nftables
> >    rules "a while before" just to be sure, but this is severely going to
> >    impact migration downtime
> >
> > 2. passt(1) runs unprivileged and uses a very simple helper to set
> >    TCP_REPAIR on the socket. Expanding helpers of this kind to directly
> >    manipulate nftables rules, or installing BPF programs, looks like a
> >    substantial security drawback
> > =20
> > > We do not want unlikely tests in the fast path. =20
> >
> > I understand, but note that this doesn't really add a branch to the
> > fast path: there's already a list of (more expensive) conditions under
> > which we need to fall back to slow path, with 'tp' definitely
> > prefetched at that point, so I don't expect any fast path cost from
> > doing this. Everything else is handled in the slow path.
> >
> > To be sure, I also checked throughput with delivery to local sockets as
> > that's the only case affected (veth setup similar to the one from the
> > selftests from patch 2/2) and there's no visible difference.
> > =20
> > > You can find a similar issue:
> > > https://lore.kernel.org/netdev/20260130145122.368748-1-me@linux.beaut=
y/ =20
> >
> > That one is not a kernel issue: in that case, the socket is closed, so
> > it's actually expected that the kernel will reset the connection. As
> > Jakub pointed out, that patch introduces a race condition on its own,
> > and it's a hack rather than a fix.
> >
> > We happened to have that kind of issue in passt as well (the
> > implementation is inspired by CRIU), but that's something entirely
> > different which userspace clearly needs to take care of, so we fixed it
> > here:
> >
> >   https://passt.top/passt/commit/?id=3Da8782865c342eb2682cca292d5bf92b5=
67344351
> > =20
> > > > passt enables repair mode, dumps the sequence
> > > >    number (101) and sends it to the target node of the guest migrat=
ion
> > > >
> > > > 4. client --seq 101:201--> origin host (passt not receiving anymore)
> > > >
> > > > 5. client <--ACK: 201-- origin host
> > > >
> > > > 6. migration completes, and passt restores sequence number 101 on t=
he
> > > >    migrated socket
> > > >
> > > > 7. client --seq 201:301--> target host (now seeing a sequence jump)
> > > >
> > > > 8. client <--ACK: 100-- target host
> > > >
> > > > ...and the connection can't recover anymore, because the client can=
't
> > > > resend data that was already (erroneously) acknowledged. We need to
> > > > avoid step 5. above.
> > > >
> > > > This would equally affect CRIU (the other known user of TCP_REPAIR),
> > > > should data be received while the original container is frozen: the
> > > > sequence dumped and the contents of the saved incoming queue would
> > > > then depend on the timing.
> > > >
> > > > The race condition is also illustrated in the kselftests introduced
> > > > by the next patch.
> > > >
> > > > To prevent this issue, discard data received for a socket in repair
> > > > mode, with a new reason, SKB_DROP_REASON_SOCKET_REPAIR.
> > > >
> > > > Fixes: ee9952831cfd ("tcp: Initial repair mode")
> > > > Tested-by: Laurent Vivier <lvivier@redhat.com>
> > > > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > > > ---
> > > >  include/net/dropreason-core.h |  3 +++
> > > >  net/ipv4/tcp_input.c          | 14 +++++++++++++-
> > > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/net/dropreason-core.h b/include/net/dropreason=
-core.h
> > > > index 2f312d1f67d6..19ab9e6ffc33 100644
> > > > --- a/include/net/dropreason-core.h
> > > > +++ b/include/net/dropreason-core.h
> > > > @@ -9,6 +9,7 @@
> > > >         FN(SOCKET_CLOSE)                \
> > > >         FN(SOCKET_FILTER)               \
> > > >         FN(SOCKET_RCVBUFF)              \
> > > > +       FN(SOCKET_REPAIR)               \
> > > >         FN(UNIX_DISCONNECT)             \
> > > >         FN(UNIX_SKIP_OOB)               \
> > > >         FN(PKT_TOO_SMALL)               \
> > > > @@ -158,6 +159,8 @@ enum skb_drop_reason {
> > > >         SKB_DROP_REASON_SOCKET_FILTER,
> > > >         /** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is=
 full */
> > > >         SKB_DROP_REASON_SOCKET_RCVBUFF,
> > > > +       /** @SKB_DROP_REASON_SOCKET_REPAIR: socket is in repair mod=
e */
> > > > +       SKB_DROP_REASON_SOCKET_REPAIR,
> > > >         /**
> > > >          * @SKB_DROP_REASON_UNIX_DISCONNECT: recv queue is purged w=
hen SOCK_DGRAM
> > > >          * or SOCK_SEQPACKET socket re-connect()s to another socket=
 or notices
> > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > index d5c9e65d9760..6eca34274f97 100644
> > > > --- a/net/ipv4/tcp_input.c
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -6457,6 +6457,7 @@ static bool tcp_validate_incoming(struct sock=
 *sk, struct sk_buff *skb,
> > > >   *       or pure receivers (this means either the sequence number =
or the ack
> > > >   *       value must stay constant)
> > > >   *     - Unexpected TCP option.
> > > > + *     - Socket is in repair mode.
> > > >   *
> > > >   *     When these conditions are not satisfied it drops into a sta=
ndard
> > > >   *     receive procedure patterned after RFC793 to handle all case=
s.
> > > > @@ -6506,7 +6507,8 @@ void tcp_rcv_established(struct sock *sk, str=
uct sk_buff *skb)
> > > >
> > > >         if ((tcp_flag_word(th) & TCP_HP_BITS) =3D=3D tp->pred_flags=
 &&
> > > >             TCP_SKB_CB(skb)->seq =3D=3D tp->rcv_nxt &&
> > > > -           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> > > > +           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt) &&
> > > > +           !tp->repair) {
> > > >                 int tcp_header_len =3D tp->tcp_header_len;
> > > >                 s32 delta =3D 0;
> > > >                 int flag =3D 0;
> > > > @@ -6632,6 +6634,11 @@ void tcp_rcv_established(struct sock *sk, st=
ruct sk_buff *skb)
> > > >                 goto discard;
> > > >         }
> > > >
> > > > +       if (tp->repair) {
> > > > +               reason =3D SKB_DROP_REASON_SOCKET_REPAIR;
> > > > +               goto discard;
> > > > +       }
> > > > +
> > > >         /*
> > > >          *      Standard slow path.
> > > >          */
> > > > @@ -7125,6 +7132,11 @@ tcp_rcv_state_process(struct sock *sk, struc=
t sk_buff *skb)
> > > >         int queued =3D 0;
> > > >         SKB_DR(reason);
> > > >
> > > > +       if (tp->repair) {
> > > > +               SKB_DR_SET(reason, SOCKET_REPAIR);
> > > > +               goto discard;
> > > > +       }
> > > > +
> > > >         switch (sk->sk_state) {
> > > >         case TCP_CLOSE:
> > > >                 SKB_DR_SET(reason, TCP_CLOSE);
> > > > --
> > > > 2.43.0 =20
> >
> > --
> > Stefano

--=20
Stefano


