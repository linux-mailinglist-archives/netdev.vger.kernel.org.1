Return-Path: <netdev+bounces-210554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED27B13E56
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3ECC17D806
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762D271479;
	Mon, 28 Jul 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3ITj4GQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F626D4E2;
	Mon, 28 Jul 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716521; cv=none; b=M2ryJFH4sijcebEQSi/Ws0XJ0vS8bdPRu2kTHcoSdVgxcUViJ0m0FqD+7Ose7zLxs5wZFeZ+F40V13qYgflNqFO0IdxwpXUwWI+yqp+ekM/k3zzp5iap2IhtwQkmVHctQgYEHEWArFcmMu8cHZjVDMeto+iU7cyPqhFSJomv5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716521; c=relaxed/simple;
	bh=nCCab6w8oj750hCuDA8aX5D8FTeBEr0NdwDFh06N7Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfG/vyfrHIAMuNxjkB76konGK68WQee7p9mCVW7Am59ftdW634ahbPWKvzKF08AkNVe8/NrtJfe561tX/6E20GK7wyZDeLUENGlFmFaZXuvagWLRX+Ds0tuyyXo9LIuh9rhhMtXaE/Q2EW4L17tvloSDs+OnRXGcMcfzObraUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3ITj4GQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477F7C4CEE7;
	Mon, 28 Jul 2025 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753716521;
	bh=nCCab6w8oj750hCuDA8aX5D8FTeBEr0NdwDFh06N7Cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T3ITj4GQGjkd+wYCvSJ0HMtHWPi1m06RcLiuvbw7nXi/pQuAhQ28BT3Ec7gjoKnp8
	 dGJMxBtb4udF9q5Rb+uIGQ1bcb/GW1qh6BjRAk28QxnT7F/eelweZuaNfvQ1JI4ugu
	 pGzGcdtLTJXW9h2qBWBx4QcTRqg/sQvQ536eGS7J4RA8Ox4fqQADMloDk5UEBhraC3
	 xfBUAqVi4MiJzdLP0v/8/YVyv0p3BC6llc6VXGfHkkUI+x3JA3Y+oinG65E+dcPizm
	 GiPKAtAMlHmhIPXu0kWnkwko59pkw/Hwzb0nivYlhSNAG99BJ5p6sS/OnsB9Rkh/qv
	 o3yXNtCG9VQOA==
Date: Mon, 28 Jul 2025 08:28:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Lukasz Majewski
 <lukasz.majewski@mailbox.org>
Subject: Re: [net-next v17 00/12] net: mtip: Add support for MTIP imx287 L2
 switch driver
Message-ID: <20250728082839.2ed8a067@kernel.org>
In-Reply-To: <20250727100128.1411514-1-lukma@denx.de>
References: <20250727100128.1411514-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 12:01:16 +0200 Lukasz Majewski wrote:
> This patch series adds support for More Than IP's L2 switch driver embedded
> in some NXP's SoCs. This one has been tested on imx287, but is also available
> in the vf610.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v6.17,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

