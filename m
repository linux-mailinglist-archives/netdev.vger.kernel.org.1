Return-Path: <netdev+bounces-184427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E32A9560D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 20:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89971188DC9A
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E51E990E;
	Mon, 21 Apr 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJso5JEp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258E26AD9;
	Mon, 21 Apr 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260941; cv=none; b=XvaKGmXMlGQ7gwdQuTAUfJKF3mmcD6JGcGsARmwSlIQT2W4vtEOQXo+Xh+ZN9cuW7mECaAaZfgv0YlBjbevHFlBfFMUc5fIPXuuqMlkWXAoza7zU5k90Sku2x3e2rAD31oSvhWrrT84xaD/0D7RqZ/4VYB67TeKOJkPphp6BirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260941; c=relaxed/simple;
	bh=PKCtPZ5e16IZooE+CufNWIVCR2UhdYPQvpu/jck5oIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdVnpmZSnIR4zUgnhwVGugE5iLK9gwqg6YQbgGzvTAJmYOsTpjXoefmjozPeaEfQrVN7jnfMZ3GZw+aYH7AroXgcU3cogcQESoTiLVlzUDgD3S/a+UWPedhUuJY394wEMYIoXqlhRKpuGX//oxiddnNgeGFaUKVpYivlRk1LJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJso5JEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81192C4CEE4;
	Mon, 21 Apr 2025 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745260940;
	bh=PKCtPZ5e16IZooE+CufNWIVCR2UhdYPQvpu/jck5oIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJso5JEpx2oKtGorQjSxlvbsd2Hn5Vx7W7R0R2WOkGPTWmFulwzG6jwFHz/wkFHj+
	 CBGggxCEuBFtwEo3wk4QR1HbecDqNr7jHdV1fljhr7jW2gxFjMlFaSMq5fsijPzwzR
	 hwAGOpisTFLNPxo7lfualLMzNFlX9K1Pi/8aagmGpRFZzgiMNa2ZRRKgdKH7wFIe34
	 rB2le5FiNLcZTblfpCso2znlJmw6nPmLiFLUOPall6XrAA4KtVmI2RtP/8KYioRVgx
	 mAQaAj/50QgJz1lcWzCbAt/ODlwwEq9m8ZvUVD26IBYlqRrwc/zRmbmu7HVWAsnOvO
	 kZR3OeeWA8i4w==
Date: Mon, 21 Apr 2025 13:42:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Nishanth Menon <nm@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, linux@ew.tq-group.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <174526093810.2599006.6297495760471249185.robh@kernel.org>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>


On Tue, 15 Apr 2025 12:18:01 +0200, Matthias Schiffer wrote:
> As discussed [1], the comments for the different rgmii(-*id) modes do not
> accurately describe what these values mean.
> 
> As the Device Tree is primarily supposed to describe the hardware and not
> its configuration, the different modes need to distinguish board designs
> (if a delay is built into the PCB using different trace lengths); whether
> a delay is added on the MAC or the PHY side when needed should not matter.
> 
> Unfortunately, implementation in MAC drivers is somewhat inconsistent
> where a delay is fixed or configurable on the MAC side. As a first step
> towards sorting this out, improve the documentation.
> 
> Link: https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28@lunn.ch/ [1]
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  .../bindings/net/ethernet-controller.yaml        | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


