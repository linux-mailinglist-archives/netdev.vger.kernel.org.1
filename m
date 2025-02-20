Return-Path: <netdev+bounces-168163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B9A3DD6A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75437AA68B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D21CEAC3;
	Thu, 20 Feb 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqbN+rMI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09A5258;
	Thu, 20 Feb 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063343; cv=none; b=eqzwKqJyrU4J7DeAw7lCJgRyv7wUHK55DPIErwDI3YbL4/FfgO0+/Zz6aABhK4GxlXl/q7G/9v5jnU06AkRRrv6DiSM/nNsHlKuey5Far/J7wBn74KPZa5wgAsg6TLrmmB/LMXFsaa+vqNZ7CXTaArrB2yitvA+yjy673Rv6ee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063343; c=relaxed/simple;
	bh=1wBmMz7u7tSMtb3T+ELX1xYQjD8A2MBdGOR+4eYPPxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaX5Pm3ojuHGyt6IfuJX5zAJbhUYUKzoIg8PoMb6R34RQDYId9h8nRtSVVXEi9iKO0V/IhCJtTCOHMV8P8//3SOd1igSo3wvrT027iH1zJFC00byIvJo4axS3SmLDlqxSHjx2LPMZWbN61CcY3S5/9XgztOuzpghIsKRT69I80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqbN+rMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CACC4CED1;
	Thu, 20 Feb 2025 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063341;
	bh=1wBmMz7u7tSMtb3T+ELX1xYQjD8A2MBdGOR+4eYPPxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqbN+rMIp1x6f5GiYAdoBKn/qoMLYCaBZ3JuA/jY0GB95WaBdjUYxEqIuS4Gb5mkE
	 414KGqehua4APLsKOawywiH9estBct1taKADqsIMyGq5vTdOH6lTfZ+13pR3972NmI
	 5d+50QzpdRCU+ZCNKrcqhxd5ZQ2apVlbGezDOVwkRV3EjzWi63SIgPvYb18parKx2P
	 oSHJ2QZZbn6LE2CfjveQSwJKrEO3/6VKfKjEzrt7OY1gPAPOO5+ZEi39F19oA1u/xK
	 BrE4uFpUx70ZQKwnSooswrN5K/KRGEEOQQ5dHsWUnMLdk9uZXhISNfRSRKdG5wrdqx
	 nXPMgY9CUAeZw==
Date: Thu, 20 Feb 2025 14:55:37 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: Re: [PATCH iwl-next v4 1/6] ice: fix check for existing switch rule
Message-ID: <20250220145537.GY1615191@kernel.org>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-2-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214085215.2846063-2-larysa.zaremba@intel.com>

On Fri, Feb 14, 2025 at 09:50:35AM +0100, Larysa Zaremba wrote:
> From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> 
> In case the rule already exists and another VSI wants to subscribe to it
> new VSI list is being created and both VSIs are moved to it.
> Currently, the check for already existing VSI with the same rule is done
> based on fdw_id.hw_vsi_id, which applies only to LOOKUP_RX flag.
> Change it to vsi_handle. This is software VSI ID, but it can be applied
> here, because vsi_map itself is also based on it.
> 
> Additionally change return status in case the VSI already exists in the
> VSI map to "Already exists". Such case should be handled by the caller.

FWIIW, I might have made this two patches, but I don't feel
particularly strongly about it.

> 
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


