Return-Path: <netdev+bounces-136604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D09F9A248E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F4B1F2403F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9331DE884;
	Thu, 17 Oct 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRbgCPLS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386551DE4F9;
	Thu, 17 Oct 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174190; cv=none; b=FdojNotR495S15/K7ieH2TBF4Qo9px+4GTMjfmgUWR0s9ROy2c9XdMOWbWH53E4i0n1mEpdNl2JVXb7jBXwBoxpf8AWZreo+D+WCbL8dC2xVtJcQOBpAjvjrMl0AFixceGbub4RqKXC8AgAo3+vLxM8HO8symVX1lV96tJKE44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174190; c=relaxed/simple;
	bh=Gv76g9oSJk6TLFlf5zNV7oL9lqSYwyx7xDbQpCSzHcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ3D+6qzoSxUbhm4f8RR4Aw6wrEX+Xy1FmzW3OvNoGJMyqc8XzyMT6ArqbkVryu7jUEG9XtMxqlBTYChNzzWwJvsavsPQHfYfXbn22bZUIzwInktRJwxq4Ja11O8V2ddlmT3Uz1E8RWRcjfjh0Liyp7kNLvtPTFoVewXa4VZu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRbgCPLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65F3C4CEC3;
	Thu, 17 Oct 2024 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174189;
	bh=Gv76g9oSJk6TLFlf5zNV7oL9lqSYwyx7xDbQpCSzHcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRbgCPLStmiQrYDaJ8hLo06ockOMlMVxGuP5F3hc+BSJ0j0S7bvQtxOvILuO9IsFn
	 Om0Tt0qE2wSagqY2Wft0N1W+PPKZLB3OVQk7Ie/dcSs5bCXiwIMyTDA9vjYk0HfAKR
	 PBeUJFMmFltp//I9L8w8ZOiGVo66YTh8MjxoJ0/8YKAdcvkAIGFK1+gBjGutDKZTOo
	 fDBgy1eZBdyqMyg1s7hwWJdYgfgfDK89udTjIcOZiSEDfq7IHb7eIYNXYmcwSegU8o
	 j8ENTeSiIP+qoddv5ps0vsL3qLSghtpPuSutJ9izBWlo3xLb9S72fqLHL3ws2FMFba
	 mHmkdmkgiAVsg==
Date: Thu, 17 Oct 2024 15:09:45 +0100
From: Simon Horman <horms@kernel.org>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com
Subject: Re: [PATCH net v2 0/4] net: stmmac: dwmac4: Fixes bugs in dwmac4
Message-ID: <20241017140945.GN1697@kernel.org>
References: <20241016031832.3701260-1-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016031832.3701260-1-leyfoon.tan@starfivetech.com>

On Wed, Oct 16, 2024 at 11:18:28AM +0800, Ley Foon Tan wrote:
> This patch series fix the bugs in dwmac4 drivers.
> 
> Changes since v1:
> - Removed empty line between Fixes and Signoff
> - Rebased to https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> - Updated git commit description for patch 4/4
> 
> History:
> v1: https://patchwork.kernel.org/project/netdevbpf/cover/20241015065708.3465151-1-leyfoon.tan@starfivetech.com/

Hi,

Thanks for the update and sorry for not providing more timely feedback.

I think that the code changes themselves look fine. However,
as a rule of thumb, fixes for net should resolve user-visible problems.
I see that is the case for patch 4/4, but it is less clear to me
for the other 3 patches. If it is indeed then I think it would be good
to explain that more clearly in their patch descriptions.

If not, perhaps they should be submitted to net-next without Fixes tags
while patch 4 and any others that are still fixes resubmitted as a smaller
v3 patch-set for net.

...

