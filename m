Return-Path: <netdev+bounces-50699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B847F6C48
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 07:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91341C20829
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 06:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E85247;
	Fri, 24 Nov 2023 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4G6ZEfi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B3D64
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 22:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700806999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBsn2i0nliFo+phWtl46j5XfLoBPy3pcywVKmodl4XE=;
	b=D4G6ZEfiI7sb7Q1opI0dF4se4oWNvD6soqIsEnaOACGZUZQXUBZ0x8GJigDYTT+2aNiDYp
	opKEwQs9jPCFjBolRMKhwC1sS0I+Suas7pVNznWHIUdJERZarJbZY80SbIvrMNRoECQIRl
	GflyqdllodmjuKQIdf6THPq8LtEhjlk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-iIoXWwH-NBunff5-zP2q7A-1; Fri, 24 Nov 2023 01:23:17 -0500
X-MC-Unique: iIoXWwH-NBunff5-zP2q7A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b99999614bso1595640a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 22:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700806996; x=1701411796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBsn2i0nliFo+phWtl46j5XfLoBPy3pcywVKmodl4XE=;
        b=qrIRitG0y87D9QRGsmlY2ZTVemkM9smN/QtiYCC9rgrbVuPdmpEK5gpDaW34mQeBCn
         qkWLIzcuq6fNG6hvz9qJvtNZ9rr7vvKd/RiT4lF59vxevq7ty/onDP5BbTEpjpOi4JRT
         Qfa9hyPKLlxOdF+d4/w6a91IJDPTE+jUyFw6iz8ENeTOjpBxZZAS0FFGts6KTCOU6fQZ
         Aip/hCtYAPUc3+cVIm4p5+Nn06QrdddBLjMyX26umFpBuCy1WlrqhU+K++snuq0SU94r
         1NfSSE/KS1rwipg/K4hmjW2epYokZEV6G1a2hWu1akC090s2RCixQMbBkQckW2N6Li0w
         ZFbg==
X-Gm-Message-State: AOJu0YyiFpY33+2oUOELrnALkiKPiIHJBYwYnRcFPvL5Adlp+h1el96V
	Dk66ZPPDjR6aD1Dx8ac2O9vCwoRzx9A+z4TD+BvgTieBP82mFm/SruQ2LL6A0D2kkTZgB8uZ6hz
	nYmgqfPPXcJuR5NGgTRBvEFVkzwCCa19+
X-Received: by 2002:a05:6a21:2711:b0:187:8eca:8dc6 with SMTP id rm17-20020a056a21271100b001878eca8dc6mr1882343pzb.34.1700806996659;
        Thu, 23 Nov 2023 22:23:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHurVLY0iGJEBlzGiDzqMf52lCg1ORWNYsJKiEEd38ufrVuquai65EsJ4/P9zUrgJnhnYuiGXQnp1IxQ0PULu8=
X-Received: by 2002:a05:6a21:2711:b0:187:8eca:8dc6 with SMTP id
 rm17-20020a056a21271100b001878eca8dc6mr1882334pzb.34.1700806996387; Thu, 23
 Nov 2023 22:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123183835.635210-1-mkp@redhat.com> <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
 <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com> <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
From: Mike Pattrick <mkp@redhat.com>
Date: Fri, 24 Nov 2023 01:23:04 -0500
Message-ID: <CAHcdBH4aMJwkR7fVP=Brwb-4=gon-pwh0CbjbFxsoEiGj4XjVA@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 7:06=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mike Pattrick wrote:
> > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Mike Pattrick wrote:
> > > > Af_packet provides checksum offload offsets to usermode application=
s
> > > > through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on th=
e
> > > > socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
> > > > af_packet will include the link level header and so csum_start need=
s
> > > > to be adjusted accordingly.
> > >
> > > Is this patch based on observing an incorrect offset in a workload,
> > > or on code inspection?
> >
> > Based on an incorrect offset in a workload. The setup involved sending
> > vxlan traffic though a veth interface configured with a vlan. The
> > vnet_hdr's csum_start value was off by 4, and this problem went away
> > when the vlan was removed.
> >
> > I'll take another look at this patch.
>
> This is a vlan device on top of a veth device? On which device and at
> which point (ingress or egress) are you receiving the packet over the
> packet socket?

Just for maximum clarity I'll include the extracted commands below,
but roughly there is a vlan device on top of a vxlan device on top of
a vlan device on top of a veth, in a namespace.

ip netns add at_ns0
ip netns exec at_ns0 ip link add dev at_vxlan1 type vxlan remote
172.31.1.100 id 0 dstport 4789
ip netns exec at_ns0 ip addr add dev at_vxlan1 10.2.1.1/24
ip netns exec at_ns0 ip link set dev at_vxlan1 mtu 1450 up
ip link add p0 type veth peer name ovs-p0
ethtool -K p0 sg on
ethtool -K p0 tso on
ip link set p0 netns at_ns0
ip link set dev ovs-p0 up
ip netns exec at_ns0 ip addr add "172.31.2.1/24" dev p0
ip netns exec at_ns0 ip link set dev p0 up
ip netns exec at_ns0 ip link add link at_vxlan1 name at_vxlan1.100
type vlan proto 802.1q id 100
ip netns exec at_ns0 ip link set dev at_vxlan1.100 up
ip netns exec at_ns0 ip addr add dev at_vxlan1.100 "10.1.1.1/24"
ip netns exec at_ns0 ip link add link p0 name p0.42 type vlan proto 802.1q =
id 42
ip netns exec at_ns0 ip link set dev p0.42 up
ip netns exec at_ns0 ip addr add dev p0.42 "172.31.1.1/24"
ip addr add "172.31.1.100/24" dev p0
ip link set dev p0 up
ip netns exec at_ns0 ping 10.1.1.100

An AF_PACKET socket on ovs-p0 receives the incorrect csum_start.
Setting up the same with a geneve tunnel and udpcsum enabled produces
the same result. Removing vlan 100 also yields an incorrect
csum_start. Removing only vlan 42 yields a correct csum_start.

>
> From a quick glance, in all cases that I see the VLAN tag is kept in
> skb->vlan_tci, so is never part of the packet payload.
>
> But checksum offload with VXLAN can be non-trivial on its own. If
> type & SKB_GSO_UDP_TUNNEL_CSUM | SKB_GSO_TUNNEL_REMCSUM, say. Then
> csum_start will point to the checksum in vxlanhdr.
>


