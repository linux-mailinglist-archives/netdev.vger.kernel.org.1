Return-Path: <netdev+bounces-203488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59965AF610F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B01C40B73
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8F30E85F;
	Wed,  2 Jul 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjUhxg0h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBD19A;
	Wed,  2 Jul 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480569; cv=none; b=HoOuDVzR4Q/S0CsoX8ZGJdcZ9orfrfh5vWUT9yb4yJaLERelKHjzjjPoOrz9ixZtVjQLdY2fqTdDhdcpehPca6+s/ses9QOTjKM3ynA1p05ynA/JzldiF4x6M/Gu/Xlr1LU1mk1VrYeEa2hvm6M47Fr/BwskkFcL4COmEfLd3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480569; c=relaxed/simple;
	bh=VCsyREOaKbQLunCJwY7sWxTPIEdDiNp3Ki+c4YiDGXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpTK6yyKNDzIycvHew4OWTvQf1h2kv4llD4mOL/vPi+AksJ5g7YeJXlEa8178ZfoeuPX5gRZa2FLDJUs3ROawY76tJ0IbcEzbGAqHuwOAtcFQVVkcJ5zJNAKCr7lgbg3aeA7yUCP2aIe/QOLUBQtJQiIZYMoe/bxOyEIjHX9je8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjUhxg0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1091C4CEE7;
	Wed,  2 Jul 2025 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480569;
	bh=VCsyREOaKbQLunCJwY7sWxTPIEdDiNp3Ki+c4YiDGXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LjUhxg0hnWkoHhrrlqhuCd4NUMAADZ5xzyQZVs5iLL07NyTc7gtu0o0HnBEGwBAec
	 /0UhsR/EMjx7i9liGvuB9RwtZzdgLOVHgIMU+Jh2C/FtXqOupMiUOHz0Xy4FmhHKfZ
	 x0hkx1FaG41kgKA9jN7E/kINmbxJVCzFnSQ5Zmqh+VL2b351OouJrVTZkhCxxqezrJ
	 Yco/yiSz5t/7iW4+TGiDbKsoBLm493981Qy0UW0Gj6KDE4NcWYbWPgJDv2I7dEZtoM
	 TJfku8eYmLbiuoL8dqBU6lqqwxU/bYnIh9t7yVtw1VgBCSMQtwEK0v7ggHAEp8Niz2
	 diBpsOLV0p2bQ==
Date: Wed, 2 Jul 2025 11:22:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "Peter GJ. Park"
 <gyujoon.park@samsung.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ming Lei <ming.lei@canonical.com>, Ming Lei
 <ming.lei@redhat.com>
Subject: Re: [PATCH] net: usb: usbnet: fix use-after-free in race on
 workqueue
Message-ID: <20250702112247.79e0556f@kernel.org>
In-Reply-To: <560fa48a-7e0b-4b50-bebb-b3600efaadd3@suse.com>
References: <CGME20250625093354epcas1p1c9817df6e1d1599e8b4eb16c5715a6fd@epcas1p1.samsung.com>
	<20250625-usbnet-uaf-fix-v1-1-421eb05ae6ea@samsung.com>
	<87a7f8a6-71b1-4b90-abc7-0a680f2a99cf@redhat.com>
	<ebd0bb9b-8e66-4119-b011-c1a737749fb2@suse.com>
	<20250701182617.07d6e437@kernel.org>
	<560fa48a-7e0b-4b50-bebb-b3600efaadd3@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 12:54:23 +0200 Oliver Neukum wrote:
> >> I am sorry to be a stickler here, but if that turns out to be true,
> >> usbnet is not the only driver that has this bug.  
> > 
> > Shooting from the hip slightly, but its unusual for a driver to start
> > link monitoring before open. After all there can be no packets on a
> > device that's closed. Why not something like:  
> 
> It turns out that user space wants to know whether there is carrier
> even before it uses an interface because it uses that information
> to decide whether to use the link.
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=444043

Ah. We should totally move the carrier clear _prior_ to registering 
the netdev!

> However, it looks to me like the issue is specifically
> queuing work for kevent. That would call for reverting
> 0162c55463057 ("usbnet: apply usbnet_link_change")
> [taking author into CC]

Hm, spying on git logs I think Ming Lei changed employers from
Cannonical to RedHat in early 2017. Adding the @redhat address.

