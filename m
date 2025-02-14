Return-Path: <netdev+bounces-166327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5E9A3585F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A647A14C9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35308221550;
	Fri, 14 Feb 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNQyXiew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96E21D596;
	Fri, 14 Feb 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520237; cv=none; b=YmJh8a2dSXfcnoZuhAEvfzXgxq6Am4btKKbJxQpnYllJrmHdqvgxLxrAKQXq1hF49z/2DQbV2Iez7rxsOCBm4SA6swAfQMAYZZxL29LnBHsU6e30x59qO6Lz0+dwuL1fnFZMc1xcYWNg0V46AyV5/uVy9HMEPqLmKT6p9Lbdh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520237; c=relaxed/simple;
	bh=ZJTleOr+aCVydGuBXvDe9vmxgmg7Hou12+O0aC141WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ9J6QWdoecvuuvyJUnccTt6oF1H9G9i5HNZIe6jOhD4QB6L2oT1I8kL9btSo7hm+HQnfTBLLdyMDaC8pKNdIkzj3vtBhY+6FPojDROuOrgSDA7ivYcFwvjISSdC3DYF9LYtPhoICiR2ZB0ZI//dEzIHyS2EKs1vCwvXVUQwoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNQyXiew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA967C4CED1;
	Fri, 14 Feb 2025 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520236;
	bh=ZJTleOr+aCVydGuBXvDe9vmxgmg7Hou12+O0aC141WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNQyXiewYUFgMh/V+W+aYjDpnFSpGmByYccCQTdDs+utzhny0WTB/CV7Pzdtk6unF
	 nIZ0LXNKlBANxtHtRqoN/q8ugYylWxYSafBFsUVmBpkTH94wGaT1JQqaZgbT+l9KDo
	 z0kzoy37mljipUA+YCzLw1g7xedqbQIcv4I7rQqsIeztYoss6AhLGzabOMvyYAeNdX
	 n5Vv4k4vXto83RiJc6QeEI8esqSmTLfSN7ncfglGEkHynuy6Xi5aZHy7icTc0oCJHf
	 +ZCpiRW6GuWfeSokxvBGKZbOttm7c0ISkKTwJcaObnz2KeSVknBe3wxh7sz+8td7SS
	 bO7KKW97He9/g==
Date: Fri, 14 Feb 2025 09:03:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next v4 11/16] dt-bindings: net: airoha: Add the NPU
 node for EN7581 SoC
Message-ID: <20250214-futuristic-goat-of-enthusiasm-bba020@krzk-bin>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
 <20250213-airoha-en7581-flowtable-offload-v4-11-b69ca16d74db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-11-b69ca16d74db@kernel.org>

On Thu, Feb 13, 2025 at 04:34:30PM +0100, Lorenzo Bianconi wrote:
> This patch adds the NPU document binding for EN7581 SoC.
> The Airoha Network Processor Unit (NPU) provides a configuration interface
> to implement wired and wireless hardware flow offloading programming Packet
> Processor Engine (PPE) flow table.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


