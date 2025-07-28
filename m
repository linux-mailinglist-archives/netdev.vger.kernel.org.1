Return-Path: <netdev+bounces-210424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB4B13372
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 05:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100E31895729
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 03:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1A20E70B;
	Mon, 28 Jul 2025 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FY12i37H"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346891A5BBC
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 03:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673873; cv=none; b=iTLPEb6QKh4xJLcw+NB41sdR6St/tnhDcyG1nV/54kxgksx4YvF5cLj4RXkNwS9KdmddaCyKD+JE9A/ii9dlt/g5DzBHAc+FR/vmjQhaczTq9AiCNuHO/jsoAR6o7/TR0ZygjsGEiiBKiTn5WOZOK0chTIsHR6K5EyVSZNNaV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673873; c=relaxed/simple;
	bh=iSNfVsAhxLlOTVc6YyOpjQwWBWKqC4qyfYx/x+m5zis=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=GyEmJfweCYCWatkVZePGyJ9g6OFrrApV2v89Bxec/3yAQbjoO6klvVdn4XdqMBgTRMfh2Upya+fV1AIti5rvQii1SFAYTy1OaZi++SIBhp6hS3cEUKJHLuoxD+tbp0CvzVaZgl2iUgEJWiKAWNz5kEYc/udNmkz9H1aE0Z/j0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FY12i37H; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753673862; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=fryy7PxdB66pk9ZPPtQkA7bhEVtafbLVXyghibrha0I=;
	b=FY12i37HVi6Zj5+6ntDI4G6qHPQzquxUbzXpMOCmO3o0J/Q7HOlJLGPN1sfmMfhIEWZmQ4GwoI0UOQHzCN9JgdGI+lpR+DrwKpBk2Na32tz2f4hLLkXJJ7UrQMbnMne1MTx48YoL6Y6QGNwbm4F4fDWg7ASQUcHBDwKgIX6uZAQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WkByCVx_1753673861 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 11:37:42 +0800
Message-ID: <1753673851.4169824-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2] netpoll: prevent hanging NAPI when netcons gets enabled
Date: Mon, 28 Jul 2025 11:37:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 edumazet@google.com,
 pabeni@redhat.com,
 andrew+netdev@lunn.ch,
 horms@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Jason Wang <jasowang@redhat.com>,
 Zigit Zo <zuozhijie@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 leitao@debian.org,
 sdf@fomichev.me,
 davem@davemloft.net
References: <20250726010846.1105875-1-kuba@kernel.org>
In-Reply-To: <20250726010846.1105875-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

On Fri, 25 Jul 2025 18:08:46 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> Paolo spotted hangs in NIPA running driver tests against virtio.
> The tests hang in virtnet_close() -> virtnet_napi_tx_disable().
>
> The problem is only reproducible if running multiple of our tests
> in sequence (I used TEST_PROGS=3D"xdp.py ping.py netcons_basic.sh \
> netpoll_basic.py stats.py"). Initial suspicion was that this is
> a simple case of double-disable of NAPI, but instrumenting the
> code reveals:
>
>  Deadlocked on NAPI ffff888007cd82c0 (virtnet_poll_tx):
>    state: 0x37, disabled: false, owner: 0, listed: false, weight: 64
>
> The NAPI was not in fact disabled, owner is 0 (rather than -1),
> so the NAPI "thinks" it's scheduled for CPU 0 but it's not listed
> (!list_empty(&n->poll_list) =3D> false). It seems odd that normal NAPI
> processing would wedge itself like this.
>
> Better suspicion is that netpoll gets enabled while NAPI is polling,
> and also grabs the NAPI instance. This confuses napi_complete_done():
>
>   [netpoll]                                   [normal NAPI]
>                                         napi_poll()
>                                           have =3D netpoll_poll_lock()
>                                             rcu_access_pointer(dev->npinf=
o)
>                                               return NULL # no netpoll
>                                           __napi_poll()
> 					    ->poll(->weight)
>   poll_napi()
>     cmpxchg(->poll_owner, -1, cpu)
>       poll_one_napi()
>         set_bit(NAPI_STATE_NPSVC, ->state)
>                                               napi_complete_done()
>                                                 if (NAPIF_STATE_NPSVC)
>                                                   return false
>                                            # exit without clearing SCHED
>
> This feels very unlikely, but perhaps virtio has some interactions
> with the hypervisor in the NAPI ->poll that makes the race window
> larger?
>
> Best I could to to prove the theory was to add and trigger this
> warning in napi_poll (just before netpoll_poll_unlock()):
>
>       WARN_ONCE(!have && rcu_access_pointer(n->dev->npinfo) &&
>                 napi_is_scheduled(n) && list_empty(&n->poll_list),
>                 "NAPI race with netpoll %px", n);
>
> If this warning hits the next virtio_close() will hang.
>
> This patch survived 30 test iterations without a hang (without it
> the longest clean run was around 10). Credit for triggering this
> goes to Breno's recent netconsole tests.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat=
.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - move the sync to netpoll_setup()
> v1: https://lore.kernel.org/20250725024454.690517-1-kuba@kernel.org
>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Zigit Zo <zuozhijie@bytedance.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> CC: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> CC: leitao@debian.org
> CC: sdf@fomichev.me
> ---
>  net/core/netpoll.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index a1da97b5b30b..5f65b62346d4 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -768,6 +768,13 @@ int netpoll_setup(struct netpoll *np)
>  	if (err)
>  		goto flush;
>  	rtnl_unlock();
> +
> +	/* Make sure all NAPI polls which started before dev->npinfo
> +	 * was visible have exited before we start calling NAPI poll.
> +	 * NAPI skips locking if dev->npinfo is NULL.
> +	 */
> +	synchronize_rcu();
> +
>  	return 0;
>
>  flush:
> --
> 2.50.1
>

