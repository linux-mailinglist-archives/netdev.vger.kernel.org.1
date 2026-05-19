Return-Path: <netdev+bounces-289520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDr5A3+MDGr0iwUAu9opvQ
	(envelope-from <netdev+bounces-289520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:14:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3AD582143
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AFFD3025CF8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D0369D40;
	Tue, 19 May 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agIcb/qY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKylge7r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633AE3AFD1D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207126; cv=none; b=A6Mfb7HH3Mq3UuMttfim/6W7EWq0SKqnpeZsEtafh48jetv1rzTydxVxvo1TzEcH5yNLfRwZkqHq94GNBinlSkzTqNGKvWgld9MlmhhcSoTaFuQXpOR25nKIbH54NLaSdffRfwohOZHpozbripKUAMSViR+DyJbXPBr3DjBt6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207126; c=relaxed/simple;
	bh=SwzAi8yu+S27YTGxUjbg4ldoUdfcQI/sTtyl9yh74QM=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=VcFfdbC3zkUTXI2BaT66JtaD9MOR/GP/i5Lq3t1Tp+HNKSrzahNjmOWc6bSTiU8acbZWF3gEEZm+MYJCQvu/YHhAGSb4zTE3QOIaUWkLXvtVRSp2tXNc975NfF/b1Pb4O6+PbOSxsGCtk2bO+3SseG4FzHDz8AVwCsuaEeFbqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agIcb/qY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKylge7r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779207124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gnLrrn+7nX3fa4iayPCgEsGwtcjXldmlIY1Tbv8prs=;
	b=agIcb/qYt5dcvR8AMJjhXN77Oj5fximGV9Pwd5bpJu60TqQgA9zco4kdgfczIN77antmNx
	TrrF2O8XlZHm38rAec3pnVbncRkWzbukr6y02pEBPNVUdXv64AeMFJ98gOaAp4j0KoJG7X
	7/Ms4mBi0lJVRy+bzgPozAW9BoopMhA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-vCXiTtXUMT2wW8unKoFicg-1; Tue, 19 May 2026 12:12:01 -0400
X-MC-Unique: vCXiTtXUMT2wW8unKoFicg-1
X-Mimecast-MFC-AGG-ID: vCXiTtXUMT2wW8unKoFicg_1779207120
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso3297905f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779207120; x=1779811920; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gnLrrn+7nX3fa4iayPCgEsGwtcjXldmlIY1Tbv8prs=;
        b=JKylge7rFHoQ3gkFotnEjqSETpuDTcpRY7i9Ot+2m29Nhc8y02LaHgBGKLrXVersh6
         t15jJvGYgi/GA1+dh3ZpwAa58sKAOGIH668BccSIefMnjakZ3N3V2nOQKr3+CG2r5Awh
         PNvRdrOcMyd1CiFjp/CfNQivjSZEYgtmyRFbsh/8tuN+kyxJCavF5cJWrXwFwUj/iDZG
         S0+IPgzOj0IuuHyU+SIOdX4F2SqmtAZo02gzRqxWjX1pmko8645hYHBYT6HdCYt2iMBT
         lMm98zewE99TlhTBEFizBQwrdpRhTgwTUOx8khHlnwyrbzqCdZQOMNc+JiLRGceEu4jn
         XWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207120; x=1779811920;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gnLrrn+7nX3fa4iayPCgEsGwtcjXldmlIY1Tbv8prs=;
        b=k6KZrxAAUz4PFU5qh5DNdClhxsEEYA1aIHz80SljsDtuadT7nA9QNvbjMreQ3BJkZ9
         ByTGcNfEhGOyJOzFkh5hI//N79+A3hpGT9b91cFSylBNbjFZHDahq8eyIx/1fpHQnsaA
         bBxhGVyh8FTkNS6IYnMpXz3gctrbYGO+UVp422zA7BYVs76CyTFjF582u0ae//fPP2ZK
         j6ZaxtcMfIX3zGhjCt6xvK1GYqrPyFaE86uRlc7IPu/z40mg45zPhcs/GBk1rlXJ7rGD
         d6Upvrc2NV19jeIUXM5Hlno5l/ynLsQO42ooWksqdZfs05/OvsdDrE+KwojZ3fWE2qrS
         +MuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4NTrWJp71+4UEiciSpQS7HJ5mFk8BtrxgEMBVYvbmEAEf5bPmL2+k3PB3xcNPs7v65yCRKM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxpKj57URpCQTisASDmQd2nZbHXX/HE2JhriqAD6u8hgi5J0d
	nTDJa5ziPtZ52UArmRQKX6zuRF0WTHabVB9aC/3ke9DWQktMl8JkMIIWYz0X3gEp/vpUFJmdx7o
	OJnNElLofjdH5SoZfQt5SlDJGrrFvxjWs2jKP9c1gNV837Pl1IPgWxe9H6w==
X-Gm-Gg: Acq92OGySGRPtmPNsfVlZsWLMlmUICK8BO/SZQT80pluRSXEANbRoUKCjQH8OhVAc/h
	CZLRfxIyCEmj8Zi+C2ufKnfqcPOpn2ChltQKyEL1eE9TTyjgDBuFVM+zR2MgXMHvb7HPBwCZO5x
	c+b1RaxdmOlklqKlgrp4vyBGBVcVxD3FRw0zcb1IaS1g8l2RUu499E5103X9jnPvWsAONPQIZMH
	pfyv28Vmt0T4YuP9nznoC/mH7VrkiJQt0l3YTL+dgaxXKJaAYFLwP4bKNqiOXysljPVtyoEkpQV
	LAK5/rRvHLfVEb2J4vONUtkYpA7B9RCJI1uxYns+eLqyGMGmfVgFg/ARHDlPB4jKcOG6m5HII55
	Nwg0Xq5jVQOuPYKkFJsiScUb6bAG6xN1/
X-Received: by 2002:a05:600c:46d0:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48fe4dad784mr281584935e9.5.1779207119759;
        Tue, 19 May 2026 09:11:59 -0700 (PDT)
X-Received: by 2002:a05:600c:46d0:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48fe4dad784mr281584365e9.5.1779207119186;
        Tue, 19 May 2026 09:11:59 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff43f213esm160227335e9.1.2026.05.19.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:11:58 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pavel
 Emelyanov <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, Jon
 Maloy <jmaloy@redhat.com>, Dmitry Safonov <dima@arista.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair
 mode
Message-ID: <20260519181157.1b0605f8@elisabeth>
In-Reply-To: <CAEWA0a5AG6JmeybHcxU+EL_Ohi0uVnSaVCiz7Bp_oDVuEdtO=g@mail.gmail.com>
References: <20260517184158.2757505-1-sbrivio@redhat.com>
	<20260517184158.2757505-2-sbrivio@redhat.com>
	<CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com>
	<20260517215307.13cda56a@elisabeth>
	<CANn89iKLfBmh3_t4xJz3dDJ8VkMsEtHRifg0mRV1PPAryNY1-g@mail.gmail.com>
	<20260518132831.5b9eb0a8@elisabeth>
	<CAEWA0a5AG6JmeybHcxU+EL_Ohi0uVnSaVCiz7Bp_oDVuEdtO=g@mail.gmail.com>
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
Date: Tue, 19 May 2026 18:11:58 +0200 (CEST)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289520-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F3AD582143
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 08:36:27 -0700
Andrei Vagin <avagin@google.com> wrote:

> On Mon, May 18, 2026 at 4:34=E2=80=AFAM Stefano Brivio <sbrivio@redhat.co=
m> wrote:
> >
> > On Mon, 18 May 2026 00:57:16 -0700
> > Eric Dumazet <edumazet@google.com> wrote:
> > =20
> > > On Sun, May 17, 2026 at 12:53=E2=80=AFPM Stefano Brivio <sbrivio@redh=
at.com> wrote: =20
> > > >
> > > > On Sun, 17 May 2026 12:05:45 -0700
> > > > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > > > =20
> > > > > On Sun, May 17, 2026 at 11:41=E2=80=AFAM Stefano Brivio <sbrivio@=
redhat.com> wrote: =20
> > > > > >
> > > > > > Once a socket enters repair mode (TCP_REPAIR socket option with
> > > > > > TCP_REPAIR_ON value), it's possible to dump the receive sequence
> > > > > > number (TCP_QUEUE_SEQ) and the contents of the receive queue it=
self
> > > > > > (using TCP_REPAIR_QUEUE to select it).
> > > > > >
> > > > > > If we receive data after the application fetched the sequence n=
umber
> > > > > > or saved the contents of the queue, though, the application wil=
l now
> > > > > > have outdated information, which defeats the whole functionalit=
y,
> > > > > > because this leads to gaps in sequence and data once they're re=
stored
> > > > > > by the target instance of the application, resulting in a hangi=
ng or
> > > > > > otherwise non-functional TCP connection.
> > > > > >
> > > > > > This type of race condition was discovered in the KubeVirt inte=
gration
> > > > > > of passt(1), using a remote iperf3 client connected to an iperf3
> > > > > > server running in the guest which is being migrated. The setup =
allows
> > > > > > traffic to reach the origin node hosting the guest during the
> > > > > > migration.
> > > > > >
> > > > > > If passt dumps sequence number and contents of the queue *befor=
e*
> > > > > > further data is received and acknowledged to the peer by the ke=
rnel,
> > > > > > once the TCP data connection is migrated to the target node, the
> > > > > > remote client becomes unable to continue sending, because a por=
tion
> > > > > > of the data it sent *and received an acknowledgement for* is no=
w lost.
> > > > > >
> > > > > > Schematically:
> > > > > >
> > > > > > 1. client --seq 1:100--> origin host --> passt --> guest --> se=
rver
> > > > > >
> > > > > > 2. client <--ACK: 100-- origin host
> > > > > >
> > > > > > 3. migration starts, =20
> > > > >
> > > > > Here, a netfilter rule or bpf prog must be installed to
> > > > > drop packets temporarily until migration completes. =20
> > > >
> > > > Thanks for the review.
> > > >
> > > > I have to say it's rather unexpected to have to work around obvious
> > > > kernel issues in userspace: TCP_REPAIR implies that queues are froz=
en,
> > > > and this is handled correctly on the sending side (see
> > > > tcp_write_xmit()), but was clearly forgotten on the receiving side.=
 =20
> > >
> > > Have you contacted TCP repair authors for best practices? =20
> >
> > I Cc'ed them here, Pavel is the author (but as far as I understand not
> > active in kernel development anymore), and I know that Andrei did some
> > substantial work on it in the past, so he's Cc'ed here as well.
> >
> > But we are following what CRIU (the userspace reference implementation)
> > does, and CRIU would be affected by this issue as well (depending on
> > usage). =20
>=20
> Before extracting the socket state, CRIU uses netfilter (iptables or
> nftables) to block all traffic associated with the specific TCP
> connection or, in the case of a container, the entire network namespace.

...by default, yes, by "depending on usage" I actually meant
'--network-lock skip', but I have to admit I'm not sure how commonly
that is used.

> This approach provides two main benefits:
>=20
> During the dump, we don't need to leave all sockets in repair mode for
> the entire duration of the dump.  We enable and disable repair mode just
> to grab the state. It's simplify a roll back if something goes wrong.

Thanks for clarifying this aspect, I wasn't sure whether it was done to
make rollback easier.

That wouldn't really simplify things with passt in case of rollback
because, as we anyway keep track of flows internally (we implement
them, after all), we want to keep those sockets (frozen) in repair mode
until we're able to process traffic again (something CRIU doesn't need
to do), and explicitly take them out of repair mode at a rather precise
point in time.

> During restoration, it ensures that the destination kernel will not
> process any packets until the socket is fully reconstructed. This
> prevents the kernel from sending a Reset (RST) or getting out of sync
> before the connection is ready to be resumed.

Right, we don't have that issue in passt (anymore) because we keep
sockets open on the origin node anyway, and we block migration until
we're done restoring connection sockets and listening sockets on the
target.

> I haven't looked at the patch yet, but I have no objections to the idea
> itself.

Thanks for the explanation and for having a look! For passt (and
KubeVirt) that would save a lot of complexity, plus the security
aspects myself and David raised.

And, besides that and the usage CRIU and passt make of it, I still think
that allowing data to be queued while somebody can dump the queue is a
fundamental race condition.

--=20
Stefano


