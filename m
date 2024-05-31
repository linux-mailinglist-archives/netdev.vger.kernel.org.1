Return-Path: <netdev+bounces-99694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D328D5E24
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704632897A6
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6281ACB;
	Fri, 31 May 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlMZ3/gY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A782480
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147375; cv=none; b=bi3pXUoYzcFeD+z3X5czI1pLeIGSeaXEJh/Fmbs5w+gz/Q38zhk9e9ZshDgEONOB4DB2zujfW+eXPAjNpejBWAUKVzMpPQXqPzP9XJmLbdROgE7S7PM5AB4cko9L2hsSE9qAy/DoceCJQ/E8LYReOG6W9Wc/NFd0ev08q7cN8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147375; c=relaxed/simple;
	bh=trasFSFgODL8XLAB7VNRMpfr10nt58DwgIB8xXcGNfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEJtBvdW8IFyhu5XvFIQhPXYlHnhnQEv04tTdxFWHiyA9AaOnc+FMenODwUpLcL3VCz1k6L0DGwxxTYAgHZ01k/RoPsEgvholgGx/mmArnleuv9RyBk2dIaJiNFUNS8sElllq1dtCVvA0AkoAJKY9NsZ+sOhRqdJ0UtZPp9CEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlMZ3/gY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717147372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KiH80SYGRUn5Kh7SgMmi8k4Hjwq1ocZWMguu+PiH2eU=;
	b=hlMZ3/gY4cGYOvRd35OyhTruo3dVMCT+xJPXle8Ub9Ya4alx9HvEIiInlBb20qQZvKudfG
	+YjQle0Iq4lurzNhLpfkeEf0EiFl4rr6qs16+GyOwb0diHU0IUHHEBPvg2gxDefAoG4z55
	Yvt47Vey4oPsvAf+y20oN3NB0Pf8/6w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-MrQKMgi_NF6RyY7QD1nFFg-1; Fri, 31 May 2024 05:22:50 -0400
X-MC-Unique: MrQKMgi_NF6RyY7QD1nFFg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57a2beef973so151908a12.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 02:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147369; x=1717752169;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiH80SYGRUn5Kh7SgMmi8k4Hjwq1ocZWMguu+PiH2eU=;
        b=eqbfa9pgC/ewNVF565N12lQzYvbHfFxot9MRtj3hVYp3zlTIMvcTJeB7jZ/o4YnwXv
         ffaHDZ4px7F7VzI52Vw6+S3UuvsxzwSESD3IMd5sybI3KhOdCUJvL1pLhJiH4Kj8RpNQ
         6++dheWJf6jrA2r6lt2DarNv9ftslzaZon5kMT/7GeGw4k2lfO16V+1+yZ24zdUmeMy8
         oN0qHULx6sQRn1O/+/ClqO37K6yQzARNd6F8zOhmrOTp85nLPuUmZSk8OGH7HuaxWYvP
         AwWUiymnVNsXFiai5ocO0XU/m8TzqPSBsVKYb2QopGJRdO9j8l1VYvgxqDyP5aFeUGk/
         Uxtg==
X-Gm-Message-State: AOJu0Yzq1eNlxio9SHpdbzOa3dRTT3CO0C7A3j7SaxOEjweTlMvR/zq8
	qU/YHIajzBeMwjr8xIxTHFZT/7SHVWzn+98p/u2lWCid2i5yC21oaaTpWV0jD3bfyrpGlTAsFhU
	+EeI8wwGrxAr6wbW2O0QCAK4IYhPT8n3nKQk6OZqDwDtkLy/OoLkMMQ==
X-Received: by 2002:a17:906:fd0e:b0:a61:9d64:e79c with SMTP id a640c23a62f3a-a681c4fbfafmr81946366b.0.1717147369123;
        Fri, 31 May 2024 02:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkaMBE96xY1ejzbF2cj+lx2E5FleBNZv0h5hhd5pCODyJvwpMCaN9jq9CqwA7k9XT7TIgM7A==
X-Received: by 2002:a17:906:fd0e:b0:a61:9d64:e79c with SMTP id a640c23a62f3a-a681c4fbfafmr81944666b.0.1717147368571;
        Fri, 31 May 2024 02:22:48 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b5c:c210::f71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73f9a72sm65989666b.72.2024.05.31.02.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:22:47 -0700 (PDT)
Message-ID: <16d7b761c3c1b4c4bd327d4486d958682a5f33dd.camel@redhat.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 31 May 2024 11:22:46 +0200
In-Reply-To: <20240528101845.414cff22@kernel.org>
References: 
	<3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	 <20240528101845.414cff22@kernel.org>
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

Hi,

Thank you for your time and reply.=20

On Tue, 2024-05-28 at 10:18 -0700, Jakub Kicinski wrote:
> > +	u32 priority;	/* scheduling strict priority */
> > +	u32 weight;	/* scheduling WRR weight*/
>=20
> I wonder if we should somehow more clearly specify what a node can do.
> Like Andrew pointed out, if we have a WRR node, presumably the weights
> go on the children, since there's only one weigh param. But then the
> WRR node itself is either empty (no params) or has rate params... which
> is odd.
>=20
> Maybe shaping nodes and RR nodes should be separate node classes,
> somehow?

Possibly clarifying the meaning of 'weight' field would help? =20
It means: this node is scheduled WRR according to the specified weight
among the sibling shapers with the same priority.

I think it's quite simpler than introducing different node classes with
separate handling. My understanding is that the latter would help only
to workaround some H/W limitation and will make the implementation more
difficult for more capable H/W.

What kind of problems do you foresee with the above definition?

> > +};
> > +
> > +/**
> > + * enum net_shaper_scope - the different scopes where a shaper could b=
e attached
> > + * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
> > + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network dev=
ice.
> > + * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtu=
al
> > + * function.
> > + * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple queues un=
der the
> > + * same device.
> > + * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given devic=
e queue.
>=20
> I wonder if we need traffic class? Some devices may have two schedulers,
> one from the host interfaces (PCIe) into the device buffer. And then
> from the device buffer independently into the wire.

I feel like I'm really missing your point here. How would you use
traffic class? And how the 2 schedulers come into play here? Each of
them will be tied to one or more of the scopes above, why exposing H/W
details that will not expand user visible features?

> > + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only available on
> > + * PF devices, usually inside the host/hypervisor.
> > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
> > + */
> > +enum net_shaper_scope {
> > +	NET_SHAPER_SCOPE_PORT,
> > +	NET_SHAPER_SCOPE_NETDEV,
> > +	NET_SHAPER_SCOPE_VF,
>=20
> I realized now that we do indeed need this VF node (if we want to
> internally express the legacy SRIOV NDOs in this API), as much=20
> as I hate it. Could you annotate somehow my nack on ever exposing
> the ability to hook on the VF to user space?

This work sparked from the need to allow configuring a shaper on
specific queues of some VF from the host. I hope this is not what you
are nacking here? Could you please elaborate a bit what concern you
with 'hook on the VF to user space'? Would the ability of attaching a
shaper to the VF from the host hit your nack?

>=20
> > +	NET_SHAPER_SCOPE_QUEUE_GROUP,
>=20
> We may need a definition for a queue group. Did I suggest this?

I think this was mentioned separately by you, John Fastabend and Intel.

> Isn't queue group just a bunch of queues feeding a trivial RR node?
> Why does it need to be a "scope"?

The goal is allowing arbitrary manipulation at the queue group level.
e.g. you can have different queue groups with different priority, or
weigh or shaping, and below them arbitrary shaping at the queue level.

Note that a similar concept could be introduced for device (or VFs)
groups.

Why would you like to constraint the features avail at the queue
groups?

>=20
> > +	NET_SHAPER_SCOPE_QUEUE,
> > +};
> > +
> > +/**
> > + * struct net_shaper_ops - Operations on device H/W shapers
> > + * @add: Creates a new shaper in the specified scope.
>=20
> "in a scope"? Isn't the scope just defining the ingress and egress
> points of the scheduling hierarchy?

This is purely lexical matter, right? The scope, and more specifically
the full 'handle' comprising more scoped-related information, specifies
'where' the shaper is located. Do you have a suggested alternative
wording?

> Also your example moves schedulers from queue scope to queue group
> scope.

In the example, this part creates/enables a shaper at the queue level:

	u32 ghandle =3D shaper_make_handle(NET_SHAPER_SCOPE_QUEUE_GROUP, 0, 0);
	dev->shaper_ops->add(dev, ghandle, &ginfo);

and this:
=09
	u32 handle =3D shaper_make_handle(NET_SHAPER_SCOPE_QUEUE, 0, queue_id);
	//...
	dev->netshaper_ops->move(dev, qhandle, ghandle, NULL);

changes the _parent_ of qhandle setting it to the previously creates
queue group shaper. qhandle initial/implicit/default parent was the
device scope shaper.

The scope of the queue shaper remains unchanged. An I misunderstanding
your point?


>=20
> > + * @set: Modify the existing shaper.
> > + * @delete: Delete the specified shaper.
> > + * @move: Move an existing shaper under a different parent.
> > + *
> > + * The initial shaping configuration ad device initialization is empty=
/
>=20
> and
>=20
> > + * a no-op/does not constraint the b/w in any way.
> > + * The network core keeps track of the applied user-configuration in
> > + * per device storage.
>=20
> "keeps track .. per device" -- "storage" may make people think NVM.
>=20
> > + * Each shaper is uniquely identified within the device with an 'handl=
e',
> > + * dependent on the shaper scope and other data, see @shaper_make_hand=
le()
> > + */
> > +struct net_shaper_ops {
> > +	/** add - Add a shaper inside the shaper hierarchy
> > +	 * @dev: netdevice to operate on
> > +	 * @handle: the shaper indetifier
> > +	 * @shaper: configuration of shaper
> > +	 * @extack: Netlink extended ACK for reporting errors.
> > +	 *
> > +	 * Return:
> > +	 * * 0 on success
> > +	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> > +	 *                  or core for any reason. @extack should be set to
> > +	 *                  text describing the reason.
> > +	 * * Other negative error values on failure.
> > +	 *
> > +	 * Examples or reasons this operation may fail include:
> > +	 * * H/W resources limits.
> > +	 * * Can=E2=80=99t respect the requested bw limits.
> > +	 */
> > +	int (*add)(struct net_device *dev, u32 handle,
> > +		   const struct net_shaper_info *shaper,
> > +		   struct netlink_ext_ack *extack);
> > +
> > +	/** set - Update the specified shaper, if it exists
>=20
> Why "if it exists" ? Core should make sure it exists, no?
>=20
> In addition to ops and state, the device will likely need to express
> capabilities of some sort. So that the core can do some work for the
> drivers and in due course we can expose them to user space for
> discoverability.

What kind of capabilities are you thinking about? supported scopes?
supported metrics? What else? I feel like there is a lot of
mixed/partial kind of support which is hard to express in a formal way
but would fit nicely an extended ack for a failing op - as the SP/WRR
constrains Andrew reported.

Do we need to introduce this introspection support from the start? I
think that having a few H/W implementations around would help (at least
me) understanding which properties could relevant here.

Thanks,

Paolo


