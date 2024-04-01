Return-Path: <netdev+bounces-83764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B564F893C3D
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 16:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5114D1F21CE4
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE31E524;
	Mon,  1 Apr 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdt2Voze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A61FB4
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982058; cv=none; b=BIC//602Zen5CVgEkcEPY4Pt4UwflB8n3Vwvd66ZZZW1SjWhmS+RiF0PbOSYQcTCDB88QFWNiir2AFCPlnPibPc7KEfHqh/643xbtIbiwnp1y8mXxtHUfCGzR9O9QNudQtefCNZZxsXYaUrILupkQNJtIlGfw+V0LHvK10giMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982058; c=relaxed/simple;
	bh=JGone0wcqZH3lOZmCrgTWympUpFhuz25LiXzwO70RgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luEjSzbR7S9wOd5/p28AAbxZaQZIMNbrYgu1f5Riphsd4dBiJjYXLB+3UdK6Xzafkwq61OJxu7KWcBgY+rusm74ed73+6kx6odKYgkiaComL2wCbESf2df6CGryGKCzoUqP1dmqRPASXH7OSEnqkuLvzvgysbVzLCKkRc7xWraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdt2Voze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAD9C433C7;
	Mon,  1 Apr 2024 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711982058;
	bh=JGone0wcqZH3lOZmCrgTWympUpFhuz25LiXzwO70RgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rdt2VozeTa9BdwIWX2Mx37O9zrPdXAH118gDBjddAMciOz84XKpL0Q5uET9mwPxoO
	 7BN2p3fTW/BKYvSS91KwWM95L/CMOiSARA/A1Vkd8uTH0xiavHK3NgmlzlJYmRoEe8
	 HI/qxSZwUk2Id8HKy2rmcjBrDvPwAlcHDdK/Rrf8UmBebNHdP/KuLjf48SaDYszLrS
	 1OfaQpST9qbHqsrd/17kMy/m1gco83A227jHmYpzNLCxOXk3kuXlHc1TYIv7+rPNK+
	 xj+UR//hPvt9KxrxM52E9+W2nWS5Kr/QbMmg4NrZ9Zr3x3WJcm7pBnFPnnRrmiNz7M
	 AxQgajKH2y7ZA==
Date: Mon, 1 Apr 2024 07:34:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>
Subject: Re: [net 06/10] net/mlx5: RSS, Block changing channels number when
 RXFH is configured
Message-ID: <20240401073416.39fb2234@kernel.org>
In-Reply-To: <87ca050f-5643-4b90-8768-1d624e367cac@gmail.com>
References: <20240326144646.2078893-1-saeed@kernel.org>
	<20240326144646.2078893-7-saeed@kernel.org>
	<20240328223149.0aeae1a3@kernel.org>
	<87ca050f-5643-4b90-8768-1d624e367cac@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 09:54:26 +0300 Tariq Toukan wrote:
> The rationale of having a "single flow" or "single "logic" is to make it 
> simple, and achieve a fine user experience.
> 
> Otherwise, users would, for example, question why increasing the number 
> of channels (after setting the indir table) from 24 channels to 120 
> works, but doesn't work when trying with 130 channels, although max num 
> channels is much higher.

Any way to preserve the indir table in case it has to grow?
If it increases by pow2 maybe we can "duplicate" the old table?
90% of the time when user changes the settings it's to exclude
a queue from RSS, the remaining 10% to change the balance. 
In both cases "mirroring" the settings would be fine.

> The required order looks pretty natural: first set the desired num of 
> channels, and only then set your indirection table.

Say user allocated 16 queues for RSS and 4 for flow rules and/or other
RSS context. Now they want to bump the 4 to 8. Resetting RSS and to be
able to allocate new queues may not be an option, as traffic from the
two "domains" would start mixing. Admittedly a bit contrived but not
impossible, so my vote would be to only nak the cases we really can't
reliably support :(

> At the end, there are pros and cons for each solution.
> If you still strongly prefer narrowing it down only to the truly 
> problematic transitions, then we'll have no big issue in changing this.

