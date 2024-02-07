Return-Path: <netdev+bounces-69877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27684CE6D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3103A1F23C8A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5A97FBC9;
	Wed,  7 Feb 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsZXxawd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B57E775
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321196; cv=none; b=LfV+LD5AkDbtYFGZH8tERJM5aCn08sFmEmslSzn4wIMG98uARo5jRtbgOqSR0q/nKbo7BnQ5gY4bap9ElCCciPe2JVVXDrJx/y8FRyoz/IhlmWCgraf2KVotIESm/nKT+CjyXJfERIjrBwEuG625OjiXmMH6GHpmk55QM8X2Cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321196; c=relaxed/simple;
	bh=NkdMDw0u5nZZCGQMBtc/IR+YcuOIVLU1n3HZwh763RY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+Sfk5FnWFlji2iUgg/tJ0luaQ6SOaU4Wgt5/7WrbC7+k91KE2/oY6kc25HoiDIvNqvXxH4/ES4RJXlsH3jxQv3iBXXtx0iwgZwgn8nX+0QV6iB0UThUUfBy9d43uqyQytkp/MZ4cbzeZfqY83Z1fqKiJtqwdSu3D0/yTS+YDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsZXxawd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CAC433C7;
	Wed,  7 Feb 2024 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321195;
	bh=NkdMDw0u5nZZCGQMBtc/IR+YcuOIVLU1n3HZwh763RY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WsZXxawdVwxBcIFGKCg6t3vbDWBrhC27YoaQ6OHOmBK3JnV1+PBqv0Ccocps4hrMO
	 TVGM0/fvoajS46EYrCn+7JeJKGAwT32C/LyFKmqo0PdBhWIxCUIOo87eHLyKk2tbD+
	 +lMMZWmOjAT41Rt+vyHAtp90ylMsL3ii08TcPjtNfeBMkDbUQiEjIuytAwgoFeGXvD
	 ZOfByKfhZ2LHl3tPGUbjM4sBYb8wtvCmnimsB/SsU8WGHfa6Hy72eGLmqaNO5qFiYW
	 LLGMqcccrfui6df+jvL/yUSan1mGxwHBDs048ao4cx/j4EN5/i4h0PVIqU7ckunImz
	 XtVfVMTMq0OhQ==
Date: Wed, 7 Feb 2024 07:53:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Igor Russkikh <irusskikh@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: atlantic: convert EEE handling to use
 linkmode bitmaps
Message-ID: <20240207075314.5458bd68@kernel.org>
In-Reply-To: <2046e53a-6de4-41e0-b816-3e7926ad489b@gmail.com>
References: <7d34ec3f-a2b7-41f5-8f4b-46ee78a76267@gmail.com>
	<c7979b55-142b-469b-8da3-2662f0fe826e@lunn.ch>
	<2046e53a-6de4-41e0-b816-3e7926ad489b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 07:52:49 +0100 Heiner Kallweit wrote:
> > This is again a correct translation. But the underlying implementation
> > seems wrong. aq_ethtool_set_eee() does not appear to allow the
> > advertisement to be changed, so advertised does equal
> > supported. However aq_ethtool_set_eee() does not validate that the
> > user is not changing what is advertised and returning an error. Lets
> > leave it broken, and see if Aquantia/Marvell care.
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> This patch was by mistake set to "Changes requested".

It's because of the comment about zeroing, not the latter one.

Sorry, it's impossible for me to guess whether he meant the tag
for v2 or he's fine with the patch as is. Andrew has the powers
to change pw state, I'm leaving this to him.

