Return-Path: <netdev+bounces-132924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF25993BC4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192251C246DB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DA8488;
	Tue,  8 Oct 2024 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8+a4Syx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A06AA1;
	Tue,  8 Oct 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347237; cv=none; b=TTcGNL0D19pClED2m0WL51JRJihQ0IF6serGP/Azx/XUu0L68xlMmBbR6LDsxqdvIjikOx82I6uG9km9GjQuxOblhLZuPa4CqUlEU2J8rOtIEHOydcNa+estAu0DXaYeT/vUdOy/ezOWYQ0CcjUtjuyZrzgEMCgbkobkHx8Sz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347237; c=relaxed/simple;
	bh=9ckwQwJYGFfdEsVWgHL6UxfIO2okKG7QZhUNQy9R3nY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4KdylV7jDMYnvGsdlmmczg4uiPk5laMb/ZvNhEG6c6FPPqGmtXeRtO/xVXfHLrS79sApWI5L10EZWTy5ZRydu0luSKwEJu2qiUGwrrhPyf9Cx7z3dA6kRKQYtkA0unCX9Y0lbGhz8C0u5QDRct2DuPpnJzZW4Kxx4sufxnjLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8+a4Syx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A4AC4CEC6;
	Tue,  8 Oct 2024 00:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728347236;
	bh=9ckwQwJYGFfdEsVWgHL6UxfIO2okKG7QZhUNQy9R3nY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8+a4Syx4JSjL7Uo/tA30qb7Al/PQ1Em05CSpt/NmetpT0pJKJJfM1WAvsMW4y2+Z
	 9Rys3VfrzSfvi6mGZPyX8aQqzGsCrB+pb3j1hCnuzeayA4733APuy1f9la52xAFrkQ
	 4QHCe/lTJdMY5TIDHvRbQLHtp7nue+M5/PcHz/MTYIFMSfGZ+3mGKZOu/WcBt4IIBO
	 RG8vKNiySc91BsGkF40dvQsW+vFW2+kXwT3U4VbhCsitv4IGGRYUfw5oRHdJdJOaTG
	 Lpr+u9R/YIWeiKkw9WcdSqVK/veK2LJ4uho+KTcGA9HLTL0L5RXY7cNIHofyZXCEhN
	 6ztJqgrWjAl+w==
Date: Mon, 7 Oct 2024 17:27:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 deeb.rand@confident.ru, lvc-project@linuxtesting.org,
 voskresenski.stanislav@confident.ru
Subject: Re: [PATCH] drivers:atlx: Prevent integer overflow in statistics
 aggregation
Message-ID: <20241007172715.649822ba@kernel.org>
In-Reply-To: <20241007092936.53445-1-rand.sec96@gmail.com>
References: <20241007092936.53445-1-rand.sec96@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 12:29:36 +0300 Rand Deeb wrote:
> The `atl1_inc_smb` function aggregates various RX and TX error counters
> from the `stats_msg_block` structure. Currently, the arithmetic operations
> are performed using `u32` types, which can lead to integer overflow when
> summing large values. This overflow occurs before the result is cast to
> a `u64`, potentially resulting in inaccurate network statistics.
> 
> To mitigate this risk, each operand in the summation is explicitly cast to
> `u64` before performing the addition. This ensures that the arithmetic is
> executed in 64-bit space, preventing overflow and maintaining accurate
> statistics regardless of the system architecture.

Thanks for the nice commit message, but honestly I don't think
the error counters can overflow u32 on an ancient NIC like this.
-- 
pw-bot: reject

