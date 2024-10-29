Return-Path: <netdev+bounces-140070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A3B9B5288
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F771C20EA2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA61E0B6C;
	Tue, 29 Oct 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhTVoqo+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457C190486
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229381; cv=none; b=hZqMbWuUFen4PRc/GAgcaxhuKJNOz1d/KpgBLLhzCh0AoD6F+fZiurZH6JAKRVBZEhVd502c9QNmqQYCb4EPBo6ZCD6ptfzRc5AEEzkhaZDNU/TK9tkECKytKgRtVJLoRRACxLycKRV11eGFs3AcGI0goHCPaOIq5V/xgGMOM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229381; c=relaxed/simple;
	bh=yyIp0yKiQu0rQxEWXOFSOiV8P7F5lVgpUjC5HgC5DiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1uPj70gRWVBdapMsyTmoVuf5vljfxSVsuHR+3La84Q5L0peZ0CIlyHhQd0Dv3m1WJq8zDUFGIXtad2c5jxPQUkIImEVdJVy1ZUo1ganOd6fHoRKCdJe26XEL5A1Yo5vDlQKExH4jbVqXdnjOsnY/XfOTbM2dG/AlPPnbgQ4qbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhTVoqo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60CEC4CECD;
	Tue, 29 Oct 2024 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730229381;
	bh=yyIp0yKiQu0rQxEWXOFSOiV8P7F5lVgpUjC5HgC5DiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HhTVoqo+U7EYXUV+DuqEQpdh+tXumRkMLNF4f1jAzyvDBDNJ59dMv1uKxCeoLwSs4
	 7XWT44o2kcaBUpuj8yQYS85qJfNmzGTjmlPZx3EVLm7frk6bezM7tVfK2Fqrs0cUcW
	 Gd6lssOYLK15Oi1rltVqvExqX+hT/tupCvewj4OZv2f5Z4XJCDXEx2MyoLK3bW/SlA
	 wTa+SH4E5IvEV3UCmDjCzfbNRs+DROFRWHy3dJVmd3/hk4hN1X6E7jsrtaVX8t45bw
	 jjCkI6FKjt/ter9zBPK1P0EhWrUK+E+uYNXBU2XyT2ERwxODrSQvqHmR/w6Y5/Tmk5
	 AMIwKmkKhycfQ==
Date: Tue, 29 Oct 2024 12:16:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Amit Cohen"
 <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 0/8] net: Shift responsibility for FDB
 notifications to drivers
Message-ID: <20241029121619.1a710601@kernel.org>
In-Reply-To: <cover.1729607879.git.petrm@nvidia.com>
References: <cover.1729607879.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 16:50:11 +0200 Petr Machata wrote:
> Besides this approach, we considered just passing a boolean back from the
> driver, which would indicate whether the notification was done. But the
> approach presented here seems cleaner.

What about adding a bit to the ops struct to indicate that 
the driver will generate the notification? Seems smaller in 
terms of LoC and shifts the responsibility of doing extra
work towards more complex users.

