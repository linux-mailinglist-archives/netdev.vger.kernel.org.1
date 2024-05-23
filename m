Return-Path: <netdev+bounces-97745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE78CCFA0
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76BA283FF6
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523E513D2A6;
	Thu, 23 May 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIj13VRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3013CFA3
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457727; cv=none; b=l3MWD4HNG471tc8tgNBR2Aia8L3StvEDuCc04Hqft4ggw5EjyvL/C+YkjBRTpsv9S1ahEC2pcGMLjjRYHSJejFVA2sK2vWPoSR5sYGoquU0GAdCEYPCOGNSNoAVZ6xIOUHcpH7vE2EO85UIbLRu/PA1071PIn0BRt7eUasNXQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457727; c=relaxed/simple;
	bh=UHtiYzo2kZ/rPP1BFXrmwXSiZCDuuBqhlgn0vOnyMI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8vZFbGJbdLF7uJ0sqaC/ndrnJxAKXPUKcFjBnMmMGv7q0fEPw9jCqNf01w1QBVoJwZxG4peGhJch+F0GyqPykG/mEfugtk0PodwnyIoR1LH4lCMFcdMzIzPi+VuFRwcirVK2DCf2hLIexQF2mX+TFvSSDPvjzVHtiz9oMoK0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIj13VRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C716C3277B;
	Thu, 23 May 2024 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457726;
	bh=UHtiYzo2kZ/rPP1BFXrmwXSiZCDuuBqhlgn0vOnyMI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIj13VRnH71mRZMstHarGQuwsSV4VGnHC+mHM2Ak6btRTJXHJm3m25BSkD5VP/t56
	 vpQR9yacveb8v2tDqI7hYFNI/6Whn0Z/trvA0HoxKMQQYDwHmz2CzZjcWr2OmzDyLB
	 Hl7fZBLGi7PznG3MilkG/cCzPFdAf9+yWxZy0mstuXCqi6+P/qevhFZcREF8Pqq8cf
	 grcKFdUIqTe34M1PddOCyB1qnC2EANKeo8AtJHhjK9VqOg7VNrnFEROYAf7qj8hXvy
	 ztbtl2ql1WJxvSgTPJB83MwYt8eYx46aNuJbDz9TPNwKlEo8kTdfR+JLu652mL9ow0
	 Fy2rwMzR0Er9w==
Date: Thu, 23 May 2024 10:48:42 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net 7/8] net/mlx5e: Use rx_missed_errors instead of
 rx_dropped for reporting buffer exhaustion
Message-ID: <20240523094842.GJ883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522192659.840796-8-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:58PM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Previously, the driver incorrectly used rx_dropped to report device
> buffer exhaustion.
> 
> According to the documentation, rx_dropped should not be used to count
> packets dropped due to buffer exhaustion, which is the purpose of
> rx_missed_errors.
> 
> Use rx_missed_errors as intended for counting packets dropped due to
> buffer exhaustion.
> 
> Fixes: 269e6b3af3bf ("net/mlx5e: Report additional error statistics in get stats ndo")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


