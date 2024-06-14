Return-Path: <netdev+bounces-103428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3575F90800C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4989A1C21522
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE4383;
	Fri, 14 Jun 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3YK6jHZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9436C;
	Fri, 14 Jun 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718323523; cv=none; b=ZTj/a1f1EwULgHlNM9/AG09cVxawMD37m9bxC7MoRBNmkQiUh1QHC8Y0gkna1kKsi2HydPitypwI5GSO+QVFww9QZPwBH5h/psDcY1BjO8Mm/tv6c0PD6gpLwhYNpHZekVoj64PeOOng3BHPszqTF9McPvodA0Xo6jF0HFBGPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718323523; c=relaxed/simple;
	bh=Tk/dh+spZSrmoPxZSBkQvt8dVNeejP0S+XKt7FjCMgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXl8yJfI5L/js4UIbu7bHpKqJ6/+NAcFG5pvdnv9gnMoaA5i3FPLBtQdCQxQVesGQGycw+B8xrJ5LK/zKXCPUmVgIG0gSDXM7pUrrajedT/eWlwrZ19YCUfhRzx4YgcJeXIePX16Dn3iCNETVJDTg6dkI5SkbdtwIQYY/75KZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3YK6jHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055A0C2BBFC;
	Fri, 14 Jun 2024 00:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718323523;
	bh=Tk/dh+spZSrmoPxZSBkQvt8dVNeejP0S+XKt7FjCMgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3YK6jHZweq8ERTiE2Yxuef/VSKTggOsD3eT2DybprJiyIinMBXHBgDO33Vn9b0Gp
	 z6QLIFrO3lrHQJvsA0cNw/mA6i2XK9coEDWk70rHSmcKGpp5bcblOFuEOaw0vOqTEG
	 sr9gTbinGnHBtB0VdX0UFtSYkq1Fw0VnZb/nN3i6k58Q3phgGdGhtwE6jgR14ILyul
	 s4D1p5/Nbr+6sqr6yGGgGnN/Xgv+vC1SdKmgP6ZwE8nblTLbMMblrStn0W9T3fc1JN
	 1uQST6uaOgl19uEfKdQ+P+jK+DX0uFc+Llk+J2MzyJ04sSNVClEC7fvuQxihxnatkm
	 Zz2FY9P/5YODA==
Date: Thu, 13 Jun 2024 17:05:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches
 <joe@perches.com>, Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: Re: [PATCH net-next] etherdevice: Optimize is_broadcast_ether_addr
Message-ID: <20240613170522.0961c781@kernel.org>
In-Reply-To: <20240613073441.781919-1-dqfext@gmail.com>
References: <20240613073441.781919-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 15:34:41 +0800 Qingfang Deng wrote:
> Like is_zero_ether_addr, is_broadcast_ether_addr can also be optimized
> by using a 32-bit load if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
> Sign extension is used to populate the upper 16-bit of the 16-bit load.

Can you provide more context on why it's beneficial. I mean, there's a
lot of code in the kernel one could micro-optimize...

Show us the assembly, cycle counts, where it's used on fast paths...
-- 
pw-bot: cr

