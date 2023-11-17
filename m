Return-Path: <netdev+bounces-48724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2BC7EF59A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829FA280D43
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2637166;
	Fri, 17 Nov 2023 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npRlYqk9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3EC3715A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE785C433C7;
	Fri, 17 Nov 2023 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236170;
	bh=Aoh0dFvn0UBfxZQ2EJTNf4opW0NJKSrjMNK4s7gCW6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npRlYqk91oTCUf+l3JXlXgqsBBcJVm++eiDhFrTdQu9SEUhwKBd2bRTyPP+dB20pK
	 H4O0y1MFsUT/KF85YelKYeGK2bGMTFrERWq0Tk2qCwCadF9wguUVmK/Q6M5wJ8vTHp
	 4KcOezhuqUMiS7nJ9d8jcFeFewXTf3Gq+vUq+vko6uVvQRPa9iPmio3IIUoKqeXL+5
	 znSbyi7NzwnOWjd63v2HYUsZGsp6b123pJ5pnV+UfhXAYP8ThB0AOuF9tFjUt5W9nr
	 Th7mIYPg+3JCwOcW3bZyfz950zPv8CdGUyAbgat5pOu1RjSnEasNPPPZBrp7fCAhIk
	 tuQFi1aSIwjlA==
Date: Fri, 17 Nov 2023 15:49:25 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 02/14] devlink: Acquire device lock during netns
 dismantle
Message-ID: <20231117154925.GF164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <e22be2464d90ae9c7b80e17570e95aea9615dea3.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22be2464d90ae9c7b80e17570e95aea9615dea3.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:11PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Device drivers register with devlink from their probe routines (under
> the device lock) by acquiring the devlink instance lock and calling
> devl_register().
> 
> Drivers that support a devlink reload usually implement the
> reload_{down, up}() operations in a similar fashion to their remove and
> probe routines, respectively.
> 
> However, while the remove and probe routines are invoked with the device
> lock held, the reload operations are only invoked with the devlink
> instance lock held. It is therefore impossible for drivers to acquire
> the device lock from their reload operations, as this would result in
> lock inversion.
> 
> The motivating use case for invoking the reload operations with the
> device lock held is in mlxsw which needs to trigger a PCI reset as part
> of the reload. The driver cannot call pci_reset_function() as this
> function acquires the device lock. Instead, it needs to call
> __pci_reset_function_locked which expects the device lock to be held.
> 
> To that end, adjust devlink to always acquire the device lock before the
> devlink instance lock when performing a reload.
> 
> For now, only do that when reload is triggered as part of netns
> dismantle. Subsequent patches will handle the case where reload is
> explicitly triggered by user space.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


