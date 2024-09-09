Return-Path: <netdev+bounces-126564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAFA971D99
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89CCB2206D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819F22F1E;
	Mon,  9 Sep 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VM7tuMkE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DF1CD0C
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894581; cv=none; b=KIWEiPQp6QLRMcmawiNHNBCrWkm7OzS0lfG7CNfTryLbmCvSq1emjJxgE+wmxKA6KxEa1ZCAsXLqc5FAT75TAHCODHcwC08/8z4ficRhAIyaef0NoxlqqI6hqtE2gRLZjnEPvrVhw4sGgLqL1lS6Lj6/dQ7BWVhYn1fG2Sg6xS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894581; c=relaxed/simple;
	bh=dI+Rfjt/ZG/wWKuEJSm1HeKwXxxOzIbk72znuwPdvUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpbZS9MTBJ6P1O3u0wgRh4Ceo/qdcDqLaPCZFKSCnvVDAk7AhjwNXpABJQNFSzZRo2FLZsKK771TSfQ3ewam/OvO7tMZoWUZvNMzUYm9Ti20qmJ655UamgEJIuh7UwdhV25+kJGZKtv4qOawj+NOMY2jRjYE87y9IOHLMqzFimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VM7tuMkE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so52383785e9.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725894578; x=1726499378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm4nr7xIwltVYF6qX7bkS2YGz1zJV+MXNBmqDOjilVw=;
        b=VM7tuMkEvIYFY2pktBAJVerOv4aouPghwSE5ZuQWggRIGLkAsygdO2heiyivQ/Lvqy
         Z+rP7ACd1J6rjpK1gvPVT03uwtalgaG23Xam/XCFCRuy0kj8LXSDLYVHj/8XT+imWtBG
         iylRVfJbfhsKp7figQgL/jtPd+kxtqAdBNgqJ91UW/RdHOw6ZY/KcJvHJzPAERdFvy2Z
         4rcZioF1RpkyeY8ATosolr/kZUI3CNdklsMnSmaqRMlBGbV9Ua8cg/GuQoj2UKf7c3c1
         wmXD8IeO/B5wre2v2WhcY8mQOS4keF8KZ0Id4pN93Wv61466MLoKOJv8LuyYLAr8mqlc
         faBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894578; x=1726499378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm4nr7xIwltVYF6qX7bkS2YGz1zJV+MXNBmqDOjilVw=;
        b=ndB27lD5He1WhjwRLxnByx4j5TlQSU54OrBBC39FzeGVAkbw7CXCI0c8cOPd7Qb9S2
         8IM85dSqgBvMD1TSbB1cw4DTvchXZ88uK5NW9NVOOccoxCUdKQ4sJ6a1ig/ko8bKBITu
         K763Dz+0QnyipzZ6TmxmNa7Lkd/Bn6CAAYIHMaT+5EImBONTn3lkk6/fiibKoSKnlRPo
         J/UjnO/Cvu4PY9bl0ifK0uvTNfZ8L7JMpzetG78gqPI6mgXLYzFJ1godWrj2eZISaSFx
         4lCVkFBeM7aU+SqAbYCJZdo0ALCmlN9EPIZr0Lpih+3bc/Km91+MA+nl1Nb+2/3NwnHn
         CYAA==
X-Forwarded-Encrypted: i=1; AJvYcCXHEdsDs6DlaN3vb1c84T7XKbU323vWTw3bEtbOKxowTMiDKJBJHgFmKbuYSScGBDUnGmnOjNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/BVWMw7+cAk5tw0/LIKXEpdriQT8DzEQr4MH2zEjLBesnOOYY
	DM0DZIZTqVwek+9/rYz5jc6nttINT9r1m2DBGvKXXwdndqJSlYdzeUsoiP4aV4IkNfdyQOAfAl8
	AUp7dgPJCRTziMd4KeRDKnHKuXcyd7S9cxbFp
X-Google-Smtp-Source: AGHT+IEsIR6wwrumlus+Mfa6VjgVEMplUj9ew9q+4/gWEovIiopD7kbiiOTxE0H17FIFBfLiTS8LKypqeR+aXHiRICQ=
X-Received: by 2002:a5d:658f:0:b0:374:bd01:707c with SMTP id
 ffacd0b85a97d-3789243fd50mr6339510f8f.48.1725894577174; Mon, 09 Sep 2024
 08:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch> <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
In-Reply-To: <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Sep 2024 17:09:23 +0200
Message-ID: <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:02=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> On 9/6/24 22:05, Willem de Bruijn wrote:
> > Sean Anderson wrote:
> >> Padding is not included in UDP and TCP checksums. Therefore, reduce th=
e
> >> length of the checksummed data to include only the data in the IP
> >> payload. This fixes spurious reported checksum failures like
> >>
> >> rx: pkt: sport=3D33000 len=3D26 csum=3D0xc850 verify=3D0xf9fe
> >> pkt: bad csum
> >
> > Are you using this test as receiver for other input?
> >
> > The packet builder in the test doesn't generate these, does it?
>
> It's added by the MAC before transmission.
>
> This is permitted by the standard, but in this case it actually appears
> to be due to the MAC using 32-bit reads for the data and not masking off
> the end. Not sure whether this is a bug in the driver/device, since
> technically we may leak up to 3 bytes of memory.

This seems to be a bug in the driver.

A call to skb_put_padto(skb, ETH_ZLEN) should be added.

>
> That said, it would be a nice enhancement to generate packets with
> non-zero padding as well, since they are an interesting edge case.
>
> > Just trying to understand if this is a bug fix or a new use for
> > csum.c as receiver.
>
> Bug fix.
>
> >> Technically it is possible for there to be trailing bytes after the UD=
P
> >> data but before the Ethernet padding (e.g. if sizeof(ip) + sizeof(udp)=
 +
> >> udp.len < ip.len). However, we don't generate such packets.
> >
> > More likely is that L3 and L4 length fields agree, as both are
> > generated at the sender, but that some trailer is attached in the
> > network. Such as a timestamp trailer.
>
> Yes, as noted above we don't generate packets with differing L3 and L4
> lengths.
>
> >> Fixes: 91a7de85600d ("selftests/net: add csum offload test")
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >> Found while testing for this very bug in hardware checksum offloads.
> >>
> >>  tools/testing/selftests/net/lib/csum.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/se=
lftests/net/lib/csum.c
> >> index b9f3fc3c3426..e0a34e5e8dd5 100644
> >> --- a/tools/testing/selftests/net/lib/csum.c
> >> +++ b/tools/testing/selftests/net/lib/csum.c
> >> @@ -654,10 +654,16 @@ static int recv_verify_packet_ipv4(void *nh, int=
 len)
> >>  {
> >>      struct iphdr *iph =3D nh;
> >>      uint16_t proto =3D cfg_encap ? IPPROTO_UDP : cfg_proto;
> >> +    uint16_t ip_len;
> >>
> >>      if (len < sizeof(*iph) || iph->protocol !=3D proto)
> >>              return -1;
> >>
> >> +    ip_len =3D ntohs(iph->tot_len);
> >> +    if (ip_len > len || ip_len < sizeof(*iph))
> >> +            return -1;
> >> +
> >> +    len =3D ip_len;
> >>      iph_addr_p =3D &iph->saddr;
> >>      if (proto =3D=3D IPPROTO_TCP)
> >>              return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph)=
);
> >> @@ -669,16 +675,22 @@ static int recv_verify_packet_ipv6(void *nh, int=
 len)
> >>  {
> >>      struct ipv6hdr *ip6h =3D nh;
> >>      uint16_t proto =3D cfg_encap ? IPPROTO_UDP : cfg_proto;
> >> +    uint16_t ip_len;
> >
> > nit: payload_len, as it never includes sizeof ipv6hdr
>
> OK
>
> --Sean
>
> >>      if (len < sizeof(*ip6h) || ip6h->nexthdr !=3D proto)
> >>              return -1;
> >>
> >> +    ip_len =3D ntohs(ip6h->payload_len);
> >> +    if (ip_len > len - sizeof(*ip6h))
> >> +            return -1;
> >> +
> >> +    len =3D ip_len;
> >>      iph_addr_p =3D &ip6h->saddr;
> >>
> >>      if (proto =3D=3D IPPROTO_TCP)
> >> -            return recv_verify_packet_tcp(ip6h + 1, len - sizeof(*ip6=
h));
> >> +            return recv_verify_packet_tcp(ip6h + 1, len);
> >>      else
> >> -            return recv_verify_packet_udp(ip6h + 1, len - sizeof(*ip6=
h));
> >> +            return recv_verify_packet_udp(ip6h + 1, len);
> >>  }
> >>
> >>  /* return whether auxdata includes TP_STATUS_CSUM_VALID */
> >> --
> >> 2.35.1.1320.gc452695387.dirty
> >>
> >
> >

