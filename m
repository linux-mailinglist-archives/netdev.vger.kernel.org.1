Return-Path: <netdev+bounces-136629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C769A276C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60E51C20D97
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57661DED58;
	Thu, 17 Oct 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFefRboU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073117DFEF
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180448; cv=none; b=O3YH/BHkRU+lahTBHJBpCQJYlFLeVt585mLDt6sgfCRx/xCaPRK0Fi21xM+jkBzdJEguq5G8QK5LyND6gaEUcwLPkc975ekzXZF8KPcbO9ImiOAdyjscHbKwsGtscFys3JnFIObdxQgdJZ6LODktmLdoZArhjcWaspt4ZvU3nvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180448; c=relaxed/simple;
	bh=3ndDiBqRuzTSa5hViSX3e6v1SrdrtxvSt0Vx6ozUauA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXsOiDB2QwXiONYbgWUTe0JZ65YJQNrjqa7r5dPrGY+wCGPe/HOR/ynR6ruo55cHu1GGmyTH6o7zP1tDoeTL2M6ATa6SrvoLidyO+aqCyIbvKQt+eGZhwvw72v8hy4BgzcFq7WztPXmaZwYFSNENzxdeNBqNLiyrSZOWINe3VZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFefRboU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBC1C4CEC3;
	Thu, 17 Oct 2024 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729180448;
	bh=3ndDiBqRuzTSa5hViSX3e6v1SrdrtxvSt0Vx6ozUauA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFefRboUZbYI7+o0nvlnkS/DURIDlsb42a8Pxx/jeq5k+7nQ4nSUbT7E8ct8hN10E
	 PByzxiKC5zjZyHqXeAgxcevVtt35XsjeXAfC86BEqOVsr45Y7jK/smPUHmhBIqKJ1m
	 gqjI3qPXO3/US46f5LPb81Z+mVQMVkIXJD5Pm37eFWJytx2gUaEGGtxam1RC5YzgNf
	 Uzbd1i7ur2bovKRv1G9wMQ8ZDWblN7hl8Pa03tqh3E9yljegJXWzW3MwCEjYeNFXoA
	 /kFO+MGZEwtPXQ1EmCWHCItlRkdHI6bWk0kohG421q3KJjbM3Rw+e87tTe2hgtw6J0
	 vo43qq4hOotDw==
Date: Thu, 17 Oct 2024 16:54:04 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: avoid duplicated messages if loading
 firmware fails and switch to warn level
Message-ID: <20241017155404.GW1697@kernel.org>
References: <d9c5094c-89a6-40e2-b5fe-8df7df4624ef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c5094c-89a6-40e2-b5fe-8df7df4624ef@gmail.com>

On Wed, Oct 16, 2024 at 10:29:39PM +0200, Heiner Kallweit wrote:
> In case of a problem with firmware loading we inform at the driver level,
> in addition the firmware load code itself issues warnings. Therefore
> switch to firmware_request_nowarn() to avoid duplicated error messages.
> In addition switch to warn level because the firmware is optional and
> typically just fixes compatibility issues.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks,

I agree that this is an appropriate use of firmware_request_nowarn()
which allows for uniform logging of error conditions by
rtl_fw_request_firmware().

I also agree that warnings are sufficient.

Reviewed-by: Simon Horman <horms@kernel.org>

