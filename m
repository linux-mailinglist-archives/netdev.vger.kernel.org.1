Return-Path: <netdev+bounces-203489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94611AF6159
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AF7A3BAD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1041E633C;
	Wed,  2 Jul 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMWQJ6gG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370B2E499A;
	Wed,  2 Jul 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481130; cv=none; b=gpR29kGHDfn2ReGz+rdsbXHC2w60yHv0TKxdYWBVhugGY4gQRrw4kMqvhxUf6S0fnVXCoUMUW14mr/ExbCenVpc4W2F0bT0Dhv+LIMh/odukxAvZyl1KgZTmNDP8KHErId7ldxCQbiwIkcSCFFamkm0ToKNeOJtNsQ+7RpzjBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481130; c=relaxed/simple;
	bh=rWpOcvP+W+OOf5yE/WLEynEehWPGL5qGyompIkSsJ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mdc/A//AOrd2l+7Ut0Kk62gnvPhmcGA2P6833oKg+ncVPiKMb5boiA569eEdqfF/RxPm8yxPIFIuPL4Xm8TQlKjXKLzmbcP6B5jmhfXRL8ZgisRWXrDGsOpZFWgeHYQV4W/QkP/j4i002EQ8Ydoa1ZorzqZ71Vf5r07ehIn7Yds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMWQJ6gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D20C4CEE7;
	Wed,  2 Jul 2025 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481129;
	bh=rWpOcvP+W+OOf5yE/WLEynEehWPGL5qGyompIkSsJ9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMWQJ6gGNInR2o/D29RHlpYXwDzMvEJ/JcKyGBiUafqWn6weK/ksFws7nzpVfEuxx
	 0TKKXgrtsIDnCkgJgd/xrGfeSc6Y8GefGh+87EEgvbTZ2e3Rtehy1n6Hpt4kOBaP4O
	 8GsUIzGhxCx1fBVdi5IwS7lWfDFccYD1zsidcgYL/9t9uP62Y0ktQNV+9tjMRk566J
	 pZbrXi5ZcuG3MOb5v7+cwqneZziI1py75b0z9fe1/FssCQdycGOBcK73sS3eV+Ts60
	 Le46wI9cTNtCZmGewFLfoOBSaPgwu+cb5sqsEgG5ex9wWFKbHrH8F9/QIfyikA5XN4
	 cuf9DHFPbFgPA==
Date: Wed, 2 Jul 2025 11:32:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 <tariqt@nvidia.com>, <cratiu@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <20250702113208.5adafe79@kernel.org>
In-Reply-To: <20250702172433.1738947-2-dtatulea@nvidia.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
	<20250702172433.1738947-2-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 20:24:23 +0300 Dragos Tatulea wrote:
> For zerocopy (io_uring, devmem), there is an assumption that the
> parent device can do DMA. However that is not always the case:
> for example mlx5 SF devices have an auxiliary device as a parent.

Noob question -- I thought that the point of SFs was that you can pass
them thru to a VM. How do they not have DMA support? Is it added on
demand by the mediated driver or some such?

