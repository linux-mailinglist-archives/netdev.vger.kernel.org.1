Return-Path: <netdev+bounces-166702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714DA36FEE
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492423AD883
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2F18BC26;
	Sat, 15 Feb 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvNDypyT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E381624C4
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641420; cv=none; b=IdGqfFWK8SWv9eybKnvAavSW3UD7Y1x1MDE+N6JwzAdj9tm86gXhQzbuHt1yjrvb3ooN9k4zTY+jX7WALzA47137uPEMjFqkP1uQwVeWEfdiHMXdIkk5mQx5GfYKlKVW2rj5gZlaV1c3VtNrkYDH23pizPyMnFcla9VcClh+xGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641420; c=relaxed/simple;
	bh=VfOOS1YHUqpbHmHcFRCQENbIsSwwTN2cG6MMrPqNKik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwK3uQlFuaHS4NtCJDGXVnO5b/y8DnqNjxRUKSmij6EoxXmSMaCgdVE/RWwGp1O0RaDQ0aBqlIpbz/7syLGdfGKqRmCuzjKu8/AE1Dy7YWhhhj0C8hbmQ9N+RyI03MUH+CcD/VYV2pCoLkaOBJYaMq0XOjS0gMkPxt3oK3clNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvNDypyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4305EC4CEDF;
	Sat, 15 Feb 2025 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739641419;
	bh=VfOOS1YHUqpbHmHcFRCQENbIsSwwTN2cG6MMrPqNKik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvNDypyT1pRZL4Nco1Em7BH8pbwEG568ld6rGu597ykOm1MDL3JzqfGkLpwDJCGR5
	 uMgHidFujqZVzehQ7bg7Yll799xcdz0KF11SlAqpgJujh6IzHgemu/l3tGTJYFR3zS
	 v+pwnl+OmCjvU4i2YxdwPWnX8vjfpnmgeL3QAD71ZC31J7ecPxmE18SDcIkKesotET
	 V2ZNbIKvRd1FIW06PbaU+T77ZeE6ObskOEyvdOPaOpbiqNH2YPfHdKtGWJfjDEkoFx
	 b/ikRad39DGk90R58/T4nRB/rLtkAeHaWCmvBbH06h1ppyJNDDD4ipz1V9QrLXIrWH
	 mI1OecwP9o/uw==
Date: Sat, 15 Feb 2025 09:43:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v8 0/6] net: napi: add CPU affinity to
 napi->config
Message-ID: <20250215094338.7863bcef@kernel.org>
In-Reply-To: <20250215094154.1c83b224@kernel.org>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
	<20250215094154.1c83b224@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 09:41:54 -0800 Jakub Kicinski wrote:
> On Tue, 11 Feb 2025 14:06:51 -0700 Ahmed Zaki wrote:
> > Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
> > after reset. However, since there can be only one IRQ affinity notifier
> > for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
> > management in the core (which also registers separate IRQ affinity
> > notifiers).     
> 
> Could you extract all the core changes as a first patch of the series
> (rmap and affinity together). And then have the driver conversion
> patches follow? Obviously don't do it if it'd introduce transient
> breakage. But I don't think it should, since core changes should
> be a noop before any driver opts in.
> 
> The way it's split now makes the logic quite hard to review.

Ah, and please add the patch with the ksft test I shared earlier to
your series:
https://github.com/kuba-moo/linux/commit/de7d2475750ac05b6e414d7e5201e354b05cf146
it just needs a commit message, I think. The prereq patches are 
in the tree now.

