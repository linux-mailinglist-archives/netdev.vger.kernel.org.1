Return-Path: <netdev+bounces-37495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF2E7B5AA0
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4B2B1B20C51
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2571F17E;
	Mon,  2 Oct 2023 18:59:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF11DA28
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 18:59:25 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C468EA
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:59:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d84f18e908aso93045276.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696273162; x=1696877962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dblyvw157+4QXxx4Gx4OQP1HlWyJULPim5OEmQHOZSQ=;
        b=mtM1jLwl9m+Tr+MMddwNSR+bOzWfGN2QX320rgEv5mojh3gssbuCpQnDR5TbYQbZif
         IGDDEMHehhSs+o+4rcOgTTGJ/dL9vUQxeqaWSG8w+3aaIg6JSGhtocAfnWULh7BzzlXZ
         FNm+JtdtLroD2ZpTCpEOHH21PJV2QiB9g/sxsjDi6mm6nHQ8XbOGamC1zufCo5pGyCrC
         C2U2dmS2Q0OGN1QjvUvng0E0VGbAAiBOgEFYrPRVIcNM0SyZoAfwtSMReHefgeJjX+Kb
         uAILc48gOU+AYSUqFDBOKILb0BprrkQH7ZXHSYivYifj8dBF629ge/bEkb7m/8/p50e7
         y27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273162; x=1696877962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dblyvw157+4QXxx4Gx4OQP1HlWyJULPim5OEmQHOZSQ=;
        b=JL6b9jn0bwFMEBu7u6VCgAjCdvF/zm/8odJ9bF51jSpbJmjdYprAw2zxvXnLosDBmb
         XmAE5iIhsw1op/cWrONHa1nF2dKqlvU7cn6iuKKeCkwpShLZiLMBVCXZPHst7DBm/bbV
         1HAgBdJOTmn2/ojIQ//bWomdBuuAOvgdGuvwxYI3FXorNN9JXIAvRAuvq07Q1yfMHCUH
         yZzJRzCtxe5bF5vqoen9t4yxUjt35Lf569MeOmMK74Sr6haDF6aRuk/FFtUH8avLYth+
         ImoBhvr1J0mSXX5nXwKF2wlUh7k55qAWBsfBhsZlOn2lKIERjzs2v3j8GBrPvjZ6FfX9
         rGIw==
X-Gm-Message-State: AOJu0Yw7OAZVHslSl+mTraxwHDwzLMERt7rQ2n41cFfJzXNQsCHHU+An
	hqA5OrkHQcv9CDTU7Y9KmFToTwmTN/zQEf7sY7Q=
X-Google-Smtp-Source: AGHT+IHjlKeeTKMnj34VtwFwKmSw9RTVshDK7x3XCWkjewdNUQK6JoZNW6N8F0tDmu8ZGY7VdOLeg1NZx/RcfPzZGUY=
X-Received: by 2002:a25:a1a5:0:b0:d85:e03b:6ac4 with SMTP id
 a34-20020a25a1a5000000b00d85e03b6ac4mr10665761ybi.47.1696273162328; Mon, 02
 Oct 2023 11:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <881c23ac-d4f4-09a4-41c6-fb6ff4ec7dc5@kernel.org>
 <CANn89iKEs8_zdEXWbjxd8mC220MqhcRQp3AeHJMS6eD-a45rRA@mail.gmail.com>
 <CADvbK_fR62L+EwjW739MbCXJRFDfW5UTQ1bRrjMhc+cgyGN-dA@mail.gmail.com> <CANn89i+Ef7zNz7t6U2_6VEHPDantgyR8d0w3ALOBVVwK0Fe=FQ@mail.gmail.com>
In-Reply-To: <CANn89i+Ef7zNz7t6U2_6VEHPDantgyR8d0w3ALOBVVwK0Fe=FQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 2 Oct 2023 14:59:11 -0400
Message-ID: <CADvbK_epdT+s-peW9v1oKGrTfttrVFCgSLkdwLLBAT2N+ZDdMQ@mail.gmail.com>
Subject: Re: tcpdump and Big TCP
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 1:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Oct 2, 2023 at 7:19=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
> >
> > On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Oct 2, 2023 at 6:20=E2=80=AFPM David Ahern <dsahern@kernel.or=
g> wrote:
> > > >
> > > > Eric:
> > > >
> > > > Looking at the tcpdump source code, it has a GUESS_TSO define that =
can
> > > > be enabled to dump IPv4 packets with tot_len =3D 0:
> > > >
> > > >         if (len < hlen) {
> > > > #ifdef GUESS_TSO
> > > >             if (len) {
> > > >                 ND_PRINT("bad-len %u", len);
> > > >                 return;
> > > >             }
> > > >             else {
> > > >                 /* we guess that it is a TSO send */
> > > >                 len =3D length;
> > > >             }
> > > > #else
> > > >             ND_PRINT("bad-len %u", len);
> > > >             return;
> > > > #endif /* GUESS_TSO */
> > > >         }
> > > >
> > > >
> > > > The IPv6 version has a similar check but no compile change needed:
> > > >         /*
> > > >          * RFC 1883 says:
> > > >          *
> > > >          * The Payload Length field in the IPv6 header must be set =
to zero
> > > >          * in every packet that carries the Jumbo Payload option.  =
If a
> > > >          * packet is received with a valid Jumbo Payload option pre=
sent and
> > > >          * a non-zero IPv6 Payload Length field, an ICMP Parameter =
Problem
> > > >          * message, Code 0, should be sent to the packet's source, =
pointing
> > > >          * to the Option Type field of the Jumbo Payload option.
> > > >          *
> > > >          * Later versions of the IPv6 spec don't discuss the Jumbo =
Payload
> > > >          * option.
> > > >          *
> > > >          * If the payload length is 0, we temporarily just set the =
total
> > > >          * length to the remaining data in the packet (which, for E=
thernet,
> > > >          * could include frame padding, but if it's a Jumbo Payload=
 frame,
> > > >          * it shouldn't even be sendable over Ethernet, so we don't=
 worry
> > > >          * about that), so we can process the extension headers in =
order
> > > >          * to *find* a Jumbo Payload hop-by-hop option and, when we=
've
> > > >          * processed all the extension headers, check whether we fo=
und
> > > >          * a Jumbo Payload option, and fail if we haven't.
> > > >          */
> > > >         if (payload_len !=3D 0) {
> > > >                 len =3D payload_len + sizeof(struct ip6_hdr);
> > > >                 if (length < len)
> > > >                         ND_PRINT("truncated-ip6 - %u bytes missing!=
",
> > > >                                 len - length);
> > > >         } else
> > > >                 len =3D length + sizeof(struct ip6_hdr);
> > > >
> > > >
> > > > Maybe I am missing something, but it appears that no code change to
> > > > tcpdump is needed for Linux Big TCP packets other than enabling tha=
t
> > > > macro when building. I did that in a local build and the large pack=
ets
> > > > were dumped just fine.
> > > >
> > Right, wireshark/tshark currently has no problem parsing BIG TCP IPv4 p=
ackets.
> > I think it enables GUESS_TSO by default.
> >
> > We also enabled GUESS_TSO in tcpdump for RHEL-9 when BIG TCP IPv4 was
> > backported in it.
>
> Make sure to enable this in tcpdump source, so that other distros do
> not have to 'guess'.
Looks the tcpdump maintainer has posted one:

https://github.com/the-tcpdump-group/tcpdump/pull/1085

>
> >
> > >
> > > My point is that tcpdump should not guess, but look at TP_STATUS_GSO_=
TCP
> > > (and TP_STATUS_CSUM_VALID would also be nice)
> > >
> > > Otherwise, why add TP_STATUS_GSO_TCP in the first place ?
> > That's for more reliable parsing in the future.
>
> We want this. I thought this was obvious.
>
> >
> > As currently in libpcap, it doesn't save meta_data(like
> > TP_STATUS_CSUM_VALID/GSO_TCP)
> > to 'pcap' files, and it requires libpcap APIs change and uses the
> > 'pcap-ng' file format.
> > I think it will take quite some time to implement in userspace.
>
> Great. Until this is implemented as discussed last year, we will not remo=
ve
> IPv6 jumbo headers.
I will get back to this libpcap APIs and pcap-ng things, and let you
know when it's done.

Thanks.

