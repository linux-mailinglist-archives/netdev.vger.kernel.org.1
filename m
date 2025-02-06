Return-Path: <netdev+bounces-163581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A7CA2AD2A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B79188BC88
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A71F419E;
	Thu,  6 Feb 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COayv9/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E751F4176
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857528; cv=none; b=cUZiEoOoDgf0HJA5w/O6yqd3ntKmr3q3H3n41hFIWTMigp+faWTi52xzcRKjz9QnxoZ4was/+Rh9s3K5ysxCj5KN2fRihVfsWYXSKm89uzBviRVsOG3WBtpHMxovGgKy8QsSBDQX/CcTe2xpqBTQiDMMspTkF9kE/E+4TkV8j5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857528; c=relaxed/simple;
	bh=21bJ8x1wexKnepbmWt0ARGt4UcOCMemJKf+jDHdCpo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCrPeEcF1sDsC2UkMlBuQz2Z9S0+vk5wfJvs0XlrKavRzcK/TUF1HkSuTjFPUF9qFi6NZXrbsp5xjbU0pMZQNiroRYMBZ+ZTfvmrnSBEXwSQKzxs0EH4rjfRIVVFXVhGeM7drZoAY2xCp1LqAid89Z5irVjKDR3MovBm2MQRkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COayv9/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7F1C4CEDD;
	Thu,  6 Feb 2025 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738857527;
	bh=21bJ8x1wexKnepbmWt0ARGt4UcOCMemJKf+jDHdCpo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=COayv9/KDsz7fGl3/w9+55/rS+YuYPnyCCam0fEY4wIAriNH8ls7euEa3GNXdD4DH
	 3Y/q5VH2b6flxU/HDWyFrJ88X0UKUFRYZ0qECXrCgGFpzsjvSgnMNYQvTA6aSf6ZQ9
	 NibWxssPRvlrke8hRi3YFJlA2FfJPFcyrSVFpOKbm3aEvSxddcCF5hsp+DI/UDt3dV
	 MI1eg0LY8+SsuFKK/TbMR25hz9UpfUZWq2FLMZmJWYwKy5QLpYhEfGBIsXEbOI+T7Q
	 GKAiSv74seKQ2qP0fIRQ07fA9Y1ugv7Ayh9KZ7qeo1eCWiTtJ/cJQbT4bmz+LBcXXi
	 biK5kUsb11WWg==
Date: Thu, 6 Feb 2025 07:58:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 0/4] eth: mlx4: use the page pool for Rx
 buffers
Message-ID: <20250206075846.1b87b347@kernel.org>
In-Reply-To: <c130df76-9b18-40a9-9b0c-7ad21fd6625b@gmail.com>
References: <20250205031213.358973-1-kuba@kernel.org>
	<c130df76-9b18-40a9-9b0c-7ad21fd6625b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:57:59 +0200 Tariq Toukan wrote:
> On 05/02/2025 5:12, Jakub Kicinski wrote:
> > Convert mlx4 to page pool. I've been sitting on these patches for
> > over a year, and Jonathan Lemon had a similar series years before.
> > We never deployed it or sent upstream because it didn't really show
> > much perf win under normal load (admittedly I think the real testing
> > was done before Ilias's work on recycling).
> > 
> > During the v6.9 kernel rollout Meta's CDN team noticed that machines
> > with CX3 Pro (mlx4) are prone to overloads (double digit % of CPU time
> > spent mapping buffers in the IOMMU). The problem does not occur with
> > modern NICs, so I dusted off this series and reportedly it still works.
> > And it makes the problem go away, no overloads, perf back in line with
> > older kernels. Something must have changed in IOMMU code, I guess.
> > 
> > This series is very simple, and can very likely be optimized further.
> > Thing is, I don't have access to any CX3 Pro NICs. They only exist
> > in CDN locations which haven't had a HW refresh for a while. So I can
> > say this series survives a week under traffic w/ XDP enabled, but
> > my ability to iterate and improve is a bit limited.  
> 
> Hi Jakub,
> 
> Thanks for your patches.
> 
> As this series touches critical data-path area, and you had no real 
> option of testing it, we are taking it through a regression cycle, in 
> parallel to the code review.
> 
> We should have results early next week. We'll update.

Sounds good, could you repost once ready?
I'll mark it as awaiting upstream in patchwork for now.
And feel free to drop the line pointed out by Ido, no real
preference either way there.
-- 
pw-bot: au

