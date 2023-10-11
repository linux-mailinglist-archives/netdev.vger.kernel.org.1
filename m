Return-Path: <netdev+bounces-40103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC77C5C59
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01405281DB0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB322318;
	Wed, 11 Oct 2023 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKRnslJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FC1D54E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7C9C433C8;
	Wed, 11 Oct 2023 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050269;
	bh=xHjSajgbqDVJreeYNE416phrC7tK0Bxr9AhJFMNBi/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BKRnslJfWwQOczGi9dpbqoq6vdXykaT3KUp4glNsg4s0nYq+bTLt2v6glFwFh43F6
	 VoZQ87Kh+ZX/3tcrsfFbNkjELHvHQaQ1OCJgJ/HnIyOBssFsoKZt6zwmsTTssknWAi
	 LzAiCu0WAYumg2e0C/wf5NIWkTAxVSSuZTKSYqAQkELls5kIAk0yC5pZB/aqN1E08H
	 Med1kxnGRKdqC3H/3Iy/lxWS2rZYwIFcHyKJCtwewGs9WWrUzpGEapPoffYmJcxtyT
	 FivMve12aqAotJrYir18L8yhtCbqVR4HZ4tZfRjDw3CV3m2Dqrie5hDByjpJFFa/eS
	 FX0iMJIEm+Dqw==
Message-ID: <a237055b-d617-86da-2fed-8193b2a98a22@kernel.org>
Date: Wed, 11 Oct 2023 12:51:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/7] ipv4: add new arguments to
 udp_tunnel_dst_lookup()
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-4-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-4-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/23 2:20 AM, Beniamino Galvani wrote:
> We want to make the function more generic so that it can be used by
> other UDP tunnel implementations such as geneve and vxlan. To do that,
> add the following arguments:
> 
>  - source and destination UDP port;
>  - ifindex of the output interface, needed by vxlan;
>  - the tos, because in some cases it is not taken from struct
>    ip_tunnel_info (for example, when it's inherited from the inner
>    packet);
>  - the dst cache, because not all tunnel types (e.g. vxlan) want to
>    use the one from struct ip_tunnel_info.
> 
> With these parameters, the function no longer needs the full struct
> ip_tunnel_info as argument and we can pass only the relevant part of
> it (struct ip_tunnel_key).
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c      | 11 +++++++----
>  include/net/udp_tunnel.h   |  8 +++++---
>  net/ipv4/udp_tunnel_core.c | 26 +++++++++++++-------------
>  3 files changed, 25 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



