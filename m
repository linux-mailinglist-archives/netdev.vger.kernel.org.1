Return-Path: <netdev+bounces-79179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E978781F3
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16131F23187
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35140870;
	Mon, 11 Mar 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGZ94rUW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F840860
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168424; cv=none; b=GRbLXuAqsISHGuOAvqAUNGPLiefSjtlGZ0AGk4h/uEph9zShxUVvZY1W4jnMcQKi3NSrp2r3L5IatuzacxSzh5KiB6vggJnFp3J1bEAad9Y75TLqfwWyCHR9Yv2a6nTYQqDUozSKp9kxVEzZfNnM9ydlY+SW35lTU5pDWh5fAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168424; c=relaxed/simple;
	bh=qPfnPac/OYRyBcbEgKzaCkMOfZ8PT/+3AnwdxCO+P1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaP/Tr7SyGGbKRzhnZqMexc3cLFygWXMvpAvQpDhpK69Rt1yVbKZtv08/k2iSRtYgGElivsH8E6UeBlachQOX6bpAty0NLTNWUWB8D94Q0154nlfVMcK0VdA9EQZ7Ont9/qWSh1LVIu6Q0TjAGsixgzPR3ft3QmI9/JZHRNMuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGZ94rUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D32C43394;
	Mon, 11 Mar 2024 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710168423;
	bh=qPfnPac/OYRyBcbEgKzaCkMOfZ8PT/+3AnwdxCO+P1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eGZ94rUWfMW+MCz6bUlqITFhzb6f7zMf6UyOlGNygF1I1ij8V/RdapOPW3c+HNfDh
	 VfWwerM4t0CpGrupLdulkQUV5nZMcCDmDYErFV7D3DEaRzWUDMACuUN3D4MZofKH4H
	 reeV/ZAzjMYVUEpZvoYnOgBgxuSOQ4Zq1wizxy0oKGjr8MgxvuQLa+MNKxattBLxoN
	 wn/5hjmpFXRoSohGPfeNiUdcN+/sGUhHp6E8wGzsZJx9FVAUnbtOSisnfcnsqlxr3e
	 BaKsK3F3XzgLp+yhO3YHowme24fUDvFqzbpGM0me+8RNoZQgv3EKJUGBZrkJnHK4E1
	 bPcOwRoAELCIw==
Date: Mon, 11 Mar 2024 07:47:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 petrm@nvidia.com
Subject: Re: [PATCH net-next 1/2] nexthop: Fix out-of-bounds access during
 attribute validation
Message-ID: <20240311074702.340dafcf@kernel.org>
In-Reply-To: <Ze4pIe_E4BgkCP6w@shredder>
References: <20240310173215.200791-1-idosch@nvidia.com>
	<20240310173215.200791-2-idosch@nvidia.com>
	<a92e609b-f5c4-4e9a-8eb8-7e2c54f75215@kernel.org>
	<Ze4pIe_E4BgkCP6w@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 23:41:53 +0200 Ido Schimmel wrote:
> > 'tb' on the stack only needs to be ARRAY_SIZE as well; that's the
> > benefit of the approach - only declare what you need.  
> 
> The reasoning for that is explained in Petr's commit message:
> 
> "
>     - To allow querying for presence of the attribute, have all the attribute
>       arrays sized to NHA_MAX, regardless of what is permitted by policy, and
>       pass the corresponding value to nlmsg_parse() as well.
> "
> 
> IOW, with resizing 'tb' to ARRAY_SIZE:
> 
> rtm_del_nexthop
>     nh_valid_get_del_req
>         if (tb[NHA_OP_FLAGS]) -> BOOM

v2 coming, right? Please repost as soon as possible. v1 crashes AFAICT
because tb is not 0-initialized so tb[NHA_OP_FLAGS] reads garbage.

