Return-Path: <netdev+bounces-14054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6373EB54
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FD8280DAF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4913AF2;
	Mon, 26 Jun 2023 19:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7ED505
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CE4C433C8;
	Mon, 26 Jun 2023 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687809500;
	bh=ldB+MatWlVsNCLZ0mR+Yj//TS0gmW2dKp23REUfd6MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u697IQCtWc7mPfP5qNsMU2uWqPdgmV1hJ9wSJ61mq7qWHcO0fSuOP1QJw+GQeHeJH
	 yz3fVEY9D+3Y2y0raE7vu687ZMFBltGJd3Hbyz5/t59QlAG5BYc6OUe21J6p2bNMVf
	 OFGKjOGg70AKDzOnVr+EfgC/iuPcBNc0vy+l4Bv2s2efBnkJHfTS8DYof2UJupzYOc
	 FS4iuCYuKTQ+vdUlmXxHzPYvwMhsLdhSlxZx2f6bZWgp4nNp2LWcKxhCIuuJAQb1oC
	 e1bDUJvq8rLTipdMQC6SN1Xtd48ku1uo9jnnBTMDyzo9BLxP76wRPO06DnbgNaGR/F
	 w1PG4+jOG5OGw==
Date: Mon, 26 Jun 2023 12:58:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, Muchun Song
 <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, David
 Ahern <dsahern@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Breno Leitao <leitao@debian.org>, David Howells
 <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>, Xin Long
 <lucien.xin@gmail.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org (open list), netdev@vger.kernel.org (open
 list:NETWORKING [GENERAL]), cgroups@vger.kernel.org (open list:CONTROL
 GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)), linux-mm@kvack.org (open
 list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Subject: Re: [PATCH net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
Message-ID: <20230626125818.74193aea@kernel.org>
In-Reply-To: <20230625142820.47185-1-wuyun.abel@bytedance.com>
References: <20230625142820.47185-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Jun 2023 22:28:10 +0800 Abel Wu wrote:
> Now there are two indicators of socket memory pressure sit inside
> struct mem_cgroup, socket_pressure and tcpmem_pressure.
> 
> When in legacy mode aka. cgroupv1, the socket memory is charged
> into a separate counter memcg->tcpmem rather than ->memory, so
> the reclaim pressure of the memcg has nothing to do with socket's
> pressure at all. While for default mode, the ->tcpmem is simply
> not used.
> 
> So {socket,tcpmem}_pressure are only used in default/legacy mode
> respectively. This patch fixes the pieces of code that make mixed
> use of both.

The merge window for 6.5 has now started, let's defer this until 6.6.

Please repost in ~2 weeks.
-- 
pw-bot: defer

