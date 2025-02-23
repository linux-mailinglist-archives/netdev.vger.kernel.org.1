Return-Path: <netdev+bounces-168804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C79A40C77
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 02:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265DF7A4134
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163A8472;
	Sun, 23 Feb 2025 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="LSx/2S5F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvTI64S7"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909B23B0
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740273476; cv=none; b=onmZQu8vBc+nnH/gnI/hn7i0bnd5XMVFHgod/ayB9WUgKgfXzDZH4puln4bGszUeSSlTh3JwM/HKUMSyhyQaOvH8OEmvL++lkG/enBlb+/Ix5upbw0VfZt0N+1nciQntsIM6uP8T0kAWP+D6l2Qfufd2wBE03oudee1TpZrDnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740273476; c=relaxed/simple;
	bh=uhirDOc/3ziZe2NAuAsrHaQ7NkvJq8q08e0hJiM5fGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKSIMb7WJ2Q7ZXur60RJcwUHh2VDjAqHJjDh2MWTwp1Qb7wW6uNK3wIL//e/oZo9ze2vIJz87HW1PGBLFqGi4Fbm1NhHIBM5SIuymr6mSiSXlRHbsVVuLKb5Mqt0pWKzJ1KpP8ErUl896pVaXacMzpyWLIpTBvtpdSPZTZRPp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=LSx/2S5F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvTI64S7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D0FF1140136;
	Sat, 22 Feb 2025 20:17:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 22 Feb 2025 20:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740273473; x=1740359873; bh=qSFzTmkGtB
	xLNsG2xqwLHkqRFImk+TdEPF6qvITryro=; b=LSx/2S5F7cWxyQvl2/c4sV4mmL
	0UtN9aaUxb/kPVh73+2kPHWM8D3OMCJ8Y9EYqjZsXH5bUIkdafdzKwS6OZNJvW3E
	67SzvYUGUQhi9uPdze9dKKuKxQO5moN9RX+lHXGILeEj9CmLrotrS3gBHcNVeTHW
	N0AfBi5jCuWfSzKFBPi2q66vAGAeJBcpVbrJWKIGpz/jpz0nqCTGRo6C+XwecmYe
	4CJatAi0kvnKstC2jhVNklqW6Dyqx/wjA2vyIy5jVHn9WYto5C9O3JjwJddTnrcX
	UuiIzqt+dkTe9SL12wmgFWVn1ISDxB0YsMI04u4ABoCv+kf30vogFK0gpNOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740273473; x=1740359873; bh=qSFzTmkGtBxLNsG2xqwLHkqRFImk+TdEPF6
	qvITryro=; b=ZvTI64S7KWB54QGdG6Xj1w1KYhuL6k3mWnjWKkz2w1PvOVdEW/l
	V4bo+q5yBKiDuxIsUD/AmF4cJPz+WE8te0/mP1oS91ToTaMiXCfZHe8VxSEZOfZ5
	Sj+434lZCdVNo3M9KTtFsHy/Jri+CBqDySdn61EYShdia9V9uaE/VwQRpQwa3epV
	wCJvkzPj2Z1UIvCo74mDmvghGRcA/i0rLCf6q1bG7Gf0XNodo/GSr8dlERAVA7k4
	TRcElwLDf7gpuFMdGQdSkqvpBsJb5VDXopawjOo8fQKCq98ujJWBWh/XkriYONVr
	YTfG4v+vCsya0OzX2nHtUdKzHNQO5h+6rTg==
X-ME-Sender: <xms:QHe6ZwIrKYoWSMPeEGlxsq6hiijs6iW1u-5n9oDK1m-zT2NQYxASYw>
    <xme:QHe6ZwI4-XkwD7JCzLdKLBT-C2UZVwnfvyNPCE8kzk4kcG2Hcsmu7xsvtd6JcJdFT
    zwY9AzY81keRXjm9g>
X-ME-Received: <xmr:QHe6Zwv9piycBRjrT1xHBMva5MHqjKFk9WSv1BHZAKzA_oFuTQWee-TpB0Ap55SQyvvm_g1n4zhaIUpDWLxiO0xwg6QhES_OVrO80FveugKABg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejgeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    efhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgleetueetkeegieekheethfffleetkeeiiefgueffhedvveeiteehkeffgeduveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunh
    hnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmihgthhgrvghlrdgthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprg
    hpgedvtddtjeefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QHe6Z9YLeR8-D1HQMx-BH3yXvaMT8zG4Dizbml16vedj6NihKlCHvQ>
    <xmx:QHe6Z3YSuOCpXZx17ycmVVxUBtsN-dvomw4nihTA7SSuJBwPtr1eOg>
    <xmx:QHe6Z5B8pOgpe79FXcDhUQkMxwWz_YrztxoA57oYZVHBy5GwAufrTw>
    <xmx:QHe6Z9b6T_0MFAiW4AqdiP77dKdU6qob72jsdoew74MAc6pxf8WAZA>
    <xmx:QXe6ZxnO4Km2ykYuXHjcC3_OMvTqUciTZD7hE5o3y64kgXbuQiTnNBQG>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Feb 2025 20:17:51 -0500 (EST)
Date: Sat, 22 Feb 2025 18:17:50 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, ap420073@gmail.com
Subject: Re: [PATCH net v2 1/2] net: ethtool: fix ioctl confusing drivers
 about desired HDS user config
Message-ID: <hzrkounydzlnimuuucnlxe35rkka4g2xntnseq7cg6lslkpt3r@g7jv662zwezy>
References: <20250221025141.1132944-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221025141.1132944-1-kuba@kernel.org>

On Thu, Feb 20, 2025 at 06:51:40PM -0800, Jakub Kicinski wrote:
> The legacy ioctl path does not have support for extended attributes.
> So we issue a GET to fetch the current settings from the driver,
> in an attempt to keep them unchanged. HDS is a bit "special" as
> the GET only returns on/off while the SET takes a "ternary" argument
> (on/off/default). If the driver was in the "default" setting -
> executing the ioctl path binds it to on or off, even tho the user
> did not intend to change HDS config.
> 
> Factor the relevant logic out of the netlink code and reuse it.
> 
> Fixes: 87c8f8496a05 ("bnxt_en: add support for tcp-data-split ethtool command")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - fix the core rather than the driver
> v1: https://lore.kernel.org/20250220005318.560733-1-kuba@kernel.org
> 
> CC: michael.chan@broadcom.com
> CC: ap420073@gmail.com
> ---
>  net/ethtool/common.h |  6 ++++++
>  net/ethtool/common.c | 16 ++++++++++++++++
>  net/ethtool/ioctl.c  |  4 ++--
>  net/ethtool/rings.c  |  9 ++++-----
>  4 files changed, 28 insertions(+), 7 deletions(-)

Tested-by: Daniel Xu <dxu@dxuuu.xyz>

