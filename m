Return-Path: <netdev+bounces-160284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5909CA19219
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B16E160565
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBB212D6F;
	Wed, 22 Jan 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2TlBkQG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5CE1EF1D
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551494; cv=none; b=PMgBtcdVZftsG9HkdywSdBiNadpUxAx4Lxlj96dea5xFG8/5rDamQgvmoMvxAc5Vne1V6Z/KECyeL2e4CFHT8nuHis8T+JEfFC8D9fnv8bnQwzbRzlzoXW7L7UcGDbrdW7R2/Kezk0OySrWWt0WDTbTmQjdVSZbzEoLjF6KzOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551494; c=relaxed/simple;
	bh=TtrEd6Ppz/dVHlJ8r0SZ55aFArDJLlgCToMy85KpjhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep2ECb9YGupmnBbJbIpiB/qC9k06q1yeuXx1uZw6aO+MAt74ViUuK/afpVeiSL00XGQV0tsXGlEwYwiBVqGWUn/IkwEwY8FMRlgaVoGkOkOQhGki1JXbmTzFOiK/YNQyRy5FlhcvRColQ/48NhfvusyMGucDWUf03SPXVSNDPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2TlBkQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C2AC4CEE0;
	Wed, 22 Jan 2025 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737551493;
	bh=TtrEd6Ppz/dVHlJ8r0SZ55aFArDJLlgCToMy85KpjhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2TlBkQGv8IhTtQ3WBWvQvYrZ6NvYxkj5GSOs21j0nzmpTe2QVCnqW1QMqQLaa97p
	 3Yun4o/E8UOOqqeKqHMg+Jj9OoS5NviavZxG86lZ6AD3XKjxjerwLK7/91xCgHq+vH
	 yHeaUxWIGNwk9yiSXFniGQuB9RM4f7K8pl+KU+sLnlnVcNgHj08dG+RPFC3E4WIoZn
	 hYGt/46lg/wh68q/D4pRC9VQ1SwUcOc6fm6FlJj5/6sxq3KOy/ZYE5e1O0XA70gaL/
	 G4A5LeFEATOkTsiBGk7RLVI6XT4YfEA6pbxVLd5+gFuD78tGkghRf0Fb6ISjHIOOz+
	 lRCs2i3bVeLsQ==
Date: Wed, 22 Jan 2025 13:11:26 +0000
From: Simon Horman <horms@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH v5 net-next 0/5] PHC support in ENA driver
Message-ID: <20250122131126.GG390877@kernel.org>
References: <20250122102040.752-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122102040.752-1-darinzon@amazon.com>

On Wed, Jan 22, 2025 at 12:20:35PM +0200, David Arinzon wrote:
> Changes in v5:
> - Add PHC error bound
> - Add PHC enablement and error bound retrieval through sysfs
> 
> Changes in v4:
> - Minor documentation change (resolution instead of accuracy)
> 
> Changes in v3:
> - Resolve a compilation error
> 
> Changes in v2:
> - CCd PTP maintainer
> - Fixed style issues
> - Fixed documentation warning
> 
> This patchset adds the support for PHC (PTP Hardware Clock)
> in the ENA driver. The documentation part of the patchset
> includes additional information, including statistics,
> utilization and invocation examples through the testptp
> utility.

## Form letter - net-next-closed

The merge window for v6.14 has begun. Therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

--
pw-bot: deferred

