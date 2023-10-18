Return-Path: <netdev+bounces-42307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5F7CE2D0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038371F225C0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D1341A1;
	Wed, 18 Oct 2023 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCJ1P+kR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE63D3A9
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA4CC433C8;
	Wed, 18 Oct 2023 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697646868;
	bh=ZZXDxCp17+VfW9J5pkXtqffD6VUVgGD9+E3fbOncF+E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kCJ1P+kRGJc51olq/AknkDzgqmkPFf/K3g1R+lToDxApECI+7PNJ2YJLwYmdQeqrM
	 45GKsxXaEv8GJuIVDnFo6kepn6OiW4IHWPw4GU3zsyQ7M4zpRPiIo24IJ/hZcxpILw
	 UoUSYcLCdrLo3L5T190v53cDw2QdNc+ZJ7/TxQTapUeHiLEFKxb4iFqaEurWCbfCRw
	 YoanTY4VmYW9psKH4MeUlqPvRD8iCwmYf9AfULLK9nfh/wNKaD+mEhPLzTubpUsJ+U
	 dXAmiFFaxTLx13kwBTvZBpBfriBe8YCbQegRnmNpivY+Qi/6/hc5adKmCeyc53phlZ
	 b7GOeaWWHoIuw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231018085717.454931c3@hermes.local>
References: <20231018154804.420823-1-atenart@kernel.org> <20231018085717.454931c3@hermes.local>
Subject: Re: [RFC PATCH net-next 0/4] net-sysfs: remove rtnl_trylock/restart_syscall use
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 18 Oct 2023 18:34:26 +0200
Message-ID: <169764686602.6041.3041045279733408955@kwain>

Quoting Stephen Hemminger (2023-10-18 17:57:17)
> The trylock was introduced to deal with lock inversion.
> It is not clear how this more complex solution prevents that.

Anything specifically in the patch 1 comments is not clear that I can
improve?

The dead lock happens between rtnl_lock and the refcounting on the
attribute kn->active, specifically when unregistering net devices
because device_del kernfs_drain will wait for the kn->active refcount to
reach KN_DEACTIVATED_BIAS, under an rtnl section. The current solution
was making one path to bail out (trylock/restart syscall).

The idea here is we can actually bail out of the attribute kn protection
(kn->active), while still letting unregistering net devices to wait for
the current sysfs operations to complete, by using the net device
refcount instead. To simplify, instead of waiting on kn->active in the
net device unregistration step, this waits on the net device refcount
(netdev_wait_allrefs_any), which is done outside an rtnl section. This
way kernfs_drain can complete under its rtnl section even if a call to
rtnl_lock is waiting in a sysfs operation.

Antoine

