Return-Path: <netdev+bounces-51872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50BB7FC955
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A204B2126D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707C481DD;
	Tue, 28 Nov 2023 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvBJ66U9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7E10D1
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701209926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPXdC7uEU7BTQsBkZAuD+zGSVtZvZtNxBLgsui0o3mI=;
	b=RvBJ66U9bMEEh//jxQr7UrrqI4jmPmNfo7rRqrStQU4jOl2gCNyi8sMXuuwTi6zzqj5FC6
	Dm1LXS92tzmE3NrJReeqbbjpB3BWP8KkjZzxkEA2S9xN17TA6b0lvXFy4NuMKv8KlBs1pI
	AeLz/OZ7q8auTEp6cug+zNjE1Ogc5bE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-gMNHuqS2MLSwuoOYADx7-A-1; Tue, 28 Nov 2023 17:18:44 -0500
X-MC-Unique: gMNHuqS2MLSwuoOYADx7-A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33303db14d9so1743640f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701209923; x=1701814723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPXdC7uEU7BTQsBkZAuD+zGSVtZvZtNxBLgsui0o3mI=;
        b=tYSFy3jdYjAhsUOkTTTB2hcd6mL2hu1Y2UH+z2vCLlZTKjiuZ8KT/9q3urdB2O56Mk
         HL0funnMOnzSx1TQikUnr9kVTPV4g5Y9XDzPThr0QJ+dGsm8LT1FXJ8eWBzTuMnTSr1c
         XmQqMAkWOJtrvpTgZvRVRt7to3hRQmuNr9FTnroaqLI3PnUnXIwokgE3iU7DgFc9DbzA
         GV3Xj6uZ17u8sazA1IJUKPE4UorhgzDvGsptW562pXL3tK4oCeCZGGpjLrkKUs67WQWe
         e7IgPTtKL5g8KappJjrKuK96uKpPbtd4YP/87BmDRNArwlB/pUmw7tNU4fTle0/BgQKO
         41Fw==
X-Gm-Message-State: AOJu0YwQ2/315eYirAREymi/00SiPxTh0Gr2K1IsrvWc1j1gziCLsLx6
	+luAQztmYZUmqU2zzklylBWryUC/t82SB038Wq8F/SNEHZjNyXsCx1ZTc5q2r2Vubf5dq3PirTZ
	WcPRAONv/jmd6hcf6qcxjvi7C
X-Received: by 2002:adf:f88c:0:b0:319:7c0f:d920 with SMTP id u12-20020adff88c000000b003197c0fd920mr11097938wrp.57.1701209923120;
        Tue, 28 Nov 2023 14:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe3z06KmNuYZ51qF5G1P9LwZ8NUiMV6vaSdE7r2CSq9mKuqQ4FTXG8F8R6seaSC0QTXAmUAg==
X-Received: by 2002:adf:f88c:0:b0:319:7c0f:d920 with SMTP id u12-20020adff88c000000b003197c0fd920mr11097935wrp.57.1701209922818;
        Tue, 28 Nov 2023 14:18:42 -0800 (PST)
Received: from debian (2a01cb058d23d60028ed52b1e62ad61d.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:28ed:52b1:e62a:d61d])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d4bcc000000b00332fbc183ebsm8594227wrt.76.2023.11.28.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:18:42 -0800 (PST)
Date: Tue, 28 Nov 2023 23:18:40 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZWZnQL1tnjJ9R8Er@debian>
References: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
 <CANn89i+sqG+T7LNxXhB-KHM-c7DU2v__vEbiV1_DJV7tkuEaGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+sqG+T7LNxXhB-KHM-c7DU2v__vEbiV1_DJV7tkuEaGg@mail.gmail.com>

On Tue, Nov 28, 2023 at 11:14:28AM +0100, Eric Dumazet wrote:
> On Fri, Nov 24, 2023 at 12:11 AM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> > that are bound but haven't yet called connect() or listen().
> >
> > This allows ss to dump bound-only TCP sockets, together with listening
> > sockets (as there's no specific state for bound-only sockets). This is
> > similar to the UDP behaviour for which bound-only sockets are already
> > dumped by ss -lu.
> >
> > The code is inspired by the ->lhash2 loop. However there's no manual
> > test of the source port, since this kind of filtering is already
> > handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> > at a time, to avoid running with bh disabled for too long.
> >
> > No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
> > socket, bound respectively to 40000, 64000, 60000, the result is:
> >
> >   $ ss -lt
> >   State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
> >   UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
> >   UNCONN 0      0               [::]:60000         [::]:*
> >   UNCONN 0      0                  *:64000            *:*
> 
> 
> Hmm...   "ss -l" is supposed to only list listening sockets.
> 
> So this change might confuse some users ?
> 

On the other hand I can't find a more sensible solution. The problem is
that "ss -l" sets both the TCPF_LISTEN and the TCPF_CLOSE flags. And
since we don't have a way to express "bound but not yet listening"
sockets, these sockets fall into the CLOSE category. So we're really
just returning what ss asked for.

If we can't rely on TCPF_CLOSE, then I don't see what kind of filter we
could use to request a dump of these TCP sockets. Using "-a" doesn't
help as it just sets all the TCPF_* flags (appart from
TCPF_NEW_SYN_RECV). Adding a new option wouldn't help either as we
couldn't map it to any of the TCPF_* flags. In any case, we still need
to rely on TCPF_CLOSE.

So maybe we can just improve the ss man page for "-l" and explain that
it also lists closed sockets, which includes the bound-only ones
(this is already true for non-TCP sockets anyway). We could also tell
the user to run "ss state listening" for getting listening sockets
exclusively (or we could implement a new option, like "-L", to make
that shorter if necessary).

What do you think?


