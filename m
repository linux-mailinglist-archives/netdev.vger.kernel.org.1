Return-Path: <netdev+bounces-150450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738869EA451
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085AB18829C2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD633433C0;
	Tue, 10 Dec 2024 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qzlD/Nr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5818E3F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794146; cv=none; b=F5d6+CtQLIUPRmBCZV9d0chbgr+osf0MtfbEqFUYHHdwob7Bvu+HRW7bcDCO+c+dDDPirS2fk/kJiVKDxOHKx912W3yZuLz88bvkyIIQCWhEoeIeNiBJ28onlndRgz8/olrB7uVrbJnAxjb79PvstkxFuP3z4DiUprCFzlNAazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794146; c=relaxed/simple;
	bh=CrYzlv+iLOZoklG5euK8cUyJYA3xUi0+7Ktshm7Loz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoBzJCixBshHtxI/KQo8KpF4fOba7qKDaExVX2HN0C5P5C0XvaP+JnfrIN5OzeYrdQk7Sx2vi648Y+8sTfE1JiFE08JQMPMsb64YseuCg98veexEZaprnzKOM5YT7/aHDrxHWsde2yfdLVn1ZAAEPm69Udg3fPDgbpxRCp6tH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qzlD/Nr7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-726b939f0c0so1315087b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 17:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733794144; x=1734398944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vvZ8mNgQOqv9Mg4Vnx4KEpPxGZz8wEUG/03GLTx8B8=;
        b=qzlD/Nr7g8DCzwGTdh8u+cILoTIf2zbF679rC7WEHkdZxAmPSBZX5njF6+t+HeGR4c
         Giv5oWm1v7/5t5rDmYy+xf17E0ScwuhVxSWIgv6pGEeQ/OLtd9TAHVSU7ViPF0QZ4KT3
         BH+00boTLikwDNV0JY8Omw8iPireywUysgB2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794144; x=1734398944;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vvZ8mNgQOqv9Mg4Vnx4KEpPxGZz8wEUG/03GLTx8B8=;
        b=d/VA3+nHiIPNOQHSGIwKNgsA8rS9f2cIWC0ugSuEMU0O8cKuLKjgZFmCGUBnk3+zbE
         80s7Zxz15ckFsnhrA6ebRUNfOBzgeoZEDcN83QEtFaDXwKJbti/WXbmIv+UpxGYH+6pz
         LLuA64nAAZHHqo7bPO80CDX40ycxTfxuH7G0k8W/23V+CvmVSZM8qED8FcfV/VYv/OjJ
         btI6fjH4GZmVkyeliFO1TVjMEg5hS6gKApYgoLrclAJtrasUYhnaku3wijlRQV58gg0m
         SatZKQMYsL+txJo6eFMfqIXeDuj909C8PqFtxZFiVl33+uoEpnO9d/DFW4yCYBZ0Sj8J
         QKvw==
X-Gm-Message-State: AOJu0YxlYUhLi4EgVdOv4bV0xEczXeRUWp2b1gqVshdl+Wx+3UyXtQLi
	z8ld5v0G+BkgqUk1FgkueJg0SDkZVP1AAvVF6V7fCUAP0ziXywCaBfRT0OoOjYs=
X-Gm-Gg: ASbGncu/5XFQEwvxvn1EdYVE0oN7Mqi5deiRdvCRUMeUzXkLqIiCrIteEbww7GWFHsR
	m1K96EWzSKnZcChEl9ClaXPqpn1zSMJF46wasS30TSj3p4rDidOc8rOkpB3KdTmLbM/EJj8x6ia
	usPqb4ExeU04M/k/Pd1rto3ss2qiricIPxFUdBCCjy2066xSZhV9Ugc8G46wV+LfezqliMAZ4Jp
	fAGRumhwBSC8YEDMZHSXDABU8lRhmLMTqqmtuLYAVU8mZGxo86MjZh/QwaO4AaGLumH3YCvDkTb
	iJR2bFzhaflq+YFu7KzI
X-Google-Smtp-Source: AGHT+IHTGRJJLmGpS+B3n881CxEm2xxSY0XzWxa48OEmh9li0OpcPMXPe2nCWR3JJ+xzAK5w8NWXJg==
X-Received: by 2002:a05:6a00:1815:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-7273cb144f0mr4187888b3a.12.1733794144041;
        Mon, 09 Dec 2024 17:29:04 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ce38be8dsm5093689b3a.149.2024.12.09.17.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:29:03 -0800 (PST)
Date: Mon, 9 Dec 2024 17:29:00 -0800
From: Joe Damato <jdamato@fastly.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 net-next 2/6] net: napi: add CPU affinity to
 napi->config
Message-ID: <Z1eZXKe58ncARD2N@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
References: <20241210002626.366878-1-ahmed.zaki@intel.com>
 <20241210002626.366878-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210002626.366878-3-ahmed.zaki@intel.com>

On Mon, Dec 09, 2024 at 05:26:22PM -0700, Ahmed Zaki wrote:
> A common task for most drivers is to remember the user's CPU affinity to
> its IRQs. On each netdev reset, the driver must then re-assign the
> user's setting to the IRQs.
> 
> Add CPU affinity mask to napi->config. To delegate the CPU affinity
> management to the core, drivers must:
>  1 - add a persistent napi config:     netif_napi_add_config()
>  2 - bind an IRQ to the napi instance: netif_napi_set_irq()
> 
> the core will then make sure to use re-assign affinity to the napi's
> IRQ.
> 
> The default mask set to all IRQs is all online CPUs.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6ef9eb401fb2..778ba27d2b83 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6699,11 +6699,35 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
>  }
>  EXPORT_SYMBOL(netif_queue_set_napi);
>  
> +static void
> +netif_napi_affinity_notify(struct irq_affinity_notify *notify,
> +			   const cpumask_t *mask)
> +{
> +	struct napi_struct *napi =
> +		container_of(notify, struct napi_struct, affinity_notify);
> +
> +	if (napi->config)
> +		cpumask_copy(&napi->config->affinity_mask, mask);
> +}
> +
> +static void
> +netif_napi_affinity_release(struct kref __always_unused *ref)
> +{
> +}
> +
>  static void napi_restore_config(struct napi_struct *n)
>  {
>  	n->defer_hard_irqs = n->config->defer_hard_irqs;
>  	n->gro_flush_timeout = n->config->gro_flush_timeout;
>  	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
> +
> +	if (n->irq > 0 && n->irq_flags & NAPIF_F_IRQ_AFFINITY) {
> +		n->affinity_notify.notify = netif_napi_affinity_notify;
> +		n->affinity_notify.release = netif_napi_affinity_release;
> +		irq_set_affinity_notifier(n->irq, &n->affinity_notify);
> +		irq_set_affinity(n->irq, &n->config->affinity_mask);
> +	}
> +
>  	/* a NAPI ID might be stored in the config, if so use it. if not, use
>  	 * napi_hash_add to generate one for us. It will be saved to the config
>  	 * in napi_disable.
> @@ -6720,6 +6744,8 @@ static void napi_save_config(struct napi_struct *n)
>  	n->config->gro_flush_timeout = n->gro_flush_timeout;
>  	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
>  	n->config->napi_id = n->napi_id;
> +	if (n->irq > 0 && n->irq_flags & NAPIF_F_IRQ_AFFINITY)
> +		irq_set_affinity_notifier(n->irq, NULL);

My understanding when I attempted this was that using generic IRQ
notifiers breaks ARFS [1], because IRQ notifiers only support a
single notifier and so drivers with ARFS can't _also_ set their own
notifiers for that.

Two ideas were proposed in the thread I mentioned:
  1. Have multiple notifiers per IRQ so that having a generic core
     based notifier wouldn't break ARFS.
  2. Jakub mentioned calling cpu_rmap_update from the core so that a
     generic solution wouldn't be blocked.

I don't know anything about option 1, so I looked at option 2.

At the time when I read the code, it seemed that cpu_rmap_update
required some state be passed in (struct irq_glue), so in that case,
the only way to call cpu_rmap_update from the core would be to
maintain some state about ARFS in the core, too, so that drivers
which support ARFS won't be broken by this change.

At that time there was no persistent per-NAPI config, but since
there is now, there might be a way to solve this.

Just guessing here, but maybe one way to solve this would be to move
ARFS into the core by:
  - Adding a new bit in addition to NAPIF_F_IRQ_AFFINITY... I don't
    know NAPIF_F_ARFS_AFFINITY or something? so that drivers
    could express that they support ARFS.
  - Remove the driver calls to irq_cpu_rmap_add and make sure to
    pass the new bit in for drivers that support ARFS (in your
    changeset, I believe that would be at least ice, mlx4, and
    bnxt... possibly more?).
  - In the generic core code, if the ARFS bit is set then you pass
    in the state needed for ARFS to work, otherwise do what the
    proposed code is doing now.

But, that's just a guess. Maybe there's a better way.

In any case, the proposed change as-is, I think, breaks ARFS in the
same way my proposed change did, so I think any further iterations
on this might need to also include something to avoid breaking ARFS.

FWIW, I was trying to solve a slightly different problem which was
removing a repeated check in driver napi poll functions to determine
if the IRQ affinity had changed.

But with the persistent NAPI state, it might be possible to solve
all of these problems in one go since they are all related?

[1]: https://lore.kernel.org/lkml/701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com/

