Return-Path: <netdev+bounces-213156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50731B23DEC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DD37ADFEE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BBA1A23AF;
	Wed, 13 Aug 2025 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8ojr8Jl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D1249E5;
	Wed, 13 Aug 2025 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049846; cv=none; b=pK634+/xubnnOkmrYr7psLKl5tx+Zkgt8VahpdBT8UUAZ5Sc7zCW4/MLhauuAJCFHGbcLKkxzTkgQsewN3/uZNAup3s+6Tg7KCNkoD9JD+qxBqKQF7+R4hyB5qyAJU6h798RuQnLtzi3UVJjBaQUskpYK4uQ4Mo/cHIAR7eYM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049846; c=relaxed/simple;
	bh=/TWbFKiAUS4Hv5UjHzTDgLkD5NVzeVFAuOyarw2xwAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo7L/emRp1Y1gupZrUDW+eXony5TqBzqhCcZO4DBpud+jPpfqrLyXEnSdFzJUDlV1K7iCZpq7w4btF2ifFl87izTavb9UTv7bIewg3gGIZJoU5C138P1Y5biMj2gr/1eeV3WXtkjLAPFHAUun+YXKkcaWb2XkqMo8x+mKnV8fnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8ojr8Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7CBC4CEF0;
	Wed, 13 Aug 2025 01:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755049846;
	bh=/TWbFKiAUS4Hv5UjHzTDgLkD5NVzeVFAuOyarw2xwAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t8ojr8Jlh97iNz7e1ejsuaKeo4Ov2eO5+NqayT8QoCHQrJ9ynNZ3b7MNw53h1bYT/
	 kg5bmr7wGeQYvGw4sinOCFr76tNnpYfYdedCrZh1rqYrOhjZ0J8SWml9+2kBEpHMs2
	 UU71oRqiedIXSi7FzlXcswk+Ci3cLVNlYBolS12bm8JEOpArqbE67/Y9hr+RoPSZ0Q
	 srTwO5wkiV49t48aCWu3OBv4gctHOK4wlv24ncskC4u5ndBGP4BaZ74083bhaOe4PM
	 B+y2oxoDUuV3PQap7zHpSnHYrtBdwSIg9mpzdZmaPQBNW2PKiPivWRvnohmOvq+qL0
	 9fgiWB4x59f8g==
Date: Tue, 12 Aug 2025 18:50:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next RESEND v17 00/12] net: mtip: Add support for MTIP
 imx287 L2 switch driver
Message-ID: <20250812185044.4381fae8@kernel.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 10:29:27 +0200 Lukasz Majewski wrote:
> This patch series adds support for More Than IP's L2 switch driver embedded
> in some NXP's SoCs. This one has been tested on imx287, but is also available
> in the vf610.

The arch/arm patches don't apply to net-next any more.
Perhaps we should take this opportunity to drop them?
We will really only apply the bindings and the driver code.
dts and arch/ code need to go to the appropriate arch maintainer..
-- 
pw-bot: cr

