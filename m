Return-Path: <netdev+bounces-17038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FD174FDF9
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127C6281882
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74C1FA4;
	Wed, 12 Jul 2023 03:45:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0D80E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36885C433C8;
	Wed, 12 Jul 2023 03:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689133539;
	bh=kV1aAg4a4cV9uuw2PocMUWykoJKk/tyIh0MW/t13PJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GD62fC1aPLT4Chb4Q2u79JyVL01BCjTdBo6PhaMSEQghTJVJ2XMfb8K4IA+5zMHhm
	 Jw5/r04qhJG3aBR8GiU4bqed0fsjfTvIcbfb6yTVO/VaN9jYHTc9bLnaqE6xisBuL2
	 DFlYzM4h3GDQcPSUU8/iQpd3F3709bWbKmrIjdADvjUlCi170bJr8v5f93PdOLp2wg
	 nARXUSE+et76TRzo+W1gxu3XwSJZf7jgKK72NG0sQ02KHSbo3GZ+nPTpLCh6eWNMR1
	 38TqTfOPM7T4rqJJpU4+HxdOul3kyGc7D8rFNUpml/fi7eSw5LpV8FvkUIEcjwXB8S
	 4b6xx+Y7a3Kvw==
Date: Tue, 11 Jul 2023 20:45:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, Muchun Song
 <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, David
 Ahern <dsahern@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, Kefeng
 Wang <wangkefeng.wang@huawei.com>, Yafang Shao <laoar.shao@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Breno Leitao <leitao@debian.org>, David Howells <dhowells@redhat.com>,
 Jason Xing <kernelxing@tencent.com>, Xin Long <lucien.xin@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel@vger.kernel.org (open list), netdev@vger.kernel.org (open
 list:NETWORKING [GENERAL]), cgroups@vger.kernel.org (open list:CONTROL
 GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)), linux-mm@kvack.org (open
 list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
Message-ID: <20230711204537.04cb1124@kernel.org>
In-Reply-To: <20230711124157.97169-1-wuyun.abel@bytedance.com>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 20:41:43 +0800 Abel Wu wrote:
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

Eric Dumazet is currently AFK, can we wait for him to return 
(in about a week) before merging?

