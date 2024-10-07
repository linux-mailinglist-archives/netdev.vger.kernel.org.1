Return-Path: <netdev+bounces-132853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088D99387A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E0F286092
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF201DE3D6;
	Mon,  7 Oct 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvIlmj+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768301DE4E9;
	Mon,  7 Oct 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333888; cv=none; b=Lor3xuiA8guZqqHeAuNmDzmlDR/EYY4V1zvU1ArG4RmI0p3/irhxgWPjzsEzdkO7DRlHo7KxqZZaYFqCkV2Ov0StnVh6u+JsQPwAFgckr/1kxXycSaqGi2xlS74w6o6MeeigfRHZVgsPBRc3AJIwYGRgvF43IyNkkK0cvMrRtVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333888; c=relaxed/simple;
	bh=ffTP74PAg0vOC/NBO95q4TJ+F7dZFq3qXZsFMzaLKlU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ryxFWjI/YbcrwhnCHB6ppLZq/hTDSzldMwjwlrDRiORFGIEIHzGBS8jf0wjAfAsT30Xc6rApD6rSn+6F6uacTTQ+1oHYUea4BlNzWQpHbNW9MsIC11BPZe92Sm5UxHggs7t9qlI6iUDooUpIlMZF3l5sSNOhSMwPPzsAexBTQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvIlmj+C; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4582760b79cso22898861cf.2;
        Mon, 07 Oct 2024 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728333885; x=1728938685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh4BdK+18NFCAgVVbHQ0tkBnIdUO1PHtgnejKkp9YK4=;
        b=KvIlmj+CQnvB+b+JnA/VHvTCsQXpCZsFaLq9cOFIPNaOelIZRvrPWdRZ202FkzLg2F
         OXP20kMBAJKzg6ohHZzr264shWXBmaP4rXJJhQHiCIwvtXdNYcox9oX6eU7DpFm3aY7k
         evYccfCmsk6VBiE8fbV8FT6j5nBr9vc/emGUYIC//FESMuGCcveFIJtRrq2UksBdN4V6
         kCzsqRHWjhm4NIVYlLec/+zg2vYNU8G65zVQez/WH3QF4jPnhRF7UEMynAN8Rd6Q/4o4
         Sc1zYM4obux7nEBhX3ym/00CnYITnb6i6cw/tAeHEpx7bwWRd1iSRZan0mOgQIEqYuOq
         6Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333885; x=1728938685;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dh4BdK+18NFCAgVVbHQ0tkBnIdUO1PHtgnejKkp9YK4=;
        b=eF8dyG2FOKBl2qKGBaRLUNzb8d+8BthowT8fXj1AH9eTQfjLVpug4eJZ7GNzSyPdS7
         W996pjw2KorQaiah00QgujKjtWJbgSPSLkgOF27VguhcC1B4dv8QdR31F72qDDsAvEvl
         cK+kEkG18lxuEMFLKE+DYEBviL/ynzHJxY6mpqae5FjtelhBtKEkvcGcVXIJD/iAOWWp
         UHeEZvLxbviBhrQrt53YQUHq5LeoLkRNy3RMjz+xRsTbXftCQhwaQd6b2YrOOV2YSPGh
         HKkC1EKCBesQMHTyk7qnAwLmuHUJ9pCmWl7lJ6wy4QKC1IU91niaZxPHvX3Z2+OFrWHD
         HEHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKcfwb9JRBF4KyurLmlFAhT9Gn8PfSXSWUm4g6yKrt0jV3Ly43qTuwBRAjQwVB79WVnyZjvVyR/YvqDUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZK8hXc8zfHPbd85K8bVEFLqCkN7yqSkSL6JoYpBSE8bH3kqt
	KB7I7aYs1wjEhrZ5AVAIhRcU56hr/ZtrzQ2sePUfhWPXk1qxZND12vRb6Viu
X-Google-Smtp-Source: AGHT+IF9dj3wgK7BaYSvD/6R7vMw98JBgbaalCQ2v52PDvHYrjRKUGUPw+z5FrancfZfxVrH1FbBJw==
X-Received: by 2002:ac8:5810:0:b0:458:4eae:6c6c with SMTP id d75a77b69052e-45d9ba69cb5mr192526011cf.30.1728333885083;
        Mon, 07 Oct 2024 13:44:45 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74b458bsm29673191cf.2.2024.10.07.13.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:44:44 -0700 (PDT)
Date: Mon, 07 Oct 2024 16:44:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?QmVub8OudCBNb25pbg==?= <benoit.monin@gmx.fr>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6704483c31f9c_1635eb294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <7056440.9J7NaK4W3v@benoit.monin>
References: <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
 <670326ed8220a_135479294d1@willemb.c.googlers.com.notmuch>
 <7056440.9J7NaK4W3v@benoit.monin>
Subject: Re: [PATCH net-next] net: skip offload for NETIF_F_IPV6_CSUM if ipv6
 header contains extension
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Beno=C3=AEt Monin wrote:
> 07/10/2024 Willem de Bruijn wrote :
> > Beno=C3=AEt Monin wrote:
> > > Devices with NETIF_F_IP_CSUM capability can checksum TCP and UDP ov=
er
> > > IPv4 with an IP header that may contains options; whereas devices w=
ith
> > > NETIF_F_IPV6_CSUM capability can only checksum TCP and UDP over IPv=
6 if
> > > the IP header does not contains extension.
> > =

> > Are both these statements universally true across devices?
> > =

> > I can believe for NETIF_F_IP_CSUM that this is the definition, and
> > that devices that cannot handle options must fix it up indivually in
> > ndo_features_check.
> > =

> > And same for NETIF_F_IPV6_CSUM with extension headers.
> > =

> > But it would be good to see where this is asserted in the code, or
> > examples of drivers that have to perform such actions.
> > =

> I was referring to the documentation in skbuff.h that describes =

> NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM.

Excellent. I had missed that when trying to find the source.
Can you add that pointer to the commit message?
 =

> For NETIF_F_IPV6_CSUM, at least fsl_dpa and r8169 expect =

> ipv6_hdr(skb)->nexthdr to be IPPROTO_{TCP,UDP} to compute the correct =

> checksum for IPv6.
> =

> I posted more details about the problem I am trying to fix with this =

> patch in the following thread: =

> https://lore.kernel.org/netdev/26548921.1r3eYUQgxm@benoit.monin/T/#u

And I had missed this thread entirely too. It's very helpful.

Please add a Link: tag that refers to it.
 =

> > > Enforce that in skb_csum_hwoffload_help by checking the network hea=
der
> > > length in the case where the IP header version is 6. We cannot simp=
ly
> > > rely on the network header length since the IPv4 header can from 20=
 to
> > > 60 bytes whereas the IPv6 header must be 40 bytes. So we check the
> > > version field which is common to IPv4 and IPv6 headers.
> > > =

> > > This fixes checksumming errors seen with ip6_tunnel and fou6
> > > encapsulation, for example with GRE-in-UDP over IPv6:
> > > * fou6 adds a UDP header with a partial checksum if the inner packe=
t
> > > does not contains a valid checksum.
> > =

> > Where in the code is this conditional on the inner packet csum?
> > =

> This is done by udp6_set_csum, which called by fou6_build_udp.

        else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
                uh->check =3D 0;
                uh->check =3D udp_v6_check(len, saddr, daddr, lco_csum(sk=
b));
                if (uh->check =3D=3D 0)
                        uh->check =3D CSUM_MANGLED_0;
        } else {
                skb->ip_summed =3D CHECKSUM_PARTIAL;
                skb->csum_start =3D skb_transport_header(skb) - skb->head=
;
                skb->csum_offset =3D offsetof(struct udphdr, check);
                uh->check =3D ~udp_v6_check(len, saddr, daddr, 0);
        }

It either leaves the inner header as CHECKSUM_PARTIAL, and fills in
the outer header entirely, based on knowledge that the inner header
will add up to zero (local checksum offload).

Or it assumes that the inner header is already filled in (whether
computed or CSUM_MANGLED_0) and then uses CHECKSUM_PARTIAL offloading
for the outer packet.

The issue you are seeing is because CHECKSUM_PARTIAL with
NETIF_F_IPV6_CSUM does not work if extension headers are present. If
so, it should even affect non-tunneled packets. I think this reference
to a dependency on the state of an inner checksum adds confusion only.
Unless I'm missing something.

> > > * ip6_tunnel adds an IPv6 header with a destination option extensio=
n
> > > header if encap_limit is non-zero (the default value is 4).
> > =

> > =

> > If this is a fix, we'll need to target net and best effort find a
> > suitable fixes tag.
> >  =

> I guess the particular problem I have found is present since the merge =

> of fou6 in 4.7, but it might not be the only code path to create an =

> IPv6 packet with an extension header and a partial checksum.

True. The fix as is won't be backportable before commit 62fafcd63139
("net: support ip generic csum processing in skb_csum_hwoffload_help")
in v5.12 anyway.

Maybe use that as the Fixes tag, but add a comment in the tag that it
did not introduce the bug, but the fix depends on that logic.

> > > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> > > ---
> > >  net/core/dev.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > =

> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index ea5fbcd133ae..199831d86ec1 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *s=
kb,
> > >  		return 0;
> > > =

> > >  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > > +		if (ip_hdr(skb)->version =3D=3D 6 &&
> > > +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> > > +			goto sw_checksum;

This check depends on skb->transport_header and skb->network_header
being set. This is likely true for all CHECKSUM_PARTIAL packets that
originate in the local stack. As well as for the injected packets and
forwarded packets, as far as I see, so Ack.

Access to the network header at this point likely requires
skb_header_pointer, however. As also used in qdisc_pkt_len_init called
from the same __dev_queue_xmit_nit.

Perhaps this test should be in can_checksum_protocol, which already
checks that the packet is IPv6 when testing NETIF_F_IPV6_CSUM.

> > >  		switch (skb->csum_offset) {
> > >  		case offsetof(struct tcphdr, check):
> > >  		case offsetof(struct udphdr, check):
> > > @@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *s=
kb,
> > >  		}
> > >  	}
> > > =

> > > +sw_checksum:
> > >  	return skb_checksum_help(skb);
> > >  }
> > >  EXPORT_SYMBOL(skb_csum_hwoffload_help);
> > =

> =

> -- =

> Beno=C3=AEt
> =

> =




