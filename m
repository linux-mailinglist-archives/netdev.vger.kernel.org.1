Return-Path: <netdev+bounces-81047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF1885946
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF101F215BA
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D3683CAA;
	Thu, 21 Mar 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcAi4/Z+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39BF3717B
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024929; cv=none; b=KjD82bOOmjVi/zdQvHo2llGLMlJNQSZWUiXtk2IOX4dK6tm3LXUiGtUJ99c6nrW9J7gw6FK0y980GgTCQcMPe5oREtM/MgZ5ByiTfE8fxULsSus8Tf78OXao4NZIMcCghXDMiqa9yd+VEtWyGbmfPsjx2jNxMA05SCFkHNx62+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024929; c=relaxed/simple;
	bh=fUek+VpJAZoN00+JKK4oOUoRAR2rxLiTPsNdSckgpbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hs23edc7Z1SMmKJBzQEVTNMfsV1hqDAgIXr86CCpYfXnbvv2rmL52MKFpjqagtEspoDjt2CMgMOj4QnDfX4m51YwbU7FqYu7eURIcaN+QISRy7fKfxpm/Ic1wCITli7Z9YuXLr59S1uqppRqH5V/gUkOeJPSD+JZBDaLlgRkFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcAi4/Z+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711024926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nNxLzLdUC2oMrEHfCE5CO8wAkNXRMnS3XIZKABAnyhI=;
	b=TcAi4/Z+XWmXo0OcyBWU+mZrJReq40sk2ZJ+H59eWt9EAJ1EpxkrcUQchKCm+oCqh619LB
	s+g6SxDIrD128KYoXoNZwuZCiniggmcjqwzaNm16r/8sunNKnlxbHBAIwu2QngRQUSHYVO
	BhBqiRK5Fa37Qxg4eB5jq7R6ukadopk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-HjOBZHPCNpuHOvCyXYY40w-1; Thu, 21 Mar 2024 08:42:05 -0400
X-MC-Unique: HjOBZHPCNpuHOvCyXYY40w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d49590ee73so2436211fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 05:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024923; x=1711629723;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNxLzLdUC2oMrEHfCE5CO8wAkNXRMnS3XIZKABAnyhI=;
        b=PwVYgjIlbHUu8O//KTWkV41M6Sj3hNSX12CwRcvLtuA91e+3Ccby53gNzbQg1og1EN
         1RPP70qDk2cJStVYTujUyWVWFoiVT6Gewm0BuH3BdFvlnZqxROcJFdIX+mSV++tWtD+t
         vt4ImJHe4JSH20TJjHnx7x1y9bDk234yN/YLpZdBhI4DYl4WHi96fP/utyU/PcV3G8q2
         1zAMVk3/Eh/YrKWipnNzkJy4b94YoMA16lzoDcQNn++2QxRPizdLNHZUR6U5si1m5Xdz
         u8UpLA6/0VozPvMzPfZUyrC8dFolFT0nodJ+Uge05oi9Y8UrmMVO8q9GQ7ZEZr5so+YR
         +XEA==
X-Forwarded-Encrypted: i=1; AJvYcCWQCDxd/kvg69VpiMDH+bsnFjjZ1w74rVGQjeEgkbvDB2P7LmpBUX8P9LAnROsJQTxSIbBy3x/R0cvdk79/cgk3aBr6JLpL
X-Gm-Message-State: AOJu0YxH4equUaItT5iSTtCd6VdVJx/cY60cOqUPYjfVKh3AejxaL4fy
	GrRgwY9k1ffrsdMaP7VEsGzJIqMxgDu1cgpoYSoh6mo/Caii3cZUduy2gFwwzOmkItBoD2bNpzV
	5c/o5aEX4XQhTyEbZ1Bvy3bRXXVoAumAJoJtlQm/f2z5sUbl89v9KTw==
X-Received: by 2002:a2e:8691:0:b0:2d4:7575:4aa3 with SMTP id l17-20020a2e8691000000b002d475754aa3mr5769430lji.4.1711024923706;
        Thu, 21 Mar 2024 05:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtJCyaUbqUoWCGJ9QQz0KQPDkdmzRYoTJW0UKqZGnM6YuefSQOGBZ2DAKn8asV33iehqAtKA==
X-Received: by 2002:a2e:8691:0:b0:2d4:7575:4aa3 with SMTP id l17-20020a2e8691000000b002d475754aa3mr5769414lji.4.1711024923310;
        Thu, 21 Mar 2024 05:42:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-130.dyn.eolo.it. [146.241.249.130])
        by smtp.gmail.com with ESMTPSA id p42-20020a05600c1daa00b004146f93a9d1sm3410009wms.25.2024.03.21.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:42:02 -0700 (PDT)
Message-ID: <718747435bca1a76377fca226a085396e0415ffc.camel@redhat.com>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to
 unnecessary checksum
From: Paolo Abeni <pabeni@redhat.com>
To: Antoine Tenart <atenart@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org
Date: Thu, 21 Mar 2024 13:42:01 +0100
In-Reply-To: <171101093713.5492.11530876509254833591@kwain>
References: <20240319093140.499123-1-atenart@kernel.org>
	 <20240319093140.499123-4-atenart@kernel.org>
	 <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
	 <171086409633.4835.11427072260403202761@kwain>
	 <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch>
	 <171094732998.5492.6523626232845873652@kwain>
	 <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch>
	 <171101093713.5492.11530876509254833591@kwain>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-21 at 09:48 +0100, Antoine Tenart wrote:
> Quoting Willem de Bruijn (2024-03-20 21:43:55)
> > Antoine Tenart wrote:
> > > Quoting Willem de Bruijn (2024-03-20 14:00:48)
> > > > Antoine Tenart wrote:
> > > > > Quoting Willem de Bruijn (2024-03-19 14:38:20)
> > > > > >=20
> > > > > > The original patch converted to CHECKSUM_UNNECESSARY for a reas=
on.
> > > > > > The skb->csum of the main gso_skb is not valid?
> > > > > >=20
> > > > > > Should instead only the csum_level be adjusted, to always keep
> > > > > > csum_level =3D=3D 0?
> > > > >=20
> > > > > The above trace is an ICMPv6 packet being tunneled and GROed at t=
he UDP
> > > > > level, thus we have:
> > > > >   UDP(CHECKSUM_PARTIAL)/Geneve/ICMPv6(was CHECKSUM_NONE)
> > > > > csum_level would need to be 1 here; but we can't know that.
> > > >=20
> > > > Is this a packet looped internally? Else it is not CHECKSUM_PARTIAL=
.
> > >=20
> > > I'm not sure to follow, CHECKSUM_NONE packets going in a tunnel will =
be
> > > encapsulated and the outer UDP header will be CHECKSUM_PARTIAL. The
> > > packet can be looped internally or going to a remote host.
> >=20
> > That is on transmit. To come into contact with UDP_GRO while having
> > CHECKSUM_PARTIAL the packet will have to loop into the receive path,
> > in some way that triggers GRO. Perhaps through gro_cells, as other
> > GRO paths are hardware NIC drivers.
>=20
> I get what you meant now, thanks. Yes, those Tx packets loop into the Rx
> path. One easy way is through veth pairs, eg. packet get tunneled in a
> netns, connected to another one via a veth pair.
>=20
> > > > > There is another issue (no kernel trace): if a packet has partial=
 csum
> > > > > and is being GROed that information is lost and the packet ends u=
p with
> > > > > an invalid csum.
> > > >=20
> > > > CHECKSUM_PARTIAL should be converted to CHECKSUM_UNNECESSARY for th=
is
> > > > reason. CHECKSUM_PARTIAL implies the header is prepared with pseudo
> > > > header checksum. Similarly CHECKSUM_COMPLETE implies skb csum is va=
lid.
> > > > CHECKSUM_UNNECESSARY has neither expectations.
> > >=20
> > > But not if the packet is sent to a remote host. Otherwise an inner
> > > partial csum is never fixed by the stack/NIC before going out.
> >=20
> > The stack will only offload a single checksum. With local checksum
> > offload, this can be the inner checksum and the outer can be cheaply
> > computed in software. udp_set_csum() handles this. It indeed sets lco
> > if the inner packet has CHECKSUM_PARTIAL. Otherwise it sets ip_summed
> > to CHECKSUM_PARTIAL, now pointing to the outer UDP header.
> >=20
> > You're right. Regardless of whether it points to the inner or outer
> > checksum, a conversion of CHECKSUM_PARTIAL to CHECKSUM_UNNECESSARY
> > will break checksum offload in the forwarding case.
> >=20
> > > > > Packets with CHECKSUM_UNNECESSARY should end up with the same inf=
o. My
> > > > > impression is this checksum conversion is at best setting the sam=
e info
> > > > > and otherwise is overriding valuable csum information.
> > > > >=20
> > > > > Or would packets with CSUM_NONE being GROed would benefit from th=
e
> > > > > CHECKSUM_UNNECESSARY conversion?
> > > >=20
> > > > Definitely. If the packet has CHECKSUM_NONE and GRO checks its
> > > > validity in software, converting it to CHECKSUM_UNNECESSARY avoids
> > > > potential additional checks at later stages in the packet path.
> > >=20
> > > Makes sense. The current code really looks like
> > > __skb_incr_checksum_unnecessary, w/o the CHECKSUM_NONE check to only
> > > convert those packets.
>=20
> If I sum up our discussion CHECKSUM_NONE conversion is wanted,
> CHECKSUM_UNNECESSARY conversion is a no-op and CHECKSUM_PARTIAL
> conversion breaks things. What about we just convert CHECKSUM_NONE to
> CHECKSUM_UNNECESSARY?
>=20
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index 50a8a65fad23..44779d4c538b 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -174,7 +174,7 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct =
sk_buff *skb, int nhoff)
>                 if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) {
>                         if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
>                                 skb->csum_level++;
> -               } else {
> +               } else if (skb->ip_summed =3D=3D CHECKSUM_NONE) {
>                         skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>                         skb->csum_level =3D 0;
>                 }
>=20
> Or directly call __skb_incr_checksum_unnecessary

I think calling __skb_incr_checksum_unnecessary() would be the better
option.

@Willem: FTR, Antoine and me discussed this series internally for a
bit, and the above variant was also discussed. I was unable to find a
good reason for the CHECKSUM_NONE -> CHECKSUM_UNNECESSARY conversion
back then, so it seemed more clean to drop the whole chunk.

Cheers,

Paolo


