Return-Path: <netdev+bounces-109888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334292A302
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FECB23E84
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D08063C;
	Mon,  8 Jul 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEwrBgvo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4380624;
	Mon,  8 Jul 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442461; cv=none; b=izlLrdbHifm90IggUlYefFzSw2b5CJu5x6ti77EYs51NLxI5k8PV1wMSq8wxAbOq2YV20IWo++fzoiBt70fBlSj8FQl+sxk0dDhvj8U7R777d3OALyu9BLvwRqDle4z9GQvQ52MY3zTIeKE/KldA39mFP+YjlXbpCoBmD+lLYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442461; c=relaxed/simple;
	bh=inyrxK1CtvgUU1j2vs6I2E3bLGPJnrjr+jybS557Q/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEFsm0jKwR1T8ZoV8Hh9QauCiwXcB7sNEK6SFvLt9AKqF8xKldoZWi3bwafpmD+dQF4gqni1a948DuZVj1yrW6xSJa7J4K6VJFXAi1WWcL63o/nPAOlb5PT32lfsH8KRDTbh5fQKr4ujNaGlTbVAeQ0jfF6yq0Ex3+do7AJk3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEwrBgvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F038EC116B1;
	Mon,  8 Jul 2024 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442460;
	bh=inyrxK1CtvgUU1j2vs6I2E3bLGPJnrjr+jybS557Q/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEwrBgvox5WkrtncTXiEFe6ih35FbSdTY41UbbjL53JEMm7a/GJNjFjrbCpK26jge
	 VVY0a/ZTk+csn26O7CGBCZ/7O6jDPIA7XMVYZgB7JU8XX8ExXp4fHvOdKtIsFIj7WY
	 911F7g8SsGR+ECam03JBPXlwXDd8FIyvFJCV6f/akzFOEs0Sz546tcnFIw0RCoLLCK
	 HYXB7BlNHdKuasE+hAmBVOAtJT+pdntP6oRII1vceGeLbYLDM1W5xNVxCXoCMNIdom
	 MvRkPjTtC/gCGfvz3acgrCkTzA+6ZUm52hMRhMZAJ4ceLFhSu5AVkBF0i0EAffzgiP
	 Lo1NBdu+q9T4Q==
Date: Mon, 8 Jul 2024 13:40:55 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 3/6] ice: add Tx hang
 devlink health reporter
Message-ID: <20240708124055.GN1481495@kernel.org>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
 <20240703125922.5625-4-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-4-mateusz.polchlopek@intel.com>

On Wed, Jul 03, 2024 at 08:59:19AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Add Tx hang devlink health reporter, see struct ice_tx_hang_event to see
> what is reported.
> 
> Subsequent commits will extend it by more info, for now it dumps
> descriptors with little metadata.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

...

> +/**
> + * ice_fmsg_put_ptr - put hex value of pointer into fmsg
> + *
> + * @fmsg: devlink fmsg under construction
> + * @name: name to pass
> + * @ptr: 64 bit value to print as hex and put into fmsg
> + */
> +static void ice_fmsg_put_ptr(struct devlink_fmsg *fmsg, const char *name,
> +                            void *ptr)
> +{
> +       char buf[sizeof(ptr) * 3];
> +
> +       sprintf(buf, "%p", ptr);
> +       devlink_fmsg_put(fmsg, name, buf);
> +}

...

> +static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
> +				     struct devlink_fmsg *fmsg, void *priv_ctx,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct ice_tx_hang_event *event = priv_ctx;
> +
> +	devlink_fmsg_obj_nest_start(fmsg);
> +	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
> +	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
> +	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, vsi_num);
> +	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, queue);
> +	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_clean);
> +	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_use);
> +	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
> +	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
> +	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)event->tx_ring->dma);

As reported by the kernel test robot, GCC 13 complains about this cast:

  .../devlink_health.c: In function 'ice_tx_hang_reporter_dump':
  .../devlink_health.c:76:43: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     76 |         ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)event->tx_ring->dma);
        |   

Perhaps a good solution is to add a helper similar to ice_fmsg_put_ptr,
but which takes a dma_buf_t rather than a void * as it's last argument.

> +	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
> +				     size_mul(event->tx_ring->count,
> +					      sizeof(struct ice_tx_desc)));
> +	devlink_fmsg_obj_nest_end(fmsg);
> +
> +	return 0;
> +}

