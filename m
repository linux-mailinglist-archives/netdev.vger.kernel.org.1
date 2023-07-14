Return-Path: <netdev+bounces-17769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A754753039
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C981C214F5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40A442C;
	Fri, 14 Jul 2023 03:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9D3D71
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB4EC433C7;
	Fri, 14 Jul 2023 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689306928;
	bh=f5+eZIpCX2ZGBRkxMwvbfJFOcoLwIN5xWjgrXsjCIhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdwV24NC1ytq3gOax2Zg2Y9E2b4xster5BxG/P4m4ijZkO8HqEnshbhavJD2FU8LC
	 ZA59DkLGyZ3jwQoKxTBCgWg0+oouhch9smeFdsCYbaDmoDGqv0zuHEV+zFzwS2Lskb
	 m2dJRu7HJPLxdPNI6Qej3FKngaHDh6rnUIM7kZxn87wAe0UlygiZ+WPMHyPpQpqyIJ
	 RY9jTdSuFkstcxBsFRpajKqegXWv6BGe6bc0b7ZdQ7kZRDlTUk1mgM4YpNT240WAUC
	 32ho2rEnqDmUvsVl8zpMn+rxBLLy7uSkBYWwCWCAq+gZ5JPjk+ito6Nhp6Z774TU6k
	 f3k+Tuoca0sIA==
Date: Thu, 13 Jul 2023 20:55:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, idosch@nvidia.com
Subject: Re: [patch net-next v2] devlink: remove reload failed checks in
 params get/set callbacks
Message-ID: <20230713205527.3aff4091@kernel.org>
In-Reply-To: <20230713094419.2534581-1-jiri@resnulli.us>
References: <20230713094419.2534581-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 11:44:19 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The checks in question were introduced by:
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> That fixed an issue of reload with mlxsw driver.
> 
> Back then, that was a valid fix, because there was a limitation
> in place that prevented drivers from registering/unregistering params
> when devlink instance was registered.
> 
> It was possible to do the fix differently by changing drivers to
> register/unregister params in appropriate places making sure the ops
> operate only on memory which is allocated and initialized. But that,
> as a dependency, would require to remove the limitation mentioned above.
> 
> Eventually, this limitation was lifted by:
> commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")
> 
> Also, the alternative fix (which also fixed another issue) was done by:
> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> 
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.
> 
> So remove the checks.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

