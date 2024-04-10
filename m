Return-Path: <netdev+bounces-86482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522989EF08
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB441F21E2E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4F15530C;
	Wed, 10 Apr 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoKP2zJ0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20197154BF6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742074; cv=none; b=E1ulFJHy8KOMQF70uhmeIPcpb/e/iFkqg4M7/d7GQKqELCfTwpCVzEnig9pTQpeYP/KIVV+JLt9yqYMqnu9VVdCoOXZEOR+NjhZ8hN6k4mvo5N5jsyqBQFn8F6n6+T7LXlHiA/V6HIw61900csei4IStTzBkJ5VgMb1F7r3HnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742074; c=relaxed/simple;
	bh=15dK3hmzofzMTuSKaRB5iq0qYc0JfC8CBA6LXhqfnSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iAPB09I+ymTpjIt9mpizpKy7uGHDDuIYsbKaYr9kumnxtZ9sGCRRL+0ED6VWNBcXFH2UMf4zeKM+C823uUUr6Qq62VDnhlbn5/vcKBI4VF3YR6rwpB1n6XbkMYZ3qfr1ENcw6PvlR8shS/dSvKb8jr2xIjKq67ZBF9nlvUizU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoKP2zJ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=15dK3hmzofzMTuSKaRB5iq0qYc0JfC8CBA6LXhqfnSM=;
	b=hoKP2zJ0+cXTXYE0RQfCETuNBZER0XNKQfKI3iIu1fLRJ6P+gzkgYd5Me2HMYAzSj1no48
	VGaA4UEXnVQzpYU/DZRirmPzWmzu9ziuhwarAJeFwfhNx559/xfBNq5vbjxTtEi5usVgU5
	1XRlf7hd7SCN+TUyFEjqgbExVMpAPnE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-JZNTSYcbPZ-UjAF8XzYYNw-1; Wed, 10 Apr 2024 05:41:09 -0400
X-MC-Unique: JZNTSYcbPZ-UjAF8XzYYNw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343edd4ac01so1094400f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 02:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742068; x=1713346868;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15dK3hmzofzMTuSKaRB5iq0qYc0JfC8CBA6LXhqfnSM=;
        b=W9Jjy6tByh3Lqal0m3Ci9GbnnH2b/6DhRx5tQQMSwNKd3aYAbf7p4thBS4SC55QeAH
         rIvVmEwEwB18mdSI8Ufn1qWnGg6G5+iRxAxo67KcggKckAdHOGHKzp+1x4uKXKwE8YCH
         ccSnfjUYcWKPflG8YRv75bkCAmdwb2eOimKY0ZmeG+m6loepoFDjLZzBVRn0ycoON0ux
         Xvn+gIRHHym/9YVrbARr3LYynPhXfEy7Cq2PcOXtirEIt3aSeEbd6TF1xBrByAZIuu9g
         WFmRNBAy2tABCe65/XYCHr6lbstENjT93x0DrRembLY1oxi1TtPlSG3wzFqi1P73Vmng
         DH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZVz31hRvd2a3r8ziRlBXbs1vfpez0NAREbLDtxWn8EEjVeyFjEgFO/stm4kMfBhXGVenZwrcLPXZPCMIz0Dte0TgZC3fp
X-Gm-Message-State: AOJu0YzCAJGYyzhOIH+6XoKZz4PPxgTy6P+/DZq2s3mWJLorX1EA9rA7
	oqRjjXgkfriFd6pf0auPWbfY4DF+Bgg3zsfXEj7LfR/BLCShPf1W6z/0aAWRDAsfdB1/Ff8/RSn
	/neodZBljNWpvLQSONX/uO2CSwJwKHI1BqQWMUGO786xN3IfHLGVICw==
X-Received: by 2002:a05:6000:23a:b0:343:bbec:aef8 with SMTP id l26-20020a056000023a00b00343bbecaef8mr1261651wrz.7.1712742068432;
        Wed, 10 Apr 2024 02:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP2L38/7yfGLzpkcVoti8FJBFJbexxia7hN2H0IGr8JIaPZi04XOmMqAokxCVBDqkI4LW4Pw==
X-Received: by 2002:a05:6000:23a:b0:343:bbec:aef8 with SMTP id l26-20020a056000023a00b00343bbecaef8mr1261639wrz.7.1712742067972;
        Wed, 10 Apr 2024 02:41:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-180.dyn.eolo.it. [146.241.233.180])
        by smtp.gmail.com with ESMTPSA id u10-20020adff88a000000b00343e01d3f6dsm13407810wrp.3.2024.04.10.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:41:07 -0700 (PDT)
Message-ID: <bf24862c280a97c98c69d22aa1a7cc5109878164.camel@redhat.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  John Fastabend <john.fastabend@gmail.com>
Date: Wed, 10 Apr 2024 11:41:06 +0200
In-Reply-To: <CAM0EoMkeErAmjksQKqOjL6uz00XXahvbgoHJWpCRjR-S6CkSGA@mail.gmail.com>
References: <20240405102313.GA310894@kernel.org>
	 <CAM0EoMnEWbLJXNChpDrnKSsu6gXjaPwCX9jRqKv0UagPUuo1tA@mail.gmail.com>
	 <b32bab8ee1468647b4b9d93407cf8287bcffc67f.camel@redhat.com>
	 <CAM0EoMkeErAmjksQKqOjL6uz00XXahvbgoHJWpCRjR-S6CkSGA@mail.gmail.com>
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

On Sat, 2024-04-06 at 09:48 -0400, Jamal Hadi Salim wrote:
> On Fri, Apr 5, 2024 at 1:06=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Fri, 2024-04-05 at 09:33 -0400, Jamal Hadi Salim wrote:
> > > On Fri, Apr 5, 2024 at 6:25=E2=80=AFAM Simon Horman <horms@kernel.org=
> wrote:
> > > > This is follow-up to the ongoing discussion started by Intel to ext=
end the
> > > > support for TX shaping H/W offload [1].
> > > >=20
> > > > The goal is allowing the user-space to configure TX shaping offload=
 on a
> > > > per-queue basis with min guaranteed B/W, max B/W limit and burst si=
ze on a
> > > > VF device.
> > > >=20
> > > >=20
> > > > In the past few months several different solutions were attempted a=
nd
> > > > discussed, without finding a perfect fit:
> > > >=20
> > > > - devlink_rate APIs are not appropriate for to control TX shaping o=
n netdevs
> > > > - No existing TC qdisc offload covers the required feature set
> > > > - HTB does not allow direct queue configuration
> > > > - MQPRIO imposes constraint on the maximum number of TX queues
> > > > - TBF does not support max B/W limit
> > > > - ndo_set_tx_maxrate() only controls the max B/W limit
> > > >=20
> > > > A new H/W offload API is needed, but offload API proliferation shou=
ld be
> > > > avoided.
> > > >=20
> > > > The following proposal intends to cover the above specified require=
ment and
> > > > provide a possible base to unify all the shaping offload APIs menti=
oned above.
> > > >=20
> > > > The following only defines the in-kernel interface between the core=
 and
> > > > drivers. The intention is to expose the feature to user-space via N=
etlink.
> > > > Hopefully the latter part should be straight-forward after agreemen=
t
> > > > on the in-kernel interface.
> > > >=20
> > > > All feedback and comment is more then welcome!
> > > >=20
> > > > [1] https://lore.kernel.org/netdev/20230808015734.1060525-1-wenjun1=
.wu@intel.com/
> > > >=20
> > >=20
> > > My 2 cents:
> > > I did peruse the lore quoted thread but i am likely to have missed so=
mething.
> > > It sounds like the requirement is for egress-from-host (which to a
> > > device internal looks like ingress-from-host on the device). Doesn't
> > > existing HTB offload already support this? I didnt see this being
> > > discussed in the thread.
> >=20
> > Yes, HTB has been one of the possible option discussed, but not in that
> > thread, let me find the reference:
> >=20
> > https://lore.kernel.org/netdev/131da9645be5ef6ea584da27ecde795c52dfbb00=
.camel@redhat.com/
> >=20
> > it turns out that HTB does not allow configuring TX shaping on a per
> > (existing, direct) queue basis. It could, with some small functional
> > changes, but then we will be in the suboptimal scenario I mentioned in
> > my previous email: quite similar to creating a new offload type,
> > and will not be 'future proof'.
> >=20
> > > Also, IIUC, there is no hierarchy
> > > requirement. That is something you can teach HTB but there's probably
> > > something i missed because i didnt understand the context of "HTB doe=
s
> > > not allow direct queue configuration". If HTB is confusing from a
> > > config pov then it seems what Paolo was describing in the thread on
> > > TBF is a reasonable approach too. I couldnt grok why that TBF
> > > extension for max bw was considered a bad idea.
> >=20
> > TBF too was also in the category 'near enough but not 100% fit'
> >=20
> > > On config:
> > > Could we not introduce skip_sw/hw semantics for qdiscs? IOW, skip_sw
> > > means the config is only subjected to hw and you have DIRECT
> > > semantics, etc.
> > > I understand the mlnx implementation of HTB does a lot of things in
> > > the driver but the one nice thing they had was ability to use classid
> > > X:Y to select a egress h/w queue. The driver resolution of all the
> > > hierarchy is not needed at all here if i understood the requirement
> > > above.
> > > You still need to have a classifier in s/w (which could be attached t=
o
> > > clsact egress) to select the queue. That is something the mlnx
> > > implementation allowed. So there is no "double queueing"
> >=20
> > AFAICS the current status of qdisc H/W offload implementation is a bit
> > mixed-up. e.g. HTB requires explicit syntax on the command line to
> > enable H/W offload, TBF doesn't.
> >=20
> > H/W offload enabled on MQPRIO implies skipping the software path, while
> > for HTB and TBF doesn't.
> >=20
> > > If this is about totally bypassing s/w config then its a different ba=
llgame..
> >=20
> > Yes, this does not have s/w counter-part. It limits itself to
> > configure/expose H/W features.
> >=20
>=20
> I think this changes the dynamics altogether. Would IDPF[1] be a fit for =
this?

Thank for the pointer, I admit we did not look closely to that before.

Anyway it looks like quite a different beast: we are looking for way to
configure H/W shaping that could be applied to most/all/as much as
possible existing H/W, while AFAICS the above dictates specification
for 'standard' high-perf netdev H/W. Only matching H/W will be
affected.

> > My take is that configuring the shapers on a queue/device/queue
> > group/vfs group basis, the admin is enforcing shared resources
> > reservation: we don't strictly need a software counter-part.
>=20
> I am assuming then, if the hw allows it one could run offloaded TC/htb
> on the queue/device/queue

HTB is one of the thing we looked at. The existing offload interface
proved not being enough for the use-case at hands.

We could extend it - or others, notably ndo_set_tx_maxrate() would be
simpler to adapt - but one request here is to avoid a delta to H/W
offload dictated by a specific request and covering only/exactly that
specific request that will lead to exactly this same process in some
(little?) time.

The idea is to cover a reasonable large spectrum of the existing
capabilities related to H/W shaping - "once for all" I would say if I
were not sure that such statement will fire back in the most painful
way ;)

Thanks,

Paolo



