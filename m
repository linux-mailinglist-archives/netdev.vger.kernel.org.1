Return-Path: <netdev+bounces-66266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D0483E27F
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379FEB241F7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F822313;
	Fri, 26 Jan 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBncn/Hx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAC224C9
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297311; cv=none; b=bCa7wddjaLVeN5QKuEhVcNna2Z+I9qZChOdN3bXDx0B7fmEZZu5Zm+Ov2csvOA1C5TofnhPaU2RLIdvbEa4Hwjluuuzx+Iohr+NwUur/WNlTIdp8mS/pekZQQcwsXe/UqRanTQcnJhZF767875L93lrxXrAkNvtH4MH5R9etwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297311; c=relaxed/simple;
	bh=7974xib4xeSwplcx7sKFjHDlYKJEpvVlCDf64+oeaXo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcd2jL/QAav7t41iSh9Go3Tjt9DKtp30cM/Rk5WuWL26kfFLHYeBkA+9c7WPtlSijtOIrFT+ot8jkUGN/MmAErgNOMtiC9jXoQh3Dt9vz78Q0xsmO41MDzooc1ta/3serL8AP4VToHzdHyO2msW+qIEqaSysF6uSBt414K14QgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBncn/Hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67262C433F1;
	Fri, 26 Jan 2024 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706297310;
	bh=7974xib4xeSwplcx7sKFjHDlYKJEpvVlCDf64+oeaXo=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=BBncn/HxRpgmvbQDtBDNtWACGpfrJMR9Grp24xzTIkWa246DAJUgazQ+iP0bBMGf5
	 V0eaeNdCtMWqZiKb0l7tMnLT/pfu05Nh7O2b6I0tIy96Xvvukl9vdq5hXMglx4J6Xx
	 +kcHy7DL8wfyNsFj3g6BxIesGPvD/QBHwHKgHBEuhDDNvllcXJUiUWMfafzYxGFZqG
	 BYoXlgkeZp2nXHBMwLHzqkIGiTOiXM/FeuWdvyt4MxtCjKCl56oNGRtvYX00Bw8EYn
	 VfexapbFYnZLB01taEyKOfvDrofcpseY891ImpsX5OEQQCnXqo6pceNpGz/oZeDux0
	 /jcFf7CNqUFwA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AF8751089B3A; Fri, 26 Jan 2024 20:28:27 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Pavel Vazharov <pavel@x3me.net>, netdev@vger.kernel.org
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind
 a Linux bonding device
In-Reply-To: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 26 Jan 2024 20:28:27 +0100
Message-ID: <87y1cb28tg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Vazharov <pavel@x3me.net> writes:

> 3. If the above scheme is supposed to work then is the bonding logic
> (LACP management traffic) affected by the access pattern of the XDP
> sockets? I mean, the order of Rx/Tx operations on the XDP sockets or
> something like that.

Well, it will be up to your application to ensure that it is not. The
XDP program will run before the stack sees the LACP management traffic,
so you will have to take some measure to ensure that any such management
traffic gets routed to the stack instead of to the DPDK application. My
immediate guess would be that this is the cause of those warnings?

-Toke

