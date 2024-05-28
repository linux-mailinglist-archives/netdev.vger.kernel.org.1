Return-Path: <netdev+bounces-98709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6598D2250
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D087C284667
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4440172791;
	Tue, 28 May 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVu93Ewv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9717082D
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916727; cv=none; b=peymioeEGDfTYH3fhppk+t38OTF3Whh0snUr4lgiVbNBv/1etOyB/99C/XXdhk0awAEXaz0L7iie5PHpJc9knVwUjpfXb+WmSbfvWkcNfu/csrauLAY9sN9584AsC/BxfAgMzmf5+JFQVBNNK7gAGt1CAcc5Z4GC0WNOZELKYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916727; c=relaxed/simple;
	bh=RZhCgosNSDDiBFuNlEmZo0/asrIiXziscLxhdpFRUOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a27VqsWJJ5t/RQaN4v52TdMqoNpDoQC+nCLJLheLzmAiZFiyT2DvDgH6pG1r56MyGnvaqwJbidrZhyvPu/Df5/dJa4egE5ox0f6wF/FGOIlWC7knZ/5KFAsxIaQVv3lttMFJo9CdN+Hz0CKklh/n3OTlAgWD/1YPNU9LriDHHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVu93Ewv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1661C3277B;
	Tue, 28 May 2024 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916727;
	bh=RZhCgosNSDDiBFuNlEmZo0/asrIiXziscLxhdpFRUOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WVu93Ewvs+n86KuZ3fyBopNEYoFTtXTswwA7D4RqDeo7kf7TeBpOy86yfbtwnZSDP
	 aqzJPEaItIkjiynTJPf/JcqeMKXn8RCNkIXWZ687ECKgUuJF+Q0naFo6EachUNM+0N
	 DTzprRGdiX2oa/XxXVpNFC2JGfN/BongwfWHB+chHykURKXwoR8DYmGNweNv2qJbvp
	 SPJNW3Y9qlAbCdhgtkPbF4OOaRFo33tIoAwxwiSUVHyLdsO3WhVi0BIq/c2m5q/P5C
	 dEITi/mg5Fqtbll3zgEeUCEkfWejnJC4jjP5GT0AT0hnV6OJz3sb2vDbxh/ZU1NzTw
	 3c5MtJbz//lmA==
Date: Tue, 28 May 2024 10:18:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <20240528101845.414cff22@kernel.org>
In-Reply-To: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  8 May 2024 22:20:51 +0200 Paolo Abeni wrote:
> +/**
> + * struct net_shaper_info - represents a shaping node on the NIC H/W
> + * @metric: Specify if the bw limits refers to PPS or BPS
> + * @bw_min: Minimum guaranteed rate for this shaper
> + * @bw_max: Maximum peak bw allowed for this shaper
> + * @burst: Maximum burst for the peek rate of this shaper
> + * @priority: Scheduling priority for this shaper
> + * @weight: Scheduling weight for this shaper
> + */
> +struct net_shaper_info {
> +	enum net_shaper_metric metric;
> +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
> +	u64 bw_max;	/* maximum allowed bandwidth */
> +	u32 burst;	/* maximum burst in bytes for bw_max */

Burst is burst, either we need two or we assume it's for both bw_min
and bw_max, but it most certainly can't be just for bw_max.

Also presumably not just bytes - if "metric" is pps, burst is pps?

> +	u32 priority;	/* scheduling strict priority */
> +	u32 weight;	/* scheduling WRR weight*/

I wonder if we should somehow more clearly specify what a node can do.
Like Andrew pointed out, if we have a WRR node, presumably the weights
go on the children, since there's only one weigh param. But then the
WRR node itself is either empty (no params) or has rate params... which
is odd.

Maybe shaping nodes and RR nodes should be separate node classes,
somehow?

> +};
> +
> +/**
> + * enum net_shaper_scope - the different scopes where a shaper could be =
attached
> + * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
> + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network devic=
e.
> + * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtual
> + * function.
> + * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple queues unde=
r the
> + * same device.
> + * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given device =
queue.

I wonder if we need traffic class? Some devices may have two schedulers,
one from the host interfaces (PCIe) into the device buffer. And then
from the device buffer independently into the wire.

> + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only available on
> + * PF devices, usually inside the host/hypervisor.
> + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
> + */
> +enum net_shaper_scope {
> +	NET_SHAPER_SCOPE_PORT,
> +	NET_SHAPER_SCOPE_NETDEV,
> +	NET_SHAPER_SCOPE_VF,

I realized now that we do indeed need this VF node (if we want to
internally express the legacy SRIOV NDOs in this API), as much=20
as I hate it. Could you annotate somehow my nack on ever exposing
the ability to hook on the VF to user space?

> +	NET_SHAPER_SCOPE_QUEUE_GROUP,

We may need a definition for a queue group. Did I suggest this?
Isn't queue group just a bunch of queues feeding a trivial RR node?
Why does it need to be a "scope"?

> +	NET_SHAPER_SCOPE_QUEUE,
> +};
> +
> +/**
> + * struct net_shaper_ops - Operations on device H/W shapers
> + * @add: Creates a new shaper in the specified scope.

"in a scope"? Isn't the scope just defining the ingress and egress
points of the scheduling hierarchy?

Also your example moves schedulers from queue scope to queue group
scope.

> + * @set: Modify the existing shaper.
> + * @delete: Delete the specified shaper.
> + * @move: Move an existing shaper under a different parent.
> + *
> + * The initial shaping configuration ad device initialization is empty/

and

> + * a no-op/does not constraint the b/w in any way.
> + * The network core keeps track of the applied user-configuration in
> + * per device storage.

"keeps track .. per device" -- "storage" may make people think NVM.

> + * Each shaper is uniquely identified within the device with an 'handle',
> + * dependent on the shaper scope and other data, see @shaper_make_handle=
()
> + */
> +struct net_shaper_ops {
> +	/** add - Add a shaper inside the shaper hierarchy
> +	 * @dev: netdevice to operate on
> +	 * @handle: the shaper indetifier
> +	 * @shaper: configuration of shaper
> +	 * @extack: Netlink extended ACK for reporting errors.
> +	 *
> +	 * Return:
> +	 * * 0 on success
> +	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> +	 *                  or core for any reason. @extack should be set to
> +	 *                  text describing the reason.
> +	 * * Other negative error values on failure.
> +	 *
> +	 * Examples or reasons this operation may fail include:
> +	 * * H/W resources limits.
> +	 * * Can=E2=80=99t respect the requested bw limits.
> +	 */
> +	int (*add)(struct net_device *dev, u32 handle,
> +		   const struct net_shaper_info *shaper,
> +		   struct netlink_ext_ack *extack);
> +
> +	/** set - Update the specified shaper, if it exists

Why "if it exists" ? Core should make sure it exists, no?

In addition to ops and state, the device will likely need to express
capabilities of some sort. So that the core can do some work for the
drivers and in due course we can expose them to user space for
discoverability.

