Return-Path: <netdev+bounces-182368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1214BA88919
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816191889565
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EE2749E2;
	Mon, 14 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsoRwWB1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF51A29A;
	Mon, 14 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649728; cv=none; b=iwR2Qrhewwilqk7cjQY7JH6C2FqA8thXATJjdSzkPKA7MnnJDPBA9hY/MbBO6AM2/f7F/iqmO8WiMNRGl+QkFxB1/Fa3blEdrRgRJ3cbbJmLrZymkFGQtDihibtgvo0KGHA56+XVFewlIW8hRT1lant5izKKtPtcVq9/gswJbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649728; c=relaxed/simple;
	bh=B/f8nfuCKrz3hf3ccJBtDMWjTuWvH9EW7AkbfWjqkrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLBCeJUyHjYTQmO4CJqGkmCaDW6lvqD/7X47G0fUZkl3P9PkkUbqWzSqBNX+EF4h6Yb4xfO7v9ti1mI0zJdVvlw66e8cpwCR+3bJj4BPrrlDEF68FgoIw701QeSQpp9m4YrGHYSlAkFpT5AiBfREJ+WUrUn6bIrPMsPjdGBnwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsoRwWB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407D4C4CEE2;
	Mon, 14 Apr 2025 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744649727;
	bh=B/f8nfuCKrz3hf3ccJBtDMWjTuWvH9EW7AkbfWjqkrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsoRwWB1aQivpwc5jmlzMzh0dvP+D9thuMGPLW6og/2G6EpsUigpcwI1L8xYjMQA8
	 bM6yoTrT8/JEyVUbhPljmzTG+U14OfV4knZxc5iL8ISIjCYzOnaumc7y/WFt/F843t
	 qoza24nMp8VO0BJmK9nlAK7q/fZ4fEH5FHOfNPHPtzu7LFztzWtHzpFJn+jgoqNg7t
	 aRFgVj39xnnz5qnh/a7thobFPe/rkxwIw19icHBDmZFC3sWgzMmVo+AJ5A7gZMFWd4
	 XK7yDgHlPpTNDUw2VLNN5G2jUxD7O14+aHWGRMGXgSvDhQXBr/jm3LExUVHC+C3cGi
	 J0snPHWvjbjLA==
Date: Mon, 14 Apr 2025 17:55:23 +0100
From: Simon Horman <horms@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] batman-adv: Fix double-hold of meshif when
 getting enabled
Message-ID: <20250414165523.GV395307@horms.kernel.org>
References: <20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org>

On Thu, Apr 10, 2025 at 08:58:51PM +0200, Sven Eckelmann wrote:
> It was originally meant to replace the dev_hold with netdev_hold. But this
> was missed in batadv_hardif_enable_interface(). As result, there was an
> imbalance and a hang when trying to remove the mesh-interface with
> (previously) active hard-interfaces:
> 
>   unregister_netdevice: waiting for batadv0 to become free. Usage count = 3
> 
> Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch is skipping Simon's normal PR submission to get this problem
> fixed faster in Linus' tree. This currently creates quite a lot of wrong
> bisect results for syzkaller and it would be better to have this fixed
> sooner than later.
> ---
> Changes in v4:
> - added Suggested-by: Eric Dumazet <edumazet@google.com>
> - added Reported-by: of various syzkaller reports which were affected (during
>   bisecting) by this problem

FWIIW, I don't see those tags at the bottom of the commit message.

> - resubmission after 24h cooldown time
> - added kernel message during hang to commit message
> - Link to v3: https://lore.kernel.org/r/20250409073524.557189-1-sven@narfation.org
> Changes in v3:
> - fix submitter address
> - Link to v2: https://lore.kernel.org/r/20250409073304.556841-1-sw@simonwunderlich.de
> Changes in v2:
> - add missing commit message
> - Link to v1: https://lore.kernel.org/r/20250409073000.556263-1-sven@narfation.org

...

