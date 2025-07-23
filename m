Return-Path: <netdev+bounces-209491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E94B0FB51
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67ACE1C23A6B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA421D3DF;
	Wed, 23 Jul 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3aCcmqb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93817C91;
	Wed, 23 Jul 2025 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301826; cv=none; b=mYzL7ayfluLGaWx9krBKVinV+OG3uoOYdwphOcVd6rPuAsXv+cIL7AvYvwtEt0D0evwM2NqJLcx1GQU+rBY7Wc4VwWNHCw9kEWzeQ9cfaEhwjzU8ek61xVNlfu6M5L9VbgNs0ikNWglkFXZWt0dncYfrLrjoUS+kFnefmMSPmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301826; c=relaxed/simple;
	bh=6dTQsHWy9Ula0eQOYuKPFueJNvyCpmmAPWGnWN5VN8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flZV61dATjkioon9WxtFJUBJSfJF1SGC42SMr8zWdxW29g7FcfOehaY3S1plM4eenKfR/vfTbh7VDMxWkKnsLbpgFpX4Qecu91UI4r0bcoTOZUYyRUS5jcSh4EiyP/OBr4FTA3luyGdibG8VBi9jysLsfQw4tiwKHD7KDC0Hxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3aCcmqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F141C4CEE7;
	Wed, 23 Jul 2025 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753301825;
	bh=6dTQsHWy9Ula0eQOYuKPFueJNvyCpmmAPWGnWN5VN8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K3aCcmqbHzqOWZPg1mufIoEjSdkzYnXKRQHcIVEZhQ1BvjrObHkb6ivcez1fkYc5J
	 4WZ2AXSRiKvHiV4nlshyMuC1UilitfNy8aEvgk9oRwqVK92f9DDrZXh7Rv9sFnC67w
	 hOLzpJzLBcmKqLnQXM5nGXq2EYxVY9JUZx33FhRufUUGN/hF8NZCA55zD3EUiHRVy7
	 GSbjUJzI5nINzfyOlkpUw7+Ue2mKQLdghr+mrYYW/P1dSj7+tyrMCm7kmtS0nf2xws
	 3LW08WUlHjPrRcPfPXz/vo2qkHt9qL4ucOhoZc2v0LR7/y5/Daf4ERA4Lh0Mrh9GJU
	 iRG6kuywos0Wg==
Date: Wed, 23 Jul 2025 13:17:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v15 06/12] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250723131704.1f16a13a@kernel.org>
In-Reply-To: <20250723220517.063c204b@wsk>
References: <20250716214731.3384273-1-lukma@denx.de>
	<20250716214731.3384273-7-lukma@denx.de>
	<20250718182840.7ab7e202@kernel.org>
	<20250722111639.3a53b450@wsk>
	<20250723220517.063c204b@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 22:05:17 +0200 Lukasz Majewski wrote:
> Do you have more comments and questions regarding this driver after my
> explanation?
> 
> Shall I do something more?

Addressing the comments may be more useful than explaining them away.

