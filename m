Return-Path: <netdev+bounces-198181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36E7ADB7EF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6293416E66E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E91287513;
	Mon, 16 Jun 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSmYzZvx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BD20AF67;
	Mon, 16 Jun 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095980; cv=none; b=AA3IvIsmB2Z3x2hlmuXIJGY8HUnY4nYxfMhztmT5qEi6BP7HgmGOy4A/ORqnixLDlRKxgU3OlIOKFSVdl0VH7bHuWh/Go4tRrI20zfLQxcU8d4XWMKepwpdYDXGwWKlhVr3egBfhnSdukGnMq2wyC6eTPC97tSp+mNja6oiiuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095980; c=relaxed/simple;
	bh=kWGrpLZraXC7+p6qSKRiuX7ZjGyPfYPnOwIuMV15KTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+YCOugVg+Xvot16PZ7kw2j2wMfZ3xoOS9VsgNIPCCO5mxXVVJ9ZtZV274/P7KCrw/DPqlYN8F6kgkc6at0eQ1dp9Xpx6vqbYPyMZftctrWAC9umdmZgo7xnHki9eZd+bfKcXzvdXJqs024J67t+2GED4fWcEjIqd/Fje8Zglc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSmYzZvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD464C4CEEA;
	Mon, 16 Jun 2025 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750095980;
	bh=kWGrpLZraXC7+p6qSKRiuX7ZjGyPfYPnOwIuMV15KTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hSmYzZvxoxkW16yhO57cY15DqUkNZeu2LDg7sP1R8zblMqzAIt7hv1GH3iI1iK37J
	 4+Il2YKncOlhoBQxX9iEArgY49dMXgaHzpUx/I3aIhhagbKtf97pvKlPRujUM+LJ+K
	 76Ys8nTssjpUvvwKJenqBtoVSLTaZQvfKX6Lvd4Bum+uWUWRtviaLjc7IMwhm7JA0J
	 pOXxGMdO66JRlA4d4P+PxQeX0gbwIzAFvyJzDiaRSgVbi9xOVmyI42eKLUdaPYEb+W
	 9bWKk71rfH+oCAIs84FRmQrBG4MyiWoDaO5tPXPV2N+KmckZmEwnom0EWBI9K5rWas
	 XXUZwCCn8qVuQ==
Date: Mon, 16 Jun 2025 10:46:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jeff Garzik
 <jeff@garzik.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethernet: alt1: Fix missing DMA mapping tests
Message-ID: <20250616104619.75f4fd74@kernel.org>
In-Reply-To: <20250616140246.612740-2-fourier.thomas@gmail.com>
References: <20250613074356.210332b1@kernel.org>
	<20250616140246.612740-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 15:59:55 +0200 Thomas Fourier wrote:
> According to Shuah Khan[1]

Sorry for a non-technical question -- are you part of some outreach /
training program? The presentation you linked is from 2013, I wonder
what made you pick up this particular task.

