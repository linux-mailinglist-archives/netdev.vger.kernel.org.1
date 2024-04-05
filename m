Return-Path: <netdev+bounces-85314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA0D89A276
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 18:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC271C21BE0
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA1171082;
	Fri,  5 Apr 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBMJFZdT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403E16FF5D
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334325; cv=none; b=EtWNEjH7EOnOqhvv4EjRabl9XnXyJRFa6M6TX4Q6b3LTEMcDQNtVGCPJKxb3Su9OyBBDQKXRYrff8cc4TFDwXQCRkp5+bL7eNKaVLobSdKVtCOpZf7IS1yzyxHWKvhHHUEsEREXyNzuBhJkI7hUd+8s45161HFX3zgieJ1FCSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334325; c=relaxed/simple;
	bh=YSihvB8i+dG162GANpwIoLXUxLYLY2asywXrft7lk3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrM1LkoNvGtXTsjCkjMXsVnPO9xm1c/qASK9QO1vZev7YC6nolbfjSDs6ZP7xADYjvNcKIG4FTaGfHqZWvTbqas+LN6sCahdAPSrrmUJMriQtF3GsFVOCnLDMGT56qMn2Govb9vm/ZdySMU139h8R0L0shdzvQmWa1WAPzrWtEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBMJFZdT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712334322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hsK/Ro3P801sgqVeczQwjZnPT38+BQr69/ogx9aGBZg=;
	b=WBMJFZdTY2bS/VGSiR5DtULYTIWq0cDVhW4m5fbUu//Ee+4Thye4jjcaKKCktzjr1wM8a6
	aClqi4/lgQ4cS5aPY6bDtC/lWHCzY7s83ftt2wtz/0WWF0hruol4ZYxEbwXfrYVkvskQVO
	4KxEcAcQWeNSXeMKJVKUkuuFxAewVUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-wfVr2mlbPhSIj9BzNpIQHw-1; Fri, 05 Apr 2024 12:25:20 -0400
X-MC-Unique: wfVr2mlbPhSIj9BzNpIQHw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41543b57f2dso5358745e9.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 09:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334320; x=1712939120;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsK/Ro3P801sgqVeczQwjZnPT38+BQr69/ogx9aGBZg=;
        b=IcMjwI9iKUPvbjFyzKc8YzufZKwVUT+E0Vy5YuN73Jvft6lFQkrjzBFDd4vcC/QUbO
         mLj5ov/vB3GSgKu0tryk4rE4vZS/nLK0EHYDUYflNmEu0gDUyozXkr8qUimjUyoeKr3z
         v3C0zhuy4X05qx3hJa95ouJ+L+63NNkdjh96ulTMKJtSWSILbljb7IgqMzsNfsYKfyhu
         ONsmDUWK7hA2Lj1C3l69F0whfjl2TNP88r9sxad53uASB8YHujh5fHOHZZlDygq4Gkku
         CoBbi14HzyH7pCvAS0BdwGAGmbdO9LBVNPKl3AYfd3k5vrBvsXXcMMRg9zBX1XrG6aRe
         Vs+w==
X-Forwarded-Encrypted: i=1; AJvYcCWgVulU4veQQw7eS2ZwvJoeBYhlUIKRuqXpPVQashsQ5n5k1jqiKq9LdByYW5EMaVsLO1YY9DgN+CV/2n25RnhmSS8smVNz
X-Gm-Message-State: AOJu0Yx56FiebmmYPo7j0CXXuDH4MGr6C1a4/qUR3OIUyPwABvNQK+4f
	1k88SXkNun9WNDS2x/UD9RyaJkVU67N4XPYrRD6KoMcmLVG+WloAoss1DTw/0CeLK2oRjndWw0D
	7JWT3pfBeG6y22u4uT60embpbfbrQ3/Kc9uime44qyy8QC5YIE98baw==
X-Received: by 2002:a5d:4452:0:b0:33e:c97c:a24 with SMTP id x18-20020a5d4452000000b0033ec97c0a24mr1429376wrr.5.1712334319644;
        Fri, 05 Apr 2024 09:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOJc8eFMsC6GTchspgoJVqhnLxB86b50maAt0NrMosK13wBcJ9F7Fs6cMWJRSP4ZXiq5AdMg==
X-Received: by 2002:a5d:4452:0:b0:33e:c97c:a24 with SMTP id x18-20020a5d4452000000b0033ec97c0a24mr1429353wrr.5.1712334319121;
        Fri, 05 Apr 2024 09:25:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d500c000000b00341e7e52802sm2353825wrt.92.2024.04.05.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:25:18 -0700 (PDT)
Message-ID: <fc300335885790c759e565cb6712e78777da6ca9.camel@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>, Simon Horman
 <horms@kernel.org>,  netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Madhu
 Chittim <madhu.chittim@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 05 Apr 2024 18:25:17 +0200
In-Reply-To: <66100bee9f979_55e88208fd@john.notmuch>
References: <20240405102313.GA310894@kernel.org>
	 <66100bee9f979_55e88208fd@john.notmuch>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 07:34 -0700, John Fastabend wrote:
> Simon Horman wrote:
> > This is follow-up to the ongoing discussion started by Intel to extend =
the
> > support for TX shaping H/W offload [1].
> >=20
> > The goal is allowing the user-space to configure TX shaping offload on =
a
> > per-queue basis with min guaranteed B/W, max B/W limit and burst size o=
n a
> > VF device.
> >=20
> >=20
> > In the past few months several different solutions were attempted and
> > discussed, without finding a perfect fit:
> >=20
> > - devlink_rate APIs are not appropriate for to control TX shaping on ne=
tdevs
> > - No existing TC qdisc offload covers the required feature set
> > - HTB does not allow direct queue configuration
> > - MQPRIO imposes constraint on the maximum number of TX queues
>=20
> iirc the TX queue limitation was somewhat artifical. Probably we could
> extend it.

Indeed MQPRIO was one of the preferred candidates, but removing the
limits is blocked by uAPI constraints.

Even ignoring the uAPI problem, it will requires some offload change to
get full support of the features required here.

In practice that will be quite similar to creating a new offload type,
and will not be 'future proof'.

Since here we are adding a new offload type, the idea is to try to
cover the capabilities of exiting (and possibly foreseeable) H/W to
avoid being in the same situation some time from now.

Being 'future proof' is one of the requirements (sorry, not stated in
this thread yet) that materialized in the past discussion.

> > - TBF does not support max B/W limit
> > - ndo_set_tx_maxrate() only controls the max B/W limit
> >=20
> > A new H/W offload API is needed, but offload API proliferation should b=
e
> > avoided.
>=20
> Did you consider the dcbnl_rtnl_ops? These have the advantage of being
> implemented in intel, mlx, amd, broadcom and a few more drivers. There
> is an IEEE spec as well fwiw.
>=20
> This has a getmaxrate, setmaxrate API. Adding a getminrate and setminrate
> would be relatively straightforward. The spec defines how to do WRR and
> NICs support it.

It would be similar to ndo_set_tx_maxrate(). Extending it would be
simple, and is implemented by some different vendors already.

But we will face the same points mentioned above: will be quite similar
to creating a new offload type, and will not be 'future proof'.

> > The following proposal intends to cover the above specified requirement=
 and
> > provide a possible base to unify all the shaping offload APIs mentioned=
 above.
> >=20
> > The following only defines the in-kernel interface between the core and
> > drivers. The intention is to expose the feature to user-space via Netli=
nk.
> > Hopefully the latter part should be straight-forward after agreement
> > on the in-kernel interface.
> >=20
> > All feedback and comment is more then welcome!
> >=20
> > [1] https://lore.kernel.org/netdev/20230808015734.1060525-1-wenjun1.wu@=
intel.com/
> >=20
> > Regards,
> > Simon with much assistance from Paolo
>=20
> Cool to see some hw offloads.

:)

The planning phase was less cool :)

> > ---=20
> > /* SPDX-License-Identifier: GPL-2.0-or-later */
> >=20
> > #ifndef _NET_SHAPER_H_
> > #define _NET_SHAPER_H_
> >=20
> > /**
> >  * enum shaper_metric - the metric of the shaper
> >  * @SHAPER_METRIC_PPS: Shaper operates on a packets per second basis
> >  * @SHAPER_METRIC_BPS: Shaper operates on a bits per second basis
> >  */
> > enum shaper_metric {
> > 	SHAPER_METRIC_PPS;
> > 	SHAPER_METRIC_BPS;
> > };
>=20
> Interesting hw has a PPS limiter?

AFAIK at least the intel ice driver has this kind of support. I've been
told this is a requirement to access the telco market. I guess other
vendors will follow - assuming they don't have it already.

>=20
> >=20
> > #define SHAPER_ROOT_ID 0
> > #define SHAPER_NONE_ID UINT_MAX
> >=20
> > /**
> >  * struct shaper_info - represent a node of the shaper hierarchy
> >  * @id: Unique identifier inside the shaper tree.
> >  * @parent_id: ID of parent shaper, or SHAPER_NONE_ID if the shaper has
> >  *             no parent. Only the root shaper has no parent.
> >  * @metric: Specify if the bw limits refers to PPS or BPS
> >  * @bw_min: Minimum guaranteed rate for this shaper
> >  * @bw_max: Maximum peak bw allowed for this shaper
> >  * @burst: Maximum burst for the peek rate of this shaper
> >  * @priority: Scheduling priority for this shaper
> >  * @weight: Scheduling weight for this shaper
> >  *
> >  * The full shaper hierarchy is maintained only by the
> >  * NIC driver (or firmware), possibly in a NIC-specific format
> >  * and/or in H/W tables.
>=20
> Is the hw actually implementing hierarchy? For some reason I
> imagined different scopes, PF, VF, QueueSet, Queue. And if it
> has more hierarchy maybe FW is just translating this? IF that
> is the case perhaps instead of hierarchy we expose a
>=20
>   enum hw_rate_limit_scope scope
>=20
> and
>=20
>   enum hw_rate_limit_scope {
>      SHAPER_LOOKUP_BY_PORT,
>      SHAPER_LOOKUP_BY_NETDEV,
>      SHAPER_LOOKUP_BY_VF,
>      SHAPER_LOOKUP_BY_QUEUE_SET,
>      SHAPER_LOOKUP_BY_QUEUE,
>   }
>=20
> My preference is almost always to push logic out of firmware
> and into OS if possible.

I think this actually overlap with is described below? this API will
allow access by the above 'scopes' (except by QUEUE_SET, but we can add
it). See shaper_lookup_mode below.

>=20
> >  * The kernel uses this representation and the shaper_ops to
> >  * access, traverse, and update it.
> >  */
> > struct shaper_info {
> > 	/* The following fields allow the full traversal of the whole
> > 	 * hierarchy.
> > 	 */
> > 	u32 id;
> > 	u32 parent_id;
> >=20
> > 	/* The following fields define the behavior of the shaper. */
> > 	enum shaper_metric metric;
> > 	u64 bw_min;
> > 	u64 bw_max;
> > 	u32 burst;
>=20
> Any details on how burst is implemented in HW?

I guess I could describe some specific H/W implementation, but would
that be too restrictive? what about just:

	maximum bw_max burst in bytes

or the like?

>=20
> > 	u32 priority;
>=20
> What is priority?

It's the strict scheduling priority, within the relevant group/set.=20

>=20
> > 	u32 weight;
>=20
> Weight to me is a reference to a WRR algorithm? Is there some other
> notion here?

Yes, as in WRR.

The general idea is to try to expose as much features as possible from
the existing H/W.

[...]

> > 	/* set - Update the specified shaper, if it exists
> > 	 * @dev: Netdevice to operate on.
> > 	 * @lookup_mode: How to perform the shaper lookup
> > 	 * @id: ID of the specified shaper,
> > 	 *      relative to the specified @access_type.
> > 	 * @shaper: Configuration of shaper.
> > 	 * @extack: Netlink extended ACK for reporting errors.
> > 	 *
> > 	 * Configure the parameters of @shaper according to values supplied
> > 	 * in the following fields:
> > 	 * * @shaper.metric
> > 	 * * @shaper.bw_min
> > 	 * * @shaper.bw_max
> > 	 * * @shaper.burst
> > 	 * * @shaper.priority
> > 	 * * @shaper.weight
> > 	 * Values supplied in other fields of @shaper must be zero and,
> > 	 * other than verifying that, are ignored.
> > 	 *
> > 	 * Return:
> > 	 * * %0 - Success
> > 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> > 	 *		    or core for any reason. @extack should be set
> > 	 *		    to text describing the reason.
> > 	 * * Other negative error values on failure.
> > 	 */
> > 	int (*set)(struct net_device *dev,
> > 		   enum shaper_lookup_mode lookup_mode, u32 id,
> > 		   const struct shaper_info *shaper,
> > 		   struct netlink_ext_ack *extack);
> >=20
> > 	/* Move - change the parent id of the specified shaper
> > 	 * @dev: netdevice to operate on.
> > 	 * @lookup_mode: how to perform the shaper lookup
> > 	 * @id: ID of the specified shaper,
> > 	 *                      relative to the specified @access_mode.
> > 	 * @new_parent_id: new ID of the parent shapers,
> > 	 *                      always relative to the SHAPER_LOOKUP_BY_TREE_I=
D
> > 	 *                      lookup mode
> > 	 * @extack: Netlink extended ACK for reporting errors.
> > 	 *
> > 	 * Move the specified shaper in the hierarchy replacing its
> > 	 * current parent shaper with @new_parent_id
> > 	 *
> > 	 * Return:
> > 	 * * %0 - Success
> > 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> > 	 *		    or core for any reason. @extack should be set
> > 	 *		    to text describing the reason.
> > 	 * * Other negative error values on failure.
> > 	 */
>=20
> Some heavy firmware or onchip CPU managing this move operation? Is this
> a reset operation as well? Is there a need for an atomic move like this
> in initial API? Maybe start with just set and push down an entire config
> in one hit. If hw can really move things around dynamically I think it
> would make sense though.

This 'move' ops was a last minute addendum. It's used by the example
below, useful in not trivial scenario. Reading the datasheet 'ice'
supports it, and I think even mlx5 - guessing on devlink_rate api.

It can be dropped or added later, without it the queue group example
below will need some other additional op.

I guess h/w not supporting it (or posing some kind of constraint) could
error out with some descriptive extack.

> > 	int (*move)(struct net_device *dev,
> > 		    enum shaper_lookup_mode lookup_mode, u32 id,
> > 		    u32 new_parent_id, struct netlink_ext_ack *extack);
> >=20
> > 	/* add - Add a shaper inside the shaper hierarchy
> > 	 * @dev: netdevice to operate on.
> > 	 * @shaper: configuration of shaper.
> > 	 * @extack: Netlink extended ACK for reporting errors.
> > 	 *
> > 	 * @shaper.id must be set to SHAPER_NONE_ID as
> > 	 * the id for the shaper will be automatically allocated.
> > 	 * @shaper.parent_id determines where inside the shaper's tree
> > 	 * this node is inserted.
> > 	 *
> > 	 * Return:
> > 	 * * non-negative shaper id on success
> > 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> > 	 *		    or core for any reason. @extack should be set
> > 	 *		    to text describing the reason.
> > 	 * * Other negative error values on failure.
> > 	 *
> > 	 * Examples or reasons this operation may fail include:
> > 	 * * H/W resources limits.
> > 	 * * The parent is a =E2=80=98leaf=E2=80=99 node - attached to a queue=
.
> > 	 * * Can=E2=80=99t respect the requested bw limits.
> > 	 */
> > 	int (*add)(struct net_device *dev, const struct shaper_info *shaper,
> > 		   struct netlink_ext_ack *extack);
> >=20
> > 	/* delete - Add a shaper inside the shaper hierarchy
> > 	 * @dev: netdevice to operate on.
> > 	 * @lookup_mode: how to perform the shaper lookup
> > 	 * @id: ID of the specified shaper,
> > 	 *                      relative to the specified @access_type.
> > 	 * @shaper: Object to return the deleted shaper configuration.
> > 	 *              Ignored if NULL.
> > 	 * @extack: Netlink extended ACK for reporting errors.
> > 	 *
> > 	 * Return:
> > 	 * * %0 - Success
> > 	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> > 	 *		    or core for any reason. @extack should be set
> > 	 *		    to text describing the reason.
> > 	 * * Other negative error values on failure.
> > 	 */
> > 	int (*delete)(struct net_device *dev,
> > 		      enum shaper_lookup_mode lookup_mode,
> > 		      u32 id, struct shaper_info *shaper,
> > 		      struct netlink_ext_ack *extack);
>=20
> One thought I have about exposing hierarchy like this is user will need=
=20
> to have nic user manual in hand to navigate hardware limitation I presume=
.
> If hw is this flexible than lets do something. But, this is why I started
> to think more about scopes (nic, pf, vf, queueSet, queue) than arbitrary
> hierarchy. Perhaps this is going to target some DPU though with lots of
> flexibility here.

I fear we were too terse describing 'enum shaper_lookup_mode
lookup_mode/id access'. I think, it actually allows the scope lookup
you are looking for. And even the full hierarchy access - if the H/W
support it.=20

My understanding is that at least intel and mellanox already support
this kind of features, and likely marvell.

> > };
> >=20
> > /*
> >  * Examples:
> >  * - set shaping on a given queue
> >  *   struct shaper_info info =3D { // fill this };
> >  *   dev->shaper_ops->set(dev, SHAPER_LOOKUP_BY_QUEUE, queue_id, &info,=
 NULL);
> >  *
> >  * - create a queue group with a queue group shaping limits.
> >  *   Assuming the following topology already exists:
> >  *                    < netdev shaper >
> >  *                      /           \
> >  *         <queue 0 shaper> . . .  <queue N shaper>
> >  *
> >  *   struct shaper_info pinfo, ginfo;
> >  *   dev->shaper_ops->get(dev, SHAPER_LOOKUP_BY_NETDEV, 0, &pinfo);
> >  *
> >  *   ginfo.parent_id =3D pinfo.id;
> >  *   // fill-in other shaper params...
> >  *   new_node_id =3D dev->shaper_ops->add(dev, &ginfo);
> >  *
> >  *   // now topology is:
> >  *   //                  <    netdev shaper    >
> >  *   //                  /            |        \
> >  *   //                 /             |        <newly created shaper>
> >  *   //                /              |
> >  *   // <queue 0 shaper> . . . <queue N shaper>
>=20
> I think we need a queue set shaper as part of this for larger bw limits.

I'm sorry, I'm unsure I understand the above, could you please re-
phrase?

In this example the 'newly created shaper' is a 'queue set' shaper.


Thanks for the feedback!

Paolo


