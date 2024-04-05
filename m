Return-Path: <netdev+bounces-85248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3C899E5C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BC81C21F35
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337616D4C5;
	Fri,  5 Apr 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OXEeRuNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EC16D4F9
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324046; cv=none; b=tRghR+mwk+02NUDEfmyx++Wh5A7Ptqf2DSh20yvhQOfeOSmCZBVuXDv//SY0LryBb1BLnKw8MZRdYhDH5cf6q5VjJNPeFSe6OVAcow3E9Cq799lGC6ykUJFt7qZ/2eroFDhBu7WhXtsb8sQvN8pD38fJVhxeUUM+ekT1/tRg744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324046; c=relaxed/simple;
	bh=2xiZS+lzeptBHXal4Pm6xzjZ3cF+eVVZTG7JYi5B80s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9mOBZo37Q05qJbii7IGklIM+xFsvYzg1lTLBaf5SKobTtV+PLueSwUKtj5BrX1NdURyAxfNUBsVTHG99CeDDKHwoPNB9FfB3BdUwIULUTPnds0ZAI49GmaI5d1JTY7tK39a4OQlbc23L69gZ8Pp8ms95iQeOBIYX5VXq6sIWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OXEeRuNX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6154a1812ffso22693277b3.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712324042; x=1712928842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HGMasy7CW4eu+5mzobBtNWNp/FJJI+kNtNpgApZ92U=;
        b=OXEeRuNXTEVoPEMFPt6DM5koBzAsm1Sltkoj5ophPmkGDNfUcE+NtugL685EEts/I3
         kojAsPMK+MIIAOkKjGtlfqeNbtDf7XkPOpAgMziWL+/4o7iMTmCa1GMZdgyvkP0/UPT+
         dw29wfPDXhn3p5OjKSVmDTJTagcRVUQF1V7cllpDjwJKPJwaV8hiwo3Fsli4XhQO4mDj
         LBWOmEMa6F2Nt7gNpYMkT6Y4kXojzI48cz4+ABV9aMeHE1gTXxTXEFpe1SQhJt3WdesL
         knYu52RhBe+rcYlg3qgcS4a6xCUqkdkceBapG9FYsWZGUQOGs/UcjJ8LLiWH6q6lYtmn
         pFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712324042; x=1712928842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HGMasy7CW4eu+5mzobBtNWNp/FJJI+kNtNpgApZ92U=;
        b=A4vPfq4Wl0BvrEIVzAph1g5W2wMwJ1Ou9KsO9XOxulSY0hWRQyhMRdjc1aaF7N8irv
         LKdAQYoItqjSCwFlTWBp03UdIRTUOOkC0wmggejcdUDIlGpyS4pLZoe1L+/YFhjLj0kb
         pwslUi8y01fK829fwTI2T+uFfRGlVEb6U9TQmJEQGJL16EWBxmxPNRAz2wCiq/KECyDk
         yBzVdwi0LzHPHLdrvHvbo+5uMqI6PwXrrfBAskiqqfD7FX+rQqPoUq98fJUnmd4E37Hi
         O58h3inBm5+SjCT6KV14tQzQsLGEsrN24oOybpUKpLvEJKRdl5CTsIkktVCvYmbfKHAU
         jOxg==
X-Gm-Message-State: AOJu0YyuhpcxaZ0AR7ZP3LTQWkBM8HlQnmTWXRdZ7vYGQXV4O+Wg4xT7
	aRiHYX1fMZEh79tcUGcsbFUG6R3QcZGNqKt55IJroxmRpS1K+JSdS6Ii/vs/00Ia86xRgCMifjt
	EE8NGBKsWi/ejBdPtUOj4vkUL8RqqenmroRK8
X-Google-Smtp-Source: AGHT+IG1StBUzeCyb8Fy28cnXLPHFxkDwwVobdAIRNoAN4H//7y5n0CxVQoHoUgLQoIRXoGGdBY/t3RfeeH3Zo286lQ=
X-Received: by 2002:a25:ac16:0:b0:dcd:5187:a032 with SMTP id
 w22-20020a25ac16000000b00dcd5187a032mr1347218ybi.43.1712324041683; Fri, 05
 Apr 2024 06:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102313.GA310894@kernel.org>
In-Reply-To: <20240405102313.GA310894@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 5 Apr 2024 09:33:50 -0400
Message-ID: <CAM0EoMnEWbLJXNChpDrnKSsu6gXjaPwCX9jRqKv0UagPUuo1tA@mail.gmail.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Madhu Chittim <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:25=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> Hi,
>
> This is follow-up to the ongoing discussion started by Intel to extend th=
e
> support for TX shaping H/W offload [1].
>
> The goal is allowing the user-space to configure TX shaping offload on a
> per-queue basis with min guaranteed B/W, max B/W limit and burst size on =
a
> VF device.
>
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
> A new H/W offload API is needed, but offload API proliferation should be
> avoided.
>
> The following proposal intends to cover the above specified requirement a=
nd
> provide a possible base to unify all the shaping offload APIs mentioned a=
bove.
>
> The following only defines the in-kernel interface between the core and
> drivers. The intention is to expose the feature to user-space via Netlink=
.
> Hopefully the latter part should be straight-forward after agreement
> on the in-kernel interface.
>
> All feedback and comment is more then welcome!
>
> [1] https://lore.kernel.org/netdev/20230808015734.1060525-1-wenjun1.wu@in=
tel.com/
>

My 2 cents:
I did peruse the lore quoted thread but i am likely to have missed somethin=
g.
It sounds like the requirement is for egress-from-host (which to a
device internal looks like ingress-from-host on the device). Doesn't
existing HTB offload already support this? I didnt see this being
discussed in the thread. Also, IIUC, there is no hierarchy
requirement. That is something you can teach HTB but there's probably
something i missed because i didnt understand the context of "HTB does
not allow direct queue configuration". If HTB is confusing from a
config pov then it seems what Paolo was describing in the thread on
TBF is a reasonable approach too. I couldnt grok why that TBF
extension for max bw was considered a bad idea.
On config:
Could we not introduce skip_sw/hw semantics for qdiscs? IOW, skip_sw
means the config is only subjected to hw and you have DIRECT
semantics, etc.
I understand the mlnx implementation of HTB does a lot of things in
the driver but the one nice thing they had was ability to use classid
X:Y to select a egress h/w queue. The driver resolution of all the
hierarchy is not needed at all here if i understood the requirement
above.
You still need to have a classifier in s/w (which could be attached to
clsact egress) to select the queue. That is something the mlnx
implementation allowed. So there is no "double queueing"

If this is about totally bypassing s/w config then its a different ballgame=
..

cheers,
jamal

> Regards,
> Simon with much assistance from Paolo
>
> ---
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
>         SHAPER_METRIC_PPS;
>         SHAPER_METRIC_BPS;
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
>         /* The following fields allow the full traversal of the whole
>          * hierarchy.
>          */
>         u32 id;
>         u32 parent_id;
>
>         /* The following fields define the behavior of the shaper. */
>         enum shaper_metric metric;
>         u64 bw_min;
>         u64 bw_max;
>         u32 burst;
>         u32 priority;
>         u32 weight;
> };
>
> /**
>  * enum shaper_lookup_mode - Lookup method used to access a shaper
>  * @SHAPER_LOOKUP_BY_PORT: The root shaper for the whole H/W, @id is unus=
ed
>  * @SHAPER_LOOKUP_BY_NETDEV: The main shaper for the given network device=
,
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
>  * mapping network visible objects (devices, VFs, queues) to the schedule=
r
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
>         /* get - Fetch the specified shaper, if it exists
>          * @dev: Netdevice to operate on.
>          * @lookup_mode: How to perform the shaper lookup
>          * @id: ID of the specified shaper,
>          *      relative to the specified @lookup_mode.
>          * @shaper: Object to return shaper.
>          * @extack: Netlink extended ACK for reporting errors.
>          *
>          * Multiple placement domain/id pairs can refer to the same shape=
r.
>          * And multiple entities (e.g. VF and PF) can try to access the s=
ame
>          * shaper concurrently.
>          *
>          * Values of @id depend on the @access_type:
>          * * If @access_type is SHAPER_LOOKUP_BY_PORT or
>          *   SHAPER_LOOKUP_BY_NETDEV, then @placement_id is unused.
>          * * If @access_type is SHAPER_LOOKUP_BY_VF,
>          *   then @id is a virtual function number, relative to @dev
>          *   which should be phisical function
>          * * If @access_type is SHAPER_LOOKUP_BY_QUEUE,
>          *   Then @id represents the queue number, relative to @dev
>          * * If @access_type is SHAPER_LOOKUP_BY_TREE_ID,
>          *   then @id is a @shaper_info.id and any shaper inside the
>          *   hierarcy can be accessed directly.
>          *
>          * Return:
>          * * %0 - Success
>          * * %-EOPNOTSUPP - Operation is not supported by hardware, drive=
r,
>          *                  or core for any reason. @extack should be set
>          *                  to text describing the reason.
>          * * Other negative error value on failure.
>          */
>         int (*get)(struct net_device *dev,
>                    enum shaper_lookup_mode lookup_mode, u32 id,
>                    struct shaper_info *shaper, struct netlink_ext_ack *ex=
tack);
>
>         /* set - Update the specified shaper, if it exists
>          * @dev: Netdevice to operate on.
>          * @lookup_mode: How to perform the shaper lookup
>          * @id: ID of the specified shaper,
>          *      relative to the specified @access_type.
>          * @shaper: Configuration of shaper.
>          * @extack: Netlink extended ACK for reporting errors.
>          *
>          * Configure the parameters of @shaper according to values suppli=
ed
>          * in the following fields:
>          * * @shaper.metric
>          * * @shaper.bw_min
>          * * @shaper.bw_max
>          * * @shaper.burst
>          * * @shaper.priority
>          * * @shaper.weight
>          * Values supplied in other fields of @shaper must be zero and,
>          * other than verifying that, are ignored.
>          *
>          * Return:
>          * * %0 - Success
>          * * %-EOPNOTSUPP - Operation is not supported by hardware, drive=
r,
>          *                  or core for any reason. @extack should be set
>          *                  to text describing the reason.
>          * * Other negative error values on failure.
>          */
>         int (*set)(struct net_device *dev,
>                    enum shaper_lookup_mode lookup_mode, u32 id,
>                    const struct shaper_info *shaper,
>                    struct netlink_ext_ack *extack);
>
>         /* Move - change the parent id of the specified shaper
>          * @dev: netdevice to operate on.
>          * @lookup_mode: how to perform the shaper lookup
>          * @id: ID of the specified shaper,
>          *                      relative to the specified @access_mode.
>          * @new_parent_id: new ID of the parent shapers,
>          *                      always relative to the SHAPER_LOOKUP_BY_T=
REE_ID
>          *                      lookup mode
>          * @extack: Netlink extended ACK for reporting errors.
>          *
>          * Move the specified shaper in the hierarchy replacing its
>          * current parent shaper with @new_parent_id
>          *
>          * Return:
>          * * %0 - Success
>          * * %-EOPNOTSUPP - Operation is not supported by hardware, drive=
r,
>          *                  or core for any reason. @extack should be set
>          *                  to text describing the reason.
>          * * Other negative error values on failure.
>          */
>         int (*move)(struct net_device *dev,
>                     enum shaper_lookup_mode lookup_mode, u32 id,
>                     u32 new_parent_id, struct netlink_ext_ack *extack);
>
>         /* add - Add a shaper inside the shaper hierarchy
>          * @dev: netdevice to operate on.
>          * @shaper: configuration of shaper.
>          * @extack: Netlink extended ACK for reporting errors.
>          *
>          * @shaper.id must be set to SHAPER_NONE_ID as
>          * the id for the shaper will be automatically allocated.
>          * @shaper.parent_id determines where inside the shaper's tree
>          * this node is inserted.
>          *
>          * Return:
>          * * non-negative shaper id on success
>          * * %-EOPNOTSUPP - Operation is not supported by hardware, drive=
r,
>          *                  or core for any reason. @extack should be set
>          *                  to text describing the reason.
>          * * Other negative error values on failure.
>          *
>          * Examples or reasons this operation may fail include:
>          * * H/W resources limits.
>          * * The parent is a =E2=80=98leaf=E2=80=99 node - attached to a =
queue.
>          * * Can=E2=80=99t respect the requested bw limits.
>          */
>         int (*add)(struct net_device *dev, const struct shaper_info *shap=
er,
>                    struct netlink_ext_ack *extack);
>
>         /* delete - Add a shaper inside the shaper hierarchy
>          * @dev: netdevice to operate on.
>          * @lookup_mode: how to perform the shaper lookup
>          * @id: ID of the specified shaper,
>          *                      relative to the specified @access_type.
>          * @shaper: Object to return the deleted shaper configuration.
>          *              Ignored if NULL.
>          * @extack: Netlink extended ACK for reporting errors.
>          *
>          * Return:
>          * * %0 - Success
>          * * %-EOPNOTSUPP - Operation is not supported by hardware, drive=
r,
>          *                  or core for any reason. @extack should be set
>          *                  to text describing the reason.
>          * * Other negative error values on failure.
>          */
>         int (*delete)(struct net_device *dev,
>                       enum shaper_lookup_mode lookup_mode,
>                       u32 id, struct shaper_info *shaper,
>                       struct netlink_ext_ack *extack);
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

