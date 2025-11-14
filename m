Return-Path: <netdev+bounces-238628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6FC5C31F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7383BD1B1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B93054F7;
	Fri, 14 Nov 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6Uq+CGS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB12D5944;
	Fri, 14 Nov 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111709; cv=none; b=j+0BolaSjvouqCqaNDfPajnIm3anNIPML9XMCrxzu87q4PvMP9bbwJnGh/SXWgMR2Brnay/UgzrUf4H98HufXJ/vBBPQn01HczbT0rY9mAn0a3JXc6Y2W18b8Sxt4TDgEF2BP4mz01YfcmiJONAyX4jCbv8CIOUPleeuskV7i5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111709; c=relaxed/simple;
	bh=kbbz3wPLsY8nHQqv/+1SqRtx1it+jT7BWo1yvJHgzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bkyn63eB70hLL007VmWOsE9LZhZg+ZkDpdMLOqaRS66Fs8EKiDcQV0K3YIVRszaYm75UVH+mJgo6aJoK31HbxuiXLUm+Hdd7kTMZmN1tWABwvnDjo8ipvQfIUAosmScH9zHxZPYooEMAdh+qFITHIPHa9wz77CRNoCR56RqkNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6Uq+CGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC346C19425;
	Fri, 14 Nov 2025 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763111709;
	bh=kbbz3wPLsY8nHQqv/+1SqRtx1it+jT7BWo1yvJHgzbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6Uq+CGSHZEcFvyGEAUK4pc9y33nD+Jt6d6Ud5m2nl90pHN8xFkNSeLIVJloO1kfr
	 oAg7QzRhvlYEiN3dmhejq2EJc07MRTDkwC21KkfzJbXtp+rTwNlPOTx8jTj0JnlbBi
	 2gLqlvWOEyquRPYl9sTbJaa3Ub9A+mNOHT3l1ODPaR4Bu4GvmOKh5JWxpvnDbFubMS
	 gbr+apaUh7HffU8O4atzgS2qPZKmAPGmPifnoGW0qZ14S65qSs1C/3ukWYHrh2VvuM
	 skZmJNXmXo8bxBnny/DiciS9f8PDatyii7JrAAiy2D9M2Ot6WH/C7U9JIVfnD04ck2
	 fDHQJgQheIvsQ==
Date: Fri, 14 Nov 2025 09:15:01 +0000
From: Simon Horman <horms@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v8 3/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
Message-ID: <aRbzFUWzvkiLO8wx@horms.kernel.org>
References: <20251114003805.494387-1-inochiama@gmail.com>
 <20251114003805.494387-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114003805.494387-4-inochiama@gmail.com>

On Fri, Nov 14, 2025 at 08:38:05AM +0800, Inochi Amaoto wrote:
> As the SG2042 has an internal rx delay, the delay should be removed
> when initializing the mac, otherwise the phy will be misconfigurated.
> 
> Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


