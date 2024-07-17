Return-Path: <netdev+bounces-111874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192D933D94
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5297282257
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654771802B2;
	Wed, 17 Jul 2024 13:26:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721217E907
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222799; cv=none; b=ZHl8vxD60WJ5o+QTlUKrZ8CQJ97J16tsM5hKtgsxLbH7qR0MqDbwqKMyh6EQH3bDvyyCHqzIeN+AP7aRnJKK6FlCHh3gt123Oc/MadAcrfLZygXDoqqHTOOyj+d4bGafjs4+Ki07DKqZ6IVP3irT/NqdRVcYzk1LiqHOBYau13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222799; c=relaxed/simple;
	bh=5LCwPiKc6zNy+mcQ/5LraEI8W/UsHGqguoqNdwJpXaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aBNm9kQTUKN4iKVznaXaj1pEFUOQjwkL1L19NJRbEYEcSB5ADHdgBoKP0YnuE46UU+wIgWpdBcRo5OUjbq8ImbbLdWrX40ufRvS+dM8tbnGS9chHivo3CYI7cbIMMR2i8WXoJ5RZiLiZxcYtGYER/Ijf6pflaVkzHoCGowZWm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-zT2pYzR7PgmLFd4LAFaZ0Q-1; Wed,
 17 Jul 2024 09:26:32 -0400
X-MC-Unique: zT2pYzR7PgmLFd4LAFaZ0Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 529761955D5A;
	Wed, 17 Jul 2024 13:26:30 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 686B519560B2;
	Wed, 17 Jul 2024 13:26:26 +0000 (UTC)
Date: Wed, 17 Jul 2024 15:26:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 22/25] ovpn: kill key and notify userspace in
 case of IV exhaustion
Message-ID: <ZpfGgHOqgSc9vOnx@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-23-antonio@openvpn.net>
 <ZpegDb1F4-uBMwpe@hog>
 <b631abf1-b390-45fb-b463-ac49fec0fdfe@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b631abf1-b390-45fb-b463-ac49fec0fdfe@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-17, 13:03:11 +0200, Antonio Quartulli wrote:
> On 17/07/2024 12:42, Sabrina Dubroca wrote:
> > I don't see any way for userspace to know the current IV state (no
> > notification for when the packetid gets past some threshold, and
> > pid_xmit isn't getting dumped via netlink), so no chance for userspace
> > to swap keys early and avoid running out of IVs. And then, since we
> > don't have a usable primary key anymore, we will have to drop packets
> > until userspace tells the kernel to swap the keys (or possibly install
> > a secondary).
> >=20
> > Am I missing something in the kernel/userspace interaction?
>=20
> There are two events triggering userspace to generate a new key:
> 1) time based
> 2) packet count based
>=20
> 1) is easy: after X seconds/minutes generate a new key and send it to the
> kernel. It's obviously based on guestimate and normally our default works
> well.
>=20
> 2) after X packets/bytes generate a new key. Here userspace keeps track o=
f
> the amount of traffic by periodically polling GET_PEER and fetching the
> VPN/LINK stats.

Oh right, that's what I was missing. TX packet count should be
equivalent to packetid. Thanks.


> A future improvement could be to have ovpn proactively notifying userspac=
e
> after reaching a certain threshold, but for now this mechanism does not
> exist.

If it's not there from the start, you won't be able to rely on it
(because the userspace client may run on a kernel that does not
provide the notification), so you would still have to fetch the stats,
unless you have a way to poll for the threshold notification feature
being present.


> I hope it helps.

Yup, thanks. Can you add this explanation to the commit message for
this patch in the next version? Documenting a bit the expectations of
the kernel/userspace interactions would be helpful, also for the
sequencing of key installation/key swap operations. I'm guessing it
goes something like this:

 1. client sets up a primary key (key#1) and uses it
 2. at some point, it sets up a secondary key (key#2)
 3. later, keys are swapped (key#2 is now primary)
 4. after some more time, the secondary (key#1) is removed and a new
    secondary (key#3) is installed
 [steps 3 and 4 keep repeating]

And from reading patch 21, both the TX and RX key seem to be changed
together (swap and delete operate on the whole keyslot, and set
requires both the ENCRYPT_DIR and DECRYPT_DIR attributes).

A rough description of the overall life of a client (opening sockets
and setting up the ovpn device/peers) could also be useful alongside
the code.

--=20
Sabrina


