Return-Path: <netdev+bounces-27096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DA77A5B6
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A108280FAC
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F41FAD;
	Sun, 13 Aug 2023 09:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE517E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 09:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E2EC433C8;
	Sun, 13 Aug 2023 09:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691917289;
	bh=ftsqMJ7kJK3s47sRpTaRHWrIiHYrq6d1XOWO+4W1p/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssGlu5slnGCFLJD3g+4F6Xf3YrCIaoaRS7KM3COtj0SLcej36uvUYzGYJ3Il+MZda
	 3oblaDRGBYyFtDVieyaMnnVbyH+yP+bwl1EzbnxON/BkaEWSj4YX/jPyuBilLBKXK5
	 sxyhqP1qIVz8LiMLRpuU0O6cxSNrXR71JgSJsu6UPVm4DDNyhfrYH6VZK+9ozIVg8z
	 oU6LVq3gMThWBoohmJyA45wqlQxFxps5JzNL6JAreSnGNBJoGmAX+DNnnb8Z7Tcb0K
	 RPz7ziPbwqTATqrAeIWLGxpzC4X/mj85oPtUupwSKu//fgRt3sib0S3w2AaFvYRAGL
	 ZxIRi63wx9SgQ==
Date: Sun, 13 Aug 2023 12:01:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>, sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 2/2] e1000e: Use PME poll to circumvent
 unreliable ACPI wake
Message-ID: <20230813090125.GF7707@unreal>
References: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
 <20230810175410.1964221-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810175410.1964221-3-anthony.l.nguyen@intel.com>

On Thu, Aug 10, 2023 at 10:54:10AM -0700, Tony Nguyen wrote:
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> On some I219 devices, ethernet cable plugging detection only works once
> from PCI D3 state. Subsequent cable plugging does set PME bit correctly,
> but device still doesn't get woken up.
> 
> Since I219 connects to the root complex directly, it relies on platform
> firmware (ACPI) to wake it up. In this case, the GPE from _PRW only
> works for first cable plugging but fails to notify the driver for
> subsequent plugging events.
> 
> The issue was originally found on CNP, but the same issue can be found
> on ADL too. So workaround the issue by continuing use PME poll after
> first ACPI wake. As PME poll is always used, the runtime suspend
> restriction for CNP can also be removed.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

