Return-Path: <netdev+bounces-114745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F383E943C42
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FFE1F242F5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A203B14B975;
	Thu,  1 Aug 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVpREob/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670314B96B
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471406; cv=none; b=tB032VDpdkbw2yPXPzk7I2ZQj8R30I7FQvwKxPlvRYtuA+P5h6j+3Q4kW4A/jRVtoZt+O+STpXBfgIM7NUXerBUbYwyx0+yc9yZuUt9sHxdSDI8ILQ4Sc/v7tE2SS1AbYNscXFJ8QdxqLNdBK8oNeYjtKKSOqIWNSH4Zp8tEIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471406; c=relaxed/simple;
	bh=uCnRplBQy3ytptaYNFNFMJqVxI5cn4hPXzO1psMTX4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7Uxr4dhAZ6v8FnTv1lEM9va1YVdSbE6lMtcN2+IM0d7xsLim5WIfiJC8woZzlx0R/9ngKMhgGnPLCxt+WwQRYucf3k1bQutpXtdNimc01RUoahMJOvVlw3faT3qjgVAYL5bjsvrMv5OxKuLEF3CWdMfBHUc5lGG7QTvQUdmsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVpREob/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD30C32786;
	Thu,  1 Aug 2024 00:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471406;
	bh=uCnRplBQy3ytptaYNFNFMJqVxI5cn4hPXzO1psMTX4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gVpREob/ysbl7WVR/Dno4ev8zXriDeY1TtQw2V6owk1lQhX26vvu4ZYkxzqL2b45r
	 NS26FRiV0LuJICoYc0W9SDoDqrMv6cqUGmS2hSEYkRKt8S6DO6oHWehE+4sxm/kPny
	 h2hJ3DU5Y/mUN6LxJjetubEAhZa9GMQhNh7VfkULuMvI7Nq83Avf8qIysPX/9XSu/W
	 +UgartETZ8su60cnTOkYkCvC8DB4YsGdd3Zd+xSviP2/041B+CZFX9UlBg9SGj4dIE
	 SbWEd/I0jin9n+ZqgGKxHPAubu7I5PiaEOF6yRDH5L6KywEuqy3zeE3BLaUeoHrTgE
	 +LBwCP0G/waiw==
Date: Wed, 31 Jul 2024 17:16:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof =?UTF-8?B?T2zEmWR6a2k=?= <ole@ans.pl>
Cc: Ido Schimmel <idosch@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>,
 Andrew Lunn <andrew@lunn.ch>, Moshe Shemesh <moshe@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com, Dan
 Merillat <git@dan.merillat.org>
Subject: Re: [PATCH v2 ethtool] qsfp: Better handling of Page 03h netlink
 read failure
Message-ID: <20240731171645.3a76d780@kernel.org>
In-Reply-To: <d232ddce-ec6a-4131-bf47-04ffe5a74557@ans.pl>
References: <0d2504d1-e150-40bf-8e30-bf6414d42b60@ans.pl>
	<Zqnz1bn2rx5Jtw09@shredder.mtl.com>
	<d232ddce-ec6a-4131-bf47-04ffe5a74557@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jul 2024 06:58:08 -0700 Krzysztof Ol=C4=99dzki wrote:
> > Nit: No blank line between Fixes and SoB, but maybe Michal can fix it up
> > when applying =20
>=20
> Ah... thanks. :/
>=20
> Michal, please let me know if I should send a v3 or if you can correct th=
is issue.

We haven't heard from Michal in a couple of weeks, I recommend you
correct and repost this one :(

