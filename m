Return-Path: <netdev+bounces-140071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD549B5298
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B01C20A4C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67C2040BB;
	Tue, 29 Oct 2024 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHWsfh5r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D0C1FF7C2
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229489; cv=none; b=t9L+tEojvNnYKyZ2wjI38lcSCdOVhCixhI+tOnVPGUj1qByliDiGhKtB9mj+FT+km7EgSefSu5ksWuToZ7vgAiJy4hLP0RN2s1mfGrOvwuum9oN2vPlS/TAm4jVGFAA7zUJuoRR22ZpqyqrAKtAUoKjwZan2Knzjd4EX83dszrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229489; c=relaxed/simple;
	bh=iHFqm1T5wTjYOEGsILSgA6OWdIkg50SIXo8W7X6Zwdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yka1hBQZdso9UMmraapXPVB7WiQfcY31kLrThXlHNMQLszak11iz6UrEXn9TbdLbWYa0CuDQHqxH/8AWxhTmVyJk6PSJq9V2NhZuN7X4hk65vrL8GuFxKK2z4+BcO4NxqkWFWC5t4pCGkYT/bR0b/H7AJKMSDLJxNk8sYzxK+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHWsfh5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A08C4CECD;
	Tue, 29 Oct 2024 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730229488;
	bh=iHFqm1T5wTjYOEGsILSgA6OWdIkg50SIXo8W7X6Zwdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHWsfh5rhyiDF3Dra+qluyMea0bbtCCyUF3qEQecSJK0FA9vuc/kxPLJHCNgA3CN5
	 Uvy+hUuz+OjjRB39Wsjgvw7gQEdLyzfsstZ0XdW13GrbKPahHPjnZnJ4GMEX3jOdhu
	 1bML2rZr4pu/F/zSXBbpuP9mTFCE4q5MutI+4GXyXjl+vhsd9gbeq6n9oksuxrPDVF
	 XivmAwwU4zSqMIL0gd5kfz2ka6Iqff6OeJOy+U7o4B7Ek96icrWWr5JQaNBousInz9
	 jzp2aa3I2FHy4uba0ryRHZDzJBdyo4DzyW30oz9qVGgqT/Uor4FvmJeJlmSB/5uwqG
	 +CILfRmMS+3pQ==
Date: Tue, 29 Oct 2024 12:18:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Amit Cohen"
 <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/8] net: Shift responsibility for FDB
 notifications to drivers
Message-ID: <20241029121807.1a00ae7d@kernel.org>
In-Reply-To: <cover.1729786087.git.petrm@nvidia.com>
References: <cover.1729786087.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 18:57:35 +0200 Petr Machata wrote:
> Besides this approach, we considered just passing a boolean back from the
> driver, which would indicate whether the notification was done. But the
> approach presented here seems cleaner.

Oops, I missed the v2, same question:

  What about adding a bit to the ops struct to indicate that 
  the driver will generate the notification? Seems smaller in 
  terms of LoC and shifts the responsibility of doing extra
  work towards more complex users.

https://lore.kernel.org/all/20241029121619.1a710601@kernel.org/

