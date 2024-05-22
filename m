Return-Path: <netdev+bounces-97590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888D8CC33A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DBCB234B9
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE31411FE;
	Wed, 22 May 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SQSSP6QB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97A1411EB
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388068; cv=none; b=ZfonnhOr3gSHLvnblpW/XR8JB9zkxxbWqcUgPFVe+OdoGDyZmLQKJgWHr86XfJV5LP5dO12Q6Gw5r4tgO6B44NIYmA/3UIT49ApBz8p933Nou5cg4cMEaBssy4krLR6bZf0mtGlTsyx1O+fPEO7dpS7qIYBA10WljMknpK2nPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388068; c=relaxed/simple;
	bh=SbBPwv5GSuNadWkN/Ype/GvbpCPfCZDny7K84NYcp+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5E85KgDtWXvegIYGQ/NtjjUhNp+6DU74t64kRq4k7m9vYvrSf7Dh1vW40mm6Jeqi9kjmwOMVklqxb/DkohiPnWFM0SR1zAa3dCoFJeMv3Nw1P0xPr3z3oRRIa8co0L0bYYsykSAScXHwJggQywEVCiWvA8rKAw7l/UHGkFUskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SQSSP6QB; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 10546400F4
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716388062;
	bh=SbBPwv5GSuNadWkN/Ype/GvbpCPfCZDny7K84NYcp+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=SQSSP6QBCHza1n+PqCJT0sF2ABPUMZZPQ0P0Kx9Z/M3fVkGbb1q1BHW+Nl3QKz2P3
	 i1ehIlI4PLp8HYATlCJEJPlbaiw1msxnnI2SJZZjYYy7BWhHApXap78iCG3sCKUpU/
	 kGwoHWYyFezjeP6pBD68ythDXEcFYojFJSOA9LgJPA4Zdj/AN2DNOsu1iltEsKl9Rp
	 /qU4b5vHLkfIk7qdoRHWOhxjg6OyRYcdra4M7jYQrZ/CRor40S3Ih66ZdfsqboxinD
	 TDUkgf6JssyKuIH/cnXGFlcUFgleQEIOXZTWTHLtD40FWpFc/Ls8YRCOnAAvGBU/d1
	 troRJJXjuJD0w==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e1f38cb631so3187481fa.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 07:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716388061; x=1716992861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbBPwv5GSuNadWkN/Ype/GvbpCPfCZDny7K84NYcp+M=;
        b=KxE85zWoOVroIBwV7MJAMXmkUCYZe/9Vs0R39cdWzdl5ucE3JzwXvclDO1BIYZ5kbN
         pojeVl+v8Jd+uQ6c7cVxpEQ24W0dEiMd3pD7Z2BMbgvAE/5VMj6Xliyv1TVjkMZ3j0/t
         fRT95OZBxWYd6k3vxBCNw2lzidR0Ou8XGSKiNEy4b+ElcFnEI//kV2H5GIp/63mlRAys
         QiGlF/D6zaeEfVS7HOpTN/Ojugp6LRXpRMMnGZgZgfO/4NJge2kMFkdJVYGWIHY2a12P
         A9icXPDoGKHvT7/lgvxO9w+4sYIwHVxguSH4IzeCAEi397+vQLPpxk3LvU3lQp2Y0lyR
         AbiA==
X-Forwarded-Encrypted: i=1; AJvYcCXSqXPg2nGRbrvrCPCFLmvkDg/uQWX2IDGsIvAfH6D9xXHb/cH/PPQ8hEvy5E7+5V2/ahwHAyJA+EYIH2CjcQqy/BEsmG3C
X-Gm-Message-State: AOJu0YwCwd/wBd1jGiPHd6JMoQm5BVizEug0ymLUwjNqwmtS36fnIgJJ
	m4zfmBDNzWcUae3Sdc3jKzneSGA2z1lfySvhjcA+wp6xfSyKnYnUUxB9u2yY1NwtbrrEaaQ/kMH
	RH0sjZRKuhL32usSm6HijUz8KLI0n8htRwuZu05NipsoLek/b2GgA9k3L0QQtpndXTmKQLX3MHX
	KObH2rIIRJAz0Dgt4UO+8JVZ4cQepMt8Grbx378noSonat
X-Received: by 2002:a2e:2c16:0:b0:2e0:6313:fe3a with SMTP id 38308e7fff4ca-2e949540d05mr18142471fa.35.1716388061018;
        Wed, 22 May 2024 07:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOH5h3bTDQ9rTy1KoldO/wIaRpZJa7uBiJFnfVUbNB5/XrA1cSzm7wwuMdCdQtFrMjqDVyZknit/uZCxatc3U=
X-Received: by 2002:a2e:2c16:0:b0:2e0:6313:fe3a with SMTP id
 38308e7fff4ca-2e949540d05mr18142291fa.35.1716388060589; Wed, 22 May 2024
 07:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
 <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com> <664ca1651b66_14f7a8294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <664ca1651b66_14f7a8294cb@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Wed, 22 May 2024 22:27:28 +0800
Message-ID: <CAPza5qfZ8JPkt4Ez1My=gfpT7VfHo75N01fLQdFaojBv2whi8w@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a6bba006190bbcfa"

--000000000000a6bba006190bbcfa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for your useful suggestions and information.

Hi Willem,

The issue initially stems from libpcap [1].
Upon their further investigation, another issue was discovered,
leading to a kernel request [2] that describes the problem in detail.

In essence, the kernel does not provide VLAN information if hardware
VLAN offloading is unavailable in cooked mode.
The TCI-TPID is missing because the prb_fill_vlan_info() function in
af_packet.c does not modify the tp_vlan_tci/tp_vlan_tpid values since
the information is in the payload and not in the sk_buff struct.
In cooked mode, the L2 header is stripped, preventing the receiver
from determining the correct TCI-TPID value.
Additionally, the protocol in SLL is incorrect, which means the
receiver cannot parse the L3 header correctly.

To reproduce the issue, please follow these steps:
1. ip link add link ens18 ens18.24 type vlan id 24
2. ifconfig ens18.24 1.0.24.1/24
3. ping -n 1.0.24.3 > /dev/null 2>&1 &
4. tcpdump -nn -i any -Q out not tcp and not udp

The attached experiment results show that the protocol is incorrectly
parsed as IPv4, which leads to inaccurate outcomes.

Thanks to Paolo's suggestion, I propose that we add a new bit in the
status to indicate the presence of VLAN information in the payload and
modify the header's entry (i.e., tp_vlan_tci/tp_vlan_tpid)
accordingly.
For the sll_protocol part, we can introduce a new member in the
sockaddr_ll struct to represent the VLAN-encapsulated protocol, if
applicable.

In my humble opinion, this approach will not affect current users who
rely on the status to handle VLAN parsing, and the sll_protocol will
remain unchanged.
Please kindly provide your feedback on this proposal, as there may be
important points I have overlooked.
If this approach seems feasible, I will submit a new version next week.
Your assistance and opinions on this issue are important to me, and I
truly appreciate them.

Best regards,
Chengen Du

[1] https://github.com/the-tcpdump-group/libpcap/issues/1105
[2] https://marc.info/?l=3Dlinux-netdev&m=3D165074467517201&w=3D4

On Tue, May 21, 2024 at 9:28=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Paolo Abeni wrote:
> > On Tue, 2024-05-21 at 11:31 +0800, Chengen Du wrote:
> > > I would appreciate any suggestions you could offer, as I am not as
> > > familiar with this area as you are.
> > >
> > > I encountered an issue while capturing packets using tcpdump, which
> > > leverages the libpcap library for sniffing functionalities.
> > > Specifically, when I use "tcpdump -i any" to capture packets and
> > > hardware VLAN offloading is unavailable, some bogus packets appear.
>
> Bogus how exactly?
>
> > > In this scenario, Linux uses cooked-mode capture (SLL) for the "any"
> > > device, reading from a PF_PACKET/SOCK_DGRAM socket instead of the
> > > usual PF_PACKET/SOCK_RAW socket.
>
> Trying to extract L2 or VLAN information from the any device may be
> the real issue here.
>
> > >
> > > Using SOCK_DGRAM instead of SOCK_RAW means that the Linux socket code
> > > does not supply the packet's link-layer header.
> > > Based on the code in af_packet.c, SOCK_DGRAM strips L2 headers from
> > > the original packets and provides SLL for some L2 information.
> >
> > > From the receiver's perspective, the VLAN information can only be
> > > parsed from SLL, which causes issues if the kernel stores VLAN
> > > information in the payload.
>
> ETH_HLEN is pulled, but the VLAN tag is still present, right?
>
> > >
> > > As you mentioned, this modification affects existing PF_PACKET receiv=
ers.
> > > For example, libpcap needs to change how it parses VLAN packets with
> > > the PF_PACKET/SOCK_RAW socket.
> > > The lack of VLAN information in SLL may prevent the receiver from
> > > properly decoding the L3 frame in cooked mode.
> > >
> > > I am new to this area and would appreciate it if you could kindly
> > > correct any misunderstandings I might have about the mechanism.
> > > I would also be grateful for any insights you could share on this iss=
ue.
> > > Additionally, I am passionate about contributing to resolving this
> > > issue and am willing to work on patches based on your suggestions.
> >
> > One possible way to address the above in a less invasive manner, could
> > be allocating a new TP_STATUS_VLAN_HEADER_IS_PRESENT bit, set it for
> > SLL when the vlan is not stripped by H/W and patch tcpdump to interpret
> > such info.
>
> Any change must indeed not break existing users. It's not sufficient
> to change pcap/tcpdump. There are lots of other PF_PACKET users out
> there. Related, it is helpful to verify that tcpdump agrees to a patch
> before we change the ABI for it.

--000000000000a6bba006190bbcfa
Content-Type: application/vnd.tcpdump.pcap; name="any_sll.pcap"
Content-Disposition: attachment; filename="any_sll.pcap"
Content-Transfer-Encoding: base64
Content-ID: <f_lwhx0e5n0>
X-Attachment-Id: f_lwhx0e5n0

1MOyoQIABAAAAAAAAAAAAAAABABxAAAAGPhNZqvjCgAsAAAALAAAAAAEAAEABqoRvXX09QAACAYA
AQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgDGPhNZq3jCgAsAAAALAAAAAAEAAEABqoRvXX09QAA
gQAAAQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgDGfhNZsNBCwAsAAAALAAAAAAEAAEABqoRvXX0
9QAACAYAAQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgDGfhNZsRBCwAsAAAALAAAAAAEAAEABqoR
vXX09QAAgQAAAQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgDGvhNZv6eCwAsAAAALAAAAAAEAAEA
BqoRvXX09QAACAYAAQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgDGvhNZgCfCwAsAAAALAAAAAAE
AAEABqoRvXX09QAAgQAAAQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgDG/hNZs38CwAsAAAALAAA
AAAEAAEABqoRvXX09QAACAYAAQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgDG/hNZtL8CwAsAAAA
LAAAAAAEAAEABqoRvXX09QAAgQAAAQgABgQAAaoRvXX09QEAGAEAAAAAAAABABgD
--000000000000a6bba006190bbcfa--

