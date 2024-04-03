Return-Path: <netdev+bounces-84533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E8897320
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5432909CF
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386814901F;
	Wed,  3 Apr 2024 14:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3E13A41F
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156158; cv=none; b=X2aX/TG/f7yckYZAAZ6CfEdyMs9dQN0vb290kOsaucfLetF4xQOjHkUHkeWVZ7lz+cy+Bu04ijDLTuJzMehM3VnMQhS+7zNe5xuudKwvDC3ieubRuOETWR4HKnWjIyWMOD9PGZMlMPTY21f8GrerimWzt76gt9C9zV9HqSWCkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156158; c=relaxed/simple;
	bh=KUUWr5kZPjnn7rG2jJiGo0oizIN5KHK/d5z7PI56ep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p5FVUHon3FEsGr5ND2eJfEmgAY2uUWImLWlRvC71nlGgqT02D1w8KFrxn6Efv0QUHfhBtunrn5eDcEjMwBscDOlLa1YQeViqrJ13Of848irTMOnYKx8PSJ4LSrgAc5EyxEZqZkqOiAV58u+3AWeeMWbpEBr1+dAtHbtE6X6PArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-c9OXWb7KMnCR36enlKvykA-1; Wed, 03 Apr 2024 10:55:51 -0400
X-MC-Unique: c9OXWb7KMnCR36enlKvykA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56D41886470;
	Wed,  3 Apr 2024 14:55:51 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28DCC8173;
	Wed,  3 Apr 2024 14:55:49 +0000 (UTC)
Date: Wed, 3 Apr 2024 16:55:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com,
	Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
Message-ID: <Zg1t8LFGiShcEWeX@hog>
References: <20240403113853.3877116-1-edumazet@google.com>
 <Zg1l9L2BNoZWZDZG@hog>
 <CANn89iL72ia+aCaRxPvBBaOcbKU_VTLZSPBjiUAQ14dhpSJrfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iL72ia+aCaRxPvBBaOcbKU_VTLZSPBjiUAQ14dhpSJrfw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-03, 16:25:47 +0200, Eric Dumazet wrote:
> On Wed, Apr 3, 2024 at 4:21=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
> >
> > 2024-04-03, 11:38:53 +0000, Eric Dumazet wrote:
> > > syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> > >
> > > Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> > > uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> > > skb->protocol.
> > >
> > > If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protoco=
l,
> > > pskb_inet_may_pull() does nothing at all.
> > >
> > > If a vlan tag was provided by the caller (af_packet in the syzbot cas=
e),
> > > the network header might not point to the correct location, and skb
> > > linear part could be smaller than expected.
> > >
> > > Add skb_vlan_inet_prepare() to perform a complete validation and pull=
.
> > > If no IPv4/IPv6 header is found, it returns 0.
> >
> > And then geneve_xmit_skb/geneve6_xmit_skb drops the packet, which
> > breaks ARP over a geneve tunnel, and other valid things like macsec.
>=20
> geneve_xmit_skb() uses ip_hdr() blindly.

Do those actually end up getting used? They get passed to
{ip_tunnel_ecn_encap,ip_tunnel_get_ttl,ip_tunnel_get_dsfield}, and
those helpers only look at their iph argument when skb_protocol(skb,
true) is ETH_P_IP or ETH_P_IPV6. So, definitely not pretty, but I
don't see a bug there. Am I missing something?

From a quick look, most users of those helpers seem to pass
ip_hdr(skb) (except for ip_tunnel_ecn_encap called from
ip_md_tunnel_xmit and ip_tunnel_xmit -- vxlan_xmit_one uses a cached
version but I don't think it's needed). Would it be less confusing if
we removed that argument and let the helper fetch ip_hdr?

--=20
Sabrina


