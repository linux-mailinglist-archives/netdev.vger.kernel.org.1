Return-Path: <netdev+bounces-115034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7B944EC6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50AEBB25797
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025313B590;
	Thu,  1 Aug 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0eaF3wA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42313B287
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524943; cv=none; b=BzPOn7XE/ACrO/s9Mbfxw8FVk8jPBjhNGEcHEdMDV7EPMS9YUOWV5nPaAXpDL+c48L+4O9958sb37U22aPPj46j4xVXJlbVrjtT5PazOjPFYQUKRg2rIEuFqvFFe5eCa2PjTbkVfrKVkz6/Bf7gVmlJi4Zd6sapcw/rFqctkfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524943; c=relaxed/simple;
	bh=uMhGNyT4i+2H1pGr9DTjkq4tyyq1R4iFujQ8meOBnjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sADGjCR7YDGQx/yvi5PRhfqneiVlkrIJCaHDma4gfzDCn7UAocVjrTmakKUW00Nto0Q9/JgUHo/xPXqez5BoY/Ffqi2n4MGiG7/snt8fuqLoUucYM5qvgLou1HH1kSRefWnluIxSKu3FV3/e6mHCV6ZXuCMUmMdkQaEpARl2lBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0eaF3wA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50501C32786;
	Thu,  1 Aug 2024 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524942;
	bh=uMhGNyT4i+2H1pGr9DTjkq4tyyq1R4iFujQ8meOBnjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0eaF3wAHGa0OTFrRrf2vvg5g6BrSe5NpuainCl9dSQjna/vb0LFljfNDfj7KvgXH
	 mkJs9Hj1lsIi200zIG+QbI2gs0mMxqT7b11eW504MI8FHaFV85fE2AAcU10nBgI3cb
	 QiRUIDOI7S8jxGFoYxX597xpr3MqIsMkHC++BWa4D4NFrcVwPpqdjGgfVAjua2g+Eo
	 2HfzbgoDg2UPtKSveva18zM2UT1XMNz2k0adoHVY25hmG4tKSxuUVMq7O83L4j5uoK
	 M82KFp1AnA/etN1qbau71JOGFxf8JUrYe0N4Mm2THW7cu3mndgA7FaqkxhTtqFejVg
	 /Sa1pYrkuc0yQ==
Date: Thu, 1 Aug 2024 08:09:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <20240801080901.4c4aa004@kernel.org>
In-Reply-To: <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 22:39:46 +0200 Paolo Abeni wrote:
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/netdevice.h>
> +#include <linux/netlink.h>

most of these could be replaced by forward declaration of types

> +#include <uapi/linux/net_shaper.h>
> +
> +/**
> + * struct net_shaper_info - represents a shaping node on the NIC H/W
> + * zeroed field are considered not set.
> + * @handle: Unique identifier for the shaper, see @net_shaper_make_handle
> + * @parent: Unique identifier for the shaper parent, usually implied. Only
> + *   NET_SHAPER_SCOPE_QUEUE, NET_SHAPER_SCOPE_NETDEV and NET_SHAPER_SCOPE_DETACHED
> + *   can have the parent handle explicitly set, placing such shaper under
> + *   the specified parent.
> + * @metric: Specify if the bw limits refers to PPS or BPS
> + * @bw_min: Minimum guaranteed rate for this shaper
> + * @bw_max: Maximum peak bw allowed for this shaper
> + * @burst: Maximum burst for the peek rate of this shaper
> + * @priority: Scheduling priority for this shaper
> + * @weight: Scheduling weight for this shaper
> + * @children: Number of nested shapers, accounted only for DETACHED scope
> + */
> +struct net_shaper_info {
> +	u32 handle;
> +	u32 parent;
> +	enum net_shaper_metric metric;
> +	u64 bw_min;
> +	u64 bw_max;
> +	u64 burst;
> +	u32 priority;
> +	u32 weight;
> +	u32 children;
> +};
> +
> +/**
> + * define NET_SHAPER_SCOPE_VF - Shaper scope
> + *
> + * This shaper scope is not exposed to user-space; the shaper is attached to
> + * the given virtual function.
> + */
> +#define NET_SHAPER_SCOPE_VF __NET_SHAPER_SCOPE_MAX
> +
> +/**
> + * struct net_shaper_ops - Operations on device H/W shapers
> + *
> + * The initial shaping configuration ad device initialization is empty/
> + * a no-op/does not constraint the b/w in any way.
> + * The network core keeps track of the applied user-configuration in
> + * per device storage.
> + *
> + * Each shaper is uniquely identified within the device with an 'handle',
> + * dependent on the shaper scope and other data, see @shaper_make_handle()

we need to document locking, seems like the locking is.. missing?
Or at least I don't see what prevents two deletes from racing.

> + */
> +struct net_shaper_ops {
> +	/**
> +	 * @group: create the specified shapers group
> +	 *
> +	 * Nest the specified @inputs shapers under the given @output shaper
> +	 * on the network device @dev. The @input shaper array size is specified
> +	 * by @nr_input.
> +	 * Create either the @inputs and the @output shaper as needed,
> +	 * otherwise move them as needed. Can't create @inputs shapers with
> +	 * NET_SHAPER_SCOPE_DETACHED scope, a separate @group call with such
> +	 * shaper as @output is needed.
> +	 *
> +	 * Returns 0 on group successfully created, otherwise an negative
> +	 * error value and set @extack to describe the failure's reason.
> +	 */
> +	int (*group)(struct net_device *dev, int nr_input,
> +		     const struct net_shaper_info *inputs,
> +		     const struct net_shaper_info *output,
> +		     struct netlink_ext_ack *extack);
> +

> +	/* the default id for detached scope shapers is an invalid one
> +	 * to help the 'group' operation discriminate between new
> +	 * detached shaper creation (ID_UNSPEC) and reuse of existing
> +	 * shaper (any other value)
> +	 */
> +	id_attr = tb[NET_SHAPER_A_ID];
> +	if (id_attr)
> +		id =  nla_get_u32(id_attr);

double space

