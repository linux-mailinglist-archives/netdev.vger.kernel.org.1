Return-Path: <netdev+bounces-178110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53BA74BBB
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8659A1B60A2F
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA33224B1E;
	Fri, 28 Mar 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWiVe1Jf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2AA224AE1;
	Fri, 28 Mar 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169436; cv=none; b=ZKhj67uf6fC1lLJpgcuC+pKTKxc161ywx79yqawD/Ewvqt4prVTu9B96wCaExGNWjWgZBiifRogrfxL3yehiHZRaTkEj0EcU9cl2vYMbLeyo1UQ+8eThMEy0od3ZkTrOmrWCeZQJUzQL/CQ+JaFFdb6BiI9ZUx7hvBvBTZEsfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169436; c=relaxed/simple;
	bh=ul/qEY26VKNyougTofT/6PHrPo6+tNe7ZZ1BlHAgJNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScLz0ADXYFMwu1wi22c+RicHt96unxynB4YmaWpz9CVRcsKxzo4y/8Ctbm1+CVEyQi7JJgFOdRWuUZvfPjO/8BbUCnelxw+S+Q0eBpTSZ0DHUJp9LtEpnWes2iRZ9w+IOVTVAUqu336mv7wMhx7o9SQWL0LLVWEEQ/0e3y4bwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWiVe1Jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60BCC4CEE4;
	Fri, 28 Mar 2025 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169434;
	bh=ul/qEY26VKNyougTofT/6PHrPo6+tNe7ZZ1BlHAgJNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWiVe1Jfqjym650rfl44EBMdv58+aYsdeSS/MIbcrMVnTDSoAeCRSNEOMYYSFKENm
	 Xd/G1tYkgon6J4UFQSphD7SXSLRs1IZKC5GwJcwvXorvNrooYNonImw+z9cguYn/Y+
	 qoQYBxmdsiKwqXnSV/PcebdLje1m2Pr2KDoJ4DErCNnr+yPy2B8BIRMQdRz6LN2RJh
	 vqX1FV1eqD5xX5N9AM9Wa+hwiohOtDXEPpVo+b1bxt9SXuIQpFmvB5pbD/h6X2dBZe
	 HfudkBrVZA7qgzBAgyYZGK38JEnNg0bzHWyIuIrwuVQ8Wo0nm5OC2zg3DMbcfZ2ToG
	 VuAMTyDhwxuJA==
Date: Fri, 28 Mar 2025 06:43:53 -0700
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] net: mtip: Add support for MTIP imx287 L2 switch
 driver
Message-ID: <20250328064353.33828cd2@kernel.org>
In-Reply-To: <20250328133544.4149716-1-lukma@denx.de>
References: <20250328133544.4149716-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 14:35:40 +0100 Lukasz Majewski wrote:
> This patch series adds support for More Than IP's L2 switch driver embedded
> in some NXP's SoCs.

## Form letter - net-next-closed

Linus already pulled net-next material v6.15 and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Apr 7th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


