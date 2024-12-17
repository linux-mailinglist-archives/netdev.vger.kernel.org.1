Return-Path: <netdev+bounces-152624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD8A9F4EA7
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84730162686
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A031F706C;
	Tue, 17 Dec 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaoKgXA3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF71F6692
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447504; cv=none; b=HksDGenqViN+4huCkc4d6kllTtIwQsIx8dshNuwsN4tFwTqzmXudTPDEkL3Rnb3u8yhKEpa/BgPnhHkrQt+4pZmr6n5gzdx3wmBGCwcb7IVMVDUPNTLkBy+ah9x0rz208zJ8bl8xJpZp9OmvMEmidI6FDtOLUbKdsIpHQrlFiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447504; c=relaxed/simple;
	bh=9iEWd3LtyX857/4KLuicuyCbZS7FwsyoYdbVhruq8I0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWTtMfzT+NQmWh/rknvXkA+N01B/HZzHG16mO6otIB5hy2jK+H5nN91qFxFKA1ozT0xbkSak1ShgJUMVtw4jBGI92lcPdeW5mO59bVZJrrxGyAmsMOjfZEvC4o9+QCSGNBamQ7pwljoC7ALr98SgKgFphGP+gSSvrIS6bPkBi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaoKgXA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C25BC4CED3;
	Tue, 17 Dec 2024 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447503;
	bh=9iEWd3LtyX857/4KLuicuyCbZS7FwsyoYdbVhruq8I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KaoKgXA3tsHJUPmucI3dN7acq8p4VRFBnH5gFVdYUsqwyYGfWyCHlEItyf6M7JIXc
	 U3XxZHl8L7K/BnJ9/mcc1MKoRjsiQ9wqImHFYNqN9msR45HoRmvVdmD4pqXfFzUG1V
	 Sn+4OiLnMX6vGivr5vqM9xBcc4JDzMoaAp8lk//mqia0cfpLIJ80JT4aILQXqbkYmE
	 LNtWU8DRiwYqBs/KEFan3Hm+6zzcJpilBKGJC7gXjTsGYpATy/W/sb7eU5eDQ0P3h/
	 e1cBk9MdN58oB0Zc1/CB1Ik/+lQHiK45Ureb3FPkT7Dkx+erg4EBSdDgm1xCTi8SAO
	 905+L7xfMFA9Q==
Date: Tue, 17 Dec 2024 06:58:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, rongwei liu
 <rongweil@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Leon Romanovsky
 <leonro@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
Message-ID: <20241217065822.4243007f@kernel.org>
In-Reply-To: <624f1c54-8bfe-4031-9614-79c4998a8d78@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
	<20241211134223.389616-3-tariqt@nvidia.com>
	<93a38917-954c-48bb-a637-011533649ed1@intel.com>
	<981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
	<abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
	<624f1c54-8bfe-4031-9614-79c4998a8d78@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 14:52:55 +0200 Mark Bloch wrote:
> > All drivers must have its symbols prefixed, otherwise there might be
> > name conflicts at anytime and also it's not clear where a definition
> > comes from if it's not prefixed.
> 
> However, those aren't exported symbols, they are used exclusively by the mlx5 lag code.
> I don't see any added value in prefixing internal functions with mlx5 unless it adds
> context to the logic.
> Here it's very clear we are going over the members that are stored inside the ldev struct.

Prefixing the symbols makes it easier to read your code for people 
who aren't exclusively working on mlx5. Also useful when reading
mlx5-originated stack traces.

