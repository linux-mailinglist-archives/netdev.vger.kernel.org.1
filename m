Return-Path: <netdev+bounces-164927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40F9A2FB29
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203061882BDB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E01BD9F8;
	Mon, 10 Feb 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug5yZVgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE1264609
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221180; cv=none; b=u0wl9DS/MhaiZy5AkffJPJA6U8L7+T76TMNhan8a3fXMkA8K6OB6QYa771CdiIlli2AZCQlmIz//ldfII1TOITzRU61m+cmKnUdTwVM3acEUYTKrVZ26opYYfu63s2rNZB+dLTA7aU7F9Hf/dVre+P6QNJblRUGdkRbie5VvJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221180; c=relaxed/simple;
	bh=PTkTYkscwOyBi14GEU1ClW0elvE2FVK6kLlhHo4tCK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDFgv7TuyrbvHAnEILS0aPdbPXMB3zVajcfblLxigKA9ygjRjg/pqRdTatA9ccljy6s4jl2dWXHP6osTjI1WwWPwUyDg1WXCUgngBHbrvuI5N5qE53AXqeXBaW24uluAtyZ2FnDyLBQFlIEqYS8cfv4s3ovT2wL7CdfviAFPGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug5yZVgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9095C4CED1;
	Mon, 10 Feb 2025 20:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739221179;
	bh=PTkTYkscwOyBi14GEU1ClW0elvE2FVK6kLlhHo4tCK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ug5yZVgolA83veJPOkjT6JDh6WBpfkLEB3cVX1oOp+Vsww5SGPNJDQv/F2w6s2ReB
	 MjisbUbCCGrkLo654gC0E1mgf5OFa4paZKk7dQJLu2IGxM+kqx3pxq1pl70u6orA5X
	 8cs1Az6DVIzFWPqEdia2qXigUPCWUHGjw5ZnHvZqACRKcsan7U2eOMW1VfculKm73w
	 9Dqoc38OAhELH3jGelwp+surp4J6Kb67pDCutql3wVLy6ddLnjmaPrw7ukhN0bAQgx
	 TSB6HMoSAzmaN7DS47pOcqvRqoSecnfHbBm4x3Xk6oJBY4s8oCl85O0V+cxMFu19nr
	 ImnKtKQKqWDdw==
Date: Mon, 10 Feb 2025 20:59:35 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next] mlxsw: Enable Tx checksum offload
Message-ID: <20250210205935.GD554665@kernel.org>
References: <8dc86c95474ce10572a0fa83b8adb0259558e982.1738950446.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc86c95474ce10572a0fa83b8adb0259558e982.1738950446.git.petrm@nvidia.com>

On Fri, Feb 07, 2025 at 07:00:44PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The device is able to checksum plain TCP / UDP packets over IPv4 / IPv6
> when the 'ipcs' bit in the send descriptor is set. Advertise support for
> the 'NETIF_F_IP{,6}_CSUM' features in net devices registered by the
> driver and VLAN uppers and set the 'ipcs' bit when the stack requests Tx
> checksum offload.
> 
> Note that the device also calculates the IPv4 checksum, but it first
> zeroes the current checksum so there should not be any difference
> compared to the checksum calculated by the kernel.
> 
> On SN5600 (Spectrum-4) there is about 10% improvement in Tx packet rate
> with 1400 byte packets when using pktgen.
> 
> Tested on Spectrum-{1,2,3,4} with all the combinations of IPv4 / IPv6,
> TCP / UDP, with and without VLAN.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


