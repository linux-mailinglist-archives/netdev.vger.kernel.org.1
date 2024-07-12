Return-Path: <netdev+bounces-111000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC1D92F380
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D4B20DD0
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2644A33;
	Fri, 12 Jul 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZwLhgKg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459F20E6;
	Fri, 12 Jul 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720748202; cv=none; b=ESLjMi4vlkETacj6gCIYnxAjq7cAl53U00YPHfl51FlUbSXxR/W6ZO9LWf9RMb/0bZspz0pVig/oZiIOYx+MO6tqGwky2NwOgOL/Sa1PFlEzK5NALSEUThWSvSXmtvEASV3a7njKH656xaxjeEAnpa2GWg9IohtFTb3bvr1LHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720748202; c=relaxed/simple;
	bh=/TfMPsr7JoapnKoxt8EqbIg5aMOv7IhGQfw/6aauwzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=be/wdoo2dgy55qydBMNRZx1K547XDXA37WSwH0PFEdujG+jr3ToBjXs9sEFqd4ppum9d2HMnH9jjdP8QChcRZweAem596dIq1dKGOBElBPoi0TaIWT4IE3La0wLBG6r58Y+nBY3wQmGtgRBlKPizLbAjkrFilr/PAOGC4wIK0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZwLhgKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5AEC116B1;
	Fri, 12 Jul 2024 01:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720748202;
	bh=/TfMPsr7JoapnKoxt8EqbIg5aMOv7IhGQfw/6aauwzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZwLhgKgcfWDWd4IZrTQU17L8+u414btRCjqQW8hPXh0oLP4ewhpRUJbkjDQtDGIH
	 tkFeogUyEEmhcdFbevFyyUC/1NyPsrgI8g8CSxeu1rxwtCyo9ipXC3Q91LTW1iHKwU
	 LuoqjIOpSCGKmq9FsF4i3IKKeOGgYNI3Qh/l9K+UpX3TOT/Dl5x+ICTisqmaMfwkqz
	 jZbJHC9TXGOYl/zZpiWoJynszKxpc7cWcwxZJtGbg3SchEs1NAERdBUAWo+cfhrLDn
	 VK0CvHlLlqEufnofZWBFlOcxKUQ7QUkJXLs3GymJSt636DvSSmYFI6dyE5iKuWAskF
	 KqTE5/eqT42hg==
Date: Thu, 11 Jul 2024 18:36:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v23 04/13] rtase: Implement the interrupt
 routine and rtase_poll
Message-ID: <20240711183640.02241a9a@kernel.org>
In-Reply-To: <20240710033234.26868-5-justinlai0215@realtek.com>
References: <20240710033234.26868-1-justinlai0215@realtek.com>
	<20240710033234.26868-5-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 11:32:25 +0800 Justin Lai wrote:
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +/* Polling 'interrupt' - used by things like netconsole to send skbs
> + * without having to re-enable interrupts. It's not called while
> + * the interrupt routine is executing.
> + */
> +static void rtase_netpoll(struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +
> +	disable_irq(pdev->irq);
> +	rtase_interrupt(pdev->irq, dev);

Why do you need to implement a separate netpoll handler?
netpoll is optional, if driver doesn't implement it core
will just core your NAPI handlers with a budget of 0 (to
only clean up Tx, see NAPI documentation).

disable_irq() sleeps, you most definitely can't call it here.
-- 
pw-bot: cr

