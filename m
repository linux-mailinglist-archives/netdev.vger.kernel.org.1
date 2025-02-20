Return-Path: <netdev+bounces-168165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6777AA3DD89
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC6F7A8B8E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21291D54F4;
	Thu, 20 Feb 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpZTZErM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2C5258;
	Thu, 20 Feb 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063488; cv=none; b=I1w/D30gP5V5v7gCePCZvQH+0HS4Gnf5Ne31S+Ttnv+Ma3n1y3/5tAbsx/Tugb29tGoCFJb+YI6kUk4yHYXl+7SlCSUYmPvhOSNBNG+zmnXihczZlw/fj8j9OPhav/g0Gm1F2QPuqiFNwaAwo3EN8qoc0n1RHiL8OlHw/bH0/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063488; c=relaxed/simple;
	bh=HosbIZJG11434mFm61nco4av3Gmcb9YQ2Or4wPIczj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvEQrGvXUCfZUh9f/hlkWUPeik4cCQa38iM/rZmumXMctwDMpxoxlD20jyck8Q7cwj1FfOb98pelLmpC1zwTkBKm4noOoRrbobbLmtF2sPhIvIgYjo60hBxr0SGOn9dSXJYTMsbWyoepzd5zaoAL6ImICps2O98uk0+V98Ll7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpZTZErM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B7EC4CED1;
	Thu, 20 Feb 2025 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063488;
	bh=HosbIZJG11434mFm61nco4av3Gmcb9YQ2Or4wPIczj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpZTZErMOwiWAt1X/W/AtusEfmQuTQCI6k4VstmWSOHGHJNu8D8yFtKhs6bIMGBiC
	 JGnlkrBrRVADvXWOQZheOrMDTgL6CINCKaU3WHWj6nERCQdXzCvYDxtdnVrttuZnkF
	 Kt1YvwQqBzLvIWeP2kAquxURR4oMq2Ubryq3FgzMJCuNNoO5NoDhT25ecbgYH9w2MF
	 irbwQPft0muThuKsfzhJxFLPG02l8P494DXWGzaoEVfdqJV3IXt9vhJ+/EQ+KYPUVi
	 e+TlRyEd9Po4QogWPp+TqIhRkl6MyLDflxweDp0WDAyvJwqGdLmNvjgLT2mHjx2Owa
	 pKd48hd60Ivsg==
Date: Thu, 20 Feb 2025 14:58:03 +0000
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
Subject: Re: [PATCH iwl-next v4 3/6] ice: receive LLDP on trusted VFs
Message-ID: <20250220145803.GA1615191@kernel.org>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-4-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214085215.2846063-4-larysa.zaremba@intel.com>

On Fri, Feb 14, 2025 at 09:50:37AM +0100, Larysa Zaremba wrote:
> From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> 
> When a trusted VF tries to configure an LLDP multicast address, configure a
> rule that would mirror the traffic to this VF, untrusted VFs are not
> allowed to receive LLDP at all, so the request to add LLDP MAC address will
> always fail for them.
> 
> Add a forwarding LLDP filter to a trusted VF when it tries to add an LLDP
> multicast MAC address. The MAC address has to be added after enabling
> trust (through restarting the LLDP service).
> 
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


