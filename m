Return-Path: <netdev+bounces-247245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BECF655E
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90F430B8FDF
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637D1F8BD6;
	Tue,  6 Jan 2026 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdGrh63i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C701F419A;
	Tue,  6 Jan 2026 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661135; cv=none; b=Mz0iX7uUoeDjJY7QfBLOeb4jvA54JQYWDKP1JQucsqXEgUcZNJoFDyQ7WMDPbC4+1JXVEWM+8wuNBKDD2Y5nXoO7eKcyzY5axEvAFBzQwSMRuZqP2ePfykGWAhD/Q/C74fi4PGenrgniyK0MYpISNKnY6uPjXYrKFbsyhPSa09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661135; c=relaxed/simple;
	bh=meaX3T05mdpT0PQJTDH++lhps9zyTEViUIHEw02+/Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEWt5k6n7pd73PG3t91CEd8LvXBHVhDyCVK1ndql02Ao13uCSaO3dZhk3EjH7+4OYxt52TTehGsAOgW5HXlXqiBzRzvaILO9TXM5nmXznWXAlC/4fT3RF/v8Ho5bMTfW4onW4KzRxfU7raVJtWy95eud+KKEQQQ4ruxeeC3xdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdGrh63i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72FAC116D0;
	Tue,  6 Jan 2026 00:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661135;
	bh=meaX3T05mdpT0PQJTDH++lhps9zyTEViUIHEw02+/Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdGrh63iOgtBeen2Y3/0xYlb9CxxWDxgU/CeGRNfS5aHp5mdbLhHKeBXLP3ciWtbN
	 RLtVQ6JVA0n6EGGEivIGZj9tNURqBlFa3QeV35MLmcOYlr/LVWPcJoPlDW9335lZlL
	 AMkQ8dWVjrr997H4tClzUx2KwQe8qeucYvEEFWCETVV7Jq9YDN7hVP21Oqs1GKZBik
	 SzfZ5MLFtJA6+mzW2jEEP/dAegZ6nlUCRaQ+PX4Asfy7OAMfcTAkUjukirtWiLwHf2
	 i3Nd5WCBVcIoeiVtTOyR0ch8O6gnpu9RjdwANfkoht35wKK6HZKadRc7FEalnhRQdQ
	 /724uhBkBrpvA==
Date: Mon, 5 Jan 2026 16:58:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dlink: mask rx_coalesce/rx_timeout before
 writing RxDMAIntCtrl
Message-ID: <20260105165854.104e6c1d@kernel.org>
In-Reply-To: <20260103092904.44462-2-yyyynoom@gmail.com>
References: <20260103092904.44462-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Jan 2026 18:29:05 +0900 Yeounsu Moon wrote:
> RxDMAIntCtrl encodes rx_coalesce in the low 16 bits
> and rx_timeout in the high 16 bits. If either value exceeds
> the field width, the current code may truncate the value and/or
> corrupt adjacent bits when programming the register.
> 
> Mask both values to 16 bits so only the intended fields are written.

Realistically IDK if this is worth it.

Paolo suggested in discussion on v1 that error checking could introduce
a regression. If we take that concern seriously we can't change the
(buggy) behavior at all.

That said the overflow is on frames, for values > 64k and the ring is
256 so IDK how high values could possibly work here in the first place.

Given this driver is using module params to configure coalescing I'd
just leave this mess be. If you add ethtool configuration for
coalescing make sure to correctly bound-check it.
-- 
pw-bot: reject

