Return-Path: <netdev+bounces-48726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7B77EF5B3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D01C20410
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7BB381CA;
	Fri, 17 Nov 2023 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts2y3vDa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E1381C3
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6086EC433C7;
	Fri, 17 Nov 2023 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236282;
	bh=Y3JsX2RVFFk1DYvrRu9IyouB2VPxYW9vM64U7V2ay2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ts2y3vDawH7CyjwG2AAJllMStJo5ZKKmsjoLNETlQT+deVhcjtiYa8wcFNnHQS9Pk
	 xNhNuoJP1D6rRfq5Jh7fHBXflqxI2Qs0Ymbiu/B9b19EPR+LnIQX4R4k8U3AmetmzL
	 9PWMINYZr9l1SuvQ7ZxjE4t7/Eg9ZRfoRJaOGPPuI9l4zq5aq9CCmiBOSI885DnTqn
	 /FWYVXtKwpqrFioKiE9yl2pHlGxPYWkeVBqs2m+yXOviW4x0h01qtuyY+63jJOZY1Y
	 ojv4J39lt15L9XAh0jnPwHRK9iyR6fMpGuddmHvGmXaDlZy7441n03DtuyEsUkffHo
	 Ebg9gRIKRQwGA==
Date: Fri, 17 Nov 2023 15:51:17 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 05/14] devlink: Acquire device lock during
 reload command
Message-ID: <20231117155117.GH164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <03cf077ca8d3a1a0a755866df1a99031e5badb14.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cf077ca8d3a1a0a755866df1a99031e5badb14.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:14PM +0100, Petr Machata wrote:
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
> Do that when reload is explicitly triggered by user space by specifying
> the 'DEVLINK_NL_FLAG_NEED_DEV_LOCK' flag in the pre_doit and post_doit
> operations of the reload command.
> 
> A previous patch already handled the case where reload is invoked as
> part of netns dismantle.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


