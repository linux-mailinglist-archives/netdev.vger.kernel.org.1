Return-Path: <netdev+bounces-288773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OThMrQcCmqmwwQAu9opvQ
	(envelope-from <netdev+bounces-288773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:53:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0D6563A03
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 21:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 398933002D01
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E442FE579;
	Sun, 17 May 2026 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClrE41+4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jdjbUST2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805C2C11FD
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779047596; cv=none; b=N6rMxz3D7ufzJGivqvRpwCPy1aQUkEZOlSxevkGwBd4CzncG4y3zOa1Sk56gUymdZCYnFBvuravAlCMHW9KbZb4TXndPyROxAbWVrNZ0aukLRnOyr29EDesiTpN8GvlWIF7H47nLN/Su/tVmYvcqw3k2C2/JOkmLy8ay3VDLhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779047596; c=relaxed/simple;
	bh=o79HrYpnFhY0JNjZOrPRLcLU2XHz+6PY9guDcXQdQAM=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=LjxHhTZxDER4AUz831tlNSpai4EurIn+/3vwea3SaXVRk1Zocb0KmMJ04+gPif2l8UOsqvbGMSTXBzwGFdWOveVqbUb0n75MVAtp/EFa5aVtYplG3AZmLsetMaUrmTVrJp/HQ8+YTyvMr7ccF6isgGC6DhyYjFNjiDONAgqCdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClrE41+4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jdjbUST2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779047592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+Pdesl1uDFlUNzcJh/hQORFgUfIQ6nCDDoTWdOXOow=;
	b=ClrE41+4x6wudvOxx6gYJWPeIh7qWJ9jhuLJw+DsrzzSIztvIZH+D1IB0Gwe0O1FQOse9w
	1lEPSiBrwrDe7EGUzFHEEa62z7fmPSsi+2o/+qfH0EADUUkhcoaTN5BAXz1IVF9nk13NkT
	QavvKWf+HYa4mWhNr1rNK/4g34h+3v8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-aYinwJdbNK-0NnkpLYeAJg-1; Sun, 17 May 2026 15:53:11 -0400
X-MC-Unique: aYinwJdbNK-0NnkpLYeAJg-1
X-Mimecast-MFC-AGG-ID: aYinwJdbNK-0NnkpLYeAJg_1779047590
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44b186b715aso875175f8f.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779047590; x=1779652390; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Pdesl1uDFlUNzcJh/hQORFgUfIQ6nCDDoTWdOXOow=;
        b=jdjbUST2RXEI/9XI/hT1XUDk5NimP94laT0OiVjVlQPq0ETOXh1/iC1XwVcPAJ95Ze
         EDn7p/MqO/dWjEMgm40BiHo3xng7fDk4A42ln0YF0SMv11vMEPPvvIT4YWaf/qFwsaNN
         wGdbQtGcU4j7kNLdZLfcjkTE2PKiJYvxc9dAxsDfOOk3k6Yaw2hYTOUme9odbDKNPLhu
         Obq0ywNlSQz4dlnmuO7VjmopS9IZ6m2IF2Qz735loFbYtivK6fitHuHDcmpgZ9H44BtA
         /yQhuHn3NBqBYbQ2xj6xgoFAPePvpEmV2yjt2VSqYlBffllJ3ijyj2RPLhhhQBCGoHlf
         vcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779047590; x=1779652390;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Pdesl1uDFlUNzcJh/hQORFgUfIQ6nCDDoTWdOXOow=;
        b=NdRVfu8kcFDoxaWjac28iOEDRzP3BEAmHae0F//Gp1CbOU8nNW2XrHPMtmvdb732WX
         M+3lvqk28D0cqgdCNvaX/Ghexf7lLkfunliQWExO9BJrBgeor10j6T6rRZf/EASsMu85
         swCpn4aE1RaGh9EFuQmNrl4sSO/2GvnviCt0YowkM/ybmH8d8IYp1aqhOMqzybK7h7lA
         gW0BW6jL2Akhr7FC2mEbZJQrYj9m4UXMOMsZjXpbAVasp2TOrneE5tVPIbn9vIfMrDmG
         baFe06qXvUZjySOdaVKtO6IGFomgmMMbAEBMfQTE7UtMFcWmNre6CpWwnDGdSrJQGzFG
         RllQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pxZTgqXaXoQN97EAgY94GTN1VSvv/QVqXaT/V0HpuD8p2dPckTp/fUmobSz6sOyrvqbkXy1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkG+IZ2H6DHz2Pg++3Eq/oxHQC9YuTNhsvVtkd1StqJEeQf7Te
	U6YiQ+JkVWOETlz1JEygvu5LusTB0fCcQW/QSilbXDjp+/kmSkYaF6XfFzvuFlNKUriI01B676z
	pSfosf/PEiFT+3Eof7+UILxfip5QNK8SrwZtmgLmdN7gby5p3DvFwDHoSTQ==
X-Gm-Gg: Acq92OEBVZ8V7ZmAKGnQOYkGFL8CZmhEPNDXduNtNJ/jPfIIzH5DHc//2nD+w3vKgrG
	B9PBu7+Pj8A4LBdTJjyO5wWjhIPR+2/oHT6v6j8JR+LOoSQr1XcMmdAScG+WaXO3Lq65gz8g3Wa
	5V1HGSSPLent3uaY0CNXiY+Igte3SK3mq8nHnoD64p/epi6AH9NYUDub7syKkNGRTnQrGGwCnuZ
	KWVsYRnjWYmVskcBFDAmSVt71IusFmGIXA0ITZXa3TXP6eXADT0DtDCH1VCKfi1kp0JhlolBtQ0
	ZCKHp0MLlJZ8/iss6z2M5DURtmMHTxzD2Tg9taORN2IXwy/Z6sSV0sLk1VYOtiOw0259kTIjdRE
	yqIh3d1VHvvZGymz4muL/a+Wx2bugz14reEDhQTxkhXU=
X-Received: by 2002:a05:6000:1ace:b0:441:1cf9:4f06 with SMTP id ffacd0b85a97d-45e5c595648mr18594594f8f.31.1779047589894;
        Sun, 17 May 2026 12:53:09 -0700 (PDT)
X-Received: by 2002:a05:6000:1ace:b0:441:1cf9:4f06 with SMTP id ffacd0b85a97d-45e5c595648mr18594569f8f.31.1779047589349;
        Sun, 17 May 2026 12:53:09 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm31329173f8f.5.2026.05.17.12.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:53:08 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Pavel Emelyanov <xemul@scylladb.com>, Laurent Vivier
 <lvivier@redhat.com>, Jon Maloy <jmaloy@redhat.com>, Dmitry Safonov
 <dima@arista.com>, Andrei Vagin <avagin@google.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair
 mode
Message-ID: <20260517215307.13cda56a@elisabeth>
In-Reply-To: <CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com>
References: <20260517184158.2757505-1-sbrivio@redhat.com>
	<20260517184158.2757505-2-sbrivio@redhat.com>
	<CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com>
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
Date: Sun, 17 May 2026 21:53:08 +0200 (CEST)
X-Rspamd-Queue-Id: BE0D6563A03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288773-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,passt.top:url]
X-Rspamd-Action: no action

On Sun, 17 May 2026 12:05:45 -0700
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> On Sun, May 17, 2026 at 11:41=E2=80=AFAM Stefano Brivio <sbrivio@redhat.c=
om> wrote:
> >
> > Once a socket enters repair mode (TCP_REPAIR socket option with
> > TCP_REPAIR_ON value), it's possible to dump the receive sequence
> > number (TCP_QUEUE_SEQ) and the contents of the receive queue itself
> > (using TCP_REPAIR_QUEUE to select it).
> >
> > If we receive data after the application fetched the sequence number
> > or saved the contents of the queue, though, the application will now
> > have outdated information, which defeats the whole functionality,
> > because this leads to gaps in sequence and data once they're restored
> > by the target instance of the application, resulting in a hanging or
> > otherwise non-functional TCP connection.
> >
> > This type of race condition was discovered in the KubeVirt integration
> > of passt(1), using a remote iperf3 client connected to an iperf3
> > server running in the guest which is being migrated. The setup allows
> > traffic to reach the origin node hosting the guest during the
> > migration.
> >
> > If passt dumps sequence number and contents of the queue *before*
> > further data is received and acknowledged to the peer by the kernel,
> > once the TCP data connection is migrated to the target node, the
> > remote client becomes unable to continue sending, because a portion
> > of the data it sent *and received an acknowledgement for* is now lost.
> >
> > Schematically:
> >
> > 1. client --seq 1:100--> origin host --> passt --> guest --> server
> >
> > 2. client <--ACK: 100-- origin host
> >
> > 3. migration starts, =20
>=20
> Here, a netfilter rule or bpf prog must be installed to
> drop packets temporarily until migration completes.

Thanks for the review.

I have to say it's rather unexpected to have to work around obvious
kernel issues in userspace: TCP_REPAIR implies that queues are frozen,
and this is handled correctly on the sending side (see
tcp_write_xmit()), but was clearly forgotten on the receiving side.

TCP_REPAIR also allows to dump queues, not just sequence numbers, so
this really is a bad race condition making the whole functionality
unreliable.

But anyway, even looking for a practical workaround of the kind you
suggested, I see two issues with it:

1. we would still have a race condition, because userspace doesn't have
   a way to synchronise application of nftables rules (or even a BPF
   program) with the effects of TCP_REPAIR. We could apply nftables
   rules "a while before" just to be sure, but this is severely going to
   impact migration downtime

2. passt(1) runs unprivileged and uses a very simple helper to set
   TCP_REPAIR on the socket. Expanding helpers of this kind to directly
   manipulate nftables rules, or installing BPF programs, looks like a
   substantial security drawback

> We do not want unlikely tests in the fast path.

I understand, but note that this doesn't really add a branch to the
fast path: there's already a list of (more expensive) conditions under
which we need to fall back to slow path, with 'tp' definitely
prefetched at that point, so I don't expect any fast path cost from
doing this. Everything else is handled in the slow path.

To be sure, I also checked throughput with delivery to local sockets as
that's the only case affected (veth setup similar to the one from the
selftests from patch 2/2) and there's no visible difference.

> You can find a similar issue:
> https://lore.kernel.org/netdev/20260130145122.368748-1-me@linux.beauty/

That one is not a kernel issue: in that case, the socket is closed, so
it's actually expected that the kernel will reset the connection. As
Jakub pointed out, that patch introduces a race condition on its own,
and it's a hack rather than a fix.

We happened to have that kind of issue in passt as well (the
implementation is inspired by CRIU), but that's something entirely
different which userspace clearly needs to take care of, so we fixed it
here:

  https://passt.top/passt/commit/?id=3Da8782865c342eb2682cca292d5bf92b56734=
4351

> > passt enables repair mode, dumps the sequence
> >    number (101) and sends it to the target node of the guest migration
> >
> > 4. client --seq 101:201--> origin host (passt not receiving anymore)
> >
> > 5. client <--ACK: 201-- origin host
> >
> > 6. migration completes, and passt restores sequence number 101 on the
> >    migrated socket
> >
> > 7. client --seq 201:301--> target host (now seeing a sequence jump)
> >
> > 8. client <--ACK: 100-- target host
> >
> > ...and the connection can't recover anymore, because the client can't
> > resend data that was already (erroneously) acknowledged. We need to
> > avoid step 5. above.
> >
> > This would equally affect CRIU (the other known user of TCP_REPAIR),
> > should data be received while the original container is frozen: the
> > sequence dumped and the contents of the saved incoming queue would
> > then depend on the timing.
> >
> > The race condition is also illustrated in the kselftests introduced
> > by the next patch.
> >
> > To prevent this issue, discard data received for a socket in repair
> > mode, with a new reason, SKB_DROP_REASON_SOCKET_REPAIR.
> >
> > Fixes: ee9952831cfd ("tcp: Initial repair mode")
> > Tested-by: Laurent Vivier <lvivier@redhat.com>
> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > ---
> >  include/net/dropreason-core.h |  3 +++
> >  net/ipv4/tcp_input.c          | 14 +++++++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 2f312d1f67d6..19ab9e6ffc33 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -9,6 +9,7 @@
> >         FN(SOCKET_CLOSE)                \
> >         FN(SOCKET_FILTER)               \
> >         FN(SOCKET_RCVBUFF)              \
> > +       FN(SOCKET_REPAIR)               \
> >         FN(UNIX_DISCONNECT)             \
> >         FN(UNIX_SKIP_OOB)               \
> >         FN(PKT_TOO_SMALL)               \
> > @@ -158,6 +159,8 @@ enum skb_drop_reason {
> >         SKB_DROP_REASON_SOCKET_FILTER,
> >         /** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is ful=
l */
> >         SKB_DROP_REASON_SOCKET_RCVBUFF,
> > +       /** @SKB_DROP_REASON_SOCKET_REPAIR: socket is in repair mode */
> > +       SKB_DROP_REASON_SOCKET_REPAIR,
> >         /**
> >          * @SKB_DROP_REASON_UNIX_DISCONNECT: recv queue is purged when =
SOCK_DGRAM
> >          * or SOCK_SEQPACKET socket re-connect()s to another socket or =
notices
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index d5c9e65d9760..6eca34274f97 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6457,6 +6457,7 @@ static bool tcp_validate_incoming(struct sock *sk=
, struct sk_buff *skb,
> >   *       or pure receivers (this means either the sequence number or t=
he ack
> >   *       value must stay constant)
> >   *     - Unexpected TCP option.
> > + *     - Socket is in repair mode.
> >   *
> >   *     When these conditions are not satisfied it drops into a standard
> >   *     receive procedure patterned after RFC793 to handle all cases.
> > @@ -6506,7 +6507,8 @@ void tcp_rcv_established(struct sock *sk, struct =
sk_buff *skb)
> >
> >         if ((tcp_flag_word(th) & TCP_HP_BITS) =3D=3D tp->pred_flags &&
> >             TCP_SKB_CB(skb)->seq =3D=3D tp->rcv_nxt &&
> > -           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
> > +           !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt) &&
> > +           !tp->repair) {
> >                 int tcp_header_len =3D tp->tcp_header_len;
> >                 s32 delta =3D 0;
> >                 int flag =3D 0;
> > @@ -6632,6 +6634,11 @@ void tcp_rcv_established(struct sock *sk, struct=
 sk_buff *skb)
> >                 goto discard;
> >         }
> >
> > +       if (tp->repair) {
> > +               reason =3D SKB_DROP_REASON_SOCKET_REPAIR;
> > +               goto discard;
> > +       }
> > +
> >         /*
> >          *      Standard slow path.
> >          */
> > @@ -7125,6 +7132,11 @@ tcp_rcv_state_process(struct sock *sk, struct sk=
_buff *skb)
> >         int queued =3D 0;
> >         SKB_DR(reason);
> >
> > +       if (tp->repair) {
> > +               SKB_DR_SET(reason, SOCKET_REPAIR);
> > +               goto discard;
> > +       }
> > +
> >         switch (sk->sk_state) {
> >         case TCP_CLOSE:
> >                 SKB_DR_SET(reason, TCP_CLOSE);
> > --
> > 2.43.0

--=20
Stefano


