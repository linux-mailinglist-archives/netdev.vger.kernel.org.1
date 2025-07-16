Return-Path: <netdev+bounces-207478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E772AB077F0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BBE1884A2C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91C122CBF1;
	Wed, 16 Jul 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvGfQ2mF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F61C5D44;
	Wed, 16 Jul 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675763; cv=none; b=FSpe8CwmjKHmYQLPO8t3jrNBrgxcxfqDAB+5L0zEXKdgR4SEEkj+2W5jPWGWbg7h2hMjTCxLDN9EqMflL4M0eimKah58TaqVq4K3JAWD4dnyfBEGl1tVSSkiUKMYF4BEJdwZNPs5D4ImnH1XOBQ26u1NCELuM5sU+WAm1jMCwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675763; c=relaxed/simple;
	bh=Cl9VSkYFdXvxa8TkHxIdPtFn93DFbyVpo3An6K2KC3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poK22sI/onXe7V8LpHPaql+LwWuux45x5I19EKWqb3fDPtGa21667Lv9Wm3vDUc3/FZFRzMf/Y/an3gDEcxfEB/0A7mfBx9iLEzW/cpe3tKMTRVAxiBJEwOj000XeFDr6Zh4d+eIUt67XV+MgDrCK3/pgSC/POBV5xK9CDT5f9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvGfQ2mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EF3C4CEE7;
	Wed, 16 Jul 2025 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752675763;
	bh=Cl9VSkYFdXvxa8TkHxIdPtFn93DFbyVpo3An6K2KC3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cvGfQ2mFvX4dfOLDzRWRtCQfV6/SmTa1TJM4uL6vxoYVAzrOF/GGhUikck+DOnUHy
	 FKnuIR5M3nyqTXQGimVqHGxZKRKIXAVyjJBqlvrRPDwYMYaC1idHVjlUmSMHPgnRVU
	 l4X/B3jtNbNUUYuJKMzZq57PPOaqfolrxvzsE1no02RlMXwQNEMTWL52Kqlf0Yqf8+
	 baHQAOz3Zf1J56Lqnkrkc2MOjWtdwAHpuLRuJgZ7MMPnKdBkDl6YlcXISMJAC6XzAR
	 v2FEk0ZLHo8ZK8OhDrK5K2OgChU/sUU+lHjDWbpZKv6QrP3vtSU6kvdMaszdhf1zkg
	 s0A8hqDZY2tNA==
Date: Wed, 16 Jul 2025 07:22:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kito Xu (veritas501)" <hxzene@gmail.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "=?UTF-8?B?6LCi6Ie0?=
 =?UTF-8?B?6YKm?= (XIE Zhibang)" <Yeking@Red54.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: appletalk: Fix use-after-free in AARP proxy probe
Message-ID: <20250716072241.16edbded@kernel.org>
In-Reply-To: <20250716070100.708021-1-hxzene@gmail.com>
References: <20250716070100.708021-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 07:00:58 +0000 Kito Xu (veritas501) wrote:
> +	atomic_t	refcnt;

refcount_t ?
-- 
pw-bot: cr

