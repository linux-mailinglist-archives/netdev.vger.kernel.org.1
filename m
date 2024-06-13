Return-Path: <netdev+bounces-103024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB87905FDB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4451C20E89
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9B8C09;
	Thu, 13 Jun 2024 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3mVWHpI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB778BEC;
	Thu, 13 Jun 2024 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240118; cv=none; b=s/FIqcFW3AnVo1InmMnjHD9ClBlUi2sgEltcit0VkztF7BLsiO/QZprbauzxKkIV6INVwfTI1C5MOVLtlo1XRjRJZx4jM0E4+OEwJIbbzOLqrUAScMZVxeABd78/Y6vmARpUn3Rs8HDnqWtdMoMWx18StVVT8UPCC/0T3b/rKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240118; c=relaxed/simple;
	bh=NY/yHtGY4A7z0RJf/TRPGDp4Z1Z4M73POIKRFEtGCkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOtLpuTs4N6m4YBQa8kyLnh6brqSXoQgi8AU92i9UugKL+rVjujnKm4MJHwUcNqGNitrixtfUaqLhH+VZpf2r5NepIW/r9AJF79aXSb87gJ0rCucNN4Q8kE7+5dFNKPGdmd+/OwbPXINp0GP6B6Ul+XMuSSoum4rk9r8RzSuRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3mVWHpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CBC3277B;
	Thu, 13 Jun 2024 00:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718240118;
	bh=NY/yHtGY4A7z0RJf/TRPGDp4Z1Z4M73POIKRFEtGCkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z3mVWHpI2YrgmNcLgze5ixi3afCObdFHFLYm7YumIrdppNB9SwGir8DBo1WOXWlsB
	 XP2aL+rAIL5Ih66cBRa+sUlTjlYVL4x0g1p7pafxuPtnMVz/vrNZUvfmIycitu9ibe
	 YXgRKxjd3lXcLe+c3o5N0duFdUVVIH1DMih+NPb9Xo1RjdKc6xNnyCDvc2EcXgmvpz
	 A9alWcXrv42yP95ohJ2Ia/zqJrbGaRR7bR/LLeUZFliLMjK9uDX1iTS24MDQIyNqLL
	 B/ZMTkXuBjQnwAtVptw5hSsT6kGln8f9xAqRPEGwtfL5XmJhtQfW3jzsRxLduyt5ga
	 1Y4LWCs5HQjmg==
Date: Wed, 12 Jun 2024 17:55:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Daniele Venzano <venza@brownhat.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ethernet: sis900: use sizeof(*pointer) instead of
 sizeof(type)
Message-ID: <20240612175516.02725d94@kernel.org>
In-Reply-To: <AS8PR02MB7237F187447FF71AE515333B8BC42@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237F187447FF71AE515333B8BC42@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Jun 2024 12:20:33 +0200 Erick Archer wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter).
> 
> At the same time remove some unnecessary initializations and
> refactor a bit to make the code clearer.
> 
> This patch has no effect on runtime behavior.

This is an ancient driver, unfortunately we prefer not to apply minor
code cleanups of this nature unless they are a part of other development
work. We'd be constantly tweaking the 200+ drivers we have, most of
which get zero use.
-- 
pw-bot: reject

