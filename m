Return-Path: <netdev+bounces-83914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200F894D85
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 10:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A382E1C20E88
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAB45948;
	Tue,  2 Apr 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abdPi9zM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D393D996
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046675; cv=none; b=EJ86wAhaKkoHk9zNmCm8mvolrNEOxzpBOEdT/ImYwsk9ZeR8LrhpVRD8BkdJvt/6EwYgLO0pUge0q1tKSfZ0tzNUF9ZWxuHUWHkQDoc1Jw8S2djmGiiuWkq8NAdSoN3pCqtS/pxSaWGMEqtO762buLcgEVPOILDr/qzMu1eFqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046675; c=relaxed/simple;
	bh=Ui0tid6TRIOKrbC2k4Bsxf46+tePZJcc0J/KJb8yQ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js+/iFUj2nwp2tH1OdG9IFLzZRHiIWq8prZBYZghjpVtVkQnTqTF+dIjdJCNt584m6TIZNyEPedjpvG6ehHO3B/AnFR8r+zBSogLdL4hdhGOi0una+Xa/Pbd+S5Ouq5Erh9p1Sq57ZtMbt8+ZtaiFCq8vvtDBi1H+o+hLHVN/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abdPi9zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5441AC43390;
	Tue,  2 Apr 2024 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046674;
	bh=Ui0tid6TRIOKrbC2k4Bsxf46+tePZJcc0J/KJb8yQ18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abdPi9zMVwc8B/X8IyFvJBKCg63aod2sDa3kW+A1wCDEazrCUwXpT6rhef5qf2JIS
	 6LBD8bC6UcDh33pJvO/wZ2OIanHtFP9AHb5CmXrHpXm58cOgdeI9yAWiPFX28m2UiX
	 7043sBdBPA+hKLFMvmyShuQPpJ/IOMv6nYsYwWq2dYmnjJfr1bFWFElwUH1SYEFrMq
	 rLzJFw7PVX/FKhuYh/CYwuZU3pIPiRk4BZ9zOTr0VhdklYTRKOqbsSw/2Usj+HwhtB
	 k1NvvEVyeXry+hTD3FpLhPSCNyE1N155CUy/D7H5VOl7c/0heo9nYw6939JfS+Cf2c
	 eald+BpwQG/AQ==
Date: Tue, 2 Apr 2024 09:31:11 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix issue caused by buggy BIOS on certain
 boards with RTL8168d
Message-ID: <20240402083111.GI26556@kernel.org>
References: <64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com>

On Sat, Mar 30, 2024 at 12:49:02PM +0100, Heiner Kallweit wrote:
> On some boards with this chip version the BIOS is buggy and misses
> to reset the PHY page selector. This results in the PHY ID read
> accessing registers on a different page, returning a more or
> less random value. Fix this by resetting the page selector first.
> 
> Fixes: f1e911d5d0df ("r8169: add basic phylib support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


