Return-Path: <netdev+bounces-151414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46AA9EEA1E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F929188C6D6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8D21576C;
	Thu, 12 Dec 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0vRgX4C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274B2080FC;
	Thu, 12 Dec 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015997; cv=none; b=rCxBeMrTR+509S+9fV/AJtgwNorPf0Tyv9TcIJNSlPmzWIy7352ISV0OkLkTx+S+vkBIARRsJ/Y7sBZtcSPsqTbIKBcYP0jGKtBjkw+nI6sNtCQy0lTo3oD8qN1qSxXN9+eUCNe5oRwA8IX1a3PRzPBJ1r7grwtndLM2M5hOvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015997; c=relaxed/simple;
	bh=fhd6N0Wos1BNNs1YgfZM4PBsdPQ2Jg9jH6URkvhfT1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US5N9GV+t4nOCd+bSwQiMJDrjledj1I+44CAiKayxXHGPoQEhBNzTFhyU0ptRRQdQebR8uq0cOhfLP5E/RLwwDcO/sF98gpI6518qs74dOpuZtk1KF22RVUZLBCVpxp6/Ge53FePDOq1/MlNkn+nG7IPg3ZHNxwZQ30GTWagU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0vRgX4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D023C4CED0;
	Thu, 12 Dec 2024 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734015996;
	bh=fhd6N0Wos1BNNs1YgfZM4PBsdPQ2Jg9jH6URkvhfT1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P0vRgX4Cvs6yCQ+tZ4xWOOdsdxj9Ww5uZ/KnObEYpoHsdcT17ldFTTmV3SdrZ4P2n
	 gcN4vsnqCc6QyUwyl7ES3T+nZL4pGPdwLx6K+A2Sa+4oUp12L14u3F4YTkWLe36qiK
	 6GkhWvcRJEjdDovDJDifoH7x2VNdxOYWtqOiaZBdpJwETx/vOJTtr3CgXtNX4cQHXs
	 Xpa4bsNjZl7roDWawVIZQZPqtOD5qhbOmKTmMhNLmEZdQdMYMi2nLQBI8+vRPSq0p1
	 74TyKFoD5qWODUSQ2xirGVf8iU1aVMmzNSvmzzB4Hl1/Iho7B34Cfir4zYKzdEKmHa
	 L2QEHehZtuPzg==
Date: Thu, 12 Dec 2024 07:06:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: andrew@lunn.ch
Cc: Wei Fang <wei.fang@nxp.com>, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, florian.fainelli@broadcom.com, heiko.stuebner@cherry.de,
 frank.li@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH v4 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Message-ID: <20241212070635.5459feb0@kernel.org>
In-Reply-To: <20241211072136.745553-1-wei.fang@nxp.com>
References: <20241211072136.745553-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 15:21:36 +0800 Wei Fang wrote:
> On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
> clock sources for two external KSZ PHYs. However, after closing the two
> FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
> not 0. The root cause is that since the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> external clock of KSZ PHY has been enabled when the PHY driver probes,
> and it can only be disabled when the PHY driver is removed. This causes
> the clock to continue working when the system is suspended or the network
> port is down.

Andrew, could you pass the final judgment on this? :)

