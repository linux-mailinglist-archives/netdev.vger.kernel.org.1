Return-Path: <netdev+bounces-120692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79595A3C5
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C184A283AB6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D11AF4F8;
	Wed, 21 Aug 2024 17:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DDB1494D1
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260868; cv=none; b=ADwHV4mL7/RpDL5kk5ubcudDYL+6wOO4RR8JmnlpBvtq/LjLjsJQD82iJ+SVM7Ia0/H0HJBix4ef+Ow0yfk9kxHp8r9B+JVbCHrx8QI2XrHUHgvbY5RwURCpsqrFDr6Wy3TJPj1GnqyUoWjGNgA1nVF82DP6CGwPBjyy6naj9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260868; c=relaxed/simple;
	bh=MIkn8YbMhcF7eIqC5aKnfC9QseQTTj9FZcBHM12OEg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y9FCQa5IWNUCcY6bPsF5H1Ji/uX3EkiPvKJbCg49Ca102O/D+zaJib22xeOgNkLXpj8PChLdA1aB68yFbz9rdrC0BhtaOZSm+T6pIoFrq6OosyboRWXSXhIV8cDT7b6Gqyn6tRPZMFoNprhoM5PYc3BXCMNwuIAhXQVurMvif1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-9Dx7hZ2oMWy1aA3hoAeXSQ-1; Wed,
 21 Aug 2024 13:20:55 -0400
X-MC-Unique: 9Dx7hZ2oMWy1aA3hoAeXSQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 726C41955F42;
	Wed, 21 Aug 2024 17:20:53 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E269219560AD;
	Wed, 21 Aug 2024 17:20:48 +0000 (UTC)
Date: Wed, 21 Aug 2024 19:20:46 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsYh7mXwIRDFnI2m@hog>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsXzlQQjMNymDkhJ@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsXzlQQjMNymDkhJ@gauss3.secunet.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-21, 16:03:01 +0200, Steffen Klassert wrote:
> On Wed, Aug 21, 2024 at 03:39:48PM +0200, Sabrina Dubroca wrote:
> > 2024-08-21, 21:26:00 +0800, Hangbin Liu wrote:
> > > On Wed, Aug 21, 2024 at 02:30:41PM +0200, Steffen Klassert wrote:
> > > > > > +/**
> > > > > > + * bond_advance_esn_state - ESN support for IPSec HW offload
> > > > > > + * @xs: pointer to transformer state struct
> > > > > > + **/
> > > > > > +static void bond_advance_esn_state(struct xfrm_state *xs)
> > > > > > +{
> > > > > > +=09struct net_device *real_dev;
> > > > > > +
> > > > > > +=09rcu_read_lock();
> > > > > > +=09real_dev =3D bond_ipsec_dev(xs);
> > > > > > +=09if (!real_dev)
> > > > > > +=09=09goto out;
> > > > > > +
> > > > > > +=09if (!real_dev->xfrmdev_ops ||
> > > > > > +=09    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > > > > +=09=09pr_warn("%s: %s doesn't support xdo_dev_state_advance_es=
n\n", __func__, real_dev->name);
> > > > >=20
> > > > > xdo_dev_state_advance_esn is called on the receive path for every
> > > > > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> > > > > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this need=
s to
> > > > > be ratelimited.
> > > >=20
> > > > How does xfrm_state offload work on bonding?
> > > > Does every slave have its own negotiated SA?
> > >=20
> > > Yes and no. Bonding only supports xfrm offload with active-backup mod=
e. So only
> > > current active slave keep the SA. When active slave changes, the sa o=
n
> > > previous slave is deleted and re-added on new active slave.
> >=20
> > It's the same SA, there's no DELSA+NEWSA when we change the active
> > slave (but we call xdo_dev_state_delete/xdo_dev_state_add to inform
> > the driver/HW), and only a single NEWSA to install the offloaded SA on
> > the bond device (which calls the active slave's xdo_dev_state_add).
>=20
> Maybe I miss something, but how is the sequence number, replay window
> etc. transfered from the old to the new active slave?

With crypto offload, the stack sees the headers so it manages to keep
track and update its data, so it should have no problem feeding it
back to the next driver?

Note that if something in that area is broken, it would be broken
regardless of ESN.

--=20
Sabrina


