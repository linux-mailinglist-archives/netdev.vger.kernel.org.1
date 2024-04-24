Return-Path: <netdev+bounces-90985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868008B0D4B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421B728C72A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E9215F400;
	Wed, 24 Apr 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwvixoj0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451715EFA1
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970415; cv=none; b=U90ePnUdc7nhNqg1Hq157eFX5hzh3PWog1T9jyYI2TS5SNoysnRY6U6gL0h6qsorOFr/f7xeBs3P/kA14KEEiRACve7uhREktj3JS2cORGDrR5bfF6j4WZAmgQ0LjeuJ0qndlCi0ogA0xsRAaunoeV4qo8uKJOAzc0m/baGF5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970415; c=relaxed/simple;
	bh=HR3VF0Px1+W9a1vjceVty7kYxaF7baqEHMIJH+ZvZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9prrAcKF4s9QOYX9NiynhRAFneCZSUxDuJrZVIR678Ru2Voi1YF3f8WSI+FV2ShskQ+vMIq7xXmg7OWKhOUVW2HZ5rC34dr2NAkXzznL1DYY5NPiavKYnXOaWOg3mbng7DoKSzxIhBLPK1y2lJz7Mqxn8f0uFj+6T0fC1+BWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwvixoj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CE9C113CD;
	Wed, 24 Apr 2024 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970415;
	bh=HR3VF0Px1+W9a1vjceVty7kYxaF7baqEHMIJH+ZvZdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwvixoj0eMnLN/dS/HW8UHac5Tg1MGEDnk7ZltqdJWoOUxnqgbCPcIAeQ4IT3lVnT
	 22u2XDsjxqFq8hQNN+O9Xq3e/YD4rI4/S89uYcQvg3y9/jVIf21p++G0ckDLUPMjNu
	 Ko+FxwlCF5lBGrFZ9Gbb+7wkiMYB7KFffp5J9iGsvZjcWpAdoEFZnt3fJQHPbIniCo
	 uSAk7GO/6KiiCbe66xMT3dvgLiweaSo0wOK60UDbDsIp6aL3oJ6cIDTCjz4sd9fhqQ
	 FwJvLh1HKO0Mk797a9IJvtv2VyT/idhnK6wQQUlWGHLrtM+HCZdr4T1YaE27fo2xGW
	 3IymJmUZ8qiEQ==
Date: Wed, 24 Apr 2024 15:53:30 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 9/9] mlxsw: spectrum_acl_tcam: Fix memory leak when
 canceling rehash work
Message-ID: <20240424145330.GK42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <0cc12ebb07c4d4c41a1265ee2c28b392ff997a86.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc12ebb07c4d4c41a1265ee2c28b392ff997a86.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:26:02PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The rehash delayed work is rescheduled with a delay if the number of
> credits at end of the work is not negative as supposedly it means that
> the migration ended. Otherwise, it is rescheduled immediately.
> 
> After "mlxsw: spectrum_acl_tcam: Fix possible use-after-free during
> rehash" the above is no longer accurate as a non-negative number of
> credits is no longer indicative of the migration being done. It can also
> happen if the work encountered an error in which case the migration will
> resume the next time the work is scheduled.
> 
> The significance of the above is that it is possible for the work to be
> pending and associated with hints that were allocated when the migration
> started. This leads to the hints being leaked [1] when the work is
> canceled while pending as part of ACL region dismantle.
> 
> Fix by freeing the hints if hints are associated with a work that was
> canceled while pending.
> 
> Blame the original commit since the reliance on not having a pending
> work associated with hints is fragile.
> 
> [1]
> unreferenced object 0xffff88810e7c3000 (size 256):
>   comm "kworker/0:16", pid 176, jiffies 4295460353
>   hex dump (first 32 bytes):
>     00 30 95 11 81 88 ff ff 61 00 00 00 00 00 00 80  .0......a.......
>     00 00 61 00 40 00 00 00 00 00 00 00 04 00 00 00  ..a.@...........
>   backtrace (crc 2544ddb9):
>     [<00000000cf8cfab3>] kmalloc_trace+0x23f/0x2a0
>     [<000000004d9a1ad9>] objagg_hints_get+0x42/0x390
>     [<000000000b143cf3>] mlxsw_sp_acl_erp_rehash_hints_get+0xca/0x400
>     [<0000000059bdb60a>] mlxsw_sp_acl_tcam_vregion_rehash_work+0x868/0x1160
>     [<00000000e81fd734>] process_one_work+0x59c/0xf20
>     [<00000000ceee9e81>] worker_thread+0x799/0x12c0
>     [<00000000bda6fe39>] kthread+0x246/0x300
>     [<0000000070056d23>] ret_from_fork+0x34/0x70
>     [<00000000dea2b93e>] ret_from_fork_asm+0x1a/0x30
> 
> Fixes: c9c9af91f1d9 ("mlxsw: spectrum_acl: Allow to interrupt/continue rehash work")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


