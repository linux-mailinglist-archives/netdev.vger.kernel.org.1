Return-Path: <netdev+bounces-37406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47207B5382
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8CFDB28364C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E09171A7;
	Mon,  2 Oct 2023 12:59:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A78CA47
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E23FC433C8;
	Mon,  2 Oct 2023 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696251595;
	bh=GA815eNLPFCWdkP7s+i7Wqp5URXRERoromI8jrKhMaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBtxMR0x4Eak3SuYEjmFjZc8qe3t7UPZ6GwSx27AjNqSsemUR/QSzHLWvmNCSHO20
	 L4/q/OR0yWgKr8+3mzP9NX+KLxE61ktlWvbwFoD/yxfhxXHeLGvJZVfDaKWnF2RY/A
	 qGvDEb3ABB/lHzpg8Fp+MkCcK7ZpdwKm4MpVlsJnok4rL9gzl2OUyKsejNVBb6Wy6R
	 kt2uuCiMIr5Qp83/HeKeyQJ168PEsX7UqdRDdr1ZWP/yNKFREn0HIIqkv5qxlQvKGJ
	 khRVasfPe9+9J2TOozOPBH0jY/UuukpyfSFZRjNOvbaP2GdESKxZCm4xvsLDdZg5Yf
	 4f3TBP1Ji2GMg==
Date: Mon, 2 Oct 2023 14:59:51 +0200
From: Simon Horman <horms@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] ipv4: Set offload_failed flag in fibmatch results
Message-ID: <ZRq+xwEzgm8UnzSi@kernel.org>
References: <20230926182730.231208-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926182730.231208-1-bpoirier@nvidia.com>

On Tue, Sep 26, 2023 at 02:27:30PM -0400, Benjamin Poirier wrote:
> Due to a small omission, the offload_failed flag is missing from ipv4
> fibmatch results. Make sure it is set correctly.
> 
> The issue can be witnessed using the following commands:
> echo "1 1" > /sys/bus/netdevsim/new_device
> ip link add dummy1 up type dummy
> ip route add 192.0.2.0/24 dev dummy1
> echo 1 > /sys/kernel/debug/netdevsim/netdevsim1/fib/fail_route_offload
> ip route add 198.51.100.0/24 dev dummy1
> ip route
> 	# 192.168.15.0/24 has rt_trap
> 	# 198.51.100.0/24 has rt_offload_failed
> ip route get 192.168.15.1 fibmatch
> 	# Result has rt_trap
> ip route get 198.51.100.1 fibmatch
> 	# Result differs from the route shown by `ip route`, it is missing
> 	# rt_offload_failed
> ip link del dev dummy1
> echo 1 > /sys/bus/netdevsim/del_device
> 
> Fixes: 36c5100e859d ("IPv4: Add "offload failed" indication to routes")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

