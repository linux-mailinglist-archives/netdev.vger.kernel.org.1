Return-Path: <netdev+bounces-167095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ADBA38CB5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460E13B1113
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03122688C;
	Mon, 17 Feb 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz036eyx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5672372;
	Mon, 17 Feb 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821832; cv=none; b=KhU1iAKsOZYlBY1kt1ZFUHz9gVVDnhMWHvfQKvzEJXhILBoc5WjpCP7uI/shazvLXJXoLTlwH6XC3nYFB4mdx7IRHyiRixPErlwQsAajCcRzZOfLYT+OEZd1AU+lYq6TiLUMOXpqmk5+i72KzUuMf43fWp8ZM7lfUdZ5vc8cDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821832; c=relaxed/simple;
	bh=bzoYtx+zghhnm4mWVvSbTKWn4YLoMTCh2RQdhPTmxq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+9iJ9Tyrx5XeZDNSqsUCeQqyvuPZah08mPXRWCNtq1YNvoM73BY9LzQYlntt1JILvQfGwr6k8awtQOmi5xo6Q3EISuSKNP4BAm64Pd/YBkGchudtKnL/h85WTpaOFdVk0qSgujYG5QNmM9iIzu710N0ETK9Q93nCvsCzA7XJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz036eyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30081C4CED1;
	Mon, 17 Feb 2025 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739821832;
	bh=bzoYtx+zghhnm4mWVvSbTKWn4YLoMTCh2RQdhPTmxq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cz036eyxfkpFgcmzrd4J4+JGWaPWwGiLgBS+p7vN3pOgrp2Ia8moKGANtaNEEryU2
	 QcdZxBWzKvZqGxqtjbH5jflUlhaxMay/HlAgBPOxikaENlYc7OnnebnQ/eNAvQNsvZ
	 18lnqxkDkR2z8bCO8tgIVfIMAoWT/yCe4LjUUGr1VBMyAoOTxiBS4ws53bhZheGMv1
	 lvCiEyh9RsfQz0/rWCUJeDyD6IwA9n0U1gGI0wJyPRdyDczN2pbpeGPhUIpVAZ8iT7
	 rslAmA/VeRnU9q7/OcEg2fO5x8tT8hNTv34Zte9i3eV+CDmzb2YGOkxEH2MVebCVYW
	 9CRmDum0Yy63Q==
Date: Mon, 17 Feb 2025 11:50:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2] netdevsim: call napi_schedule from a timer
 context
Message-ID: <20250217115031.25abfaf4@kernel.org>
In-Reply-To: <20250217-netdevsim-v2-1-fc7fe177b98f@debian.org>
References: <20250217-netdevsim-v2-1-fc7fe177b98f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 09:35:29 -0800 Breno Leitao wrote:
> The netdevsim driver was experiencing NOHZ tick-stop errors during packet
> transmission due to pending softirq work when calling napi_schedule().
> This issue was observed when running the netconsole selftest, which
> triggered the following error message:
> 
>   NOHZ tick-stop error: local softirq work is pending, handler #08!!!
> 
> To fix this issue, introduce a timer that schedules napi_schedule()
> from a timer context instead of calling it directly from the TX path.
> 
> Create an hrtimer for each queue and kick it from the TX path,
> which then schedules napi_schedule() from the timer context.

This crashes in the nl_netdev test.

I think you should move the hrtimer init to nsim_queue_alloc()
and removal to nsim_queue_free()
-- 
pw-bot: cr

