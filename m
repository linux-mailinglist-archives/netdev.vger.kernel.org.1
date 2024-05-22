Return-Path: <netdev+bounces-97572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 731688CC2AB
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D581C22ADE
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0F1411E0;
	Wed, 22 May 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuFOrhMx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4D1411D2
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386152; cv=none; b=AHNJgB4DQ3hDEH3KGF8B9TKMrc551ssS/bAzXIRoS9mj5pgT1YUf1TiS90D6wMVZprcIbabuALp+olmwUHSw1+ADEguJ31wGZjRAw9YAzH9AsS7fgLP/lT/HUCwS+70CpjFqrxzISeKayDCoxGe0D5ahDtFS5BdL28QfWgogkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386152; c=relaxed/simple;
	bh=+tMwcoL79gLi0nujiJ3sXxygAakt7dyZpS/QD3y71Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THz3E03Zq25Hj9Bj2RUIYcUqXDGohtTovhkl9dqdveSE3Da8WyMpaxgal3ip7R+pIiKePmNtaSAkvuPXlESEVabvcse04LDxohclgZROQIS0XQJOLPep6geBxi5W6F+wN6oBXXueI+r0ilZWZdm3X9g0F63ye9ePEu5Yh+repG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuFOrhMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771CBC2BBFC;
	Wed, 22 May 2024 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716386151;
	bh=+tMwcoL79gLi0nujiJ3sXxygAakt7dyZpS/QD3y71Vg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WuFOrhMxd6OGw7EhgVcxQIxL2QDntzvGop7QZLr7iyjCf/I8VwmRmdV5KqiYwbgFh
	 sfUeJQswkHs8detrPRlGxZhq3Vk8kI5gKTleYS+fz8iG7KL4dhgXOWob0raRfl+vpZ
	 TH7II8l+IkmbUd5U67JQxGNrqLQDSNMuCtUS8a26JBj+23B55WWdpN/IY6wlJx6gpG
	 l0lJ9WxIZcNk9cGRgfZtChjCH5Pf5R1mQORYcRQa+A/urZlQiGXtbfd+W4cq8BEyPq
	 4iLQ39GrZg0PDyoadPx9h5CNQ34mO6VL+1sIYCU2ZtMS/W1bH6nR+onWDjty699kIz
	 lK42GJv9ZFAMQ==
Date: Wed, 22 May 2024 06:55:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ken Milmore <ken.milmore@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Realtek
 linux nic maintainers <nic_swsd@realtek.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: r8169: Crash with TX segmentation offload on RTL8125
Message-ID: <20240522065550.32d37359@kernel.org>
In-Reply-To: <75df2de0-9e32-475d-886c-0e65d7cfba1e@gmail.com>
References: <b18ea747-252a-44ad-b746-033be1784114@gmail.com>
	<75df2de0-9e32-475d-886c-0e65d7cfba1e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 15:21:00 -0700 Florian Fainelli wrote:
> > The patch below fixes the problem, by simply reading nr_frags a bit later, after the checksum stage.  
> 
> Yeah, that's an excellent catch and one that is bitten us before, too:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20d1f2d1b024f6be199a3bedf1578a1d21592bc5
> 
> unclear what we would do in skb_shinfo() to help driver writers, rather 
> than rely upon code inspection to find such bugs.

I wonder if we should add a "error injection" hook under DEBUG_NET
to force re-allocation of skbs in any helper which may cause it?

