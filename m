Return-Path: <netdev+bounces-61884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DD82527D
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F069BB229C0
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429528E08;
	Fri,  5 Jan 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHMJODsW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A028DDA;
	Fri,  5 Jan 2024 10:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EBFC433C8;
	Fri,  5 Jan 2024 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704452310;
	bh=7VPBGYOpqAVjbMriYWq9KPZB+dzGm77OsE6Z5xm7oSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHMJODsWZcBRtJfHIdw5MgkVCO/43sODxcr0m9PAIAVmo/opXnEUTjDm7DwqwTVAp
	 iBbsOleygpHhiBmuCQ2ma1WQ/OvQYpEVHiT2SB9z6TIJPTY4meK+6EmnmgRwXuHhX9
	 x52LmxJcj7+J92PjIvNylABUqvyjZ0jwfgcCELxa7RsAfheKJkc4jBOffj31kpu29A
	 SH7hFF9DQKe7HUjZkNzRpRFgQmjsX4aB+sSP2UQFKbtIa2jT/QV6ZKQmR/ptFSkdl6
	 sxHTXA2CWZS7iX//juvOMZZnKPR91kkVi7uWjjMD24NssnZehd7LXu1Poybb6t7LO0
	 JrCIIY3DQUJ0A==
Date: Fri, 5 Jan 2024 10:58:23 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, sedara@marvell.com, egallen@redhat.com,
	mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Joshua Hay <joshua.a.hay@intel.com>, Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v2 1/8] octeon_ep_vf: Add driver framework and
 device initialization
Message-ID: <20240105105823.GT31813@kernel.org>
References: <20231223134000.2906144-1-srasheed@marvell.com>
 <20231223134000.2906144-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223134000.2906144-2-srasheed@marvell.com>

On Sat, Dec 23, 2023 at 05:39:53AM -0800, Shinas Rasheed wrote:
> Add driver framework and device setup and initialization for Octeon
> PCI Endpoint NIC VF.
> 
> Add implementation to load module, initialize, register network device,
> cleanup and unload module.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Hi Shinas,

a minor nit from my side.

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h

...

> +#ifndef UINT64_MAX
> +#define UINT64_MAX		((u64)(~((u64)0)))        /* 0xFFFFFFFFFFFFFFFF */
> +#endif

nit: UINT64_MAX appears to be unused, so I think it can be removed.
     Else, perhaps the code can be updated to use U64_MAX instead.

...

