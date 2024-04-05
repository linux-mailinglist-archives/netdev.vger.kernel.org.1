Return-Path: <netdev+bounces-85272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E8899FD9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2DA282EE0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516016F0F3;
	Fri,  5 Apr 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWo84RTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30116C85B
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327666; cv=none; b=AmgimD4jZi6ZvrNNA7de/J2PhbiOkx6Nc+4rpDMVU1UuemaVUkivmszMIJqr9VFxNZwjQAv/m0WyY74koUAu5mYRwhP9+r6mm4Uvaq9yISzzCyfD1cOWYpgz66IlFAFpdgdvPRxwdMcMebeCUrASwsT9jVwHIH2I82W9OVARDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327666; c=relaxed/simple;
	bh=z+w0nQTaE/2l3WqzTuDWQax5ZvwssENZCHmek2d4v5w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NKF1S7ioM2t4x3Hl+eyVnvfoI3MZ9y0fBuFOG1WZJMtEhBcJh3d4RdZT1NJH1m9U/G+V9Xrkzx4mNjc1ZhwTTDOqF2tPrQSW2yyc43oc4lzAXv0RAw5a9HbZtNYzyLioSWqUSX2CWP77W9ctITqNmFnsdqMwddsfDj5oGt2j6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWo84RTZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecff9df447so779422b3a.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327664; x=1712932464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N24jYv+96/Zl7ZxQFv6JKuyYKvKKez8uwe6BdhO1ijQ=;
        b=YWo84RTZBWLy14bG1mr47IF03FTu8BVMr6hSN+DqYqvVcL5OEKYe5yB4p6USPezNPb
         BfU6leyktJbU7UxHWSiM5iTAxs6OvNQ0pmMXZk2fSemxwyeOb/qwh1tvAUkkTXuzCSWI
         P+W6t4Y/cZB/7Dy7WOlwDFkGDXBu4YDpHEM4doHaO+NUWcXUv8whSleAI8qkMvLaourR
         aZ6h/Gm4CTEt1se8gDOqm684O/ne65oZrXjKA3zu9DuWosWI/1ilhZfdSvrIoB3lpUNr
         dF+MX9yWa4Dy+BY12gX5ns+FFaws0kIzjKrtwPe6vDXe+fl5/HMnTipnMCZI1UfVCyM7
         svew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327664; x=1712932464;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N24jYv+96/Zl7ZxQFv6JKuyYKvKKez8uwe6BdhO1ijQ=;
        b=oZ3FIgTkEt/3+UJ6mwX0miP4PAOvl5kPc+LrsSBE9Rw2CildVgCHBXp4LaGWk6/oxy
         7vUKUcA3YaVnOcTgTzt4W4HJJvWTxJ6bjgeWoRJ2opDK1Mdivvaf30prxMSPMo6sUuEg
         KQusbXxS28grr4LVqAX1qx4Pa6Ye1Jak9o2WEBCJpaS1gExbW8vbgJrcVOONLo2HZzxA
         nGGyLGJiPRjcoq6lZdPNWruZljd2AAlI/YckakqexfFa/OuGnN40rk9l3EAJou1pDnQB
         o6DnVpXYZFDNPvot0VuaXK2innS75H/uDm3mDOVmdmlbT6/rIXO67tkGha4Z0p3tSLp3
         4MtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr5Zs6fN4IICCyXyltktpfgI0Pw2m48oHYalyF/+sVRV3znVb/QfsX+W7AunJn+lHRxdklXH4jz/d/AvY7lMTO6+PR5gSS
X-Gm-Message-State: AOJu0Ywh3cb5ImDEBrL1KsMUbi325sKfPKNPXCxgj1huBoBkFDZWOppY
	L49FsPiHYPb5J273ihgmJC5u+Y9z284+Z85dTMIdyMhDy9PYw9q5
X-Google-Smtp-Source: AGHT+IFjGUcHielIuLsN0zZWm8qiEY/qRrYnOVDmJHrmIWBlpdGaYo9RW5zGFvgmknDqn+5gzcpBmw==
X-Received: by 2002:a05:6a00:1784:b0:6ea:c475:4a98 with SMTP id s4-20020a056a00178400b006eac4754a98mr2103213pfg.20.1712327663810;
        Fri, 05 Apr 2024 07:34:23 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7990e000000b006e664031f10sm1558320pff.51.2024.04.05.07.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:34:23 -0700 (PDT)
Date: Fri, 05 Apr 2024 07:34:22 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <66100bee9f979_55e88208fd@john.notmuch>
In-Reply-To: <20240405102313.GA310894@kernel.org>
References: <20240405102313.GA310894@kernel.org>
Subject: RE: [RFC] HW TX Rate Limiting Driver API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simon Horman wrote:
> Hi,
> =

> This is follow-up to the ongoing discussion started by Intel to extend =
the
> support for TX shaping H/W offload [1].
> =

> The goal is allowing the user-space to configure TX shaping offload on =
a
> per-queue basis with min guaranteed B/W, max B/W limit and burst size o=
n a
> VF device.
> =

> =

> In the past few months several different solutions were attempted and
> discussed, without finding a perfect fit:
> =

> - devlink_rate APIs are not appropriate for to control TX shaping on ne=
tdevs
> - No existing TC qdisc offload covers the required feature set
> - HTB does not allow direct queue configuration
> - MQPRIO imposes constraint on the maximum number of TX queues

iirc the TX queue limitation was somewhat artifical. Probably we could
extend it.

> - TBF does not support max B/W limit
> - ndo_set_tx_maxrate() only controls the max B/W limit
> =

> A new H/W offload API is needed, but offload API proliferation should b=
e
> avoided.

Did you consider the dcbnl_rtnl_ops? These have the advantage of being
implemented in intel, mlx, amd, broadcom and a few more drivers. There
is an IEEE spec as well fwiw.

This has a getmaxrate, setmaxrate API. Adding a getminrate and setminrate=

would be relatively straightforward. The spec defines how to do WRR and
NICs support it.

The main limitation is spec only defined 8 TCs so interface followed
spec. But I think we could make this as large as needed to map TCs
1:1 to queues if you want. By the way someone probably already thought
of it, but having queue sets rate limited proved very useful in the
past. For example having a 40Gbps limit on a 100Gbps NIC likely needs
multiple queues (a TC in DCB language).

Just an idea I don't have the full context, but looks like an easy fit
to me. Assuming the mqprio mapping can be easily extended.

> =

> The following proposal intends to cover the above specified requirement=
 and
> provide a possible base to unify all the shaping offload APIs mentioned=
 above.
> =

> The following only defines the in-kernel interface between the core and=

> drivers. The intention is to expose the feature to user-space via Netli=
nk.
> Hopefully the latter part should be straight-forward after agreement
> on the in-kernel interface.
> =

> All feedback and comment is more then welcome!
> =

> [1] https://lore.kernel.org/netdev/20230808015734.1060525-1-wenjun1.wu@=
intel.com/
> =

> Regards,
> Simon with much assistance from Paolo

Cool to see some hw offloads.

> =

> --- =

> /* SPDX-License-Identifier: GPL-2.0-or-later */
> =

> #ifndef _NET_SHAPER_H_
> #define _NET_SHAPER_H_
> =

> /**
>  * enum shaper_metric - the metric of the shaper
>  * @SHAPER_METRIC_PPS: Shaper operates on a packets per second basis
>  * @SHAPER_METRIC_BPS: Shaper operates on a bits per second basis
>  */
> enum shaper_metric {
> 	SHAPER_METRIC_PPS;
> 	SHAPER_METRIC_BPS;
> };

Interesting hw has a PPS limiter?

> =

> #define SHAPER_ROOT_ID 0
> #define SHAPER_NONE_ID UINT_MAX
> =

> /**
>  * struct shaper_info - represent a node of the shaper hierarchy
>  * @id: Unique identifier inside the shaper tree.
>  * @parent_id: ID of parent shaper, or SHAPER_NONE_ID if the shaper has=

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

Is the hw actually implementing hierarchy? For some reason I
imagined different scopes, PF, VF, QueueSet, Queue. And if it
has more hierarchy maybe FW is just translating this? IF that
is the case perhaps instead of hierarchy we expose a

  enum hw_rate_limit_scope scope

and

  enum hw_rate_limit_scope {
     SHAPER_LOOKUP_BY_PORT,
     SHAPER_LOOKUP_BY_NETDEV,
     SHAPER_LOOKUP_BY_VF,
     SHAPER_LOOKUP_BY_QUEUE_SET,
     SHAPER_LOOKUP_BY_QUEUE,
  }

My preference is almost always to push logic out of firmware
and into OS if possible.

>  * The kernel uses this representation and the shaper_ops to
>  * access, traverse, and update it.
>  */
> struct shaper_info {
> 	/* The following fields allow the full traversal of the whole
> 	 * hierarchy.
> 	 */
> 	u32 id;
> 	u32 parent_id;
> =

> 	/* The following fields define the behavior of the shaper. */
> 	enum shaper_metric metric;
> 	u64 bw_min;
> 	u64 bw_max;
> 	u32 burst;

Any details on how burst is implemented in HW?

> 	u32 priority;

What is priority?

> 	u32 weight;

Weight to me is a reference to a WRR algorithm? Is there some other
notion here?

> };
> =

> /**
>  * enum shaper_lookup_mode - Lookup method used to access a shaper
>  * @SHAPER_LOOKUP_BY_PORT: The root shaper for the whole H/W, @id is un=
used
>  * @SHAPER_LOOKUP_BY_NETDEV: The main shaper for the given network devi=
ce,
>  *                           @id is unused
>  * @SHAPER_LOOKUP_BY_VF: @id is a virtual function number.
>  * @SHAPER_LOOKUP_BY_QUEUE: @id is a queue identifier.
>  * @SHAPER_LOOKUP_BY_TREE_ID: @id is the unique shaper identifier insid=
e the
>  *                            shaper hierarchy as in shaper_info.id
>  *
>  * SHAPER_LOOKUP_BY_PORT and SHAPER_LOOKUP_BY_VF, SHAPER_LOOKUP_BY_TREE=
_ID are
>  * only available on PF devices, usually inside the host/hypervisor.
>  * SHAPER_LOOKUP_BY_NETDEV is available on both PFs and VFs devices, bu=
t
>  * only if the latter are privileged ones.
>  * The same shaper can be reached with different lookup mode/id pairs,
>  * mapping network visible objects (devices, VFs, queues) to the schedu=
ler
>  * hierarchy and vice-versa.
>  */
> enum shaper_lookup_mode {
>     SHAPER_LOOKUP_BY_PORT,
>     SHAPER_LOOKUP_BY_NETDEV,
>     SHAPER_LOOKUP_BY_VF,
>     SHAPER_LOOKUP_BY_QUEUE,
>     SHAPER_LOOKUP_BY_TREE_ID,
> };
> =

> =

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
>  * It=E2=80=99s up to the driver or firmware to create the default shap=
ers hierarchy,
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
>                    struct shaper_info *shaper, struct netlink_ext_ack *=
extack);
> =

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
> =

> 	/* Move - change the parent id of the specified shaper
> 	 * @dev: netdevice to operate on.
> 	 * @lookup_mode: how to perform the shaper lookup
> 	 * @id: ID of the specified shaper,
> 	 *                      relative to the specified @access_mode.
> 	 * @new_parent_id: new ID of the parent shapers,
> 	 *                      always relative to the SHAPER_LOOKUP_BY_TREE_I=
D
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

Some heavy firmware or onchip CPU managing this move operation? Is this
a reset operation as well? Is there a need for an atomic move like this
in initial API? Maybe start with just set and push down an entire config
in one hit. If hw can really move things around dynamically I think it
would make sense though.

> 	int (*move)(struct net_device *dev,
> 		    enum shaper_lookup_mode lookup_mode, u32 id,
> 		    u32 new_parent_id, struct netlink_ext_ack *extack);
> =

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
> 	 * * The parent is a =E2=80=98leaf=E2=80=99 node - attached to a queue=
.
> 	 * * Can=E2=80=99t respect the requested bw limits.
> 	 */
> 	int (*add)(struct net_device *dev, const struct shaper_info *shaper,
> 		   struct netlink_ext_ack *extack);
> =

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

One thought I have about exposing hierarchy like this is user will need =

to have nic user manual in hand to navigate hardware limitation I presume=
.
If hw is this flexible than lets do something. But, this is why I started=

to think more about scopes (nic, pf, vf, queueSet, queue) than arbitrary
hierarchy. Perhaps this is going to target some DPU though with lots of
flexibility here.

> };
> =

> /*
>  * Examples:
>  * - set shaping on a given queue
>  *   struct shaper_info info =3D { // fill this };
>  *   dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info,=
 NULL);
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

I think we need a queue set shaper as part of this for larger bw limits.

>  *
>  *   // move a shapers for queues 3..n out of such queue group
>  *   for (i =3D 0; i <=3D 2; ++i)
>  *           dev->shaper_ops->move(dev, SHAPER_LOOKUP_BY_QUEUE, i, new_=
node_id);
>  *
>  *   // now topology is:
>  *   //                   < netdev shaper >
>  *   //                   /              \
>  *   //        <newly created shaper>   <queue 3 shaper> ... <queue n s=
haper>
>  *   //         /                   \
>  *   // <queue 0 shaper> ... <queue 2 shaper>
>  */
> #endif
> =

> =


Thanks,
John=

