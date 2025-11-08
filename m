Return-Path: <netdev+bounces-236929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DDC42481
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 03:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 450C44E138E
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14D26E6E8;
	Sat,  8 Nov 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEOrQBi+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9A1FECD4
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568428; cv=none; b=VZQks8BCmcfhR832CiwkCrDxcO5UcoNC8PJ++uvVFMGerGVxD2pqwIZIXUe5nCIAPPEjwHbkI73102x52qoP6EGXRv5mOGT5LnHBLYpyVLajSzPjZ8gMo57C2vFvU8y3Lba2+wXyknZQVifVxxcBE27K6kZQK8j2WhVv/m2YFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568428; c=relaxed/simple;
	bh=4vaaNwNVOwMyiHlV3Cnc39dzspNCCRLZ6WxZOO8eoTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rgxkoo2EOfiYY8eW3sNd3szuC5eMwMix2InYNx+qnxBKHwy+tMDb0dXnwA2oG5usIRMbFmb4VVKsq7gaPpgClQ7OUpS+a/gvtS8kbk/ri6S2geEg0gx0vX6++uSOnNvXkbcM5VeSukOwqEevzgnQB79wd9IEZXtLrGM7gZQgcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEOrQBi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ACBC4CEF7;
	Sat,  8 Nov 2025 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762568427;
	bh=4vaaNwNVOwMyiHlV3Cnc39dzspNCCRLZ6WxZOO8eoTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IEOrQBi+3PPEZNL7W6YExeAKQCZxMHzlzvEOVC97sqP+kHPhFsnqm510MvpdJRp1T
	 87lrEgTpmwTto7v38oM+kvL6Ekji7jsqMzkYP4+WDQCzc7O4bf1HntS3UG4ljGO7F7
	 q2zfOfD68BtJLPNoMT074LgZ/Dr6LAsWJkRG3AAck/7uEKRkQ4ftd6HEwyW9ZouWY/
	 gZRlvX+mwGiSPQyIVBzJSxAH+C4+KG4dAAn1s6XZRafxI85c6x+JnM/JQQ8GddXv2s
	 QKbjU61tDZDCec0NCOX1wIr+uIO1lZIAd1C7F42k1zewM0ZMEnIV9VDw7P8e3WKJXa
	 bDp+5mejp/HjQ==
Date: Fri, 7 Nov 2025 18:20:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v12 0/5] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
Message-ID: <20251107182026.45bde2a0@kernel.org>
In-Reply-To: <20251107060751.49271-1-xuanzhuo@linux.alibaba.com>
References: <20251107060751.49271-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 14:07:46 +0800 Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.

The rule is one posting in 24h. If you mess up - you must wait.

I'm discarding this. Repost again next week.

