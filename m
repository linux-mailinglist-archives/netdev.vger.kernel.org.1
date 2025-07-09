Return-Path: <netdev+bounces-205588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A208DAFF57E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D54E15BE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322D21D3C6;
	Wed,  9 Jul 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbnUUvkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE951B3925;
	Wed,  9 Jul 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752104827; cv=none; b=fXcxyp8lXERas4dRbbKq8tq1HEtGnneb3AriJrOCE2NzLw5jnUEYdSjktNCUVIdXMu5wpqdYrABPJH3+YKyAo2BNnSx1lOYs5WdXy3ZlzMNdjAMGEBO8LGxzOIWsHIq0VP/nrEAMWwXuGpF1Mga7m3JrODuZl+ZrJTRvNHQegJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752104827; c=relaxed/simple;
	bh=eIq0OFvNWB/Tp6MVf4iCCKg2VhT8N+pVSrssWB5jy4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuapcQ+KHQ3ZOlM7b5VbzsM6zfpsomAHpecZJDvkoQYOxGc5z2ub4PZPCJyCfpIAS+qvLJ5kPe0HOSOAeCdt+swl3oW47vMiJaRNcJSVU6+kFLy+rgQW1zZwiJnq6ikIeQpWSYEizY30STvugW6LjX8/iJEThyuZQCtOFsu4s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbnUUvkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C2FC4CEEF;
	Wed,  9 Jul 2025 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752104825;
	bh=eIq0OFvNWB/Tp6MVf4iCCKg2VhT8N+pVSrssWB5jy4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GbnUUvkh4ZDK4rJsFQGmlv9MD8Jtm9fcj6oNCAbzyHmId1DCIWL5zflGe1pzO3lBs
	 o6WdTgUP7UfJugJvr4maBCRN3awzayhv+EbPi3b7HLGUVWTP9zHFdEN9yalBvuQbej
	 nItQZ98NJVnLIOzXuk4SnrlliyFLSxta2Fst5ex0xBRjYWgl93RkMO5GVibfibLLxQ
	 JuhxXOvyQ9yLBrC5ioQOttDZt0eb3VmAEWV7Bs55kjG6ybp6Pp8VI3B3N2Wd4koU3Y
	 y1XW+6G5ABvmHT+JHTw7VeCpMZwwpeSdJSE2QVJyngmBWuntYT8l7lt3gVnDWpYn+H
	 0m1X5cgVqJeaw==
Date: Wed, 9 Jul 2025 16:47:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neill Kapron <nkapron@google.com>
Cc: netdev@vger.kernel.org, kernel-team@android.com, cmllamas@google.com,
 jstultz@google.com, Nick Hawkins <nick.hawkins@hpe.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Anastasia Kovaleva <a.kovaleva@yadro.com>, Jinjie
 Ruan <ruanjinjie@huawei.com>, Siddh Raman Pant
 <siddh.raman.pant@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC net] netlink: lock nl_cb_mutex in netlink_release
Message-ID: <20250709164704.4b0fcfff@kernel.org>
In-Reply-To: <20250708230513.42922-1-nkapron@google.com>
References: <20250708230513.42922-1-nkapron@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 23:04:52 +0000 Neill Kapron wrote:
> It is at this point after the netlink_dump() checks for cb_running that
> netlink_release() is called, which tears everything down. While the change
> in [2] clears cb_running, it does so without holding the lock. This causes
> the NULL pointer dereference in netlink_dump().

Closing a socket while it's being read is pretty unlikely for real
life processes. I don't think its even possible, but I'm not a VFS
expert.

AFAICT the crash is on:

	if (dev->dev.parent &&
	    nla_put_string(skb, IFLA_PARENT_DEV_NAME,
			   dev_name(dev->dev.parent)))
		goto nla_put_failure;

So my first suspicion would be dev.parent getting broken 
under our feet for the "special" device you're dealing with..

