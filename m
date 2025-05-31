Return-Path: <netdev+bounces-194460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE6DAC98EC
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FCE9E36F4
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07E15E96;
	Sat, 31 May 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj7zmzZH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E1C148;
	Sat, 31 May 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748658653; cv=none; b=hM+uVSBm3FdUToeRL29T3QO16nP30thnqt0wcNk7S0rNO6s+csNMltlGJFUrGUMywBQ7C9d9XV56b80A3enKO6Wevfv/bgFSVDHmEAPceIvbp+A4KCOShHef3rg6lqx5V/+62OVVusNLx9eVVa5g8wS6cq6AE5zx4Sab34zmhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748658653; c=relaxed/simple;
	bh=G5iujgdOpUegi9+v+dMXi3frMCBX8UzXpdWCePyE12U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6bNCYLpsKIrag82BAp/bq+8NY0pIQS8gTM7dFTCuncMRvmN0DgtkY2kqmBn/5G6GMsg9V79iKRR+1ELHWMfi0i46zmP3p1KZqKgI0LKCFad2uyVuIxNg1wOFzIiEJU4WE7xBV3lEsc9DDqv/folJStHZM7WNbTqVcAy2q2Q0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj7zmzZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BAEC4CEEB;
	Sat, 31 May 2025 02:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748658653;
	bh=G5iujgdOpUegi9+v+dMXi3frMCBX8UzXpdWCePyE12U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fj7zmzZHmoZvyIgZWwZB3McuD7Ib+AesMLOX83fSqP+YDhxb0lkUjHG7LLeaWqqY0
	 Y0WHLcj+sIw6WntTUQ/Lnx2yFvA5zmlZy2z2cueXscbyyy6MM/Ns73OeUFIKGsqx2Y
	 qytVb7rcGCB50iMOfk1v3U++HWO8xH3/6b/s1X4az9UV6fvts3m4WHOm/30DjLC9Zs
	 TgHEpdbzLbPs9XDvj5Zt9LXAXpmu+8uL0u+u77l67buKjN3zPeFuNlsDGHHuQ3nqYQ
	 jBT4BC4lFUeaa4MxoJNNGGkjdkr53yXtCUHVM2qlYSbeYtTkGtmY2zQlPsvhpzG/b4
	 riyw9kCnU5ivA==
Date: Fri, 30 May 2025 19:30:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] netconsole: Only register console drivers when
 targets are configured
Message-ID: <20250530193052.1bdbc879@kernel.org>
In-Reply-To: <20250528-netcons_ext-v1-1-69f71e404e00@debian.org>
References: <20250528-netcons_ext-v1-1-69f71e404e00@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 10:20:19 -0700 Breno Leitao wrote:
> The netconsole driver currently registers the basic console driver
> unconditionally during initialization, even when only extended targets
> are configured. This results in unnecessary console registration and
> performance overhead, as the write_msg() callback is invoked for every
> log message only to return early when no matching targets are found.
> 
> Optimize the driver by conditionally registering console drivers based
> on the actual target configuration. The basic console driver is now
> registered only when non-extended targets exist, same as the extended
> console. The implementation also handles dynamic target creation through
> the configfs interface.
> 
> This change eliminates unnecessary console driver registrations,
> redundant write_msg() callbacks for unused console types, and associated
> lock contention and target list iterations. The optimization is
> particularly beneficial for systems using only the most common extended
> console type.
> 
> Fixes: e2f15f9a79201 ("netconsole: implement extended console support")

Code makes sense but I think it's net-next material.
-- 
pw-bot: defer

