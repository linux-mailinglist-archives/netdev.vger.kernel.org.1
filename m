Return-Path: <netdev+bounces-35397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515437A947B
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 15:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E35F1C20A20
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18821B650;
	Thu, 21 Sep 2023 13:03:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D88B641
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED923C4E680;
	Thu, 21 Sep 2023 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695301401;
	bh=QQErOBVn2FxBJvJN3P5qkCKvkd3xzS75o/VNKQRTI+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VBGsI+jmwKFsy2leqkbuHfx/JnZ7k//PJM0Whx7QluGrBFawqP5Id/Uj0yvffQ0/q
	 vwz0CcIuau2SkGf38i67KrbhLeyaLN7/NL/WhiNZTZJN6ADf8kQvC8Yeyxdxs4XUhq
	 nAfwjdTq4hZeG3rKl/hLSEjK+n382ppWV2QY/IMAKN075LnDVjtq7+C3p4BN1XKzSY
	 w6zQuw55tS2X4CN1squE3zj32ag5e1a/5binJfbFxa0HiBgPo/poaoqNBls3KHFjrk
	 dBj8U+qkRYFUIREh6LD6MCPf8teWBXYSFqyj0sIF3lvXaziaiMdpe3mzVk7pTEd++7
	 uWvvmyNJTZtLA==
Message-ID: <21c58c78-1b76-745a-0a12-7532a569374b@kernel.org>
Date: Thu, 21 Sep 2023 07:03:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCHv3 net 1/2] fib: convert fib_nh_is_v6 and nh_updated to use
 a single bit
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>,
 Thomas Haller <thaller@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, Ido Schimmel <idosch@idosch.org>
References: <20230921031409.514488-1-liuhangbin@gmail.com>
 <20230921031409.514488-2-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921031409.514488-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/23 9:14 PM, Hangbin Liu wrote:
> The FIB info structure currently looks like this:
> struct fib_info {
>         struct hlist_node          fib_hash;             /*     0    16 */
>         [...]
>         u32                        fib_priority;         /*    80     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct dst_metrics *       fib_metrics;          /*    88     8 */
>         int                        fib_nhs;              /*    96     4 */
>         bool                       fib_nh_is_v6;         /*   100     1 */
>         bool                       nh_updated;           /*   101     1 */
> 
>         /* XXX 2 bytes hole, try to pack */

2B hole here and you want to add a single flag so another bool. I would
prefer the delay to a bitfield until all holes are consumed.



