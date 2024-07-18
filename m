Return-Path: <netdev+bounces-112090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F151934E6C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2C0B20CEE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4397D13DB9B;
	Thu, 18 Jul 2024 13:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3A13DB99
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310066; cv=none; b=q+6gHV9BVJeAKZJ04QURVvow7x3ZlY7HSYz9OdK20yX7GCxeg6BQ9NYStDhaofJJWA5M+vjAPm5bv/esKz0GLAPYonifJeMYKYf6ZqGEXsBU09JMyyfIThJYSXn6jVrrYiDNQHzbVWzA7uXwgM8OUGw7/MiKlkROhNd+zcjA39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310066; c=relaxed/simple;
	bh=MMCeEYB52ITuAGhmv/OFNmDFcNoDpb0zEWbYshCJCpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C1Bi0N2IkOwKpRUoMKVzvB/0Ib1FluBi5uImcZka87+s8jfOwH2SP7z/sDN1SfXfC2C7pOXBvNnzzRPGIWaAwgqr6hoXaHLBuqlmAJiYb1MYMF0DHy5PQKHFtL2uZbgwjzEwYgqaWH+MghQ2YvFv/pcRTEz5Db6erZTkP1YOGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-L7TZSrDfO-qgQNQK9npYfA-1; Thu,
 18 Jul 2024 09:40:53 -0400
X-MC-Unique: L7TZSrDfO-qgQNQK9npYfA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7220E19560B3;
	Thu, 18 Jul 2024 13:40:48 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D154019560AA;
	Thu, 18 Jul 2024 13:40:44 +0000 (UTC)
Date: Thu, 18 Jul 2024 15:40:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
Message-ID: <ZpkbWoW4FlzDDuyp@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net>
 <Zj4k9g1hV1eHQ4Ox@hog>
 <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net>
 <Zpjyg-nO42rA3W_0@hog>
 <10c01ca1-c79a-41ab-b99b-deab81adb552@openvpn.net>
 <ZpkUfMtdrsXc-p6k@hog>
 <80351026-0d15-460a-8002-4b24b893fefa@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <80351026-0d15-460a-8002-4b24b893fefa@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-18, 15:27:42 +0200, Antonio Quartulli wrote:
> On 18/07/2024 15:11, Sabrina Dubroca wrote:
> > > basically the idea is: with our encapsulation we can guarantee that w=
hat
> > > entered the tunnel is also exiting the tunnel, without corruption.
> > > Therefore we claim that checksums are all correct.
> >=20
> > Can you be sure that they were correct when they went into the tunnel?
> > If not, I think you have to set CHECKSUM_NONE.
>=20
> I can't be sure, because on the sender side we don't validate checksums
> before encapsulation.
>=20
> If we assume that outgoing packets are always well formed and they can on=
ly
> be damaged while traveling on the link, then the current code should be o=
k.
>=20
> If we cannot make this assumption, then we need the receiver to verify al=
l
> checksums before moving forward (which is what you are suggesting).
>=20
> Is it truly possible for the kernel to hand ovpn a packet with invalid
> checksums on the TX path?

The networking stack shouldn't generate packets with broken checksums,
but it could happen. On a VPN server that's giving access to an
internal network, I think the packet could get corrupted on the
internal network and may be pushed without verification into the
tunnel.

It's also possible to inject them with packet sockets for
testing. Using scapy to send packets over your ovpn device should
allow you to do that.

--=20
Sabrina


