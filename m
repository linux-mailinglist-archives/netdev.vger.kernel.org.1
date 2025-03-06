Return-Path: <netdev+bounces-172596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B0A55782
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D543AD190
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0627603F;
	Thu,  6 Mar 2025 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV7eR4/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B0249E5
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293290; cv=none; b=uAJh3mCU2pWj0u+VP5UJTJb9UGMQXZcGmkFIVDFFAqkoy7ofGD0TRycLEbw4RHb21foBWvm2jdq5zWysb0oPv5J0l1bdjbdOApzzPeg6W01HqWjXdIm9UMEp+vnMp1M6Q5Si3TpWOPNvJdbuEjGwuqoSYZ1FLz1LoYdx7rxGdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293290; c=relaxed/simple;
	bh=aniIYBl4gqtdOD6l9WBwzQflxuG+wa6epLodlkSYJcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ29J6Nfn2G4nNgCeT/2VyoAPhuF2ZHXMSL2OIB/5LbIYm3mgfgx5qRtEA6HoRsbJ4pOVuiHWVjYchqZDU2L/8kiB+DbihmZkVuXUnAYbaSDRFTofiuCMr/zvjLDUxfG7zeLzSTkg0mRVuxVpsCrF4jO3N4zJhQcRNg7kVFwhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV7eR4/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFA4C4CEE0;
	Thu,  6 Mar 2025 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741293289;
	bh=aniIYBl4gqtdOD6l9WBwzQflxuG+wa6epLodlkSYJcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hV7eR4/ApXl6FY4w31kVH5JLkBsXqUWwpwMbwS57tzyApCP59sUBrI1uY6EheWrcp
	 zp60siukavydEg+DO0Poakr+HOQjc+Osfh3rIBxXjTxF9HiAUMzrV7Wa9q6xXbhmeD
	 3gRkpJCjORs9alswzxc8wxonj50jiwY1lDZSjNsRTdzHD8eIZj9VNRJRZDO8idLeTD
	 soz0ZF2LPJ6N7DXBBtCIZvhdye25VE2NAXpw8Tt+5Q794GIdI0T5CULhkDl24j3nax
	 aq95EKtetHxhcyMpzRrTG0s1bXD/NQOfsKDYh46FY3cFbGq/vj1yShAnjiLwBcyzT4
	 T7DVrk6vZYAzw==
Date: Thu, 6 Mar 2025 12:34:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250306123448.189615da@kernel.org>
In-Reply-To: <3faf95ef-022a-412e-879d-c6a326f4267a@gmail.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
	<20250305183016.413bda40@kernel.org>
	<7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
	<20250306113914.036e75ea@kernel.org>
	<3faf95ef-022a-412e-879d-c6a326f4267a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 22:12:52 +0200 Tariq Toukan wrote:
> >    The exact expectations on the response time will vary by subsystem.
> >    The patch review SLA the subsystem had set for itself can sometimes
> >    be found in the subsystem documentation. Failing that as a rule of thumb
> >    reviewers should try to respond quicker than what is the usual patch
> >    review delay of the subsystem maintainer. The resulting expectations
> >    may range from two working days for fast-paced subsystems (e.g. networking)  
> 
> So no less than two working days for any subsystem.
> Okay, now this makes more sense.

Could you explain to me why this is a problem for you?
You're obviously capable of opening your email client once a day.
Are you waiting for QA results or some such?

