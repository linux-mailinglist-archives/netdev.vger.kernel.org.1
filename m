Return-Path: <netdev+bounces-159111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA4A146DB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F022188E1AB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79ED25A633;
	Thu, 16 Jan 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXJqKVw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0725A620
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071692; cv=none; b=ki9mQfi64yPBmfekK8N3QUqdHaOdVGOTJYLm9956l/5ZvCp3Xk4ftJQHblPpbamArMeQwFpqNOr04OUggiILcdpX7nucdA+6Z0OmpTHY1eEB0zcJooIer4Y9s0IDG0dDoLjOxKAi40EU5t7WV3Xabtwn5Qt0YXp1ZDOSr3bO/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071692; c=relaxed/simple;
	bh=0J2IA/e7thUgrNrMk3lpjh4NlsSXf3nncDJSmhGYGE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7WZMUzOKL6EYghjvQbjtO3Ixbb1uyyTn7NAaHqRm8obcJfUC9osCZoSJt04cwIFVzJk+0yLP34DZfl4oFfs/M9Q/PWorkG72kqbSWi/8py0g8I+kFTH3pY5pKIvykf9BsWiR6Vy/0uU+U6xU0+Tqnc9vH6xbiv7hn2sKfkFA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXJqKVw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DD2C4CED6;
	Thu, 16 Jan 2025 23:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737071692;
	bh=0J2IA/e7thUgrNrMk3lpjh4NlsSXf3nncDJSmhGYGE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WXJqKVw+t1Fqdn0o17DAdpfV27bTineDvMbI+xUPYjyHaOXKeKVytMs3LJpEgJLvv
	 iN6S8PwJinFTUJTAFlWbpTTZUM88ZsNyaA0VfhzFqPOe8oXCeyGNgDrx+3L1iRimFH
	 8YvaBTOWquTT62eLD9P9H9BXA95TxyypFIYcMwvkmoRNJeouCleJ/l1a1c/98aIqrd
	 R40n0MNZKUrIFNFZMMPdezfeKtQ9y8fdc9m3f1QG312K0XxHnulPd0W3Aou7gthHMA
	 hfiRZtrboaM5sEPLGZWhjQSF0PGwJxOKgPG/GhfmowKSZ3ePgrs6qciFDlfA7v0PeD
	 e8BV6nx6AtNrA==
Date: Thu, 16 Jan 2025 15:54:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <20250116155450.46ba772a@kernel.org>
In-Reply-To: <Z4maY9r3tuHVoqAM@x130>
References: <20250116215530.158886-1-saeed@kernel.org>
	<20250116215530.158886-11-saeed@kernel.org>
	<20250116152136.53f16ecb@kernel.org>
	<Z4maY9r3tuHVoqAM@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 15:46:43 -0800 Saeed Mahameed wrote:
> >We need to pay off some technical debt we accrued before we merge more
> >queue ops implementations. Specifically the locking needs to move from
> >under rtnl. Sorry, this is not going in for 6.14.  
> 
> What technical debt accrued ? I haven't seen any changes in queue API since
> bnxt and gve got merged, what changed since then ?
> 
> mlx5 doesn't require rtnl if this is because of the assert, I can remove
> it. I don't understand what this series is being deferred for, please
> elaborate, what do I need to do to get it accepted ?

Remove the dependency on rtnl_lock _in the core kernel_.

