Return-Path: <netdev+bounces-176765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB2A6C0F8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FD61B60D92
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F122D7A2;
	Fri, 21 Mar 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LBptL/CU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B022D791
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577016; cv=none; b=ZKerHqXtMwpMH3Iz2N3VkJMyvjgPYW2+3AwEGAc6w8jIQO6rAGWChldL9kKC8QTSkZmKF13qnZqROjxPhR0YPBkwI0AkkSx/WEAOfa9XNioEhb5lMEEs2YNDROcLR7BUkWbbHQSD1UuLMjmoHS/RSrD/B6TUWUFLLhvDEat3gZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577016; c=relaxed/simple;
	bh=AbtqjHhnNemg/bE6YUYWWlcODFUCy1ZpcbKvffaIpo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq+sYdituigNpt2LeTUldZ3YcYjAEOPU31t3ZBLjvvAt6Lb9Si2dbocKzqBBjEmuf1MYC6VvI2fD8ev9OmHtz0bX8b9PV/NZB6VrroD5spJI6b4i1ZoF5PhYPYYR3Hu4So3agBW2jesVoJbNydcpNvcE9+EywcZ+30bdY0gewr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LBptL/CU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso3600102a91.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742577013; x=1743181813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpXL4k6DFrtf5XspZQ1o34hmXXdJFYAzhIfGHuPw1Kk=;
        b=LBptL/CUDcWZAguc1Y0zWp3F+O46s81OxVv3iSyy6FpSetE4yMk70jwJoSobiSLEPg
         BYQ5t9ChTTEyNQhsB+8bOiVIWvwizPBBf6auWPc1346l3TGOvuc6BGT9WtFrkodOlL2f
         oSCDpKWk9UKpsY/J75nHzp3izstGnRY7188XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577013; x=1743181813;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpXL4k6DFrtf5XspZQ1o34hmXXdJFYAzhIfGHuPw1Kk=;
        b=QZxhYrH5naSjWoxWW8oDzKGIZHwnhnsIZEeIgoHh1yGHeXPmsGO1rl4D/qad49K+//
         CBGn/tdEYnwQAzFqYoB6PHIeGaThM8Enuq1Z0yr0KhnGYQbzVn0OwDGzuFuYpckL9P99
         MTIWw0N27oTs9PE3GiGxnglAv0NMq3XgzAH6cXVBp/7lLJnJTgJGWlv7sZWHT0ETtayl
         Up3v1eiZZLnaQjiggjHvgcv28R/wQl6qDOQsdJmNdrfEYAXDel6vlJbVj3R9gYxbaFba
         0KTu47ghpUPESdgWFMWA+RXalP1zw246MYcePAU73EUapnOMgFI9ls+yYwOVREo50v+s
         4jEA==
X-Forwarded-Encrypted: i=1; AJvYcCWdlyRn/BRbO+arlVgqA6KabnX7jcceN39qxDGH7WLhBEtK65B0QdGZHKnVw57MwVxlQQdEVZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxehTa8Y/9EkI7o7fjNcZYxSRqASg6OI07cH9uWk+IBJXsjgVSv
	UZdIE91rYeCCSXArjWWAuajP/cna159H6gqZNZHTzTiCz7d0XqOq6RDgC3x8Xgw=
X-Gm-Gg: ASbGnctvtk3O+7oJG69NPMtO9XNmQWlzFWxEQAbsF3/IYS5jsnqz7npCnlv7IEAawb6
	UZatWbDtdR2YQhclj1CnPuL6efa2ENLnCen8BM6vXio9TtubTwv6KdgU67mAXoawicU70L1jT1q
	//Ax2IedEdXcQn0ivTxpEdnTX9UN0KGce9XhHRhhNBckrwkB+JolR2P1bLBKYFQSP18Rzm3L5OO
	n9ljjIvrVXRqYi1ODbVZF5OnYO6NeYqlzzQptpBF0iAcWLfm5eJMVr31LnMhSRoTx0H1yHJjCC+
	Dfw/2wyGgE/70GWO/cCpXK121ZGGVjXWxOeGKbjmb9CMTLeaFR7esFqllMFAyhtLc+iJ05dhut4
	ubaxbggEuBeaTphA8
X-Google-Smtp-Source: AGHT+IFYWJ1NFiADGNzUgasm93iN2NE+eF0NnylUvwD9Za2QlsDZ3C1W+31mWXMesJhz11q35q0Ybw==
X-Received: by 2002:a17:90a:ec8c:b0:2ff:6e72:b8e9 with SMTP id 98e67ed59e1d1-3030fee7104mr6936822a91.25.1742577012726;
        Fri, 21 Mar 2025 10:10:12 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f806fb9sm2267327a91.45.2025.03.21.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:10:12 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:10:09 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] Add support to set napi threaded for
 individual napi
Message-ID: <Z92dcVfEiI2g8XOZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250321021521.849856-1-skhawaja@google.com>
 <20250321021521.849856-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321021521.849856-2-skhawaja@google.com>

On Fri, Mar 21, 2025 at 02:15:18AM +0000, Samiullah Khawaja wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> napi polling on all of the NAPI contexts under that device. Allow
> enabling threaded napi polling at individual napi level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a napi
> context.
> 
> Tested using following command in qemu/virtio-net:
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>   --do napi-set       --json '{"id": 66, "threaded": 1}'
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 10 ++++++++
>  Documentation/networking/napi.rst       | 13 ++++++++++-
>  include/linux/netdevice.h               | 10 ++++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/dev.c                          | 31 +++++++++++++++++++++++++
>  net/core/netdev-genl-gen.c              |  5 ++--
>  net/core/netdev-genl.c                  |  9 +++++++
>  tools/include/uapi/linux/netdev.h       |  1 +
>  8 files changed, 77 insertions(+), 3 deletions(-)

I still think that this patch could be submit on its own, separate
from this series, with its own selftest.

It seems generally useful to be able to enable threaded NAPI on a
per-NAPI basis, unrelated to the rest of the work in the series.

> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index f5e0750ab71d..92f98f2a6bd7 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -280,6 +280,14 @@ attribute-sets:
>          doc: The timeout, in nanoseconds, of how long to suspend irq
>               processing, if event polling finds events
>          type: uint
> +      -
> +        name: threaded
> +        doc: Whether the napi is configured to operate in threaded polling
> +             mode. If this is set to `1` then the NAPI context operates
> +             in threaded polling mode.
> +        type: u32

I think the type should be uint instead of u32?

> +        checks:
> +          max: 1
>    -
>      name: xsk-info
>      attributes: []
> @@ -691,6 +699,7 @@ operations:
>              - defer-hard-irqs
>              - gro-flush-timeout
>              - irq-suspend-timeout
> +            - threaded
>        dump:
>          request:
>            attributes:
> @@ -743,6 +752,7 @@ operations:
>              - defer-hard-irqs
>              - gro-flush-timeout
>              - irq-suspend-timeout
> +            - threaded
>  
>  kernel-family:
>    headers: [ "net/netdev_netlink.h"]
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
> index d0e3953cae6a..63f98c05860f 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -444,7 +444,18 @@ dependent). The NAPI instance IDs will be assigned in the opposite
>  order than the process IDs of the kernel threads.
>  
>  Threaded NAPI is controlled by writing 0/1 to the ``threaded`` file in
> -netdev's sysfs directory.
> +netdev's sysfs directory. It can also be enabled for a specific napi using
> +netlink interface.
> +
> +For example, using the script:
> +
> +.. code-block:: bash
> +
> +  $ kernel-source/tools/net/ynl/pyynl/cli.py \
> +            --spec Documentation/netlink/specs/netdev.yaml \
> +            --do napi-set \
> +            --json='{"id": 66,
> +                     "threaded": 1}'
>  
>  .. rubric:: Footnotes
>  
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0c5b1f7f8f3a..3c244fd9ae6d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -369,6 +369,7 @@ struct napi_config {
>  	u64 irq_suspend_timeout;
>  	u32 defer_hard_irqs;
>  	cpumask_t affinity_mask;
> +	bool threaded;
>  	unsigned int napi_id;
>  };
>  
> @@ -590,6 +591,15 @@ static inline bool napi_complete(struct napi_struct *n)
>  
>  int dev_set_threaded(struct net_device *dev, bool threaded);
>  
> +/*
> + * napi_set_threaded - set napi threaded state
> + * @napi: NAPI context
> + * @threaded: whether this napi does threaded polling
> + *
> + * Return 0 on success and negative errno on failure.
> + */
> +int napi_set_threaded(struct napi_struct *napi, bool threaded);
> +
>  void napi_disable(struct napi_struct *n);
>  void napi_disable_locked(struct napi_struct *n);
>  
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 7600bf62dbdf..fac1b8ffeb55 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -134,6 +134,7 @@ enum {
>  	NETDEV_A_NAPI_DEFER_HARD_IRQS,
>  	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
>  	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
> +	NETDEV_A_NAPI_THREADED,
>  
>  	__NETDEV_A_NAPI_MAX,
>  	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 235560341765..b92e4e8890d1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6806,6 +6806,30 @@ static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> +{
> +	if (napi->dev->threaded)
> +		return -EINVAL;

This works differently than the existing per-NAPI defer_hard_irqs /
gro_flush_timeout which are also interface wide.

In that implementation: 
  - the per-NAPI value is set when requested by the user
  - when the sysfs value is written, all NAPIs have their values
    overwritten to the sysfs value

I think either:
  - This implementation should work like the existing ones, or
  - The existing ones should be changed to work like this

I am opposed to have two different behaviors when setting per-NAPI
vs system/nic-wide sysfs values.

I don't have a preference on which behavior is chosen, but the
behavior should be the same for all of the things that are
system/nic-wide and moving to per-NAPI.

> +	if (threaded) {
> +		if (!napi->thread) {
> +			int err = napi_kthread_create(napi);
> +
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	if (napi->config)
> +		napi->config->threaded = threaded;
> +
> +	/* Make sure kthread is created before THREADED bit is set. */
> +	smp_mb__before_atomic();
> +	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> +
> +	return 0;
> +}
> +
>  int dev_set_threaded(struct net_device *dev, bool threaded)
>  {
>  	struct napi_struct *napi;
> @@ -6817,6 +6841,11 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>  		return 0;
>  
>  	if (threaded) {
> +		/* Check if threaded is set at napi level already */
> +		list_for_each_entry(napi, &dev->napi_list, dev_list)
> +			if (test_bit(NAPI_STATE_THREADED, &napi->state))
> +				return -EINVAL;
> +

Same comment as above.

>  		list_for_each_entry(napi, &dev->napi_list, dev_list) {
>  			if (!napi->thread) {
>  				err = napi_kthread_create(napi);
> @@ -7063,6 +7092,8 @@ static void napi_restore_config(struct napi_struct *n)
>  		napi_hash_add(n);
>  		n->config->napi_id = n->napi_id;
>  	}
> +
> +	napi_set_threaded(n, n->config->threaded);

I feel like if this fails, it should only be because
napi_kthread_create fails (as described above), which I think should
probably generate a warning, perhaps via WARN_ON_ONCE ?

>  }
>  
>  static void napi_save_config(struct napi_struct *n)
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 739f7b6506a6..c2e5cee857d2 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -92,11 +92,12 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
>  };
>  
>  /* NETDEV_CMD_NAPI_SET - do */
> -static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT + 1] = {
> +static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED + 1] = {
>  	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
>  	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
>  	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
>  	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
> +	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
>  };
>  
>  /* Ops table for netdev */
> @@ -187,7 +188,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
>  		.cmd		= NETDEV_CMD_NAPI_SET,
>  		.doit		= netdev_nl_napi_set_doit,
>  		.policy		= netdev_napi_set_nl_policy,
> -		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
> +		.maxattr	= NETDEV_A_NAPI_THREADED,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  };
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a186fea63c09..057001c3bbba 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -186,6 +186,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>  	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
>  		goto nla_put_failure;
>  
> +	if (nla_put_u32(rsp, NETDEV_A_NAPI_THREADED, !!napi->thread))
> +		goto nla_put_failure;
> +
>  	if (napi->thread) {
>  		pid = task_pid_nr(napi->thread);
>  		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
> @@ -324,8 +327,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
>  {
>  	u64 irq_suspend_timeout = 0;
>  	u64 gro_flush_timeout = 0;
> +	u32 threaded = 0;
>  	u32 defer = 0;
>  
> +	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
> +		threaded = nla_get_u32(info->attrs[NETDEV_A_NAPI_THREADED]);
> +		napi_set_threaded(napi, !!threaded);
> +	}
> +
>  	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
>  		defer = nla_get_u32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
>  		napi_set_defer_hard_irqs(napi, defer);
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
> index 7600bf62dbdf..fac1b8ffeb55 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -134,6 +134,7 @@ enum {
>  	NETDEV_A_NAPI_DEFER_HARD_IRQS,
>  	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
>  	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
> +	NETDEV_A_NAPI_THREADED,
>  
>  	__NETDEV_A_NAPI_MAX,
>  	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

