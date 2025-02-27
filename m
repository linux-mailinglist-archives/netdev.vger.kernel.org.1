Return-Path: <netdev+bounces-170085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02145A473B1
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0622B16B10D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B91D6DA8;
	Thu, 27 Feb 2025 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtmgAtm+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CE1D61A1;
	Thu, 27 Feb 2025 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627792; cv=none; b=YNxVzTYqUEMFZXEVg668c9e+Jc5jPm7aSNNMxTnbryfiEW20rH9CByHrlQ27ZOJA8Ym8tDOrohLVOTnZH0MNFP6oM98vR60NGpO1N94Ks9abZSKwrvt6YCAC11gHMtizWVHrqj+J3w/tu1hBfz84S/oWMVnHpYzEl6gqZvigpBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627792; c=relaxed/simple;
	bh=HRAUJZiaXmc4gvllAhWu+rvpOk514k1RBIfgmxusrUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6E7hyw8bwDziIK2uClzuSn/aM9ScPXxGjR5jjcm8Fbbp8a/prIq0tLhOr8yAXN2oGAyTVfJtMkqo6IK2ubbOIeas/a+fDl1HstQOWIgcTrRE9AufBffsYtHPxOL3TATdiFXh5US/DtZin1scun/+Ft8/A+n8jVmq5qTAE4psM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtmgAtm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9152BC4CEDD;
	Thu, 27 Feb 2025 03:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740627792;
	bh=HRAUJZiaXmc4gvllAhWu+rvpOk514k1RBIfgmxusrUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dtmgAtm+Qe2PheNsliaKRMSteSGk5zN7eklfKXZ8ucTjoq/tFgrq23nfNLtEFuPJd
	 5vGDqgp0mJkY0URP8UVPlmOKF6rT4poVrSntpgkNHclC6tbtLPvghLxBavUCUZzWoz
	 hRqGJ29uPhdG3NYkMSaiH1BBaHg04ei1MwlCyGLX/f+eJZ/YUpN6gxdMOwfXhOJSdP
	 J7MmCZreolXJdyZbAlZ4ICWvgzIOZPb6VlMDp+HFEFu4WjD2yA1ATKKbNQLNcVKdbd
	 jOuB0zd4ixcsqyiQX2NwkIubjFHu1e6R1IoAhI9dJMA/JwTrvNWe6rFVJ3bJhHaxwI
	 skTFGGCISA09Q==
Date: Wed, 26 Feb 2025 19:43:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>
Subject: Re: [PATCH net-next v7 13/15] net: airoha: Introduce flowtable
 offload support
Message-ID: <20250226194310.03398da0@kernel.org>
In-Reply-To: <20250224-airoha-en7581-flowtable-offload-v7-13-b4a22ad8364e@kernel.org>
References: <20250224-airoha-en7581-flowtable-offload-v7-0-b4a22ad8364e@kernel.org>
	<20250224-airoha-en7581-flowtable-offload-v7-13-b4a22ad8364e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 12:25:33 +0100 Lorenzo Bianconi wrote:
> +	foe_size = PPE_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
> +	ppe->foe = dmam_alloc_coherent(eth->dev, foe_size, &ppe->foe_dma,
> +				       GFP_KERNEL | __GFP_ZERO);

dmam_alloc_coherent() always zeros the memory, the GFP_ZERO is not necessary

