Return-Path: <netdev+bounces-180458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2B6A81608
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03DB47B17EC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600D248864;
	Tue,  8 Apr 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAXWz1Sx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B1246335
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141854; cv=none; b=QmRqPZzVM6IKpRfOHQKWeoP3gS23OfSpPB0NxIFcHjyXNpHytsuNhwubFyInakgR9Wtfh3mNG8vDfx/bP8uN0vRBWaBL/rDppRBvKzqq5gpwE/g3OocRdtsHqHegiXjNdQDGVDDEp3ui1DTNj8THNdthGV/U6siR0hKBhNiOme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141854; c=relaxed/simple;
	bh=Cl6FMiR8V/WqCdufAIYky9qQP+eWaJzEf8Abe6gD4do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDK2vsWCCaG//Re0/vZHNGv1dXfJT59SrsuyJgU6psjLEaqo8bSDpb4begfO1R9nCdgf6xioyO2+PLm67gHSkPL+bWwkTzkBJzIPFjXXZbGTSNTAM11nSoK+DOaj3X30lhq4aaTpBFQSy8ErVFx/c04IFpZOjjAaWKL0gDDT+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAXWz1Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B76C4CEE5;
	Tue,  8 Apr 2025 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744141853;
	bh=Cl6FMiR8V/WqCdufAIYky9qQP+eWaJzEf8Abe6gD4do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oAXWz1SxIH94bJE5hQcX3QcDb7RE41fDs5qfkhPHCjriewW32cSx64hKSoTVD8C4T
	 PdmYuHtgTBh+pkh4EVaKfcTEWqUjo5R+obn7NdcvUb/In/eDBrpoABs74s+PAye+U/
	 5Bl4BbX+sOsbhrWiNYcLFrJn/PZtfWQTdbRTLmmiqUxP1VPgIODC5VzzYXJ1hpmQPD
	 zZhlMmyrksSzjYFLRsqxrrLp18hbU4NCxk4tfLM9FfhNvrjFBABL7mqZDyHgTHgtLa
	 cUGwwHjEcHpOnYA07e7fvmTW1YuHJnxFuv9OVG6QbwVUcTwbJbeYuWqJp91+UD/2JY
	 2Tbt2M9uNgP7w==
Date: Tue, 8 Apr 2025 12:50:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Richard
 Cochran <richardcochran@gmail.com>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 0/5] net: stmmac: remove unnecessary
 initialisation of =?UTF-8?B?McK1cw==?= TIC counter
Message-ID: <20250408125052.50615419@kernel.org>
In-Reply-To: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 19:58:01 +0100 Russell King (Oracle) wrote:
> In commit 8efbdbfa9938 ("net: stmmac: Initialize MAC_ONEUS_TIC_COUNTER
> register"), code to initialise the LPI 1us counter in dwmac4's
> initialisation was added, making the initialisation in glue drivers
> unnecessary. This series cleans up the now redundant initialisation.

Failed to apply patch:
Applying: net: stmmac: dwc-qos: remove tegra_eqos_init()
error: sha1 information is lacking or useless (drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 net: stmmac: dwc-qos: remove tegra_eqos_init()
-- 
pw-bot: cr

