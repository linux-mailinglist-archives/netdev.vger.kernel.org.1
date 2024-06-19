Return-Path: <netdev+bounces-104713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9360990E169
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C94F1C21935
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC21B970;
	Wed, 19 Jun 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVfkFTw4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EDE4428
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761932; cv=none; b=OgXhnRlFPu+cRMUrbyusjG2YuacqToLERSoZ/QxapuqbzN8BaWJLKp69jS0I39DJiS4PaSQBZjkHgMh1V4JqftME1ho5Ysz0BpZk9ka2ig68IojTXkZR3hhaEXSbpBC+RWgRAy2rxrFXKlbt0wVUdaIm4E4atlkA3T0qK4KyRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761932; c=relaxed/simple;
	bh=srlzL/jCc03T5xR7b7xlqCWgLxWRJ601RsLpGbDf9Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBEzMLuE8tTPEEAktt8O+/yTgqZWMfZWc0W30EqiAxq1m6jiBsEVRkV7m9itzjQuS2FJbzL6NfW9eLkYhIwssdoJLRV3zIW4EQMzRTTU3BB/I49vLr96Lf3+ul0SNuzdqyr6Lp0x6wqccLXxeWgkp0tM9sfuGq/5m72Iyck7RS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVfkFTw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A627C3277B;
	Wed, 19 Jun 2024 01:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718761931;
	bh=srlzL/jCc03T5xR7b7xlqCWgLxWRJ601RsLpGbDf9Y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVfkFTw4qaQ29FjO/kF4Ox1g5azJiIjsQ4u5LGYC5ZDhcauGi3w4Py36l65NyizCm
	 8YF/nqkKRAnyCZEQiMqhMr3Us8rz/rmKwQF6nTRLWRLlmXGNM5turSiSWhwKdt1Qcz
	 nYb5BLWhFCNYghNQk0Z7xuCtKqlCM7FjsPXgNnLk1ZAjCc387HCq2hXj7DjGdlgyGB
	 v97wxbNaSbhrT+lCpTzMTgioCDXHTm2Qa65q42tisdRfYwpcgA/1uXii/KGDA/T2KX
	 1FYHrUhloiNiMnSjTVnF5NRtiy6sMR/qx61gsXzBDeCrVykm/f2WmV7kFxuJsUp61a
	 zEXikuxzPhwoA==
Date: Tue, 18 Jun 2024 18:52:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v11 5/7] net: tn40xx: add basic Rx handling
Message-ID: <20240618185210.3a7a5715@kernel.org>
In-Reply-To: <20240618051608.95208-6-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
	<20240618051608.95208-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:16:06 +0900 FUJITA Tomonori wrote:
> +		skb = napi_build_skb(page_address(dm->page), PAGE_SIZE);
> +		if (!skb) {
> +			netdev_err(priv->ndev, "napi_build_skb() failed\n");

memory pressure happens a lot in real world scenarios,
allocations will fail, and you don't want to spam the logs
in such cases.

In general prints on the datapath can easily turn into a DoS vector.
You're better off using appropriate statistics (here struct
netdev_queue_stats_rx :: alloc_fail)

