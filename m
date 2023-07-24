Return-Path: <netdev+bounces-20513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5541075FDA6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE861C20BB2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9BF50B;
	Mon, 24 Jul 2023 17:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7791DF66
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11887C433C8;
	Mon, 24 Jul 2023 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690219662;
	bh=0og/bNUmA6QqIXBeUG9kfDyMSbAlo11LXSikr8aWDyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kNnnklHyknGtUzXHohAdU8aJfpKGyR4AL+HFasdicCdP5cN8YGJqdY9xA8YN1fUVa
	 0X6UR615yGjfbdlP4kZX4Nw2JGsl7xe/7t0EhCN0U+8OjBlCTAnWZp/yF5z6hLc4Z3
	 PO6+3n9BL9KRFID+N+hY1ra/UbQTyT2kRpMab4W9dHeJ+JMDZzxAxW6cM7CImV4dKG
	 kWvgjiY83a1jh9GtFhlrm6cGU6mEs1lHqt27pwaQxRrJmLsavtrsLhO4Zk8ai86Bwu
	 GP9DPXEkOd+NHNoo6/2SEB4X8tTqXYgLl7M9Xousy2WxbXXmapdA+ZTXbFWSbsl6xW
	 Na8xx3MwJeJYA==
Date: Mon, 24 Jul 2023 10:27:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 mkubecek@suse.cz, lorenzo@kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, Neil Brown <neilb@suse.de>
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
Message-ID: <20230724102741.469c0e42@kernel.org>
In-Reply-To: <2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
References: <20230722014237.4078962-1-kuba@kernel.org>
	<20230722014237.4078962-2-kuba@kernel.org>
	<20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
	<20230724084126.38d55715@kernel.org>
	<2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jul 2023 18:23:03 +0200 Paolo Abeni wrote:
> On Mon, 2023-07-24 at 08:41 -0700, Jakub Kicinski wrote:
> > On Mon, 24 Jul 2023 10:18:04 +0200 Paolo Abeni wrote: =20
> > > A possibly dumb question: why using an xarray over a plain list? =20
> >=20
> > We need to drop the lock during the walk.=C2=A0 =20
>=20
> I should have looked more closely to patch 2/2.
>=20
> > So for a list we'd need=20
> > to either=20
> >  - add explicit iteration "cursor" or  =20
>=20
> Would a cursor require acquiring a netdev reference? If so it looks
> problematic (an evil/buggy userspace could keep such reference held for
> an unbounded amount of time).

I was thinking we can add a cursor which looks like:

struct netdev_list_node {
	struct list head_list;
	bool is_a_device;
};

then iteration can put this struct into its dump state and insert
*itself* into the device list. All iterations will then have to:

	struct netdev_list_node *lnode;

	list_for_each_entry... lnode) {
		/* skip cursors inserted into the list */
		if (!lnode->is_a_device)
			continue;
		netdev =3D containerof(lnode);

		...
	}

But then we need to add some code to .start and .stop callbacks
and make sure the "cursor" is removed if someone closes the socket
half way thru the dump.

> I agree xarray looks a better solution.

I do think xarray is the simplest solution.

> I still have some minor doubts WRT the 'missed device' scenario you
> described in the commit message. What if the user-space is doing
> 'create the new one before deleting the old one' with the assumption
> that at least one of old/new is always reported in dumps? Is that a too
> bold assumption?

The problem is kinda theoretical in the first place because it assumes
ifindexes got wrapped so that the new netdev comes "before" the old in
the xarray. Which would require adding and removing 2B netdevs, assuming
one add+remove takes 10 usec (impossibly fast), wrapping ifindex would
take 68 years.

And if that's not enough we can make the iteration index ulong=20
(i.e. something separate from ifindex as ifindex is hardwired to 31b
by uAPI).

