Return-Path: <netdev+bounces-120911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9695B2D4
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5175B216C6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A3179206;
	Thu, 22 Aug 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pyjfrqpz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD69364A4
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322182; cv=none; b=QOhpA/SRNaQ+2TtpQGr+81w1QAWBYZqGLCzLvVl7KbDupqhtaAKy5H8lBIPyRAaE+YSMqDVlCQ+nTFS8OkeCTFkXNZgitOC8OnoyMoCq76kMxpIr1ayOzFNGl91XzmATgrbrL0cF1DxFlmM7r90tll3reXqvx+2GOl+0eWyqy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322182; c=relaxed/simple;
	bh=6qQLrdt4izcz2V+I8k7k1v2aOMi/FJ1gQoWP0TsSJ0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrhceHn+SZ11Hkol97bIH7Bfj+Thj6ku//B9qWavi9a7sbbTqH2a3U45/uXL7qgb6PWcw0oBixv7iFMqfI+ubZT2zNPaUg/Q5JfPUAxEsxo5Z4I74N+7Qky5jMxhpexr/t0tP+q8mHjbwrnwQBQ2PmhdMESuli9V2T+RUeVlcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pyjfrqpz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724322179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PM6Bwg2hvkvZKxGLuYJbLZsSu5PxkdBrsa5wx234vH0=;
	b=PyjfrqpzCge1I3IJSfLblOMxi/hK5GXrVo6Sv1KvnSflAMDQ3QJdoh4zDa2+FmQ7Mg9clQ
	Rt0KWUqX3ytGRJI94eKNb+cRR3T62frvCo0ELomoAkxiQwvABWpHR407kPqCIgfGaPBST+
	9+jSOuZWvm15Q3AA4o58vxt24VNCqT0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-GdvLznBcOgy2jG6bvungJg-1; Thu, 22 Aug 2024 06:22:58 -0400
X-MC-Unique: GdvLznBcOgy2jG6bvungJg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280b119a74so4396915e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322177; x=1724926977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PM6Bwg2hvkvZKxGLuYJbLZsSu5PxkdBrsa5wx234vH0=;
        b=NZHk/hkTf+BwR+qc7eMPMcIVQPvT7A3KqPrBmPFXGvlf0MKNEu+IU/hvzvw1+LqHSs
         xq/hxL8VSSzV7Q1ss5x9l/4UcXjrEDyRVHt1ebEwUOvmZSlkszmjwiENNVxWHAOwx/yi
         I0IorEO7hm5maS8rsFhRXi7yxvgVvkuJFRgNv/Lwo84ZoudLcyjzfUVVfm2oDA6KiY2V
         U0dMmtaXagVZ/PtiwWxXykXIbfYfns+6YhnZ61UG5JcDlnAUMFWjYdmDYMiv5kVsVuET
         O1WyddcQ8xbIlnlxECrdOHDw3qMbWsfsM8rr676GuboCvOuIioqWLCG0tdADINMv20UL
         3+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUzR6Zbh5eF0U046farSObzINCNXODhfAYq4a0Pu7HvlVGozcZRtNFF/Ism+jFfj3u5VwmmaXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrNzVkZDx8TQKCI4+qGymkk1Q4h4AqRCK5NfZCpI7Z0kOWR/+
	VHTUiQbJg3dE/6nbCLI2h2fghefUFmdyRuTpaipzfoH+l99sFZ91bBPclrFK3zVOcPyWNVlvAaS
	PVQANgWWhwxoPMhtzNWSu8N44oN7RJi/C5Ay64G00i4PWEezDQAyySQ==
X-Received: by 2002:a05:600c:3583:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-42ac55e440cmr8803105e9.19.1724322177108;
        Thu, 22 Aug 2024 03:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpsGJd5PZXf0Z4sTIzlfw6vDZM3Vr503lNrd8QYAl+YyFwrPZqaNrHyTqZllkRT39KrE6bcQ==
X-Received: by 2002:a05:600c:3583:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-42ac55e440cmr8802925e9.19.1724322176584;
        Thu, 22 Aug 2024 03:22:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a076sm1319222f8f.60.2024.08.22.03.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 03:22:56 -0700 (PDT)
Message-ID: <cc6601a3-6657-4659-9f2b-6dd7856fe8e0@redhat.com>
Date: Thu, 22 Aug 2024 12:22:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] l2tp: avoid using drain_workqueue in
 l2tp_pre_exit_net
To: James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, tparkin@katalix.com, xiyou.wangcong@gmail.com
References: <20240819145208.3209296-1-jchapman@katalix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240819145208.3209296-1-jchapman@katalix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/24 16:52, James Chapman wrote:
> Recent commit c1b2e36b8776 ("l2tp: flush workqueue before draining
> it") incorrectly uses drain_workqueue. 

isn't the relevant commit fc7ec7f554d7d0a27ba339fcf48df11d14413329?

> The use of drain_workqueue in
> l2tp_pre_exit_net is flawed because the workqueue is shared by all
> nets and it is therefore possible for new work items to be queued
> while drain_workqueue runs.
> 
> Instead of using drain_workqueue, use a loop to delete all tunnels and
> __flush_workqueue until all tunnel/session lists of the net are
> empty. Add a per-net flag to ensure that no new tunnel can be created
> in the net once l2tp_pre_exit_net starts.

We need a fixes tag even for net-next fixes :)

> Signed-off-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: Tom Parkin <tparkin@katalix.com>
> ---
>   net/l2tp/l2tp_core.c    | 38 +++++++++++++++++++++++++++++---------
>   net/l2tp/l2tp_core.h    |  2 +-
>   net/l2tp/l2tp_netlink.c |  2 +-
>   net/l2tp/l2tp_ppp.c     |  3 ++-
>   4 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index af87c781d6a6..246b07342b86 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -107,6 +107,7 @@ static struct workqueue_struct *l2tp_wq;
>   /* per-net private data for this module */
>   static unsigned int l2tp_net_id;
>   struct l2tp_net {
> +	bool net_closing;
>   	/* Lock for write access to l2tp_tunnel_idr */
>   	spinlock_t l2tp_tunnel_idr_lock;
>   	struct idr l2tp_tunnel_idr;
> @@ -1560,13 +1561,19 @@ static int l2tp_tunnel_sock_create(struct net *net,
>   	return err;
>   }
>   
> -int l2tp_tunnel_create(int fd, int version, u32 tunnel_id, u32 peer_tunnel_id,
> +int l2tp_tunnel_create(struct net *net, int fd, int version,
> +		       u32 tunnel_id, u32 peer_tunnel_id,
>   		       struct l2tp_tunnel_cfg *cfg, struct l2tp_tunnel **tunnelp)
>   {
> +	struct l2tp_net *pn = l2tp_pernet(net);
>   	struct l2tp_tunnel *tunnel = NULL;
>   	int err;
>   	enum l2tp_encap_type encap = L2TP_ENCAPTYPE_UDP;
>   
> +	/* This pairs with WRITE_ONCE() in l2tp_pre_exit_net(). */
> +	if (READ_ONCE(pn->net_closing))
> +		return -ENETDOWN;

Is this necessary? the netns is going away, no user space process should 
be able to touch it.

> +
>   	if (cfg)
>   		encap = cfg->encap;
>   
> @@ -1855,16 +1870,21 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
>   	}
>   	rcu_read_unlock_bh();
>   
> -	if (l2tp_wq) {
> -		/* ensure that all TUNNEL_DELETE work items are run before
> -		 * draining the work queue since TUNNEL_DELETE requests may
> -		 * queue SESSION_DELETE work items for each session in the
> -		 * tunnel. drain_workqueue may otherwise warn if SESSION_DELETE
> -		 * requests are queued while the work queue is being drained.
> -		 */
> +	if (l2tp_wq)
>   		__flush_workqueue(l2tp_wq);
> -		drain_workqueue(l2tp_wq);
> +
> +	/* repeat until all of the net's IDR lists are empty, in case tunnels
> +	 * or sessions were being created just before l2tp_pre_exit_net was
> +	 * called.
> +	 */
> +	rcu_read_lock_bh();
> +	if (!idr_is_empty(&pn->l2tp_tunnel_idr) ||
> +	    !idr_is_empty(&pn->l2tp_v2_session_idr) ||
> +	    !idr_is_empty(&pn->l2tp_v3_session_idr)) {
> +		rcu_read_unlock_bh();
> +		goto again;

This looks not nice, it could keep the kernel spinning for a while.

What about i.e. queue a 'dummy' work on l2tp_wq after 
__flush_workqueue() and explicitly wait for such work to complete?

when such work completes are other l2tp related one in the same netns 
should also be completed.

Cheers,

Paolo


