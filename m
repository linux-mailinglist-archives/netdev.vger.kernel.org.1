Return-Path: <netdev+bounces-66280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248F83E3DE
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1445B22CF4
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419D24A15;
	Fri, 26 Jan 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGOPHG8Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054824215
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304316; cv=none; b=eBHDyMaC9tcM5nxBuBIV+vNoLJR+EUXL5osmjMPg2SuBFFDSujsyBpN3GGKBTDRkXk9cnhuIH74sORm9yiyVAxElWNKHgnCmIe7YNcDZoEwqK01eFDB27bIZ4rKO45N5kLfT2htVlX/O4ptJbdE68UKFDpjCp+AwjYTlBQBdo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304316; c=relaxed/simple;
	bh=5frl+3ZsbuHnczYAPFS820f6UJzFarGXvVT9NBTT1jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1rdtAw+sQr5aYfBwxw15neB1QXmtkcNDLJcAkwuhS1Um6SWIm02fCcCpOPwdUfG0C6jle7HL30IFk5d7xzfOD8coR3ZHzq5rR8VNnOVVvHryKnKiSgHdGL6hQsb1w5uJ+cdv38iZ3deOJGodShM3wCGD/Yt8Vvr7rMIrvoP9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGOPHG8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3F8C433F1;
	Fri, 26 Jan 2024 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706304316;
	bh=5frl+3ZsbuHnczYAPFS820f6UJzFarGXvVT9NBTT1jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGOPHG8YhX+/8JMzmOn5vHoG6Y6rz5xLLoQpkyJihSgt7EEmQHcAAQsoRUVUhBntE
	 K53WfobcTZi/2pKm4vubP8oiB8zimATOKJpKDpLcYti1xfV/eGXKCv+QxyNMK6axo+
	 cm77p7g8C+z8vmlein2L4cJXV/roMssp1RM6Iic9eoIEHw3zEttQybBv8lYlZtaKq6
	 VnJI380yQT/loXMIptBObpQGLA9CON7pdnRGgJEZFiBmG60sp5v4Rr+L3PTAb18YxP
	 8+q52Sw5l9ods56eLwvNW1mLFDYoKhBaB8ueyAtGTQkgTDecqLTzaKSzE3J0qFMCy1
	 MHxZECqL5ho6w==
Date: Fri, 26 Jan 2024 21:25:11 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] ip6_tunnel: make sure to pull inner header in
 __ip6_tnl_rcv()
Message-ID: <20240126212511.GG401354@kernel.org>
References: <20240125170557.2663942-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125170557.2663942-1-edumazet@google.com>

On Thu, Jan 25, 2024 at 05:05:57PM +0000, Eric Dumazet wrote:
> syzbot found __ip6_tnl_rcv() could access unitiliazed data [1].
> 
> Call pskb_inet_may_pull() to fix this, and initialize ipv6h
> variable after this call as it can change skb->head.

...

> Fixes: 0d3c703a9d17 ("ipv6: Cleanup IPv6 tunnel receive path")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


