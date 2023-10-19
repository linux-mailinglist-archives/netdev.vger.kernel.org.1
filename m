Return-Path: <netdev+bounces-42514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BE7CF19E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D63B20E85
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD52DDAB;
	Thu, 19 Oct 2023 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgmQvj/X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04388F62
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 07:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B947AC433C8;
	Thu, 19 Oct 2023 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697701651;
	bh=iXuRg5IWUuaGs0z3tYPAfinfJCjonPHZy8dgncX/kds=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fgmQvj/XZLCBadUjYFl0P8UWVMYFJxI56W30qtECR/nFqWc6ClkjkeYfCMDepKbX0
	 S4XVi7MvrvB5BAWnu3TrnVdtXqgHAgmbs9bXXsV++G6dI7Aeetzi27u/bbnnKXzeYT
	 bwS4YLrTQMfQ0B3AUsrp3+NtPKQcIXUoFFfAw8pxjCsCeHSDZDhVzF5KJSiNCrVgJh
	 T4eCVln1FiksR7zcE0kinV2iS0702Z0N/Q5CP5itI5e9R8iRBuPg5e0OrDVpsxYTEW
	 TTxhjWcisRbwYt0sZb7Ska2nvBdhC6kTLNx5l7cXdCklBHUNoXqG3jsDAb0Sj+qBfS
	 sJQF3q2i98VIA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231018111547.0be5532d@hermes.local>
References: <20231018154804.420823-1-atenart@kernel.org> <20231018111547.0be5532d@hermes.local>
Subject: Re: [RFC PATCH net-next 0/4] net-sysfs: remove rtnl_trylock/restart_syscall use
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 19 Oct 2023 09:47:27 +0200
Message-ID: <169770164786.433869.13558540630519879540@kwain>

Quoting Stephen Hemminger (2023-10-18 20:15:47)
> On Wed, 18 Oct 2023 17:47:42 +0200
> Antoine Tenart <atenart@kernel.org> wrote:
>=20
> > Some time ago we tried to improve the rtnl_trylock/restart_syscall
> > situation[1]. What happens is when there is rtnl contention, userspace
> > accessing net sysfs attributes will spin and experience delays. This can
> > happen in different situations, when sysfs attributes are accessed
> > (networking daemon, configuration, monitoring) while operations under
> > rtnl are performed (veth creation, driver configuration, etc). A few
> > improvements can be done in userspace to ease things, like using the
> > netlink interface instead, or polling less (or more selectively) the
> > attributes; but in the end the root cause is always there and this keeps
> > happening from time to time.
>=20
> What attribute is not exposed by netlink, and only by sysfs?

I think there were a few last time (a while a go) I checked, but it's
not an issue IMHO, if one is missing in netlink we can add it.

> That doesn't mean the locking should not be fixed, just that better
> to avoid the situation if possible.

100% agree on this one. I believe using netlink is the right way.

Having said that, sysfs is still there and (quite some time ago) while
having discussions with different projects, some were keen to switch to
netlink, but some weren't and pushed back because "sysfs is a stable
API" and "if there is a kernel issue it should be fixed in the kernel".
Not blaming anyone really, they'd have to support the two interfaces for
compatibility. My point is, yes, I would encourage everyone to use
netlink too, but we don't control every user and it's not like sysfs
will disappear anytime soon.

Thanks,
Antoine

