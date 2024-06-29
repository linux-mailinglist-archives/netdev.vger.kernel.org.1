Return-Path: <netdev+bounces-107866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA5991CA65
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 03:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066E31F2276B
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5D4C9B;
	Sat, 29 Jun 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzkLHxDp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF33C0C;
	Sat, 29 Jun 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626389; cv=none; b=VuIFb0ULdpDlC+jNWEOoHxcrXmD12fm/hl45zQ4eP9PiTA6sbHr6RbewBT0hGA3JjD3kJ0PYp3j7qA/I6DCdeGDZVmYCW0V6Fmvh0WGJVVEsFBzd+w/ut2W/UpMHQzq05CrqHjXZJyUAgCMHvoxfyNTudkaklXX/jOK1yh2TKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626389; c=relaxed/simple;
	bh=dxNiEUCiVeI5V98ExqslHQUXuZLzcJJesPgtYyYGyjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rabLsXQbWCn0T69wW9yrPDOtkWXUNR64CPeVow5viJDE2osG6PkPpnGUaXm0dmaJl2a+Z7IKZhlwxa7OP22xx8ptiYV24RHRbm5DBJbF5/bxPysEEUKOGqWq69NKkIFW1l2+L/2VyzzRMpULc0LgGUYmbxg7rKxGxm18VTxaM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzkLHxDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BABC116B1;
	Sat, 29 Jun 2024 01:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719626389;
	bh=dxNiEUCiVeI5V98ExqslHQUXuZLzcJJesPgtYyYGyjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jzkLHxDpFHNnEr4T8Z2KXPJ7qAnVR3MP6YjXJyCCl6JWsqkGbmAiYAlyJF2uChmfi
	 +U8Mx7vu8dyiaN39Lgpros1rSrxgy+jTxlnOdEwBzrKPy9rWcmDsxRaPXKtUdfNEbh
	 AiI3Zp0eiDikY49K/sPVZ8s5XZtcRBQTs8vrfgehvkalUF/+Hpc3wXMEXmY9kAmyYM
	 99KrSQxWW6gxQ2VQ3cCMs3FiUNBKNQioYw5hOZudYlzlmWSmbluZ0fJDa/Epho/jSc
	 IslaajSqdjjzdWkpkO494Q0L5ew1gUzNdXFRPq3+TD9WgLVB9V/9A+aAtYpFCinIWq
	 WwDsBURovvidw==
Date: Fri, 28 Jun 2024 18:59:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
Message-ID: <20240628185947.4e8cec02@kernel.org>
In-Reply-To: <c561738f-e28f-9231-af04-10937fac61da@gmail.com>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
	<20240625114432.1398320-2-aleksander.lobakin@intel.com>
	<20240626075117.6a250653@kernel.org>
	<e0b66a74-b32b-4e77-a7f7-8fd9c28cb88b@intel.com>
	<20240627125541.3de68e1f@kernel.org>
	<c561738f-e28f-9231-af04-10937fac61da@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 17:03:10 +0100 Edward Cree wrote:
> >> It generates sizeof(bitfield) which the compilers don't like and don't
> >> want to compile ._.  
> > 
> > Mm. Okay, I have no better ideas then.
> > 
> > Do consider moving the cold flags next to wol_enabled, tho?  
> 
> My RSS series moves wol_enabled out to struct ethtool_netdev_state [1] so
>  this may not be worthwhile?

Speaking of which a new bit just appeared there, for the SFP module
flashing. I'm gonna merge your series because it technically doesn't
impact it, but could you follow up and move that bit to ethtool state?

