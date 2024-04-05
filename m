Return-Path: <netdev+bounces-85169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9EF899AA9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4030E283800
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58B1649DF;
	Fri,  5 Apr 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh/Vr4rn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EA1649DC
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312687; cv=none; b=DOiDuyTdKaBaX9+lUYSOkbQ3oCH5efjjGzUsrul/+dS9bo4Ef/sxkOOjarmrqGZl8HDAMdewzuIYJKm61rzZ030ZdnnnHHlSKLTDmFklQdA2wVVp4fg21WrMwNfsuXsJ1ghE/20CArggFl3OE7732j0nc0wVamfU7KyJY0DOy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312687; c=relaxed/simple;
	bh=43wk8HZ0mt55F6j0HCuDCI36YwFH6sfak+q8/iD6ssE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LTLofwjs3B7nWoPHUNWtJCc3wiwirQsbeQaL3O4JHmpQLPpWaREEi8F8n6QhIIBHlWNt9MeQSY4sYTNbc3PZQf/Oto2CxbcihuaZQOvfFe/diyWq4Mtu0eDI6AN7me5o7pgCIfZrKGLc3bhG9DMZbRML75o62J+Am+XvUsdabWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh/Vr4rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04993C43394;
	Fri,  5 Apr 2024 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712312687;
	bh=43wk8HZ0mt55F6j0HCuDCI36YwFH6sfak+q8/iD6ssE=;
	h=Date:From:To:Cc:Subject:From;
	b=Dh/Vr4rn8zyo/4jE4F0ElPsbXfCMe57DmnVBc/oAFb/NcKX/mZq7xrkYvIfKVZ00x
	 bItrNi/NvgldqE/EkGmNBI/tCsLyxuCy4qe41E2lKLkXVjsTL6UaXfITm/GnIPavD7
	 n/CClzoLCGnidWZc4t9o/kcx/pTm/Vb2Zwhh6ApNuJ8SlXXflwIyXP/kmSYjKvbVmX
	 ZDkM19Yc15UhJZn3bQa2Ch3iCYA8T7mt2wgB2AuEUyUg43YHqb7DmTthVwkexhqK12
	 YGXvczowbbppzKqJeMK5S0AuuT0xPXVA8vnWwwfBmVo7UTnJew3KgmeNDZ8xO4DjrU
	 7KH/dznU7t7Jg==
Date: Fri, 5 Apr 2024 11:23:13 +0100
From: Simon Horman <horms@kernel.org>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC] HW TX Rate Limiting Driver API
Message-ID: <20240405102313.GA310894@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

This is follow-up to the ongoing discussion started by Intel to extend the
support for TX shaping H/W offload [1].

The goal is allowing the user-space to configure TX shaping offload on a
per-queue basis with min guaranteed B/W, max B/W limit and burst size on a
VF device.


In the past few months several different solutions were attempted and
discussed, without finding a perfect fit:

- devlink_rate APIs are not appropriate for to control TX shaping on netdevs
- No existing TC qdisc offload covers the required feature set
- HTB does not allow direct queue configuration
- MQPRIO imposes constraint on the maximum number of TX queues
- TBF does not support max B/W limit
- ndo_set_tx_maxrate() only controls the max B/W limit

A new H/W offload API is needed, but offload API proliferation should be
avoided.

The following proposal intends to cover the above specified requirement and
provide a possible base to unify all the shaping offload APIs mentioned above.

The following only defines the in-kernel interface between the core and
drivers. The intention is to expose the feature to user-space via Netlink.
Hopefully the latter part should be straight-forward after agreement
on the in-kernel interface.

All feedback and comment is more then welcome!

[1] https://lore.kernel.org/netdev/20230808015734.1060525-1-wenjun1.wu@intel.com/

Regards,
Simon with much assistance from Paolo

--- 
/* SPDX-License-Identifier: GPL-2.0-or-later */

#ifndef _NET_SHAPER_H_
#define _NET_SHAPER_H_

/**
 * enum shaper_metric - the metric of the shaper
 * @SHAPER_METRIC_PPS: Shaper operates on a packets per second basis
 * @SHAPER_METRIC_BPS: Shaper operates on a bits per second basis
 */
enum shaper_metric {
	SHAPER_METRIC_PPS;
	SHAPER_METRIC_BPS;
};

#define SHAPER_ROOT_ID 0
#define SHAPER_NONE_ID UINT_MAX

/**
 * struct shaper_info - represent a node of the shaper hierarchy
 * @id: Unique identifier inside the shaper tree.
 * @parent_id: ID of parent shaper, or SHAPER_NONE_ID if the shaper has
 *             no parent. Only the root shaper has no parent.
 * @metric: Specify if the bw limits refers to PPS or BPS
 * @bw_min: Minimum guaranteed rate for this shaper
 * @bw_max: Maximum peak bw allowed for this shaper
 * @burst: Maximum burst for the peek rate of this shaper
 * @priority: Scheduling priority for this shaper
 * @weight: Scheduling weight for this shaper
 *
 * The full shaper hierarchy is maintained only by the
 * NIC driver (or firmware), possibly in a NIC-specific format
 * and/or in H/W tables.
 * The kernel uses this representation and the shaper_ops to
 * access, traverse, and update it.
 */
struct shaper_info {
	/* The following fields allow the full traversal of the whole
	 * hierarchy.
	 */
	u32 id;
	u32 parent_id;

	/* The following fields define the behavior of the shaper. */
	enum shaper_metric metric;
	u64 bw_min;
	u64 bw_max;
	u32 burst;
	u32 priority;
	u32 weight;
};

/**
 * enum shaper_lookup_mode - Lookup method used to access a shaper
 * @SHAPER_LOOKUP_BY_PORT: The root shaper for the whole H/W, @id is unused
 * @SHAPER_LOOKUP_BY_NETDEV: The main shaper for the given network device,
 *                           @id is unused
 * @SHAPER_LOOKUP_BY_VF: @id is a virtual function number.
 * @SHAPER_LOOKUP_BY_QUEUE: @id is a queue identifier.
 * @SHAPER_LOOKUP_BY_TREE_ID: @id is the unique shaper identifier inside the
 *                            shaper hierarchy as in shaper_info.id
 *
 * SHAPER_LOOKUP_BY_PORT and SHAPER_LOOKUP_BY_VF, SHAPER_LOOKUP_BY_TREE_ID are
 * only available on PF devices, usually inside the host/hypervisor.
 * SHAPER_LOOKUP_BY_NETDEV is available on both PFs and VFs devices, but
 * only if the latter are privileged ones.
 * The same shaper can be reached with different lookup mode/id pairs,
 * mapping network visible objects (devices, VFs, queues) to the scheduler
 * hierarchy and vice-versa.
 */
enum shaper_lookup_mode {
    SHAPER_LOOKUP_BY_PORT,
    SHAPER_LOOKUP_BY_NETDEV,
    SHAPER_LOOKUP_BY_VF,
    SHAPER_LOOKUP_BY_QUEUE,
    SHAPER_LOOKUP_BY_TREE_ID,
};


/**
 * struct shaper_ops - Operations on shaper hierarchy
 * @get: Access the specified shaper.
 * @set: Modify the specifier shaper.
 * @move: Move the specifier shaper inside the hierarchy.
 * @add: Add a shaper inside the shaper hierarchy.
 * @delete: Delete the specified shaper .
 *
 * The netdevice exposes a pointer to these ops.
 *
 * It’s up to the driver or firmware to create the default shapers hierarchy,
 * according to the H/W capabilities.
 */
struct shaper_ops {
	/* get - Fetch the specified shaper, if it exists
	 * @dev: Netdevice to operate on.
	 * @lookup_mode: How to perform the shaper lookup
	 * @id: ID of the specified shaper,
	 *      relative to the specified @lookup_mode.
	 * @shaper: Object to return shaper.
	 * @extack: Netlink extended ACK for reporting errors.
	 *
	 * Multiple placement domain/id pairs can refer to the same shaper.
	 * And multiple entities (e.g. VF and PF) can try to access the same
	 * shaper concurrently.
	 *
	 * Values of @id depend on the @access_type:
	 * * If @access_type is SHAPER_LOOKUP_BY_PORT or
	 *   SHAPER_LOOKUP_BY_NETDEV, then @placement_id is unused.
	 * * If @access_type is SHAPER_LOOKUP_BY_VF,
	 *   then @id is a virtual function number, relative to @dev
	 *   which should be phisical function
	 * * If @access_type is SHAPER_LOOKUP_BY_QUEUE,
	 *   Then @id represents the queue number, relative to @dev
	 * * If @access_type is SHAPER_LOOKUP_BY_TREE_ID,
	 *   then @id is a @shaper_info.id and any shaper inside the
	 *   hierarcy can be accessed directly.
	 *
	 * Return:
	 * * %0 - Success
	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
	 *		    or core for any reason. @extack should be set
	 *		    to text describing the reason.
	 * * Other negative error value on failure.
	 */
	int (*get)(struct net_device *dev,
		   enum shaper_lookup_mode lookup_mode, u32 id,
                   struct shaper_info *shaper, struct netlink_ext_ack *extack);

	/* set - Update the specified shaper, if it exists
	 * @dev: Netdevice to operate on.
	 * @lookup_mode: How to perform the shaper lookup
	 * @id: ID of the specified shaper,
	 *      relative to the specified @access_type.
	 * @shaper: Configuration of shaper.
	 * @extack: Netlink extended ACK for reporting errors.
	 *
	 * Configure the parameters of @shaper according to values supplied
	 * in the following fields:
	 * * @shaper.metric
	 * * @shaper.bw_min
	 * * @shaper.bw_max
	 * * @shaper.burst
	 * * @shaper.priority
	 * * @shaper.weight
	 * Values supplied in other fields of @shaper must be zero and,
	 * other than verifying that, are ignored.
	 *
	 * Return:
	 * * %0 - Success
	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
	 *		    or core for any reason. @extack should be set
	 *		    to text describing the reason.
	 * * Other negative error values on failure.
	 */
	int (*set)(struct net_device *dev,
		   enum shaper_lookup_mode lookup_mode, u32 id,
		   const struct shaper_info *shaper,
		   struct netlink_ext_ack *extack);

	/* Move - change the parent id of the specified shaper
	 * @dev: netdevice to operate on.
	 * @lookup_mode: how to perform the shaper lookup
	 * @id: ID of the specified shaper,
	 *                      relative to the specified @access_mode.
	 * @new_parent_id: new ID of the parent shapers,
	 *                      always relative to the SHAPER_LOOKUP_BY_TREE_ID
	 *                      lookup mode
	 * @extack: Netlink extended ACK for reporting errors.
	 *
	 * Move the specified shaper in the hierarchy replacing its
	 * current parent shaper with @new_parent_id
	 *
	 * Return:
	 * * %0 - Success
	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
	 *		    or core for any reason. @extack should be set
	 *		    to text describing the reason.
	 * * Other negative error values on failure.
	 */
	int (*move)(struct net_device *dev,
		    enum shaper_lookup_mode lookup_mode, u32 id,
		    u32 new_parent_id, struct netlink_ext_ack *extack);

	/* add - Add a shaper inside the shaper hierarchy
	 * @dev: netdevice to operate on.
	 * @shaper: configuration of shaper.
	 * @extack: Netlink extended ACK for reporting errors.
	 *
	 * @shaper.id must be set to SHAPER_NONE_ID as
	 * the id for the shaper will be automatically allocated.
	 * @shaper.parent_id determines where inside the shaper's tree
	 * this node is inserted.
	 *
	 * Return:
	 * * non-negative shaper id on success
	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
	 *		    or core for any reason. @extack should be set
	 *		    to text describing the reason.
	 * * Other negative error values on failure.
	 *
	 * Examples or reasons this operation may fail include:
	 * * H/W resources limits.
	 * * The parent is a ‘leaf’ node - attached to a queue.
	 * * Can’t respect the requested bw limits.
	 */
	int (*add)(struct net_device *dev, const struct shaper_info *shaper,
		   struct netlink_ext_ack *extack);

	/* delete - Add a shaper inside the shaper hierarchy
	 * @dev: netdevice to operate on.
	 * @lookup_mode: how to perform the shaper lookup
	 * @id: ID of the specified shaper,
	 *                      relative to the specified @access_type.
	 * @shaper: Object to return the deleted shaper configuration.
	 *              Ignored if NULL.
	 * @extack: Netlink extended ACK for reporting errors.
	 *
	 * Return:
	 * * %0 - Success
	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
	 *		    or core for any reason. @extack should be set
	 *		    to text describing the reason.
	 * * Other negative error values on failure.
	 */
	int (*delete)(struct net_device *dev,
		      enum shaper_lookup_mode lookup_mode,
		      u32 id, struct shaper_info *shaper,
		      struct netlink_ext_ack *extack);
};

/*
 * Examples:
 * - set shaping on a given queue
 *   struct shaper_info info = { // fill this };
 *   dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, NULL);
 *
 * - create a queue group with a queue group shaping limits.
 *   Assuming the following topology already exists:
 *                    < netdev shaper >
 *                      /           \
 *         <queue 0 shaper> . . .  <queue N shaper>
 *
 *   struct shaper_info pinfo, ginfo;
 *   dev->shaper_ops->get(dev, SHAPER_LOOKUP_BY_NETDEV, 0, &pinfo);
 *
 *   ginfo.parent_id = pinfo.id;
 *   // fill-in other shaper params...
 *   new_node_id = dev->shaper_ops->add(dev, &ginfo);
 *
 *   // now topology is:
 *   //                  <    netdev shaper    >
 *   //                  /            |        \
 *   //                 /             |        <newly created shaper>
 *   //                /              |
 *   // <queue 0 shaper> . . . <queue N shaper>
 *
 *   // move a shapers for queues 3..n out of such queue group
 *   for (i = 0; i <= 2; ++i)
 *           dev->shaper_ops->move(dev, SHAPER_LOOKUP_BY_QUEUE, i, new_node_id);
 *
 *   // now topology is:
 *   //                   < netdev shaper >
 *   //                   /              \
 *   //        <newly created shaper>   <queue 3 shaper> ... <queue n shaper>
 *   //         /                   \
 *   // <queue 0 shaper> ... <queue 2 shaper>
 */
#endif


