Return-Path: <netdev+bounces-87221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBDE8A229E
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 01:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DBC1F2327D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46B4AED1;
	Thu, 11 Apr 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcAumvKT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DB487BE
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879511; cv=none; b=l1/ey12hQ7jOKlLXTLPKYt2rI2Ab763kIdi1GpSUQI5xQFSDlftaYR4HT/TZDC0irL8Dtl+TOTa/cynEa8YoRZthr3vqfxNbvMlfDMuE/CQWgJFSuPzzcIalcT8U+t/UBEdUyhyTYFRU2AHbt9mG+rAtB3+HVP1XaO49zX/1GAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879511; c=relaxed/simple;
	bh=kElu9bJKH5GeZaRtSgjAzA2mHOEMvBifzw42DjLyAFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BnqA9ObwhUAVtsynCh8rLAO1qoY+DGl9AToLkzdYDGlQSK3BdGC5BEGFONlffk6fph0ZMjQ2jOlHMPgNJr3IVkT2kXhMutmERyOkkBE25ak2vziT4mrS+uOhm8yupAK09KElhUkP/JoJgnaGv/RUFPb9RuKEAFLqK3Q2/Kyb+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcAumvKT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712879510; x=1744415510;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=kElu9bJKH5GeZaRtSgjAzA2mHOEMvBifzw42DjLyAFY=;
  b=FcAumvKT2Grqj4YzigVZqi2fOpfoNgc489vNUOupP/o0Ewln9JVxKmg4
   /KKb0cgamT+H707NNQk0E/paU87nC3zmJ40tpqrOdyOd8Egq4QXmpAid3
   ZdyUQM4DLKTS88eRX9eCFW9iVgxhLlOQOcZC6q74+Vc9coxKPRoA8ms+7
   kBlYbkz1tUwnDbfWmSaL90YsMWaSCAaPeZeeIB04ic5ZaC590iUIXeN/8
   0/Gl7G3/BTae/Gkd1o1Ii0BPBcF0XBE0TDxKjmiDLaVrbZitL+bifBBF0
   Gr1U56NkSzMmnSyzxB/2Ho7bGeT0YVgDo6VWwc7yYWwWbiOhK9GeLug7l
   g==;
X-CSE-ConnectionGUID: WBFtb8pLSz2PCn4mqQO/oQ==
X-CSE-MsgGUID: xKuqnk1sQUGJwbjek7Mx4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19474731"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="19474731"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:51:49 -0700
X-CSE-ConnectionGUID: S0NO4/1URI+u1q9uSlD9Xw==
X-CSE-MsgGUID: 4eHKlmeBR5ab1NE/aJDAnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25847163"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.241.228.254])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:51:47 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Madhu
 Chittim <madhu.chittim@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
In-Reply-To: <20240405102313.GA310894@kernel.org>
References: <20240405102313.GA310894@kernel.org>
Date: Thu, 11 Apr 2024 16:51:45 -0700
Message-ID: <87a5lzihke.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Simon Horman <horms@kernel.org> writes:

> Hi,
>
> This is follow-up to the ongoing discussion started by Intel to extend the
> support for TX shaping H/W offload [1].
>
> The goal is allowing the user-space to configure TX shaping offload on a
> per-queue basis with min guaranteed B/W, max B/W limit and burst size on a
> VF device.
>

What about non-VF cases? Would it be out of scope?

>
> In the past few months several different solutions were attempted and
> discussed, without finding a perfect fit:
>
> - devlink_rate APIs are not appropriate for to control TX shaping on netd=
evs
> - No existing TC qdisc offload covers the required feature set
> - HTB does not allow direct queue configuration
> - MQPRIO imposes constraint on the maximum number of TX queues
> - TBF does not support max B/W limit
> - ndo_set_tx_maxrate() only controls the max B/W limit
>

Another questions: is how "to plug" different shaper algorithms? for
example, the TSN world defines the Credit Based Shaper (IEEE 802.1Q-2018
Annex L gives a good overview), which tries to be accurate over sub
milisecond intervals.

(sooner or later, some NIC with lots of queues will appear with TSN
features, and I guess some people would like to know that they are using
the expected shaper)

> A new H/W offload API is needed, but offload API proliferation should be
> avoided.
>
> The following proposal intends to cover the above specified requirement a=
nd
> provide a possible base to unify all the shaping offload APIs mentioned a=
bove.
>
> The following only defines the in-kernel interface between the core and
> drivers. The intention is to expose the feature to user-space via Netlink.
> Hopefully the latter part should be straight-forward after agreement
> on the in-kernel interface.
>

Another thing that MQPRIO (indirectly) gives is the ability to userspace
applications to have some amount of control in which queue their packets
will end up, via skb->priority.

Would this new shaper hierarchy have something that would fill this
role? (if this is for VF-only use cases, then the answer would be "no" I
guess)

(I tried to read the whole thread, sorry if I missed something)

> All feedback and comment is more then welcome!
>
> [1] https://lore.kernel.org/netdev/20230808015734.1060525-1-wenjun1.wu@in=
tel.com/
>
> Regards,
> Simon with much assistance from Paolo
>
> ---=20
> /* SPDX-License-Identifier: GPL-2.0-or-later */
>
> #ifndef _NET_SHAPER_H_
> #define _NET_SHAPER_H_
>
> /**
>  * enum shaper_metric - the metric of the shaper
>  * @SHAPER_METRIC_PPS: Shaper operates on a packets per second basis
>  * @SHAPER_METRIC_BPS: Shaper operates on a bits per second basis
>  */
> enum shaper_metric {
> 	SHAPER_METRIC_PPS;
> 	SHAPER_METRIC_BPS;
> };
>
> #define SHAPER_ROOT_ID 0
> #define SHAPER_NONE_ID UINT_MAX
>
> /**
>  * struct shaper_info - represent a node of the shaper hierarchy
>  * @id: Unique identifier inside the shaper tree.
>  * @parent_id: ID of parent shaper, or SHAPER_NONE_ID if the shaper has
>  *             no parent. Only the root shaper has no parent.
>  * @metric: Specify if the bw limits refers to PPS or BPS
>  * @bw_min: Minimum guaranteed rate for this shaper
>  * @bw_max: Maximum peak bw allowed for this shaper
>  * @burst: Maximum burst for the peek rate of this shaper
>  * @priority: Scheduling priority for this shaper
>  * @weight: Scheduling weight for this shaper
>  *
>  * The full shaper hierarchy is maintained only by the
>  * NIC driver (or firmware), possibly in a NIC-specific format
>  * and/or in H/W tables.
>  * The kernel uses this representation and the shaper_ops to
>  * access, traverse, and update it.
>  */
> struct shaper_info {
> 	/* The following fields allow the full traversal of the whole
> 	 * hierarchy.
> 	 */
> 	u32 id;
> 	u32 parent_id;
>
> 	/* The following fields define the behavior of the shaper. */
> 	enum shaper_metric metric;
> 	u64 bw_min;
> 	u64 bw_max;
> 	u32 burst;
> 	u32 priority;
> 	u32 weight;
> };
>
> /**
>  * enum shaper_lookup_mode - Lookup method used to access a shaper
>  * @SHAPER_LOOKUP_BY_PORT: The root shaper for the whole H/W, @id is unus=
ed
>  * @SHAPER_LOOKUP_BY_NETDEV: The main shaper for the given network device,
>  *                           @id is unused
>  * @SHAPER_LOOKUP_BY_VF: @id is a virtual function number.
>  * @SHAPER_LOOKUP_BY_QUEUE: @id is a queue identifier.
>  * @SHAPER_LOOKUP_BY_TREE_ID: @id is the unique shaper identifier inside =
the
>  *                            shaper hierarchy as in shaper_info.id
>  *
>  * SHAPER_LOOKUP_BY_PORT and SHAPER_LOOKUP_BY_VF, SHAPER_LOOKUP_BY_TREE_I=
D are
>  * only available on PF devices, usually inside the host/hypervisor.
>  * SHAPER_LOOKUP_BY_NETDEV is available on both PFs and VFs devices, but
>  * only if the latter are privileged ones.
>  * The same shaper can be reached with different lookup mode/id pairs,
>  * mapping network visible objects (devices, VFs, queues) to the scheduler
>  * hierarchy and vice-versa.
>  */
> enum shaper_lookup_mode {
>     SHAPER_LOOKUP_BY_PORT,
>     SHAPER_LOOKUP_BY_NETDEV,
>     SHAPER_LOOKUP_BY_VF,
>     SHAPER_LOOKUP_BY_QUEUE,
>     SHAPER_LOOKUP_BY_TREE_ID,
> };
>
>
> /**
>  * struct shaper_ops - Operations on shaper hierarchy
>  * @get: Access the specified shaper.
>  * @set: Modify the specifier shaper.
>  * @move: Move the specifier shaper inside the hierarchy.
>  * @add: Add a shaper inside the shaper hierarchy.
>  * @delete: Delete the specified shaper .
>  *
>  * The netdevice exposes a pointer to these ops.
>  *
>  * It=E2=80=99s up to the driver or firmware to create the default shaper=
s hierarchy,
>  * according to the H/W capabilities.
>  */
> struct shaper_ops {
> 	/* get - Fetch the specified shaper, if it exists
> 	 * @dev: Netdevice to operate on.
> 	 * @lookup_mode: How to perform the shaper lookup
> 	 * @id: ID of the specified shaper,
> 	 *      relative to the specified @lookup_mode.
> 	 * @shaper: Object to return shaper.
> 	 * @extack: Netlink extended ACK for reporting errors.
> 	 *
> 	 * Multiple placement domain/id pairs can refer to the same shaper.
> 	 * And multiple entities (e.g. VF and PF) can try to access the same
> 	 * shaper concurrently.
> 	 *
> 	 * Values of @id depend on the @access_type:
> 	 * * If @access_type is SHAPER_LOOKUP_BY_PORT or
> 	 *   SHAPER_LOOKUP_BY_NETDEV, then @placement_id is unused.
> 	 * * If @access_type is SHAPER_LOOKUP_BY_VF,
> 	 *   then @id is a virtual function number, relative to @dev
> 	 *   which should be phisical function
> 	 * * If @access_type is SHAPER_LOOKUP_BY_QUEUE,
> 	 *   Then @id represents the queue number, relative to @dev
> 	 * * If @access_type is SHAPER_LOOKUP_BY_TREE_ID,
> 	 *   then @id is a @shaper_info.id and any shaper inside the
> 	 *   hierarcy can be accessed directly.
> 	 *
> 	 * Return:
> 	 * * %0 - Success
> 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> 	 *		    or core for any reason. @extack should be set
> 	 *		    to text describing the reason.
> 	 * * Other negative error value on failure.
> 	 */
> 	int (*get)(struct net_device *dev,
> 		   enum shaper_lookup_mode lookup_mode, u32 id,
>                    struct shaper_info *shaper, struct netlink_ext_ack *ex=
tack);
>
> 	/* set - Update the specified shaper, if it exists
> 	 * @dev: Netdevice to operate on.
> 	 * @lookup_mode: How to perform the shaper lookup
> 	 * @id: ID of the specified shaper,
> 	 *      relative to the specified @access_type.
> 	 * @shaper: Configuration of shaper.
> 	 * @extack: Netlink extended ACK for reporting errors.
> 	 *
> 	 * Configure the parameters of @shaper according to values supplied
> 	 * in the following fields:
> 	 * * @shaper.metric
> 	 * * @shaper.bw_min
> 	 * * @shaper.bw_max
> 	 * * @shaper.burst
> 	 * * @shaper.priority
> 	 * * @shaper.weight
> 	 * Values supplied in other fields of @shaper must be zero and,
> 	 * other than verifying that, are ignored.
> 	 *
> 	 * Return:
> 	 * * %0 - Success
> 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> 	 *		    or core for any reason. @extack should be set
> 	 *		    to text describing the reason.
> 	 * * Other negative error values on failure.
> 	 */
> 	int (*set)(struct net_device *dev,
> 		   enum shaper_lookup_mode lookup_mode, u32 id,
> 		   const struct shaper_info *shaper,
> 		   struct netlink_ext_ack *extack);
>
> 	/* Move - change the parent id of the specified shaper
> 	 * @dev: netdevice to operate on.
> 	 * @lookup_mode: how to perform the shaper lookup
> 	 * @id: ID of the specified shaper,
> 	 *                      relative to the specified @access_mode.
> 	 * @new_parent_id: new ID of the parent shapers,
> 	 *                      always relative to the SHAPER_LOOKUP_BY_TREE_ID
> 	 *                      lookup mode
> 	 * @extack: Netlink extended ACK for reporting errors.
> 	 *
> 	 * Move the specified shaper in the hierarchy replacing its
> 	 * current parent shaper with @new_parent_id
> 	 *
> 	 * Return:
> 	 * * %0 - Success
> 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> 	 *		    or core for any reason. @extack should be set
> 	 *		    to text describing the reason.
> 	 * * Other negative error values on failure.
> 	 */
> 	int (*move)(struct net_device *dev,
> 		    enum shaper_lookup_mode lookup_mode, u32 id,
> 		    u32 new_parent_id, struct netlink_ext_ack *extack);
>
> 	/* add - Add a shaper inside the shaper hierarchy
> 	 * @dev: netdevice to operate on.
> 	 * @shaper: configuration of shaper.
> 	 * @extack: Netlink extended ACK for reporting errors.
> 	 *
> 	 * @shaper.id must be set to SHAPER_NONE_ID as
> 	 * the id for the shaper will be automatically allocated.
> 	 * @shaper.parent_id determines where inside the shaper's tree
> 	 * this node is inserted.
> 	 *
> 	 * Return:
> 	 * * non-negative shaper id on success
> 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> 	 *		    or core for any reason. @extack should be set
> 	 *		    to text describing the reason.
> 	 * * Other negative error values on failure.
> 	 *
> 	 * Examples or reasons this operation may fail include:
> 	 * * H/W resources limits.
> 	 * * The parent is a =E2=80=98leaf=E2=80=99 node - attached to a queue.
> 	 * * Can=E2=80=99t respect the requested bw limits.
> 	 */
> 	int (*add)(struct net_device *dev, const struct shaper_info *shaper,
> 		   struct netlink_ext_ack *extack);
>
> 	/* delete - Add a shaper inside the shaper hierarchy
> 	 * @dev: netdevice to operate on.
> 	 * @lookup_mode: how to perform the shaper lookup
> 	 * @id: ID of the specified shaper,
> 	 *                      relative to the specified @access_type.
> 	 * @shaper: Object to return the deleted shaper configuration.
> 	 *              Ignored if NULL.
> 	 * @extack: Netlink extended ACK for reporting errors.
> 	 *
> 	 * Return:
> 	 * * %0 - Success
> 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> 	 *		    or core for any reason. @extack should be set
> 	 *		    to text describing the reason.
> 	 * * Other negative error values on failure.
> 	 */
> 	int (*delete)(struct net_device *dev,
> 		      enum shaper_lookup_mode lookup_mode,
> 		      u32 id, struct shaper_info *shaper,
> 		      struct netlink_ext_ack *extack);
> };
>
> /*
>  * Examples:
>  * - set shaping on a given queue
>  *   struct shaper_info info =3D { // fill this };
>  *   dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info, N=
ULL);
>  *
>  * - create a queue group with a queue group shaping limits.
>  *   Assuming the following topology already exists:
>  *                    < netdev shaper >
>  *                      /           \
>  *         <queue 0 shaper> . . .  <queue N shaper>
>  *
>  *   struct shaper_info pinfo, ginfo;
>  *   dev->shaper_ops->get(dev, SHAPER_LOOKUP_BY_NETDEV, 0, &pinfo);
>  *
>  *   ginfo.parent_id =3D pinfo.id;
>  *   // fill-in other shaper params...
>  *   new_node_id =3D dev->shaper_ops->add(dev, &ginfo);
>  *
>  *   // now topology is:
>  *   //                  <    netdev shaper    >
>  *   //                  /            |        \
>  *   //                 /             |        <newly created shaper>
>  *   //                /              |
>  *   // <queue 0 shaper> . . . <queue N shaper>
>  *
>  *   // move a shapers for queues 3..n out of such queue group
>  *   for (i =3D 0; i <=3D 2; ++i)
>  *           dev->shaper_ops->move(dev, SHAPER_LOOKUP_BY_QUEUE, i, new_no=
de_id);
>  *
>  *   // now topology is:
>  *   //                   < netdev shaper >
>  *   //                   /              \
>  *   //        <newly created shaper>   <queue 3 shaper> ... <queue n sha=
per>
>  *   //         /                   \
>  *   // <queue 0 shaper> ... <queue 2 shaper>
>  */
> #endif
>
>

--=20
Vinicius

