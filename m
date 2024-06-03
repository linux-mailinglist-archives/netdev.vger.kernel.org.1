Return-Path: <netdev+bounces-100178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727D8D80A0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574472817B3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2A84D0F;
	Mon,  3 Jun 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbtyCnZZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1F84D07
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413108; cv=none; b=saYN7bbAItOOSIotOyX8dk6t/6adaJ0/1nn1fuoqyVrpUodzHwuytDfDATYqypxIV7FqBM1Jtpv4KGUAzp1dDJmSyzc5QaNwfYjThUlGw2yOUuRJ0utaoMlY7/k2LJrcBIXwlXuwIMUDqJZmdo362b7OiMZgO8OLqcb8FQtOBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413108; c=relaxed/simple;
	bh=vJsRbeyWIVNjrncznqVLAp7RkcCoVLovO7F4CmulAG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWlJ/VPLDTEatX86IAjle/DkByIXjyZ412ljsLksdqZqH5IV755bh/ngmK2qbzgOK+7aAeQzxJycr1ugH3HV4ZsLlhTf/zH0D3vCoxuqq7zeXYOuRIffWwq0Ii91EGYS+MvA47OxConee9wh03htPbS1wvZ/bjGegGvdn8SFu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbtyCnZZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717413105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mgX6m2yhUXpskSq1hKWUFuWr2WVZ24DiDs6pJ6/vJV4=;
	b=WbtyCnZZLdKieLy45krz964OyFeJOiKLdBC2mybUUww/SHd2LDQJQpAlcowI6lSCgUEpsl
	DJ94xRaY86lbCLd6G4e6t0kmO2tb4WHg/3VylfJwzEoI7Rn1JQIK7ZVAB1HSglEJ9oJ4/2
	JFKVK6pmrPOIQKkqDwWKP/T0dKR6AwA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-8jbViCHHPv262BCS2TJZJA-1; Mon, 03 Jun 2024 07:11:43 -0400
X-MC-Unique: 8jbViCHHPv262BCS2TJZJA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4211239ed3dso5515185e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 04:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717413102; x=1718017902;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgX6m2yhUXpskSq1hKWUFuWr2WVZ24DiDs6pJ6/vJV4=;
        b=PoyCtoRvQqJFQPeSeZcqsjhzmqo+4ytxgffAgo9GozenEPmi58KlmVRBtri9dXcOC0
         kPw9fMVsP1p9ewx81vQKdiwY7pBYQJVJP+DC3qMuX9VGIxyO5T1dB7/dQImipxOJ5TlW
         4H+vwz0hG2MjMNjic0MzQvDwkZEKjVr5ijfzndLffzZDB3Av7Mc2v9GEciKGjUwGxoB3
         MD7Wky9sMljNBQUFCBbjI8q1P3KntwvDR6wfGTFfcOgqC3CseBpLWiiQhJSlug9ZspNT
         FKej94H7VV+A1+OpFHe3Qi6P78EHJyI5iBKg/Rm+ckE2C9JRvBhUHLFZY4c5yYyATOZH
         jDKw==
X-Gm-Message-State: AOJu0Yxucof3MHQ5Vj1MkEYMIo/RzH7deeazKRss1sLkDCm1O0u9hi0L
	Go2okOf8NY4I6ihGjBl9bazuIXt0Xj3zK2eBkuES5FhFSlRh9H487eDpUiCTnl86wlqInEJfGx8
	I3mHHQ4QMlgYdR8dkC6RtnQE0OWiDXu7RGJrLmG6gatYKVzAxf9KcOw==
X-Received: by 2002:a05:600c:1d27:b0:41a:c04a:8021 with SMTP id 5b1f17b1804b1-4212e004258mr68201165e9.0.1717413101783;
        Mon, 03 Jun 2024 04:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvIWJIA3q/+RGQGIWa0D3iFEMPNVxY/ifU5NuHB/kEyDAeczZ1Im84dRr4L2WRAT4hv+TtoA==
X-Received: by 2002:a05:600c:1d27:b0:41a:c04a:8021 with SMTP id 5b1f17b1804b1-4212e004258mr68201035e9.0.1717413101273;
        Mon, 03 Jun 2024 04:11:41 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213860126fsm65863675e9.40.2024.06.03.04.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 04:11:40 -0700 (PDT)
Message-ID: <c5dcf167aad610c6c623c5958bb252647773fddd.camel@redhat.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 03 Jun 2024 13:11:39 +0200
In-Reply-To: <20240531090057.02fb8616@kernel.org>
References: 
	<3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	 <20240528101845.414cff22@kernel.org>
	 <16d7b761c3c1b4c4bd327d4486d958682a5f33dd.camel@redhat.com>
	 <20240531090057.02fb8616@kernel.org>
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

It looks like most of the open points here are related lack of clarity
or misunderstanding. I propose to discuss them in the upcoming
reviewer's meeting.

Some replies below, just in case I magically achieved superior written
natural language skills meanwhile ;)=20

On Fri, 2024-05-31 at 09:00 -0700, Jakub Kicinski wrote:
> On Fri, 31 May 2024 11:22:46 +0200 Paolo Abeni wrote:
> > On Tue, 2024-05-28 at 10:18 -0700, Jakub Kicinski wrote:
> > > > +	u32 priority;	/* scheduling strict priority */
> > > > +	u32 weight;	/* scheduling WRR weight*/ =20
> > >=20
> > > I wonder if we should somehow more clearly specify what a node can do=
.
> > > Like Andrew pointed out, if we have a WRR node, presumably the weight=
s
> > > go on the children, since there's only one weigh param. But then the
> > > WRR node itself is either empty (no params) or has rate params... whi=
ch
> > > is odd.
> > >=20
> > > Maybe shaping nodes and RR nodes should be separate node classes,
> > > somehow? =20
> >=20
> > Possibly clarifying the meaning of 'weight' field would help? =20
> > It means: this node is scheduled WRR according to the specified weight
> > among the sibling shapers with the same priority.
> >=20
> > I think it's quite simpler than introducing different node classes with
> > separate handling. My understanding is that the latter would help only
> > to workaround some H/W limitation and will make the implementation more
> > difficult for more capable H/W.
> >=20
> > What kind of problems do you foresee with the above definition?
>=20
> The problem Andrew mentioned, basically. There may not be a path to
> transition one fully offloaded hierarchy to another (e.g. switching
> strict prio to WRR). TBH I haven't really grasped your proposal in:
> https://lore.kernel.org/all/db51b7ccff835dd5a96293fb84d527be081de062.came=
l@redhat.com/

The problem Andrew reported is that some H/W, in some configuration,
can't change per-queue shapers individually.

The solution proposed in the above link is to let the API change
multiple shapers with a single op "atomically".

> > > > + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only availabl=
e on
> > > > + * PF devices, usually inside the host/hypervisor.
> > > > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> > > > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs device=
s.
> > > > + */
> > > > +enum net_shaper_scope {
> > > > +	NET_SHAPER_SCOPE_PORT,
> > > > +	NET_SHAPER_SCOPE_NETDEV,
> > > > +	NET_SHAPER_SCOPE_VF, =20
> > >=20
> > > I realized now that we do indeed need this VF node (if we want to
> > > internally express the legacy SRIOV NDOs in this API), as much=20
> > > as I hate it. Could you annotate somehow my nack on ever exposing
> > > the ability to hook on the VF to user space? =20
> >=20
> > This work sparked from the need to allow configuring a shaper on
> > specific queues of some VF from the host. I hope this is not what you
> > are nacking here? Could you please elaborate a bit what concern you
> > with 'hook on the VF to user space'? Would the ability of attaching a
> > shaper to the VF from the host hit your nack?
>=20
> Queue configuration, for the VF, from the hypervisor?
> I thought it was from the VF.
> In any case, hypervisor has the representors.=20
> Use the representor's NETDEV scope?

It looks like even the NETDEV scope + representor alternative should
fit the intended use-case.

> > > > +	NET_SHAPER_SCOPE_QUEUE_GROUP, =20
> > >=20
> > > We may need a definition for a queue group. Did I suggest this? =20
> >=20
> > I think this was mentioned separately by you, John Fastabend and Intel.
>=20
> Oh ugh, I can't type. I think I meant to say "Why do we need..."
>=20
> > > Isn't queue group just a bunch of queues feeding a trivial RR node?
> > > Why does it need to be a "scope"? =20
> >=20
> > The goal is allowing arbitrary manipulation at the queue group level.
> > e.g. you can have different queue groups with different priority, or
> > weigh or shaping, and below them arbitrary shaping at the queue level.
> >=20
> > Note that a similar concept could be introduced for device (or VFs)
> > groups.
> >=20
> > Why would you like to constraint the features avail at the queue
> > groups?
>=20
> Wait! You don't have a way to create pure RR nodes other than queue
> group now? Perhaps that's what I'm missing...

No, it's not needed.=C2=A0To have RR on some queues, just set the same
weight and priority on them.

Queue groups could be used to do something more complex, e.g. shaping
on the specified set of RR queues.

> > > > +	NET_SHAPER_SCOPE_QUEUE,
> > > > +};
> > > > +
> > > > +/**
> > > > + * struct net_shaper_ops - Operations on device H/W shapers
> > > > + * @add: Creates a new shaper in the specified scope. =20
> > >=20
> > > "in a scope"? Isn't the scope just defining the ingress and egress
> > > points of the scheduling hierarchy? =20
> >=20
> > This is purely lexical matter, right? The scope, and more specifically
> > the full 'handle' comprising more scoped-related information, specifies
> > 'where' the shaper is located. Do you have a suggested alternative
> > wording?
>=20
> ... and also what confused me here.
>=20
> How are you going to do 2 layers of grouping with arbitrary shaping?
> We need arbitrary inner nodes. Unless I'm missing a trick.

I guess this part really needs some talk. I also don't understand your
doubt above.

> >=20
I hope we can discuss this tomorrow (and the other points, if/as
needed).

Thanks!

Paolo


