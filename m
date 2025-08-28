Return-Path: <netdev+bounces-217582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB5B391AD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2A53679AC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3951F4C92;
	Thu, 28 Aug 2025 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy7w7Z+g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E51C5499;
	Thu, 28 Aug 2025 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348267; cv=none; b=MLDrYxbAIWs+BZbkwCMgUmQHpe2K7Y4aUvC70ijeUTs3rZa48IzG05so2/LpJTQWsy7YJF6EAdDTTveznWBT9g9fhwNyr8mj+li++wUWCDBX27i4z0qMqNM/W3jGA8kUNzV53+oBbWekuv/rdi4JVkNSpy4zXuYgrx/EPXPVF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348267; c=relaxed/simple;
	bh=Jp+q+OMH44/A5s5dMrV18NukkMjsoCFKlwXK6QRC9c0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmPK6tVihkznZcm/L0xYdQIm57awiB+PFecpN5cAmVFHdrQ41Z8lUer6rVRDbB3c7PqnoTGBGDxu1Cbfs1ddCDCJhrG/1fO6jHCelDG2n36wmDtbKHqIR1zrHGhtjbZCFYKH/Gl3jtg/ug26FI++2JBafjJU/oasONIGsVwEvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy7w7Z+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99700C4CEEB;
	Thu, 28 Aug 2025 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756348267;
	bh=Jp+q+OMH44/A5s5dMrV18NukkMjsoCFKlwXK6QRC9c0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gy7w7Z+gTiX4okHiVGemqZyKkOvwfjqvIB2fVFE/FzwchMy1SjtHL61AQhk1Yj5a0
	 e0iRWpLsvQ8BBCxMLQjJVzH7EgP53BxAPOZOWv2cPGztSUS2NeUuDeej8PUIOEH973
	 7xX1hdDIYDR3UfVvmXQgZtR42X+grk8y8tOx03VyVq546yR2NJyI3ripWcLqlFNuF4
	 rTiUjlNHeDI8SmGuq3FdDnth1PlWxz8GuEsc6p+esGHZV+ebXa+ajsoIeedijpju9+
	 J/0bVn8d+beYlAim3UDQQZlEUd+vSVW7P1lIBxK3ooODwdMxjqTQynmuusrkfCh5aR
	 VgahFsmkF5J7g==
Date: Wed, 27 Aug 2025 19:31:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
Message-ID: <20250827193105.47aaa17b@kernel.org>
In-Reply-To: <20250827-relative_flex_pps-v3-1-673e77978ba2@foss.st.com>
References: <20250827-relative_flex_pps-v3-0-673e77978ba2@foss.st.com>
	<20250827-relative_flex_pps-v3-1-673e77978ba2@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 13:04:58 +0200 Gatien Chevallier wrote:
> +		curr_time = ns_to_timespec64(ns);
> +		if (target_ns < ns + PTP_SAFE_TIME_OFFSET_NS) {
> +			cfg->start = timespec64_add_safe(cfg->start, curr_time);

Is there a strong reason to use timespec64_add_safe()?
It's not exported to modules:
ERROR: modpost: "timespec64_add_safe" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] undefined!
-- 
pw-bot: cr

