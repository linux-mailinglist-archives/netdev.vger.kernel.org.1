Return-Path: <netdev+bounces-188189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA0AAB806
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8C617AECA
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D5728D859;
	Tue,  6 May 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PYRLaUHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D127A91B
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489297; cv=none; b=tIKPhqJ62dKzT3fAcBfzwmwP+mwH4tfEeQKlUKLbG5prF2RXq2cPU1WqLuJ73URHHAvThUyfWStVFUkLVAlyxeAUR719jSZBLI3x4kAN3VT0rao08RxGh0/ANT1321BsdFWsPopcLpiOJdefv9EJIXIihe4YUeTZRoNKLrzK03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489297; c=relaxed/simple;
	bh=/2Oo4hpeqQ72lkjZJcWgwHN8eeG7qdXGbJSkOlbBWWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdtJT+tlrkDB1OevwLTZ4lsA7M/KP6ZC7RQUfjo267da+kUtE85004MrFHzRDqKABSsAyDWZFBrxxnjfZ7HN6w0lEpSeXXI+Joz/r95Z943JpQPVP6p/FJqZH0Z62Ux5Hr/1D2j1/8WEUmZmBNJP0/DyHXBYLMRtRE327EkMrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PYRLaUHl; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U86OgasmdA5L3G8dzDk8ANFuXdi7eodeDf/pfv2NO48=; t=1746489295; x=1747353295; 
	b=PYRLaUHl/iUeEicuPkle24wmnaHwaTqMxqyew6pvQCIeNUfNqJnDgvv43JHB/HZJjSNIq6njwmP
	bYKWwTzmGvlpJIlqdj8UMnH037flKVjqmtP57slJYCb5tz0zczq356IT7rjH+DwGFTSTLQD50Mf6V
	wp+niaBN1+68bXYH4QNAW/qGtOW7GKx1a/5MkjC6RJ8/lxrBuZhFp/zq5zQPApHOipIcigTur4OLs
	tyV7PFmwZYayLoKJczfUIdpdorgWks+//zjgUy0BL26l964gZG+4WaTwEseCXSk7O3QsC5YAXCu1t
	cRFNA4+ZZ+YM9AAIixmqmnJihNAOH1ge0qpA==;
Received: from mail-oo1-f50.google.com ([209.85.161.50]:60517)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uC5e9-0004Tl-CR
	for netdev@vger.kernel.org; Mon, 05 May 2025 16:54:54 -0700
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6063462098eso3008486eaf.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 16:54:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwcwH31Hy05g2BEPbLkctFAXpf4jJ6hKCKJ4Kv5krs72gByHyi7
	VJ7Qt23zPM8MuKvG73s55E9WaIEHB8diSHO6diPQMTzPMJziTcfv0mgxKHdA6IYAoiQyok4wQyV
	0bOmYBFiHYEssIeiIhS6VkYLuPhY=
X-Google-Smtp-Source: AGHT+IECPfaYbZZ3kCdQzODkTUcwdOR2kk6V+FJ+2kJCuC5HAAbdHkxgdAUBTOkWlsVFgGY+sDyBnV9H9pvlT3jcDNE=
X-Received: by 2002:a4a:ee98:0:b0:604:2b3:2c9b with SMTP id
 006d021491bc7-608002fe88dmr5574176eaf.4.1746489292827; Mon, 05 May 2025
 16:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-3-ouster@cs.stanford.edu> <835b43b9-b9c4-4f09-9ce3-9157e1d9fea6@redhat.com>
In-Reply-To: <835b43b9-b9c4-4f09-9ce3-9157e1d9fea6@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 5 May 2025 16:54:17 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzuf51CVYZRPDC9OOpr+UVo5SjgiEEGfSQVdy=TC0OhtQ@mail.gmail.com>
X-Gm-Features: ATxdqUHaQD9yhXs-WUW7lwO9XaF-Z_2uUWDpT1SfD45EoeHNsefmCge8btBQm_g
Message-ID: <CAGXJAmzuf51CVYZRPDC9OOpr+UVo5SjgiEEGfSQVdy=TC0OhtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 02/15] net: homa: create homa_wire.h
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 866f53e0e2528d6d10d4c38b759870b4

On Mon, May 5, 2025 at 1:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/3/25 1:37 AM, John Ousterhout wrote:
> > diff --git a/net/homa/homa_wire.h b/net/homa/homa_wire.h
> > new file mode 100644
> > index 000000000000..47693244c3ec
> > --- /dev/null
> > +++ b/net/homa/homa_wire.h
>
> I'm wondering why you keep the wire-struct definition outside the uAPI -
> the opposite of what other protocols do.

By 'uAPI' I assume you mean homa.h? I didn't consider putting it
there, and would prefer not to, because Homa users should not need to
know anything about the wire format. But, I will combine the files if
you think it is better to do that for consistency with other
protocols. Please confirm?

> > +/* Defines the possible types of Homa packets.
> > + *
> > + * See the xxx_header structs below for more information about each ty=
pe.
> > + */
> > +enum homa_packet_type {
> > +     DATA               =3D 0x10,
> > +     RESEND             =3D 0x12,
> > +     RPC_UNKNOWN        =3D 0x13,
> > +     BUSY               =3D 0x14,
> > +     NEED_ACK           =3D 0x17,
> > +     ACK                =3D 0x18,
> > +     BOGUS              =3D 0x19,      /* Used only in unit tests. */
> > +     /* If you add a new type here, you must also do the following:
> > +      * 1. Change BOGUS so it is the highest opcode
>
> If you instead define 'MAX' value, the required update policy would be
> self-explained and you will not need to expose tests details.

Done.

>
> > +      * 2. Add support for the new opcode in homa_print_packet,
> > +      *    homa_print_packet_short, homa_symbol_for_type, and mock_skb=
_new.
> > +      * 3. Add the header length to header_lengths in homa_plumbing.c.
> > +      */
> > +};
> > +
> > +/** define HOMA_IPV6_HEADER_LENGTH - Size of IP header (V6). */
> > +#define HOMA_IPV6_HEADER_LENGTH 40
> > +
> > +/** define HOMA_IPV4_HEADER_LENGTH - Size of IP header (V4). */
> > +#define HOMA_IPV4_HEADER_LENGTH 20
>
> I suspect you will be better off using sizeof(<relevant struct>). Making
> protocol-specific definition for common/global constants is somewhat
> confusing and unexpected

Done.

> > +/**
> > + * define HOMA_SKB_EXTRA - How many bytes of additional space to allow=
 at the
> > + * beginning of each sk_buff, before the IP header. This includes room=
 for a
> > + * VLAN header and also includes some extra space, "just to be safe" (=
not
> > + * really sure if this is needed).
> > + */
> > +#define HOMA_SKB_EXTRA 40
>
> You could use:
>
> #define MAX_HOME_HEADER MAX_TCP_HEADER
>
> to leverage a consolidated value covering most use-cases and kernel confi=
gs.

Done (I wasn't aware of MAX_TCP_HEADER).

> > +/**
> > + * define HOMA_ETH_OVERHEAD - Number of bytes per Ethernet packet for =
Ethernet
> > + * header, CRC, preamble, and inter-packet gap.
> > + */
> > +#define HOMA_ETH_OVERHEAD 42
>
> It's not clear why the protocol should be interested in MAC-specific
> details. What if the the MAC is not ethernet?

This is used by the pacer in order to get the most accurate possible
estimate of exactly how much time it will take to transmit a packet
(so that Homa can pass packets to the NIC at a rate that runs the
uplink at utilization just under 100% without generating queue buildup
in the NIC). Is there a way to get this information from the dev in a
way that reflects the specific hardware more accurately than guessing
based on Ethernet?

> > +     /**
> > +      * @type: Homa packet type (one of the values of the homa_packet_=
type
> > +      * enum). Corresponds to the low-order byte of the ack in TCP.
> > +      */
> > +     __u8 type;
>
> If you keep this outside uAPI you should use 'u8'

Will do.

> > +_Static_assert(sizeof(struct homa_data_hdr) <=3D HOMA_MAX_HEADER,
> > +            "homa_data_hdr too large for HOMA_MAX_HEADER; must adjust =
HOMA_MAX_HEADER");
> > +_Static_assert(sizeof(struct homa_data_hdr) >=3D HOMA_MIN_PKT_LENGTH,
> > +            "homa_data_hdr too small: Homa doesn't currently have code=
 to pad data packets");
> > +_Static_assert(((sizeof(struct homa_data_hdr) - sizeof(struct homa_seg=
_hdr)) &
> > +             0x3) =3D=3D 0,
> > +            " homa_data_hdr length not a multiple of 4 bytes (required=
 for TCP/TSO compatibility");
>
> Please use BUILD_BUG_ON() in a .c file instead. Many other cases below.

Will do, if this info doesn't move to uAPI (BTW, BUILD_BUG_ON feels
more awkward because it doesn't allow an error message).


-John-

