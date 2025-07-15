Return-Path: <netdev+bounces-207210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B24B06409
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ADB581D88
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2850273D8C;
	Tue, 15 Jul 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efmTp12Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE07257452;
	Tue, 15 Jul 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595952; cv=none; b=to/9ebZnkns0EhDVmaP+6jabMZL3pF5Xuh07QiUfRPFrGEvuME7jwHkvolhRoTkfATDanQcW5ykR7CjyNEXHjMKJ/jj/FyK3veoeh7nMGleqfm8rNVO8i/oQuGYCJeQk+fVUFoMCTnTr2QiAAMrZm2odqMIcM4yPnhV04RR+f2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595952; c=relaxed/simple;
	bh=nJZWdtM9uRGXUb4Ns2ouwUrYB0TxfLJdIw+jw5/2hlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tat6atImRJ36mfpGFeIXvNRQDxX+5XJoKFDVQVO0lu+rb7a+5cI4khKrmdWFaHIXxr7lv+KgbNguJeT6aIiJI9NfltYdeTxfxm5Bvux5KCeqXdL8cWlEpIYCU2rCrM3CJ3jii2CelTB3aPh8/XpfjXBerm9xIyHPcBMf7KiHKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efmTp12Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F2C4CEE3;
	Tue, 15 Jul 2025 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752595952;
	bh=nJZWdtM9uRGXUb4Ns2ouwUrYB0TxfLJdIw+jw5/2hlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efmTp12QjvO0Upv8iLLUGRHl2bquX8b0iwFxjfM2GLiEDfEnnxhvWH8AbJGzWk6Pv
	 22h3SFQl9kd+BtExRYgwyzxl/45Wo8LjnW8tJj8+HP8GxumVSIrndoJ7JuESn2xwPv
	 roiyKItpyoWDtdjhA8e/N9V0McUmBkt79MOekrrscaEQUjcShl2jeq+MAc7PFfFban
	 YDOEOivSGooG8kWOvZoGXjpF8gSsbU3il+qh2BMhIr7pLHSpL9yETouS2ROCExB1HK
	 i4wr734XJBgpy1zmN20bvcGlxJC8in93oVeto5L3gKTu2QhlwIp0T+2KBLucxfGXjz
	 hIUyulo/VeXlg==
Date: Tue, 15 Jul 2025 17:12:27 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: [net PatchV2] Octeontx2-vf: Fix max packet length errors
Message-ID: <20250715161227.GE721198@horms.kernel.org>
References: <20250715111351.1440171-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715111351.1440171-1-hkelam@marvell.com>

On Tue, Jul 15, 2025 at 04:43:51PM +0530, Hariprasad Kelam wrote:
> Implement packet length validation before submitting packets to
> the hardware to prevent MAXLEN_ERR. Increment tx_dropped counter
> on failure.
> 
> Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
> Fixes: 22f858796758 ("octeontx2-pf: Add basic net_device_ops")
> Fixes: 3ca6c4c882a7 ("octeontx2-pf: Add packet transmission support")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> v2 * Add the packet length check for rep dev
>      Increment tx_dropped counter on failure

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


