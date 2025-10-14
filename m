Return-Path: <netdev+bounces-229134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6CDBD86CA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BD134E6BF9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B752DCF7B;
	Tue, 14 Oct 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2VIJnvj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0725D546
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433935; cv=none; b=q/QvSSZcCpN8lic6y3j5Q5gUX7f1+suTwAnlCcB1zJkO20UxrlveaHkZX1RXoqCLgjg0fi6ZrcAwg7BNQsXRAYkzcSVwmF4AThfydQN1cJ1cidJ2ghpqMc/H3q+VLiQ/1LengEBsGMW7XEbP6wB2C9apho0diFlQP/kmOXCZyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433935; c=relaxed/simple;
	bh=8Mpb15od7JA5MjgB34GiY42X9T1Dma3DJCUBcLWR5Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMR4Mo2+zBHpg5fT3H/81nv+tfrmQKX1IRqlDzuM12NWqgBl3qLuol1pIi8uF2vw/ChDlO6FlncRI2nupV4EVPcwm0nQte7ppem4tZgWx4rXHRsJd37b5U4DIgBtmqGcWZQlqoLAOuAGJqD/HHhpwqHQGdkOB+qs/3UWn19ruiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2VIJnvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD8FC4CEE7;
	Tue, 14 Oct 2025 09:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760433934;
	bh=8Mpb15od7JA5MjgB34GiY42X9T1Dma3DJCUBcLWR5Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2VIJnvjeULkqo+jYu3MvXTdSpkss5eKcDIMzGYsUp3pWCeEXwq+shs9TcZ4PxS/V
	 GpMekWpp7laGilxhFxm4nwbvwhNL1qw32IaJfSvItJxyh4CmM/RtUl93JR9ex1ohCY
	 znUyPA0CmOYaYXnWOxPeJULE+yQIeoYJLcoqiEY5hhB7tK01obDPy101yM7pK4xDjj
	 UMCVcJtT0yvKXp1ITzvmMhH9yWZI5OpzZ4zKH/guopeGKH8LpeKEtZQeGIX9akt//R
	 0566OisOS/MhbuLghBymw8ZOkxOc1+1sRewCBbMawDo/6Ii+vE04JTPBYSjcAIqN2Q
	 FmIU3KgDSK3GQ==
Date: Tue, 14 Oct 2025 10:25:29 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, decot@google.com,
	willemb@google.com, joshua.a.hay@intel.com, madhu.chittim@intel.com
Subject: Re: [PATCH iwl-net] idpf: fix possible vport_config NULL pointer
 deref in remove
Message-ID: <aO4XCSu0jZ57k-1Z@horms.kernel.org>
References: <20251013150824.28705-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013150824.28705-1-emil.s.tantilov@intel.com>

On Mon, Oct 13, 2025 at 08:08:24AM -0700, Emil Tantilov wrote:
> Attempting to remove the driver will cause a crash in cases where
> the vport failed to initialize. Following trace is from an instance where
> the driver failed during an attempt to create a VF:
> [ 1661.543624] idpf 0000:84:00.7: Device HW Reset initiated
> [ 1722.923726] idpf 0000:84:00.7: Transaction timed-out (op:1 cookie:2900 vc_op:1 salt:29 timeout:60000ms)
> [ 1723.353263] BUG: kernel NULL pointer dereference, address: 0000000000000028
> ...
> [ 1723.358472] RIP: 0010:idpf_remove+0x11c/0x200 [idpf]
> ...
> [ 1723.364973] Call Trace:
> [ 1723.365475]  <TASK>
> [ 1723.365972]  pci_device_remove+0x42/0xb0
> [ 1723.366481]  device_release_driver_internal+0x1a9/0x210
> [ 1723.366987]  pci_stop_bus_device+0x6d/0x90
> [ 1723.367488]  pci_stop_and_remove_bus_device+0x12/0x20
> [ 1723.367971]  pci_iov_remove_virtfn+0xbd/0x120
> [ 1723.368309]  sriov_disable+0x34/0xe0
> [ 1723.368643]  idpf_sriov_configure+0x58/0x140 [idpf]
> [ 1723.368982]  sriov_numvfs_store+0xda/0x1c0
> 
> Avoid the NULL pointer dereference by adding NULL pointer check for
> vport_config[i], before freeing user_config.q_coalesce.
> 
> Fixes: e1e3fec3e34b ("idpf: preserve coalescing settings across resets")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>

Thanks,

I agree that prior to the cited commit adapter->vport_config[i] being
NULL was harmless. But afterwards a NULL pointer dereference would occur.

It also seems to me that the possibility of adapter->vport_config[i]
being null, via an error in idpf_vport_alloc() has existed since
vport configuration was added by commit 0fe45467a104 ("idpf: add create
vport and netdev configuration"). (Which predates the cited commit.)

Reviewed-by: Simon Horman <horms@kernel.org>


